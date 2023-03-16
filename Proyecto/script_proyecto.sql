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




/*==============================================================*/
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
-- VIASUALIZAR LOS FILEGROUPS Y BASES DE DATOS QUE EXISTEN EN EL SERVIDOR
SELECT * FROM sys.sysdatabases
GO
SELECT * FROM sys.filegroups
GO
SP_HELPDB [ECORP]
GO





/*==============================================================*/
--USAR LA BASE DE DATOS
USE ECORP
GO

-- CREAR LOS SCHEMAS
CREATE SCHEMA PROVEEDORES;
GO
CREATE SCHEMA INVENTARIO;
GO
CREATE SCHEMA OPERACIONES;
GO
CREATE SCHEMA VENTAS;
GO







--USAR LA BASE DE DATOS
USE ECORP
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
(id_proveedor, nombre_proveedor, 
direccion_proveedor, telefono_proveedor, 
ciudad_proveedor, pais_proveedor, 
fecha_actualizacion)
VALUES
('Prov001', 'La Vaquita Mu', 'Av. Canadá 3359 - La Victoria', '970428484', 'Lima', 'Perú', GETDATE()),
('Prov002', 'Gusto''s', 'Los Ajenjos M-E L-7 - Ate Vitarte', '97342725', 'Lima', 'Perú', GETDATE()),
('Prov003', 'Tu Mercado SAC', 'Av. Petit Thouars 1175 - Lince', '936923085', 'Lima', 'Perú', GETDATE()),
('Prov004', 'Tío Sergio SAC', 'Vargas Machuca 556 - Santa Anita', '933680027', 'Lima', 'Perú', GETDATE()),
('Prov005', 'Expotadores camal SAC', 'av. mariategui', '976162551', 'Lima', 'Perú', GETDATE()),
('Prov006', 'Amazon andes export SAC', 'CAL. RUY DIAZ 239. Callao.. C.P. callao1, Callao', '7342725', 'Callao', 'Perú', GETDATE()),
('Prov007', 'bakels', 'Av. La Arboleda 298 Urb. Santa Raquel Lima 03', '16184640', 'Lima', 'Perú', GETDATE()),
('Prov008', 'Corporacion Vega Productores Santa Anita', 'Av. La Cultura s/n Psje. B Puesto 13 Santa Anita', '(01) 3547522', 'Lima', 'Perú', GETDATE()),
('Prov009', 'Inversiones Ray S.A.C.', 'Avenida Mercado de Productores Santa Anita', '946-531478', 'Lima', 'Perú', GETDATE()),
('Prov010', 'Fas Group Carnes y Máss', 'av. los héroes s/n CIUDAD DE DIOS. San Juan De Miraflore', '997462847', 'Lima', 'Perú', GETDATE()),
('Prov011', 'Carnes Sabrosas Peru', 'calle los blanquillos 299. Los Olivos.. C.P. 051', '4856826', 'Lima', 'Perú', GETDATE()),
('Prov012', 'Campo grande perú', 'Jr. Teofilo Castillo 771', '(51) 987 635', 'Lima', 'Perú', GETDATE()),
('Prov013', 'Inversiones agroindustrial', 'Av. Javier Prado Este 1234', '51-789-0123', 'Lima', 'Perú', GETDATE()),
('Prov014', 'Agro exportadora ruiz e.i.r.l.', 'Calle Los Ficus 456', '51-012-345', 'Lima', 'Perú', GETDATE()),
('Prov015', 'Comvenperu', 'Jirón Cuzco 789', '998-345-678', 'Lima', 'Perú', GETDATE());
GO


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

