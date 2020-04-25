
/* EDA */
/* Union de los cuatro anios */
DATA WORK.UNION_ALL (drop=F16);
	SET Rodrigo.All_2016 Rodrigo.All_2017 Rodrigo.All_2018;
RUN;
/*Cambio de Tipo de Dato*/
DATA WORK.ALL_HEAD (DROP= YEAR MONTH DAY_OF_MONTH DAY_OF_WEEK OP_UNIQUE_CARRIER TAIL_NUM
	OP_CARRIER_FL_NUM ORIGIN DEST CRS_DEP_TIME DEP_TIME DEP_DELAY_NEW CRS_ARR_TIME
	CRS_ELAPSED_TIME DISTANCE);
	SET WORK.UNION_ALL;
	FORMAT YEAR_ $20.;
	FORMAT MES $20.;
	FORMAT DIA_MES $20.;
	FORMAT DIA_SEMANA $20.;
	FORMAT ID_OPERADOR $20.;
	FORMAT ID_AVION $20.;
	FORMAT NUM_VUELO $20.;
	FORMAT DESTINO $20.;
	FORMAT ORIGEN $20.;
	FORMAT HORA_SALIDA $20.;
	FORMAT SALIDA_REAL $20.;
	FORMAT DELAY 20.;
	FORMAT HORA_LLEGADA_PROG $20.;
	FORMAT TIEMPO_TRANS_VUELO 20.;
	FORMAT DISTANCIA_MILLAS 20.;
	YEAR_ = COMPRESS(YEAR);
	MES = COMPRESS(MONTH);
	DIA_MES = COMPRESS(DAY_OF_MONTH);
	DIA_SEMANA = COMPRESS(DAY_OF_WEEK);
	ID_OPERADOR = OP_UNIQUE_CARRIER;
    ID_AVION = TAIL_NUM;
    NUM_VUELO = OP_CARRIER_FL_NUM;
    ORIGEN = ORIGIN;
    DESTINO = DEST;
    HORA_SALIDA = CRS_DEP_TIME;
    SALIDA_REAL = DEP_TIME;
    DELAY = DEP_DELAY_NEW;
    HORA_LLEGADA_PROG = CRS_ARR_TIME;
    TIEMPO_TRANS_VUELO = CRS_ELAPSED_TIME;
    DISTANCIA_MILLAS = DISTANCE;
RUN;

DATA WORK.ALL_HEAD2 (DROP= YEAR MONTH DAY_OF_MONTH DAY_OF_WEEK OP_UNIQUE_CARRIER TAIL_NUM
	OP_CARRIER_FL_NUM ORIGIN DEST CRS_DEP_TIME DEP_TIME DEP_DELAY_NEW CRS_ARR_TIME
	CRS_ELAPSED_TIME DISTANCE F16);
	SET Rodrigo.ALL_2019;
	FORMAT YEAR_ $20.;
	FORMAT MES $20.;
	FORMAT DIA_MES $20.;
	FORMAT DIA_SEMANA $20.;
	FORMAT ID_OPERADOR $20.;
	FORMAT ID_AVION $20.;
	FORMAT NUM_VUELO $20.;
	FORMAT DESTINO $20.;
	FORMAT ORIGEN $20.;
	FORMAT HORA_SALIDA $20.;
	FORMAT SALIDA_REAL $20.;
	FORMAT DELAY 20.;
	FORMAT HORA_LLEGADA_PROG $20.;
	FORMAT TIEMPO_TRANS_VUELO 20.;
	FORMAT DISTANCIA_MILLAS 20.;
	YEAR_ = COMPRESS(YEAR);
	MES = COMPRESS(MONTH);
	DIA_MES = COMPRESS(DAY_OF_MONTH);
	DIA_SEMANA = COMPRESS(DAY_OF_WEEK);
	ID_OPERADOR = OP_UNIQUE_CARRIER;
    ID_AVION = TAIL_NUM;
    NUM_VUELO = COMPRESS(OP_CARRIER_FL_NUM);
    ORIGEN = ORIGIN;
    DESTINO = DEST;
    HORA_SALIDA = COMPRESS(CRS_DEP_TIME);
    SALIDA_REAL = COMPRESS(DEP_TIME);
    DELAY = DEP_DELAY_NEW;
    HORA_LLEGADA_PROG = COMPRESS(CRS_ARR_TIME);
    TIEMPO_TRANS_VUELO = CRS_ELAPSED_TIME;
    DISTANCIA_MILLAS = DISTANCE;
