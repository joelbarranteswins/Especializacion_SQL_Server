

/* Creando cursores */
--recupera datos y los presenta a travez de reportes

SELECT CategoryID, CategoryName, Description from Categories
--usando un cursor
--1 declarar el cursor
DECLARE cursor1 cursor scroll for select CategoryID, CategoryName, Description from Categories
--2 abrir el cursor
OPEN cursor1
--3 leer los registror del cursor
FETCH FIRST FROM curso1
FETCH ABSOLUTE 5 FROM cursor1
FETCH LAST FROM cursor1
--4 cerrar el cursor
CLOSE cursor1
--5 liberar el cursoR, liberar la memoria
DEALLOCATE cursor1


--*******************
-- cursor consulta
--*******************
DECLARE curCate cursor for select  CategoryID, CategoryName, Description from Categories
DECLARE @codigo int, @nombre VARCHAR(50), @DESCRIPTION varchar(255)
OPEN curCate
FETCH curCate INTO @codigo, @nombre, @description
PRINT 'REPORTE CATEGORIAS'
PRINT replicate('=',40)
WHILE @@FETCH_STATUS = 0 --variable del sistema
BEGIN
    PRINT 'Codigo: ' + cast(@codigo as char(2)) + ' Nombre: ' + @nombre + ' Descripcion: ' + @description
    FETCH curCate INTO @codigo, @nombre, @description
END
PRINT replicate('-',40)
close curCate
DEALLOCATE curCate



-- Listar los productos y sus cantidades vendidas durante el 2do semestre de 1997
DECLARE curDatos cursor for
    SELECT P.ProductName, sum(OD.Quantity) as total
    FROM Orders AS O
    JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
    JOIN Products AS P ON OD.ProductID = P.ProductID
    WHERE YEAR(O.OrderDate) = 1997 AND DATEPART(QUARTER, O.OrderDate) >= 3 GROUP BY P.ProductName
DECLARE @nomPrd VARCHAR(40), @cantidad int
OPEN curDatos
PRINT 'PRODUCTOS VENDIDOS DURANTE EL 2do SEMESTRE DE 1997'
PRINT replicate('=',60)
FETCH curDatos INTO @nomprd, @cantidad
WHILE @@FETCH_STATUS = 0
BEGIN
	--print @nomPrd +cast(@cantidad as char)
    PRINT LEFT(@nomPrd + replicate('.',45), 45) + cast(@cantidad as char)
    FETCH curDatos INTO @nomPrd, @cantidad
END
PRINT replicate('-',60)
CLOSE curDatos
DEALLOCATE curDatos
GO


/****************************************************
CURSORES ANIDADOS
LISTAR LAS CATEGORIAS Y LOS PRODUCTOS QUE PERTENECEN A ELLA
****************************************************/

DECLARE curCate CURSOR FOR SELECT CategoryID, CategoryName FROM Categories
DECLARE @codigo int, @nombre VARCHAR(50)
OPEN curCate
FETCH curCate INTO @codigo, @nombre
PRINT 'REPORTE DE PRODUCTOS POR CATEGORIA'
PRINT replicate('=',60)
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Categoria ' + cast(@codigo as char(2)) + ' Nombre: ' + @nombre
    PRINT replicate('-', 60)
    DECLARE curProd CURSOR FOR SELECT ProductID, ProductName from Products where CategoryID=@codigo
    DECLARE @codPrd int, @nomPrd varchar(50)
    OPEN curProd
    FETCH curProd INTO @codPrd, @nomPrd
    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT replicate(' ', 5) + cast(@codprd as char(2)) + replicate(' ', 5) + @nomPrd
        FETCH curProd INTO @codPrd, @nomPrd
    END
    CLOSE curProd
    DEALLOCATE curProd
    PRINT replicate('-', 60)
    FETCH curCate INTO @codigo, @nombre
END
CLOSE curCate
DEALLOCATE curCate
GO

