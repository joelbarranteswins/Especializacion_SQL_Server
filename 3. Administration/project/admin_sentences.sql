
/*==============================================================*/
-- CREAR LA BASE DE DATOS Y LOS REGISTROS EN FISICO
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'ECORP')
BEGIN
    DROP DATABASE ESCUELA
END

CREATE DATABASE ECORP
ON(
NAME='ECORP_DATA',
FILENAME='C:\database\ECORP_DATA.MDF',
SIZE=5MB,
MAXSIZE=15MB,
FILEGROWTH=50%
)
LOG ON(
NAME='ECORP_LOG',
FILENAME='C:\database\ECORP_LOG.LDF',
SIZE=5MB,
MAXSIZE=15MB,
FILEGROWTH=2MB
);
GO

--AGREGAR FILEGROUPS A LA BD
ALTER DATABASE [ECORP] ADD FILEGROUP DATA_FILEGROUP_V1
GO

--AGREGAR ARCHIVOS SECUNDARIOS A LOS FILEGROUPS
ALTER DATABASE [ECORP]
ADD FILE(
NAME=DATA_FILEGROUP_V1,
FILENAME='C:\database\DATA_FILEGROUP_V1.NDF',
SIZE= 1MB,
MAXSIZE=10MB,
FILEGROWTH=2MB
)TO FILEGROUP DATA_FILEGROUP_V1
GO



/*==============================================================*/
USE ECORP
GO

-- Crear esquemas
CREATE SCHEMA PROVEEDORES;
GO
CREATE SCHEMA INVENTARIO;
GO
CREATE SCHEMA OPERACIONES;
GO
CREATE SCHEMA VENTAS;
GO


-- Crear tabla para los empleados
CREATE TABLE OPERACIONES.Empleados (
  id_empleado char(4) PRIMARY KEY CHECK(id_empleado LIKE'E[0-9][0-9][0-9]'),
  nombre_empleado varchar(100) NOT NULL,
  cargo_empleado varchar(50) NOT NULL,
  salario_empleado decimal(10,2) NOT NULL,
  fecha_creacion DATETIME DEFAULT GETDATE(),
  fecha_actualizacion DATETIME NOT NULL
);

INSERT INTO OPERACIONES.Empleados 
(id_empleado, nombre_empleado, cargo_empleado, salario_empleado, fecha_actualizacion)
VALUES 
('E001', 'Juan Perez', 'jefe de ventas', 3000.00, GETDATE()),
('E002', 'Ana Garcia', 'asesor de ventas', 2500.00, GETDATE()),
('E003', 'Luis Gomez', 'practicante de ventas', 900.00, GETDATE()),
('E004', 'Maria Rodriguez', 'gerente de ventas', 3000.00, GETDATE()),
('E005', 'Pedro Hernandez', 'operario', 1500.00,  GETDATE()),
('E006', 'Jorge Torres', 'Ayudante de operario', 1200.00, GETDATE()),
('E007', 'Sofia Ramirez', 'operario', 1500.00, GETDATE()),
('E008', 'Carlos Chavez', 'gerente de almacen', 3000.00, GETDATE()),
('E009', 'Fernanda Garcia', 'ayudante de almacen', 1200.00, GETDATE()),
('E010', 'Luz Hernandez', 'ayudante de almacen', 1200.00, GETDATE()),
('E011', 'Mario Gonzalez', 'ayudante de almacen', 1200.00, GETDATE()),
('E012', 'Laura Torres', 'practicante de almacen', 900.00, GETDATE()),
('E013', 'Gabriel Diaz', 'operario', 1500.00, GETDATE()),
('E014', 'Paulina Castro', 'operario', 1500.00, GETDATE()),
('E015', 'Diana Martinez', 'operario', 1500.00, GETDATE());
GO

-- Crear tabla para los vehiculos
CREATE TABLE OPERACIONES.Vehiculos (
  id_vehiculo char(4) PRIMARY KEY  CHECK(id_vehiculo LIKE'V[0-9][0-9][0-9]'),
  tipo_vehiculo varchar(50) NOT NULL,
  placa_vehiculo varchar(10) NOT NULL,
  capacidad_vehiculo decimal(10,2) NOT NULL,
  fecha_creacion DATETIME DEFAULT GETDATE(),
  fecha_actualizacion DATETIME NOT NULL
);