INSERT INTO PROVEEDORES.Proveedores_Producto 
(id_proveedor_producto, nombre_proveedor_producto, 
descripcion_proveedor_producto, precio_proveedor_producto, 
id_proveedor, fecha_actualizacion)
VALUES
(1,'leche','1 litro de leche',4.50,'Prov001',GETDATE()),
(2,'mantequilla','1 kg de mantequilla',48.80,'Prov001',GETDATE()),
(3,'esencia de vainilla','1 litro de esencia de vainilla',10.90,'Prov002',GETDATE()),
(4,'fermento','1/2 litro de fermento',58.90,'Prov002',GETDATE()),
(5,'harina','1 kg de harina',5.90,'Prov002',GETDATE()),
(6,'azúcar','1 kg de azúcar',4.90,'Prov002',GETDATE()),
(7,'sal','1 kg de sal',1.80,'Prov002',GETDATE()),
(8,'canela','1 kg de canela',36.90,'Prov002',GETDATE()),
(9,'anis','1 kg de anis',23.50,'Prov002',GETDATE()),
(10,'vinagre','1 litro de vinagre',4.70,'Prov002',GETDATE()),
(11,'fresa','1 kg de fresa',3.19,'Prov003',GETDATE()),
(12,'choclo','1 unidad de choclo',2.00,'Prov003',GETDATE()),
(13,'maíz pelado','1 kg de maíz pelado',240.00,'Prov003',GETDATE()),
(14,'cebolla','1 kg de cebolla',2.29,'Prov003',GETDATE()),
(15,'achiote','1 kg de achiote',43.00,'Prov003',GETDATE()),
(16,'camote','1 kg de camote',4.99,'Prov003',GETDATE()),
(17,'pasas','1 kg de pasas',145.00,'Prov003',GETDATE()),
(18,'ají panca','1 kg de ají panca',13.90,'Prov003',GETDATE()),
(19,'pimienta','10 gr de pimienta',1.00,'Prov003',GETDATE()),
(20,'manteca de cerdo','1 kg de manteca de cerdo',89.90,'Prov004',GETDATE()),
(21,'carne de cerdo','1 kg de carne de cerdo',17.50,'Prov004',GETDATE());



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


INSERT INTO INVENTARIO.Ingredientes
(id_ingrediente, nombre_ingrediente, id_proveedor, id_proveedor_producto, fecha_actualizacion)
VALUES
(1,'leche','Prov001',1, GETDATE()),
(2,'mantequilla','Prov001',2, GETDATE()),
(3,'esencia de vainilla','Prov002',3, GETDATE()),
(4,'fermento','Prov002',4, GETDATE()),
(5,'harina','Prov002',5, GETDATE()),
(6,'azúcar','Prov002',6, GETDATE()),
(7,'sal','Prov002',7, GETDATE()),
(8,'canela','Prov002',8, GETDATE()),
(9,'anis','Prov002',9, GETDATE()),
(10,'vinagre','Prov002',10, GETDATE()),
(11,'fresa','Prov003',11, GETDATE()),
(12,'choclo','Prov003',12, GETDATE()),
(13,'maíz pelado','Prov003',13, GETDATE()),
(14,'cebolla','Prov003',14, GETDATE()),
(15,'achiote','Prov003',15, GETDATE()),
(16,'camote','Prov003',16, GETDATE()),
(17,'pasas','Prov003',17, GETDATE()),
(18,'ají panca','Prov003',18, GETDATE()),
(19,'pimienta','Prov003',19, GETDATE()),
(20,'manteca de cerdo','Prov004',20, GETDATE()),
(21,'carne de cerdo','Prov004',21, GETDATE());



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


INSERT INTO INVENTARIO.Detalles_Producto_Ingrediente
(id_detalle, id_producto, id_ingrediente, cantidad, fecha_actualizacion)
VALUES
(1,'Prod001',1,1.00,GETDATE()),
(2,'Prod001',3,1.00,GETDATE()),
(3,'Prod001',11,1.00,GETDATE()),
(4,'Prod002',5,1.00,GETDATE()),
(5,'Prod002',6,1.00,GETDATE()),
(6,'Prod002',7,1.00,GETDATE()),
(7,'Prod002',8,1.00,GETDATE()),
(8,'Prod002',9,1.00,GETDATE()),
(9,'Prod002',9,1.00,GETDATE()),
(10,'Prod002',13,1.00,GETDATE()),
(11,'Prod003',16,1.00,GETDATE()),
(12,'Prod003',6,1.00,GETDATE()),
(13,'Prod004',18,1.00,GETDATE()),
(14,'Prod004',19,1.00,GETDATE()),
(15,'Prod004',20,1.00,GETDATE()),
(16,'Prod004',21,1.00,GETDATE()),
(17,'Prod004',13,1.00,GETDATE()),
(18,'Prod004',7,1.00,GETDATE()),
(19,'Prod004',14,1.00,GETDATE()),
(20,'Prod004',15,1.00,GETDATE());



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