RUN;
DATA Rodrigo.UNION_ALL2 ;
	SET WORK.ALL_HEAD WORK.ALL_HEAD2 ;
RUN;
/*Eliminar cuando Id_Operador = OP_UNIQUE_CARRIER */
PROC SQL;
	CREATE TABLE WORK.TIME1 AS
	SELECT t1.*
	FROM Rodrigo.UNION_ALL2 t1
	WHERE t1.ID_OPERADOR NOT = "OP_UNIQUE_CARRIER";
QUIT;
/*Trabajar con las horas para hacer el analisis del Delay*/
DATA WORK.TIME2 (DROP= hh mm);
SET WORK.TIME1;
hh = input(substr(HORA_SALIDA,1,2),2.);
mm = input(substr(HORA_SALIDA,3,2),2.);
HORASALIDAF = hms(hh,mm,0);
FORMAT HORASALIDAF time15.;
RUN;
DATA WORK.TIME3 (DROP= hh mm);
SET WORK.TIME2;
hh = input(substr(SALIDA_REAL,1,2),2.);
mm = input(substr(SALIDA_REAL,3,2),2.);
SALIDA_REALF = hms(hh,mm,0);
FORMAT SALIDA_REALF time15.;
RUN;
DATA WORK.TIME4 (DROP= hh mm);
SET WORK.TIME3;
hh = input(substr(HORA_LLEGADA_PROG,1,2),2.);
mm = input(substr(HORA_LLEGADA_PROG,3,2),2.);
HORA_LLEGADA_PROGF = hms(hh,mm,0);
FORMAT HORA_LLEGADA_PROGF time15.;
RUN;
/*Categorizar los delay > a X tiempo*/
DATA WORK.BANDERAS (DROP = HORA_SALIDA SALIDA_REAL HORA_LLEGADA_PROG);
	SET WORK.TIME4;
	FORMAT BANDERA_DELAY $20.;
	IF DELAY <= 0 THEN BANDERA_DELAY = "A:SIN RETRASO";
	ELSE IF DELAY > 0 AND DELAY <= 10 THEN BANDERA_DELAY = "B:RETRASO_MENOR10";
	ELSE IF DELAY > 10 AND DELAY <= 20 THEN BANDERA_DELAY = "C:RETRASO_MENOR20";
	ELSE IF DELAY > 20 AND DELAY <= 30 THEN BANDERA_DELAY = "D:RETRASO_MENOR30";
	ELSE IF DELAY > 30 AND DELAY <= 40 THEN BANDERA_DELAY = "E:RETRASO_MENOR40";
	ELSE IF DELAY > 40 AND DELAY <= 50 THEN BANDERA_DELAY = "F:RETRASO_MENOR50";
	ELSE IF DELAY > 50 AND DELAY <= 60 THEN BANDERA_DELAY = "G:RETRASO_MENOR60";
	ELSE BANDERA_DELAY = "H:RETRASO_MAYOR60";
RUN;
/*Formato de Fechas*/
DATA WORK.FECHA;
SET WORK.BANDERAS;
FORMAT DAY $2.;
FORMAT MONTH $2.;
FORMAT DAY_SEM $11.;
IF DIA_MES = 1 OR DIA_MES = 2 OR DIA_MES = 3 OR DIA_MES = 4 OR DIA_MES = 5 OR DIA_MES = 6
	OR DIA_MES = 7 OR DIA_MES = 8 OR DIA_MES = 9 THEN DAY = cats(0,DIA_MES); ELSE DAY = DIA_MES;