INSERT INTO OPERACIONES.Vehiculos 
(id_vehiculo, tipo_vehiculo, placa_vehiculo, capacidad_vehiculo, fecha_actualizacion)
VALUES
('V001', 'Automóvil', 'ABC123', 5.0, GETDATE()),
('V002', 'Motocicleta', 'DEF456', 0.5, GETDATE()),
('V003', 'Camión', 'GHI789', 20.0, GETDATE()),
('V004', 'Furgoneta', 'JKL012', 10.0, GETDATE()),
('V005', 'Automóvil', 'MNO345', 5.0, GETDATE()),
('V006', 'Motocicleta', 'PQR678', 0.5, GETDATE()),
('V007', 'Camión', 'STU901', 20.0, GETDATE()),
('V008', 'Furgoneta', 'VWX234', 10.0, GETDATE()),
('V009', 'Automóvil', 'YZA567', 5.0, GETDATE()),
('V010', 'Motocicleta', 'BCD890', 0.5, GETDATE()),
('V011', 'Camión', 'EFG123', 20.0, GETDATE()),
('V012', 'Furgoneta', 'HIJ456', 10.0, GETDATE()),
('V013', 'Automóvil', 'KLM789', 5.0, GETDATE()),
('V014', 'Motocicleta', 'NOP012', 0.5, GETDATE()),
('V015', 'Camión', 'QRS345', 20.0, GETDATE());


-- Crear tabla para los proveedores
CREATE TABLE PROVEEDORES.Proveedores (
  id_proveedor char(7) PRIMARY KEY CHECK(id_proveedor LIKE'Prov[0-9][0-9][0-9]'),
  nombre_proveedor NVARCHAR(50) NOT NULL,
  direccion_proveedor NVARCHAR(100),
  telefono_proveedor NVARCHAR(20) NOT NULL,
  ciudad_proveedor NVARCHAR(50),
  pais_proveedor NVARCHAR(50),
  fecha_creacion DATETIME DEFAULT GETDATE(),
  fecha_actualizacion DATETIME NOT NULL
);


INSERT INTO PROVEEDORES.Proveedores
(id_proveedor, nombre_proveedor, direccion_proveedor, telefono_proveedor, ciudad_proveedor, pais_proveedor, fecha_actualizacion)
VALUES
('Prov001', 'Expotadores camal SAC', 'av. mariategui', '976162551', 'Lima', 'Perú', GETDATE()),
('Prov002', 'Amazon andes export SAC', 'CAL. RUY DIAZ 239. Callao.. C.P. callao1, Callao', '7342725', 'Callao', 'Perú', GETDATE()),
('Prov003', 'bakels', 'Av. La Arboleda 298 Urb. Santa Raquel Lima 03', '16184640', 'Lima', 'Perú', GETDATE());



-- Crear tabla para los proveedores_producto
CREATE TABLE PROVEEDORES.Proveedores_Producto (
  id_proveedor_producto int PRIMARY KEY,
  nombre_proveedor_producto nvarchar(50),
  descripcion_proveedor_producto nvarchar(200),
  precio_proveedor_producto decimal(10, 2),
  id_proveedor char(7) FOREIGN KEY REFERENCES PROVEEDORES.Proveedores(id_proveedor),
  fecha_creacion DATETIME DEFAULT GETDATE(),
  fecha_actualizacion DATETIME NOT NULL
);
GO

-- Crear tabla para los productos
CREATE TABLE INVENTARIO.Productos (
  id_producto char(7) PRIMARY KEY CHECK(id_producto LIKE'Prod[0-9][0-9][0-9]'),
  nombre_producto varchar(50) NOT NULL,
  descripcion_producto varchar(200) NOT NULL,
  precio_unitario_producto decimal(10,2) NOT NULL,
  ingredientes_producto VARCHAR(MAX) NOT NULL,
  fecha_creacion DATETIME DEFAULT GETDATE(),
  fecha_actualizacion DATETIME NOT NULL
);


