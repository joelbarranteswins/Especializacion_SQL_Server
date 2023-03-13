
USE BD_LATAM
GO

EXECUTE sp_helpDB BD_LATAM
GO

BACKUP DATABASE BD_LATAM
TO DISK= 'C:\database\BD_LATAM_FULL.BAK'
WITH NOINIT,	-- LA COPIA DE SEGURIDAD SE AGREGA COMO CONJUNTO DE INFORMACI�N ESPECIFICA
NAME='COPIA COMPLETA',
DESCRIPTION='COPIA DIARIA'


-- EL FILELISTONLY LISTA LA INFORMACION DE ARCHIVOS QUE SE COPIARON EN LA COPIA DE SEGURIDAD (BACKUP)
 RESTORE FILELISTONLY
 FROM DISK= 'C:\database\BD_LATAM_FULL.BAK'
 GO

 -- HEADERONLY MUESTRA EL ENCABEZADO (EL NAME) DE LA COPIA DE SEGURIDAD (BACKUP)
 RESTORE HEADERONLY
 FROM DISK= 'C:\database\BD_LATAM_FULL.BAK'
 GO


--REDUCIR EL ESPACIO DEL BACKUP
--EN CASO DE QUE SEA MAYOR DEL ESPERADO
 BACKUP DATABASE BD_LATAM
 TO DISK= 'C:\database\BD_LATAM_FULL2.BAK'
    WITH INIT, --NO SE AGREGA EN EL COJUNTO DEL BACKUP, SI NO CREA UNO NUEVO
    NAME='COPIA COMPLETA',
    DESCRIPTION='COPIA DIARIA',
    STATS=10,
    FORMAT, COMPRESSION



 RESTORE FILELISTONLY
 FROM DISK= 'C:\database\BD_LATAM_FULL2.BAK'
 GO

 
 RESTORE HEADERONLY
 FROM DISK= 'C:\database\BD_LATAM_FULL2.BAK'
 GO

 --CAMBIAR IDIOMA
 -- SET LANGUAGE SPANISH


USE BD_LATAM
GO

 


--VOY A CREAR UNA TABLA UTILIZANDO LA CONSULTA SELECT NOMBRE TBLCIUDAD

SELECT * INTO TBLCIUDAD FROM Ciudad

SELECT * FROM TBLCIUDAD


--ACTUALIZAR DICHOS REGISTROS
UPDATE TBLCIUDAD SET Nombre='Chiclayo' where Id like '%[1,6]'

select * from tBLCIUDAD where Id like '%[1,6]'


BACKUP DATABASE BD_LATAM
TO DISK = 'C:\database\BD_LATAM_DIFF.BAK'
    WITH DIFFERENTIAL,
    NAME='COPIA DIFERENCIAL',
    DESCRIPTION='COPIA DIFERENCIA Y DIARIA LUNEA 14PM',
    INIT
GO


/*
COPIA DE REGISTROS DE TRANSACCIONES

TIME            EVENTO
8:00 AM         COPIA SEGURIDAD DE DB
MEDIO DIA       COPIA SEGURIDAD DE TRANSACCIONES
16:00 PM        COPIA REGISTROS DE TRANSACCIONES
18:00 PM        COPIA SEGURIDAD DE DB
20:00 PM        COPIA REGISTROS DE TRANSACCIONES

*/


BACKUP LOG BD_LATAM
TO DISK = 'C:\database\BD_LATAM_LOG.BAK'
    WITH NAME = 'COPIA DEL LOG',
        DESCRIPTION='COPIA LOG. LUNEA 14PM',
        INIT


SELECT * FROM TBLCIUDAD

--ELIMAR DE LA TABLA TBLCIUDAD LA CIUDAD CHICLAYO

DELETE FROM TBLCIUDAD WHERE NOMBRE='CHICLAYO'



-- RECUPERACION DE LA BASE DE DATOS	(EJECUTAR DESDE MASTER)
USE MASTER
GO


RESTORE DATABASE BD_LATAM
FROM DISK = 'C:\database\BD_LATAM_FULL2.BAK'
WITH REPLACE, NORECOVERY 
--TENER EN CUENTA QUE EN EL BD_LATAM_FULL2.BAK NO HAY LA TABLA TBLCIUDAD

--SIRVE PARA FINALIZAR LA RESTAURACION DE LA BASE DE DATOS.
--RESTORE DATABASE BD_LATAM
--WITH RECOVERY;



--RESTAURAR EL BACKUP DIFERENCIAL
RESTORE DATABASE BD_LATAM
FROM DISK = 'C:\database\BD_LATAM_DIFF.BAK'
WITH NORECOVERY


--RESTAURAR EL BACKUP DE LOS REGISTROS
RESTORE LOG BD_LATAM
FROM DISK = 'C:\database\BD_LATAM_LOG.BAK'
WITH NORECOVERY
GO


RESTORE LOG BD_LATAM
WITH RECOVERY;	   --SE UTILIZA CUANDO YA SE FINALIZA LA RESTAURACI�N


/* 
Cuando se utiliza la opci�n "WITH RECOVERY", 
la base de datos o el registro de transacciones se 
recuperan hasta el punto final y se aplican todos los 
cambios necesarios para asegurarse de que la base de 
datos est� en un estado consistente y sea completamente 
funcional. Tambi�n se abre la base de datos para que los 
usuarios puedan realizar consultas y modificaciones.
*/



SELECT *
FROM fn_dblog(NULL,NULL)
WHERE Operation IN ('LOP_INSERT_ROWS','LOP_MODIFY_ROW','LOP_DELETE_ROWS')







--COMPROBANDO LA RESTAURACI�N
USE BD_LATAM

SELECT * FROM TBLCIUDAD