INSERT INTO INVENTARIO.Solicitudes_Compra
(id_solicitud, id_producto, cantidad, fecha_solicitud, fecha_actualizacion)
VALUES
(1,'Prod001',200,'2023-01-01',GETDATE()),
(2,'Prod002',300,'2023-01-02',GETDATE()),
(3,'Prod003',400,'2023-01-03',GETDATE()),
(4,'Prod004',500,'2023-01-04',GETDATE()),
(5,'Prod001',200,'2023-01-05',GETDATE()),
(6,'Prod002',300,'2023-01-06',GETDATE()),
(7,'Prod003',400,'2023-01-07',GETDATE()),
(8,'Prod004',500,'2023-01-08',GETDATE()),
(9,'Prod001',200,'2023-01-09',GETDATE()),
(10,'Prod002',300,'2023-01-10',GETDATE()),
(11,'Prod003',400,'2023-01-11',GETDATE()),
(12,'Prod004',500,'2023-01-12',GETDATE()),
(13,'Prod001',200,'2023-01-13',GETDATE()),
(14,'Prod002',300,'2023-01-14',GETDATE()),
(15,'Prod003',400,'2023-01-15',GETDATE()),
(16,'Prod004',500,'2023-01-16',GETDATE()),
(17,'Prod001',200,'2023-01-17',GETDATE()),
(18,'Prod002',300,'2023-01-18',GETDATE()),
(19,'Prod003',400,'2023-01-19',GETDATE()),
(20,'Prod004',500,'2023-01-20',GETDATE());


-- Crear tabla para las ordenes de compra
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


INSERT INTO INVENTARIO.Ordenes_Compra
(id_orden, id_solicitud, fecha_orden, id_proveedor, fecha_actualizacion)
VALUES
(1,1,'2023-01-01','Prov001',GETDATE()),
(2,2,'2023-01-02','Prov002',GETDATE()),
(3,3,'2023-01-03','Prov003',GETDATE()),
(4,4,'2023-01-04','Prov004',GETDATE()),
(5,5,'2023-01-05','Prov001',GETDATE()),
(6,6,'2023-01-06','Prov002',GETDATE()),
(7,7,'2023-01-07','Prov003',GETDATE()),
(8,8,'2023-01-08','Prov004',GETDATE()),
(9,9,'2023-01-09','Prov001',GETDATE()),
(10,10,'2023-01-10','Prov002',GETDATE()),
(11,11,'2023-01-11','Prov003',GETDATE()),
(12,12,'2023-01-12','Prov004',GETDATE()),
(13,13,'2023-01-13','Prov001',GETDATE()),
(14,14,'2023-01-14','Prov002',GETDATE()),
(15,15,'2023-01-15','Prov003',GETDATE()),
(16,16,'2023-01-16','Prov004',GETDATE()),
(17,17,'2023-01-17','Prov001',GETDATE()),
(18,18,'2023-01-18','Prov002',GETDATE()),
(19,19,'2023-01-19','Prov003',GETDATE()),
(20,20,'2023-01-20','Prov004',GETDATE());


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


INSERT INTO INVENTARIO.Detalles_Orden_Compra
(id_detalle_orden, id_orden, id_ingrediente, cantidad, fecha_actualizacion)
VALUES
(1,1,1,25,GETDATE()),
(2,2,2,30,GETDATE()),
(3,3,3,40,GETDATE()),
(4,4,4,5,GETDATE()),
(5,5,1,10,GETDATE()),
(6,6,2,30,GETDATE()),
(7,7,3,40,GETDATE()),
(8,8,4,50,GETDATE()),
(9,9,1,20,GETDATE()),
(10,10,2,30,GETDATE()),
(11,11,3,40,GETDATE()),
(12,12,4,50,GETDATE()),
(13,13,1,20,GETDATE()),
(14,14,2,30,GETDATE()),
(15,15,3,40,GETDATE()),
(16,16,4,50,GETDATE()),
(17,17,1,20,GETDATE()),
(18,18,2,30,GETDATE()),
(19,19,3,40,GETDATE()),
(20,20,4,50,GETDATE());

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
/*====================CREACIÓN DE BACKUP========================*/
--BACKUP COMPRIMIDO
 BACKUP DATABASE BD_ECORP
 TO DISK= 'C:\database\BD_ECORP_FULL.BAK'
	WITH INIT,
	NAME='COPIA COMPLETA',
	DESCRIPTION='COPIA DIARIA DE LA BASE DE DATOS ECORP',
	STATS=10,
	FORMAT, COMPRESSION
