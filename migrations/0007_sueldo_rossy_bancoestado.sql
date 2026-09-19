-- Nueva fuente: reporte oficial BancoEstado de transferencias enviadas
-- desde la cuenta "Chequera Electronica" de INVERSIONES SALAZAR REQUEJO
-- SPA hacia la cuenta BCI de Rossy Rojas Requejo (RUT 28.074.612-6).
-- El propio reporte filtra por destino "sueldo rossy" -- la fuente mas
-- confiable vista hasta ahora.
--
-- El dueño precisa: de las 22 transferencias (jun-sep 2026), solo cuentan
-- como sueldo las de $200.000 a $280.000 (7 transferencias). Quedan fuera
-- $325.533, $150.000 y todas las menores a $200.000.

INSERT INTO categories (id, name, status, checked, description, sort_order) VALUES (
  'sueldo_rossy_bancoestado',
  'Sueldo Rossy - BancoEstado (Inversiones SpA)',
  'confirmado',
  1,
  'Reporte oficial BancoEstado de transferencias enviadas desde la cuenta de Inversiones Salazar Requejo SpA a la cuenta BCI de Rossy Rojas Requejo, filtrado por el propio banco como destino "sueldo rossy". El dueño precisa que solo cuentan como sueldo las transferencias de $200.000 a $280.000 (jun-sep 2026); se excluyen montos fuera de ese rango.',
  11
);

INSERT INTO payments (category_id, fecha, monto, nota) VALUES
  ('sueldo_rossy_bancoestado', '2026-06-15', 269500, 'Op. 7048555, destino "sueldo rossy"'),
  ('sueldo_rossy_bancoestado', '2026-06-30', 276777, 'Op. 7044057, destino "sueldo rossy"'),
  ('sueldo_rossy_bancoestado', '2026-07-16', 276777, 'Op. 7085699, destino "sueldo rossy"'),
  ('sueldo_rossy_bancoestado', '2026-08-01', 276776, 'Op. 7047972, destino "sueldo rossy"'),
  ('sueldo_rossy_bancoestado', '2026-08-16', 276777, 'Op. 7097486, destino "sueldo rossy"'),
  ('sueldo_rossy_bancoestado', '2026-08-30', 276776, 'Op. 7070819, destino "sueldo rossy"'),
  ('sueldo_rossy_bancoestado', '2026-09-16', 276778, 'Op. 7079199, destino "sueldo rossy"');
