/*Paso 30: Regresar a la tabla original de todo los vuelos de NW*/
DROP TABLE IF EXISTS TRANSFORM.NW28;
CREATE TABLE TRANSFORM.NW28 AS
SELECT t1.*, t2.SUM_EFECTOS_DOMINO, t2.TOT_SUM_DOMINO, t2.COUNT3 AS VUELOS_AFECTADOS
FROM TRANSFORM.NW15 t1
LEFT JOIN TRANSFORM.NW27 t2
ON (t1.FECHA = t2.FECHA AND t1.ID_AVION = t2.ID_AVION AND t1.RANK_CONTADOR = t2.RANK_CONTADOR)
ORDER BY ID_AVION, FECHA, HORASALIDAF;
;