GO

-- BACKUP DIFERENCIAL
BACKUP DATABASE ECORP
TO DISK = 'C:\database\BD_ECORP_DIFF.BAK'
    WITH DIFFERENTIAL,
    NAME='COPIA DIFERENCIAL',
    DESCRIPTION='COPIA DIFERENCIA DE LA BASE DE DATOS ECORP',
    INIT
GO

-- BACKUP DE LOS REGISTROS
BACKUP LOG BD_ECORP
TO DISK = 'C:\database\BD_ECORP_LOG.BAK'
    WITH NAME = 'COPIA DEL LOG',
    DESCRIPTION='COPIA LOG DE LA BASE DE DATOS ECORP',
    INIT



-- EL FILELISTONLY LISTA LA INFORMACION DE ARCHIVOS QUE SE COPIARON EN LA COPIA DE SEGURIDAD (BACKUP)
RESTORE FILELISTONLY
FROM DISK= 'C:\database\BD_ECORP_FULL.BAK'
GO

-- HEADERONLY MUESTRA EL ENCABEZADO (EL NAME) DE LA COPIA DE SEGURIDAD (BACKUP)
RESTORE HEADERONLY
FROM DISK= 'C:\database\BD_ECORP_FULL.BAK'
GO





/*==============================================================*/
/*==================RESTAURACIÓN DE BACKUP======================*/
--EJECUTAR DESDE MASTER
USE MASTER
GO

--RESTAURAR EL BACKUP
RESTORE DATABASE BD_ECORP
FROM DISK = 'C:\database\BD_ECORP_FULL.BAK'
WITH REPLACE, NORECOVERY 


--RESTAURAR EL BACKUP DIFERENCIAL
RESTORE DATABASE BD_ECORP
FROM DISK = 'C:\database\BD_ECORP_DIFF.BAK'
WITH NORECOVERY


--RESTAURAR EL BACKUP DE LOS REGISTROS
RESTORE LOG BD_ECORP
FROM DISK = 'C:\database\BD_ECORP_LOG.BAK'
WITH NORECOVERY
GO


RESTORE LOG BD_ECORP
WITH RECOVERY;	   --SE UTILIZA CUANDO YA SE FINALIZA LA RESTAURACIÓN


--COMPROBANDO LA RESTAURACIÓN
USE BD_ECORP

SELECT * FROM TBLCIUDAD



/*==============================================================*/
/*================ADMINISTRACIÓN DE SEGURIDAD===================*/


/*================MODOS DE AUTENTICIDAD===================*/

/* 
En el caso de SQL Server, los modos de autenticación se refieren a los diferentes 
métodos que se pueden utilizar para autenticar a los usuarios que intentan acceder 
a la base de datos. Los modos de autenticación disponibles en SQL Server son:

Autenticación de Windows: En este modo de autenticación, los usuarios se autentican 
utilizando sus credenciales de inicio de sesión de Windows. Este modo es el más seguro 
y recomendado, ya que utiliza la infraestructura de seguridad de Windows.

Autenticación de SQL Server: En este modo de autenticación, los usuarios se autentican 
utilizando un nombre de usuario y una contraseña específicos de SQL Server. Este modo 
es menos seguro que la autenticación de Windows, ya que las credenciales se transmiten 
en texto plano y pueden ser interceptadas.
*/


/*================CREACIÓN DE USUARIOS===================*/

USE ECORP
GO

--CREAREMOS UN NUEVO USUARIO
CREATE LOGIN MANAGERSELLER WITH PASSWORD='t2j8X6$k'
GO


/*================USO DE CREDENCIALES Y PERMISOS===================*/
--AGREGAR AL USER COMO ADMINISTRADOR
SP_ADDUSER [MANAGERSELLER], ADMINISTRADOR
GO

--DAR PERMISOS DE DML A UN USUARIO
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

/*================ROLES DE SERVIDOR===================*/


