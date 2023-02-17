
USE Northwind;

exec sp_helpindex pa_Empleado_insert;

CREATE PROC pa_Sumita_2
@n1 int, @n2 int, @n3 INT OUTPUT
AS
BEGIN
    SET @n3 = @n1 + @n2
END
GO

--ejecutando el procedimiento
declare @rpta int
exec pa_Sumita_2 8, 21, @rpta output
select 'la suma es: ', @rpta


/* CREANDO FUNCIONES */
CREATE FUNCTION fn_Sumita_4
(
    @n1 int,
    @n2 int
)
RETURNS int
BEGIN
    return (@n1 + @n2)
END
go

--ejecutando la funcion
SELECT 'la suma es: ', dbo.fn_Sumita_4(8, 26)

----------------------------------------------------------------

SELECT * FROM [Order Details]


--crear una funcion que calcule
--IMPORTE PAGADO=PERCIO*CANTIDAD * (1-DESCUENTO)
CREATE FUNCTION fn_Importe
(
    @precio money,
    @cantidad int,
    @descuento real
)
RETURNS money
BEGIN
    return (@precio * @cantidad * (1 - @descuento))
END
GO

--ejecutando la funcion
SELECT *, dbo.fn_Importe(UnitPrice, Quantity, Discount) 
AS Importe 
FROM [Order Details];


--devolver la cantidad de pedidos realizados por un cliente
CREATE FUNCTION fn_PedidosCliente_2
(
    @codcli VARCHAR(10)
)
RETURNS int
BEGIN
    DECLARE @Nro int
    SELECT @Nro = COUNT(1) FROM Orders WHERE CustomerID = @codcli
    RETURN @Nro
END
GO

--ejecutando la funcion
SELECT CustomerID, CompanyName, dbo.fn_PedidosCliente_2(CustomerID) 
AS "Nro de Pedidos"
FROM Customers; 


--
SELECT * FROM Orders;
SELECT * FROM [Order Details];

--------------------------------------------------------------

SELECT *, dbo.fn_Importe(UnitPrice, Quantity, Discount) from [Order Details];
SELECT OrderID, SUM(dbo.fn_Importe(UnitPrice, Quantity, Discount))
FROM [Order Details]
GROUP BY OrderID;

----------------------------------------------------------------------------
--CREANDO UNA FUNCION DENTRO DE OTRA FUNCION
--crear una funcion que devuelva el importe total de un pedido
CREATE FUNCTION fn_Total_Pedido
(
    @nroPed int
)
RETURNS money
BEGIN
    RETURN(
        SELECT SUM(dbo.fn_Importe(UnitPrice, Quantity, Discount))
		FROM [Order Details] WHERE OrderID = @nroPed)
END
GO

--ejecutando la funcion
SELECT * FROM Orders

SELECT OrderID, CustomerID, EmployeeID, ShipVia, orderDate, Freight, dbo.fn_Total_Pedido(OrderID) AS Total
FROM Orders;


--------------------------------------------------------------------
--cear una funcion que devuelva el importe de n bono para los empleado, 
--considerar un X% de importe total generado por cada uno de ellos

CREATE FUNCTION fn_Bono_Empleado_2
(
    @codEmp int,
	@porc real
)
RETURNS money
BEGIN
    DECLARE @total money
    SELECT @total = SUM(dbo.fn_Total_Pedido(OrderID))FROM Orders WHERE Orders.EmployeeID=@codEmp
    RETURN (@total * @porc / 100)
END
GO

--ejecutando la funcion
SELECT EmployeeID, LastName, FirstName, dbo.fn_Bono_Empleado_2(EmployeeID, 10) AS Bono
FROM Employees;

SELECT EmployeeID, LastName, FirstName, dbo.fn_Bono_Empleado_2(EmployeeID, 10) AS Bono
FROM Employees;

--comparando
SELECT EmployeeID, LastName, FirstName, dbo.fn_Bono_Empleado_2(EmployeeID, 10) "BONO 10%"
bdo.fn_Bono_Empleado(EmployeeID, 5) "BONO 5%"
FROM Employees;

-- crear una funcion que devuelva los datos de cliente y proveedores para la sunat
--TYPO
create function fn_ListSunat
()returns @lista table(tipo char(3),codigo varchar(5),nombre varchar(60),direccion varchar(80),
						ciudad varchar(30),pais varchar(30))
as
begin
	insert into @lista
	select 'CLI',CustomerID,CompanyName,Address,City,Country from Northwind.dbo.Customers
	insert into @lista
	select 'PRV',SupplierID,CompanyName,Address,City,Country from Northwind.dbo.Suppliers
	return
end
go

--ejecutando la funcion
SELECT * FROM fn_ListSunat();


------------------------------------------------------------------------------------
--devolver los pedidos de un determinado cliente
CREATE FUNCTION fn_Cliente_Pedidos
(
    @codcli CHAR(5)
)
RETURNS TABLE
AS
RETURN(
    SELECT OrderID, CustomerID, EmployeeID, ShipVia, orderDate, Freight, dbo.fn_Total_Pedido(OrderID) AS Total
    FROM Orders
    WHERE CustomerID = @codcli
)
go

--ejecutando la funcion
SELECT * FROM fn_Cliente_Pedidos('anton');


--crear una f uncion que devuelva a los clientes de un determinado pais
CREATE FUNCTION fn_Clientes_Pais
(
    @nomPais VARCHAR(30)
)
RETURNS TABLE
AS
RETURN(
    SELECT *
    FROM Northwind.dbo.Customers
    WHERE Country = @nomPais
)
go

--ejecutando la funcion
SELECT * FROM fn_Clientes_Pais('germany');


-------------------------------------------------------------------------
--listar funciones existentes
SELECT * FROM sys.sysobjects
WHERE xtype IN('fn', 'tf', 'if')

