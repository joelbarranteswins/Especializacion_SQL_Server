
## Descripción de la Edición de SQL Server

Existe muchas maneras de ver la version del SQL server:
1. Ingresando al log (los registros de SQL server) el cual se encuentra en el siguiente paths.
    ~~~shell
    > C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Log
    ~~~
    luego abrir el archivo ERRORLOG, los cuales son los registros de errores de sql.

2. haciendo click derecho en el nombre de la base de datos e ingresando en properties:

<div align="center">
<img src="./imgs/properties-database.png">
</div>

3. Puedes realizar una consulta en SQL

~~~sql
-- visualizar la version
select @@VERSION

-- visualizar la version, producto y edición
SELECT SERVERPROPERTY('PRODUCTVERSION'),SERVERPROPERTY('PRODUCTLEVEL'),
SERVERPROPERTY('EDITION')
~~~

## Bases de Datos por Defecto


En SQL Server, existen cuatro bases de datos principales, cada una con un propósito específico:

1. **La base de datos "master":** Es la base de datos principal de SQL Server y contiene información sobre todas las demás bases de datos del servidor, incluyendo información de inicio de sesión y permisos. Además, también contiene información sobre la configuración del servidor, como los parámetros de configuración y los objetos del sistema.

2. **La base de datos "model":** Esta base de datos se utiliza como plantilla para crear nuevas bases de datos en el servidor. Cuando se crea una nueva base de datos, se utiliza la información de la base de datos "model" como punto de partida.

3. *La base de datos "tempdb":* Es una base de datos temporal que se utiliza para almacenar datos temporales y objetos de trabajo para las operaciones de SQL Server. Esto incluye tablas temporales, variables de tabla, variables de tabla de usuario, cursores y otros objetos temporales.

4. *La base de datos "msdb":* Contiene información y objetos que se utilizan para programar y administrar tareas del sistema, como la copia de seguridad y restauración de bases de datos, la programación de trabajos de SQL Server Agent y la administración de alertas.

### En resumen:
* "master": es la base de datos principal del servidor y contiene información sobre todas las demás bases de datos y configuración del servidor.
* "model": se utiliza como plantilla para crear nuevas bases de datos, 
* "tempdb": se utiliza para almacenar objetos temporales 
* "msdb": se utiliza para administrar tareas del sistema y programación de trabajos.

## Planificación de la Base de Datos

~~~sql
-- se debe tener en cuenta que los path del filename para el MDF y el LDF es referencial y puede cambiar segun la version que se disponga.

CREATE DATABASE ESCUELA
ON(
NAME='ESCUELA_DATA',
FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ESCUELA_DATA.MDF',
SIZE=5MB,
MAXSIZE=15MB,
FILEGROWTH=50%
)
LOG ON(
NAME='ESCUELA_LOG',
FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ESCUELA_LOG.LDF',
SIZE=5MB,
MAXSIZE=15MB,
FILEGROWTH=2MB
);

GO
~~~

Puede que te genere un error como este:

~~~shell
Directory lookup for the file "C:\Users\joel_\Documents\GitHub\Especializacion_SQL_Server\3. Administration\class 2\database\BD_TIENDA_DATA.MDF" failed with the operating system error 5(Acceso denegado.).
~~~
el cual no es otra cosa mas que el sql server no tiene los permisos para hacer CRUD en una carpeta,


### Los archivos .MDF y .LDF 

* **El archivo .MDF (Master Data File)** es el archivo principal de la base de datos que contiene los datos y los objetos de la base de datos, como tablas, índices, procedimientos almacenados, entre otros.

* **El archivo .LDF (Log Data File)** es el archivo de registro de transacciones que se utiliza para registrar todas las transacciones realizadas en la base de datos. Esto incluye todas las inserciones, actualizaciones y eliminaciones de datos.

### Consideraciones:
El archivo de registro de transacciones es crítico para la integridad de los datos de la base de datos, ya que se utiliza para recuperar la base de datos en caso de fallo del sistema o de una falla en la unidad de almacenamiento.

Es importante tener en cuenta que, al igual que con el archivo .MDF, el archivo .LDF también es esencial para la integridad de la base de datos. Por lo tanto, es importante realizar copias de seguridad regulares tanto del archivo .MDF como del archivo .LDF para asegurarse de que los datos estén protegidos en caso de fallas del sistema o pérdida de datos.