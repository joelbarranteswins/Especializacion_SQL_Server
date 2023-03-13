
/*==============================================================*/
/*==================ADMINISTRACION DE SEGURIDAD======================*/

-- a. Modos de autenticidad



-- b. Creación de Usuarios

USE ECORP

CREATE LOGIN ECORP_AREA_DE_OPERACIONES WITH PASSWORD='12345'


-- c. Uso de credenciales y permisos

-- d. Roles del servidor

SP_ADDSRVROLEMEMBER ECORP,[sysadmin]

-- QUITAR RS SYSADMIN
SP_DROPSRVROLEMEMBER ECORP, [sysadmin]
GO
-- AGREGAR RS DBCREATOR, PARA CREAR UNA BD
SP_ADDSRVROLEMEMBER ECORP.[dbcreator]
GO
SP_DROPSRVROLEMEMBER ECORP,[dbcreator]
GO

-- AGREGAR RS SCURITYADMIN, CREAR UN LOGIN 
SP_ADDSRVROLEMEMBER ECORP,[securityadmin]
GO

SP_DROPSRVROLEMEMBER ECORP, [securityadmin]


-- e. Beneficios de la automatización