IF MES = 1 OR MES = 2 OR MES = 3 OR MES = 4 OR MES = 5 OR MES = 6
	OR MES = 7 OR MES = 8 OR MES = 9 THEN MONTH = cats(0,MES); ELSE MONTH = MES;
IF DIA_SEMANA = 1 THEN DAY_SEM = "A:LUNES";
ELSE IF DIA_SEMANA = 2 THEN DAY_SEM = "B:MARTES";
ELSE IF DIA_SEMANA = 3 THEN DAY_SEM = "C:MIERCOLES";
ELSE IF DIA_SEMANA = 4 THEN DAY_SEM = "D:JUEVES";
ELSE IF DIA_SEMANA = 5 THEN DAY_SEM = "E:VIERNES";
ELSE IF DIA_SEMANA = 6 THEN DAY_SEM = "F:SABADO";
ELSE IF DIA_SEMANA = 7 THEN DAY_SEM = "G:DOMINGO";
ELSE DAY_SEM = DIA_SEMANA;
FECHA_VUELO = cats(DAY,MONTH,YEAR_);
FECHA = input(FECHA_VUELO, ddmmyy10.);
FORMAT FECHA date9.;
RUN;
/*Filtro de WN - Limpieza de Variables*/
PROC SQL;
	CREATE TABLE Rodrigo.NW AS
	SELECT t1.FECHA, t1.DAY_SEM, t1.ID_OPERADOR, t1.ID_AVION, t1.NUM_VUELO, t1.ORIGEN,
           t1.DESTINO, t1.HORASALIDAF, t1.SALIDA_REALF, t1.TIEMPO_TRANS_VUELO,
		   t1.DISTANCIA_MILLAS, t1.HORA_LLEGADA_PROGF, t1.DELAY, t1.BANDERA_DELAY
      FROM WORK.FECHA t1
WHERE t1.ID_OPERADOR = "WN";
QUIT;
/*Eliminar valores missings de ID_AVION*/
PROC SQL;
	CREATE TABLE WORK.NW2 AS
	SELECT t1.*
	FROM Rodrigo.NW t1
	WHERE ID_AVION NOT IS MISSING
	AND t1.SALIDA_REALF NOT IS MISSING;
	/*ORDER BY t1.ID_AVION, t1.HORASALIDAF*/;
QUIT;
/*Ordenar esta tabla por Id_avion, Hora de salidaF y Fecha */
PROC SQL;
	CREATE TABLE WORK.NW3 AS
	SELECT t1.*
	FROM WORK.NW2 t1
	GROUP BY t1.FECHA
	ORDER BY t1.ID_AVION, t1.FECHA, t1.HORASALIDAF;
RUN;
/*Generar un contador por ID_vuelo y Fecha*/
DATA WORK.NW4;
	SET WORK.NW3;
	COUNT + 1;
	BY ID_AVION FECHA;
	IF FIRST.ID_AVION OR FIRST.FECHA THEN COUNT = 1;
RUN;
/*Tomar el maximo de por ID_AVION Y FECHA*/
PROC SQL;
   CREATE TABLE WORK.MAX_NW AS
   SELECT (MAX(t1.COUNT)) AS MAX,
          t1.ID_AVION, t1.FECHA
   FROM WORK.NW4 t1
   GROUP BY t1.ID_AVION, t1.FECHA;
QUIT;
/*Pegar la tabla de M�ximos a la tabla NW4 creando NW5*/
PROC SQL;
	CREATE TABLE WORK.NW5 AS
	SELECT t1.*, t2.MAX
	FROM WORK.NW4 t1
	INNER JOIN WORK.MAX_NW t2
	ON (t1.ID_AVION = t2.ID_AVION AND t1.FECHA = t2.FECHA)
	ORDER BY t1.ID_AVION, t1.FECHA, t1.HORASALIDAF;