/*SYSADMIN*/
/* Este es el rol de servidor más alto en SQL Server y permite a los usuarios realizar 
cualquier tarea en el servidor, incluyendo la creación de bases de datos, la 
configuración de seguridad y el mantenimiento de la instancia.*/


--AGREGAR AL NUEVO USUARIO COMO SYSADMIN

SP_ADDSRVROLEMEMBER MANAGERSELLER,[sysadmin]
GO

--QUITAR AL NUEVO USUARIO COMO SYSADMIN

SP_DROPSRVROLEMEMBER [MANAGERSELLER],[sysadmin]
GO


/*SERVERADMIN*/
/*
Este rol permite a los usuarios administrar la seguridad 
en SQL Server, como la creación de usuarios y roles, la configuración de 
permisos y la administración de claves de cifrado.
*/

--AGREGAR AL NUEVO USUARIO COMO SERVERADMIN
SP_ADDSRVROLEMEMBER [MANAGERSELLER],[serveradmin]
GO

--QUITAR AL NUEVO USUARIO COMO SERVERADMIN
SP_DROPSRVROLEMEMBER [MANAGERSELLER],[serveradmin]
GO

/*SEPUPADMIN*/
/* Este rol permite a los usuarios instalar y configurar SQL Server en el servidor.*/

--AGREGAR AL NUEVO USUARIO COMO SEPUPADMIN
SP_ADDSRVROLEMEMBER [MANAGERSELLER],[setupadmin]
GO

--QUITAR AL NUEVO USUARIO COMO SEPUPADMIN
SP_DROPSRVROLEMEMBER [MANAGERSELLER],[setupadmin]
GO


/*SECURITYADMIN*/
/* 
Este rol permite a los usuarios administrar la configuración 
del servidor, como la configuración de memoria, la configuración de red y 
la configuración del servidor de correo electrónico.
*/

SP_ADDSRVROLEMEMBER [MANAGERSELLER],[securityadmin]
GO

SP_DROPSRVROLEMEMBER [MANAGERSELLER],[securityadmin]
GO

/*PROCESSADMIN*/
/* 
Este rol permite a los usuarios administrar los procesos en SQL Server, 
como la detención y reinicio de servicios y la administración de trabajos.
*/
-- AGREGAR AL NUEVO USUARIO COMO PROCESSADMIN
SP_ADDSRVROLEMEMBER [MANAGERSELLER],[processadmin]
GO

-- QUITAR AL NUEVO USUARIO COMO PROCESSADMIN

SP_DROPSRVROLEMEMBER [MANAGERSELLER],[processadmin]
GO

/*DBCREATOR*/
/* Este rol permite a los usuarios crear bases de datos en SQL Server */
-- AGREGAR AL NUEVO USUARIO COMO DBCREATOR
SP_ADDSRVROLEMEMBER [MANAGERSELLER],[dbcreator]
GO

-- QUITAR AL NUEVO USUARIO COMO DBCREATOR
SP_DROPSRVROLEMEMBER [MANAGERSELLER],[dbcreator]
GO


/*BULKADMIN*/
/* Este rol permite a los usuarios realizar operaciones de importación y 
exportación masiva de datos en SQL Server. */

-- AGREGAR AL NUEVO USUARIO COMO BULKADMIN
SP_ADDSRVROLEMEMBER [MANAGERSELLER],[bulkadmin]
GO

-- QUITAR AL NUEVO USUARIO COMO BULKADMIN
SP_DROPSRVROLEMEMBER [MANAGERSELLER],[bulkadmin]
GO

/*DB_OWNER*/

-- AGREGAR AL NUEVO USUARIO COMO DB_OWNER
SP_ADDSRVROLEMEMBER [MANAGERSELLER],[db_owner]
GO

-- QUITAR AL NUEVO USUARIO COMO DB_OWNER
SP_DROPSRVROLEMEMBER [MANAGERSELLER],[db_owner]
GO

/*DB_DATAREADER*/
/* Este rol permite a los usuarios leer datos de las tablas de una base de datos. */
-- AGREGAR AL NUEVO USUARIO COMO DB_DATAREADER
SP_ADDSRVROLEMEMBER [MANAGERSELLER],[db_datareader]
GO

-- QUITAR AL NUEVO USUARIO COMO DB_DATAREADER
SP_DROPSRVROLEMEMBER [MANAGERSELLER],[db_datareader]
GO