INSERT INTO INVENTARIO.Productos
(id_producto, nombre_producto, descripcion_producto, precio_unitario_producto, ingredientes_producto, fecha_actualizacion)
VALUES
('Prod001', 'helados tres sabores', 'producto contine 3 sabores: yogurt, fresa, vainilla', 1.00, 'leche, esencia de vainilla, fresa, fermento', GETDATE()),
('Prod002', 'humitas', 'hecho de choclo al horno', 2.00, 'Harina, choclo, azucar, sal, mantequilla, canella, anis, pasas', GETDATE()),
('Prod003', 'camote', 'camote al horno', 2.00, 'camote, azucar', GETDATE()),
('Prod004', 'tamales', 'hecho de mote reventado', 3.00, 'maíz pelado, manteca de cerdo, cebolla, achiote, carne de cerdo, vinagre, sal, pimienta, ají panca', GETDATE());



-- Crear tabla para los ingredientes
CREATE TABLE INVENTARIO.Ingredientes (
  id_ingrediente int PRIMARY KEY,
  nombre_ingrediente varchar(50) NOT NULL,
  id_proveedor char(7) FOREIGN KEY REFERENCES PROVEEDORES.Proveedores(id_Proveedor),
  id_proveedor_producto int FOREIGN KEY REFERENCES PROVEEDORES.Proveedores_Producto(id_proveedor_producto),
  fecha_creacion DATETIME DEFAULT GETDATE(),
  fecha_actualizacion DATETIME NOT NULL
);


-- Crear tabla para los detalles de los productos e ingredientes
CREATE TABLE INVENTARIO.Detalles_Producto_Ingrediente (
  id_detalle int PRIMARY KEY,
  id_producto char(7) NOT NULL,
  id_ingrediente int NOT NULL,
  cantidad decimal(10,2) NOT NULL,
  CONSTRAINT fk_producto FOREIGN KEY (id_producto) REFERENCES Inventario.Productos(id_producto),
  CONSTRAINT fk_ingrediente FOREIGN KEY (id_ingrediente) REFERENCES Inventario.Ingredientes(id_ingrediente),
  fecha_creacion DATETIME DEFAULT GETDATE(),
  fecha_actualizacion DATETIME NOT NULL
);


-- Crear tabla para las solicitudes de compra
CREATE TABLE INVENTARIO.Solicitudes_Compra (
  id_solicitud int PRIMARY KEY,
  id_producto char(7) NOT NULL,
  cantidad decimal(10,2) NOT NULL,
  fecha_solicitud datetime NOT NULL,
  CONSTRAINT fk_producto_solicitud FOREIGN KEY (id_producto) REFERENCES Inventario.Productos(id_producto),
  fecha_creacion DATETIME DEFAULT GETDATE(),
  fecha_actualizacion DATETIME NOT NULL
);

-- Crear tabla para las �rdenes de compra
CREATE TABLE INVENTARIO.Ordenes_Compra (
  id_orden int PRIMARY KEY,
  id_solicitud int NOT NULL,
  fecha_orden datetime NOT NULL,
  id_proveedor char(7),
  CONSTRAINT fk_solicitud_orden FOREIGN KEY (id_solicitud) REFERENCES Inventario.Solicitudes_Compra(id_solicitud),
  CONSTRAINT fk_proveedor_orden FOREIGN KEY (id_proveedor) REFERENCES PROVEEDORES.Proveedores(id_Proveedor),
  fecha_creacion DATETIME DEFAULT GETDATE(),
  fecha_actualizacion DATETIME NOT NULL
);


-- Crear tabla para los detalles de las �rdenes de compra
CREATE TABLE INVENTARIO.Detalles_Orden_Compra (
  id_detalle_orden int PRIMARY KEY,
  id_orden int NOT NULL,
  id_ingrediente int NOT NULL,
  cantidad decimal(10,2) NOT NULL,
  CONSTRAINT fk_orden FOREIGN KEY (id_orden) REFERENCES Inventario.Ordenes_Compra(id_orden),
  CONSTRAINT fk_ingrediente_detalle_orden FOREIGN KEY (id_ingrediente) REFERENCES Inventario.Ingredientes(id_ingrediente),
  fecha_creacion DATETIME DEFAULT GETDATE(),
  fecha_actualizacion DATETIME NOT NULL
);

