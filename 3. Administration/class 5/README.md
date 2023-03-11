


## que es un BACKUP

Un backup de SQL Server es una copia de seguridad de la base de datos y sus objetos asociados, como tablas, índices, procedimientos almacenados, desencadenadores, etc. El propósito de un backup es permitir la recuperación de la base de datos en caso de una falla del sistema, un error humano, un desastre natural o cualquier otro evento que cause la pérdida de los datos originales.

Los backups de SQL Server pueden ser completos, diferenciales o de registros de transacciones. Los backups completos contienen una copia de todos los datos y objetos en la base de datos, mientras que los backups diferenciales contienen solo los datos y objetos que han cambiado desde el último backup completo. Los backups de registro de transacciones contienen solo los cambios en los datos y objetos desde el último backup de registro de transacciones.

SQL Server también proporciona opciones para comprimir y encriptar los backups para garantizar la seguridad y reducir el tamaño del archivo. La frecuencia de los backups y la estrategia de recuperación de desastres varían según las necesidades de la organización y deben ser planificadas cuidadosamente para garantizar una recuperación exitosa en caso de una falla del sistema.


## FILELISTONLY, HEADERONLY

La opción "RESTORE FILELISTONLY" se utiliza para mostrar una lista de los archivos de la copia de seguridad de SQL Server, incluyendo el nombre lógico de cada archivo y su ubicación física. Esto se puede utilizar para determinar qué archivos se incluyeron en una copia de seguridad antes de realizar una operación de restauración.

La opción "HEADERONLY RESTORE" se utiliza para mostrar solo los encabezados de la copia de seguridad, incluyendo información básica como la fecha y hora de la copia de seguridad y el tipo de copia de seguridad.

La opción "BACKUP DATABASE" se utiliza para realizar una copia de seguridad de una base de datos de SQL Server. No proporciona información sobre los archivos que se copiaron.