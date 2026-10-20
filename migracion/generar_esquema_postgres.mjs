// Genera migracion/esquema_postgres.sql desde el esquema real de D1 con el mismo traductor del espejo.
// Uso: node migracion/generar_esquema_postgres.mjs
import fs from "fs";
import { traducirSql } from "../src/pg/traductor.js";
const sentencias = fs.readFileSync("migracion/esquema_d1_real.sql", "utf8").split(/;\s*\n/).map(s => s.trim()).filter(Boolean);
const salida = ["-- Esquema de Deuda sueldo Rossy para Supabase (generado desde D1).", "create schema if not exists deuda_rossy;", "set search_path = deuda_rossy;", ""];
for (const s of sentencias) salida.push(traducirSql(s).text.replace(/^CREATE TABLE /, "CREATE TABLE IF NOT EXISTS ").replace(/^CREATE INDEX /, "CREATE INDEX IF NOT EXISTS ") + ";");
fs.writeFileSync("migracion/esquema_postgres.sql", salida.join("\n") + "\n");