-- Crear tabla para los clientes
CREATE TABLE VENTAS.Clientes (
  id_cliente char(4) PRIMARY KEY CHECK(id_cliente LIKE'C[0-9][0-9][0-9]'),
  tipo_cliente varchar(20) NOT NULL,
  nombre_cliente varchar(100) NOT NULL,
  direccion_cliente varchar(200) NOT NULL,
  telefono_cliente varchar(15) NOT NULL,
  fecha_creacion DATETIME DEFAULT GETDATE(),
  fecha_actualizacion DATETIME NOT NULL
);

DROP TABLE VENTAS.Clientes

INSERT INTO VENTAS.Clientes (id_cliente, tipo_cliente, nombre_cliente, direccion_cliente, telefono_cliente, fecha_actualizacion)
VALUES 
('C001', 'Persona Natural', 'Ana Rodríguez', 'Av. Los Incas 205 Mz. A Lt. 7 Ex. Av. Circunvalacion - Ate', '986132456', GETDATE()),
('C002', 'Persona Natural', 'Juan Pérez', 'Av. Argentina No. 3093, Local 174, Calle 2, Pabellón 1, Callao', '987654132', GETDATE()),
('C003', 'Persona Natural', 'María López', 'Av. Alfredo Mendiola N° 3698, Valle De La Piedra Liza, Independencia', '989654345', GETDATE()),
('C004', 'Persona Natural', 'Carlos Gómez', 'Av. Salaverry 2400 - CC Real Plaza', '999345654', GETDATE()),
('C005', 'Persona Natural', 'Laura Martínez', 'Alm. Alfonso Ugarte Esq. Con Av. Del Progreso', '987654198', GETDATE()),
('C006', 'Persona Jurídica', 'Inversiones R&C Ltda.', 'Av. Republica Dominicana 505', '912323465', GETDATE()),
('C007', 'Persona Jurídica', 'Grupo Empresarial X S.A.S.', 'Av. Antúnez de Mayolo 1001-A, Urbanización Mercurio', '985165187', GETDATE()),
('C008', 'Persona Jurídica', 'Corporación Z LTDA.', 'Av. Gran Chimu 378-A 1er Piso, Urb. Zarate', '987112223', GETDATE()),
('C009', 'Persona Jurídica', 'Compañía Y & C S.A.', 'AV. CIRCUNVALACIÓN 1803 TIENDA ANCLA 3 SJM', '900876546', GETDATE()),
('C010', 'Persona Jurídica', 'Empresa de Servicios Técnicos E.C.', 'CC Open Plaza Atocongo - AV. CIRCUNVALACION 1801 - MODULO M-18', '907876564', GETDATE()),
('C011', 'Persona Natural', 'Pedro Gutiérrez', 'Av. San Juan 1143', '987646352', GETDATE()),
('C012', 'Persona Natural', 'Lucía Ramírez', 'AV. PEDRO MIOTTA ESQ CON AV. ALIPIO PONCE', '900023445', GETDATE()),
('C013', 'Persona Natural', 'Fernando González', 'CC Megaplaza - Av Alfredo Mendiola 3698, M75', '997612112', GETDATE()),
('C014', 'Persona Natural', 'Sara Vélez', ' AV CIRCUNVALACION 1803', '912133443', GETDATE()),
('C015', 'Persona Natural', 'Mario Buitrago', 'Av. Javier Prado Este #1059', '987345234', GETDATE());



-- Crear tabla para los pedidos
CREATE TABLE VENTAS.Pedidos (
  id_pedido char(6) PRIMARY KEY CHECK(id_pedido LIKE'Ped[0-9][0-9][0-9]'),
  fecha_pedido datetime NOT NULL,
  id_cliente char(4) NOT NULL,
  id_empleado char(4) NOT NULL,
  id_vehiculo CHAR(4) NOT NULL,
  CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES Ventas.Clientes(id_cliente),
  CONSTRAINT fk_empleado FOREIGN KEY (id_empleado) REFERENCES Operaciones.Empleados(id_empleado),
  CONSTRAINT fk_vehiculo FOREIGN KEY (id_vehiculo) REFERENCES Operaciones.Vehiculos(id_vehiculo),
  fecha_creacion DATETIME DEFAULT GETDATE(),
  fecha_actualizacion DATETIME NOT NULL
);


