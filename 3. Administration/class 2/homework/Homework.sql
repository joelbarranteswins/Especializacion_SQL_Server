
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
GO


/* PREGUNTA 2:
Una tienda especializada en componentes electrónicos compra sus existencias a,
vendiéndolas posteriormente a sus clientes a la vez que lleva a cabo el control de almacén
adecuado para controlar sus existencias en todo momento. 

La gestión de proveedores lleva unida la gestión de los datos administrativos de éstos más 
la información de los componentes que cada proveedor sirve. 
La gestión de proveedores, además del típico mantenimiento de los datos relacionados, 
se encarga de generar los listados de las piezas servidas por un
determinado proveedor, o los proveedores que sirven una determinada pieza. 

Cuando un cliente solicita un determinado componente, se comprueba que hay existencias 
y se le informa de su precio. 
Si el cliente adquiere el producto, se actualizará el almacén y se le emitirá una factura.
Si no hay existencias del componente, pero el cliente está interesado se procederá a almacenar
la petición con objeto de realizar el correspondiente pedido al proveedor. 

El control de almacén se encarga de tener actualizado el almacén de existencias, 
dando de alta los componentes que llegan, eliminando componentes defectuosos, y realizando 
los listados de componentes disponibles en el almacén y de los componentes pendientes de ser pedidos a un proveedor.

Debe utilizarse un almacén PROVEEDORES que recoge la información de los proveedores y 
de las piezas que sirven. 
*/

/* PREGUNTA 3:
Elabore su BD Relacional 
*/

-- Uso de la Base de datos Almacen
-- USE Almacen
-- GO

-- creando un filegroup en la base de datos Almacen

ALTER DATABASE [Almacen] ADD FILEGROUP DATA_1
GO

-- agregando archivos secundarios a los filegroups

ALTER DATABASE [Almacen]
ADD FILE(
NAME=DATA_ALAMACEN,
FILENAME='C:\Users\joel_\Desktop\database\DATA_ALMACEN.NDF',
SIZE= 2MB,
MAXSIZE=10MB,
FILEGROWTH=2MB
)TO FILEGROUP DATA_1
GO


--Agregando Schemas y tablas necesarios a la base de datos


CREATE SCHEMA PROVEEDORES
GO

CREATE TABLE PROVEEDORES.Proveedores (
    ProveedorID INT PRIMARY KEY,
    NombreProveedor NVARCHAR(50),
    Direccion NVARCHAR(100),
    Telefono NVARCHAR(20),
    Ciudad NVARCHAR(50),
    Pais NVARCHAR(50),
    Fecha_creacion DATETIME,
    Fecha_acutalizacion DATETIME
);

CREATE TABLE PROVEEDORES.ProveedoresComponentes (
    ComponenteID INT PRIMARY KEY,
    Nombre NVARCHAR(50),
    Descripcion NVARCHAR(200),
    Precio DECIMAL(10, 2),
    ProveedorID INT FOREIGN KEY REFERENCES PROVEEDORES.Proveedores(ProveedorID)
);
GO



CREATE SCHEMA ALMACEN
GO

CREATE TABLE ALMACEN.Componentes (
    ComponenteID INT PRIMARY KEY,
    Nombre NVARCHAR(50),
    Descripcion NVARCHAR(200),
    Cantidad INT,
    Precio DECIMAL(10, 2),
    Precio_unitario DECIMAL(10, 2),
    Fecha_creacion DATETIME,
    Fecha_acutalizacion DATETIME
);

CREATE TABLE ALMACEN.ComponentesDefectuosos (
    ComponenteDefectuosoID INT PRIMARY KEY,
    FechaDetectado DATE,
    Comentarios NVARCHAR(255),
    Cantidad INT,
    ComponenteID INT FOREIGN KEY REFERENCES ALMACEN.Componentes(ComponenteID),
    ProveedorID INT FOREIGN KEY REFERENCES PROVEEDORES.Proveedores(ProveedorID)
);

CREATE TABLE ALMACEN.Inventario (
    InventarioID INT PRIMARY KEY,
    ComponenteID INT FOREIGN KEY REFERENCES ALMACEN.Componentes(ComponenteID),
    Cantidad INT,
    PrecioCompra DECIMAL(10, 2),
    PrecioVenta DECIMAL(10, 2),
    Fecha_creacion DATETIME,
    Fecha_acutalizacion DATETIME
);


CREATE TABLE ALMACEN.Pedidos (
    PedidoID INT PRIMARY KEY,
    ProveedorID INT FOREIGN KEY REFERENCES PROVEEDORES.Proveedores(ProveedorID),
    FechaPedido DATE,
    FechaEntrega DATE,
    Fecha_creacion DATETIME,
    Fecha_acutalizacion DATETIME
);

CREATE TABLE ALMACEN.DetallesPedido (
    DetallesPedidoID INT PRIMARY KEY,
    PedidoID INT FOREIGN KEY REFERENCES ALMACEN.Pedidos(PedidoID),
    ComponenteID INT FOREIGN KEY REFERENCES ALMACEN.Componentes(ComponenteID),
    Cantidad INT,
    Precio DECIMAL(10, 2)
);
GO


CREATE SCHEMA VENTAS
GO

CREATE TABLE VENTAS.Clientes (
    ClienteID INT PRIMARY KEY,
    NombreCliente NVARCHAR(50),
    Direccion NVARCHAR(100),
    Telefono NVARCHAR(20),
    Ciudad NVARCHAR(50),
    Pais NVARCHAR(50),
    Fecha_creacion DATETIME,
    Fecha_acutalizacion DATETIME
);

CREATE TABLE VENTAS.Ventas (
    VentaID INT PRIMARY KEY,
    InventarioID INT FOREIGN KEY REFERENCES ALMACEN.Inventario(InventarioID),
    FechaVenta DATE,
    Cantidad INT,
    Fecha_creacion DATETIME,
    Fecha_acutalizacion DATETIME
);

CREATE TABLE VENTAS.Facturas (
    FacturaID INT PRIMARY KEY,
    ClienteID INT FOREIGN KEY REFERENCES VENTAS.Clientes(ClienteID),
    FechaFactura DATE,
    Total DECIMAL(10, 2),
    Fecha_creacion DATETIME,
    Fecha_acutalizacion DATETIME
);

CREATE TABLE VENTAS.DetallesFactura (
    DetallesFacturaID INT PRIMARY KEY,
    FacturaID INT FOREIGN KEY REFERENCES VENTAS.Facturas(FacturaID),
    InventarioID INT FOREIGN KEY REFERENCES ALMACEN.Inventario(InventarioID),
    Cantidad INT,
    Precio DECIMAL(10, 2)
);
GO



