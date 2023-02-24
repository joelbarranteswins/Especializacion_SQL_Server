
select @@VERSION

SELECT SERVERPROPERTY('PRODUCTVERSION'),SERVERPROPERTY('PRODUCTLEVEL'),
SERVERPROPERTY('EDITION')

--PLANIFICACION BD

GO

CREATE DATABASE ESCUELA
ON(
NAME='ESCUELA_DATA',
FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ESCUELA_DATA.MDF',
SIZE=5MB,
MAXSIZE=15MB,
FILEGROWTH=50%
)
LOG ON(
NAME='ESCUELA_LOG',
FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ESCUELA_LOG.LDF',
SIZE=5MB,
MAXSIZE=15MB,
FILEGROWTH=2MB
);

GO
--EJEMPLO 2

CREATE DATABASE BD_TIENDA
ON(
NAME='BD_TIENDA_DATA',
FILENAME='D:\SEMANA1\BD_TIENDA_DATA.MDF',
SIZE=6MB,
MAXSIZE=25MB,
FILEGROWTH=60%
)
LOG ON(
NAME='BD_TIENDA_LOG',
FILENAME='D:\SEMANA1\BD_TIENDA_LOG.LDF',
SIZE=6MB,
MAXSIZE=25MB,
FILEGROWTH=4MB
)
/*
*/

--CREAR FILEGROUPS

--AGREGAR FILEGROUPS A LA BD
ALTER DATABASE [BD_TIENDA] ADD FILEGROUP DATA_1
GO
ALTER DATABASE  [BD_TIENDA] ADD FILEGROUP DATA_2

USE MASTER
USE ESCUELA
USE BD_TIENDA
SELECT * FROM sys.filegroups

--AGREGAR ARCHIVOS SECUNDARIOS A LOS FILEGROUPS

ALTER DATABASE [BD_TIENDA]
ADD FILE(
NAME=DATA1,
FILENAME='D:\SEMANA1\DATA1.NDF',
SIZE= 1MB,
MAXSIZE=10MB,
FILEGROWTH=2MB
)TO FILEGROUP DATA_1

GO
ALTER DATABASE [BD_TIENDA]
ADD FILE(
NAME=DATA2,
FILENAME='D:\SEMANA1\DATA2.NDF',
SIZE=1MB,
MAXSIZE=10MB,
FILEGROWTH=2MB
)TO FILEGROUP DATA_2
GO

--USO DE LA BD ESCUELA


USE ESCUELA
GO
CREATE SCHEMA DEPARTAMENTOS
GO
CREATE SCHEMA JORNADA
GO
CREATE SCHEMA TRABAJADORES
GO
CREATE SCHEMA OBRA
GO
CREATE SCHEMA PRESUPUESTO
GO

--CONS. SCHEMAS
SELECT * FROM sys.schemas
GO

CREATE TABLE DEPARTAMENTOS.DEPAS(
CODDEP  INT PRIMARY KEY,
NOMDEP VARCHAR(20)
)
GO
CREATE TABLE JORNADA.JOR(
CODJOR INT PRIMARY KEY,
DESJOR VARCHAR(40),
COSJOR MONEY
)
GO
CREATE TABLE TRABAJADORES.TRAB(
CODTRA INT PRIMARY KEY,
NOMTRA VARCHAR(30),
APETRA VARCHAR(30),
CODJOR INT FOREIGN KEY(CODJOR) REFERENCES JORNADA.JOR,
CODDEP INT FOREIGN KEY(CODDEP) REFERENCES DEPARTAMENTOS.DEPAS
)
GO
CREATE TABLE OBRA.OBR(
CODOBR INT PRIMARY KEY,
FINOBR DATE,
RESOBR VARCHAR(20),
NOMOBR VARCHAR(30) UNIQUE,
FFIOBR DATE,
CODTRA INT FOREIGN KEY(CODTRA) REFERENCES TRABAJADORES.TRAB,
CODPRE INT FOREIGN KEY(CODPRE) REFERENCES PRESUPUESTO.PRES
)

GO 
CREATE TABLE PRESUPUESTO.PRES(
CODPRE INT PRIMARY KEY,
DESPRE VARCHAR(30),
COSPRE MONEY
)

GO
USE master

SELECT * FROM sys.sysdatabases

SELECT * FROM sys.filegroups

SP_HELPDB [BD_TIENDA]