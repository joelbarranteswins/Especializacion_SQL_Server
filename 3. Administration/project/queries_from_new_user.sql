		 
 --ABRIR UN NEW QUERY DESDE EL NUEVO USUARIO
USE ECORP
GO

---------------------------------------------------------
---------------------------------------------------------
--TESTEANDO LOS PERMISOS DE SELECT, INSERT, UPDATE, DELETE

SELECT * FROM VENTAS.Clientes
GO

SELECT * FROM VENTAS.Facturas;
GO

SELECT * FROM VENTAS.Pedidos;
GO

SELECT * FROM VENTAS.Recibos;
GO


INSERT INTO VENTAS.Clientes (id_cliente, tipo_cliente, nombre_cliente, direccion_cliente, telefono_cliente, fecha_actualizacion)
VALUES 
('C016', 'Persona Natural', 'Ana Rodríguez', 'Av. Los Incas 205 ', '986132413', GETDATE());
GO

UPDATE VENTAS.Clientes SET nombre_cliente = 'Carlos Alcantara' WHERE id_cliente = 'C016';
GO

DELETE FROM VENTAS.Clientes WHERE id_cliente = 'C016';
GO
 

---------------------------------------------------------
---------------------------------------------------------
--TESTEANDO LOS PERMISOS VISTA QUE MUESTRA IMPLEMENTACION
CREATE VIEW VENTASVIEW AS
SELECT
p.id_pedido AS Pedido,
p.fecha_pedido AS Fecha_Pedido,
c.nombre_cliente AS Cliente,
c.direccion_cliente AS Direccion,
c.telefono_cliente AS Telefono,
dp.id_producto AS Producto,
dp.cantidad AS Cantidad,
f.fecha_factura AS Fecha_Factura,
r.fecha_recibo AS Fecha_Recibo
FROM
VENTAS.Pedidos p
JOIN VENTAS.Clientes c ON p.id_cliente = c.id_cliente
JOIN VENTAS.Detalles_Pedido dp ON p.id_pedido = dp.id_pedido
JOIN VENTAS.Facturas f ON p.id_pedido = f.id_pedido
JOIN VENTAS.Recibos r ON p.id_pedido = r.id_pedido;
GO


SELECT * FROM VENTASVIEW
GO

--BORRA UN VIEW
--DROP VIEW DATALECTOR



