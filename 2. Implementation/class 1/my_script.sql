-- ingresar a la BD
use UNI00;

--verificando
SELECT db_name();

--listando las tablas existentes
SELECT * FROM sys.tables;

--crear tablas
CREATE TABLE demo10 (
codigo int,
dato varchar(50));

--listando datos
SELECT * FROM demo10;

--insertando datos
INSERT INTO demo10 VALUES(1, 'hola');

INSERT demo10 VALUES(2,'Nuevo');

--crear tablas
CREATE TABLE demo11(
codigo INT PRIMARY KEY,
dato VARCHAR(50) NOT NULL UNIQUE);

--insertando datos
INSERT INTO demo11 VALUES(3, 'hola mundo')
INSERT INTO demo11 VALUES(4, 'hola mundo nuevo')
INSERT INTO demo11 VALUES(5, 'mundo te quiero')

SELECT * FROM demo11

--usando otros tipo de datos
CREATE TABLE Persona (
	codPer INT IDENTITY PRIMARY KEY,
	nomPer Varchar(80) NOT NULL,
	dniPer CHAR(8) NOT NULL UNIQUE,
	fecNaci DATE,
	sexo CHAR(1) DEFAULT 'F' CHECK(sexo in ('F','M')),
	edad as DATEDIFF(YEAR, fecNaci, GETDATE()),
	nroHijos TINYINT,
	sueldo MONEY DEFAULT 930 CHECK(sueldo>=930));


INSERT Persona VALUES('Perico Perez', '12345678','1994-05-14','M',0,2300);

SELECT * FROM Persona;

--inserting some values
insert Persona(nomPer,dniPer,nroHijos) values('Rosita Rios' , '44332211' , 0);

CREATE TABLE Distrito (
	codDis CHAR(3) PRIMARY KEY,
	nomDis VARCHAR(80) NOT NULL UNIQUE);

INSERT Distrito VALUES('L01', 'Lima');
INSERT Distrito VALUES('L21', 'Ancon');
INSERT Distrito VALUES('L32', 'SJM');
INSERT Distrito VALUES('L27', 'San Isidro');
INSERT Distrito VALUES('L18', 'Miraflores');

--luego
SELECT * FROM Distrito
SELECT * FROM Persona

--modificando la tabla
alter table Persona
ADD codPostal CHAR(3) REFERENCES Distrito;

insert Persona(nomPer, dniPer, nroHijos, codPostal)
VALUES('Pedrito Navaja','77332211',0,'L99')

insert Persona(nomPer, dniPer, nroHijos, codPostal)
VALUES('Pedrito Navaja','77332211',0,'L02')