/*==============================================================*/
/*================MODOS DE TRANSFERENCIA DE DATOS================*/
USE ECORP
GO

--CREAMOS UNA NUEVA TABLA LLAMADA Tabla_Pedidos_Febrero
SELECT
p.id_pedido AS Pedido,
p.fecha_pedido AS Fecha_Pedido,
c.nombre_cliente AS Cliente,
c.direccion_cliente AS Direccion,
c.telefono_cliente AS Telefono,
dp.id_producto AS Producto,
dp.cantidad AS Cantidad,
f.fecha_factura AS Fecha_Factura,
r.fecha_recibo AS Fecha_Recibo
INTO VENTAS.Tabla_Pedidos_Clientes
FROM
VENTAS.Pedidos p
JOIN VENTAS.Clientes c ON p.id_cliente = c.id_cliente
JOIN VENTAS.Detalles_Pedido dp ON p.id_pedido = dp.id_pedido
JOIN VENTAS.Facturas f ON p.id_pedido = f.id_pedido
JOIN VENTAS.Recibos r ON p.id_pedido = r.id_pedido
GO

SELECT * FROM  ECORP.VENTAS.Tabla_Pedidos_Clientes
GO

--EJECUTAREMOS EL SIGUIENTE CODIGO EN LA TERMINAL USANDO EL CLI BCP
--BCP ECORP.VENTAS.Tabla_Pedidos_Clientes OUT C:\database\Tabla_Pedidos_Clientes.TXT -S . -T -c

--HACIENDO UNA CONSULTA Y GUARDANDO EL RESULTADO EN UN ARCHIVO DE TEXTO
/*
BCP "SELECT * FROM ECORP.VENTAS.Tabla_Pedidos_Clientes p WHERE MONTH(p.fecha_pedido) = 1" QUERYOUT C:\database\Tabla_Pedidos_Clientes_Enero.TXT -S . -T -c
 */


 /*==============================================================*/
/*===================CARGA MASIVA DE DATOS======================*/


--EJECUTAREMOS EL SIGUIENTE CODIGO EN LA TERMINAL USANDO EL CLI BCP
--BCP ECORP.VENTAS.Tabla_Pedidos_Clientes IN C:\database\Tabla_Pedidos_Clientes.TXT -S . -T -c


--CARGANDO DATOS MASICOS CON SENTECIA SQL
USE ECORP
GO

SELECT * FROM ECORP.VENTAS.Tabla_Pedidos_Clientes

--ELIMINA LOS REGISTROS
TRUNCATE TABLE ECORP.VENTAS.Tabla_Pedidos_Clientes


--CARGA LOS DATOS
BULK INSERT ECORP.VENTAS.Tabla_Pedidos_Clientes
FROM 'C:\database\Tabla_Pedidos_Clientes.TXT'



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

/*==============================================================*/
 --ABRIR UN NUEVO QUERY DESDE EL NUEVO USUARIO
USE ECORP
GO


/*==============================================================*/
/*==========================TRIGGER==============================*/
--CREAR UN TRIGGER PARA ACTUALIZAR LA FECHA DE ACTUALIZACION DE LA TABLA CLIENTES
CREATE TABLE VENTAS.Clientes_Auditoria (
  nro_registro int IDENTITY,
  id_cliente char(4),
  tipo_cliente varchar(20) NOT NULL,
  nombre_cliente varchar(100) NOT NULL,
  direccion_cliente varchar(200) NOT NULL,
  telefono_cliente varchar(15) NOT NULL,
  fecha_actualizacion DATETIME NOT NULL,
  accion varchar(15) NOT NULL,
);
GO

