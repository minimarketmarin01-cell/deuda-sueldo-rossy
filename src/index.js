const json = (data, init) =>
  new Response(JSON.stringify(data), {
    ...init,
    headers: { "content-type": "application/json;charset=UTF-8", ...(init && init.headers) },
  });

const badRequest = (msg) => json({ error: msg }, { status: 400 });
const notFound = () => json({ error: "No encontrado" }, { status: 404 });

const DATE_RE = /^\d{4}-\d{2}-\d{2}$/;

function slugify(name) {
  return name
    .normalize("NFD")
    .replace(/[̀-ͯ]/g, "")
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "_")
    .replace(/^_+|_+$/g, "")
    .slice(0, 40) || "grupo";
}

async function getState(db) {
  const [settingsRes, tramosRes, categoriesRes, paymentsRes] = await Promise.all([
    db.prepare("SELECT key, value FROM settings").all(),
    db.prepare("SELECT id, label, from_date, to_date, monto, fuente FROM salary_tramos ORDER BY sort_order").all(),
    db.prepare("SELECT id, name, status, checked, description FROM categories ORDER BY sort_order").all(),
    db.prepare("SELECT id, category_id, fecha, monto, nota FROM payments ORDER BY fecha").all(),
  ]);

  const settings = {};
  for (const row of settingsRes.results) settings[row.key] = row.value;

  const subtotals = {};
  for (const p of paymentsRes.results) {
    subtotals[p.category_id] = (subtotals[p.category_id] || 0) + p.monto;
  }

  const categories = categoriesRes.results.map((c) => ({
    ...c,
    checked: !!c.checked,
    subtotal: subtotals[c.id] || 0,
  }));

  return {
    settings,
    tramos: tramosRes.results,
    categories,
    payments: paymentsRes.results,
  };
}

export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    const { pathname } = url;
    const db = env.DB;

    if (!pathname.startsWith("/api/")) {
      return env.ASSETS.fetch(request);
    }

    try {
      // GET /api/state
      if (pathname === "/api/state" && request.method === "GET") {
        return json(await getState(db));
      }

      // PUT /api/settings  { fecha_inicio }
      if (pathname === "/api/settings" && request.method === "PUT") {
        const body = await request.json();
        if (!DATE_RE.test(body.fecha_inicio || "")) return badRequest("fecha_inicio invalida");
        await db
          .prepare("INSERT INTO settings (key, value) VALUES ('fecha_inicio', ?1) ON CONFLICT(key) DO UPDATE SET value=?1")
          .bind(body.fecha_inicio)
          .run();
        return json({ ok: true });
      }

      // PUT /api/tramos/:id  { monto }
      let m = pathname.match(/^\/api\/tramos\/(\d+)$/);
      if (m && request.method === "PUT") {
        const id = Number(m[1]);
        const body = await request.json();
        const monto = Number(body.monto);
        if (!Number.isFinite(monto) || monto < 0) return badRequest("monto invalido");
        const res = await db.prepare("UPDATE salary_tramos SET monto = ?1 WHERE id = ?2").bind(monto, id).run();
        if (res.meta.changes === 0) return notFound();
        return json({ ok: true });
      }

      // PUT /api/categories/:id  { checked }
      m = pathname.match(/^\/api\/categories\/([a-zA-Z0-9_-]+)$/);
      if (m && request.method === "PUT") {
        const id = m[1];
        const body = await request.json();
        const checked = body.checked ? 1 : 0;
        const res = await db.prepare("UPDATE categories SET checked = ?1 WHERE id = ?2").bind(checked, id).run();
        if (res.meta.changes === 0) return notFound();
        return json({ ok: true });
      }

      // POST /api/categories  { name, description }
      if (pathname === "/api/categories" && request.method === "POST") {
        const body = await request.json();
        const name = (body.name || "").trim();
        if (!name) return badRequest("nombre requerido");

        let id = slugify(name);
        const exists = await db.prepare("SELECT id FROM categories WHERE id = ?1").bind(id).first();
        if (exists) id = id + "_" + Date.now().toString(36);

        const maxOrder = await db.prepare("SELECT COALESCE(MAX(sort_order), 0) AS m FROM categories").first();
        const sortOrder = (maxOrder ? maxOrder.m : 0) + 1;

        await db
          .prepare(
            "INSERT INTO categories (id, name, status, checked, description, sort_order) VALUES (?1, ?2, 'confirmado', 1, ?3, ?4)"
          )
          .bind(id, name, body.description || "Grupo agregado desde la app.", sortOrder)
          .run();

        return json({ ok: true, id, name }, { status: 201 });
      }

      // POST /api/payments  { category_id, fecha, monto, nota }
      if (pathname === "/api/payments" && request.method === "POST") {
        const body = await request.json();
        const { category_id, fecha, nota } = body;
        const monto = Number(body.monto);
        if (!category_id) return badRequest("category_id requerido");
        if (!DATE_RE.test(fecha || "")) return badRequest("fecha invalida (usa YYYY-MM-DD)");
        if (!Number.isFinite(monto) || monto <= 0) return badRequest("monto invalido");

        const cat = await db.prepare("SELECT id FROM categories WHERE id = ?1").bind(category_id).first();
        if (!cat) return badRequest("categoria desconocida");

        const res = await db
          .prepare("INSERT INTO payments (category_id, fecha, monto, nota) VALUES (?1, ?2, ?3, ?4)")
          .bind(category_id, fecha, monto, nota || null)
          .run();
        return json({ ok: true, id: res.meta.last_row_id }, { status: 201 });
      }

      // DELETE /api/payments/:id
      m = pathname.match(/^\/api\/payments\/(\d+)$/);
      if (m && request.method === "DELETE") {
        const id = Number(m[1]);
        const res = await db.prepare("DELETE FROM payments WHERE id = ?1").bind(id).run();
        if (res.meta.changes === 0) return notFound();
        return json({ ok: true });
      }

      return notFound();
    } catch (err) {
      return json({ error: String((err && err.message) || err) }, { status: 500 });
    }
  },
};
