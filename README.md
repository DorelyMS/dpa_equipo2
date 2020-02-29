# Proyecto Equipo 2 Arquitectura de producto de datos
Repositorio del equipo 2 del proyecto de la materia Data Product Architecture.

+ Laura Gómez Bustamante 191294 
+ Miguel Ángel Millán Dorado 191401 
+  Elizabeth Rodríguez Sánchez 191430 
+ Marco Julio Monroy Ayala 187825 
+ Rodrigo Suárez Segovia 191351


## Objetivo del proyecto:

Desarrollar un producto de datos que con base en información relacionada con el vuelo (fecha, origen, destino,etc) sea capaz de predecir si la salida de éste tendrá un retraso crítico (mayor a 20 minutos).

## Problemátiva a resolver:

Los aeropuertos del mundo, sobre todo los más grandes y que mayor tráfico aéreo registran, van 
incorporando poco a poco servicios exclusivos para amenizar al cliente. Convertirse en el mejor 
operador de servicios aeroportuarios requiere de ofrecer servicios con seguridad, eficiencia 
tecnológica y confort de manera sostenible y rentable. Derivado de esto, resulta importante contar con servicios que permitan empoderar y darle libertad a compañías áreas en la experiencia de viaje, brindándole información importante en el momento adecuado para tomar decisiones hacia sus clientes.

## Metas y objetivos específicos:

Para el caso de los vuelos cuya salida sí se retrase, determinar rangos de retraso en minutos, es decir, retraso entre 30 y 60 minutos, retraso entre 60 y 120 minutos, etc.

## Recursos

+ Información del Departamento de Transporte de los EUA
+ API de Google Maps
+ Servicios de AWS para almacenamiento y procesamiento

## Pipeline
![](Imagenes/Pipeline_Entrega.png)

## ETL

La información que será utilizada para el desarrollo de este proyecto en principio es actualizada de forma mensual; sin embargo se desconoce la fecha exacta de actualización. Los datos que están disponibles se encuentran en formato .csv.

Como parte del proceso ETL, se tiene considerado utilizar el framework Node.js para descargar la información de la siguiente ubicación https://www.transtats.bts.gov/DL_SelectFields.asp?Table_ID=236. Es importante mencionar que en un primer momento deberá obtenerse lo correspondiente al periodo que será utilizado para llevar a cabo el entrenamiento; y posteriormente se realizará una revisión semanal para comprobar si existe información actualizada sobre los vuelos. En caso afirmativo, se descargará la nueva información. El almacenamiento de ambas será realizado en un servicio RDS de AWS.

A través de RDS se utilizará el motor PostgreSQL para crear los esquemas *raw*, *clean* y *semantic*. En el primer esquema se importarán los datos originales y se almacenarán en formato tipo texto. Lo correspondiente a *clean* implicará establecer los tipos de datos adecuados, realizar estandarización de campos que contengan texto, eliminar espacios, entre otras acciones. Así mismo, puede aprovecharse esta parte del proceso para la creación de índices, los cuáles ayudarán a acelerar la consulta entre las tablas del siguiente esquema: *semantic*. Este último está relacionado con la creación de las tablas de entidades y eventos.
![](Imagenes/ETL_Final.png)

