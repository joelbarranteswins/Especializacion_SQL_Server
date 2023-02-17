USE UNI00;

--validanto
SELECT db_name();

--listando las tablas
SELECT * FROM sys.tables;

--listar los esquemas
SELECT * FROM sys.schemas;

--luego (prueba de consulta)
SELECT s.name AS Esquema, t.name AS Tabla, t.create_date, t.object_id, t.lock_escalation_desc
FROM sys.schemas AS S
join sys.tables AS T ON s.schema_id = t.schema_id;

--como crear una esquema
CREATE SCHEMA Ventas;

CREATE SCHEMA Produccion;

--creando una tabla dentro de otro esquema
CREATE TABLE ventas.boleta (
nroBoleta INT PRIMARY KEY,
fecEmision DATE DEFAULT GETDATE(),
total MONEY DEFAULT 0);

CREATE TABLE Produccion.producto (
codProd INT IDENTITY(1001,1) PRIMARY KEY,
nombre VARCHAR(80) NOT NULL,
nomLocal NVARCHAR(80),
precio MONEY DEFAULT 0 CHECK(precio>=0),
stock INT DEFAULT 0 CHECK(stock>=0));

--probando
INSERT INTO Produccion.producto(nombre, nomLocal)
VALUES ('causa rellena', 'cauda rellena');

--mal ingresado (no recibe nuevos caracteres si no especificamosuna N antes del valor)
INSERT INTO Produccion.producto(nombre, nomLocal)
VALUES ('caviar', 'слово')

--corregido, usar N antes del valor para que permita ingresar
INSERT INTO Produccion.producto(nombre, nomLocal)
VALUES ('caviar', N'слово')

INSERT INTO Produccion.producto(NOMBRE,nomLocal)
VALUES ('Humus - garbanzo', N'слово');


--creando tipo de datos, luego usarlos
CREATE TYPE correo FROM VARCHAR(80);
CREATE TYPE nombre FROM VARCHAR(40);
CREATE TYPE apellido FROM VARCHAR(30);

--luego
CREATE TABLE ventas.vendedor(
codVen INT IDENTITY PRIMARY KEY,
nomVen nombre,
apPaterno apellido,
apMaterno apellido,
fecNaci date,
dni char(8) not null unique,
sueldo MONEY DEFAULT 0);

--modificando la table 
ALTER TABLE ventas.vendedor
ADD email correo;

--borra una table
ALTER TABLE ventas.vendedor
DROP COLUMN email;

--modificar dato o nombre de una columna
ALTER TABLE ventas.vendedor
ALTER COLUMN sueldo money;

ALTER TABLE [ventas].[vendedor] 
DROP CONSTRAINT [DF__vendedor__sueldo__6754599E];

ALTER TABLE [ventas].[vendedor] 
ADD CONSTRAINT [DF_sueldo] default 930 for sueldo;

SELECT * FROM Ventas.vendedor;

--see columns data type
exec sp_help 'Ventas.vendedor'


/*manejo de indices*/
--creando una table sin indeces
CREATE TABLE Prueba1(
codigo CHAR(3),
nombre VARCHAR(50));

CREATE TABLE Prueba2(
codigo CHAR(3) primary key,
nombre VARCHAR(50));

--insertando datos
INSERT INTO Prueba1 values
('L01', 'Lima Cercado'),
('L27','San Isidro'),
('L18','Miraflores'),
('L02', 'Ancon'),
('L25','Rimac'),
('L36','SJL'),
('L03','Ate');

INSERT INTO Prueba2 values
('L01', 'Lima Cercado'),
('L27','San Isidro'),
('L18','Miraflores'),
('L02', 'Ancon'),
('L25','Rimac'),
('L36','SJL'),
('L03','Ate');

CREATE TABLE Prueba3(
codigo CHAR(3) primary key,
nombre VARCHAR(50));

INSERT INTO Prueba3 values
('L01', 'Lima Cercado'),
('L27','San Isidro'),
('L18','Miraflores'),
('L02', 'Ancon'),
('L25','Rimac'),
('L36','SJL'),
('L03','Ate');


--luego
SELECT * FROM Prueba1;

SELECT * FROM Prueba2;

SELECT * FROM Prueba3;


--ordenar por codigo
SELECT * FROM Prueba1 ORDER BY codigo;
SELECT * FROM Prueba2 ORDER BY codigo;
SELECT * FROM Prueba3 ORDER BY codigo;
SELECT * FROM Prueba4 ORDER BY codigo;

SELECT * FROM Prueba1 order by nombre;
 

SELECT * FROM Prueba1 order by codigo desc;
SELECT * FROM Prueba2 order by codigo desc;

SELECT * FROM Prueba1 order by nombre desc;
SELECT * FROM Prueba2 order by nombre desc;


exec sp_helpindex prueba1;
exec sp_helpindex prueba2;
exec sp_helpindex prueba3;

