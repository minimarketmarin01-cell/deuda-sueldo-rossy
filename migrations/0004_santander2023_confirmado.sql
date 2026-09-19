-- El dueño confirma que las transferencias Santander 2023-2024 SI son
-- sueldo pagado a Rossy (antes marcado como "inferido").

UPDATE categories
SET status = 'confirmado',
    description = 'Transferencias Santander pagadas a Rossy como sueldo, mayo 2023 - septiembre 2024, antes de que se empezara a llevar el registro detallado en la hoja SUELDOS PAGADOS.'
WHERE id = 'santander2023';
