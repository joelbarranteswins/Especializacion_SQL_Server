
/* Trigger = Disparador = Desencadenador */
--la idea es que dispare y no que piense en su proceso

SELECT * FROM Employees;

EXEC sp_help();

--creando una tabla de auditoria de empleados
USE [Northwind]

CREATE TABLE [dbo].[Employees_Audi_2](
	tipoOD char(3),
	usuario VARCHAR(50) DEFAULT SUSER_SNAME(),
    fecha DATETIME DEFAULT GETDATE(),
    equipo VARCHAR(50) DEFAULT HOST_NAME(),
	[EmployeeID] [int],
	[LastName] [nvarchar](20),
	[FirstName] [nvarchar](10),
	[Title] [nvarchar](30),
	[TitleOfCourtesy] [nvarchar](25) NULL,
	[BirthDate] [datetime] NULL,
	[HireDate] [datetime] NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[HomePhone] [nvarchar](24) NULL,
	[Extension] [nvarchar](4) NULL,
	[Photo] [image] NULL,
	[Notes] [ntext] NULL,
	[ReportsTo] [int] NULL,
	[PhotoPath] [nvarchar](255) NULL)
GO

-----------------------------------------------------------------------------
--crear un trigger que se active al ingresar datos a la tabla empleado
CREATE TRIGGER tg_Emp_insert_2 on Employees
FOR INSERT
AS 
BEGIN
    INSERT INTO Employees_Audi_2(
        tipoOD, EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, 
		BirthDate, HireDate, Address, City, Region, 
        PostalCode, Country, HomePhone, Extension, ReportsTo, PhotoPath)
    SELECT  'INS', EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, 
        HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, 
        ReportsTo, PhotoPath FROM inserted
END
GO

--ejecutando el trigger
INSERT INTO Employees_Audi_2(LastName, FirstName, Title, BirthDate, HireDate, City, Country)
VALUES('Ramos', 'Daniel', 'Instructor', '1972-01-01', '2012-01-01', 'Santiago', 'Chile')

select * from Employees;
SELECT * FROM Employees_Audi;


-------------------------------------------------------------------------------------------------
--modificando datos
CREATE TRIGGER tg_Emp_update on Employees
FOR UPDATE
AS 
BEGIN
    INSERT INTO Employees_Audi_2(
        tipoOD, EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, 
		BirthDate, HireDate, Address, City, Region, 
        PostalCode, Country, HomePhone, Extension, ReportsTo, PhotoPath)
    SELECT  'UPD', EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, 
        HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, 
        ReportsTo, PhotoPath FROM deleted
END
GO

--ejecutando el trigger
UPDATE Employees SET LastName = 'Ramos Castañeda' WHERE EmployeeID = 27;

SELECT * FROM Employees;
SELECT * FROM Employees_Audi_2;


-------------------------------------------------------------------------------------------------
--crear trigger para la eliminacion de datos
CREATE TRIGGER tg_Emp_delete on Employees
FOR DELETE
AS
BEGIN
    INSERT INTO Employees_Audi_2(
        tipoOD, EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, 
        BirthDate, HireDate, Address, City, Region, 
        PostalCode, Country, HomePhone, Extension, ReportsTo, PhotoPath)
    SELECT  'DEL', EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, 
        HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, 
        ReportsTo, PhotoPath FROM deleted
END
GO

--ejecutando el trigger
DELETE FROM Employees WHERE EmployeeID = 27;


SELECT * FROM Employees;
SELECT * FROM Employees_Audi_2;

--------------------------------------------------------------------------------------
/* CASO 2 */

CREATE TABLE bco_Cuenta(
nroCta uniqueidentifier default newid() primary key,
nomCli varchar (50) not null,
fechaCta datetime default getdate(),
lineaAprob money default 0,
lineaDispo money default 0 check (lineaDispo>=0))
GO

CREATE TABLE bco_Movi (
nroOpe bigint identity (1001,1) primary key,
nroCta uniqueidentifier references bco_Cuenta,
fechaOpe datetime default getdate(),
debe money default 0,
haber money default 0)
GO

--PROBANDO SIN TRIGGERS
INSERT INTO bco_Cuenta(nomCli,lineaAprob) 
VALUES ('Joseth Saravia',5500)

--CREANDO LOS TRIGGERS
CREATE TRIGGER tg_CtaNueva ON bco_Cuenta
FOR INSERT AS
BEGIN
INSERT INTO bco_Movi(nroCta,haber)
SELECT nroCta,lineaAprob FROM inserted
END
GO

--PERO TAMBIEN
CREATE TRIGGER tg_MoviNuevo ON bco_Movi
FOR INSERT AS
BEGIN
	DECLARE @cta uniqueidentifier, @debe money, @haber money
	SELECT @cta=nroCta,@debe=debe,@haber=haber FROM inserted
	UPDATE bco_Cuenta SET lineaDispo=lineaDispo+@haber-@debe
	WHERE nroCta=@cta
END
GO
--PROBANDO CON DISPARADORES
INSERT INTO bco_Cuenta(nomCli,lineaAprob) 
VALUES ('Joseth QUIÑONES',7500)

--COMPRA
INSERT INTO bco_Movi(nroCta,debe)
VALUES ('BD2320B8-DFE4-431D-985F-151FFA96D112',1000)

INSERT INTO bco_Movi(nroCta,debe)
VALUES ('BD2320B8-DFE4-431D-985F-151FFA96D112',1000)

--PAGO
INSERT INTO bco_Movi(nroCta,haber) 
VALUES ('BD2320B8-DFE4-431D-985F-151FFA96D112',1500)
SELECT * FROM bco_Cuenta
SELECT * FROM bco_Movi