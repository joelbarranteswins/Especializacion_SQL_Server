

/*
uso del JOIN
*/
CREATE TABLE j_auto (
nomAuto VARCHAR(20) NOT NULL UNIQUE,
colorAuto VARCHAR(20) NOT NULL UNIQUE );

CREATE TABLE j_fruta (
nomFruta VARCHAR(20) NOT NULL UNIQUE,
colorFruta VARCHAR(20) NOT NULL UNIQUE );

--insertando datos
INSERT INTO j_Auto VALUES('toyota','blanco'),('mazda','verde'),('ferrari','rojo'),
('ford','azul'),('kia','amarillo'),('bmw','negro'),('mercedes benz','dorado'),('citroen','celeste');

INSERT INTO j_fruta VALUES('palta','verde'),('fresa','rojo'),('coco','marron'),('higo','negro'),
('platano','amarillo'),('naranja','naranja'),('uva','morado');

SELECT * FROM j_auto;
SELECT * FROM j_fruta;

-- INNER JOIN()
-- devuelve los valores iguales de ambas tablas
SELECT A.nomAuto, A.colorAuto, B.colorFruta
FROM j_auto AS A
JOIN j_fruta AS B ON A.ColorAuto = B.ColorFruta;

--otra forma del INNER JOIN()
SELECT nomAuto, colorAuto, colorFruta, nomFruta
FROM j_auto 
INNER JOIN j_fruta ON j_auto.ColorAuto = j_fruta.ColorFruta


-- LEFT JOINT
-- devuelve todos los valores de la primera tabla
SELECT A.nomAuto, A.colorAuto, B.nomFruta, B.colorFruta
FROM j_auto AS A
LEFT JOIN j_fruta AS B ON A.colorAuto = B.colorFruta;

-- RIGHT JOIN
-- devuelve los valores de la segunda tabla
SELECT A.nomAuto, A.colorAuto, B.nomFruta, B.colorFruta
FROM j_auto AS A
RIGHT JOIN j_fruta AS B ON A.colorAuto = B.colorFruta;

-- LEFT JOIN - WHERE
-- devuelve los valores de la primera tabla pero diferentes de la segunda
SELECT A.nomAuto, A.colorAuto, B.nomFruta, B.colorFruta
FROM j_auto AS A
LEFT JOIN j_fruta AS B ON A.colorAuto = B.colorFruta
WHERE B.colorFruta IS NULL;

-- RIGHT JOIN - WHERE
-- devuelve los valores de la segunda tabla pero diferentes de la primera
SELECT A.nomAuto, A.colorAuto, B.nomFruta, B.colorFruta
FROM j_auto AS A
RIGHT JOIN j_fruta AS B ON A.colorAuto = B.colorFruta
WHERE A.colorAuto IS NULL;

-- FULL JOIN
-- devuelve los valores de ambas tablas
SELECT A.nomAuto, A.colorAuto, B.nomFruta, B.colorFruta
FROM j_auto AS A
FULL OUTER JOIN j_fruta AS B ON A.colorAuto = B.colorFruta;

-- FULL OUTER JOIN - WHERE
-- devuelve los valores de ambas tablas pero diferentes de la primera y de la segunda
SELECT A.nomAuto, A.colorAuto, B.nomFruta, B.colorFruta
FROM j_auto AS A
FULL OUTER JOIN j_fruta AS B ON A.colorAuto = B.colorFruta
WHERE A.colorAuto IS NULL OR B.colorFruta IS NULL;

-----------------------------------------------------------------
USE Northwind;
SELECT DB_NAME();

-- TRABAJANDO CON LOS JOIN
-- mostrar la cantidad de productos por categoria
SELECT CategoryID, COUNT(ProductName) AS [Cantidad de Productos]
FROM Products
GROUP BY CategoryID;

--mostrar la cantidad de productos por categoria
SELECT P.CategoryID, C.CategoryName, COUNT(ProductName) AS [Cantidad de Productos]
FROM Products AS P
JOIN Categories AS C ON P.CategoryID = C.CategoryID
GROUP BY P.CategoryID, C.CategoryName;

--cuantos productos tenemos por proveedor
SELECT S.CompanyName as Proveedor, COUNT(P.ProductName) AS Cantidad
FROM Products as P
JOIN Suppliers AS S ON P.SupplierID=S.SupplierID
GROUP BY S.CompanyName;

SELECT * FROM Suppliers;
SELECT * FROM Products;
SELECT * FROM Categories;
-----------------------------------------------------------------

--varios JOIN
SELECT P.ProductID, P.ProductName, S.CompanyName AS Proveedor, , C.CategoryName AS Categoria 
FROM Products AS P
JOIN Suppliers as S ON P.SupplierID=S.SupplierID
JOIN Categories AS C ON P.CategoryID=C.CategoryID

--cuando el nombre de la tabla es unica, no es necesaria el alias
SELECT ProductID, ProductName, CompanyName AS Proveedor, , CategoryName AS Categoria 
FROM Products AS P
JOIN Suppliers as S ON P.SupplierID=S.SupplierID
JOIN Categories AS C ON P.CategoryID=C.CategoryID

SELECT * FROM orders;

SELECT OrderId, O.CustomerID, C.CompanyName AS Cliente, 
O.EmployeeID, E.LastName, E.FirstName, OrderDate, 
ShipVia, S.CompanyName AS Proveedor, Freight
FROM Orders AS O
JOIN Customers AS C ON O.CustomerID=C.CustomerID
JOIN Employees AS E ON O.EmployeeID=E.EmployeeID
JOIN Shippers AS S ON O.ShipVia=S.ShipperID