CREATE TRIGGER Ventas_Auditoria
ON VENTAS.Clientes
AFTER INSERT, UPDATE, DELETE
AS
	BEGIN
		DECLARE @fecha DATETIME = GETDATE();
		IF EXISTS(SELECT * FROM inserted)
			BEGIN
				IF EXISTS(SELECT * FROM deleted)
					BEGIN
						INSERT INTO VENTAS.Clientes_Auditoria
						SELECT d.id_cliente, d.tipo_cliente, d.nombre_cliente, d.direccion_cliente, d.telefono_cliente, @fecha, 'update'
						FROM deleted d
						INNER JOIN inserted i ON d.id_cliente = i.id_cliente;
						PRINT 'Se ha realizado una actualizaci�n exitosa en la tabla de auditor�a';
					END
				ELSE
					BEGIN
						INSERT INTO VENTAS.Clientes_Auditoria
						SELECT i.id_cliente, i.tipo_cliente, i.nombre_cliente, i.direccion_cliente, i.telefono_cliente, @fecha, 'insert'
						FROM inserted i;
						PRINT 'Se ha realizado una inserci�n exitosa en la tabla de auditor�a';
					END
			END
		ELSE
			BEGIN
				INSERT INTO VENTAS.Clientes_Auditoria
				SELECT d.id_cliente, d.tipo_cliente, d.nombre_cliente, d.direccion_cliente, d.telefono_cliente, @fecha, 'delete'
				FROM deleted d;
				PRINT 'Se ha realizado una eliminaci�n exitosa en la tabla de auditor�a';
			END
	END;
GO

--ELIMINAR TRIGGER
DROP TRIGGER Ventas_Auditoria


--USAR EL TRIGGER PARA INSERTAR UN REGISTRO
INSERT INTO VENTAS.Clientes
VALUES 
('C020', 'Persona Natural', 'John vargas', 'Calle 123', '987876765', GETDATE(), GETDATE());

--USAR EL TRIGGER PARA ACTUALIZAR UN REGISTRO
UPDATE VENTAS.Clientes
SET nombre_cliente = 'John perez'
WHERE id_cliente = 'C020';


--USAR EL TRIGGER PARA ELIMINAR UN REGISTRO
DELETE FROM VENTAS.Clientes
WHERE id_cliente = 'C020';


--VERIFICAR LA EJECUCION DE ACTUALIZAR, ELIMINADO O INSERTADO DE UN REGISTRO
SELECT * FROM VENTAS.Clientes;
SELECT * FROM VENTAS.Clientes_Auditoria;
GO

/*==============================================================*/
/*===========================VIEWS==============================*/
--CREAR VIEWS
CREATE VIEW VENTASVIEW AS
SELECT
p.id_pedido AS Pedido,
p.fecha_pedido AS Fecha_Pedido,
c.nombre_cliente AS Cliente,
c.direccion_cliente AS Direccion,
c.telefono_cliente AS Telefono,
dp.id_producto AS Producto,
dp.cantidad AS Cantidad,
f.fecha_factura AS Fecha_Factura,
r.fecha_recibo AS Fecha_Recibo
FROM
VENTAS.Pedidos p
JOIN VENTAS.Clientes c ON p.id_cliente = c.id_cliente
JOIN VENTAS.Detalles_Pedido dp ON p.id_pedido = dp.id_pedido
JOIN VENTAS.Facturas f ON p.id_pedido = f.id_pedido
JOIN VENTAS.Recibos r ON p.id_pedido = r.id_pedido;
GO


SELECT * FROM VENTASVIEW
GO

--BORRA UN VIEW
--DROP VIEW DATALECTOR



