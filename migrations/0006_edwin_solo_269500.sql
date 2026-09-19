-- El dueño precisa: de la cuenta MachBank de Edwin, el sueldo real son
-- solo los movimientos de $269.500 (17/03, 30/03, 15/04-2026). El resto
-- de los ingresos que se habian agregado en 0005 no son sueldo.

DELETE FROM payments
WHERE category_id = 'edwin_machbank'
  AND monto != 269500;

UPDATE categories
SET description = 'Cartolas MachBank de Edwin Salazar Requejo. El dueño confirma que el sueldo de Rossy en esa cuenta corresponde solo a los pagos de $269.500 (17/03, 30/03 y 15/04-2026). El resto de los ingresos a esa cuenta (SPA y transferencias de Edwin) no son sueldo.'
WHERE id = 'edwin_machbank';
