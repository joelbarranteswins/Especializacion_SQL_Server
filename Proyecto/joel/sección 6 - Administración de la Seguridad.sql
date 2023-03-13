
/*==============================================================*/
/*================ADMINISTRACIÓN DE SEGURIDAD===================*/


/*================MODOS DE AUTENTICIDAD===================*/

/* 
En el caso de SQL Server, los modos de autenticación se refieren a los diferentes 
métodos que se pueden utilizar para autenticar a los usuarios que intentan acceder 
a la base de datos. Los modos de autenticación disponibles en SQL Server son:

Autenticación de Windows: En este modo de autenticación, los usuarios se autentican 
utilizando sus credenciales de inicio de sesión de Windows. Este modo es el más seguro 
y recomendado, ya que utiliza la infraestructura de seguridad de Windows.

Autenticación de SQL Server: En este modo de autenticación, los usuarios se autentican 
utilizando un nombre de usuario y una contraseña específicos de SQL Server. Este modo 
es menos seguro que la autenticación de Windows, ya que las credenciales se transmiten 
en texto plano y pueden ser interceptadas.
*/


/*================CREACIÓN DE USUARIOS===================*/

USE ECORP
GO

--CREAREMOS UN NUEVO USUARIO
CREATE LOGIN MANAGERSELLER WITH PASSWORD='t2j8X6$k'
GO


/*================USO DE CREDENCIALES Y PERMISOS===================*/
--AGREGAR AL USER COMO ADMINISTRADOR
SP_ADDUSER [MANAGERSELLER], ADMINISTRADOR
GO

--DAR PERMISOS DE DML A UN USUARIO
GRANT SELECT, INSERT, UPDATE, DELETE ON VENTAS.Clientes TO ADMINISTRADOR
GRANT SELECT, INSERT, UPDATE, DELETE ON VENTAS.Pedidos TO ADMINISTRADOR
GRANT SELECT, INSERT, UPDATE, DELETE ON VENTAS.Detalles_Pedido TO ADMINISTRADOR
GRANT SELECT, INSERT, UPDATE, DELETE ON VENTAS.Facturas TO ADMINISTRADOR
GRANT SELECT, INSERT, UPDATE, DELETE ON VENTAS.Recibos TO ADMINISTRADOR

-- DENEGAR PERMISOS
REVOKE SELECT, INSERT, UPDATE, DELETE ON VENTAS.Clientes TO ADMINISTRADOR
REVOKE SELECT, INSERT, UPDATE, DELETE ON VENTAS.Pedidos TO 	ADMINISTRADOR
REVOKE SELECT, INSERT, UPDATE, DELETE ON VENTAS.Detalles_Pedido TO ADMINISTRADOR
REVOKE SELECT, INSERT, UPDATE, DELETE ON VENTAS.Facturas TO ADMINISTRADOR
REVOKE SELECT, INSERT, UPDATE, DELETE ON VENTAS.Recibos TO ADMINISTRADOR


--OTORGAR PERMISOS PARA EL USUARIO , VISTAS , FUNCIONES , PROCEDIMIENTO ALMACENADO 

GRANT CREATE TABLE, CREATE FUNCTION, CREATE PROCEDURE, CREATE VIEW, EXECUTE TO ADMINISTRADOR

--DENEGAR PERMISOS PARA EL USUARIO , VISTAS , FUNCIONES , PROCEDIMIENTO ALMACENADO

REVOKE CREATE TABLE, CREATE FUNCTION, CREATE PROCEDURE, CREATE VIEW, EXECUTE TO ADMINISTRADOR
GO

/*================ROLES DE SERVIDOR===================*/


/*SYSADMIN*/
/* Este es el rol de servidor más alto en SQL Server y permite a los usuarios realizar 
cualquier tarea en el servidor, incluyendo la creación de bases de datos, la 
configuración de seguridad y el mantenimiento de la instancia.*/


--AGREGAR AL NUEVO USUARIO COMO SYSADMIN

SP_ADDSRVROLEMEMBER MANAGERSELLER,[sysadmin]
GO

--QUITAR AL NUEVO USUARIO COMO SYSADMIN

SP_DROPSRVROLEMEMBER [MANAGERSELLER],[sysadmin]
GO


/*SERVERADMIN*/
/*
Este rol permite a los usuarios administrar la seguridad 
en SQL Server, como la creación de usuarios y roles, la configuración de 
permisos y la administración de claves de cifrado.
*/

--AGREGAR AL NUEVO USUARIO COMO SERVERADMIN
SP_ADDSRVROLEMEMBER [MANAGERSELLER],[serveradmin]
GO

--QUITAR AL NUEVO USUARIO COMO SERVERADMIN
SP_DROPSRVROLEMEMBER [MANAGERSELLER],[serveradmin]
GO

