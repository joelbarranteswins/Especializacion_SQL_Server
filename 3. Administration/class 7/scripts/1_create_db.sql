CREATE DATABASE SUPERMERCADO;

USE SUPERMERCADO;

CREATE TABLE DISTRITOS(
CODDIS CHAR(4) PRIMARY KEY,
NOMDIS VARCHAR(25) NOT NULL
);

CREATE TABLE CARGOS(
CODCAR CHAR(4) PRIMARY KEY,
NOCAR VARCHAR(30) NOT NULL
);

CREATE TABLE MARCAS(
CODMAR CHAR(4) PRIMARY KEY, 
NOMMAR VARCHAR(30) NOT NULL
);

CREATE TABLE CATEGORIAS(
CODCAT CHAR(4) PRIMARY KEY,
NOMCAT VARCHAR(30) NOT NULL
);

CREATE TABLE FORMA_PAGO(
CODFOR CHAR(4) PRIMARY KEY,
NOMFOR VARCHAR(25) NOT NULL
);

CREATE TABLE LOCALES(
CODLOC CHAR(4) PRIMARY KEY,
NOMLOC VARCHAR(30) NOT NULL,
DIREC VARCHAR(40) NOT NULL,
CODDIS CHAR(4),
TELEF VARCHAR(9) NOT NULL,
EMAIL VARCHAR(30) NOT NULL,
FOREIGN KEY (CODDIS) REFERENCES DISTRITOS(CODDIS)
);



CREATE TABLE CLIENTES(
CODCLI CHAR(4) PRIMARY KEY,
NOMCLI VARCHAR(40) NOT NULL,
DIREC VARCHAR(40) NOT NULL,
CODDIS CHAR(4) REFERENCES DISTRITOS(CODDIS),
FNAC DATE NOT NULL,
SEXO CHAR(1) NOT NULL,
TELEF VARCHAR(9) NOT NULL
);

CREATE TABLE PERSONAL(
CODPER CHAR(4) PRIMARY KEY,
NOMPER VARCHAR(40) NOT NULL,
DIREC VARCHAR(40) NOT NULL,
CODDIS CHAR(4) REFERENCES DISTRITOS(CODDIS),
FNAC  DATE NOT NULL,
SEXO CHAR(1) NOT NULL,
CODCAR CHAR(4) REFERENCES CARGOS(CODCAR),
SUELDO DECIMAL(7,2) NOT NULL
);

CREATE TABLE PRODUCTOS(
CODPROD CHAR(6) PRIMARY KEY,
NOMPROD VARCHAR(40) NOT NULL,
CODMAR CHAR(4) REFERENCES MARCAS(CODMAR),
CODCAT CHAR(4) REFERENCES CATEGORIAS(CODCAT),
PRECIO DECIMAL(7,2) NOT NULL,
STOCK INT NOT NULL
);

CREATE TABLE COMP_CABECERA(
CODCOM CHAR(6) PRIMARY KEY,
CODCLI CHAR(4) REFERENCES CLIENTES(CODCLI),
CODPER CHAR(4) REFERENCES PERSONAL(CODPER),
CODLOC CHAR(4) REFERENCES LOCALES(CODLOC),
CODFOR CHAR(4) REFERENCES FORMA_PAGO(CODFOR),
TIPO_COMP CHAR(1) NOT NULL,
FECHA DATE NOT NULL
);

CREATE TABLE COMP_DETALLE(
CODCOM CHAR(6) REFERENCES COMP_CABECERA(CODCOM),
CODPROD CHAR(6) REFERENCES PRODUCTOS(CODPROD),
CANTIDAD INT NOT NULL,
PRECIO DECIMAL(7,2) NOT NULL,
DCTO DECIMAL(6,2) NOT NULL
);
GO


--TRIGGERS

--EJERCICIO 1
CREATE TRIGGER GRABA_MARCA ON [dbo].[MARCAS]
FOR INSERT
AS
PRINT 'SE GRABO UNA NUEVA MARCA'
GO


--EJERCICIO 2
CREATE TRIGGER MODIFICA_MARCA ON [dbo].[MARCAS]
FOR UPDATE
AS
PRINT 'SE MODIFICO UNA MARCA'

