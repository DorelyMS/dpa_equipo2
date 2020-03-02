# Proyecto Arquitectura de Producto de Datos
Repositorio del equipo 2 del proyecto de la materia Data Product Architecture.

+ Laura Gómez Bustamante 191294 
+ Miguel Ángel Millán Dorado 191401 
+ Elizabeth Rodríguez Sánchez 191430 
+ Marco Julio Monroy Ayala 187825 
+ Rodrigo Suárez Segovia 191351


## Objetivo del proyecto:

Garantizar la eficiencia general de las operaciones aeroportuarias mediante un producto de datos basado en información relacionada con el vuelo (fecha, origen, destino, etc), capaz de predecir si habrá un retraso crítico (mayor a 20 minutos) para el despegue, disminuyendo los costos operativos relacionados al efecto dominó de los retrasos en las salidas de vuelos.

## Problemática a resolver:

El negocio de los aeropuertos incluye muchos procesos, regulaciones y partes interesadas definidas. Que un vuelo despegue a tiempo depende de múltiples factores: como la distancia al suelo, la autorización del control de tráfico aéreo, la reposición de alimentos, el reabastecimiento de combustible así como retrasos de vuelos procedentes de otros lugares. Una demora en cualquiera de estos factores puede llevar a un efecto dominó en las operaciones del aeropuerto. 

Imaginemos cuál sería el impacto en un aeropuerto con alto tráfico como los de Atlanta, Chicago o Beijing. Las cosas se vuelven aún más difíciles en el caso de condiciones climáticas extremas o eventos perturbadores. Con un número cada vez mayor de pasajeros y vuelos, la eficiencia operativa se ha convertido en un gran desafío para los aeropuertos.

Mejorar la eficiencia y el rendimiento general de un aeropuerto se pueden lograr mediante el intercambio de información en tiempo real con todas las partes interesadas. Por tanto, éste producto de datos, representa un diferenciador importante que empodera y da libertad a operadores de servicios aeroportuarios, brindándoles información importante de posibles retrasos, permitiendo tomar decisiones a las partes interesadas del aeropuerto (operadores de aeropuertos, líneas aéreas, operadores de tierra y controladores de tráfico aéreo, etc.) intercambiando información de retrasos, y alentando a la colaboración para una gestión eficiente de las operaciones, buscando disminuir los costos involucrados en dichos retrasos.

Nota: Poner aquí el mockup.

## Recursos

+ Información del Departamento de Transporte de los EUA
+ Servicios de AWS para almacenamiento y procesamiento

## Pipeline
![](Imagenes/Pipeline_Entrega.png)

## Descripción de las variables
La información que será utilizada para el desarrollo de este proyecto en principio es actualizada de forma mensual; sin embargo se desconoce la fecha exacta de actualización. Los datos que están disponibles se encuentran en formato .csv, y contienen las siguientes variables:

||Nombre variable	|Descripción|
|---|---|---|
|1	|report	|Year|
|2	|MONTH	|1-12|
|3	|DAY\_OF\_MONTH	|1-31|
|4	|DAY\_OF_WEEK	|1 (Monday) - 7 (Sunday)|
|5	|DEP_TIME	|Actual departure time (local, hhmm)|
|6	|CRS\_DEP_TIME	|Scheduled departure time (local, hhmm)|
|7	|ARR_TIME	|Actual arrival time (local, hhmm)|
|8	|CRS\_ARR_TIME	|Scheduled arrival time (local, hhmm)|
|9	|OP\_UNIQUE_CARRIER|Unique carrier code|
|10	|OP\_CARRIER\_FL\_NUM	|Flight number|
|11	|TAIL_NUM	|Plane tail number|
|12	|ACTUAL\_ELAPSED_TIME	|Elapsed Time of Flight, in minutes|
|13	|CRS\_ELAPSED_TIME	|CRS Elapsed Time of Flight, in minutes|
|14	|AIR_TIME	|Flight Time, in minutes|
|15	|ARR_DELAY	|Difference in minutes between scheduled and actual arrival time. Early arrivals show negative numbers.|
|16	|DEP_DELAY	|Difference in minutes between scheduled and actual departure time. Early departures set to 0.|
|17	|ORIGIN	|Origin IATA airport code|
|18	|DEST	|Destination IATA airport code|
|19	|DISTANCE	|Distance between airports, in miles|
|20	|TAXI_IN	|Taxi in time, in minutes|
|21	|TAXI_OUT	|Taxi out time in minutes|
|22	|CANCELLED	|Cancelled Flight Indicator (1=Yes)|
|23	|CANCELLATION_CODE	|Reason for cancellation (A = carrier, B = weather, C = NAS, D = security)|
|24	|DIVERTED	|Diverted Flight Indicator, 1 = yes, 0 = no|
|25	|CARRIER_DELAY	|Carrier Delay, in minutes|
|26	|WEATHER_DELAY	|Weather Delay, in minutes|
|27	|NAS_DELAY	|National Air System Delay, in minutes|
|28	|SECURITY_DELAY	|Security Delay, in minutes|
|29	|LATE\_AIRCRAFT_DELAY	|Late Aircraft Delay, in minutes|


## ETL

Como parte del proceso ETL, se tiene considerado utilizar el framework Node.js para descargar la información de la siguiente ubicación https://www.transtats.bts.gov/DL_SelectFields.asp?Table_ID=236. 

Es importante mencionar que en un primer momento deberá obtenerse lo correspondiente al periodo que será utilizado para llevar a cabo el entrenamiento; y posteriormente se realizará una revisión semanal para comprobar si existe información actualizada sobre los vuelos. En caso afirmativo, se descargará la nueva información. El almacenamiento de ambas será realizado en un servicio RDS de AWS.

A través de RDS se utilizará el motor PostgreSQL para crear los esquemas *raw*, *clean* y *semantic*. En el primer esquema se importarán los datos originales y se almacenarán en formato tipo texto. Lo correspondiente a *clean* implicará establecer los tipos de datos adecuados, realizar estandarización de campos que contengan texto, eliminar espacios, entre otras acciones. Así mismo, puede aprovecharse esta parte del proceso para la creación de índices, los cuáles ayudarán a acelerar la consulta entre las tablas del siguiente esquema: *semantic*. Este último está relacionado con la creación de las tablas de entidades y eventos.
![](Imagenes/ETL_Final.png)


## IMPLICACIONES ÉTICAS (Detallar todo)

* Implicaciones de un modelo de predicción sensible:
+ Avisar de un posible retraso propiciando el movimiento de personal, cuando en realidad no existe retraso.
+ Aumento de costos de operación al aeropuerto derivado de posibles alertas de retrasos, cuando estos no ocurrirán.

* Implicaciones de un modelo de predicción preciso:
+ Causar una aglomeración de personas en ciertos horarios por tener vuelos retrasados cuando el modelo predijo que no habrá retraso.
+ No tener disponibles espacios suficientes habilitados para las personas shalalá ..
+ Realizar obras de mantenimiento en zonas con demanda cuando se esperaba que la operación de vuelos no se retrasé afectando a los usuarios de aerolíneas.

Por tanto, se buscará equilibrar el modelo a través de la medida F (media armónica) que da una ponderación ... bla bla bla














