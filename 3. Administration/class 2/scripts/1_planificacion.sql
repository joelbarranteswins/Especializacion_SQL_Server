--PLANIFICACION BD

-- CREATE DATABASE ESCUELA
-- ON(
-- NAME='ESCUELA_DATA',
-- FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ESCUELA_DATA.MDF',
-- SIZE=5MB,
-- MAXSIZE=15MB,
-- FILEGROWTH=50%
-- )
-- LOG ON(
-- NAME='ESCUELA_LOG',
-- FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ESCUELA_LOG.LDF',
-- SIZE=5MB,
-- MAXSIZE=15MB,
-- FILEGROWTH=2MB
-- );

-- GO



--EJEMPLO 2 (Crea tu base de datos fisico y logico en tu ruta de preferencia)

CREATE DATABASE BD_TIENDA
ON(
NAME='BD_TIENDA_DATA',
FILENAME='C:\Users\joel_\Documents\GitHub\Especializacion_SQL_Server\3. Administration\class 2\database\BD_TIENDA_DATA.MDF',
SIZE=6MB,
MAXSIZE=25MB,
FILEGROWTH=60%
)
LOG ON(
NAME='BD_TIENDA_LOG',
FILENAME='C:\Users\joel_\Documents\GitHub\Especializacion_SQL_Server\3. Administration\class 2\database\BD_TIENDA_LOG.LDF',
SIZE=6MB,
MAXSIZE=25MB,
FILEGROWTH=4MB
)