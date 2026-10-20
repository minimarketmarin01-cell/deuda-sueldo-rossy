// Compara D1 con su copia en Supabase (esquema deuda_rossy): cantidad de filas por tabla y la suma de los abonos.
// Una lectura en lote a D1 y una llamada a Supabase; resultado en caché 60 s.
import { crearTransporteSupabase } from "./transporte_supabase.js";

const TABLAS = ["settings", "salary_tramos", "categories", "payments"];
const SUMAS = [["Abonos (suma)", "SELECT COALESCE(SUM(monto),0) AS v FROM payments"], ["Tramos de sueldo (suma)", "SELECT COALESCE(SUM(monto),0) AS v FROM salary_tramos"]];
let _cache = { t: 0, r: null };

export async function compararRossy(env) {
  if (!env.SUPABASE_URL || !env.SUPABASE_SERVICE_KEY) throw new Error("Faltan los secretos SUPABASE_URL y SUPABASE_SERVICE_KEY en el servidor");
  if (_cache.r && Date.now() - _cache.t < 60000) return { ..._cache.r, enCache: true };
  const tx = crearTransporteSupabase({ url: env.SUPABASE_URL, key: env.SUPABASE_SERVICE_KEY, rpc: "ejecutar_sql_rossy" });
  const consultas = [...TABLAS.map(t => "SELECT COUNT(*) AS v FROM " + t), ...SUMAS.map(x => x[1])];
  const d1 = await env.DB.batch(consultas.map(s => env.DB.prepare(s)));
  const sb = await tx.transaccion(consultas.map(s => ({ text: s.replace(/ FROM (\w+)/, " FROM deuda_rossy.$1"), params: [] })));
  const val = r => Number(((r && (r.results || r.rows)) || [])[0]?.v ?? NaN);
  const tablas = TABLAS.map((t, i) => ({ tabla: t, d1: val(d1[i]), supabase: val(sb[i]) })).map(x => ({ ...x, coincide: x.d1 === x.supabase }));
  const control = SUMAS.map((x, k) => { const i = TABLAS.length + k; return { nombre: x[0], d1: val(d1[i]), supabase: val(sb[i]), coincide: val(d1[i]) === val(sb[i]) }; });
  const r = { ok: true, todoCoincide: tablas.every(x => x.coincide) && control.every(x => x.coincide), tablas, control, revisadoEn: new Date().toISOString() };
  _cache = { t: Date.now(), r };
  return r;
}
