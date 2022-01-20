/*
Crear los Procedimiento almacenados para la tabla Customers 
enviar: daniel.ramos.c@sistemasuni.edu.pe
asunto: Tarea Semana03
*/

--NOMBRE: JOEL BARRANTES PALACIOS

--crear un procedimiento para insertar 
CREATE PROC pa_Clientes_insert
@id VARCHAR(5),
@company VARCHAR(40)=NULL,
@nombre VARCHAR(80)=NULL,
@direccion VARCHAR(120)=NULL,
@ciudad VARCHAR(30)=NULL,
@pais VARCHAR(30)=NULL
AS
IF @id IS NULL
BEGIN
    RAISERROR('Debe ingresar el id',15,1)
    RETURN
END
INSERT INTO Customers(CustomerID, CompanyName, ContactName, Address, City, Country)
VALUES (@id, @company, @nombre, @direccion, @ciudad, @pais)
PRINT 'Cliente Registrado';


--ejecuntado el procedimiento
EXEC pa_Clientes_insert 'AAAAA','JUNTOSVAMOS','Ramos''LIMA','Lima','Peru';
EXEC pa_Clientes_insert 'AAAAL','JUNYTV','Daniel','SJM','Lima','Peru';

--observando la tabla
SELECT * FROM Customers;


--crear un procedimiento para actualizar uan fila
CREATE PROC pa_Clientes_update
@id VARCHAR(10),
@company VARCHAR(40)=NULL,
@nombre VARCHAR(80)=NULL,
@direccion VARCHAR(120)=NULL,
@ciudad VARCHAR(30)=NULL,
@pais VARCHAR(30)=NULL
AS
IF @id IS NULL
BEGIN
    RAISERROR('Debe ingresar el id del cliente',15,1)
    RETURN
END
IF @nombre IS NULL
BEGIN
    RAISERROR('Debe ingresar el nombre del cliente',15,1)
    RETURN
END
UPDATE Customers
SET CustomerID=@id, CompanyName=@nombre, Address=@direccion, City=@ciudad, Country=@pais
WHERE CustomerID=@id
PRINT 'Cliente Actualizado';

--ejecutar el procedimiento
EXEC pa_Clientes_update 'AAAAA','ENVACK','Ramos','Lima','Peru';
EXEC pa_Clientes_update 'AAAAL','ALICOR','Daniel','Lima','Peru';

SELECT * FROM Customers;


--crear un procedimiento para eliminar una fila
CREATE PROC pa_Clientes_delete
@id VARCHAR(5)=NULL
AS
IF @id IS NULL
BEGIN
    RAISERROR('Debe ingresar el ID del cliente',15,1)
    RETURN
END
DELETE FROM Customers WHERE CustomerID=@id
PRINT 'Cliente Eliminado';


--EXEC el procedimiento
EXEC pa_Clientes_delete 'AAAAA';
EXEC pa_Clientes_delete 'AAAAL';

SELECT * FROM Customers;