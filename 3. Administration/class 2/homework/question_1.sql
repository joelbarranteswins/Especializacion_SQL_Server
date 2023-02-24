
/* PREGUNTA 1:
Crear la BD Almacén en C:\, 02 archivos.  Tamaño inicial: 4 MB c/u, 
Máximo: 25MB c/u,  crecimiento: 60% y el lógico 5Mb.
*/ 

CREATE DATABASE Almacen
ON(
NAME = Almacen_Data,
FILENAME = 'C:\Users\joel_\Desktop\database\Almacen_Data.MDF',
SIZE = 4MB,
MAXSIZE = 25MB,
FILEGROWTH = 60%
)

LOG ON(
NAME = Almacen_Log,
FILENAME = 'C:\Users\joel_\Desktop\database\Almacen_Log.LDF',
SIZE = 5MB,
MAXSIZE = 25MB, 
FILEGROWTH = 60%
)



/* PREGUNTA 2:
Una tienda especializada en componentes electrónicos compra sus existencias a,
vendiéndolas posteriormente a sus clientes a la vez que lleva a cabo el control de almacén
adecuado para controlar sus existencias en todo momento. La gestión de proveedores lleva
unida la gestión de los datos administrativos de éstos más la información de los componentes
que cada proveedor sirve. La gestión de proveedores, además del típico mantenimiento de los
datos relacionados, se encarga de generar los listados de las piezas servidas por un
determinado proveedor, o los proveedores que sirven una determinada pieza. Cuando un cliente
solicita un determinado componente, se comprueba que hay existencias y se le informa de su
precio. Si el cliente adquiere el producto, se actualizará el almacén y se le emitirá una factura.
Si no hay existencias del componente, pero el cliente está interesado se procederá a almacenar
la petición con objeto de realizar el correspondiente pedido al proveedor. El control de almacén
se encarga de tener actualizado el almacén de existencias, dando de alta los componentes que
llegan, eliminando componentes defectuosos, y realizando los listados de componentes
disponibles en el almacén y de los componentes pendientes de ser pedidos a un proveedor.
Debe utilizarse un almacén PROVEEDORES que recoge la información de los proveedores y 
de las piezas que sirven. 
*/

USE Almacen;
GO

CREATE SCHEMA Inventario
GO

ALTER DATABASE Almacen ADD FILEGROUP InventarioFileGroup;
ALTER DATABASE Almacen ADD FILE (
    NAME = 'InventarioData',
    FILENAME = 'Ruta/De/Tu/Carpeta/InventarioData.mdf',
    SIZE = 10MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
) TO FILEGROUP InventarioFileGroup;

ALTER DATABASE Almacen ADD LOG FILE (
    NAME = 'InventarioLog',
    FILENAME = 'Ruta/De/Tu/Carpeta/InventarioLog.ldf',
    SIZE = 10MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
) TO FILEGROUP InventarioFileGroup;


CREATE TABLE Inventario.Proveedores (
    ProveedorID INT PRIMARY KEY,
    NombreProveedor VARCHAR(50),
    Direccion VARCHAR(100),
    Ciudad VARCHAR(50),
    Pais VARCHAR(50)
);

CREATE TABLE Inventario.Componentes (
    ComponenteID INT PRIMARY KEY,
    NombreComponente VARCHAR(50),
    Descripcion VARCHAR(100),
    Precio DECIMAL(10, 2),
    Existencias INT
);

CREATE TABLE Inventario.ProveedoresComponentes (
    ProveedorID INT REFERENCES Inventario.Proveedores(ProveedorID),
    ComponenteID INT REFERENCES Inventario.Componentes(ComponenteID),
    PRIMARY KEY (ProveedorID, ComponenteID)
);

CREATE SCHEMA Ventas
GO

ALTER DATABASE [NombreDeTuBaseDeDatos] ADD FILEGROUP VentasFileGroup;
ALTER DATABASE [NombreDeTuBaseDeDatos] ADD FILE (
    NAME = 'VentasData',
    FILENAME = 'Ruta/De/Tu/Carpeta/VentasData.mdf',
    SIZE = 10MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
) TO FILEGROUP VentasFileGroup;

ALTER DATABASE [NombreDeTuBaseDeDatos] ADD


/* PREGUNTA 3:
Elabore su BD Relacional y el uso del Schema.
*/