UPDATE MARCAS SET NOMMAR = 'ROSAS Y LIMON' WHERE CODMAR = 'M001'

SELECT * FROM MARCAS
GO

--EJERCICIO 3
--CREA UN TRIGGER QUE IMPRIMA LOS DATOS ANTOGUOS Y NUEVOS CUANDO SE MODIFICA UN DISTRITO
--TABLA INSERTED

CREATE TRIGGER MODIFICA_DISTRITO 
ON [dbo].[DISTRITOS]
    FOR UPDATE
    AS
        DECLARE @COD CHAR(4), @NOM VARCHAR(25)
        SELECT @COD = CODDIS, @NOM = NOMDIS FROM DELETED
        PRINT 'SE MODIFICO EL DISTRITO '
        PRINT 'DATOS ANTIGUOS'
        PRINT '-------------------------------'
        PRINT 'CODIGO    :' + @COD
        PRINT 'NOMBRE    :' + @NOM

        SELECT @COD=CODDIS, @NOM=NOMDIS FROM INSERTED
        PRINT 'DATOS NUEVOS'
        PRINT '-------------------------------'
        PRINT 'CODIGO    :' + @COD
        PRINT 'NOMBRE    :' + @NOM
GO

INSERT INTO DISTRITOS VALUES('D001', 'SAN JUAN DE LURIGANCHO')
GO

SELECT * FROM DISTRITOS

UPDATE DISTRITOS SET NOMDIS = 'SAN JUAN' WHERE CODDIS = 'D001'
GO

--EJERCICIO 4
CREATE TRIGGER MODIFICA_PRECIO
ON [dbo].[PRODUCTOS]
    FOR UPDATE
    AS
        DECLARE @PREANT DECIMAL(7,2), @PRECNUE DECIMAL(7,2)
        SELECT @PREANT = PRECIO FROM DELETED   
        SELECT @PRECNUE = PRECIO FROM INSERTED
        IF @PREANT <> @PRECNUE
        BEGIN
            PRINT 'SE MODIFICO EL PRECIO DE UN PRODUCTO'
            PRINT 'PRECIO ANTIGUO: ' + STR(@PREANT AS VARCHAR(10))
            PRINT 'PRECIO NUEVO: ' + STR(@PRECNUE AS VARCHAR(10))
        END
GO
--EJEMPLO 5
-- CREAR UN TRIGGER QUE IMPRIMA EL DATO ANTIGUO Y NUEVO CUANDO SE MODIFIQUE EL TELEFONO DE UN CLIENTE
CREATE TRIGGER MODIFICA_TELEFONO
ON [dbo].[CLIENTES]
FOR UPDATE
AS
    DECLARE @TELEFANT VARCHAR(9), @TELEFNUE VARCHAR(9)
    SELECT @TELEFANT = TELEF FROM DELETED
    SELECT @TELEFNUE = TELEF FROM INSERTED
    IF @TELEFANT <> @TELEFNUE
    BEGIN
        PRINT 'SE MODIFICO EL TELEFONO DE UN CLIENTE'
        PRINT 'TELEFONO ANTIGUO: ' + @TELEFANT
        PRINT 'TELEFONO NUEVO: ' + @TELEFNUE
    END
GO


--EJEMPLO 6
--CREAR UN TRIGGER QUE NO ME PERMITA MODIFICAR EL SUELDO DE UN PERSONAL
CREATE TRIGGER MODIFICAR_SUELDO
ON [dbo].[PERSONAL]
FOR UPDATE
    AS
    IF(UPDATE([SUELDO]))
    BEGIN
        ROLLBACK
        PRINT 'NO SE PUEDE MODIFICAR EL SUELDO'
    END
GO

--EJEMPLO 7
CERATE TRIGGER ELIMINA_MARCA
ON [dbo].[MARCAS]
    FOR DELETE
    AS 
    IF((SELECT COUNT(CODMAR) FROM DELETED) > 1)
    BEGIN
        ROLLBACK
        PRINT 'NO SE PUEDE ELIMINAR MAS DE UNA MARCA'
    END 

