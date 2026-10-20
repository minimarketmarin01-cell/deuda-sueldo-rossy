// Prueba del espejo de Deuda Rossy: D1 (SQLite local) y Supabase (Postgres local) parten iguales; se usa la API normal
// y al final ambas bases deben coincidir, ids incluidos. Uso: NODE_PATH=<carpeta con pg> PGHOST=... node migracion/probar_espejo.mjs
import http from "http";
import fs from "fs";
import assert from "assert";
import { createRequire } from "module";
import { DatabaseSync } from "node:sqlite";
import worker from "../src/index.js";
import { normalizarNumerados } from "../src/pg/espejo.js";
const { Client } = createRequire(import.meta.url)("pg");

const sq = new DatabaseSync(":memory:"); sq.exec(fs.readFileSync("migracion/esquema_d1_real.sql", "utf8"));
const semilla = `INSERT INTO settings VALUES ('fecha_inicio','2024-01-01');
 INSERT INTO salary_tramos VALUES (1,'2024','2024-01-01','2024-12-31',500000,'ley',1),(2,'2025','2025-01-01','2025-12-31',529000,'ley',2);
 INSERT INTO categories VALUES ('transfer','Transferencias','confirmado',1,'x',1),('efectivo','Efectivo','inferido',0,'y',2);
 INSERT INTO payments(category_id,fecha,monto,nota) VALUES ('transfer','2024-02-01',100000,'a'),('efectivo','2024-03-01',50000,NULL);`;
sq.exec(semilla);
const mk = (sql, p = []) => ({ bind: (...a) => mk(sql, a), all: async () => ({ results: sq.prepare(sql).all(...p), meta: { changes: 0 } }),
  first: async (c) => { const r = sq.prepare(sql).get(...p) || null; return c && r ? r[c] : r; },
  run: async () => { if (/^\s*SELECT/i.test(sql)) return { results: sq.prepare(sql).all(...p), meta: { changes: 0 } }; const r = sq.prepare(sql).run(...p); return { results: [], meta: { changes: Number(r.changes), last_row_id: Number(r.lastInsertRowid) } }; } });
const DB = { prepare: s => mk(s), batch: async l => { const o = []; for (const s of l) o.push(await s.all()); return o; } };

const c = new Client(); await c.connect();
await c.query("drop schema if exists deuda_rossy cascade");
await c.query(fs.readFileSync("migracion/esquema_postgres.sql", "utf8"));
for (const f of ["funcion_ejecutar_sql.sql", "funcion_ejecutar_sql_espejo.sql"]) await c.query(fs.readFileSync("migracion/" + f, "utf8").replace(/revoke all[^;]*;|grant execute[^;]*;/g, ""));
await c.query("set search_path = deuda_rossy; " + semilla.replace("INSERT INTO payments(", "INSERT INTO payments(").replace(/;\s*$/, "") + "; select setval(pg_get_serial_sequence('deuda_rossy.payments','id'), 2)");
const srv = http.createServer(async (req, res) => {
  let body = ""; for await (const ch of req) body += ch;
  const fn = req.url.split("/rpc/")[1];
  try { const r = await c.query("select public." + fn + "($1::jsonb) as r", [JSON.stringify(JSON.parse(body).sentencias)]); res.writeHead(200); res.end(JSON.stringify(r.rows[0].r)); }
  catch (e) { res.writeHead(400); res.end(JSON.stringify({ message: e.message })); }
}).listen(0);
const env = { DB, ASSETS: { fetch: () => new Response("") }, SUPABASE_URL: "http://127.0.0.1:" + srv.address().port, SUPABASE_SERVICE_KEY: "k" };
const pendientes = []; const ctx = { waitUntil: p => { pendientes.push(Promise.resolve(p).catch(() => {})); } };
const esperar = async () => { while (pendientes.length) await pendientes.shift(); };
let n = 0; const ok = m => console.log("ok", ++n, m);
const api = async (metodo, ruta, body) => { const r = await worker.fetch(new Request("https://x" + ruta, { method: metodo, body: body ? JSON.stringify(body) : undefined }), env, ctx); return { status: r.status, j: await r.json() }; };

const nn = normalizarNumerados("INSERT INTO settings (key, value) VALUES ('a?1', ?1) ON CONFLICT(key) DO UPDATE SET value=?1", ["X"]);
assert.strictEqual(nn.sql, "INSERT INTO settings (key, value) VALUES ('a?1', ?) ON CONFLICT(key) DO UPDATE SET value=?"); assert.deepStrictEqual(nn.params, ["X", "X"]);
ok("parámetros numerados (?1 repetido) se pasan a ? en orden, sin tocar los textos");

const pasos = [["PUT", "/api/settings", { fecha_inicio: "2024-02-01" }], ["PUT", "/api/tramos/2", { monto: 530000 }], ["PUT", "/api/categories/efectivo", { checked: true }],
  ["POST", "/api/categories", { name: "Cuentas pagadas 'luz'", description: "agua y luz" }], ["POST", "/api/payments", { category_id: "transfer", fecha: "2026-10-01", monto: 80000, nota: "abono 'oct'" }],
  ["POST", "/api/payments", { category_id: "efectivo", fecha: "2026-10-05", monto: 20000 }], ["DELETE", "/api/payments/1"]];
for (const [m, r, b] of pasos) { const x = await api(m, r, b); assert(x.status < 300, m + " " + r + ": " + JSON.stringify(x.j)); }
await esperar(); ok("7 cambios con la app normal (ajustes, tramo, grupo nuevo, 2 abonos, eliminar abono)");
for (const [t, orden] of [["settings", "key"], ["salary_tramos", "id"], ["categories", "id"], ["payments", "id"]]) {
  const a = sq.prepare("select * from " + t + " order by " + orden).all().map(r => { delete r.created_at; return JSON.stringify(Object.values(r).map(v => v === null ? null : String(v))); });
  const b = (await c.query("select * from deuda_rossy." + t + " order by " + orden)).rows.map(r => { delete r.created_at; return JSON.stringify(Object.values(r).map(v => v === null ? null : String(v))); });
  assert.deepStrictEqual(b, a, t);
}
ok("Supabase quedó igual a D1 en las 4 tablas, ids de abonos incluidos");
const cmp = await api("GET", "/api/espejo_comparar");
assert(cmp.j.ok && cmp.j.todoCoincide, JSON.stringify(cmp.j)); ok("/api/espejo_comparar: todo coincide");
const st = await api("GET", "/api/state", null, { ...env, SUPABASE_URL: undefined });
assert(st.j.payments.length === 3); ok("la app sigue leyendo de D1 (" + st.j.payments.length + " abonos)");
console.log("\nTodas las pruebas pasaron:", n); srv.close(); await c.end(); process.exit(0);
