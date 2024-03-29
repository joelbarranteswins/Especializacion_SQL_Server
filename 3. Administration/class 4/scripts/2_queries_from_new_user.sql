		 
 --ABRIR UN NEW QUERY DESDE EL NUEVO USUARIO

use BIBLIOTECA

----------------------------------
--TESTEANDO LOS PERMISOS DE INSERT
select * from autores

INSERT INTO AUTORES(COD_AUT,NOM_AUT,DES_AUT)VALUES
('A001','CESAR VALLEJO','')

SELECT * FROM cargos
INSERT INTO CARGOS VALUES('C001','GERENTE','')

SELECT * FROM categorias
SELECT * FROM DISTRITOS

INSERT INTO DISTRITOS VALUES('D001','SAN MIGUEL','')

--TESTEANDO LOS PERMISOS DE UPDATE
UPDATE DISTRITOS SET NOM_DIS='SAN ISIDRO' WHERE COD_DIS='D001'
INSERT INTO DISTRITOS VALUES('D002','SAN LUIS','')


--TESTEANDO LOS PERMISOS DE DELETE
DELETE FROM DISTRITOS WHERE COD_DIS='D002'
DELETE FROM DISTRITOS WHERE COD_DIS='D001'

SELECT * FROM lectores
SELECT * FROM libros
SELECT * FROM personal
SELECT * FROM prestamos
SELECT * FROM tipos
SELECT * FROM ubicacion


-- INSERTANDO DATOS A DISTRITOS, TIPOS Y LECTORES
INSERT INTO DISTRITOS (COD_DIS, NOM_DIS, DES_DIS) VALUES
('D001', 'Distrito 1', 'Descripción del distrito 1'),
('D002', 'Distrito 2', 'Descripción del distrito 2'),
('D003', 'Distrito 3', 'Descripción del distrito 3');

INSERT INTO TIPOS (COD_TIP, NOM_TIP, DES_TIP) VALUES
('T001', 'Tipo 1', 'Descripción del tipo 1'),
('T002', 'Tipo 2', 'Descripción del tipo 2'),
('T003', 'Tipo 3', 'Descripción del tipo 3');

INSERT INTO LECTORES (COD_LEC, NOM_LEC, DIR_LEC, DIS_LEC, TIP_LEC, FRE_LEC, EST_LEC, TEL_LEC, OBS_LEC) VALUES
('L001', 'Lector 1', 'Dirección del lector 1', 'D001', 'T001', GETDATE(), 1, '12345678', NULL),
('L002', 'Lector 2', 'Dirección del lector 2', 'D002', 'T002', GETDATE(), 0, '23456789', 'Observaciones del lector 2'),
('L003', 'Lector 3', 'Dirección del lector 3', 'D003', 'T003', GETDATE(), 1, '34567890', NULL);


---------------------------------------------------------
--TESTEANDO LOS PERMISOS VISTA QUE MUESTRA IMPLEMENTACION
CREATE VIEW DATALECTOR
AS
SELECT LECTORES.COD_LEC AS CODIGO,
LECTORES.NOM_LEC AS LECTOR,
LECTORES.DIR_LEC AS DIRECCION,
DISTRITOS.NOM_DIS AS DISTRITO,
TIPOS.NOM_TIP AS TIPO,
LECTORES.FRE_LEC AS REGISTO,
LECTORES.EST_LEC AS ESTADO,
LECTORES.TEL_LEC AS TELEFONO,
LECTORES.OBS_LEC AS OBSERVACION
FROM LECTORES,DISTRITOS,TIPOS WHERE DISTRITOS.COD_DIS=LECTORES.DIS_LEC AND
TIPOS.COD_TIP=LECTORES.TIP_LEC
GO

--BORRA UN VIEW
--DROP VIEW DATALECTOR

SELECT * FROM DATALECTOR
GO


--------------------------------------------------
--TESTEANDO PROCEDIMIENTOS PARA INSERTAR REGISTROS.

CREATE PROCEDURE INADIS @A CHAR(4),@B VARCHAR(30),@C VARCHAR(50)
AS
INSERT INTO DISTRITOS(COD_DIS,NOM_DIS,DES_DIS)VALUES(@A,@B,@C)
GO


INADIS 'D004','ATE',''
GO
INADIS 'D005','OLIVOS',''
GO
INADIS 'D006','VMT',''
GO
INADIS 'D007','VIA SALVADOR',''
GO
INADIS 'D008','san luis',''
GO

--EJEMPLO B TIPOS

CREATE PROC INATIP @A CHAR(4),@B VARCHAR(30),@C VARCHAR(50)
AS
INSERT INTO TIPOS(COD_TIP,NOM_TIP,DES_TIP)VALUES(@A,@B,@C)
GO


INATIP 'T004','FRECUENTE',''
GO
INATIP 'T005','NUNCA',''
GO




--------------------------------------------
--TESTEANDO CREACION DE UNA TB HISTORIAL BD BIBLIOTECA

CREATE TABLE HISTORIAL(
NRO_HIS INT PRIMARY KEY IDENTITY(1,1),
FEC_HIS DATETIME DEFAULT GETDATE(),
OPE_HIS VARCHAR(30)NOT NULL,
DES_HIS VARCHAR(50)NOT NULL
)
GO

SELECT * FROM HISTORIAL


------------------------------------------------------
--TESTEANDO CURSORES:

--DECLARACION
DECLARE LEERDISTRITO SCROLL CURSOR FOR SELECT * FROM DISTRITOS

--ABRIR EL CURSOS
OPEN LEERDISTRITO

--SENTENCIAS QUE NOS PERMITEN MOVER ENTRE LOS REGISTROS
FETCH NEXT FROM LEERDISTRITO
FETCH PRIOR FROM LEERDISTRITO
FETCH FIRST FROM LEERDISTRITO
FETCH LAST FROM LEERDISTRITO