/*SEPUPADMIN*/
/* Este rol permite a los usuarios instalar y configurar SQL Server en el servidor.*/

--AGREGAR AL NUEVO USUARIO COMO SEPUPADMIN
SP_ADDSRVROLEMEMBER [MANAGERSELLER],[setupadmin]
GO

--QUITAR AL NUEVO USUARIO COMO SEPUPADMIN
SP_DROPSRVROLEMEMBER [MANAGERSELLER],[setupadmin]
GO


/*SECURITYADMIN*/
/* 
Este rol permite a los usuarios administrar la configuración 
del servidor, como la configuración de memoria, la configuración de red y 
la configuración del servidor de correo electrónico.
*/

SP_ADDSRVROLEMEMBER [MANAGERSELLER],[securityadmin]
GO

SP_DROPSRVROLEMEMBER [MANAGERSELLER],[securityadmin]
GO

/*PROCESSADMIN*/
/* 
Este rol permite a los usuarios administrar los procesos en SQL Server, 
como la detención y reinicio de servicios y la administración de trabajos.
*/
-- AGREGAR AL NUEVO USUARIO COMO PROCESSADMIN
SP_ADDSRVROLEMEMBER [MANAGERSELLER],[processadmin]
GO

-- QUITAR AL NUEVO USUARIO COMO PROCESSADMIN

SP_DROPSRVROLEMEMBER [MANAGERSELLER],[processadmin]
GO

/*DBCREATOR*/
/* Este rol permite a los usuarios crear bases de datos en SQL Server */
-- AGREGAR AL NUEVO USUARIO COMO DBCREATOR
SP_ADDSRVROLEMEMBER [MANAGERSELLER],[dbcreator]
GO

-- QUITAR AL NUEVO USUARIO COMO DBCREATOR
SP_DROPSRVROLEMEMBER [MANAGERSELLER],[dbcreator]
GO


/*BULKADMIN*/
/* Este rol permite a los usuarios realizar operaciones de importación y 
exportación masiva de datos en SQL Server. */

-- AGREGAR AL NUEVO USUARIO COMO BULKADMIN
SP_ADDSRVROLEMEMBER [MANAGERSELLER],[bulkadmin]
GO

-- QUITAR AL NUEVO USUARIO COMO BULKADMIN
SP_DROPSRVROLEMEMBER [MANAGERSELLER],[bulkadmin]
GO

/*DB_OWNER*/

-- AGREGAR AL NUEVO USUARIO COMO DB_OWNER
SP_ADDSRVROLEMEMBER [MANAGERSELLER],[db_owner]
GO

-- QUITAR AL NUEVO USUARIO COMO DB_OWNER
SP_DROPSRVROLEMEMBER [MANAGERSELLER],[db_owner]
GO

/*DB_DATAREADER*/
/* Este rol permite a los usuarios leer datos de las tablas de una base de datos. */
-- AGREGAR AL NUEVO USUARIO COMO DB_DATAREADER
SP_ADDSRVROLEMEMBER [MANAGERSELLER],[db_datareader]
GO

-- QUITAR AL NUEVO USUARIO COMO DB_DATAREADER
SP_DROPSRVROLEMEMBER [MANAGERSELLER],[db_datareader]
GO




/*================BENEFICIOS DE AUTOMATIZACIÓN===================*/

/*
La automatización en la administración de seguridad de SQL Server tiene varios
beneficios, entre los que se incluyen:

Ahorro de tiempo: La automatización de tareas de seguridad repetitivas, como 
la creación de usuarios y la asignación de permisos, puede ahorrar tiempo y 
recursos valiosos. Esto permite que el personal de seguridad se concentre en 
tareas más críticas y estratégicas.

Mayor precisión: La automatización de tareas de seguridad elimina la posibilidad 
de errores humanos, lo que aumenta la precisión de la administración de seguridad. 
Esto reduce el riesgo de acceso no autorizado y otros problemas de seguridad 
relacionados con errores de configuración.

Cumplimiento normativo: La automatización de la administración de seguridad puede 
ayudar a garantizar que se cumplan los requisitos normativos y legales, como los 
estándares de seguridad de la industria y las regulaciones gubernamentales. Esto 
puede evitar sanciones, multas y daños a la reputación de la organización.

Escalabilidad: La automatización de la administración de seguridad es escalable, 
lo que significa que puede adaptarse fácilmente a las necesidades de la organización 
a medida que esta crece y evoluciona. Esto permite que la administración de seguridad 
siga siendo efectiva y eficiente a medida que se agregan nuevos usuarios y se expande 
la infraestructura de la base de datos.

Mejora de la gestión de riesgos: La automatización de la administración de seguridad 
puede ayudar a identificar y mitigar riesgos de seguridad más rápidamente, lo que 
permite una respuesta más rápida y efectiva a los problemas de seguridad.

*/