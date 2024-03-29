USE [master]
GO
/****** Object:  Database [Cariages]    Script Date: 07.01.2020 16:35:23 ******/
CREATE DATABASE [Cariages]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Cariages', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Cariages.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Cariages_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Cariages_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Cariages] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Cariages].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Cariages] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Cariages] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Cariages] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Cariages] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Cariages] SET ARITHABORT OFF 
GO
ALTER DATABASE [Cariages] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Cariages] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Cariages] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Cariages] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Cariages] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Cariages] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Cariages] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Cariages] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Cariages] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Cariages] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Cariages] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Cariages] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Cariages] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Cariages] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Cariages] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Cariages] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Cariages] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Cariages] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Cariages] SET  MULTI_USER 
GO
ALTER DATABASE [Cariages] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Cariages] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Cariages] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Cariages] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Cariages] SET DELAYED_DURABILITY = DISABLED 
GO
USE [Cariages]
GO
/****** Object:  Table [dbo].[Brand]    Script Date: 07.01.2020 16:35:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Brand](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[brand] [varchar](250) NOT NULL,
	[cariagyingCapacity] [float] NOT NULL,
	[model] [varchar](250) NULL,
 CONSTRAINT [PK_Brand] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Car]    Script Date: 07.01.2020 16:35:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Car](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[brandId] [int] NOT NULL,
	[year] [smalldatetime] NOT NULL,
	[number] [varchar](10) NOT NULL,
	[shortYear] [int] NULL,
	[yearOfReceipt] [smalldatetime] NULL,
 CONSTRAINT [PK_Car] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Driver]    Script Date: 07.01.2020 16:35:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Driver](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[lastName] [varchar](250) NOT NULL,
	[firstName] [varchar](250) NOT NULL,
	[patronymic] [varchar](250) NOT NULL,
	[birthDay] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_Driver] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Journal]    Script Date: 07.01.2020 16:35:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Journal](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[carId] [int] NOT NULL,
	[driverId] [int] NOT NULL,
	[departure] [smalldatetime] NOT NULL,
	[weight] [numeric](18, 0) NOT NULL,
	[distance] [numeric](18, 0) NOT NULL,
	[arrival] [smalldatetime] NOT NULL,
	[departureDate] [date] NULL,
	[deparureTime] [time](7) NULL,
	[arrivalDate] [date] NULL,
	[arrivalTime] [time](7) NULL,
 CONSTRAINT [PK_Journal] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LongJourneys]    Script Date: 07.01.2020 16:35:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LongJourneys](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[carId] [int] NULL,
	[driverId] [int] NULL,
	[departure] [smalldatetime] NULL,
	[weight] [numeric](18, 0) NULL,
	[distance] [numeric](18, 0) NULL,
	[arrival] [smalldatetime] NULL,
	[departureDate] [date] NULL,
	[departureTime] [time](7) NULL,
	[arrivalDate] [date] NULL,
	[arrivalTime] [time](7) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [indexYearNumber]    Script Date: 07.01.2020 16:35:23 ******/
CREATE NONCLUSTERED INDEX [indexYearNumber] ON [dbo].[Car]
(
	[year] ASC,
	[number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Car]  WITH NOCHECK ADD  CONSTRAINT [FK_Car_Brand] FOREIGN KEY([brandId])
REFERENCES [dbo].[Brand] ([id])
GO
ALTER TABLE [dbo].[Car] CHECK CONSTRAINT [FK_Car_Brand]
GO
ALTER TABLE [dbo].[Journal]  WITH CHECK ADD  CONSTRAINT [FK_Journal_Car] FOREIGN KEY([carId])
REFERENCES [dbo].[Car] ([id])
GO
ALTER TABLE [dbo].[Journal] CHECK CONSTRAINT [FK_Journal_Car]
GO
ALTER TABLE [dbo].[Journal]  WITH CHECK ADD  CONSTRAINT [FK_Journal_Driver] FOREIGN KEY([driverId])
REFERENCES [dbo].[Driver] ([id])
GO
ALTER TABLE [dbo].[Journal] CHECK CONSTRAINT [FK_Journal_Driver]
GO
USE [master]
GO
ALTER DATABASE [Cariages] SET  READ_WRITE 
GO