-- PARA DEJAR DE UTILIZAR EL CURSOR, LO CERRAMOS
CLOSE LEERDISTRITO

DEALLOCATE LEERDISTRITO



---------------------------------------------------------
--CREAR UN PROCEDIMIENTO ALMACENADO DE MUESTREO DE DATOS:

CREATE PROCEDURE CURSORDISTRITO
AS
	DECLARE @COD CHAR(4),@NOM VARCHAR(30),@DES VARCHAR(50)
	DECLARE LEER CURSOR FOR SELECT COD_DIS,NOM_DIS,DES_DIS FROM DISTRITOS
	OPEN LEER
	FETCH NEXT FROM LEER INTO @COD,@NOM,@DES --ABRE EL CURSOR Y SETTEA LOS VALORES EN LAS VARIABLES
		WHILE @@FETCH_STATUS=0	  
		--@@FETCH_STATUS es una variable del sistema que se actualiza automáticamente, 
		-- @@FETCH_STATUS = 0 SI HAY MAS FILAS EN EL CURSOR, @@FETCH_STATUS = 1 YA NO HAY MAS FILAS  
			BEGIN
				PRINT CONVERT(CHAR(4),@COD)+SPACE(5)+CONVERT(CHAR(30),@NOM)+SPACE(5)+@DES
				FETCH NEXT FROM LEER INTO @COD,@NOM,@DES
			END
	CLOSE LEER
	DEALLOCATE LEER
GO


EXECUTE CURSORDISTRITO


--ELIMINAR UN PROCEDURE
--DROP PROCEDURE CURSORDISTRITO



--ALTERAR PROCEDIMIENTO ALMACENADO
GO
ALTER PROCEDURE CURSORDISTRITO
AS
	-- Se declaran las variables para almacenar temporalmente la información de los distritos
	DECLARE @COD CHAR(4),@NOM VARCHAR(30),@DES VARCHAR(50)
	DECLARE LEER CURSOR FOR SELECT COD_DIS,NOM_DIS,DES_DIS FROM DISTRITOS --SE CREA UN CURSOR
	OPEN LEER
		-- Se lee la primera fila del cursor LEER y se almacena en las variables correspondientes
		FETCH NEXT FROM LEER INTO @COD,@NOM,@DES
			WHILE @@FETCH_STATUS=0	  --CONTINUA EJECUTANDOSE MIENTRA HAYA FILAS
				BEGIN
					-- Se imprime la información del distrito actual
					PRINT CONVERT(CHAR(4),@COD)+SPACE(5)+CONVERT(CHAR(30),@NOM)+SPACE(5)+@DES
					PRINT REPLICATE('-',60)

					 -- Se declaran las variables
					DECLARE @C CHAR(4),@N VARCHAR(30),@D VARCHAR(50)
					-- Se define un cursor para leer los datos de la tabla LECTORES filtrados por el distrito actual
					DECLARE LECT CURSOR FOR SELECT COD_LEC,NOM_LEC,DIR_LEC FROM LECTORES WHERE DIS_LEC=@COD
						--ABRIMOS EL CURSOR
						OPEN LECT
							-- SETEA VALORES EN LAS VARIABLES
							FETCH NEXT FROM LECT INTO @C,@N,@D
							--ABRIMOS CONDICIONAL
								IF @@FETCH_STATUS<>0  -- SE VERIFICA SI EXISTEN REGISTROS EN EL CURSOR LECT
									PRINT '			<<SIN REGISTROS>>'
								ELSE
									BEGIN
										--ABRIMOS BIGEN PARA IMPRIMIR DATOS
										WHILE @@FETCH_STATUS=0
											BEGIN
												-- Se imprime la información del lector actual
												PRINT CONVERT(CHAR(4),@C)+SPACE(3)+CONVERT(CHAR(30),@N)+SPACE(3)+@D
												FETCH NEXT FROM LECT INTO @C,@N,@D
											--CERRAMOS EL BEGIN
											END
									--CERRAMOS EL BEGIN
									END
									-- Se imprime una línea en blanco
									PRINT ''
						CLOSE LECT	 --CERRAMOS EL CURSOR LECT
						DEALLOCATE LECT --BORRAMOS EL CURSOR LECT
						FETCH NEXT FROM LEER INTO @COD,@NOM,@DES
				--CERRAMOS EL BEGIN
				END
	
	CLOSE LEER --CERRAMOS EL CURSOR LEER
	DEALLOCATE LEER --BORRAMOS EL CURSOR LEER

GO

EXECUTE CURSORDISTRITO
GO


-------------------------------------------------------------------
--CREAR UNA FUNCION QUE RETORNAN DE LA TABLA LECTORES POR DISTRITO:

CREATE FUNCTION LECTORES_POR_DISTRITO(@DATO VARCHAR(30)) RETURNS
TABLE
AS
RETURN(
	SELECT L.COD_LEC AS CODIGO,L.NOM_LEC AS NOMBRE,D.NOM_DIS AS DISTRITO
	FROM LECTORES L,DISTRITOS D 
	WHERE D.COD_DIS=L.DIS_LEC AND D.NOM_DIS=@DATO
	)
GO

-- BORRAR UNA FUNCTION
--DROP FUNCTION LECTORES_POR_DISTRITO;



SELECT * FROM LECTORES_POR_DISTRITO('Distrito 1')
SELECT * FROM LECTORES_POR_DISTRITO('Distrito 2')



--------------------------------------------------
--TESTEANDO REVOCACION DE PERMISOS PARA EL USUARIO

SELECT * FROM DISTRITOS

INSERT INTO DISTRITOS VALUES('D010','SAN MIGUEL','')