QUIT;
/*Hacer la resta para obtener el # de vuelos faltantes en el dia para el mismo avion*/
PROC SQL;
	CREATE TABLE Rodrigo.NW6 AS
	SELECT t1.*, SUM(t1.MAX, -t1.COUNT) AS NVUE_FALT
	FROM WORK.NW5 t1;
QUIT;

/*-----------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------*/
/*Efecto domino*/

/*Generar bandera fuelos afectados*/
PROC SQL;
	CREATE TABLE WORK.NW7 AS
	SELECT t1.*, CASE WHEN t1.BANDERA_DELAY = "A:SIN RETRASO" THEN 0 ELSE 1 END
	AS IND_RETRASO1
	FROM Rodrigo.NW6 t1;
QUIT;
DATA WORK.NW8;
	SET WORK.NW7;
	IND_RETRASO2 = LAG(IND_RETRASO1);
RUN;
DATA WORK.NW9;
	SET WORK.NW8;
	BY ID_AVION FECHA;
	IF FIRST.ID_AVION OR FIRST.FECHA THEN IND_RETRASO3 = . ;
	ELSE IND_RETRASO3 = IND_RETRASO2;
RUN;
/*Borrar el IND_RETRASO2 y crear domin� igualando IND1 vs IND3*/
PROC SQL;
	CREATE TABLE Rodrigo.NW10 AS
	SELECT t1.*, CASE WHEN t1.IND_RETRASO1 = t1.IND_RETRASO3 AND t1.IND_RETRASO1 = 1
	THEN "DOMINO" ELSE "SIN EFECTO" END AS EFECTO
	FROM WORK.NW9 t1;
QUIT;
/*________________________________________________________________________________________*/
/*Filtrar (la tabla queda de  2'454,328) donde Ind_Retraso1 = 1
(para quedarme con todos los vuelos retrasados).*/
PROC SQL;
	CREATE TABLE WORK.NW11 AS
	SELECT t1.*
	FROM Rodrigo.NW10 t1
	WHERE t1.IND_RETRASO1 = 1;
QUIT;
/*Se genera un lag con la columna efecto*/
DATA WORK.NW12;
	SET WORK.NW11;
	EFECTO2 = LAG(EFECTO);
RUN;
/*Paso adicional que podemos omitir */
/*  DATA WORK.NW13; */
/*	SET WORK.NW12;*/
/*	BY ID_AVION FECHA;*/
/*	IF FIRST.ID_AVION OR FIRST.FECHA THEN IND_EFECTO = "NO_CONSIDERAR"; */
/*	ELSE IND_EFECTO = EFECTO2;*/
/*RUN;*/
/*Hacer la pregunta de Cuantos retrasos le ocurren al dia al avion que genera efecto domino*/
PROC SQL;
	CREATE TABLE WORK.NW13 AS
	SELECT t1.*, CASE WHEN t1.EFECTO = "DOMINO" AND t1.EFECTO2 = "SIN EFECTO"
	THEN 1 ELSE 0 END AS EFECTOS_DOMINO
	FROM WORK.NW12 t1;
QUIT;
/*Se suma la variable EFECTOS_DOMINO y se agrupa por Id_avion y fecha*/
PROC SQL;
	CREATE TABLE WORK.NW_SUMA_EFECTOS AS
    SELECT t1.FECHA, t1.ID_AVION, (SUM(t1.EFECTOS_DOMINO)) AS SUM_EFECTOS_DOMINO
    FROM WORK.NW13 t1
    GROUP BY t1.FECHA, t1.ID_AVION;
