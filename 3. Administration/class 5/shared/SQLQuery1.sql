CREATE DATABASE BD_LATAM
GO
USE [BD_LATAM]
GO
/****** Object:  Table [dbo].[AsientoAvion]    Script Date: 24/08/2019 12:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AsientoAvion](
	[Id] [int] IDENTITy(1,1) NOT NULL,
	[IdAvion] [int] NULL,
	[Nombre] [nvarchar](10) NULL,
	[Activo] [bit] NULL,
 CONSTRAINT [PK_AsientoAvion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Avion]    Script Date: 24/08/2019 12:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Avion](
	[Id] [int] IDENTITy(1,1) NOT NULL,
	[Modelo] [nvarchar](50) NULL,
	[Matricula] [nvarchar](50) NULL,
	[Activo] [bit] NULL,
 CONSTRAINT [PK_Avion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ciudad]    Script Date: 24/08/2019 12:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ciudad](
[Id] [int] IDENTITy(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NULL,
	[Activo] [bit] NULL,
 CONSTRAINT [PK_Ciudad] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pasaje]    Script Date: 24/08/2019 12:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pasaje](
	[Id] [int] IDENTITy(1,1) NOT NULL,
	[IdVuelo] [int] NULL,
	[IdPasajero] [int] NULL,
	[IdAsientoAvion] [int] NULL,
	[Estado] [nvarchar](10) NULL,
 CONSTRAINT [PK_Pasaje] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pasajero]    Script Date: 24/08/2019 12:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pasajero](
	[Id] [int] IDENTITy(1,1) NOT NULL,
	[Nombres] [nvarchar](50) NULL,
	[ApellidoPaterno] [nvarchar](50) NULL,
	[ApellidoMaterno] [nvarchar](50) NULL,
	[Dni] [nvarchar](10) NULL,
	[Activo] [bit] NULL,
 CONSTRAINT [PK_Pasajero] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tarifa]    Script Date: 24/08/2019 12:17:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tarifa](
	[Id] [int] IDENTITy(1,1) NOT NULL,
	[IdCiudadOrigen] [int] NULL,
	[IdCiudadDestino] [int] NULL,
	[IdTipoServicio] [int] NULL,
	[Precio] [decimal](10, 2) NULL,
[Activo] [bit] NULL,
 CONSTRAINT [PK_Tarifa] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoServicio]    Script Date: 24/08/2019 12:17:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoServicio](
	[Id] [int] IDENTITy(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NULL,
	[Activo] [bit] NULL,
 CONSTRAINT [PK_TipoServicio] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vuelo]    Script Date: 24/08/2019 12:17:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vuelo](
	[Id] [int] IDENTITy(1,1) NOT NULL,
	[IdTarifa] [int] NULL,
	[Fecha] [nvarchar](10) NULL,
	[Hora] [nvarchar](10) NULL,
	[IdAvion] [int] NULL,
	[Activo] [bit] NULL,
 CONSTRAINT [PK_Vuelo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AsientoAvion]  WITH CHECK ADD  CONSTRAINT [FK_AsientoAvion_Avion] FOREIGN KEY([IdAvion])
REFERENCES [dbo].[Avion] ([Id])
GO
ALTER TABLE [dbo].[AsientoAvion] CHECK CONSTRAINT [FK_AsientoAvion_Avion]
GO
ALTER TABLE [dbo].[Pasaje]  WITH CHECK ADD  CONSTRAINT [FK_Pasaje_AsientoAvion] FOREIGN KEY([IdAsientoAvion])
REFERENCES [dbo].[AsientoAvion] ([Id])
GO
ALTER TABLE [dbo].[Pasaje] CHECK CONSTRAINT [FK_Pasaje_AsientoAvion]
GO
ALTER TABLE [dbo].[Pasaje]  WITH CHECK ADD  CONSTRAINT [FK_Pasaje_Pasajero1] FOREIGN KEY([IdPasajero])
REFERENCES [dbo].[Pasajero] ([Id])
GO
ALTER TABLE [dbo].[Pasaje] CHECK CONSTRAINT [FK_Pasaje_Pasajero1]
GO
ALTER TABLE [dbo].[Pasaje]  WITH CHECK ADD  CONSTRAINT [FK_Pasaje_Vuelo] FOREIGN KEY([IdVuelo])
REFERENCES [dbo].[Vuelo] ([Id])
GO
ALTER TABLE [dbo].[Pasaje] CHECK CONSTRAINT [FK_Pasaje_Vuelo]
GO
ALTER TABLE [dbo].[Tarifa]  WITH CHECK ADD  CONSTRAINT [FK_Tarifa_Ciudad] FOREIGN KEY([IdCiudadOrigen])
REFERENCES [dbo].[Ciudad] ([Id])
GO
ALTER TABLE [dbo].[Tarifa] CHECK CONSTRAINT [FK_Tarifa_Ciudad]
GO
ALTER TABLE [dbo].[Tarifa]  WITH CHECK ADD  CONSTRAINT [FK_Tarifa_Ciudad1] FOREIGN KEY([IdCiudadDestino])
REFERENCES [dbo].[Ciudad] ([Id])
GO
ALTER TABLE [dbo].[Tarifa] CHECK CONSTRAINT [FK_Tarifa_Ciudad1]
GO
ALTER TABLE [dbo].[Tarifa]  WITH CHECK ADD  CONSTRAINT [FK_Tarifa_TipoServicio] FOREIGN KEY([IdTipoServicio])
REFERENCES [dbo].[TipoServicio] ([Id])
GO
ALTER TABLE [dbo].[Tarifa] CHECK CONSTRAINT [FK_Tarifa_TipoServicio]
GO
ALTER TABLE [dbo].[Vuelo]  WITH CHECK ADD  CONSTRAINT [FK_Vuelo_Avion] FOREIGN KEY([IdAvion])
REFERENCES [dbo].[Avion] ([Id])
GO
ALTER TABLE [dbo].[Vuelo] CHECK CONSTRAINT [FK_Vuelo_Avion]
GO
ALTER TABLE [dbo].[Vuelo]  WITH CHECK ADD  CONSTRAINT [FK_Vuelo_Tarifa] FOREIGN KEY([IdTarifa])
REFERENCES [dbo].[Tarifa] ([Id])
GO
ALTER TABLE [dbo].[Vuelo] CHECK CONSTRAINT [FK_Vuelo_Tarifa]
GO
---registros 
USE [BD_LATAM]
GO
SET IDENTITY_INSERT [dbo].[Avion] ON 
GO
INSERT [dbo].[Avion] ([Id], [Modelo], [Matricula], [Activo]) VALUES (1, N'AIRBUS A300', NULL, 0)
GO
INSERT [dbo].[Avion] ([Id], [Modelo], [Matricula], [Activo]) VALUES (2, N'BOEING 737', NULL, 1)
GO
INSERT [dbo].[Avion] ([Id], [Modelo], [Matricula], [Activo]) VALUES (3, N'AIRBUS A340', NULL, 1)
GO
INSERT [dbo].[Avion] ([Id], [Modelo], [Matricula], [Activo]) VALUES (4, N'AIRBUS A350', NULL, 1)
GO
INSERT [dbo].[Avion] ([Id], [Modelo], [Matricula], [Activo]) VALUES (5, N'BOEING 747', NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[Avion] OFF
GO
SET IDENTITY_INSERT [dbo].[AsientoAvion] ON 
GO
INSERT [dbo].[AsientoAvion] ([Id], [IdAvion], [Nombre], [Activo]) VALUES (1, 1, N'A1', 1)
GO
INSERT [dbo].[AsientoAvion] ([Id], [IdAvion], [Nombre], [Activo]) VALUES (2, 1, N'A2', 1)
GO
INSERT [dbo].[AsientoAvion] ([Id], [IdAvion], [Nombre], [Activo]) VALUES (3, 1, N'A3', 1)
GO
INSERT [dbo].[AsientoAvion] ([Id], [IdAvion], [Nombre], [Activo]) VALUES (4, 2, N'B1', 1)
GO
INSERT [dbo].[AsientoAvion] ([Id], [IdAvion], [Nombre], [Activo]) VALUES (5, 2, N'B2', 1)
GO
INSERT [dbo].[AsientoAvion] ([Id], [IdAvion], [Nombre], [Activo]) VALUES (6, 2, N'B3', 1)
GO
INSERT [dbo].[AsientoAvion] ([Id], [IdAvion], [Nombre], [Activo]) VALUES (7, 3, N'C1', 1)
GO
INSERT [dbo].[AsientoAvion] ([Id], [IdAvion], [Nombre], [Activo]) VALUES (8, 3, N'C2', 1)
GO
INSERT [dbo].[AsientoAvion] ([Id], [IdAvion], [Nombre], [Activo]) VALUES (9, 3, N'C3', 1)
GO
INSERT [dbo].[AsientoAvion] ([Id], [IdAvion], [Nombre], [Activo]) VALUES (10, 4, N'D1', 1)
GO
INSERT [dbo].[AsientoAvion] ([Id], [IdAvion], [Nombre], [Activo]) VALUES (11, 4, N'D2', 1)
GO
INSERT [dbo].[AsientoAvion] ([Id], [IdAvion], [Nombre], [Activo]) VALUES (12, 4, N'D3', 1)
GO
INSERT [dbo].[AsientoAvion] ([Id], [IdAvion], [Nombre], [Activo]) VALUES (13, 5, N'E1', 1)
GO
INSERT [dbo].[AsientoAvion] ([Id], [IdAvion], [Nombre], [Activo]) VALUES (14, 5, N'E2', 1)
GO
INSERT [dbo].[AsientoAvion] ([Id], [IdAvion], [Nombre], [Activo]) VALUES (15, 5, N'E3', 1)
GO
SET IDENTITY_INSERT [dbo].[AsientoAvion] OFF
GO
SET IDENTITY_INSERT [dbo].[Pasajero] ON 
GO
INSERT [dbo].[Pasajero] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Dni], [Activo]) VALUES (1, N'JUAN', N'PEREZ', N'PINO', N'01020304', 1)
GO
INSERT [dbo].[Pasajero] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Dni], [Activo]) VALUES (2, N'ISABEL', N'RODRIGUEZ', N'LOZANO', N'16164789', 1)
GO
INSERT [dbo].[Pasajero] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Dni], [Activo]) VALUES (3, N'LUCY', N'MATIAS', N'POVIS', N'88750102', 1)
GO
INSERT [dbo].[Pasajero] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Dni], [Activo]) VALUES (4, N'PEDRO', N'VARGAS', N'JARAMILLO', N'56551487', 1)
GO
SET IDENTITY_INSERT [dbo].[Pasajero] OFF
GO
SET IDENTITY_INSERT [dbo].[Ciudad] ON 
GO
INSERT [dbo].[Ciudad] ([Id], [Nombre], [Activo]) VALUES (1, N'LIMA', 1)
GO
INSERT [dbo].[Ciudad] ([Id], [Nombre], [Activo]) VALUES (2, N'CUZCO', 1)
GO
INSERT [dbo].[Ciudad] ([Id], [Nombre], [Activo]) VALUES (3, N'TRUJILLO', 1)
GO
INSERT [dbo].[Ciudad] ([Id], [Nombre], [Activo]) VALUES (4, N'IQUITOS', 1)
GO
INSERT [dbo].[Ciudad] ([Id], [Nombre], [Activo]) VALUES (5, N'AREQUIPA', 1)
GO
INSERT [dbo].[Ciudad] ([Id], [Nombre], [Activo]) VALUES (6, N'TACNA', 0)
GO
SET IDENTITY_INSERT [dbo].[Ciudad] OFF
GO
SET IDENTITY_INSERT [dbo].[TipoServicio] ON 
GO
INSERT [dbo].[TipoServicio] ([Id], [Nombre], [Activo]) VALUES (1, N'VIP', 1)
GO
INSERT [dbo].[TipoServicio] ([Id], [Nombre], [Activo]) VALUES (2, N'ECONOMICO', 1)
GO
INSERT [dbo].[TipoServicio] ([Id], [Nombre], [Activo]) VALUES (3, N'TURISTA', 1)
GO
INSERT [dbo].[TipoServicio] ([Id], [Nombre], [Activo]) VALUES (4, N'INVITADO', 0)
GO
SET IDENTITY_INSERT [dbo].[TipoServicio] OFF
GO
SET IDENTITY_INSERT [dbo].[Tarifa] ON 
GO
INSERT [dbo].[Tarifa] ([Id], [IdCiudadOrigen], [IdCiudadDestino], [IdTipoServicio], [Precio], [Activo]) VALUES (1, 1, 2, 1, CAST(300.00 AS Decimal(10, 2)), 1)
GO
INSERT [dbo].[Tarifa] ([Id], [IdCiudadOrigen], [IdCiudadDestino], [IdTipoServicio], [Precio], [Activo]) VALUES (2, 1, 2, 2, CAST(200.00 AS Decimal(10, 2)), 1)
GO
INSERT [dbo].[Tarifa] ([Id], [IdCiudadOrigen], [IdCiudadDestino], [IdTipoServicio], [Precio], [Activo]) VALUES (3, 1, 2, 3, CAST(250.00 AS Decimal(10, 2)), 1)
GO
INSERT [dbo].[Tarifa] ([Id], [IdCiudadOrigen], [IdCiudadDestino], [IdTipoServicio], [Precio], [Activo]) VALUES (4, 2, 1, 1, CAST(305.00 AS Decimal(10, 2)), 1)
GO
INSERT [dbo].[Tarifa] ([Id], [IdCiudadOrigen], [IdCiudadDestino], [IdTipoServicio], [Precio], [Activo]) VALUES (5, 2, 1, 2, CAST(205.00 AS Decimal(10, 2)), 1)
GO
INSERT [dbo].[Tarifa] ([Id], [IdCiudadOrigen], [IdCiudadDestino], [IdTipoServicio], [Precio], [Activo]) VALUES (6, 2, 1, 3, CAST(255.00 AS Decimal(10, 2)), 1)
GO
SET IDENTITY_INSERT [dbo].[Tarifa] OFF
GO
SET IDENTITY_INSERT [dbo].[Vuelo] ON 
GO
INSERT [dbo].[Vuelo] ([Id], [IdTarifa], [Fecha], [Hora], [IdAvion], [Activo]) VALUES (1, 1, N'30-10-2019', N'18:30', 1, 1)
GO
INSERT [dbo].[Vuelo] ([Id], [IdTarifa], [Fecha], [Hora], [IdAvion], [Activo]) VALUES (2, 5, N'01-11-2019', N'05:00', 5, 1)
GO
INSERT [dbo].[Vuelo] ([Id], [IdTarifa], [Fecha], [Hora], [IdAvion], [Activo]) VALUES (3, 2, N'28-10-2019', N'00:00', 2, 1)
GO
INSERT [dbo].[Vuelo] ([Id], [IdTarifa], [Fecha], [Hora], [IdAvion], [Activo]) VALUES (4, 1, N'27-11-2019', N'12:00', 3, 1)
GO
INSERT [dbo].[Vuelo] ([Id], [IdTarifa], [Fecha], [Hora], [IdAvion], [Activo]) VALUES (5, 3, N'26-10-2019', N'23:45', 4, 1)
GO
SET IDENTITY_INSERT [dbo].[Vuelo] OFF
GO

--BACKUP

EXECUTE sp_helpDB BD_LATAM
GO

--CREACION DEL BACKUP

GO
BACKUP DATABASE BD_LATAM
TO DISK='D:\DATOS\BD_LATAM_FULL.BAK'
	WITH NOINIT,
	NAME='COPIA COMPLETA',
	DESCRIPTION='COPIA DIARIA'

	RESTORE FILELISTONLY
	FROM DISK='D:\DATOS\BD_LATAM_FULL.BAK'
	GO
	RESTORE HEADERONLY
	FROM DISK='D:\DATOS\BD_LATAM_FULL.BAK'

--
GO
BACKUP DATABASE [BD_LATAM]
TO DISK='D:\DATOS\BD_LATAM_FULL2.BAK'
	WITH INIT,
		NAME='COPIA COMPLETA',
		DESCRIPTION='COPIA DIARIA',
		STATS=10,
		FORMAT,COMPRESSION
GO
	RESTORE FILELISTONLY
	FROM DISK='D:\DATOS\BD_LATAM_FULL2.BAK'
	GO
	RESTORE HEADERONLY
	FROM DISK='D:\DATOS\BD_LATAM_FULL2.BAK'

--CAMBIAR DE IDIOMA
USE BD_LATAM
SET LANGUAGE SPANISH 

SELECT * FROM Ciudad

--VOY CREAR UNA TABLA UTILIZANDO LA CONSULTA SELECT NOMBRE TBLCIUDAD

SELECT * INTO TBLCIUDAD FROM CIUDAD

SELECT * FROM TBLCIUDAD

--ACTUALIZAR DICHOS REGISTROS
UPDATE TBLCIUDAD SET Nombre='Chiclayo' where Id like '%[1,6]'

select * from tBLCIUDAD where Id like '%[1,6]'

go

backup DATABASE BD_LATAM
TO DISK='D:\DATOS\BD_LATAM_DIFF.BAK'
WITH DIFFERENTIAL,
	NAME='COPIA DIFERENCIAL',
	DESCRIPTION='COPIA DIF. LUNES 14PM',
	INIT
GO

/*
COPIA DE REGISTROS DE TRANSACCIONES

TIME		EVENTO
8:00		COPIA SEGURIDAD DE BD
MEDIODIA    COPIA REGISTRO DE TRANSACCIONES
16:00		COPIA REGISTRO DE TRANSACCIONES
18:00		COPIA SEGURIDAD DE BD
20:00		COPIA REGISTRO DE TRANSACCIONES
*/

GO

BACKUP LOG [BD_LATAM]
TO DISK='D:\DATOS\BD_LATAM_LOG.BAK'
	WITH NAME='COPIA DEL LOG',
		DESCRIPTION='COPIA LOG. LUNES 14PM',
		INIT
GO

SELECT * FROM TBLCIUDAD

--ELIMINAR DE LA TBLECIUDAD LA CIUDAD CHICLAYO

DELETE FROM TBLCIUDAD WHERE Nombre='CHICLAYO'

--RECUPERACION LOS DATOS DE LATAM

USE MASTER
GO
RESTORE DATABASE BD_LATAM
FROM DISK='D:\DATOS\BD_LATAM_FULL2.BAK'
WITH REPLACE , NORECOVERY
GO

RESTORE DATABASE BD_LATAM
FROM DISK='D:\DATOS\BD_LATAM_DIFF.BAK'
WITH NORECOVERY

USE BD_LATAM
GO

RESTORE LOG BD_LATAM
FROM DISK='D:\DATOS\BD_LATAM_LOG.BAK'
with norecovery
go

RESTORE LOG BD_LATAM

SELECT * FROM TBLCIUDAD

--MOVIMIENTOS DATOS 
--SISTEMASUNI3