--creando table con 2 indices
CREATE TABLE Prueba4(
codigo CHAR(3) primary key nonclustered,
nombre VARCHAR(50) unique nonclustered);

INSERT INTO Prueba4 values
('L01', 'Lima Cercado'),
('L27','San Isidro'),
('L18','Miraflores'),
('L02', 'Ancon'),
('L25','Rimac'),
('L36','SJL'),
('L03','Ate');

SELECT * FROM Prueba4;

exec sp_helpindex prueba4;

--creando otra table
CREATE TABLE prueba5 (
codigo INT IDENTITY(1011,1) PRIMARY KEY,
apPaterno apellido NOT NULL,
apmaterno apellido,
nombres nombre NOT NULL,
dni CHAR(8) NOT NULL UNIQUE,
fecnaci DATE,
direccion VARCHAR(120),
codPostal CHAR(3) REFERENCES distrito, --clave foranea
email correo NOT NULL UNIQUE,
fecIngreso DATE,
cargo VARCHAR(40),
sueldo MONEY)

SELECT * FROM prueba5; 

--ingresando datos
INSERT INTO prueba5 
VALUES ('Ramos','Castañeda','Daniel Alexis', '09080706',
'1972-01-18','su casa','L01','daniel.ramos.c@sistemasuni.edu.pe',
'1999-10-25','instructor', 999)

INSERT INTO prueba5 
VALUES ('Barrantes','Palacios','Joel Angel', '74843978',
'1995-01-18','SJM','L01','joelbarrantespalacios@gmail.com',
'2021-10-01','Ing. Minas', 2000)

insert prueba5 values
('Mena','Santos','Alvaro Mena','76187930','1994-07-16','mi casa','L01',
'amenas94@gmail.com','2015-07-11','alumno',930);
insert Prueba5 values('Chuquipul','Vidal','Divash Agustín','74811523',
'1996-11-21','AV. Manuel Gonzales Prada','L01',
'dchuquipul@gmail.com','2021-12-12','Pasante',930) ;
insert Prueba5 values('Saravia','Quiñones','Joseth','76548731','1998-10-25',
'Mi casa',null,
'josethsaravia13@gmail.com','2021-12-12','Estudiante',930);
insert prueba5 values('Flores','Yanqui','Rosmery Nelly','45782308','1989-05-18',
'mi casa',
'L02','rosmery.nefy@gmail.com','1999-10-25','instructor',1200);
insert prueba5 values('Rodas','Arrieta','Jose','74968285','1998-05-28','su casa',
'L01','jose.rodas98@gmail.com','2021-10-25','estudiante',999)
insert prueba5 values('Moran','Vilela','Victor Hugo','70086493','1994-09-25',
'calle lima',null, 'moran1201124@gmail.com','1999-10-25','Alumno',950) ;
insert prueba5 values('Calixto','Aguilar','Steven','73682586','2000-01-21',
'su casa','L02',
'scalixtoa@uni.pe','1999-10-25','Alumno',999) ;
insert prueba5 values('Barrientos','Sarmiento','Jordan David','46846617',
'1991-05-15','Lima','L01',
'jd.barrientos@outlook.com','2010-10-25','instructor',1000) ;
insert prueba5 values('Remuzgo','Artezano','Evelin Mirtha','76761375','1997-07-06',
'Av. Víctor Malasquez','L01',
'2017025794@unfv.edu.pe','2017-04-10','estudiante',800)
insert prueba5 values('Cotrina','Salas','Jacqueline','76295064','1995-06-03','SJM','L01',
'jaqui.cotrina@gmail.com','1999-10-25','estudiante',995) ;
insert prueba 5 values('Calderon','Calero','Daniel Ronal','70207314','1995-03-26',
'Asoc. Isabel de Huaraz, Puente Piedra','L01',
'danielronal22@gmail.com','2015-03-25','alumno',1200);
insert prueba5 values('Salvador','Pacheco','Luis Eduardo','76423089','1994-11-12',
'av. mi casa',null,
'lsalveco12@gmail.com','2021-12-25','coordinador',999) ;
insert prueba5 values('Mendoza','Rondan','Jose Manuel','75001726','1999-07-23',
'Laura Caller','L01',
'mendozaj.2399@gmail.com','2021-12-12','Estudiante',2000);
insert Prueba5 values ('Paco', 'Huaman', 'Juan Carlos', '47730342', '1992-05-21', 
'Bellavista', null, 'juan.paco.hu@gmail.com', '2021-11-11', 'alumno', 1300);

SELECT * FROM Prueba5;
SELECT * FROM prueba5 ORDER BY apPaterno;

SELECT * FROM prueba5 WHERE apPaterno LIKE 'ramos';
SELECT * FROM prueba5 WHERE apMaterno LIKE 'castañeda';

SELECT * FROM prueba5 ORDER BY apPaterno;
SELECT * FROM prueba5 ORDER BY apPaterno;