/*==============================================================*/
/*=========================PROCEDURE============================*/
--CREAR PROCEDIMIENTOS PARA INSERTAR REGISTROS.
CREATE PROCEDURE INSERTCLIENTES
(
	@id_cliente char(4),
    @tipo_cliente varchar(20),
    @nombre_cliente varchar(100),
    @direccion_cliente varchar(200),
    @telefono_cliente varchar(15)
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO VENTAS.Clientes (id_cliente ,tipo_cliente, nombre_cliente, direccion_cliente, telefono_cliente, fecha_actualizacion)
    VALUES (@id_cliente, @tipo_cliente, @nombre_cliente, @direccion_cliente, @telefono_cliente, GETDATE());
END


--EJECUTAR EL PROCEDIMIENTO
EXEC INSERTCLIENTES 
'C020', 'Persona Natural', 'John vargas', 'Calle 123', '987876765'
GO

-- BORRAR PROCEDURE
DROP PROCEDURE INSERTCLIENTES
GO


--CREATE PROCEDURE TO DELETE A RECORD
CREATE PROCEDURE DELETECLIENTES
(
	@id_cliente char(4)
)
AS
BEGIN
	SET NOCOUNT ON;
	DELETE FROM VENTAS.Clientes
	WHERE id_cliente = @id_cliente;
END
GO


DELETE FROM VENTAS.Clientes
WHERE id_cliente = 'C020'

-- BORRAR PROCEDURE
DROP PROCEDURE DELETECLIENTES



/*==============================================================*/
/*==========================CURSOR==============================*/
--CREANDO CURSORES:

--DECLARACION
DECLARE LEERCLIENTES SCROLL CURSOR FOR SELECT * FROM VENTAS.Clientes

--ABRIR EL CURSOS
OPEN LEERCLIENTES

--SENTENCIAS QUE NOS PERMITEN MOVER ENTRE LOS REGISTROS
FETCH NEXT FROM LEERCLIENTES
FETCH PRIOR FROM LEERCLIENTES
FETCH FIRST FROM LEERCLIENTES
FETCH LAST FROM LEERCLIENTES

-- PARA DEJAR DE UTILIZAR EL CURSOR, LO CERRAMOS
CLOSE LEERCLIENTES
GO

DEALLOCATE LEERCLIENTES
GO



/*==============================================================*/
/*=========================STORE PROCEDURE======================*/
--CREAR UN PROCEDIMIENTO ALMACENADO DE MUESTREO DE DATOS:
CREATE PROCEDURE CURSORCLIENTE
AS
DECLARE 
	@ID_CLIENTE CHAR(4),
	@TIPO_CLIENTE VARCHAR(20),
	@NOMBRE_CLIENTE VARCHAR(100),
	@DIRECCION_CLIENTE VARCHAR(200),
	@TELEFONO_CLIENTE VARCHAR(15),
	@FECHA_CREACION DATETIME, 
	@FECHA_ACTUALIZACION DATETIME
DECLARE LEER CURSOR FOR SELECT 
id_cliente, tipo_cliente, nombre_cliente, direccion_cliente, telefono_cliente, fecha_creacion, fecha_actualizacion
FROM VENTAS.Clientes
OPEN LEER
FETCH NEXT FROM LEER INTO @ID_CLIENTE, @TIPO_CLIENTE, @NOMBRE_CLIENTE, @DIRECCION_CLIENTE, @TELEFONO_CLIENTE, @FECHA_CREACION, @FECHA_ACTUALIZACION
WHILE @@FETCH_STATUS=0
				BEGIN
	PRINT CONVERT(CHAR(4),@ID_CLIENTE)+SPACE(3)+CONVERT(CHAR(20),@TIPO_CLIENTE)+SPACE(3)+CONVERT(CHAR(100),@NOMBRE_CLIENTE)+SPACE(3)+CONVERT(CHAR(200),@DIRECCION_CLIENTE)+SPACE(3)+CONVERT(CHAR(15),@TELEFONO_CLIENTE)+SPACE(3)+CONVERT(CHAR(23),@FECHA_CREACION)+SPACE(3)+CONVERT(CHAR(23),@FECHA_ACTUALIZACION)
	PRINT REPLICATE('-',60)
	FETCH NEXT FROM LEER INTO @ID_CLIENTE, @TIPO_CLIENTE, @NOMBRE_CLIENTE, @DIRECCION_CLIENTE, @TELEFONO_CLIENTE, @FECHA_CREACION, @FECHA_ACTUALIZACION
END
CLOSE LEER
DEALLOCATE LEER
GO

--EJECUTAR EL PROCEDIMIENTO ALMACENADO
EXECUTE CURSORCLIENTE
GO

--BORRAR EL PROCEDIMIENTO ALMACENADO
DROP PROCEDURE CURSORCLIENTE
GO



/*==============================================================*/
/*=========================FUNCTION=============================*/
--CREAR UNA FUNCION QUE RETORNA LA TABLA PEDIDOS POR CLIENTE
CREATE FUNCTION PEDIDOS_POR_CLIENTE
(
	@id_cliente char(4)
)
RETURNS TABLE
AS
RETURN(
	SELECT P.*, C.nombre_cliente, C.direccion_cliente 
	FROM VENTAS.Pedidos P 
	INNER JOIN VENTAS.Clientes C ON P.id_cliente = C.id_cliente 
	WHERE C.id_cliente = @id_cliente
)
GO



--EJECUTAR LA FUNCION
SELECT * FROM PEDIDOS_POR_CLIENTE('C001')
SELECT * FROM PEDIDOS_POR_CLIENTE('C002')
