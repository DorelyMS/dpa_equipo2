/*Paso 3_5: Generar bandera Delay2*/
DROP TABLE IF EXISTS TRANSFORM.NW2_5;
CREATE TABLE TRANSFORM.NW2_5 AS
SELECT * ,
CASE WHEN DELAY < 0 THEN 0 ELSE DELAY 
END AS DELAY2
FROM TRANSFORM.NW2
;


