CREATE DATABASE BD_LATAM
GO

USE BD_LATAM
GO

/****** Object:  Table [dbo].[AsientoAvion]    Script Date: 24/08/2019 12:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AsientoAvion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
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
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Modelo] [nvarchar](50) NULL,
	[Matricula] [nvarchar](50) NULL,
	[Activo] [bit] NULL,
 CONSTRAINT [PK_Avion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object: Table [dbo].[Ciudad] Script Date: 24/08/2019 12:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ciudad](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NULL,
	[Activo] [bit] NULL,
 CONSTRAINT [PK_Ciudad] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object: Table [dbo].[Pasaje] Script Date: 24/08/2019 12:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pasaje](
	[Id] [int] IDENTITY(1,1) NOT NULL,
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


/****** Object: Table [dbo].[Pasajero] Script Date: 24/08/2019 12:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pasajero](
	[Id] [int] IDENTITY(1,1) NOT NULL,
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



/****** Object: Table [dbo].[Tarifa] Script Date: 24/08/2019 12:17:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tarifa](
	[Id] [int] IDENTITY(1,1) NOT NULL,
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


/****** Object: Table [dbo].[TipoServicio] Script Date: 24/08/2019 12:17:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoServicio] (
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NULL,
	[Activo] [bit] NULL,
	CONSTRAINT [PK_TipoServicio] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object: Table [dbo].[Vuelo] Script Date: 24/08/2019 12:17:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vuelo] (
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTarifa] [int] NULL,
	[Fecha] [nvarchar](10) NULL,
	[Hora] [nvarchar](10) NULL,
	[IdAvion] [int] NULL,
	[Activo] [bit] NULL,
	CONSTRAINT [PK_Vuelo] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[AsientoAvion] ADD CONSTRAINT [FK_AsientoAvion_Avion] FOREIGN KEY([IdAvion])
REFERENCES [dbo].[Avion] ([Id])
GO
ALTER TABLE [dbo].[AsientoAvion] CHECK CONSTRAINT [FK_AsientoAvion_Avion]
GO
ALTER TABLE [dbo].[Pasaje] ADD CONSTRAINT [FK_Pasaje_AsientoAvion] FOREIGN KEY([IdAsientoAvion])
REFERENCES [dbo].[AsientoAvion] ([Id])
GO
ALTER TABLE [dbo].[Pasaje] CHECK CONSTRAINT [FK_Pasaje_AsientoAvion]
GO
ALTER TABLE [dbo].[Pasaje] ADD CONSTRAINT [FK_Pasaje_Pasajero1] FOREIGN KEY([IdPasajero])
REFERENCES [dbo].[Pasajero] ([Id])
GO
ALTER TABLE [dbo].[Pasaje] CHECK CONSTRAINT [FK_Pasaje_Pasajero1]
GO
ALTER TABLE [dbo].[Pasaje] ADD CONSTRAINT [FK_Pasaje_Vuelo] FOREIGN KEY([IdVuelo])
REFERENCES [dbo].[Vuelo] ([Id])
GO
ALTER TABLE [dbo].[Pasaje] CHECK CONSTRAINT [FK_Pasaje_Vuelo]
GO
ALTER TABLE [dbo].[Tarifa] ADD CONSTRAINT [FK_Tarifa_Ciudad] FOREIGN KEY([IdCiudadOrigen])
REFERENCES [dbo].[Ciudad] ([Id])
GO
ALTER TABLE [dbo].[Tarifa] CHECK CONSTRAINT [FK_Tarifa_Ciudad]
GO








