


## que es un BACKUP

Un backup de SQL Server es una copia de seguridad de la base de datos y sus objetos asociados, como tablas, índices, procedimientos almacenados, desencadenadores, etc. El propósito de un backup es permitir la recuperación de la base de datos en caso de una falla del sistema, un error humano, un desastre natural o cualquier otro evento que cause la pérdida de los datos originales.

Los backups de SQL Server pueden ser completos, diferenciales o de registros de transacciones. Los backups completos contienen una copia de todos los datos y objetos en la base de datos, mientras que los backups diferenciales contienen solo los datos y objetos que han cambiado desde el último backup completo. Los backups de registro de transacciones contienen solo los cambios en los datos y objetos desde el último backup de registro de transacciones.

SQL Server también proporciona opciones para comprimir y encriptar los backups para garantizar la seguridad y reducir el tamaño del archivo. La frecuencia de los backups y la estrategia de recuperación de desastres varían según las necesidades de la organización y deben ser planificadas cuidadosamente para garantizar una recuperación exitosa en caso de una falla del sistema.

## BACKUP DIFERENCIAL

Un backup diferencial es una copia de seguridad que incluye todas las modificaciones realizadas en la base de datos desde la última copia de seguridad completa. En otras palabras, un backup diferencial solo contiene los cambios que se han producido desde la última copia de seguridad completa y no incluye los cambios que se hayan producido desde la última copia de seguridad diferencial.

Por lo tanto, normalmente en un backup diferencial se espera encontrar una cantidad de datos menor en comparación con la copia de seguridad completa, ya que solo se incluyen los cambios desde la última copia de seguridad completa. Además, se espera que el backup diferencial sea más rápido de realizar que una copia de seguridad completa, ya que solo se están copiando los cambios que se han producido en la base de datos desde la última copia de seguridad completa.

Los backups diferenciales se utilizan comúnmente como parte de una estrategia de copia de seguridad y restauración de bases de datos, ya que permiten restaurar la base de datos a un punto específico en el tiempo sin tener que restaurar todas las copias de seguridad de registro de transacciones desde la última copia de seguridad completa.


## FILELISTONLY, HEADERONLY

La opción "RESTORE FILELISTONLY" se utiliza para mostrar una lista de los archivos de la copia de seguridad de SQL Server, incluyendo el nombre lógico de cada archivo y su ubicación física. Esto se puede utilizar para determinar qué archivos se incluyeron en una copia de seguridad antes de realizar una operación de restauración.

La opción "HEADERONLY RESTORE" se utiliza para mostrar solo los encabezados de la copia de seguridad, incluyendo información básica como la fecha y hora de la copia de seguridad y el tipo de copia de seguridad.

La opción "BACKUP DATABASE" se utiliza para realizar una copia de seguridad de una base de datos de SQL Server. No proporciona información sobre los archivos que se copiaron.

## PARAMETROS DEL BACKUP

~~~SQL
BACKUP DATABASE BD_LATAM
TO DISK= 'C:\database\BD_LATAM_FULL.BAK'
 WITH NOINIT,	
 NAME='COPIA COMPLETA',
 DESCRIPTION='COPIA DIARIA'
~~~

* El parámetro WITH NOINIT en la instrucción BACKUP DATABASE se utiliza para indicar que se va a agregar la copia de seguridad al conjunto de copias de seguridad existente en el archivo de copia de seguridad especificado.

    Si no se utiliza el parámetro WITH NOINIT, la instrucción BACKUP DATABASE sobrescribirá cualquier archivo de copia de seguridad existente con el mismo nombre que se especifique en el comando y comenzará a escribir una nueva copia de seguridad en ese archivo.

~~~SQL

 BACKUP DATABASE BD_LATAM
 TO DISK= 'C:\database\BD_LATAM_FULL2.BAK'
    WITH INIT, --NO SE AGREGA EN EL COJUNTO DEL BACKUP, SI NO CREA UNO NUEVO
    NAME='COPIA COMPLETA',
    DESCRIPTION='COPIA DIARIA',
    STATS=10,
    FORMAT, COMPRESSION
~~~

* WITH INIT: Este parámetro indica que se va a realizar una copia de seguridad completa en lugar de agregarla a un conjunto de copias de seguridad existente.

* NAME: Este parámetro proporciona un nombre descriptivo para la copia de seguridad.

* DESCRIPTION: Este parámetro proporciona una descripción para la copia de seguridad.

* STATS: Este parámetro indica que el progreso del backup se actualiza cada 10 por ciento.

* FORMAT: Este parámetro indica que el archivo de copia de seguridad se formatee antes de realizar la copia de seguridad.

* COMPRESSION: Este parámetro indica que la copia de seguridad se comprima para reducir su tamaño en disco.



~~~sql
backup DATABASE BD_LATAM
TO DISK='D:\DATOS\BD_LATAM_DIFF.BAK'
WITH DIFFERENTIAL,
	NAME='COPIA DIFERENCIAL',
	DESCRIPTION='COPIA DIF. LUNES 14PM',
	INIT
GO
~~~

* El parámetro WITH DIFFERENTIAL en la instrucción BACKUP DATABASE se utiliza para realizar una copia de seguridad diferencial de la base de datos en lugar de una copia de seguridad completa.

    Una copia de seguridad diferencial incluye solo los cambios realizados en la base de datos desde la última copia de seguridad completa, lo que puede ser útil para realizar copias de seguridad más rápidas y reducir el espacio de almacenamiento necesario para las copias de seguridad.

~~~sql
-- RECUPERACION DE LA BASE DE DATOS
USE MASTER
GO
RESTORE DATABASE BD_LATAM
FROM DISK = 'C:\database\BD_LATAM_FULL2.BAK'
WITH REPLACE, NORECOVERY 
~~~

REPLACE: Este parámetro indica que la base de datos existente se reemplazará si existe una copia de la base de datos con el mismo nombre. Si la base de datos no existe, se creará una nueva base de datos con el nombre especificado en la copia de seguridad.

NORECOVERY: Este parámetro se utiliza cuando se restauran copias de seguridad adicionales después de la primera copia de seguridad (que se restaura normalmente sin el parámetro NORECOVERY). Indica que la base de datos no se puede usar después de la restauración y que se deben restaurar más copias de seguridad.