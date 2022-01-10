
USE Northwind;

SELECT DB_NAME();

/*PROCEDIMIENTO ALMACENADO*/
--CREATE PROC
-- son funciones con una tarea
CREATE PROC pa_Empleado
AS
SELECT EmployeeID, LastName, FirstName, BirthDate AS FechaNacimiento,
DATEDIFF(YEAR, BirthDate, GETDATE()) AS Edad,
HireDate as FechaContratacion,
DATEDIFF(YEAR, HireDate, GETDATE()) TiempoServicio,
City, Country
FROM Employees;

--ejecutar el procedimiento
EXEC pa_Empleado;

---
select EmployeeID, LastName, FirstName, Title, 
TitleOfCourtesy, BirthDate, HireDate, Address, City, 
Country
FROM Employees;

-------------------------------------------------------------------
--creando un procedimiento con su tipo de dato para introducir datos
CREATE PROC pa_Empleado_insert
@apellido varchar(40)=null,
@nombre varchar(20)=null,
@cargo varchar(60)=null,
@titulo varchar(50)=null,
@fecnaci date=null, 
@fecIngreso date,
@direccion varchar(120)=null,
@ciudad varchar(30)=null,
@pais varchar(30)=null
AS
IF @apellido is null or @nombre is null
BEGIN
	RAISERROR('Debe ingresar el apellido y Nombre',15,1)
	RETURN
END
INSERT INTO Employees(LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City, Country)
VALUES (@apellido, @nombre, @cargo, @titulo, @fecnaci, @fecIngreso, @direccion, @ciudad, @pais)
PRINT 'Empleado Registrado';


--ejecuntado el procedimiento
exec pa_Empleado_insert 'Ramos','Daniel','Instructor','Ing.','1972-01-18','1999-10-25','su casa','Lima','Peru';
exec pa_Empleado_insert 'Calderon','Daniel','alumno','adm.','1995-03-26','2021-02-25','su casa','Lima','Peru';
exec pa_Empleado_insert 'Miguel','Llicahua','Alumno','simple_mortal','1996-11-09','2016-04-26','Urb.Santo Domingo','Lima','Per�';
exec pa_Empleado_insert 'Barrientos','Jordan','Estudiante','Ing.','1991-05-15','2010-10-25','Av. Mayolo 232','Lima','Peru';
exec pa_Empleado_insert 'Flores','Rosmery','Estudiante','Ing','1989-05-18','1999-08-15','su casa','Lima','Peru';
exec pa_Empleado_insert 'Saravia','JOseth','Alumno','Egre.','1998-10-25','2021-12-12','mi casa','Chincha','Peru';
exec pa_Empleado_insert 'Mena','Alvaro','alumno','adm.','1995-03-26','2021-02-25','su casa','Lima','Peru';
exec pa_Empleado_insert 'Calixto','Steven','Alumno','Alumno','2000-02-16','2015-05-16','su casa','Lima','Peru';
exec pa_Empleado_insert 'Chuquipul','Divash','Estudiante','Lic.','1996-11-21','2021-10-25','Av. Gonza'


--haciendo query a la tabla
SELECT * 
FROM Employees
ORDER BY LastName;

--------------------------------------------------------------------------------------
--creando un procedimiento con sus datos para actualizar datos
create proc pa_Empleado_update
@codigo int=NULL, 
@apellido varchar(40)=null,
@nombre varchar(20)=null,
@cargo varchar(60)=null,
@titulo varchar(50)=null, 
@fecnaci date=null, 
@fecIngreso date,
@direccion varchar(120)=null,
@ciudad varchar(30)=null,
@pais varchar(30)=null
AS
if @codigo IS NULL
begin
	raiserror('Debe ingresar el codigo',15,1)
	return
end
if @apellido is null or @nombre is null
begin
	raiserror('Debe ingresar el apellido y Nombre',15,1)
	return
end
update Employees 
set 
LastName=@apellido,
FirstName=@nombre,
Title=@cargo,
TitleOfCourtesy=@titulo,
BirthDate=@fecnaci,
HireDate=@fecIngreso,
Address=@direccion,
City=@ciudad,
Country=@pais
where EmployeeID=@codigo
print 'Empleado Actualizado';


--ejecutando el procedimiento
-- el numero al lado del procedimiento es el EmployeeID, ubica al empleado
exec pa_Empleado_update 19,
'Ramos','Daniel0000','Instructor','Profesor','1972-01-18','1999-10-25','su casa','Lima','Peru';

--ver la tabla
SELECT * FROM Employees;


----------------------------------------------------------------------
CREATE PROC pa_Empleado_delete_3
@codigo int=NULL
AS
if @codigo IS NULL
begin
    raiserror('Debe ingresar el codigo',15,1)
    return
end
delete from Employees where EmployeeID=@codigo
print 'Empleado Eliminado';

--ejecutando el procedimiento de eliminar
exec pa_Empleado_delete_3 15;

--ver la tabla
SELECT * FROM Employees;

/*
Crear los Procedimiento almacenados para la tabla Customers 
enviar: daniel.ramos.c@sistemasuni.edu.pe
asunto: Tarea Semana03
*/

--create a proc to insert data into Customers
CREATE PROC pa_Clientes_insert
@nombre varchar(40)=null,
@apellido varchar(20)=null,
@direccion varchar(120)=null,
@ciudad varchar(30)=null,
@pais varchar(30)=null
AS
IF @nombre is null or @apellido is null
BEGIN
    RAISERROR('Debe ingresar el nombre y apellido',15,1)
    RETURN
END
INSERT INTO Customers(CompanyName, ContactName, ContactTitle, Address, City, Country)
VALUES (@nombre, @apellido, @direccion, @ciudad, @pais)
PRINT 'Cliente Registrado';


--ejecuntado el procedimiento
exec pa_Clientes_insert 'Ramos','Daniel','su casa','Lima','Peru';
exec pa_Clientes_insert 'Calderon','Daniel','su casa','Lima','Peru';


--create a proc to update data into Customers
CREATE PROC pa_Clientes_update
@codigo int=NULL,
@nombre varchar(40)=null,
@apellido varchar(20)=null,
@direccion varchar(120)=null,
@ciudad varchar(30)=null,
@pais varchar(30)=null
AS
IF @codigo IS NULL
BEGIN
    RAISERROR('Debe ingresar el codigo',15,1)
    RETURN
END
IF @nombre is null or @apellido is null
BEGIN
    RAISERROR('Debe ingresar el nombre y apellido',15,1)
    RETURN
END
UPDATE Customers
SET CompanyName=@nombre, ContactName=@apellido, Address=@direccion, City=@ciudad, Country=@pais
WHERE CustomerID=@codigo
PRINT 'Cliente Actualizado';

--ejecutar el procedimiento
exec pa_Clientes_update 1,
'Ramos','Daniel','su casa','Lima','Peru';


--create a proc to delete a customer
CREATE PROC pa_Clientes_delete
@codigo int=NULL
AS
IF @codigo IS NULL
BEGIN
    RAISERROR('Debe ingresar el codigo',15,1)
    RETURN
END
DELETE FROM Customers WHERE CustomerID=@codigo
PRINT 'Cliente Eliminado';


--exec el procedimiento
exec pa_Clientes_delete 1;




