
/*==============================================================*/
 --ABRIR UN NUEVO QUERY DESDE EL NUEVO USUARIO
USE ECORP
GO


/*==============================================================*/
/*==========================TRIGGER==============================*/
--CREAR UN TRIGGER PARA ACTUALIZAR LA FECHA DE ACTUALIZACION DE LA TABLA CLIENTES
CREATE TABLE VENTAS.Clientes_Auditoria (
  nro_registro int IDENTITY,
  id_cliente char(4),
  tipo_cliente varchar(20) NOT NULL,
  nombre_cliente varchar(100) NOT NULL,
  direccion_cliente varchar(200) NOT NULL,
  telefono_cliente varchar(15) NOT NULL,
  fecha_actualizacion DATETIME NOT NULL,
  accion varchar(15) NOT NULL,
);
GO

CREATE TRIGGER Ventas_Auditoria
ON VENTAS.Clientes
AFTER INSERT, UPDATE, DELETE
AS
	BEGIN
		DECLARE @fecha DATETIME = GETDATE();
		IF EXISTS(SELECT * FROM inserted)
			BEGIN
				IF EXISTS(SELECT * FROM deleted)
					BEGIN
						INSERT INTO VENTAS.Clientes_Auditoria
						SELECT d.id_cliente, d.tipo_cliente, d.nombre_cliente, d.direccion_cliente, d.telefono_cliente, @fecha, 'update'
						FROM deleted d
						INNER JOIN inserted i ON d.id_cliente = i.id_cliente;
						PRINT 'Se ha realizado una actualizaci�n exitosa en la tabla de auditor�a';
					END
				ELSE
					BEGIN
						INSERT INTO VENTAS.Clientes_Auditoria
						SELECT i.id_cliente, i.tipo_cliente, i.nombre_cliente, i.direccion_cliente, i.telefono_cliente, @fecha, 'insert'
						FROM inserted i;
						PRINT 'Se ha realizado una inserci�n exitosa en la tabla de auditor�a';
					END
			END
		ELSE
			BEGIN
				INSERT INTO VENTAS.Clientes_Auditoria
				SELECT d.id_cliente, d.tipo_cliente, d.nombre_cliente, d.direccion_cliente, d.telefono_cliente, @fecha, 'delete'
				FROM deleted d;
				PRINT 'Se ha realizado una eliminaci�n exitosa en la tabla de auditor�a';
			END
	END;
GO

--ELIMINAR TRIGGER
DROP TRIGGER Ventas_Auditoria


--USAR EL TRIGGER PARA INSERTAR UN REGISTRO
INSERT INTO VENTAS.Clientes
VALUES 
('C020', 'Persona Natural', 'John vargas', 'Calle 123', '987876765', GETDATE(), GETDATE());

--USAR EL TRIGGER PARA ACTUALIZAR UN REGISTRO
UPDATE VENTAS.Clientes
SET nombre_cliente = 'John perez'
WHERE id_cliente = 'C020';


--USAR EL TRIGGER PARA ELIMINAR UN REGISTRO
DELETE FROM VENTAS.Clientes
WHERE id_cliente = 'C020';


--VERIFICAR LA EJECUCION DE ACTUALIZAR, ELIMINADO O INSERTADO DE UN REGISTRO
SELECT * FROM VENTAS.Clientes;
SELECT * FROM VENTAS.Clientes_Auditoria;
GO

/*==============================================================*/
/*===========================VIEWS==============================*/
--CREAR VIEWS
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



/*==============================================================*/
/*=========================PROCEDURE============================*/
--CREAR PROCEDIMIENTOS PARA INSERTAR REGISTROS.
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



/*==============================================================*/
/*==========================CURSOR==============================*/
--CREANDO CURSORES:

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



/*==============================================================*/
/*=========================STORE PROCEDURE======================*/
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



/*==============================================================*/
/*=========================FUNCTION=============================*/
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