---------------------------------------------------------
---------------------------------------------------------
--TESTEANDO PROCEDIMIENTOS PARA INSERTAR REGISTROS.
CREATE PROCEDURE INSERTCLIENTES
(
	@id_cliente char(4),
    @tipo_cliente varchar(20),
    @nombre_cliente varchar(100),
    @direccion_cliente varchar(200),
    @telefono_cliente varchar(15)
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO VENTAS.Clientes (id_cliente ,tipo_cliente, nombre_cliente, direccion_cliente, telefono_cliente, fecha_actualizacion)
    VALUES (@id_cliente, @tipo_cliente, @nombre_cliente, @direccion_cliente, @telefono_cliente, GETDATE());
END


--EJECUTAR EL PROCEDIMIENTO
EXEC INSERTCLIENTES 
'C020', 'Persona Natural', 'John vargas', 'Calle 123', '987876765'
GO

-- BORRAR PROCEDURE
DROP PROCEDURE INSERTCLIENTES
GO

--CREATE PROCEDURE TO DELETE A RECORD
CREATE PROCEDURE DELETECLIENTES
(
	@id_cliente char(4)
)
AS
BEGIN
	SET NOCOUNT ON;
	DELETE FROM VENTAS.Clientes
	WHERE id_cliente = @id_cliente;
END
GO


DELETE FROM VENTAS.Clientes
WHERE id_cliente = 'C020'

-- BORRAR PROCEDURE
DROP PROCEDURE DELETECLIENTES

---------------------------------------------------------
---------------------------------------------------------
--TESTEANDO CREACION DE UNA TB HISTORIAL BD BIBLIOTECA

CREATE TABLE CLIENTES_DEUDORES
(
	id_cliente char(4) PRIMARY KEY CHECK(id_cliente LIKE'Rec[0-9][0-9][0-9]'),
	nombre_cliente varchar(100) NOT NULL,
	direccion_cliente varchar(200) NOT NULL,
	telefono_cliente varchar(15) NOT NULL,
	fecha_actualizacion datetime NOT NULL,
	fecha_deuda datetime NOT NULL,
	monto_deuda decimal(10,2) NOT NULL,
	
)
GO

SELECT * FROM CLIENTES_DEUDORES
GO

---------------------------------------------------------
------------------------------------------------------
--TESTEANDO CURSORES:

--DECLARACION
DECLARE LEERCLIENTES SCROLL CURSOR FOR SELECT * FROM VENTAS.Clientes

--ABRIR EL CURSOS
OPEN LEERCLIENTES

--SENTENCIAS QUE NOS PERMITEN MOVER ENTRE LOS REGISTROS
FETCH NEXT FROM LEERCLIENTES
FETCH PRIOR FROM LEERCLIENTES
FETCH FIRST FROM LEERCLIENTES
FETCH LAST FROM LEERCLIENTES

-- PARA DEJAR DE UTILIZAR EL CURSOR, LO CERRAMOS
CLOSE LEERCLIENTES
GO

DEALLOCATE LEERCLIENTES
GO

---------------------------------------------------------
---------------------------------------------------------
--CREAR UN PROCEDIMIENTO ALMACENADO DE MUESTREO DE DATOS:
CREATE PROCEDURE CURSORCLIENTE
AS
DECLARE 
	@ID_CLIENTE CHAR(4),
	@TIPO_CLIENTE VARCHAR(20),
	@NOMBRE_CLIENTE VARCHAR(100),
	@DIRECCION_CLIENTE VARCHAR(200),
	@TELEFONO_CLIENTE VARCHAR(15),
	@FECHA_CREACION DATETIME, 
	@FECHA_ACTUALIZACION DATETIME
DECLARE LEER CURSOR FOR SELECT 
id_cliente, tipo_cliente, nombre_cliente, direccion_cliente, telefono_cliente, fecha_creacion, fecha_actualizacion
FROM VENTAS.Clientes
OPEN LEER
FETCH NEXT FROM LEER INTO @ID_CLIENTE, @TIPO_CLIENTE, @NOMBRE_CLIENTE, @DIRECCION_CLIENTE, @TELEFONO_CLIENTE, @FECHA_CREACION, @FECHA_ACTUALIZACION
WHILE @@FETCH_STATUS=0
				BEGIN
	PRINT CONVERT(CHAR(4),@ID_CLIENTE)+SPACE(3)+CONVERT(CHAR(20),@TIPO_CLIENTE)+SPACE(3)+CONVERT(CHAR(100),@NOMBRE_CLIENTE)+SPACE(3)+CONVERT(CHAR(200),@DIRECCION_CLIENTE)+SPACE(3)+CONVERT(CHAR(15),@TELEFONO_CLIENTE)+SPACE(3)+CONVERT(CHAR(23),@FECHA_CREACION)+SPACE(3)+CONVERT(CHAR(23),@FECHA_ACTUALIZACION)
	PRINT REPLICATE('-',60)
	FETCH NEXT FROM LEER INTO @ID_CLIENTE, @TIPO_CLIENTE, @NOMBRE_CLIENTE, @DIRECCION_CLIENTE, @TELEFONO_CLIENTE, @FECHA_CREACION, @FECHA_ACTUALIZACION
END
CLOSE LEER
DEALLOCATE LEER
GO

--EJECUTAR EL PROCEDIMIENTO ALMACENADO
EXECUTE CURSORCLIENTE
GO

--BORRAR EL PROCEDIMIENTO ALMACENADO
DROP PROCEDURE CURSORCLIENTE
GO

---------------------------------------------------------
-------------------------------------------------------------------
--CREAR UNA FUNCION QUE RETORNA LA TABLA PEDIDOS POR CLIENTE
CREATE FUNCTION PEDIDOS_POR_CLIENTE
(
	@id_cliente char(4)
)
RETURNS TABLE
AS
RETURN(
	SELECT P.*, C.nombre_cliente, C.direccion_cliente 
	FROM VENTAS.Pedidos P 
	INNER JOIN VENTAS.Clientes C ON P.id_cliente = C.id_cliente 
	WHERE C.id_cliente = @id_cliente
)
GO



--EJECUTAR LA FUNCION
SELECT * FROM PEDIDOS_POR_CLIENTE('C001')
SELECT * FROM PEDIDOS_POR_CLIENTE('C002')
