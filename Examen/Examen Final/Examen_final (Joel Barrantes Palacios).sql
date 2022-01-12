
/* 
EXAMEN FINAL DE SQL IMPLEMENTACION
NOMBRE: JOEL BARRANTES PALACIOS 
*/


/*
1. Listar los productos vendidos durante 
el mes de julio de cualquier año y 
la cantidad total solicitada
*/

USE Northwind;

SELECT * FROM Products;
SELECT * FROM Orders;


SELECT 
P.ProductName AS [Nombre del producto], 
P.ProductID AS [ID del producto], 
OD.OrderID AS [ID de Orden],
FORMAT(O.OrderDate, 'dd-MM-yyyy') AS [Fecha de venta] , 
P.UnitPrice AS [Precio Unitario], 
OD.Quantity AS [Cantidad Comprada], 
OD.Discount AS [Descuento por compra]
FROM Products AS P
JOIN [Order Details] AS OD ON OD.ProductID = P.ProductID
JOIN Orders AS O ON O.OrderID = OD.OrderID
WHERE MONTH(O.OrderDate) = 7 
ORDER BY P.ProductName;


----------------------------------------------------------------------
/*
2. Crear procedimiento almacenado para 
registrar, actualizar y eliminar datos de la tabla Supplier
*/

SELECT * FROM Suppliers;

--PROCEDIMIENTO PARA INSERTAR UN PROVEEDOR
CREATE PROC pa_Proveedores_insert
@empresa varchar(100),
@contacto varchar(120)=null,
@puesto varchar(60)=null,
@direccion varchar(120)=null,
@ciudad varchar(30)=null,
@pais varchar(30)=null,
@telefono varchar(30)
AS
if @empresa is null
begin
    raiserror('Debe ingresar el nombre de la empresa',15,1)
    return
end
if @telefono is null
begin
    raiserror('Debe ingresar el telefono del contacto o empresa',15,1)
    return
end
INSERT INTO Suppliers(CompanyName, ContactName, ContactTitle, Address, City, Country, Phone)
VALUES (@empresa, @contacto, @puesto, @direccion, @ciudad, @pais, @telefono)
PRINT 'Proveedor Registrado';


--ejecutar el procedimiento
exec pa_Proveedores_insert 'Don Victorio','Joel Barrantes','Jefe de Ventas','Billingurt 4A', 'Lima','Peru', '987654321';

exec pa_Proveedores_insert 'Ariel','David Barrantes','Jefe de Ventas','AV. Huancayo 4A', 'Lima','Peru', '00000000';

--ver la tabla
SELECT * FROM Suppliers;


--
--PROCEDIMIENTO PARA ACTUALIZAR EL PROVEEDOR
CREATE PROC pa_Proveedores_update
@codigo int=NULL,
@empresa varchar(100),
@contacto varchar(120)=null,
@puesto varchar(60)=null,
@direccion varchar(120)=null,
@ciudad varchar(30)=null,
@pais varchar(30)=null,
@telefono varchar(30)
AS
if @codigo is null
begin
    raiserror('Debe ingresar el codigo del proveedor',15,1)
    return
end
if @empresa is null
begin
    raiserror('Debe ingresar el nombre de la empresa',15,1)
    return
end
if @telefono is null
begin
    raiserror('Debe ingresar el telefono del contacto o empresa',15,1)
    return
end
UPDATE Suppliers SET 
    CompanyName = @empresa, ContactName = @contacto, ContactTitle = @puesto, 
    Address = @direccion, City = @ciudad, Country = @pais, Phone = @telefono
WHERE SupplierID = @codigo;
PRINT 'Proveedor Actualizado';

--ejecutar el procedimiento
exec pa_Proveedores_update 31,
'Don Victorio S.A.','Joel Barrantes Palacios','Jefe de Ventas','Billingurt 4A', 'Lima','Peru', '987654321';

