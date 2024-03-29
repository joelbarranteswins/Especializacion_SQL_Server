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

--CREA TABLAS EN LOS SCHEMAS
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


CREATE TABLE PRESUPUESTO.PRES(
CODPRE INT PRIMARY KEY,
DESPRE VARCHAR(30),
COSPRE MONEY
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
