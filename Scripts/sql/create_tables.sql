/***********************************************************************************/
/**************************** Preparacion de las tablas ****************************/
/***********************************************************************************/


/**************************** Titulo ejecuciones ****************************/
drop table if exists linaje.ejecuciones;
create table linaje.ejecuciones (
  "id_ejec" NUMERIC,
  "usuario_ejec" VARCHAR(20),
  "instancia_ejec" VARCHAR(20),
  "fecha_hora_ejec" TIMESTAMP,
  "bucket_s3" VARCHAR(40),
  "tag_script" VARCHAR(20),
  "tipo_ejec" VARCHAR(5),
  "url_webscrapping" VARCHAR(100),
  "status_ejec" VARCHAR(5)
);
comment on table linaje.ejecuciones is 'describe los datos principales de las ejecuciones';


/**************************** Titulo archivos ****************************/
drop table if exists linaje.archivos;
create table linaje.archivos (
  "id_ejec" NUMERIC,
  "id_archivo" VARCHAR(40),
  "num_registros" VARCHAR(20),
  "num_columnas" VARCHAR(10),
  "tamanio_archivo" FLOAT,
  "anio" VARCHAR(5),
  "mes" VARCHAR(10),
  "ruta_almac_s3" VARCHAR(100)
);
comment on table linaje.archivos is 'describe caracteristicas especificas de archivos';


/**************************** Titulo archivos_det ****************************/
drop table if exists linaje.archivos_det;
create table linaje.archivos_det (
  "id_archivo" VARCHAR(40),
  "nombre_col" VARCHAR(35)
);
comment on table linaje.archivos_det is 'describe detalles del archivo';


/**************************** Raw vuelos ****************************/
drop table if exists raw.vuelos;
create table raw.vuelos(
  "YEAR" VARCHAR(50),
  "MONTH" VARCHAR(50),
  "DAY_OF_MONTH" VARCHAR(50),
  "DAY_OF_WEEK" VARCHAR(50),
  "OP_UNIQUE_CARRIER" VARCHAR(50),
  "TAIL_NUM" VARCHAR(50),
  "OP_CARRIER_FL_NUM" VARCHAR(50),
  "ORIGIN" VARCHAR(50),
  "DEST" VARCHAR(50),
  "CRS_DEP_TIME" VARCHAR(50),
  "DEP_TIME" VARCHAR(50),
  "DEP_DELAY" VARCHAR(50),
  "CRS_ARR_TIME" VARCHAR(50),
  "CRS_ELAPSED_TIME" VARCHAR(50),
  "DISTANCE" VARCHAR(50)
);
comment on table linaje.archivos_det is 'detalles por vuelo';
