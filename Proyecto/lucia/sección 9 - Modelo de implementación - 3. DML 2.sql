
/*==============================================================*/
 --ABRIR UN NUEVO QUERY DESDE EL NUEVO USUARIO
USE ECORP
GO


/*==============================================================*/
/*==========================TRIGGER==============================*/
	CREATE TRIGGER MODIFICA_SALARIO_EMPLEADOS
ON OPERACIONES.Empleados
	FOR UPDATE
	AS
		if (UPDATE(salario_empleado))
			BEGIN
			DECLARE @SALARIOANT DECIMAL (7,2), @SALARIONUE DECIMAL (7,2)
			SELECT @SALARIOANT=salario_empleado FROM deleted
			SELECT @SALARIONUE=salario_empleado FROM inserted
			
				PRINT 'SE MODIFICO EL SALARIO DE UM EMPLEADO'
				PRINT 'SALARIO ANTIGUO:' + STR(@SALARIOANT,7,2) --- que me diga el salario antiguo
				PRINT 'SALARIO NUEVO:' + STR(@SALARIONUE,7,2)
			END

	GO




/*==============================================================*/
/*===========================VIEWS==============================*/
--CREAR VIEWS

CREATE VIEW PROVEEDORESyPRODUCTOSVIEW AS
SELECT 
dt.id_proveedor_producto AS Proveedor,
dt.nombre_proveedor_producto AS Producto,
dt.descripcion_proveedor_producto AS Descripcion,
dt.precio_proveedor_producto AS Precio,
dt.fecha_actualizacion AS Fecha_actualizacion,
dd.nombre_proveedor AS Nombre_Proveedor,
dd.direccion_proveedor AS Direccion,
dd.telefono_proveedor AS Telefono,
dd.ciudad_proveedor AS Ciudad,
dd.pais_proveedor AS Pais
FROM
PROVEEDORES.Proveedores_Producto dt
JOIN PROVEEDORES.Proveedores dd ON dt.id_proveedor=dd.id_proveedor;


SELECT * FROM PROVEEDORESyPRODUCTOSVIEW
GO



/*==============================================================*/
/*=========================PROCEDURE============================*/
--CREAR PROCEDIMIENTOS PARA INSERTAR REGISTROS.
CREATE PROCEDURE INSERTPROVEEDRORES
(
	@id_proveedor char(7),
    @nombre_proveedor nvarchar(50),
	@direccion_proveedor NVARCHAR(100),
	@telefono_proveedor NVARCHAR(20),
	@ciudad_proveedor NVARCHAR(50),
	@pais_proveedor NVARCHAR(50)
)
AS

BEGIN
    SET NOCOUNT ON;

    INSERT INTO PROVEEDORES.Proveedores (id_proveedor, nombre_proveedor, direccion_proveedor, telefono_proveedor,pais_proveedor, fecha_actualizacion)
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
