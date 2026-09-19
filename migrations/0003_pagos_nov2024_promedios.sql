-- Redefine categoria 'pagos': solo desde noviembre 2024, celdas vacias de
-- luz/agua rellenadas con el promedio de esa columna (calculado con los
-- valores reales de la tabla PAGOS, hoja SUELDOS ANTERIORES, Nov-2024 a Feb-2026).
-- Promedio luz: 53704 (8 meses con dato real)
-- Promedio agua: 42031 (9 meses con dato real)

DELETE FROM payments WHERE category_id = 'pagos';

INSERT INTO payments (category_id, fecha, monto, nota) VALUES
  ('pagos', '2024-11-19', 95735, 'Luz (promedio) 53.704 + agua (promedio) 42.031 -- celda vacia en el Excel'),
  ('pagos', '2024-12-19', 95735, 'Luz (promedio) 53.704 + agua (promedio) 42.031 -- celda vacia en el Excel'),
  ('pagos', '2025-01-20', 95735, 'Luz (promedio) 53.704 + agua (promedio) 42.031 -- celda vacia en el Excel'),
  ('pagos', '2025-02-20', 95735, 'Luz (promedio) 53.704 + agua (promedio) 42.031 -- celda vacia en el Excel'),
  ('pagos', '2025-03-20', 45210,  'Luz 22.605 + agua 22.605'),
  ('pagos', '2025-04-20', 95735, 'Luz (promedio) 53.704 + agua (promedio) 42.031 -- celda vacia en el Excel'),
  ('pagos', '2025-05-20', 297604, 'Luz 23.064 + agua 25.540 + otros pagos 220.000 + transf. Santander 29.000'),
  ('pagos', '2025-06-20', 71097,  'Luz 44.337 + agua 26.760'),
  ('pagos', '2025-07-24', 167967, 'Luz 82.157 + agua 51.810 + otros pagos 34.000'),
  ('pagos', '2025-08-20', 132809, 'Luz 94.809 + agua 38.000'),
  ('pagos', '2025-09-20', 97455,  'Luz 27.245 + agua 70.210'),
  ('pagos', '2025-10-20', 140704, 'Luz (promedio) 53.704 + agua 87.000'),
  ('pagos', '2025-11-20', 104473, 'Luz 81.093 + agua 23.380'),
  ('pagos', '2025-12-20', 87289,  'Luz 54.319 + agua 32.970'),
  ('pagos', '2026-01-21', 95735, 'Luz (promedio) 53.704 + agua (promedio) 42.031 -- celda vacia en el Excel'),
  ('pagos', '2026-02-21', 95735, 'Luz (promedio) 53.704 + agua (promedio) 42.031 -- celda vacia en el Excel');

UPDATE categories
SET description = 'Tabla PAGOS de la hoja SUELDOS ANTERIORES, solo desde noviembre 2024. Celdas de luz/agua vacias en el Excel se rellenaron con el promedio de esa columna (luz $53.704, agua $42.031, calculados con los meses que si tienen dato). Se asume que estas cuentas se pagaron a nombre de Rossy como parte de su sueldo.'
WHERE id = 'pagos';