INSERT INTO VENTAS.Pedidos 
(id_pedido, fecha_pedido, id_cliente, id_empleado, id_vehiculo, fecha_actualizacion)
VALUES 
('Ped001', '2023-01-01', 'C001', 'E001', 'V003', GETDATE()),
('Ped002', '2023-01-05', 'C010', 'E002', 'V002', GETDATE()),
('Ped003', '2023-01-15', 'C005', 'E002', 'V008', GETDATE()),
('Ped004', '2023-01-20', 'C008', 'E002', 'V010', GETDATE()),
('Ped005', '2023-01-22', 'C001', 'E002', 'V012', GETDATE()),
('Ped006', '2023-01-30', 'C009', 'E001', 'V002', GETDATE()),
('Ped007', '2023-02-07', 'C010', 'E002', 'V005', GETDATE()),
('Ped008', '2023-02-08', 'C010', 'E002', 'V006', GETDATE()),
('Ped009', '2023-02-09', 'C001', 'E004', 'V002', GETDATE()),
('Ped010', '2023-02-10', 'C004', 'E001', 'V002', GETDATE()),
('Ped011', '2023-02-11', 'C010', 'E002', 'V002', GETDATE()),
('Ped012', '2023-02-12', 'C001', 'E002', 'V004', GETDATE()),
('Ped013', '2023-03-13', 'C004', 'E002', 'V003', GETDATE()),
('Ped014', '2023-03-14', 'C002', 'E002', 'V002', GETDATE()),
('Ped015', '2023-04-15', 'C005', 'E002', 'V001', GETDATE());


-- Crear tabla para los detalles de los pedidos
CREATE TABLE VENTAS.Detalles_Pedido (
  id_detalle_pedido int PRIMARY KEY,
  id_pedido char(6) NOT NULL,
  id_producto char(7) NOT NULL,
  cantidad decimal(10,2) NOT NULL,
  CONSTRAINT fk_pedido FOREIGN KEY (id_pedido) REFERENCES Ventas.Pedidos(id_pedido),
  CONSTRAINT fk_producto_detalle_pedido FOREIGN KEY (id_producto) REFERENCES Inventario.Productos(id_producto),
  fecha_creacion DATETIME DEFAULT GETDATE(),
  fecha_actualizacion DATETIME NOT NULL
);


--CREAR 15 REGISTROS DE LA TABLA DE Ventas.Detalles_Pedido
INSERT INTO VENTAS.Detalles_Pedido
(id_detalle_pedido, id_pedido, id_producto, cantidad, fecha_actualizacion)
VALUES
(1, 'Ped001', 'Prod001', 300, GETDATE()),
(2, 'Ped002', 'Prod001', 200, GETDATE()),
(3, 'Ped003', 'Prod002', 500, GETDATE()),
(4, 'Ped004', 'Prod004', 100, GETDATE()),
(5, 'Ped005', 'Prod002', 250, GETDATE()),
(6, 'Ped006', 'Prod002', 400, GETDATE()),
(7, 'Ped007', 'Prod001', 200, GETDATE()),
(8, 'Ped008', 'Prod002', 600, GETDATE()),
(9, 'Ped009', 'Prod004', 100, GETDATE()),
(10, 'Ped010', 'Prod001', 250, GETDATE()),
(11, 'Ped011', 'Prod002', 500, GETDATE()),
(12, 'Ped012', 'Prod003', 70, GETDATE()),
(13, 'Ped013', 'Prod002', 500, GETDATE()),
(14, 'Ped014', 'Prod002', 600, GETDATE()),
(15, 'Ped015', 'Prod004', 200, GETDATE());



