/*==============================================================*/
/*===================CARGA MASIVA DE DATOS======================*/


--EJECUTAREMOS EL SIGUIENTE CODIGO EN LA TERMINAL USANDO EL CLI BCP
--BCP ECORP.VENTAS.Tabla_Pedidos_Clientes IN C:\database\Tabla_Pedidos_Clientes.TXT -S . -T -c


--CARGANDO DATOS MASICOS CON SENTECIA SQL
USE ECORP
GO

SELECT * FROM ECORP.VENTAS.Tabla_Pedidos_Clientes

--ELIMINA LOS REGISTROS
TRUNCATE TABLE ECORP.VENTAS.Tabla_Pedidos_Clientes


--CARGA LOS DATOS
BULK INSERT ECORP.VENTAS.Tabla_Pedidos_Clientes
FROM 'C:\database\Tabla_Pedidos_Clientes.TXT'