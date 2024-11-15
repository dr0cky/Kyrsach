USE [master]
GO
/****** Object:  Database [Teatr]    Script Date: 11/9/2024 2:10:50 PM ******/
CREATE DATABASE [Teatr]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Teatr', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Teatr.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Teatr_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Teatr_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Teatr].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Teatr] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Teatr] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Teatr] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Teatr] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Teatr] SET ARITHABORT OFF 
GO
ALTER DATABASE [Teatr] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Teatr] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Teatr] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Teatr] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Teatr] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Teatr] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Teatr] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Teatr] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Teatr] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Teatr] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Teatr] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Teatr] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Teatr] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Teatr] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Teatr] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Teatr] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Teatr] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Teatr] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Teatr] SET  MULTI_USER 
GO
ALTER DATABASE [Teatr] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Teatr] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Teatr] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Teatr] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Teatr] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Teatr', N'ON'
GO
USE [Teatr]
GO
/****** Object:  DatabaseRole [db_security]    Script Date: 11/9/2024 2:10:50 PM ******/
CREATE ROLE [db_security]
GO
/****** Object:  DatabaseRole [db_manager]    Script Date: 11/9/2024 2:10:50 PM ******/
CREATE ROLE [db_manager]
GO
/****** Object:  DatabaseRole [db_admin]    Script Date: 11/9/2024 2:10:50 PM ******/
CREATE ROLE [db_admin]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [db_security]
GO
ALTER ROLE [db_datareader] ADD MEMBER [db_manager]
GO
ALTER ROLE [db_owner] ADD MEMBER [db_admin]
GO
/****** Object:  Schema [db_admin]    Script Date: 11/9/2024 2:10:50 PM ******/
CREATE SCHEMA [db_admin]
GO
/****** Object:  Schema [db_manager]    Script Date: 11/9/2024 2:10:50 PM ******/
CREATE SCHEMA [db_manager]
GO
/****** Object:  Schema [db_security]    Script Date: 11/9/2024 2:10:50 PM ******/
CREATE SCHEMA [db_security]
GO
/****** Object:  Schema [TeatrUser1]    Script Date: 11/9/2024 2:10:50 PM ******/
CREATE SCHEMA [TeatrUser1]
GO
/****** Object:  Schema [TeatrUser2]    Script Date: 11/9/2024 2:10:50 PM ******/
CREATE SCHEMA [TeatrUser2]
GO
/****** Object:  Schema [TeatrUser3]    Script Date: 11/9/2024 2:10:50 PM ******/
CREATE SCHEMA [TeatrUser3]
GO
/****** Object:  UserDefinedFunction [dbo].[ArithmeticOperations]    Script Date: 11/9/2024 2:10:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ArithmeticOperations]
(
    @Operand1 BIGINT,
    @Operand2 BIGINT,
    @Operator NVARCHAR(1)
)
RETURNS BIGINT
AS
BEGIN
    DECLARE @Result BIGINT

    IF @Operator = '+'
        SET @Result = @Operand1 + @Operand2
    ELSE IF @Operator = '-'
        SET @Result = @Operand1 - @Operand2
    ELSE IF @Operator = '*'
        SET @Result = @Operand1 * @Operand2
    ELSE IF @Operator = '/'
        SET @Result = @Operand1 / @Operand2

    RETURN @Result
END
GO
/****** Object:  UserDefinedFunction [dbo].[get_cities]    Script Date: 11/9/2024 2:10:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[get_cities] (@filter VARCHAR(70))
RETURNS @cities TABLE  
(
    [Worker_ID] [int],
	[Last_name] [nvarchar](100),
	[First_name] [nvarchar](100),
	[Patronymic] [nvarchar](100),
	[Year_of_birth] [date],
	[Year_of_admissionWork] [date],
	[Experience] [int],
	[Post] [nchar](100),
	[Gender] [nvarchar](100),
	[Address] [nvarchar](100),
	[City] [nvarchar](100),
	[Phone] [nvarchar](100)
)
AS
BEGIN
    INSERT @cities   
    SELECT * FROM [Employees of the teatr] WHERE Last_name LIKE @filter; 

    RETURN;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[get_worker]    Script Date: 11/9/2024 2:10:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[get_worker] (@filter VARCHAR(70))
RETURNS @worker TABLE  
(
    [Worker_ID] [int],
	[Last_name] [nvarchar](100),
	[First_name] [nvarchar](100),
	[Patronymic] [nvarchar](100),
	[Year_of_birth] [date],
	[Year_of_admissionWork] [date],
	[Experience] [int],
	[Post] [nchar](100),
	[Gender] [nvarchar](100),
	[Address] [nvarchar](100),
	[City] [nvarchar](100),
	[Phone] [nvarchar](100)
)
AS
BEGIN
    INSERT @worker   
    SELECT * FROM [Employees of the teatr] WHERE Last_name LIKE @filter; 

    RETURN;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[get_worker1]    Script Date: 11/9/2024 2:10:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[get_worker1] (@filter VARCHAR(70))
RETURNS @worker TABLE  
(
    [Worker_ID] [int],
	[Last_name] [nvarchar](100),
	[First_name] [nvarchar](100),
	[Patronymic] [nvarchar](100),
	[Year_of_birth] [date],
	[Year_of_admissionWork] [date],
	[Experience] [int],
	[Post] [nchar](100),
	[Gender] [nvarchar](100),
	[Address] [nvarchar](100),
	[City] [nvarchar](100),
	[Phone] [nvarchar](100)
)
AS
BEGIN
    INSERT @worker   
    SELECT * FROM [Employees of the teatr] WHERE Gender = 'ж'; 

    RETURN;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[GetFullName]    Script Date: 11/9/2024 2:10:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetFullName](@EmployeeID INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @FullName VARCHAR(100)

    SELECT @FullName = First_name + ' ' + Last_name
    FROM [Employees of the teatr]
    WHERE Worker_ID = @EmployeeID

    RETURN @FullName
END
GO
/****** Object:  UserDefinedFunction [dbo].[ParseStr]    Script Date: 11/9/2024 2:10:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ParseStr] (@String nvarchar(500))RETURNS @table TABLE
(Number int IDENTITY (1,1) NOT NULL,Substr nvarchar (30))
AS
BEGIN
DECLARE @Str1 nvarchar(500), @Pos int,@Count int, @PosCount int
SET @Count = 0
SET @PosCount = 1
SET @Str1 = @String
WHILE @Count < LEN(@Str1)
 BEGIN SET @Pos = CHARINDEX(' ', @Str1)
 IF @POS > 0  BEGIN
  SET @Count = @Count + 1 
  INSERT INTO @table
  VALUES (SUBSTRING (@Str1, 1, @Pos))  
  --SET @PosCount = @PosCount + @Pos
  SET @Str1 = REPLACE(@Str1, SUBSTRING (@Str1, 1, @Pos), '') 
  END
 ELSE  
 BEGIN
  INSERT INTO @table
  VALUES (@Str1)
  BREAK 
  END
 END
 RETURN
END
GO
/****** Object:  Table [dbo].[Employees of the teatr]    Script Date: 11/9/2024 2:10:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees of the teatr](
	[Worker_ID] [int] IDENTITY(1,1) NOT NULL,
	[Last_name] [nvarchar](100) NOT NULL,
	[First_name] [nvarchar](100) NOT NULL,
	[Patronymic] [nvarchar](100) NULL,
	[Year_of_birth] [date] NOT NULL,
	[Year_of_admissionWork] [date] NOT NULL,
	[Experience] [int] NOT NULL,
	[Post] [nvarchar](50) NOT NULL,
	[Gender] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](100) NOT NULL,
	[City] [nvarchar](100) NOT NULL,
	[Phone] [nvarchar](100) NOT NULL,
	[Photo] [nvarchar](50) NULL,
 CONSTRAINT [PK_Employees of the teatr] PRIMARY KEY CLUSTERED 
(
	[Worker_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Performances]    Script Date: 11/9/2024 2:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Performances](
	[Performances_ID] [int] IDENTITY(1,1) NOT NULL,
	[NamePerformance] [int] NOT NULL,
	[DirectorPostanovjik] [nchar](100) NOT NULL,
	[ProductionHudojnik] [nchar](100) NOT NULL,
	[DerejerPostanovjik] [nchar](100) NOT NULL,
	[Author] [nchar](100) NOT NULL,
	[Style] [nchar](100) NOT NULL,
	[TypePerformances] [nchar](100) NOT NULL,
 CONSTRAINT [PK_Performances] PRIMARY KEY CLUSTERED 
(
	[Performances_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepertoireTeatra]    Script Date: 11/9/2024 2:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepertoireTeatra](
	[Performance_IDD] [int] NOT NULL,
	[Tour_IDD] [int] NOT NULL,
	[PeriodEvent] [date] NOT NULL,
	[DaysTimes] [date] NOT NULL,
	[TicketPrice] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tour]    Script Date: 11/9/2024 2:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tour](
	[Tour_ID] [int] NOT NULL,
	[NameTour] [nchar](100) NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[LocationTour] [nchar](100) NOT NULL,
	[NamePerformance] [int] NOT NULL,
 CONSTRAINT [PK_Tour] PRIMARY KEY CLUSTERED 
(
	[Tour_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Troupe]    Script Date: 11/9/2024 2:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Troupe](
	[Troupe_ID] [int] NOT NULL,
	[Worker_IDD] [int] IDENTITY(1,1) NOT NULL,
	[Actors] [int] NOT NULL,
	[NameRole] [nchar](100) NOT NULL,
	[Phone] [nchar](100) NOT NULL,
	[Performance_IDD] [int] NULL,
 CONSTRAINT [PK_Troupe] PRIMARY KEY CLUSTERED 
(
	[Troupe_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[DYNTAB]    Script Date: 11/9/2024 2:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[DYNTAB] (@city varchar(10))
returns table
as
return select Tour_ID, NameTour, StartDate, LocationTour from Tour
where LocationTour = @city
GO
/****** Object:  UserDefinedFunction [dbo].[GetContactFormalNames1]    Script Date: 11/9/2024 2:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetContactFormalNames1]()
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 10 Last_name + ' ' + First_name + ' ' + Patronymic AS FormalName
    FROM [Employees of the teatr]
)
GO
/****** Object:  View [dbo].[FirstView]    Script Date: 11/9/2024 2:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[FirstView]
AS
SELECT        Worker_ID AS ID_Работника, Last_name AS Фамилия, First_name AS Имя, Patronymic AS Отчество, Experience AS Стаж
FROM            dbo.[Employees of the teatr]
WHERE        (Experience > 6)
GO
/****** Object:  View [dbo].[FourthView]    Script Date: 11/9/2024 2:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[FourthView] as
select
Worker_ID as ID_Работника,
Last_name AS Фамилия,
First_name AS Имя,
Patronymic AS Отчество,
Experience as Стаж,
Style as Жанр
from [Employees of the teatr], [Performances]
GO
/****** Object:  View [dbo].[SecondView]    Script Date: 11/9/2024 2:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SecondView]
AS
SELECT        Worker_ID AS ID_Работника, Last_name AS Фамилия, First_name AS Имя, Patronymic AS Отчество, Experience AS Стаж, Post AS Должность
FROM            dbo.[Employees of the teatr]
WHERE        (Experience > 6) AND (NOT (Post = 'Художник-декоратор'))
GO
/****** Object:  View [dbo].[ThirdView]    Script Date: 11/9/2024 2:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[ThirdView] as
SELECT        Worker_ID AS ID_Работника, Last_name AS Фамилия, First_name AS Имя, Patronymic AS Отчество, Post AS Должность
FROM            dbo.[Employees of the teatr]
WHERE        (Post = 'Актер')
GO
SET IDENTITY_INSERT [dbo].[Employees of the teatr] ON 

INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (1, N'Александра', N'Расстегаева', N'Сергеевна', CAST(N'1985-05-12' AS Date), CAST(N'2021-02-15' AS Date), 10, N'Генеральный директор                              ', N'ж', N'ул. Ленина, д. 1, кв. 1', N'Уфа', N'+79871354279', N'Resources/1.jpg')
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (2, N'Тимур', N'Исмагилов', N'Дамирович', CAST(N'1992-09-23' AS Date), CAST(N'2022-03-28' AS Date), 8, N'Актер                                             ', N'м', N'ул. Куйбышева, д. 2, кв. 2', N'Уфа', N'+779889222423', NULL)
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (3, N'Иванов', N'Олег', N'Эдуардович', CAST(N'1988-11-07' AS Date), CAST(N'2023-04-11' AS Date), 9, N'Помощник_ген.директора                            ', N'м', N'ул. Пушкина, д. 3, кв. 3', N'Уфа', N'+7 988 939-31-92', NULL)
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (4, N'Бердин', N'Андрей', N'Александрович', CAST(N'1990-04-15' AS Date), CAST(N'2021-05-17' AS Date), 8, N'Помощник_ген.директора                            ', N'м', N'ул. Горького, д. 4, кв. 4', N'Уфа', N'+7 977 418-65-14', NULL)
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (5, N'Ирина', N'Андреева', N'Никитовна', CAST(N'1987-02-28' AS Date), CAST(N'2022-06-22' AS Date), 6, N'Режиссер-постановщик                              ', N'ж', N'ул. Маяковского, д. 5, кв. 5', N'Москва', N'+7 905 021-46-69', N'Resources/10.jpg')
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (6, N'Маргарита', N'Иванова', N'Николаевна', CAST(N'1991-06-18' AS Date), CAST(N'2023-07-27' AS Date), 6, N'Режиссер-постановщик                              ', N'ж', N'ул. Гоголя, д. 6, кв. 6', N'Уфа', N'+7 988 939-31-92', N'Resources/11.jpg')
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (7, N'Евдокимов', N'Илья', N'Инванович', CAST(N'1986-10-30' AS Date), CAST(N'2020-08-03' AS Date), 7, N'Режиссер-постановщик                              ', N'м', N'ул. Чехова, д. 7, кв. 7', N'Уфа', N'+7 991 558-42-49', NULL)
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (8, N'Айдар', N'Сергей', NULL, CAST(N'1993-08-09' AS Date), CAST(N'2021-09-09' AS Date), 1, N'Художник-постановщик                              ', N'м', N'ул. Толстого, д. 8, кв. 8', N'Уфа', N'+7 985 265-21-59', NULL)
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (9, N'Иванов', N'Олег', N'Владимирович', CAST(N'1989-01-22' AS Date), CAST(N'2022-10-15' AS Date), 5, N'Художник-постановщик                              ', N'м', N'ул. Достоевского, д. 9, кв. 9', N'Уфа', N'+7 988 939-31-92', NULL)
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (11, N'Иванов', N'Олег', N'Владимирович', CAST(N'1983-07-25' AS Date), CAST(N'2020-12-25' AS Date), 5, N'Художник-декоратор                                ', N'м', N'ул. Акмуллы, д. 11, кв. 11', N'Уфа', N'+7 988 939-31-92', NULL)
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (13, N'Сидоров', N'Дмитрий', N'Николаевич', CAST(N'1982-03-16' AS Date), CAST(N'2022-02-05' AS Date), 3, N'Художник по свету                                 ', N'м', N'ул. Карима, д. 13, кв. 13', N'Уфа', N'+7 950 030-20-31', NULL)
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (15, N'Кристина', N'Морозова', N'Дмитриевна', CAST(N'1981-09-03' AS Date), CAST(N'2020-04-15' AS Date), 2, N'Звукорежиссер                                     ', N'ж', N'ул. Хасана, д. 15, кв. 15', N'Уфа', N'+7 977 108-49-97', N'Resources/12.jpg')
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (16, N'Айдар', N'Ирина', NULL, CAST(N'1997-10-17' AS Date), CAST(N'2021-05-20' AS Date), 6, N'Звукорежиссер                                     ', N'ж', N'ул. Тукая, д. 16, кв. 16', N'Уфа', N'+7 991 775-42-92', NULL)
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (17, N'Ольга', N'Васильева', N'Александровна', CAST(N'1980-04-29' AS Date), CAST(N'2022-06-25' AS Date), 8, N'Звукорежиссер                                     ', N'ж', N'ул. Назиба, д. 17, кв. 17', N'Питер', N'+7 977 107-45-74', N'Resources/13.jpg')
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (18, N'Зайцев', N'Владимир', N'Сергеевич', CAST(N'1998-07-05' AS Date), CAST(N'2023-07-30' AS Date), 4, N'Заведующий труппой                                ', N'м', N'ул. Ахундова, д. 18, кв. 18', N'Уфа', N'+7 977 144-15-22', NULL)
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (19, N'Попова', N'Юлия', N'Александровна', CAST(N'1984-01-19' AS Date), CAST(N'2020-08-04' AS Date), 1, N'Заведующий труппой                                ', N'ж', N'ул. Мифтахова, д. 19, кв. 19', N'Уфа', N'+7 991 604-73-46', NULL)
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (21, N'Дарья', N'Фролова', N'Кирилловна', CAST(N'1985-09-06' AS Date), CAST(N'2022-10-14' AS Date), 5, N'Актер                                             ', N'ж', N'ул. Гафури, д. 21, кв. 21', N'Москва', N'+7 991 756-07-46', N'Resources/14.jpg')
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (22, N'Пантелеев', N'Иван', N'Дмитриевич', CAST(N'1990-10-20' AS Date), CAST(N'2023-11-19' AS Date), 1, N'Актер                                             ', N'м', N'ул. Карима, д. 22, кв. 22', N'Уфа', N'+7 958 502-27-34', NULL)
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (23, N'Андреев', N'Марк', NULL, CAST(N'1991-11-12' AS Date), CAST(N'2020-12-24' AS Date), 6, N'Актер                                             ', N'м', N'ул. Янаби, д. 23, кв. 23', N'Уфа', N'+7 905 021-46-69', NULL)
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (24, N'Любовь', N'Андреева', N'Артемьевна', CAST(N'1992-12-21' AS Date), CAST(N'2021-01-29' AS Date), 3, N'Актер                                             ', N'ж', N'ул. Хасана, д. 24, кв. 24', N'Уфа', N'+7 905 021-46-69', N'Resources/15.jpg')
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (25, N'Дементьев', N'Фёдор', N'Макарович', CAST(N'1993-01-01' AS Date), CAST(N'2022-02-03' AS Date), 7, N'Актер                                             ', N'м', N'ул. Тукая, д. 25, кв. 25', N'Уфа', N'+7 991 181-01-54', NULL)
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (26, N'Озеров', N'Даниил', N'Арсентьевич', CAST(N'1994-02-13' AS Date), CAST(N'2023-03-08' AS Date), 9, N'Актер                                             ', N'м', N'ул. Назиба, д. 26, кв. 26', N'Уфа', N'+7 962 834-53-77', NULL)
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (27, N'Дмитрева', N'Анфиса', N'Мироновна', CAST(N'1995-03-22' AS Date), CAST(N'2020-04-13' AS Date), 3, N'Актер                                             ', N'ж', N'ул. Ахундова, д. 27, кв. 27', N'Уфа', N'+7 926 981-35-26', N'Resources/16.jpg')
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (28, N'Лазарев', N'Святослав', N'Владиславович', CAST(N'1996-04-03' AS Date), CAST(N'2021-05-18' AS Date), 2, N'Актер                                             ', N'м', N'ул. Мифтахова, д. 28, кв. 28', N'Уфа', N'+7 999 509-30-58', NULL)
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (29, N'Морозов', N'Сергей', N'Романович', CAST(N'1997-05-14' AS Date), CAST(N'2022-06-23' AS Date), 6, N'Актер                                             ', N'м', N'ул. Акмуллы, д. 29, кв. 29', N'Уфа', N'+7 999 509-21-89', NULL)
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (31, N'Калинин', N'Александр', N'Маркович', CAST(N'1999-07-04' AS Date), CAST(N'2020-08-02' AS Date), 1, N'Актер                                             ', N'м', N'ул. Карима, д. 31, кв. 31', N'Уфа', N'
+7 999 450-28-39', NULL)
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (32, N'Евгения', N'Ефимова', N'Матвеевна', CAST(N'2000-08-15' AS Date), CAST(N'2021-09-07' AS Date), 6, N'Актер                                             ', N'ж', N'ул. Янаби, д. 32, кв. 32', N'Уфа', N'+7 977 435-82-60', N'Resources/18.jpg')
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (33, N'Галкин', N'Артём', N'Андреевич', CAST(N'2001-09-24' AS Date), CAST(N'2022-10-12' AS Date), 5, N'Актер                                             ', N'м', N'ул. Хасана, д. 33, кв. 33', N'Уфа', N'+7 977 453-19-38', NULL)
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (36, N'Будилов', N'Виталий', N'Владимирович', CAST(N'2005-07-24' AS Date), CAST(N'2022-07-24' AS Date), 10, N'Актер                                             ', N'м', N'ул.Ленина, д. 1, кв. 2', N'Уфа', N'+79871354279', NULL)
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (39, N'Расстегаев', N'Александр', N'Сергеевич', CAST(N'2024-10-27' AS Date), CAST(N'2024-11-09' AS Date), 10, N'Генеральный директор                              ', N'ж', N'Набережная', N'Уфа', N'+79871354279', NULL)
INSERT [dbo].[Employees of the teatr] ([Worker_ID], [Last_name], [First_name], [Patronymic], [Year_of_birth], [Year_of_admissionWork], [Experience], [Post], [Gender], [Address], [City], [Phone], [Photo]) VALUES (42, N'Расстегаевввв', N'Александр', N'Сергеевич', CAST(N'2024-10-27' AS Date), CAST(N'2024-11-09' AS Date), 2, N'Генеральный директор                              ', N'ж', N'Набережная', N'Уфа', N'+79871354279', NULL)
SET IDENTITY_INSERT [dbo].[Employees of the teatr] OFF
GO
SET IDENTITY_INSERT [dbo].[Performances] ON 

INSERT [dbo].[Performances] ([Performances_ID], [NamePerformance], [DirectorPostanovjik], [ProductionHudojnik], [DerejerPostanovjik], [Author], [Style], [TypePerformances]) VALUES (7, 1, N'6                                                                                                   ', N'8                                                                                                   ', N'11                                                                                                  ', N'20                                                                                                  ', N'Драма                                                                                               ', N'Молодежные                                                                                          ')
INSERT [dbo].[Performances] ([Performances_ID], [NamePerformance], [DirectorPostanovjik], [ProductionHudojnik], [DerejerPostanovjik], [Author], [Style], [TypePerformances]) VALUES (8, 2, N'5                                                                                                   ', N'10                                                                                                  ', N'11                                                                                                  ', N'27                                                                                                  ', N'Драма                                                                                               ', N'Молодежные                                                                                          ')
INSERT [dbo].[Performances] ([Performances_ID], [NamePerformance], [DirectorPostanovjik], [ProductionHudojnik], [DerejerPostanovjik], [Author], [Style], [TypePerformances]) VALUES (9, 3, N'7                                                                                                   ', N'9                                                                                                   ', N'11                                                                                                  ', N'31                                                                                                  ', N'Водевиль                                                                                            ', N'Детские                                                                                             ')
INSERT [dbo].[Performances] ([Performances_ID], [NamePerformance], [DirectorPostanovjik], [ProductionHudojnik], [DerejerPostanovjik], [Author], [Style], [TypePerformances]) VALUES (10, 4, N'6                                                                                                   ', N'8                                                                                                   ', N'11                                                                                                  ', N'24                                                                                                  ', N'Комедия                                                                                             ', N'Детские                                                                                             ')
INSERT [dbo].[Performances] ([Performances_ID], [NamePerformance], [DirectorPostanovjik], [ProductionHudojnik], [DerejerPostanovjik], [Author], [Style], [TypePerformances]) VALUES (11, 5, N'6                                                                                                   ', N'8                                                                                                   ', N'12                                                                                                  ', N'25                                                                                                  ', N'Фарс                                                                                                ', N'Молодежные                                                                                          ')
INSERT [dbo].[Performances] ([Performances_ID], [NamePerformance], [DirectorPostanovjik], [ProductionHudojnik], [DerejerPostanovjik], [Author], [Style], [TypePerformances]) VALUES (12, 6, N'5                                                                                                   ', N'10                                                                                                  ', N'12                                                                                                  ', N'32                                                                                                  ', N'Мюзикл                                                                                              ', N'Молодежные                                                                                          ')
INSERT [dbo].[Performances] ([Performances_ID], [NamePerformance], [DirectorPostanovjik], [ProductionHudojnik], [DerejerPostanovjik], [Author], [Style], [TypePerformances]) VALUES (13, 7, N'7                                                                                                   ', N'9                                                                                                   ', N'12                                                                                                  ', N'21                                                                                                  ', N'Мелодрама                                                                                           ', N'Детские                                                                                             ')
INSERT [dbo].[Performances] ([Performances_ID], [NamePerformance], [DirectorPostanovjik], [ProductionHudojnik], [DerejerPostanovjik], [Author], [Style], [TypePerformances]) VALUES (14, 8, N'6                                                                                                   ', N'10                                                                                                  ', N'11                                                                                                  ', N'23                                                                                                  ', N'Феерия                                                                                              ', N'Детские                                                                                             ')
INSERT [dbo].[Performances] ([Performances_ID], [NamePerformance], [DirectorPostanovjik], [ProductionHudojnik], [DerejerPostanovjik], [Author], [Style], [TypePerformances]) VALUES (15, 9, N'5                                                                                                   ', N'10                                                                                                  ', N'12                                                                                                  ', N'33                                                                                                  ', N'Мим                                                                                                 ', N'Молодежные                                                                                          ')
SET IDENTITY_INSERT [dbo].[Performances] OFF
GO
INSERT [dbo].[RepertoireTeatra] ([Performance_IDD], [Tour_IDD], [PeriodEvent], [DaysTimes], [TicketPrice]) VALUES (7, 1, CAST(N'2024-03-27' AS Date), CAST(N'2024-02-12' AS Date), N'3500.00')
INSERT [dbo].[RepertoireTeatra] ([Performance_IDD], [Tour_IDD], [PeriodEvent], [DaysTimes], [TicketPrice]) VALUES (8, 2, CAST(N'2024-03-27' AS Date), CAST(N'2024-06-24' AS Date), N'2100.00')
INSERT [dbo].[RepertoireTeatra] ([Performance_IDD], [Tour_IDD], [PeriodEvent], [DaysTimes], [TicketPrice]) VALUES (9, 3, CAST(N'2024-03-27' AS Date), CAST(N'2024-01-31' AS Date), N'4998.00')
INSERT [dbo].[RepertoireTeatra] ([Performance_IDD], [Tour_IDD], [PeriodEvent], [DaysTimes], [TicketPrice]) VALUES (10, 4, CAST(N'2024-03-27' AS Date), CAST(N'2024-05-25' AS Date), N'5999.00')
INSERT [dbo].[RepertoireTeatra] ([Performance_IDD], [Tour_IDD], [PeriodEvent], [DaysTimes], [TicketPrice]) VALUES (11, 5, CAST(N'2024-03-27' AS Date), CAST(N'2024-07-11' AS Date), N'7999.00')
INSERT [dbo].[RepertoireTeatra] ([Performance_IDD], [Tour_IDD], [PeriodEvent], [DaysTimes], [TicketPrice]) VALUES (12, 6, CAST(N'2024-03-27' AS Date), CAST(N'2024-02-12' AS Date), N'2300.00')
INSERT [dbo].[RepertoireTeatra] ([Performance_IDD], [Tour_IDD], [PeriodEvent], [DaysTimes], [TicketPrice]) VALUES (13, 7, CAST(N'2024-03-27' AS Date), CAST(N'2024-11-29' AS Date), N'3488.00')
INSERT [dbo].[RepertoireTeatra] ([Performance_IDD], [Tour_IDD], [PeriodEvent], [DaysTimes], [TicketPrice]) VALUES (14, 8, CAST(N'2024-03-27' AS Date), CAST(N'2024-10-12' AS Date), N'1299.00')
INSERT [dbo].[RepertoireTeatra] ([Performance_IDD], [Tour_IDD], [PeriodEvent], [DaysTimes], [TicketPrice]) VALUES (15, 9, CAST(N'2024-03-27' AS Date), CAST(N'2024-03-15' AS Date), N'799.00')
GO
INSERT [dbo].[Tour] ([Tour_ID], [NameTour], [StartDate], [EndDate], [LocationTour], [NamePerformance]) VALUES (1, N'Сценические Ориентиры                                                                               ', CAST(N'2022-03-04' AS Date), CAST(N'2022-05-04' AS Date), N'Уфа                                                                                                 ', 1)
INSERT [dbo].[Tour] ([Tour_ID], [NameTour], [StartDate], [EndDate], [LocationTour], [NamePerformance]) VALUES (2, N'Театральные Путешествия                                                                             ', CAST(N'2023-07-01' AS Date), CAST(N'2023-08-01' AS Date), N'Москва                                                                                              ', 2)
INSERT [dbo].[Tour] ([Tour_ID], [NameTour], [StartDate], [EndDate], [LocationTour], [NamePerformance]) VALUES (3, N'Актерские Страницы                                                                                  ', CAST(N'2022-08-23' AS Date), CAST(N'2022-10-23' AS Date), N'Уфа                                                                                                 ', 3)
INSERT [dbo].[Tour] ([Tour_ID], [NameTour], [StartDate], [EndDate], [LocationTour], [NamePerformance]) VALUES (4, N'Мега-Выступления                                                                                    ', CAST(N'2023-12-01' AS Date), CAST(N'2024-02-01' AS Date), N'Казань                                                                                              ', 4)
INSERT [dbo].[Tour] ([Tour_ID], [NameTour], [StartDate], [EndDate], [LocationTour], [NamePerformance]) VALUES (5, N'Империя Выступлений                                                                                 ', CAST(N'2022-07-10' AS Date), CAST(N'2022-08-10' AS Date), N'Нефтекамск                                                                                          ', 5)
INSERT [dbo].[Tour] ([Tour_ID], [NameTour], [StartDate], [EndDate], [LocationTour], [NamePerformance]) VALUES (6, N'Книжное Перевоплощение                                                                              ', CAST(N'2024-03-08' AS Date), CAST(N'2024-05-08' AS Date), N'Новосибирск                                                                                         ', 6)
INSERT [dbo].[Tour] ([Tour_ID], [NameTour], [StartDate], [EndDate], [LocationTour], [NamePerformance]) VALUES (7, N'Мир Театра                                                                                          ', CAST(N'2022-08-01' AS Date), CAST(N'2022-10-01' AS Date), N'Санкт-Петербург                                                                                     ', 7)
INSERT [dbo].[Tour] ([Tour_ID], [NameTour], [StartDate], [EndDate], [LocationTour], [NamePerformance]) VALUES (8, N'Актерское Перевоплощение                                                                            ', CAST(N'2023-02-02' AS Date), CAST(N'2023-03-02' AS Date), N'Казань                                                                                              ', 8)
INSERT [dbo].[Tour] ([Tour_ID], [NameTour], [StartDate], [EndDate], [LocationTour], [NamePerformance]) VALUES (9, N'Лучший Актер                                                                                        ', CAST(N'2022-11-11' AS Date), CAST(N'2022-12-11' AS Date), N'Москва                                                                                              ', 9)
GO
SET IDENTITY_INSERT [dbo].[Troupe] ON 

INSERT [dbo].[Troupe] ([Troupe_ID], [Worker_IDD], [Actors], [NameRole], [Phone], [Performance_IDD]) VALUES (30, 3, 20, N'Герой                                                                                               ', N'+1555123                                                                                            ', NULL)
INSERT [dbo].[Troupe] ([Troupe_ID], [Worker_IDD], [Actors], [NameRole], [Phone], [Performance_IDD]) VALUES (31, 2, 22, N'Антагонист                                                                                          ', N'+44201234                                                                                           ', NULL)
INSERT [dbo].[Troupe] ([Troupe_ID], [Worker_IDD], [Actors], [NameRole], [Phone], [Performance_IDD]) VALUES (32, 1, 26, N'Любовник                                                                                            ', N'+911112345                                                                                          ', NULL)
INSERT [dbo].[Troupe] ([Troupe_ID], [Worker_IDD], [Actors], [NameRole], [Phone], [Performance_IDD]) VALUES (33, 7, 21, N'Мечтатель                                                                                           ', N'+6121234                                                                                            ', NULL)
INSERT [dbo].[Troupe] ([Troupe_ID], [Worker_IDD], [Actors], [NameRole], [Phone], [Performance_IDD]) VALUES (34, 6, 30, N'Мистик                                                                                              ', N'+86101234                                                                                           ', NULL)
INSERT [dbo].[Troupe] ([Troupe_ID], [Worker_IDD], [Actors], [NameRole], [Phone], [Performance_IDD]) VALUES (35, 5, 33, N'Предатель                                                                                           ', N'+33112345                                                                                           ', NULL)
INSERT [dbo].[Troupe] ([Troupe_ID], [Worker_IDD], [Actors], [NameRole], [Phone], [Performance_IDD]) VALUES (36, 9, 31, N'Мечтатель                                                                                           ', N'+8131234                                                                                            ', NULL)
INSERT [dbo].[Troupe] ([Troupe_ID], [Worker_IDD], [Actors], [NameRole], [Phone], [Performance_IDD]) VALUES (37, 8, 29, N'Страж                                                                                               ', N'+490123                                                                                             ', NULL)
INSERT [dbo].[Troupe] ([Troupe_ID], [Worker_IDD], [Actors], [NameRole], [Phone], [Performance_IDD]) VALUES (38, 7, 27, N'Мечтатель                                                                                           ', N'+6402123                                                                                            ', NULL)
SET IDENTITY_INSERT [dbo].[Troupe] OFF
GO
ALTER TABLE [dbo].[RepertoireTeatra]  WITH CHECK ADD  CONSTRAINT [FK_RepertoireTeatra_Performances1] FOREIGN KEY([Performance_IDD])
REFERENCES [dbo].[Performances] ([Performances_ID])
GO
ALTER TABLE [dbo].[RepertoireTeatra] CHECK CONSTRAINT [FK_RepertoireTeatra_Performances1]
GO
ALTER TABLE [dbo].[RepertoireTeatra]  WITH CHECK ADD  CONSTRAINT [FK_RepertoireTeatra_Tour1] FOREIGN KEY([Tour_IDD])
REFERENCES [dbo].[Tour] ([Tour_ID])
GO
ALTER TABLE [dbo].[RepertoireTeatra] CHECK CONSTRAINT [FK_RepertoireTeatra_Tour1]
GO
ALTER TABLE [dbo].[Troupe]  WITH CHECK ADD  CONSTRAINT [FK_Troupe_Employees of the teatr] FOREIGN KEY([Worker_IDD])
REFERENCES [dbo].[Employees of the teatr] ([Worker_ID])
GO
ALTER TABLE [dbo].[Troupe] CHECK CONSTRAINT [FK_Troupe_Employees of the teatr]
GO
ALTER TABLE [dbo].[Troupe]  WITH CHECK ADD  CONSTRAINT [FK_Troupe_Performances1] FOREIGN KEY([Performance_IDD])
REFERENCES [dbo].[Performances] ([Performances_ID])
GO
ALTER TABLE [dbo].[Troupe] CHECK CONSTRAINT [FK_Troupe_Performances1]
GO
ALTER TABLE [dbo].[Employees of the teatr]  WITH CHECK ADD  CONSTRAINT [Experience] CHECK  (([Experience]>(0)))
GO
ALTER TABLE [dbo].[Employees of the teatr] CHECK CONSTRAINT [Experience]
GO
/****** Object:  StoredProcedure [dbo].[checkClient]    Script Date: 11/9/2024 2:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[checkClient] @param int as 
if (select Year_of_birth from [Employees of the teatr] where Worker_ID = @param) > '01-01-1998'
return 1
else
return 0
GO
/****** Object:  StoredProcedure [dbo].[GetContactFormalNames]    Script Date: 11/9/2024 2:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetContactFormalNames]
AS  
BEGIN  
   SELECT TOP 10 Last_name + ' ' + First_name + ' ' + Patronymic AS FormalName
   FROM [Employees of the teatr]  
END
GO
/****** Object:  StoredProcedure [dbo].[SelectCustomersByCity]    Script Date: 11/9/2024 2:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectCustomersByCity]
    @City nvarchar(50)
AS
BEGIN
    SELECT * FROM [Employees of the teatr]
    WHERE City = @City;
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateStudentInfo]    Script Date: 11/9/2024 2:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateStudentInfo]
    @sID int,
    @Fam nvarchar(50),
    @Giv nvarchar(50)
AS
BEGIN
    UPDATE [Employees of the teatr]
    SET Last_name = @Fam, First_name = @Giv
    WHERE Worker_ID = @sID;
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetAddress]    Script Date: 11/9/2024 2:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetAddress] @City nvarchar(30)
AS
SELECT * 
FROM [Employees of the teatr]
WHERE City = @City
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[23] 4[16] 2[6] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Employees of the teatr"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 253
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'FirstView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'FirstView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[15] 4[18] 2[5] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Employees of the teatr"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 253
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 2625
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SecondView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SecondView'
GO
USE [master]
GO
ALTER DATABASE [Teatr] SET  READ_WRITE 
GO
