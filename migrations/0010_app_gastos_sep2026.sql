-- Nueva fuente: categoria "SUELDO DEUDA" de la app de gastos del dueño,
-- septiembre 2026. Continua el mismo patron de $20.000 casi diarios que
-- el cuaderno manuscrito (que corta en 31-mar-2026) -- probablemente el
-- mismo habito, ahora registrado en la app en vez de a mano.

INSERT INTO categories (id, name, status, checked, description, sort_order) VALUES (
  'app_gastos_sep2026',
  'App de gastos - Sueldo deuda (sep 2026)',
  'confirmado',
  1,
  'Categoria "SUELDO DEUDA" de la app de gastos del dueño, $20.000 casi diarios. Continua el mismo patron que el cuaderno manuscrito (que llegaba solo hasta marzo 2026).',
  13
);

INSERT INTO payments (category_id, fecha, monto, nota) VALUES
  ('app_gastos_sep2026', '2026-09-01', 20000, 'Rossy Sueldo'),
  ('app_gastos_sep2026', '2026-09-02', 20000, 'Rossy Sueldo'),
  ('app_gastos_sep2026', '2026-09-03', 20000, 'Rossy sueldo'),
  ('app_gastos_sep2026', '2026-09-04', 20000, 'Rossy Sueldo'),
  ('app_gastos_sep2026', '2026-09-06', 20000, 'Rossy'),
  ('app_gastos_sep2026', '2026-09-13', 20000, 'Rossy'),
  ('app_gastos_sep2026', '2026-09-17', 20000, 'Rossy sueldo');