exec pa_Proveedores_update 32,
'Ariel SAC','Angel David Barrantes','Jefe de Ventas','AV. Huancayo 4A', 'Lima','Peru', '00000000';

--ver la tabla
SELECT * FROM Suppliers;


--PROCEDIMIENTO PARA ELIMINAR UN PROVEEDOR
CREATE PROC pa_Proveedores_delete
@codigo int=NULL
AS
IF @codigo IS NULL
BEGIN
    RAISERROR('Debe ingresar el codigo',15,1)
    RETURN
END
DELETE FROM Suppliers WHERE SupplierID=@codigo
PRINT 'Proveedor Eliminado';

--ejecutar el procedimiento
exec pa_Proveedores_delete 32;

--ver la tabla
SELECT * FROM Suppliers;


----------------------------------------------------------------------
/*
Crear las siguientes Queries
*/


/*
1. LISTAR LOS CLIENTES QUE REALIZARON PEDIDOS DURANTE EL MES DE 
OCTUBRE DE CUALQUIER AÑO, INDICANDO LA CANTIDAD DE PEDIDOS EFECTUADOS 
Y SU IMPORTE TOTAL.
*/

CREATE FUNCTION fn_Importe
(
    @precio money,
    @cantidad int,
    @descuento real
)
RETURNS money
BEGIN
    return (@precio * @cantidad * (1 - @descuento))
END;

SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM [Order Details];
SELECT * FROM Customers;

SELECT 
C.CustomerID AS [ID del cliente], 
C.CompanyName AS Cliente, 
O.OrderID,
C.Country AS [Pais],
FORMAT(O.OrderDate, 'dd-MMMM-yyy') AS [Fecha de venta],
SUM(OD.Quantity) AS [Cantidad de Pedidos],
SUM(ROUND(dbo.fn_Importe(OD.UnitPrice, OD.Quantity, OD.Discount), 2)) AS [Importe Total]
FROM Customers AS C
JOIN Orders AS O ON C.CustomerID=O.CustomerID
JOIN [Order Details] AS OD ON O.OrderID=OD.OrderID
WHERE MONTH(O.OrderDate) = 10
GROUP BY C.CustomerID, C.CompanyName, O.OrderID, C.Country, O.OrderDate
ORDER BY C.CustomerID



/* 
2. LOS PRODUCTOS MÁS SOLICITADOS ENTRE FEBRERO Y JUNIO DE 1997.
*/

SELECT 
P.ProductName AS [Nombre del producto], 
P.ProductID AS [ID del producto], 
OD.OrderID AS [ID de Orden],
FORMAT(O.OrderDate, 'MMMM-yy') AS [Fecha de venta],  
P.UnitPrice AS [Precio Unitario], 
SUM(OD.Quantity) AS [Cantidad de Pedidos] 

FROM Products AS P
JOIN [Order Details] AS OD ON OD.ProductID = P.ProductID
JOIN Orders AS O ON O.OrderID = OD.OrderID
WHERE 
	MONTH(O.OrderDate) >= 2 
	AND MONTH(O.OrderDate) <= 6 
	AND YEAR(O.OrderDate) = 1997
GROUP BY P.ProductName, O.OrderDate, P.ProductID, OD.OrderID, P.UnitPrice
ORDER BY [Cantidad de Pedidos] DESC;


/* 
3. LOS 3 PAÍSES QUE MENOS PEDIDOS RECIBIÓ EN 1998
*/

SELECT TOP(3)
O.ShipCountry AS [Pais],  
SUM(OD.Quantity) AS [Cantidad de Pedidos]
FROM [Order Details] AS OD
JOIN Orders AS O ON O.OrderID = OD.OrderID
WHERE 
	MONTH(O.OrderDate) >= 2 
	AND MONTH(O.OrderDate) <= 6 
	AND YEAR(O.OrderDate) = 1998
GROUP BY O.ShipCountry
ORDER BY [Cantidad de Pedidos] DESC;