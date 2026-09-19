-- Cuaderno de pagos diarios en efectivo (fotos), 29-sep-2024 a 31-mar-2026.
-- El dueno confirma: TODOS son sueldo, incluidas las 2 marcadas 'luz'
-- (se le pagaba para que ella cubriera servicios basicos).
-- OJO: el rango abr-2025 a mar-2026 se solapa con la categoria
-- 'Transferencia dia Marin' del Excel original -- posible duplicado, revisar.

INSERT INTO categories (id, name, status, checked, description, sort_order) VALUES (
  'cuaderno_diario',
  'Cuaderno pagos diarios (sep-2024 a mar-2026)',
  'confirmado',
  1,
  'Cuaderno escrito a mano con pagos casi diarios en efectivo, para que Rossy cubriera gastos y servicios basicos. El dueno confirma que todos son sueldo, incluidas 2 entradas marcadas luz. ADVERTENCIA: el rango abr-2025 a mar-2026 se solapa con la categoria Transferencia dia Marin del Excel original -- podria ser la misma plata anotada dos veces, sin confirmar todavia.',
  12
);

INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2024-09-29', 1000, 'Pasaje');
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2024-10-06', 2000, 'Pasaje');
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2024-12-23', 30000, 'Feriado');
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-01-03', 23000, 'Feriado');
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-01-06', 25000, 'Pago');
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-01-22', 5000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-01-24', 25000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-01-25', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-02-01', 25000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-02-10', 25000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-02-17', 15000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-02-22', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-03-01', 10000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-03-02', 11000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-03-04', 15000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-03-05', 25000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-03-06', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-03-15', 25000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-04-14', 6000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-04-18', 10000, 'Transferencia');
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-04-19', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-05-06', 17450, 'Transferencia');
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-05-13', 10000, 'Dia feriado');
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-05-25', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-06-01', 7000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-12-07', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-12-08', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-12-09', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-12-10', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-12-14', 10000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-12-15', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-12-16', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-12-17', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-12-20', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-12-22', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-12-22', 32970, 'Luz (marcado con estrella en el cuaderno)');
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-12-24', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-12-29', 50000, 'Feriado');
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-12-25', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-12-30', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2025-12-31', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-01-02', 18000, 'Feriado');
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-01-06', 35154, 'Luz (marcado con estrella en el cuaderno)');
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-01-14', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-01-16', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-01-17', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-01-20', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-01-27', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-01-28', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-01-29', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-01-30', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-02-02', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-02-03', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-02-04', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-02-05', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-02-06', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-02-08', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-02-09', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-02-12', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-02-13', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-02-14', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-02-15', 2000, 'Escrito "2000" en el cuaderno, verificar si era 20.000');
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-02-16', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-02-18', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-02-20', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-02-21', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-02-22', 20600, 'Escrito "20.600" en el cuaderno');
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-02-24', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-02-23', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-02-26', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-03-01', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-03-02', 20000, 'Transferencia');
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-03-03', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-03-04', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-03-05', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-03-06', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-03-10', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-03-13', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-03-14', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-03-15', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-03-17', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-03-19', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-03-20', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-03-22', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-03-23', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-03-24', 20000, 'Ano escrito "24" en el cuaderno, se asume 2026 por la secuencia');
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-03-27', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-03-28', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-03-29', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-03-30', 20000, NULL);
INSERT INTO payments (category_id, fecha, monto, nota) VALUES ('cuaderno_diario', '2026-03-31', 20000, NULL);
