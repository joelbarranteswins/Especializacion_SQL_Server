
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

    INSERT INTO PROVEEDORES.Proveedores (id_proveedor, nombre_proveedor, direccion_proveedor, telefono_proveedor,ciudad_proveedor,pais_proveedor, fecha_actualizacion)
    VALUES (@id_proveedor, @nombre_proveedor, @direccion_proveedor, @telefono_proveedor, @ciudad_proveedor, @pais_proveedor, GETDATE());
END


--EJECUTAR EL PROCEDIMIENTO
EXEC INSERTCLIENTES 
'Prov001', 'La Vaquita Mu', 'Av. Canadá 3359 - La Victoria', '970428484', 'Lima', 'Perú', GETDATE()),
GO

-- BORRAR PROCEDURE
DROP PROCEDURE INSERTPROVEEDORES
GO


/*==============================================================*/
/*==========================CURSOR==============================*/
--CREANDO CURSORES:
--REPETIR CURSORES PARA "PROVEEDORES":

DECLARE LEERPROD_PROVEEDOR SCROLL CURSOR FOR SELECT * FROM PROVEEDORES.Proveedores_Producto

OPEN LEERPROD_PROVEEDOR

FETCH NEXT FROM LEERPROD_PROVEEDOR
FETCH PRIOR FROM LEERPROD_PROVEEDOR
FETCH FIRST FROM LEERPROD_PROVEEDOR
FETCH LAST FROM LEERPROD_PROVEEDOR

CLOSE LEERPROD_PROVEEDOR

DEALLOCATE LEERPROD_PROVEEDOR


/*==============================================================*/
/*=========================FUNCTION=============================*/
--CREAR UNA FUNCION QUE RETORNA LA TABLA PEDIDOS POR CLIENTE
CREATE FUNCTION PRODUCTOS_POR_PROVEEDOR(@id_proveedor char(7)) RETURNS
TABLE
AS
RETURN(SELECT d.nombre_proveedor as NombreProveedor, dt.id_proveedor_producto AS idProducto, dt.nombre_proveedor_producto AS Producto,
dt.precio_proveedor_producto AS Precio
FROM PROVEEDORES.Proveedores d, PROVEEDORES.Proveedores_Producto dt WHERE d.id_proveedor=dt.id_proveedor AND d.id_proveedor=@id_proveedor)
GO

--EJECUTAR LA FUNCION 'PRODUCTOS POR PROVEEDOR'
SELECT * FROM PRODUCTOS_POR_PROVEEDOR('prov001')
SELECT * FROM PRODUCTOS_POR_PROVEEDOR('prov002')
GO
GO



--EJECUTAR LA FUNCION
SELECT * FROM PEDIDOS_POR_CLIENTE('C001')
SELECT * FROM PEDIDOS_POR_CLIENTE('C002')
