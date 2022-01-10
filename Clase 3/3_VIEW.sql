
USE Northwind;


/* CREANDO VISTAS CON VIEW */
--almacena una consulta

CREATE VIEW v_Pedido_2
AS
SELECT OrderID,o.CustomerID,c.CompanyName as Cliente,o.EmployeeID,e.LastName,e.FirstName,
OrderDate,ShipVia,s.CompanyName as Proveedor, Freight
from Orders as O
join Customers as C on o.CustomerID=c.CustomerID
join Employees as E on o.EmployeeID=e.EmployeeID
join Shippers as S on o.ShipVia=s.ShipperID

--ver la consulta de una vista
SELECT * FROM v_pedido_2;

--ver la consulta de esa vista
EXEC sp_helptext v_pedido_2;

CREATE VIEW v_Pedido AS
SELECT OrderId, O.CustomerID, C.CompanyName as Cliente, 
O.EmployeeID, E.FirstName, OrderDate, ShipVia, S.CompanyName as Proveedor, Freight
FROM Orders AS O
JOIN Customers AS C ON O.CustomerID=C.CustomerID
JOIN Employees AS E ON O.EmployeeID=E.EmployeeID
JOIN Shippers AS S ON O.ShipVia=S.ShipperID;

SELECT * FROM v_Pedido;

EXEC sp_helptext v_Pedido;

--generar un ORDER BY() para una vista
SELECT * FROM v_Pedido
ORDER BY Cliente;

--usando COUNT() para una vista
SELECT Cliente, COUNT(1) as Cantidad
FROM v_Pedido
GROUP BY Cliente;

-------------------------------------------------------------------
--las vista mejoran el rendimiento cuando tienen un indice

-- creando otra vista
CREATE VIEW v_Empleado
AS
SELECT EmployeeID, LastName, FirstName, BirthDate AS FechaNacimiento,
DATEDIFF(YEAR, BirthDate, GETDATE()) AS Edad,
HireDate AS FechaContratacion,
DATEDIFF(YEAR, HireDate, GETDATE()) AS TiempoServicio,
City, Country
FROM Employees;


SELECT * FROM v_Empleado
SELECT * FROM Orders;

--haciendo un JOIN en una vista
SELECT O.OrderID, O.CustomerID, ve.LastName + ' ' +ve.FirstName AS Empleado, OrderDate, Freight
FROM Orders AS O
JOIN v_Empleado AS ve ON O.EmployeeID=ve.EmployeeID;



-- En una vista no existe el ORDER BY y la organizacion se realiza por fuera


