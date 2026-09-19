-- Nueva exportacion BancoEstado (01/02/2026 a 30/06/2026) trae 3
-- transferencias "sueldo rossy" que faltaban, dentro del rango
-- $200.000-$280.000 (misma regla del dueño).

INSERT INTO payments (category_id, fecha, monto, nota) VALUES
  ('sueldo_rossy_bancoestado', '2026-05-01', 251533, 'Op. 7090035, destino "sueldo rossy" - "fin de mes abril descontando un dia"'),
  ('sueldo_rossy_bancoestado', '2026-05-17', 269500, 'Op. 7026301, destino "sueldo rossy"'),
  ('sueldo_rossy_bancoestado', '2026-05-31', 269500, 'Op. 7081167, destino "sueldo rossy"');
