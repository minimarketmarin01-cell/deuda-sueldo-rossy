-- Los 36 pagos de $20.000 del 01/07 al 30/08-2026 se habian guardado en
-- "Transferencia dia Marin" (el grupo que quedaba seleccionado por defecto).
-- El dueño confirma que son continuacion del mismo cuaderno diario --
-- siguen exactamente donde termina "Cuaderno cierres abril 2026" (30/06).

UPDATE payments
SET category_id = 'cuaderno_cierres_abril_2026'
WHERE category_id = 'dia' AND monto = 20000 AND fecha >= '2026-07-01';
