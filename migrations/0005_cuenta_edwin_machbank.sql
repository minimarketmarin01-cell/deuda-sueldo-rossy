-- Nueva fuente: cartolas MachBank de Edwin Salazar Requejo, mar-may 2026.
-- El dueño confirma: los INGRESOS a esa cuenta (desde Inversiones Salazar
-- Requejo SpA, y desde transferencias propias de Edwin salvo el primer
-- $5.000 que fue para activar la cuenta) son sueldo de Rossy -- Edwin
-- actua de intermediario/caja.
--
-- Se cuenta SOLO el lado de los ingresos. Los egresos de esa misma cuenta
-- hacia Rossy ($300.789) y hacia su familia Rody/Kely/Durba ($100.191,
-- autorizado por ella) NO se agregan aparte: es la misma plata saliendo
-- de donde ya se conto al entrar -- sumarla tambien duplicaria el monto.

INSERT INTO categories (id, name, status, checked, description, sort_order) VALUES (
  'edwin_machbank',
  'Cuenta MachBank Edwin (ingresos SPA + Edwin)',
  'confirmado',
  1,
  'Cartolas MachBank de Edwin Salazar Requejo, mar-may 2026. Se cuentan los ingresos a esa cuenta desde Inversiones Salazar Requejo SpA y desde transferencias propias de Edwin (excepto el primer $5.000, que fue para activar la cuenta) como sueldo de Rossy -- Edwin actua de intermediario. No se cuentan los egresos de esa misma cuenta (pagos directos a Rossy, a su familia, o gastos de Edwin) para no duplicar: esa plata ya esta contada del lado de los ingresos.',
  10
);

INSERT INTO payments (category_id, fecha, monto, nota) VALUES
  ('edwin_machbank', '2026-03-17', 269500, 'Transferencia de Salazar Requejo Edwin (ingreso)'),
  ('edwin_machbank', '2026-03-18', 70633,  'Transferencia de Salazar Requejo Edwin (ingreso)'),
  ('edwin_machbank', '2026-03-24', 74733,  'Transferencia de Inversiones Salazar Requejo Spa'),
  ('edwin_machbank', '2026-03-30', 269500, 'Transferencia de Inversiones Salazar Requejo Spa'),
  ('edwin_machbank', '2026-03-31', 51800,  'Transferencia de Inversiones Salazar Requejo Spa'),
  ('edwin_machbank', '2026-04-05', 62640,  'Transferencia de Inversiones Salazar Requejo Spa'),
  ('edwin_machbank', '2026-04-07', 44000,  'Transferencia de Inversiones Salazar Requejo Spa'),
  ('edwin_machbank', '2026-04-13', 73830,  'Transferencia de Inversiones Salazar Requejo Spa'),
  ('edwin_machbank', '2026-04-15', 269500, 'Transferencia de Inversiones Salazar Requejo Spa'),
  ('edwin_machbank', '2026-04-21', 74930,  'Transferencia de Inversiones Salazar Requejo Spa'),
  ('edwin_machbank', '2026-04-29', 177000, 'Transferencia de Inversiones Salazar Requejo Spa');
