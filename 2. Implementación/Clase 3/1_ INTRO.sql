
--ver las bases de datos
SELECT * FROM SYS.databases;

USE Northwind;

--validar la base de datos en uso
SELECT DB_NAME();

--listar las tablas existentes
SELECT * FROM sys.tables;

SELECT * FROM Employees;

SELECT EmployeeID, FirstName, LastName, BirthDate AS FechaNacimiento,
DATEDIFF(YEAR, BirthDate, GETDATE()) AS Edad
FROM Employees;

--Tambien podemos calcular el tiempo de servicio
SELECT EmployeeID, FirstName, LastName, BirthDate AS FechaNacimiento,
DATEDIFF(YEAR, BirthDate, GETDATE()) AS Edad, 
HireDate AS FechaContratacion, 
DATEDIFF(YEAR, HireDate, GETDATE()) AS TiempoServicio
FROM Employees;

--ver las columnas de orders
SELECT * FROM Orders;

--saber cuanto demoro en embarcar el pedido
SELECT OrderID, RequiredDate, ShippedDate, 
DATEDIFF(DAY, OrderDate,ShippedDate) AS [Tiempo Demora Embarque]
FROM Orders;

---------------------------------------------------------------
/* FUNCIONES DE AGREGADO*/
SELECT * FROM customers;

--cuantos clientes tenemos
SELECT COUNT(*) AS [Cantidad de Clientes]
FROM customers;

--una mejor manera
SELECT COUNT(1) FROM Customers;

SELECT * FROM Products;

--mostrar el precio mas alto
SELECT MAX(UnitPrice) AS [Precio mas alto]
FROM Products;

--mostrar el precio mas bajo
SELECT MIN(UnitPrice) AS "Precio mas bajo"
FROM Products;

--el precio mas alto y el mas bajo
SELECT MAX(UnitPrice) AS [Precio mas alto], MIN(UnitPrice) AS [Precio mas bajo]
FROM Products;

--ordenando los datos de precio
SELECT ProductName,
MAX(UnitPrice) AS [Precio mas alto], 
MIN(UnitPrice) AS [Precio mas bajo]
FROM Products 
GROUP BY ProductName, UnitPrice ORDER BY UnitPrice DESC

SELECT ProductName,MAX(UnitPrice) AS [Precio mas alto], MIN(UnitPrice) AS [Precio mas bajo]
FROM Products GROUP BY ProductName;

--listar una columna
--TOP() ayuda a elegir el primer producto en la lista
SELECT TOP(1) [ProductName],MAX(UnitPrice) AS [Precio mas alto], MIN(UnitPrice) AS [Precio mas bajo]
FROM Products 
GROUP BY [ProductName], UnitPrice ORDER BY UnitPrice DESC

--TOP() para listar los 3 productos mas caros
SELECT TOP(3) ProductName AS Producto, 
MAX(UnitPrice) AS [Precio mas alto], 
MIN(UnitPrice) AS [Precio mas bajo]
FROM Products GROUP BY [ProductName], UnitPrice ORDER BY UnitPrice DESC

--total de unidades de  productos
SELECT * FROM Products;

--numero total de productos
SELECT SUM(UnitsInStock) [Suma Total Unidades]
FROM Products;

--numero de unidades por productos en total
--GROUP BY
--nos ayuda a agrupar segun un tipo de fila, ya que es una columna con datos repetidos
SELECT Products.CategoryID, SUM(UnitsInStock) AS [Total Unidades]
FROM Products
GROUP BY Products.CategoryID;

--valorizado de productos
SELECT SUM([UnitPrice]*[UnitsInStock]) AS [Valorizado]
FROM [dbo].[Products];

SELECT SUM([UnitPrice]*[UnitsInStock]) AS [Valorizado]
FROM Products;


--precio promedio
SELECT AVG(UnitPrice) AS precio_promedio
FROM Products;

--listar los productos cuyo precio se mayor al promedio
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products);

--columna para saber que el producto es mayor que el promedio
SELECT ProductID, ProductName, UnitPrice, (SELECT AVG(UnitPrice) FROM Products) AS Promedio
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products);

--DECLARANDO VARIABLES 
--utilizando DECLARE
DECLARE @promedio MONEY
SELECT @promedio = AVG(UnitPrice) FROM Products
SELECT ProductID, ProductName, UnitPrice, @promedio AS Promedio
FROM Products
WHERE UnitPrice > @promedio;

--utilizando SET
--tener en cuenta que las variables deben ser direfentes
DECLARE @promedio_2 MONEY
SET @promedio_2 = (SELECT AVG(UnitPrice) FROM Products)
SELECT ProductID, ProductName, UnitPrice, @promedio_2 AS Promedio
FROM Products
WHERE UnitPrice > @promedio_2;

-----------------------------------------------------------------
-- GROUP BY()
-- agrupando segun un tipo de dato
SELECT * FROM Products;
SELECT * FROM Customers;

SELECT ProductName, CategoryID, UnitPrice FROM Products;

--cantidad de productos por categoria
SELECT CategoryID, COUNT(ProductName) AS [Cantidad de Productos]
FROM Products
group by CategoryID;

SELECT CategoryID, ProductName AS [Cantidad de Productos]
FROM Products
group by CategoryID;

--mostrar el precio por categoria
SELECT CategoryID, AVG(UnitPrice) AS PrecioPromedio
FROM Products
group by CategoryID;

SELECT CompanyName, Country, City
FROM Customers
GROUP BY CompanyName, Country, City;

--cuantosa clientes hay por pais y ciudad
SELECT Country, City, COUNT(CustomerID) AS [Cantidad de Clientes]
FROM Customers
GROUP BY Country, City;

--ordenando los datos con ORDER BY
SELECT Country, City, COUNT(CustomerID) AS [Cantidad de Clientes]
FROM Customers
GROUP BY Country, City
ORDER BY Country, City;