-- Crear tabla para las facturas
CREATE TABLE VENTAS.Facturas (
  id_factura char(7) PRIMARY KEY CHECK(id_factura LIKE'Fact[0-9][0-9][0-9]'),
  id_pedido char(6) NOT NULL,
  fecha_factura datetime NOT NULL,
  CONSTRAINT fk_pedido_factura FOREIGN KEY (id_pedido) REFERENCES Ventas.Pedidos(id_pedido),
  fecha_creacion DATETIME DEFAULT GETDATE(),
  fecha_actualizacion DATETIME NOT NULL
);


INSERT INTO VENTAS.Facturas
(id_factura, id_pedido, fecha_factura, fecha_actualizacion)
VALUES
('Fact001', 'Ped001', '2023-01-01', GETDATE()),
('Fact002', 'Ped002', '2023-01-05', GETDATE()),
('Fact003', 'Ped003', '2023-01-15', GETDATE()),
('Fact004', 'Ped004', '2023-01-20', GETDATE()),
('Fact005', 'Ped005', '2023-01-22', GETDATE()),
('Fact006', 'Ped006', '2023-01-30', GETDATE()),
('Fact007', 'Ped007', '2023-02-07', GETDATE()),
('Fact008', 'Ped008', '2023-02-08', GETDATE()),
('Fact009', 'Ped009', '2023-02-09', GETDATE()),
('Fact010', 'Ped010', '2023-02-10', GETDATE()),
('Fact011', 'Ped011', '2023-02-11', GETDATE()),
('Fact012', 'Ped012', '2023-02-12', GETDATE()),
('Fact013', 'Ped013', '2023-03-13', GETDATE()),
('Fact014', 'Ped014', '2023-03-14', GETDATE()),
('Fact015', 'Ped015', '2023-04-15', GETDATE());




-- Crear tabla para los recibos
CREATE TABLE VENTAS.Recibos (
  id_recibo char(6) PRIMARY KEY CHECK(id_recibo LIKE'Rec[0-9][0-9][0-9]'),
  id_pedido char(6) NOT NULL,
  monto_total decimal(10,2) NOT NULL,
  fecha_recibo datetime NOT NULL,
  CONSTRAINT fk_pedido_recibo FOREIGN KEY (id_pedido) REFERENCES Ventas.Pedidos(id_pedido),
  fecha_creacion DATETIME DEFAULT GETDATE(),
  fecha_actualizacion DATETIME NOT NULL
);

--generame 15 registros de la tabla de Ventas.Recibos
INSERT INTO VENTAS.Recibos
(id_recibo, id_pedido, monto_total, fecha_recibo, fecha_actualizacion)
VALUES
('Rec001', 'Ped001', 300, '2023-01-01', GETDATE()),
('Rec002', 'Ped002', 200, '2023-01-05', GETDATE()),
('Rec003', 'Ped003', 500, '2023-01-15', GETDATE()),
('Rec004', 'Ped004', 100, '2023-01-20', GETDATE()),
('Rec005', 'Ped005', 250, '2023-01-22', GETDATE()),
('Rec006', 'Ped006', 400, '2023-01-30', GETDATE()),
('Rec007', 'Ped007', 200, '2023-02-07', GETDATE()),
('Rec008', 'Ped008', 600, '2023-02-08', GETDATE()),
('Rec009', 'Ped009', 100, '2023-02-09', GETDATE()),
('Rec010', 'Ped010', 250, '2023-02-10', GETDATE()),
('Rec011', 'Ped011', 500, '2023-02-11', GETDATE()),
('Rec012', 'Ped012', 70, '2023-02-12', GETDATE()),
('Rec013', 'Ped013', 500, '2023-03-13', GETDATE()),
('Rec014', 'Ped014', 600, '2023-03-14', GETDATE()),
('Rec015', 'Ped015', 200, '2023-04-15', GETDATE());



/*==============================================================*/
-- VIASUALIZAR LOS FILEGROUPS Y BASES DE DATOS QUE EXISTEN EN EL SERVIDOR

SELECT * FROM sys.sysdatabases
GO
SELECT * FROM sys.filegroups
GO
SP_HELPDB [ECORP]
GO