SELECT apPaterno, apMaterno, nombres from Prueba5 WHERE apPaterno LIKE 'ramos'
SELECT apPaterno, apMaterno, nombres from Prueba5 WHERE apMaterno LIKE 'castañeda'

--cuantos indices tenemos???
exec sp_helpindex prueba5;

--creando un nuevo indice
CREATE INDEX idxPaterno on prueba5(apPaterno)

CREATE INDEX idxPaterno2 on prueba5(apPaterno, nombres)

CREATE INDEX idxPaterno3 on prueba5(apPaterno) include(apMaterno, nombres, dni) --filtro con indice

SELECT * FROM idxPaterno3;


/* 
Recuperando datos
*/
USE Northwind;

SELECT DB_NAME();

--listar las tablas existentes
SELECT * FROM sys.tables;

-- recuperar las columnas con sus tipos de dato
exec sp_help Customers;

--sin utilizar comodin
SELECT CustomerID, CompanyName, ContactName,ContactTitle,
Address,City,Region,PostalCode,Country,Phone, Fax
FROM Customers;

SELECT CustomerID, CompanyName, Address, City, Country
FROM Customers;

SELECT CompanyName,  City, Country, CustomerID
FROM Customers;

--ordenando los datos
SELECT CompanyName,  City, Country, CustomerID
FROM Customers
ORDER BY Country;

SELECT CompanyName,  City, Country, CustomerID
FROM Customers
ORDER BY Country DESC;

SELECT CompanyName,  City, Country, CustomerID
FROM Customers
ORDER BY Country, City;

SELECT CompanyName,  City, Country, CustomerID
FROM Customers
ORDER BY Country desc, City;

SELECT CompanyName,  City, Country, CustomerID
FROM Customers
ORDER BY Country desc, City desc;

--filtros
SELECT  CustomerID, CompanyName, Country, City, Address
FROM Customers
WHERE Country='uk';

SELECT  CustomerID, CompanyName, Country, City, Address
FROM Customers
WHERE Country='uk' OR Country='france';

SELECT  CustomerID, CompanyName, Country, City, Address
FROM Customers
WHERE Country='uk' AND City='london';


SELECT  CustomerID, CompanyName, Country City, Address
FROM Customers
WHERE Country IN ('uk','france','germany','italy','denmark');

SELECT  CustomerID, CompanyName, Country City, Address
FROM Customers
WHERE Country NOT IN ('uk','france','germany','italy','denmark');

SELECT * FROM Products WHERE UnitPrice>40;

SELECT * FROM Products WHERE UnitPrice>=40;

SELECT * FROM Products WHERE UnitPrice>40 AND UnitPrice<80;

SELECT * FROM Products WHERE UnitPrice BETWEEN 40 AND 80;

SELECT * FROM Products WHERE UnitPrice NOT BETWEEN 40 AND 80;

--Listar todos los clientes que tienen numero de fax
SELECT  CustomerID, CompanyName, Country City, Address
FROM Customers
WHERE fax IS NOT NULL;

SELECT  CustomerID, CompanyName, Country City, Address
FROM Customers
WHERE fax IS NULL;

--uso de like
SELECT  CustomerID, CompanyName, Country City, Address
FROM Customers
WHERE CompanyName LIKE 's%'; --palabras que comiencen en s

SELECT  CustomerID, CompanyName, Country City, Address
FROM Customers
WHERE CompanyName NOT LIKE 's%'; 

SELECT  CustomerID, CompanyName, Country City, Address
FROM Customers
WHERE CompanyName LIKE '%ese%'; --tiene que tener dentro "ese"

SELECT  CustomerID, CompanyName, Country City, Address
FROM Customers
WHERE CompanyName LIKE '_s%'; --que la palabra tenga como segunda letra s

SELECT  CustomerID, CompanyName, Country City, Address
FROM Customers
WHERE CompanyName LIKE '__s%';


/* Funciones de Agregado 
SUM, AVG, MAX, MIN, COUNT
lo vemos la proxima clase
*/


/* Funciones de fecha y hora*/
SELECT GETDATE();

SELECT GETDATE(), YEAR(GETDATE()) Año, MONTH(GETDATE()) Mes, DAY(GETDATE()) Dia;

SELECT GETDATE(), DATEPART(HH,GETDATE()) Hora, DATEPART(mm, GETDATE()) min, DATEPART(ss, GETDATE()) seg;

SELECT DATEDIFF(YEAR, '1972-01-18', GETDATE());
SELECT DATEDIFF(MONTH, '1972-01-18', GETDATE());
select DATEDIFF(DAY,'1972-01-18', GETDATE());

/* Tarea
utilizando cualquiera de la stablas de la BD Northwin
usar funciones de cadena.

daniel.ramos.c@sistemasuni.edu.pe
asunto: tarea semana02
*/

