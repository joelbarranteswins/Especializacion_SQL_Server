
/* SQL Database */

--CREATE DATABASE [SQL_Database]
--crea la base de datos 
CREATE DATABASE data_base_name;

--DROP DATABASE [SQL_Database]
--elimina la base de datos
DROP DATABASE data_base_name;

--BACKUP DATABASE [SQL_Database] TO  DISK = 'file_path'
--guarda la base de datos en un archivo
BACKUP DATABASE data_base_name TO  DISK = 'C:\SQL_Database.bak'

--CREATE TABLE [dbo].[Table_Name]
--crea una tabla
CREATE TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
    );

--DROP TABLE [dbo].[Table_Name]
--elimina una tabla
DROP TABLE Persons;


--ALTER TABLE [dbo].[Table_Name]
--modifica una tabla
ALTER TABLE table_name
ADD column_name datatype;

--change data tyoe
ALTER TABLE Persons
ALTER COLUMN DateOfBirth year;

--eliminar una columna
ALTER TABLE Persons
DROP COLUMN DateOfBirth;

--CREATE TABLE [dbo].[Table_Name] Constraint [Constraint_Name]
--crea una tabla con una restriccion
CREATE TABLE table_name (
    column1 datatype constraint,
    column2 datatype constraint,
    column3 datatype constraint,
    ....
);

/*
The following constraints are commonly used in SQL:

NOT NULL - Ensures that a column cannot have a NULL value
UNIQUE - Ensures that all values in a column are different
PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
FOREIGN KEY - Prevents actions that would destroy links between tables
CHECK - Ensures that the values in a column satisfies a specific condition
DEFAULT - Sets a default value for a column if no value is specified
CREATE INDEX - Used to create and retrieve data from the database very quickly
*/

--crear tabla con restriccion de NOT NULL
CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255) NOT NULL,
    Age int
);

--modificar el tipo de dato de una columna
ALTER TABLE Persons
MODIFY Age int NOT NULL;

--rectriccion UNIQUE
CREATE TABLE Persons (
    ID int NOT NULL UNIQUE,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int
);

--ALTER para agregar UNIQUE
ALTER TABLE Persons
ADD UNIQUE (ID);

ALTER TABLE Persons
ADD CONSTRAINT UC_Person UNIQUE (ID,LastName);

--PRIMARY KEY
CREATE TABLE Persons (
    ID int NOT NULL PRIMARY KEY,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int
);

CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    CONSTRAINT PK_Person PRIMARY KEY (ID,LastName)
);

ALTER TABLE Persons
ADD PRIMARY KEY (ID);

ALTER TABLE Persons
ADD CONSTRAINT PK_Person PRIMARY KEY (ID,LastName);

ALTER TABLE Persons
DROP CONSTRAINT PK_Person;

--FOREIGN KEY
CREATE TABLE Orders (
    OrderID int NOT NULL PRIMARY KEY,
    OrderNumber int NOT NULL,
    PersonID int FOREIGN KEY REFERENCES Persons(PersonID)
);

CREATE TABLE Orders (
    OrderID int NOT NULL,
    OrderNumber int NOT NULL,
    PersonID int,
    PRIMARY KEY (OrderID),
    CONSTRAINT FK_PersonOrder FOREIGN KEY (PersonID)
    REFERENCES Persons(PersonID)
);

ALTER TABLE Orders
ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);

ALTER TABLE Orders
ADD CONSTRAINT FK_PersonOrder
FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);

ALTER TABLE Orders
DROP CONSTRAINT FK_PersonOrder;


--CHECK()
CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int CHECK (Age>=18)
);

CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    City varchar(255),
    CONSTRAINT CHK_Person CHECK (Age>=18 AND City='Sandnes')
);

ALTER TABLE Persons
ADD CHECK (Age>=18);

ALTER TABLE Persons
ADD CONSTRAINT CHK_PersonAge CHECK (Age>=18 AND City='Sandnes');

ALTER TABLE Persons
DROP CONSTRAINT CHK_PersonAge;

--DEFAULT() 
CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    City varchar(255) DEFAULT 'Sandnes'
);

CREATE TABLE Orders (
    ID int NOT NULL,
    OrderNumber int NOT NULL,
    OrderDate date DEFAULT GETDATE()
);

ALTER TABLE Persons
ADD CONSTRAINT df_City
DEFAULT 'Sandnes' FOR City;

ALTER TABLE Persons
ALTER COLUMN City DROP DEFAULT;

--CREATE INDEX
CREATE INDEX idx_lastname
ON Persons (LastName);

CREATE INDEX idx_pname
ON Persons (LastName, FirstName);

DROP INDEX table_name.index_name;

--AUTO_INCREMENT
/*
Tip: To specify that the "Personid" column should start 
at value 10 and increment by 5, change it to IDENTITY(10,5).
*/
CREATE TABLE Persons (
    Personid int IDENTITY(1,1) PRIMARY KEY,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int
);

--data types
/*
SQL Server comes with the following data types for storing a date or a date/time value in the database:

DATE - format YYYY-MM-DD
DATETIME - format: YYYY-MM-DD HH:MI:SS
SMALLDATETIME - format: YYYY-MM-DD HH:MI:SS
TIMESTAMP - format: a unique number
Note: The date types are chosen for a column when you create a new table in your database!
*/

SELECT * FROM Orders WHERE OrderDate='2008-11-11'

--CREATE VIEW
/*
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;
*/

CREATE VIEW [Brazil Customers] AS
SELECT CustomerName, ContactName
FROM Customers
WHERE Country = 'Brazil';

SELECT * FROM [Brazil Customers];

CREATE VIEW [Products Above Average Price] AS
SELECT ProductName, Price
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

SELECT * FROM [Products Above Average Price];

CREATE OR REPLACE VIEW [Brazil Customers] AS
SELECT CustomerName, ContactName, City
FROM Customers
WHERE Country = 'Brazil';

DROP VIEW [Brazil Customers];