/*==============================================================*/
--CREA EL SNAPSHOT
-- RECUERDA USAR EL NOMBRE DEL ARCHIVO Y NO EL NOMBRE DE LA BASE DE DATOS PARA CREAR EL SNAPSHOT
USE MASTER;
GO


CREATE DATABASE SNAPSHOT_ECORP_MARCH_2023 ON 
(
    NAME = 'SNAPSHOT_ECORP_MARCH_2023', --NOMBRE DEL ARCHIVO
    FILENAME = 'C:\database\SNAPSHOT_ECORP_MARCH_2023.ss'
)
AS SNAPSHOT OF ECORP; --NOMBRE DE LA BASE DE DATOS


/*==============================================================*/
-- RECUERDA QUE EL QUERY DEBE SER CREADO DESDE EL SERVER PRINCIPAL Y NO DESDE UN USUARIO
USE ECORP
GO

--CREAREMOS UN NUEVO USUARIO
CREATE LOGIN MANAGERSELLER WITH PASSWORD='t2j8X6$k'
GO

/*==============================================================*/
--CONCEDER PERMISOS PARA EL USUARIO SISTEMASUNI

SP_ADDUSER [MANAGERSELLER], ADMINISTRADOR
GO

GRANT SELECT, INSERT, UPDATE, DELETE ON VENTAS.Clientes TO ADMINISTRADOR
GRANT SELECT, INSERT, UPDATE, DELETE ON VENTAS.Pedidos TO ADMINISTRADOR
GRANT SELECT, INSERT, UPDATE, DELETE ON VENTAS.Detalles_Pedido TO ADMINISTRADOR
GRANT SELECT, INSERT, UPDATE, DELETE ON VENTAS.Facturas TO ADMINISTRADOR
GRANT SELECT, INSERT, UPDATE, DELETE ON VENTAS.Recibos TO ADMINISTRADOR

-- DENEGAR PERMISOS
REVOKE SELECT, INSERT, UPDATE, DELETE ON VENTAS.Clientes TO ADMINISTRADOR
REVOKE SELECT, INSERT, UPDATE, DELETE ON VENTAS.Pedidos TO 	ADMINISTRADOR
REVOKE SELECT, INSERT, UPDATE, DELETE ON VENTAS.Detalles_Pedido TO ADMINISTRADOR
REVOKE SELECT, INSERT, UPDATE, DELETE ON VENTAS.Facturas TO ADMINISTRADOR
REVOKE SELECT, INSERT, UPDATE, DELETE ON VENTAS.Recibos TO ADMINISTRADOR


--OTORGAR PERMISOS PARA EL USUARIO , VISTAS , FUNCIONES , PROCEDIMIENTO ALMACENADO 

GRANT CREATE TABLE, CREATE FUNCTION, CREATE PROCEDURE, CREATE VIEW, EXECUTE TO ADMINISTRADOR

--DENEGAR PERMISOS PARA EL USUARIO , VISTAS , FUNCIONES , PROCEDIMIENTO ALMACENADO

REVOKE CREATE TABLE, CREATE FUNCTION, CREATE PROCEDURE, CREATE VIEW, EXECUTE TO ADMINISTRADOR
GO


/*==============================================================*/
--ROLES DE SERVIDOR
--AGREGAR AL NUEVO USUARIO COMO SYSADMIN


SP_ADDSRVROLEMEMBER MANAGERSELLER,[sysadmin]
GO

--QUITAR AL NUEVO USUARIO COMO SYSADMIN

SP_DROPSRVROLEMEMBER [MANAGERSELLER],[sysadmin]
GO

--AGREGAR AL NUEVO USUARIO COMO DBCREATOR , PARA CREAR UNA BD.

SP_ADDSRVROLEMEMBER [MANAGERSELLER],[dbcreator]
GO

SP_DROPSRVROLEMEMBER [MANAGERSELLER],[dbcreator]
GO

--AGREGAR AL NUEVO USUARIO COMO SCURITYADMIN , CREAR UN LOGIN SISTEMASUNI
SP_ADDSRVROLEMEMBER [MANAGERSELLER],[securityadmin]
GO

SP_DROPSRVROLEMEMBER [MANAGERSELLER],[securityadmin]