QUIT;
/*Regresar esta tabla Rodrigo.NW10*//*Es un error, se debe regresar a la tabla de NW11
/* ------------------------------------------------------------------------------------------*/
PROC SQL;
	CREATE TABLE WORK.NW14 AS
	SELECT t1.*,t2.SUM_EFECTOS_DOMINO
	FROM WORK.NW11 t1
	LEFT JOIN WORK.NW_SUMA_EFECTOS t2
	ON (t1.FECHA = t2.FECHA AND t1.ID_AVION = t2.ID_AVION)
	ORDER BY t1.ID_AVION, t1.FECHA, t1.HORASALIDAF;
QUIT;
/*Eliminar cuando ocurren dobles o triples efectos domino*/
PROC SQL;
	CREATE TABLE WORK.NW15 AS
	SELECT t1.*
	FROM WORK.NW14 t1
	WHERE t1.SUM_EFECTOS_DOMINO <= 1
	ORDER BY t1.ID_AVION, t1.FECHA, t1.HORASALIDAF;
QUIT;
/*Hacer las condicionales para el calculo de la suma de vuelos afectados*/
/*Hacer la SUMA de SUM_EFECTOS_DOMINO*/
PROC SQL;
   CREATE TABLE WORK.NW16 AS
   SELECT t1.*,
   		  CASE WHEN t1.SUM_EFECTOS_DOMINO = 0 THEN 0
		  ELSE (SUM(t1.SUM_EFECTOS_DOMINO)-1) END AS TOT_SUM_DOMINO
   FROM WORK.NW15 t1
   GROUP BY t1.ID_AVION,
               t1.FECHA;
QUIT;
/*Intentar el Count inverso*//*La tabla Rodrigo.NW16 se queda como informativa,
la cual tiene aquellos dias en donde se dan 2 o hasta 3 efectos domino no consecutivos*/
DATA Rodrigo.NW17;
	SET WORK.NW16;
	COUNT2 + (-1);
	BY ID_AVION FECHA;
	IF FIRST.ID_AVION OR FIRST.FECHA THEN COUNT2 = TOT_SUM_DOMINO;
RUN;
/*Ahora acotar a Count2 para hacerlo 0 en caso de que obtengamos valores negativos*/
PROC SQL;
	CREATE TABLE WORK.NW18 AS
	SELECT t1.*, CASE WHEN t1.COUNT2 < 0 THEN 0 ELSE COUNT2 END AS COUNT3
	FROM Rodrigo.NW17 t1;
QUIT;

/*Regresar a la tabla original de Rodrigo.NW10*/
PROC SQL;
	CREATE TABLE WORK.NW19 AS
	SELECT t1.*, t2.SUM_EFECTOS_DOMINO, t2.TOT_SUM_DOMINO, t2.COUNT3 AS VUELOS_AFECTADOS
	FROM Rodrigo.NW10 t1
	LEFT JOIN WORK.NW18 t2
	ON (t1.FECHA = t2.FECHA AND t1.ID_AVION = t2.ID_AVION AND t1.COUNT = t2.COUNT)
	ORDER BY t1.ID_AVION, t1.FECHA, t1.HORASALIDAF;
QUIT;
/*Generacion de etiquetas*/
PROC SQL;
	CREATE TABLE WORK.ETIQUETAS AS
	SELECT t1.*, YEAR(t1.fecha) AS YEAR,
	CASE WHEN t1.DELAY >= 20 AND t1.VUELOS_AFECTADOS >= 2 THEN 1 ELSE 0 END AS ETIQUETA1,
	CASE WHEN t1.DELAY >= 20 AND t1.VUELOS_AFECTADOS >= 1 THEN 1 ELSE 0 END AS ETIQUETA2,
	CASE WHEN t1.DELAY >= 10 AND t1.VUELOS_AFECTADOS >= 2 THEN 1 ELSE 0 END AS ETIQUETA3,
	CASE WHEN t1.DELAY >= 10 AND t1.VUELOS_AFECTADOS >= 1 THEN 1 ELSE 0 END AS ETIQUETA4
	FROM WORK.NW19 t1;
QUIT;
