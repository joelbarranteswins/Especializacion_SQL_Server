/*==============================================================*/
/*================MODOS DE TRANSFERENCIA DE DATOS================*/
USE ECORP
GO

--CREAMOS UNA NUEVA TABLA LLAMADA Tabla_Pedidos_Febrero
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
INTO VENTAS.Tabla_Pedidos_Clientes
FROM
VENTAS.Pedidos p
JOIN VENTAS.Clientes c ON p.id_cliente = c.id_cliente
JOIN VENTAS.Detalles_Pedido dp ON p.id_pedido = dp.id_pedido
JOIN VENTAS.Facturas f ON p.id_pedido = f.id_pedido
JOIN VENTAS.Recibos r ON p.id_pedido = r.id_pedido
GO

SELECT * FROM  ECORP.VENTAS.Tabla_Pedidos_Clientes
GO

--EJECUTAREMOS EL SIGUIENTE CODIGO EN LA TERMINAL USANDO EL CLI BCP
--BCP ECORP.VENTAS.Tabla_Pedidos_Clientes OUT C:\database\Tabla_Pedidos_Clientes.TXT -S . -T -c

--HACIENDO UNA CONSULTA Y GUARDANDO EL RESULTADO EN UN ARCHIVO DE TEXTO
/*
BCP "SELECT * FROM ECORP.VENTAS.Tabla_Pedidos_Clientes p WHERE MONTH(p.fecha_pedido) = 1" QUERYOUT C:\database\Tabla_Pedidos_Clientes_Enero.TXT -S . -T -c
 */


