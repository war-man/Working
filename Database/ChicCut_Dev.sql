USE [master]
GO
/****** Object:  Database [ChicCut_Dev]    Script Date: 3/1/2018 3:41:25 PM ******/
CREATE DATABASE [ChicCut_Dev]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ChicCut', FILENAME = N'D:\Database\ChicCut_Dev.mdf' , SIZE = 12928KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ChicCut_log', FILENAME = N'D:\Database\ChicCut_Dev_log.ldf' , SIZE = 16576KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ChicCut_Dev] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ChicCut_Dev].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ChicCut_Dev] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ChicCut_Dev] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ChicCut_Dev] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ChicCut_Dev] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ChicCut_Dev] SET ARITHABORT OFF 
GO
ALTER DATABASE [ChicCut_Dev] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ChicCut_Dev] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ChicCut_Dev] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ChicCut_Dev] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ChicCut_Dev] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ChicCut_Dev] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ChicCut_Dev] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ChicCut_Dev] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ChicCut_Dev] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ChicCut_Dev] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ChicCut_Dev] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ChicCut_Dev] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ChicCut_Dev] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ChicCut_Dev] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ChicCut_Dev] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ChicCut_Dev] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ChicCut_Dev] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ChicCut_Dev] SET RECOVERY FULL 
GO
ALTER DATABASE [ChicCut_Dev] SET  MULTI_USER 
GO
ALTER DATABASE [ChicCut_Dev] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ChicCut_Dev] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ChicCut_Dev] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ChicCut_Dev] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [ChicCut_Dev] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ChicCut_Dev', N'ON'
GO
USE [ChicCut_Dev]
GO
/****** Object:  User [useradmin]    Script Date: 3/1/2018 3:41:26 PM ******/
CREATE USER [useradmin] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [useradmin]
GO
/****** Object:  UserDefinedTableType [dbo].[PriceList]    Script Date: 3/1/2018 3:41:26 PM ******/
CREATE TYPE [dbo].[PriceList] AS TABLE(
	[ProductId] [int] NOT NULL,
	[CustomerLevelId] [int] NOT NULL,
	[Price] [decimal](18, 0) NULL,
	PRIMARY KEY CLUSTERED 
(
	[CustomerLevelId] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  UserDefinedTableType [dbo].[ProductList]    Script Date: 3/1/2018 3:41:27 PM ******/
CREATE TYPE [dbo].[ProductList] AS TABLE(
	[ProductId] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[ServiceList]    Script Date: 3/1/2018 3:41:27 PM ******/
CREATE TYPE [dbo].[ServiceList] AS TABLE(
	[ServiceId] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[UpdateProductList]    Script Date: 3/1/2018 3:41:27 PM ******/
CREATE TYPE [dbo].[UpdateProductList] AS TABLE(
	[ProductUpdateMasterId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[ProductStoreCode] [nvarchar](max) NULL,
	[ProductCode] [nvarchar](max) NULL,
	[ProductName] [nvarchar](max) NULL,
	[ImportPrice] [decimal](18, 0) NULL,
	[ExchangeRate] [decimal](18, 0) NULL,
	[ShippingFee] [decimal](18, 0) NULL,
	PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  UserDefinedTableType [dbo].[UpdateProductList2]    Script Date: 3/1/2018 3:41:28 PM ******/
CREATE TYPE [dbo].[UpdateProductList2] AS TABLE(
	[ProductUpdateMasterId] [int] NOT NULL,
	[ProductId] [int] NULL,
	[ProductStoreCode] [nvarchar](max) NULL,
	[ProductCode] [nvarchar](max) NULL,
	[ProductName] [nvarchar](max) NULL,
	[ImportPrice] [decimal](18, 0) NULL,
	[ExchangeRate] [decimal](18, 0) NULL,
	[ShippingFee] [decimal](18, 0) NULL,
	PRIMARY KEY CLUSTERED 
(
	[ProductUpdateMasterId] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  UserDefinedFunction [dbo].[Num2Text]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Num2Text](@Number int)
RETURNS nvarchar(4000) AS
BEGIN
DECLARE @sNumber nvarchar(4000)
DECLARE @Return nvarchar(4000)
DECLARE @mLen int
DECLARE @i int
DECLARE @mDigit int
DECLARE @mGroup int
DECLARE @mTemp nvarchar(4000)
DECLARE @mNumText nvarchar(4000)
 
SELECT @sNumber=LTRIM(STR(@Number))
SELECT @mLen = Len(@sNumber)
SELECT @i=1
SELECT @mTemp=''
 
WHILE @i <= @mLen
BEGIN
SELECT @mDigit=SUBSTRING(@sNumber, @i, 1)
IF @mDigit=0 SELECT @mNumText=N'không'
ELSE
BEGIN
    IF @mDigit=1 SELECT @mNumText=N'một'
    ELSE
    IF @mDigit=2 SELECT @mNumText=N'hai'
    ELSE
    IF @mDigit=3 SELECT @mNumText=N'ba'
    ELSE
    IF @mDigit=4 SELECT @mNumText=N'bốn'
    ELSE
    IF @mDigit=5 SELECT @mNumText=N'năm'
    ELSE
    IF @mDigit=6 SELECT @mNumText=N'sáu'
    ELSE
    IF @mDigit=7 SELECT @mNumText=N'bảy'
    ELSE
    IF @mDigit=8 SELECT @mNumText=N'tám'
    ELSE
    IF @mDigit=9 SELECT @mNumText=N'chín'
END
 
SELECT @mTemp = @mTemp + ' ' + @mNumText
 
IF (@mLen = @i) BREAK
 
Select @mGroup=(@mLen - @i) % 9
 
IF @mGroup=0
BEGIN
    SELECT @mTemp = @mTemp + N' tỷ'
 
    If SUBSTRING(@sNumber, @i + 1, 3) = N'000'
    SELECT @i = @i + 3
 
    If SUBSTRING(@sNumber, @i + 1, 3) = N'000'
    SELECT @i = @i + 3
 
    If SUBSTRING(@sNumber, @i + 1, 3) = N'000'
    SELECT @i = @i + 3
END
ELSE
IF @mGroup=6
BEGIN
    SELECT @mTemp = @mTemp + N' triệu'
 
    If SUBSTRING(@sNumber, @i + 1, 3) = N'000'
    SELECT @i = @i + 3
 
    If SUBSTRING(@sNumber, @i + 1, 3) = N'000'
    SELECT @i = @i + 3
END
ELSE
IF @mGroup=3
BEGIN
    SELECT @mTemp = @mTemp + N' nghìn'
    If SUBSTRING(@sNumber, @i + 1, 3) = N'000'
    SELECT @i = @i + 3
 
END
ELSE
BEGIN
    Select @mGroup=(@mLen - @i) % 3
    IF @mGroup=2   
    SELECT @mTemp = @mTemp + N' trăm'
    ELSE
    IF @mGroup=1
    SELECT @mTemp = @mTemp + N' mươi'  
END
SELECT @i=@i+1
END
 
--'Loại bỏ trường hợp x00
SELECT @mTemp = Replace(@mTemp, N'không mươi không', '')
 
--'Loại bỏ trường hợp 00x
SELECT @mTemp = Replace(@mTemp, N'không mươi ', N'linh ')
 
--'Loại bỏ trường hợp x0, x>=2
SELECT @mTemp = Replace(@mTemp, N'mươi không', N'mươi')
 
--'Fix trường hợp 10
SELECT @mTemp = Replace(@mTemp, N'một mươi', N'mười')
 
--'Fix trường hợp x4, x>=2
SELECT @mTemp = Replace(@mTemp, N'mươi bốn', N'mươi tư')
 
--'Fix trường hợp x04
SELECT @mTemp = Replace(@mTemp, N'linh bốn', N'linh tư')
 
--'Fix trường hợp x5, x>=2
SELECT @mTemp = Replace(@mTemp, N'mươi năm', N'mươi lăm')
 
--'Fix trường hợp x1, x>=2
SELECT @mTemp = Replace(@mTemp, N'mươi một', N'mươi mốt')
 
--'Fix trường hợp x15
SELECT @mTemp = Replace(@mTemp, N'mười năm', N'mười lăm')
 
--'Bỏ ký tự space
SELECT @mTemp = LTrim(@mTemp)
 
--'Ucase ký tự đầu tiên
SELECT @Return=UPPER(Left(@mTemp, 1)) + SUBSTRING(@mTemp,2, 4000) + N' đồng.'
 
RETURN @Return 
END 

GO
/****** Object:  Table [dbo].[AccessModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccessModel](
	[RolesId] [int] NOT NULL,
	[PageId] [int] NOT NULL,
 CONSTRAINT [PK_AccessModel] PRIMARY KEY CLUSTERED 
(
	[RolesId] ASC,
	[PageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AccountModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountModel](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](100) NULL,
	[Password] [nvarchar](100) NULL,
	[RolesId] [int] NULL,
	[isCustomer] [bit] NULL,
	[CustomerId] [int] NULL,
	[EmployeeId] [int] NULL,
	[Actived] [bit] NULL,
 CONSTRAINT [PK_AccountModel] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AM_AccountModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AM_AccountModel](
	[AMAccountId] [int] IDENTITY(1,1) NOT NULL,
	[AMAccountTypeCode] [nvarchar](10) NULL,
	[StoreId] [int] NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_AM_AccountModel] PRIMARY KEY CLUSTERED 
(
	[AMAccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AM_AccountTypeModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AM_AccountTypeModel](
	[AMAccountTypeCode] [nvarchar](10) NOT NULL,
	[AMAccountTypeName] [nvarchar](50) NULL,
 CONSTRAINT [PK_AccAccountTypeModel] PRIMARY KEY CLUSTERED 
(
	[AMAccountTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AM_ContactItemTypeModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AM_ContactItemTypeModel](
	[ContactItemTypeCode] [nvarchar](10) NOT NULL,
	[ContactItemTypeName] [nvarchar](50) NULL,
	[OrderBy] [int] NULL,
 CONSTRAINT [PK_AM_ContactItemTypeModel] PRIMARY KEY CLUSTERED 
(
	[ContactItemTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AM_DebtModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AM_DebtModel](
	[DebtId] [int] IDENTITY(1000,1) NOT NULL,
	[SupplierId] [int] NULL,
	[CustomerId] [int] NULL,
	[TimeOfDebt] [datetime] NULL,
	[RemainingAmountAccrued] [decimal](18, 2) NULL,
	[ImportId] [int] NULL,
	[OrderId] [int] NULL,
	[ReturnMasterId] [int] NULL,
	[OrderReturnId] [int] NULL,
	[TransactionId] [int] NULL,
	[TransactionTypeCode] [nvarchar](10) NULL,
 CONSTRAINT [PK_AM_DebtModel] PRIMARY KEY CLUSTERED 
(
	[DebtId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AM_TransactionModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AM_TransactionModel](
	[TransactionId] [int] IDENTITY(1000,1) NOT NULL,
	[StoreId] [int] NULL,
	[AMAccountId] [int] NULL,
	[TransactionTypeCode] [nvarchar](10) NULL,
	[ContactItemTypeCode] [nvarchar](10) NULL,
	[CustomerId] [int] NULL,
	[SupplierId] [int] NULL,
	[EmployeeId] [int] NULL,
	[OtherId] [int] NULL,
	[Amount] [decimal](18, 2) NULL,
	[OrderId] [int] NULL,
	[ImportMasterId] [int] NULL,
	[IEOtherMasterId] [int] NULL,
	[Note] [nvarchar](40) NULL,
	[CreateDate] [datetime] NULL,
	[CreateEmpId] [int] NULL,
	[Address] [nvarchar](500) NULL,
	[RemainingAmountAccrued] [decimal](18, 2) NULL,
 CONSTRAINT [PK_AM_TransactionModel] PRIMARY KEY CLUSTERED 
(
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AM_TransactionTypeModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AM_TransactionTypeModel](
	[TransactionTypeCode] [nvarchar](10) NOT NULL,
	[TransactionTypeName] [nvarchar](50) NULL,
	[GroupCode] [nvarchar](10) NULL,
	[OrderBy] [int] NULL,
	[isImport] [bit] NULL,
 CONSTRAINT [PK_AM_TransactionTypeModel] PRIMARY KEY CLUSTERED 
(
	[TransactionTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AY_SMSCalendar]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AY_SMSCalendar](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SMSContent] [ntext] NULL,
	[SMSTo] [nvarchar](50) NULL,
	[EndDate] [datetime] NULL,
	[isSent] [bit] NULL,
	[NumberOfFailed] [int] NULL,
 CONSTRAINT [PK_SMSCalendar] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BranchModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BranchModel](
	[BranchId] [int] IDENTITY(1,1) NOT NULL,
	[BranchName] [nvarchar](200) NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_BranchModel] PRIMARY KEY CLUSTERED 
(
	[BranchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CalendarModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CalendarModel](
	[CalendarId] [int] IDENTITY(1,1) NOT NULL,
	[CourseId] [int] NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[LocationId] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[Time] [nvarchar](4000) NULL,
	[Price] [decimal](18, 0) NULL,
	[NumberOfTrainees] [int] NOT NULL,
	[TotalOfReg] [int] NULL,
	[isHot] [bit] NOT NULL,
	[HotIndex] [int] NULL,
	[Actived] [bit] NOT NULL,
	[UserCreated] [nvarchar](100) NULL,
	[DateCreated] [datetime] NULL,
	[UserModified] [nvarchar](100) NULL,
	[DateModified] [datetime] NULL,
 CONSTRAINT [PK_CourseDetailId] PRIMARY KEY CLUSTERED 
(
	[CalendarId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CategoryModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryModel](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](4000) NULL,
	[CategoryNameEn] [nvarchar](4000) NULL,
	[OrderBy] [int] NULL,
	[Parent] [int] NULL,
	[Keywords] [nvarchar](200) NULL,
	[KeywordsEn] [nvarchar](200) NULL,
	[Description] [ntext] NULL,
	[DescriptionEn] [ntext] NULL,
	[ImageUrl] [nvarchar](4000) NULL,
	[SEOCategoryName] [nvarchar](4000) NULL,
	[isHasChildren] [bit] NOT NULL,
	[Actived] [bit] NOT NULL,
	[ADNCode] [nvarchar](4000) NULL,
	[isDisplayOnHomePage] [bit] NULL,
 CONSTRAINT [PK__Category__19093A0B42E1EEFE] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CourseModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseModel](
	[CourseId] [int] IDENTITY(1000,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[CourseName] [nvarchar](500) NULL,
	[Description] [nvarchar](4000) NULL,
	[Details] [ntext] NULL,
	[Url] [nvarchar](500) NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_CourseModel] PRIMARY KEY CLUSTERED 
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CRM_EmailParameterModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_EmailParameterModel](
	[EmailParameterId] [int] IDENTITY(1,1) NOT NULL,
	[EmailTemplateId] [int] NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [nvarchar](1000) NULL,
 CONSTRAINT [PK_CRM_EmailParameterModel] PRIMARY KEY CLUSTERED 
(
	[EmailParameterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CRM_EmailTemplateModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_EmailTemplateModel](
	[EmailTemplateId] [int] IDENTITY(1000,1) NOT NULL,
	[EmailTemplateName] [nvarchar](300) NULL,
	[EmailContent] [ntext] NULL,
	[Actived] [bit] NULL,
	[EmailTitle] [nvarchar](200) NULL,
 CONSTRAINT [PK_CRM_EmailTemplateModel] PRIMARY KEY CLUSTERED 
(
	[EmailTemplateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CRM_ObjectModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_ObjectModel](
	[ObjectId] [int] IDENTITY(1,1) NOT NULL,
	[ObjectName] [nvarchar](50) NULL,
	[Actived] [bit] NULL,
 CONSTRAINT [PK_CRM_ObjectModel] PRIMARY KEY CLUSTERED 
(
	[ObjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CRM_PeriodModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_PeriodModel](
	[PeriodCode] [nvarchar](10) NOT NULL,
	[PeriodName] [nvarchar](200) NULL,
	[Actived] [bit] NULL,
	[OrderIndex] [int] NULL,
 CONSTRAINT [PK_CRM_PeriodModel] PRIMARY KEY CLUSTERED 
(
	[PeriodCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CRM_Remider_EmailParameter_Mapping]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_Remider_EmailParameter_Mapping](
	[RemiderId] [int] NOT NULL,
	[EmailTemplateId] [int] NOT NULL,
	[EmailParameterId] [int] NOT NULL,
	[ValueType] [nvarchar](50) NULL,
	[Value] [nvarchar](500) NULL,
 CONSTRAINT [PK_CRM_Remider_EmailParameter_Mapping] PRIMARY KEY CLUSTERED 
(
	[RemiderId] ASC,
	[EmailTemplateId] ASC,
	[EmailParameterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CRM_Remider_SMSParameter_Mapping]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_Remider_SMSParameter_Mapping](
	[RemiderId] [int] NOT NULL,
	[SMSTemplateId] [int] NOT NULL,
	[SMSParameterId] [int] NOT NULL,
	[ValueType] [nvarchar](50) NULL,
	[Value] [nvarchar](500) NULL,
 CONSTRAINT [PK_CRM_Remider_SMSParameter_Mapping] PRIMARY KEY CLUSTERED 
(
	[RemiderId] ASC,
	[SMSParameterId] ASC,
	[SMSTemplateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CRM_RemiderAUTOTypeModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_RemiderAUTOTypeModel](
	[ValueCode] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_CRM_RemiderAUTOTypeModel] PRIMARY KEY CLUSTERED 
(
	[ValueCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CRM_RemiderModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_RemiderModel](
	[RemiderId] [int] IDENTITY(1000,1) NOT NULL,
	[RemiderName] [nvarchar](500) NULL,
	[ObjectId] [int] NULL,
	[CustomerId] [int] NULL,
	[SupplierId] [int] NULL,
	[PeriodType] [int] NULL,
	[ExpiryDate] [datetime] NULL,
	[DaysPriorNotice] [int] NULL,
	[PeriodCode] [nvarchar](10) NULL,
	[StartDate] [datetime] NULL,
	[isEmailNotified] [bit] NULL,
	[isSMSNotifred] [bit] NULL,
	[EmailTemplateId] [int] NULL,
	[SMSTemplateId] [int] NULL,
	[EmployeeId] [int] NULL,
	[isCCEmail] [bit] NULL,
	[EmailOfEmployee] [nvarchar](500) NULL,
	[Note] [ntext] NULL,
	[Actived] [bit] NULL,
	[NDays] [int] NULL,
	[LastDateRemind] [datetime] NULL,
	[NextDateRemind] [datetime] NULL,
	[Price] [decimal](18, 2) NULL,
	[isCCSMS] [bit] NULL,
	[SMSOfEmployee] [nvarchar](500) NULL,
	[ServiceContent] [ntext] NULL,
 CONSTRAINT [PK_CRM_RemiderModel] PRIMARY KEY CLUSTERED 
(
	[RemiderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CRM_RemiderValueTypeModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_RemiderValueTypeModel](
	[ValueTypeId] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](500) NULL,
 CONSTRAINT [PK_CRM_RemiderValueTypeModel] PRIMARY KEY CLUSTERED 
(
	[ValueTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CRM_SMSParameterModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_SMSParameterModel](
	[SMSParameterId] [int] IDENTITY(1,1) NOT NULL,
	[SMSTemplateId] [int] NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [nvarchar](1000) NULL,
 CONSTRAINT [PK_CRM_SMSParameterModel] PRIMARY KEY CLUSTERED 
(
	[SMSParameterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CRM_SMSTemplateModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_SMSTemplateModel](
	[SMSTemplateId] [int] IDENTITY(1000,1) NOT NULL,
	[SMSTemplateName] [nvarchar](300) NULL,
	[SMSContent] [nvarchar](1000) NULL,
	[Actived] [bit] NULL,
 CONSTRAINT [PK_CRM_SMSTemplateModel] PRIMARY KEY CLUSTERED 
(
	[SMSTemplateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CurrencyModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CurrencyModel](
	[CurrencyId] [int] IDENTITY(1,1) NOT NULL,
	[CurrencyName] [nvarchar](200) NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_CurrencyModel] PRIMARY KEY CLUSTERED 
(
	[CurrencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerLevelModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerLevelModel](
	[CustomerLevelId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerLevelName] [nvarchar](300) NULL,
	[MinimumPurchase] [decimal](18, 0) NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_CustomerLevelModel] PRIMARY KEY CLUSTERED 
(
	[CustomerLevelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerModel](
	[CustomerId] [int] IDENTITY(10000,1) NOT NULL,
	[CustomerLevelId] [int] NULL,
	[FullName] [nvarchar](500) NULL,
	[ShortName] [nvarchar](500) NULL,
	[IdentityCard] [nvarchar](50) NULL,
	[Gender] [bit] NULL,
	[BirthDay] [datetime] NULL,
	[EnterpriseName] [nvarchar](500) NULL,
	[TaxCode] [nvarchar](200) NULL,
	[Phone] [nvarchar](50) NULL,
	[Fax] [nvarchar](50) NULL,
	[Email] [nvarchar](200) NULL,
	[ImageUrl] [nvarchar](100) NULL,
	[Note] [ntext] NULL,
	[ProvinceId] [int] NULL,
	[DistrictId] [int] NULL,
	[Address] [nvarchar](1000) NULL,
	[AdditionalPurchase] [decimal](18, 0) NULL,
	[Actived] [bit] NULL,
	[EmployeeId] [int] NULL,
	[RegDate] [datetime] NULL,
 CONSTRAINT [PK_CustomerModel] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Daily_ChicCut_OrderDetailModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Daily_ChicCut_OrderDetailModel](
	[OrderDetailId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NULL,
	[ServiceId] [int] NULL,
	[COGS] [decimal](18, 2) NULL,
	[Price] [decimal](18, 2) NULL,
	[Qty] [decimal](18, 2) NULL,
	[UnitCOGS] [decimal](18, 2) NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[QuantificationMasterId] [int] NULL,
 CONSTRAINT [PK_Daily_ChicCut_OrderDetailModel] PRIMARY KEY CLUSTERED 
(
	[OrderDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Daily_ChicCut_OrderModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Daily_ChicCut_OrderModel](
	[OrderId] [int] IDENTITY(1000000,1) NOT NULL,
	[PaymentMethodId] [int] NULL,
	[isHoliday] [int] NULL,
	[CustomerId] [int] NULL,
	[FullName] [nvarchar](500) NULL,
	[IdentityCard] [nvarchar](50) NULL,
	[HairTypeId] [int] NULL,
	[Gender] [bit] NULL,
	[Phone] [nvarchar](50) NULL,
	[OrderStatusId] [int] NULL,
	[CreatedUserId] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CashierUserId] [int] NULL,
	[CashierDate] [datetime] NULL,
	[CanceledUserId] [int] NULL,
	[CanceledDate] [datetime] NULL,
	[SumCOGSOfOrderDetail] [decimal](18, 2) NULL,
	[SumPriceOfOrderDetail] [decimal](18, 2) NULL,
	[AdditionalPrice] [decimal](18, 2) NULL,
	[BillDiscountTypeId] [int] NULL,
	[BillDiscount] [decimal](18, 2) NULL,
	[TotalBillDiscount] [decimal](18, 2) NULL,
	[Total] [decimal](18, 2) NULL,
	[Note] [nvarchar](2000) NULL,
	[StaffId] [int] NULL,
	[Tip] [decimal](18, 2) NULL,
	[Commission] [decimal](18, 2) NULL,
	[ProductCommission] [decimal](18, 2) NULL,
	[HolidayCommission] [decimal](18, 2) NULL,
	[CanceledReason] [nvarchar](500) NULL,
 CONSTRAINT [PK_Daily_ChicCut_OrderModel] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Daily_ChicCut_OrderProductDetailModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Daily_ChicCut_OrderProductDetailModel](
	[OrderProductDetailId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NULL,
	[ProductId] [int] NULL,
	[COGS] [decimal](18, 2) NULL,
	[Price] [decimal](18, 2) NULL,
	[Qty] [decimal](18, 2) NULL,
	[UnitCOGS] [decimal](18, 2) NULL,
	[UnitPrice] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Daily_ChicCut_OrderProductDetailModel] PRIMARY KEY CLUSTERED 
(
	[OrderProductDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Daily_ChicCut_OrderStatusModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Daily_ChicCut_OrderStatusModel](
	[OrderStatusId] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [nvarchar](50) NULL,
	[Description] [nvarchar](2000) NULL,
	[StatusNameForSMS] [nvarchar](50) NULL,
 CONSTRAINT [PK_Daily_ChicCut_OrderStatusModel] PRIMARY KEY CLUSTERED 
(
	[OrderStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Daily_ChicCut_Pre_DayOffModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Daily_ChicCut_Pre_DayOffModel](
	[DateTIme] [date] NOT NULL,
 CONSTRAINT [PK_Daily_ChicCut_Pre_DayOffModel] PRIMARY KEY CLUSTERED 
(
	[DateTIme] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Daily_ChicCut_Pre_OrderDetailModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Daily_ChicCut_Pre_OrderDetailModel](
	[PreOrderDetailId] [int] IDENTITY(1,1) NOT NULL,
	[PreOrderId] [int] NULL,
	[ServiceCategoryId] [int] NULL,
	[COGS] [decimal](18, 2) NULL,
	[MinPrice] [decimal](18, 2) NULL,
	[MaxPrice] [decimal](18, 2) NULL,
	[Qty] [decimal](18, 2) NULL,
	[UnitCOGS] [decimal](18, 2) NULL,
	[MinUnitPrice] [decimal](18, 2) NULL,
	[MaxUnitPrice] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Daily_ChicCut_Pre_OrderDetailModel] PRIMARY KEY CLUSTERED 
(
	[PreOrderDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Daily_ChicCut_Pre_OrderModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Daily_ChicCut_Pre_OrderModel](
	[PreOrderId] [int] IDENTITY(1000000,1) NOT NULL,
	[OrderId] [int] NULL,
	[CustomerId] [int] NULL,
	[FullName] [nvarchar](500) NULL,
	[IdentityCard] [nvarchar](50) NULL,
	[HairTypeId] [int] NULL,
	[Gender] [bit] NULL,
	[Phone] [nvarchar](50) NULL,
	[BillDiscountTypeId] [int] NULL,
	[BillDiscount] [decimal](18, 2) NULL,
	[OrderStatusId] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedUserId] [int] NULL,
	[CanceledDate] [datetime] NULL,
	[CanceledUserId] [int] NULL,
	[SumCOGSOfOrderDetail] [decimal](18, 2) NULL,
	[MinSumPriceOfOrderDetail] [decimal](18, 2) NULL,
	[MaxSumPriceOfOrderDetail] [decimal](18, 2) NULL,
	[MinTotalBillDiscount] [decimal](18, 2) NULL,
	[MaxTotalBillDiscount] [decimal](18, 2) NULL,
	[MinTotal] [decimal](18, 2) NULL,
	[MaxTotal] [decimal](18, 2) NULL,
	[Note] [nvarchar](1000) NULL,
	[AppointmentTime] [datetime] NULL,
	[PreOrderCode] [nvarchar](20) NULL,
	[ServicesName] [nvarchar](1000) NULL,
	[ServicesNote] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Daily_ChicCut_Pre_OrderModel] PRIMARY KEY CLUSTERED 
(
	[PreOrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Daily_ChicCut_Pre_SettingModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Daily_ChicCut_Pre_SettingModel](
	[Code] [nvarchar](10) NOT NULL,
	[ReserveFrom] [int] NULL,
	[ReserveTo] [int] NULL,
 CONSTRAINT [PK_Daily_ChicCut_Pre_SettingModel] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Daily_ChicCut_Pre_ShiftModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Daily_ChicCut_Pre_ShiftModel](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[FromTime] [time](7) NULL,
	[ToTime] [time](7) NULL,
	[Actived] [bit] NULL,
 CONSTRAINT [PK_Daily_ChicCut_Pre_ShiftModel] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Daily_ChicCut_WorkingDateModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Daily_ChicCut_WorkingDateModel](
	[DayOff] [date] NOT NULL,
 CONSTRAINT [PK_Daily_ChicCut_WorkingDateModel] PRIMARY KEY CLUSTERED 
(
	[DayOff] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Daily_ChicCut_WorkingTimeModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Daily_ChicCut_WorkingTimeModel](
	[WorkingTimeCode] [int] NOT NULL,
	[FromTime] [time](7) NULL,
	[ToTime] [time](7) NULL,
 CONSTRAINT [PK_Daily_ChicCut_WorkingTimeModel] PRIMARY KEY CLUSTERED 
(
	[WorkingTimeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DiscountModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiscountModel](
	[DiscountId] [int] IDENTITY(1,1) NOT NULL,
	[CalendarId] [int] NOT NULL,
	[Days] [int] NULL,
	[Qty] [int] NULL,
	[Discount] [decimal](18, 0) NULL,
	[Curent] [int] NULL,
 CONSTRAINT [PK_DiscountModel] PRIMARY KEY CLUSTERED 
(
	[DiscountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DiscountTypeModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiscountTypeModel](
	[DiscountTypeId] [int] NOT NULL,
	[DiscountName] [nvarchar](50) NULL,
 CONSTRAINT [PK_DiscountTypeModel] PRIMARY KEY CLUSTERED 
(
	[DiscountTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DistrictModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DistrictModel](
	[DistrictId] [int] IDENTITY(1,1) NOT NULL,
	[ProvinceId] [int] NULL,
	[Appellation] [nvarchar](50) NULL,
	[DistrictName] [nvarchar](200) NULL,
	[Location] [nvarchar](100) NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_DistrictModel] PRIMARY KEY CLUSTERED 
(
	[DistrictId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmployeeModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeModel](
	[EmployeeId] [int] IDENTITY(10001,1) NOT NULL,
	[FullName] [nvarchar](500) NULL,
	[IdentityCard] [nvarchar](50) NULL,
	[Gender] [bit] NULL,
	[BirthDay] [datetime] NULL,
	[Phone] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[Actived] [bit] NOT NULL,
	[StoreId] [int] NULL,
	[ParentId] [int] NULL,
 CONSTRAINT [PK_EmployeeModel] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ExchangeRateModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExchangeRateModel](
	[ExchangeRateId] [int] IDENTITY(1,1) NOT NULL,
	[CurrencyId] [int] NULL,
	[ExchangeRate] [float] NULL,
	[ExchangeDate] [datetime] NULL,
 CONSTRAINT [PK_ExchangeRateModel] PRIMARY KEY CLUSTERED 
(
	[ExchangeRateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IEOtherDetailModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IEOtherDetailModel](
	[IEOtherDetailId] [int] IDENTITY(1000,1) NOT NULL,
	[IEOtherMasterId] [int] NULL,
	[ProductId] [int] NULL,
	[Price] [decimal](18, 2) NULL,
	[ImportQty] [decimal](18, 2) NULL,
	[ExportQty] [decimal](18, 2) NULL,
	[UnitShippingWeight] [decimal](18, 2) NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[Note] [nvarchar](200) NULL,
 CONSTRAINT [PK_IEOtherDetailModel] PRIMARY KEY CLUSTERED 
(
	[IEOtherDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IEOtherMasterModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IEOtherMasterModel](
	[IEOtherMasterId] [int] IDENTITY(1000,1) NOT NULL,
	[IEOtherMasterCode] [nvarchar](50) NULL,
	[WarehouseId] [int] NOT NULL,
	[InventoryTypeId] [int] NOT NULL,
	[CustomerName] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[SenderName] [nvarchar](50) NULL,
	[ReceiverName] [nvarchar](50) NULL,
	[Note] [nvarchar](50) NULL,
	[TotalPrice] [decimal](18, 2) NULL,
	[Money] [decimal](18, 2) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedAccount] [nvarchar](50) NULL,
	[CreatedEmployeeId] [int] NULL,
	[DeletedDate] [datetime] NULL,
	[DeletedAccount] [nvarchar](50) NULL,
	[DeletedEmployeeId] [int] NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_IEOtherModel] PRIMARY KEY CLUSTERED 
(
	[IEOtherMasterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ImportDetailModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImportDetailModel](
	[ImportDetailId] [int] IDENTITY(1,1) NOT NULL,
	[ImportMasterId] [int] NULL,
	[ProductId] [int] NULL,
	[Qty] [decimal](18, 2) NULL,
	[Price] [decimal](18, 2) NULL,
	[UnitShippingWeight] [decimal](18, 2) NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[Note] [nvarchar](100) NULL,
	[ShippingFee] [decimal](18, 2) NULL,
	[UnitCOGS] [decimal](18, 2) NULL,
 CONSTRAINT [PK_ImportDetailModel] PRIMARY KEY CLUSTERED 
(
	[ImportDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ImportMasterModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImportMasterModel](
	[ImportMasterId] [int] IDENTITY(1000,1) NOT NULL,
	[ImportMasterCode] [nvarchar](50) NULL,
	[StoreId] [int] NULL,
	[WarehouseId] [int] NULL,
	[InventoryTypeId] [int] NULL,
	[SupplierId] [int] NULL,
	[SalemanName] [nvarchar](200) NULL,
	[SenderName] [nvarchar](200) NULL,
	[ReceiverName] [nvarchar](200) NULL,
	[Note] [ntext] NULL,
	[VATType] [nvarchar](50) NULL,
	[VATValue] [decimal](18, 2) NULL,
	[TAXBillCode] [nvarchar](50) NULL,
	[TAXBillDate] [datetime] NULL,
	[ManualDiscountType] [nvarchar](50) NULL,
	[ManualDiscount] [decimal](18, 2) NULL,
	[DebtDueDate] [datetime] NULL,
	[CurrencyId] [int] NULL,
	[ExchangeRate] [decimal](18, 2) NULL,
	[TotalPrice] [decimal](18, 2) NULL,
	[TotalQty] [decimal](18, 2) NULL,
	[TotalShippingWeight] [decimal](18, 2) NULL,
	[Paid] [decimal](18, 2) NULL,
	[MoneyTransfer] [decimal](18, 2) NULL,
	[RemainingAmount] [decimal](18, 2) NULL,
	[RemainingAmountAccrued] [decimal](18, 2) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedAccount] [nvarchar](50) NULL,
	[CreatedEmployeeId] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
	[LastModifiedAccount] [nvarchar](50) NULL,
	[LastModifiedEmployeeId] [int] NULL,
	[DeletedDate] [datetime] NULL,
	[DeletedAccount] [nvarchar](50) NULL,
	[DeletedEmployeeId] [int] NULL,
	[Actived] [bit] NOT NULL,
	[SumCOGSOfOrderDetail] [decimal](18, 2) NULL,
	[SumPriceOfOrderDetail] [decimal](18, 2) NULL,
	[TotalBillDiscount] [decimal](18, 2) NULL,
	[TotalVAT] [decimal](18, 2) NULL,
 CONSTRAINT [PK_ImportMasterModel] PRIMARY KEY CLUSTERED 
(
	[ImportMasterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InventoryDetailModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryDetailModel](
	[InventoryDetailId] [int] IDENTITY(1000,1) NOT NULL,
	[InventoryMasterId] [int] NULL,
	[ProductId] [int] NULL,
	[BeginInventoryQty] [decimal](21, 5) NULL,
	[COGS] [decimal](18, 2) NULL,
	[Price] [decimal](21, 5) NULL,
	[ImportQty] [decimal](21, 5) NULL,
	[ExportQty] [decimal](21, 5) NULL,
	[UnitCOGS] [decimal](18, 2) NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[EndInventoryQty] [decimal](21, 5) NULL,
	[Note] [nvarchar](200) NULL,
 CONSTRAINT [PK_InventoryDetailModel] PRIMARY KEY CLUSTERED 
(
	[InventoryDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InventoryMasterModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryMasterModel](
	[InventoryMasterId] [int] IDENTITY(1000,1) NOT NULL,
	[InventoryCode] [nvarchar](50) NULL,
	[WarehouseModelId] [int] NULL,
	[InventoryTypeId] [int] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedAccount] [nvarchar](50) NULL,
	[CreatedEmployeeId] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
	[LastModifiedAccount] [nvarchar](50) NULL,
	[LastModifiedEmployeeId] [int] NULL,
	[DeletedDate] [datetime] NULL,
	[DeletedAccount] [nvarchar](50) NULL,
	[DeletedEmployeeId] [int] NULL,
	[Actived] [bit] NOT NULL,
	[BusinessId] [int] NULL,
	[BusinessName] [nvarchar](50) NULL,
	[ActionUrl] [nvarchar](50) NULL,
	[StoreId] [int] NULL,
 CONSTRAINT [PK_ReventoryMasterModel] PRIMARY KEY CLUSTERED 
(
	[InventoryMasterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InventoryTypeModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryTypeModel](
	[InventoryTypeId] [int] NOT NULL,
	[InventoryTypeCode] [nvarchar](50) NULL,
	[InventoryTypeName] [nvarchar](50) NULL,
	[Description] [nvarchar](1000) NULL,
	[isImport] [bit] NULL,
 CONSTRAINT [PK_ImportTypeModel] PRIMARY KEY CLUSTERED 
(
	[InventoryTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LanguageModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LanguageModel](
	[LanguageId] [int] IDENTITY(10001,1) NOT NULL,
	[Code] [nvarchar](10) NULL,
	[LanguageName] [nvarchar](50) NULL,
 CONSTRAINT [PK__Language__B93855AB70DDC3D8] PRIMARY KEY CLUSTERED 
(
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LocationModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocationModel](
	[LocationId] [int] IDENTITY(1000,1) NOT NULL,
	[LocationName] [nvarchar](2000) NULL,
	[Url] [nvarchar](2000) NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_LocationModel] PRIMARY KEY CLUSTERED 
(
	[LocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LocationOfProductModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocationOfProductModel](
	[LocationOfProductId] [int] IDENTITY(1,1) NOT NULL,
	[LocationOfProductName] [nvarchar](200) NULL,
	[Detail] [ntext] NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_LocationOfProductModel] PRIMARY KEY CLUSTERED 
(
	[LocationOfProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ManualDiscountTypeModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManualDiscountTypeModel](
	[ManualDiscountType] [nvarchar](50) NOT NULL,
	[manualDiscountTypeName] [nvarchar](50) NULL,
 CONSTRAINT [PK_ManualDiscountTypeModel] PRIMARY KEY CLUSTERED 
(
	[ManualDiscountType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Master_ChicCut_HairTypeModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Master_ChicCut_HairTypeModel](
	[HairTypeId] [int] IDENTITY(1000,1) NOT NULL,
	[HairTypeName] [nvarchar](100) NULL,
	[OrderIndex] [int] NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_Master_ChicCut_HairTypeModel] PRIMARY KEY CLUSTERED 
(
	[HairTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Master_ChicCut_QuantificationDetailModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Master_ChicCut_QuantificationDetailModel](
	[QuantificationDetailId] [int] IDENTITY(1,1) NOT NULL,
	[QuantificationMasterId] [int] NULL,
	[ProductId] [int] NULL,
	[Qty] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Master_ChicCut_QuantificationDetailModel] PRIMARY KEY CLUSTERED 
(
	[QuantificationDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Master_ChicCut_QuantificationMasterModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Master_ChicCut_QuantificationMasterModel](
	[QuantificationMasterId] [int] IDENTITY(1,1) NOT NULL,
	[ServiceId] [int] NOT NULL,
	[QuantificationName] [nvarchar](100) NOT NULL,
	[Detail] [nvarchar](500) NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_Master_ChicCut_QuantificationMasterModel] PRIMARY KEY CLUSTERED 
(
	[QuantificationMasterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Master_ChicCut_ServiceCategoryModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Master_ChicCut_ServiceCategoryModel](
	[ServiceCategoryId] [int] IDENTITY(1,1) NOT NULL,
	[ServiceName] [nvarchar](500) NULL,
	[OrderBy] [int] NULL,
	[Actived] [bit] NOT NULL,
	[Type] [int] NULL,
 CONSTRAINT [PK_Master_ChicCut_ServiceCategoryModel] PRIMARY KEY CLUSTERED 
(
	[ServiceCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Master_ChicCut_ServiceModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Master_ChicCut_ServiceModel](
	[ServiceId] [int] IDENTITY(1001,1) NOT NULL,
	[ServiceCategoryId] [int] NULL,
	[ServiceName] [nvarchar](500) NULL,
	[Gender] [bit] NULL,
	[HairTypeId] [int] NULL,
	[Price] [decimal](18, 0) NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_Master_ChicCut_ServiceModel] PRIMARY KEY CLUSTERED 
(
	[ServiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MenuLanguageModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuLanguageModel](
	[MenuId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[MenuName] [nvarchar](100) NULL,
 CONSTRAINT [PK__MenuLanguage__PRIMARYKey] PRIMARY KEY CLUSTERED 
(
	[MenuId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MenuModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuModel](
	[MenuId] [int] IDENTITY(1,1) NOT NULL,
	[MenuName] [nvarchar](200) NULL,
	[OrderBy] [int] NULL,
	[Icon] [nvarchar](1000) NULL,
 CONSTRAINT [PK_MenuModel] PRIMARY KEY CLUSTERED 
(
	[MenuId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MessageModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MessageModel](
	[MessageId] [int] IDENTITY(1,1) NOT NULL,
	[Message] [nvarchar](4000) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[Viewed] [bit] NOT NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_MessageModel] PRIMARY KEY CLUSTERED 
(
	[MessageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NotificationModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotificationModel](
	[NotificationId] [int] IDENTITY(1,1) NOT NULL,
	[Note] [nvarchar](max) NULL,
	[AccountId] [int] NULL,
	[CreateDate] [datetime] NULL,
	[Actived] [bit] NOT NULL,
	[NotifiType] [nvarchar](500) NULL,
	[EffectDate] [date] NULL,
 CONSTRAINT [PK_NoteValidation] PRIMARY KEY CLUSTERED 
(
	[NotificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderDetailModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetailModel](
	[OrderDetailId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NULL,
	[ProductId] [int] NULL,
	[Quantity] [decimal](18, 2) NULL,
	[Price] [decimal](18, 2) NULL,
	[DiscountTypeId] [int] NULL,
	[Discount] [decimal](18, 2) NULL,
	[UnitDiscount] [decimal](18, 2) NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[Note] [nvarchar](500) NULL,
	[COGS] [decimal](18, 2) NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderMasterModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderMasterModel](
	[OrderId] [int] IDENTITY(1000,1) NOT NULL,
	[OrderCode] [nvarchar](50) NULL,
	[WarehouseId] [int] NULL,
	[BillDiscountTypeId] [int] NULL,
	[BillDiscount] [decimal](18, 2) NULL,
	[BillVAT] [int] NULL,
	[SaleName] [nvarchar](200) NULL,
	[DebtDueDate] [datetime] NULL,
	[PaymentMethodId] [int] NULL,
	[Paid] [decimal](18, 2) NULL,
	[MoneyTransfer] [decimal](18, 2) NULL,
	[CompanyName] [nvarchar](200) NULL,
	[TaxBillCode] [nvarchar](200) NULL,
	[ContractNumber] [nvarchar](200) NULL,
	[TaxBillDate] [datetime] NULL,
	[CustomerId] [int] NOT NULL,
	[FullName] [nvarchar](200) NULL,
	[IdentityCard] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[Gender] [bit] NULL,
	[ProvinceId] [int] NULL,
	[DistrictId] [int] NULL,
	[Address] [nvarchar](1000) NULL,
	[Email] [nvarchar](200) NULL,
	[Note] [ntext] NULL,
	[OrderStatusId] [int] NULL,
	[TotalPrice] [decimal](18, 2) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedAccount] [nvarchar](50) NULL,
	[CreatedEmployeeId] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
	[LastModifiedAccount] [nvarchar](50) NULL,
	[LastModifiedEmployeeId] [int] NULL,
	[DeletedDate] [datetime] NULL,
	[DeletedAccount] [nvarchar](50) NULL,
	[DeletedEmployeeId] [int] NULL,
	[Actived] [bit] NOT NULL,
	[TotalQty] [decimal](18, 2) NULL,
	[StoreId] [int] NULL,
	[SaleId] [int] NULL,
	[CustomerLevelId] [int] NULL,
	[RemainingAmount] [decimal](18, 2) NULL,
	[RemainingAmountAccrued] [decimal](18, 2) NULL,
	[SumCOGSOfOrderDetail] [decimal](18, 2) NULL,
	[SumPriceOfOrderDetail] [decimal](18, 2) NULL,
	[TotalBillDiscount] [decimal](18, 2) NULL,
	[TotalVAT] [decimal](18, 2) NULL,
 CONSTRAINT [PK_OrderMasterModel] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderReturnDetailModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderReturnDetailModel](
	[OrderReturnDetailId] [int] IDENTITY(1,1) NOT NULL,
	[OrderReturnId] [int] NULL,
	[ProductId] [int] NULL,
	[SellQuantity] [decimal](18, 2) NULL,
	[ReturnQuantity] [decimal](18, 2) NULL,
	[Price] [decimal](18, 2) NULL,
	[ReturnedQuantity] [decimal](18, 2) NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[Note] [nvarchar](500) NULL,
	[ReturnReason] [nvarchar](500) NULL,
	[COGS] [decimal](18, 2) NULL,
 CONSTRAINT [PK_OrderReturnDetailModel] PRIMARY KEY CLUSTERED 
(
	[OrderReturnDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderReturnModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderReturnModel](
	[OrderReturnMasterId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NULL,
	[StoreId] [int] NULL,
	[WarehouseId] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedAccount] [nvarchar](50) NULL,
	[CreatedEmployeeId] [int] NULL,
	[OrderReturnMasterCode] [nvarchar](50) NULL,
	[BillDiscountTypeId] [int] NULL,
	[DeletedDate] [datetime] NULL,
	[DeletedAccount] [nvarchar](50) NULL,
	[DeletedEmployeeId] [int] NULL,
	[Actived] [bit] NOT NULL,
	[BillDiscount] [decimal](18, 2) NULL,
	[BillVAT] [int] NULL,
	[Paid] [decimal](18, 2) NULL,
	[PaymentMethodId] [int] NULL,
	[TotalPrice] [decimal](18, 2) NULL,
	[TotalQty] [decimal](18, 2) NULL,
	[RemainingAmount] [decimal](18, 2) NULL,
	[Note] [nvarchar](500) NULL,
	[MoneyTransfer] [decimal](18, 2) NULL,
	[SumCOGSOfOrderDetail] [decimal](18, 2) NULL,
	[SumPriceOfOrderDetail] [decimal](18, 2) NULL,
	[TotalBillDiscount] [decimal](18, 2) NULL,
	[TotalVAT] [decimal](18, 2) NULL,
	[RemainingAmountAccrued] [decimal](18, 2) NULL,
 CONSTRAINT [PK_OrderReturnModel] PRIMARY KEY CLUSTERED 
(
	[OrderReturnMasterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderStatusModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatusModel](
	[OrderStatusId] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [nvarchar](50) NULL,
	[Description] [nvarchar](2000) NULL,
	[StatusNameForSMS] [nvarchar](50) NULL,
 CONSTRAINT [PK__OrderSta__BC674CA10EC32C7A] PRIMARY KEY CLUSTERED 
(
	[OrderStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OriginOfProductModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OriginOfProductModel](
	[OriginOfProductId] [int] IDENTITY(1,1) NOT NULL,
	[OriginOfProductName] [nvarchar](200) NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_OriginOfProductModel] PRIMARY KEY CLUSTERED 
(
	[OriginOfProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PageLanguageModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PageLanguageModel](
	[PageId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[PageName] [nvarchar](50) NULL,
 CONSTRAINT [PK__PageLanguage__PRIMARYKey] PRIMARY KEY CLUSTERED 
(
	[PageId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PageModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PageModel](
	[PageId] [int] IDENTITY(1,1) NOT NULL,
	[PageName] [nvarchar](100) NULL,
	[PageUrl] [nvarchar](300) NULL,
	[MenuId] [int] NULL,
	[OrderBy] [int] NULL,
	[Icon] [nvarchar](100) NULL,
	[Visiable] [bit] NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_PageModel] PRIMARY KEY CLUSTERED 
(
	[PageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PaymentMethodModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentMethodModel](
	[PaymentMethodId] [int] IDENTITY(5,1) NOT NULL,
	[PaymentMethodName] [nvarchar](50) NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_PaymentMethodModel] PRIMARY KEY CLUSTERED 
(
	[PaymentMethodId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PlanDetailModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlanDetailModel](
	[PlanDetailId] [int] IDENTITY(1,1) NOT NULL,
	[PlanMasterId] [int] NULL,
	[TimeFrame] [time](7) NULL,
	[AmountOfCus] [int] NULL,
 CONSTRAINT [PK_PlanDetailModel] PRIMARY KEY CLUSTERED 
(
	[PlanDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PlanModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlanModel](
	[PlanMasterId] [int] IDENTITY(1,1) NOT NULL,
	[DayOfWeek] [int] NULL,
	[FromTime] [time](7) NULL,
	[ToTime] [time](7) NULL,
 CONSTRAINT [PK_PlanModel] PRIMARY KEY CLUSTERED 
(
	[PlanMasterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PolicyModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PolicyModel](
	[PolicyId] [int] IDENTITY(1,1) NOT NULL,
	[PolicyName] [nvarchar](500) NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_PolicyModel] PRIMARY KEY CLUSTERED 
(
	[PolicyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PreImportDetailModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PreImportDetailModel](
	[PreImportDetailId] [int] IDENTITY(1,1) NOT NULL,
	[PreImportMasterId] [int] NULL,
	[ProductId] [int] NULL,
	[Qty] [decimal](18, 2) NULL,
	[ConfirmQty] [decimal](18, 2) NULL,
	[Price] [decimal](18, 2) NULL,
	[UnitShippingWeight] [decimal](18, 2) NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[Note] [nvarchar](100) NULL,
	[ShippingFee] [decimal](18, 2) NULL,
	[UnitCOGS] [decimal](18, 2) NULL,
 CONSTRAINT [PK_PreImportDetailModel] PRIMARY KEY CLUSTERED 
(
	[PreImportDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PreImportMasterModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PreImportMasterModel](
	[PreImportMasterId] [int] IDENTITY(1000,1) NOT NULL,
	[PreImportMasterCode] [nvarchar](50) NULL,
	[StoreId] [int] NULL,
	[WarehouseId] [int] NULL,
	[InventoryTypeId] [int] NULL,
	[SupplierId] [int] NULL,
	[SalemanName] [nvarchar](200) NULL,
	[SenderName] [nvarchar](200) NULL,
	[ReceiverName] [nvarchar](200) NULL,
	[Note] [ntext] NULL,
	[VATType] [nvarchar](50) NULL,
	[VATValue] [decimal](18, 2) NULL,
	[TAXBillCode] [nvarchar](50) NULL,
	[TAXBillDate] [datetime] NULL,
	[ManualDiscountType] [nvarchar](50) NULL,
	[ManualDiscount] [decimal](18, 2) NULL,
	[DebtDueDate] [datetime] NULL,
	[CurrencyId] [int] NULL,
	[ExchangeRate] [decimal](18, 2) NULL,
	[TotalPrice] [decimal](18, 2) NULL,
	[TotalQty] [decimal](18, 2) NULL,
	[TotalShippingWeight] [decimal](18, 2) NULL,
	[Paid] [decimal](18, 2) NULL,
	[MoneyTransfer] [decimal](18, 2) NULL,
	[RemainingAmount] [decimal](18, 2) NULL,
	[RemainingAmountAccrued] [decimal](18, 2) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedAccount] [nvarchar](50) NULL,
	[CreatedEmployeeId] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
	[LastModifiedAccount] [nvarchar](50) NULL,
	[LastModifiedEmployeeId] [int] NULL,
	[DeletedDate] [datetime] NULL,
	[DeletedAccount] [nvarchar](50) NULL,
	[DeletedEmployeeId] [int] NULL,
	[Actived] [bit] NOT NULL,
	[StatusCode] [nvarchar](20) NULL,
	[ImportMasterId] [int] NULL,
	[SumCOGSOfOrderDetail] [decimal](18, 2) NULL,
	[SumPriceOfOrderDetail] [decimal](18, 2) NULL,
	[TotalBillDiscount] [decimal](18, 2) NULL,
	[TotalVAT] [decimal](18, 2) NULL,
 CONSTRAINT [PK_PreImportMasterModel] PRIMARY KEY CLUSTERED 
(
	[PreImportMasterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PreOrderDetailModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PreOrderDetailModel](
	[PreOrderDetailId] [int] IDENTITY(1,1) NOT NULL,
	[PreOrderId] [int] NULL,
	[ProductId] [int] NULL,
	[Quantity] [decimal](18, 2) NULL,
	[Price] [decimal](18, 2) NULL,
	[DiscountTypeId] [int] NULL,
	[Discount] [decimal](18, 2) NULL,
	[UnitDiscount] [decimal](18, 2) NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[Note] [nvarchar](500) NULL,
	[COGS] [decimal](18, 2) NULL,
 CONSTRAINT [PK_PreOrderDetail] PRIMARY KEY CLUSTERED 
(
	[PreOrderDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PreOrderMasterModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PreOrderMasterModel](
	[PreOrderId] [int] IDENTITY(1000,1) NOT NULL,
	[PreOrderCode] [nvarchar](50) NULL,
	[WarehouseId] [int] NULL,
	[BillDiscountTypeId] [int] NULL,
	[BillDiscount] [decimal](18, 2) NULL,
	[BillVAT] [int] NULL,
	[SaleName] [nvarchar](200) NULL,
	[DebtDueDate] [datetime] NULL,
	[PaymentMethodId] [int] NULL,
	[Paid] [decimal](18, 2) NULL,
	[MoneyTransfer] [decimal](18, 2) NULL,
	[CompanyName] [nvarchar](200) NULL,
	[TaxBillCode] [nvarchar](200) NULL,
	[ContractNumber] [nvarchar](200) NULL,
	[TaxBillDate] [datetime] NULL,
	[CustomerId] [int] NOT NULL,
	[FullName] [nvarchar](200) NULL,
	[IdentityCard] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[Gender] [bit] NULL,
	[ProvinceId] [int] NULL,
	[DistrictId] [int] NULL,
	[Address] [nvarchar](1000) NULL,
	[Email] [nvarchar](200) NULL,
	[Note] [ntext] NULL,
	[OrderStatusId] [int] NULL,
	[TotalPrice] [decimal](18, 2) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedAccount] [nvarchar](50) NULL,
	[CreatedEmployeeId] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
	[LastModifiedAccount] [nvarchar](50) NULL,
	[LastModifiedEmployeeId] [int] NULL,
	[DeletedDate] [datetime] NULL,
	[DeletedAccount] [nvarchar](50) NULL,
	[DeletedEmployeeId] [int] NULL,
	[Actived] [bit] NOT NULL,
	[TotalQty] [decimal](18, 2) NULL,
	[StoreId] [int] NULL,
	[SaleId] [int] NULL,
	[CustomerLevelId] [int] NULL,
	[RemainingAmount] [decimal](18, 2) NULL,
	[RemainingAmountAccrued] [decimal](18, 2) NULL,
	[StatusCode] [nvarchar](20) NULL,
	[OrderId] [int] NULL,
	[SumCOGSOfOrderDetail] [decimal](18, 2) NULL,
	[SumPriceOfOrderDetail] [decimal](18, 2) NULL,
	[TotalDiscount] [decimal](18, 2) NULL,
	[TotalVAT] [decimal](18, 2) NULL,
 CONSTRAINT [PK_PreOrderMasterModel] PRIMARY KEY CLUSTERED 
(
	[PreOrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductAlertModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductAlertModel](
	[ProductId] [int] NOT NULL,
	[WarehouseId] [int] NOT NULL,
	[RolesId] [int] NOT NULL,
	[QtyAlert] [decimal](18, 2) NULL,
 CONSTRAINT [PK_ProductAlertModel] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC,
	[WarehouseId] ASC,
	[RolesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductImageModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductImageModel](
	[ProductImageId] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NULL,
	[ImageUrl] [nvarchar](500) NULL,
 CONSTRAINT [PK_ProductImageModel] PRIMARY KEY CLUSTERED 
(
	[ProductImageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductModel](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[ProductCode] [nvarchar](50) NULL,
	[ProductName] [nvarchar](500) NOT NULL,
	[SEOProductName] [nvarchar](500) NULL,
	[CategoryId] [int] NULL,
	[OriginOfProductId] [int] NULL,
	[PolicyInStockId] [int] NULL,
	[PolicyOutOfStockId] [int] NULL,
	[LocationOfProductId] [int] NULL,
	[ProductStatusId] [int] NULL,
	[Keywords] [nvarchar](100) NULL,
	[Barcode] [nvarchar](200) NULL,
	[Specifications] [nvarchar](500) NULL,
	[ShippingWeight] [decimal](18, 2) NULL,
	[UnitId] [int] NULL,
	[ImportPrice] [decimal](18, 2) NULL,
	[CurrencyId] [int] NULL,
	[ExchangeRate] [decimal](18, 2) NULL,
	[ShippingFee] [decimal](18, 2) NULL,
	[COGS] [decimal](18, 2) NULL,
	[Detail] [ntext] NULL,
	[ImageUrl] [nvarchar](500) NULL,
	[isHot] [bit] NULL,
	[OrderBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedAccount] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
	[LastModifiedAccount] [nvarchar](50) NULL,
	[IsMaterial] [bit] NOT NULL,
	[IsProduct] [bit] NOT NULL,
	[Actived] [bit] NOT NULL,
	[StoreId] [int] NULL,
	[ProductTypeId] [int] NULL,
	[ProductStoreCode] [nvarchar](50) NULL,
	[BeginWarehouseId] [int] NULL,
	[BeginInventoryQty] [decimal](18, 2) NULL,
	[ImportDate] [datetime] NULL,
	[ShortProductName] [nvarchar](50) NULL,
	[Note] [nvarchar](4000) NULL,
	[FileId] [int] NULL,
	[isShowOnWebsite] [bit] NULL,
	[isParentProduct] [bit] NULL,
	[ParentProductId] [int] NULL,
 CONSTRAINT [PK_ProductModel] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductPriceModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductPriceModel](
	[ProductPriceID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerLevelId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Price] [decimal](18, 2) NULL,
 CONSTRAINT [PK_ProductPriceModel] PRIMARY KEY CLUSTERED 
(
	[ProductPriceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductStatusModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductStatusModel](
	[ProductStatusId] [int] IDENTITY(1,1) NOT NULL,
	[ProductStatusName] [nvarchar](50) NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_ProductStatusModel] PRIMARY KEY CLUSTERED 
(
	[ProductStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductTypeModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductTypeModel](
	[ProductTypeId] [int] IDENTITY(1,1) NOT NULL,
	[ProductTypeCode] [nvarchar](50) NULL,
	[ProductTypeName] [nvarchar](500) NULL,
	[OrderBy] [int] NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_ProductTypeModel] PRIMARY KEY CLUSTERED 
(
	[ProductTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductUpdateDetailModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductUpdateDetailModel](
	[ProductUpdateDetailId] [int] IDENTITY(1000,1) NOT NULL,
	[ProductUpdateMasterId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[ProductStoreCode] [nvarchar](50) NOT NULL,
	[ProductCode] [nvarchar](50) NULL,
	[ProductName] [nvarchar](500) NOT NULL,
	[ImportPrice] [decimal](18, 2) NULL,
	[ExchangeRate] [decimal](18, 2) NULL,
	[ShippingFee] [decimal](18, 2) NULL,
	[Price1] [decimal](18, 2) NULL,
	[Price2] [decimal](18, 2) NULL,
	[Price3] [decimal](18, 2) NULL,
	[Price4] [decimal](18, 2) NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_ProductUpdateDetailModel] PRIMARY KEY CLUSTERED 
(
	[ProductUpdateDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductUpdateMasterModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductUpdateMasterModel](
	[ProductUpdateMasterId] [int] IDENTITY(1000,1) NOT NULL,
	[ProductUpdateMasterCode] [nvarchar](50) NULL,
	[TotalQty] [decimal](18, 2) NULL,
	[CreateAccount] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[CreatedEmployeeId] [int] NULL,
	[DeletedDate] [datetime] NULL,
	[DeletedAccount] [nvarchar](50) NULL,
	[DeletedEmployeeId] [int] NULL,
	[Note] [nvarchar](max) NULL,
	[CreatedIEOther] [bit] NOT NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_ProductUpdateMasterModel] PRIMARY KEY CLUSTERED 
(
	[ProductUpdateMasterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProvinceModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProvinceModel](
	[ProvinceId] [int] IDENTITY(1,1) NOT NULL,
	[ProvinceName] [nvarchar](200) NULL,
	[Actived] [bit] NULL,
 CONSTRAINT [PK_ProvinceModel] PRIMARY KEY CLUSTERED 
(
	[ProvinceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RegistryModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegistryModel](
	[RegistryId] [int] IDENTITY(10000,1) NOT NULL,
	[CourseId] [int] NOT NULL,
	[FullName] [nvarchar](4000) NULL,
	[Email] [nvarchar](200) NULL,
	[Gender] [bit] NULL,
	[BirthDay] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[Note] [ntext] NULL,
	[CalendarId] [int] NULL,
	[EventId] [int] NULL,
	[Price] [decimal](18, 0) NULL,
	[DiscountId] [int] NULL,
	[Actived] [bit] NULL,
 CONSTRAINT [PK__Registry__006876721209AD79] PRIMARY KEY CLUSTERED 
(
	[RegistryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReturnDetailModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnDetailModel](
	[ReturnDetailId] [int] IDENTITY(1,1) NOT NULL,
	[ReturnMasterId] [int] NULL,
	[ProductId] [int] NULL,
	[ImportQty] [decimal](18, 2) NULL,
	[ReturnedQty] [decimal](18, 2) NULL,
	[InventoryQty] [decimal](18, 2) NULL,
	[ReturnQty] [decimal](18, 2) NULL,
	[Price] [decimal](18, 2) NULL,
	[UnitShippingWeight] [decimal](18, 2) NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[Note] [nvarchar](50) NULL,
	[ShippingFee] [decimal](18, 2) NULL,
	[UnitCOGS] [decimal](18, 2) NULL,
 CONSTRAINT [PK_ReturnDetailModel] PRIMARY KEY CLUSTERED 
(
	[ReturnDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReturnMasterModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnMasterModel](
	[ReturnMasterId] [int] IDENTITY(1000,1) NOT NULL,
	[ReturnMasterCode] [nvarchar](50) NULL,
	[ImportMasterId] [int] NOT NULL,
	[StoreId] [int] NULL,
	[WarehouseId] [int] NULL,
	[InventoryTypeId] [int] NULL,
	[SupplierId] [int] NULL,
	[SalemanName] [nvarchar](200) NULL,
	[SenderName] [nvarchar](200) NULL,
	[ReceiverName] [nvarchar](200) NULL,
	[Note] [ntext] NULL,
	[VATType] [nvarchar](50) NULL,
	[VATValue] [decimal](18, 2) NULL,
	[TAXBillCode] [nvarchar](50) NULL,
	[TAXBillDate] [datetime] NULL,
	[ManualDiscountType] [nvarchar](50) NULL,
	[ManualDiscount] [decimal](18, 2) NULL,
	[DebtDueDate] [datetime] NULL,
	[CurrencyId] [int] NULL,
	[ExchangeRate] [decimal](18, 2) NULL,
	[TotalPrice] [decimal](18, 2) NULL,
	[TotalQty] [decimal](18, 2) NULL,
	[TotalShippingWeight] [decimal](18, 2) NULL,
	[Paid] [decimal](18, 2) NULL,
	[MoneyTransfer] [decimal](18, 2) NULL,
	[RemainingAmount] [decimal](18, 2) NULL,
	[RemainingAmountAccrued] [decimal](18, 2) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedAccount] [nvarchar](50) NULL,
	[CreatedEmployeeId] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
	[LastModifiedAccount] [nvarchar](50) NULL,
	[LastModifiedEmployeeId] [int] NULL,
	[DeletedDate] [datetime] NULL,
	[DeletedAccount] [nvarchar](50) NULL,
	[DeletedEmployeeId] [int] NULL,
	[Actived] [bit] NOT NULL,
	[SumCOGSOfOrderDetail] [decimal](18, 2) NULL,
	[SumPriceOfOrderDetail] [decimal](18, 2) NULL,
	[TotalBillDiscount] [decimal](18, 2) NULL,
	[TotalVAT] [decimal](18, 2) NULL,
 CONSTRAINT [PK_ReturnMasterModel] PRIMARY KEY CLUSTERED 
(
	[ReturnMasterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RolesLanguageModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RolesLanguageModel](
	[RolesId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[RolesName] [nvarchar](50) NULL,
 CONSTRAINT [PK__RolesLanguage__PRIMARYKey] PRIMARY KEY CLUSTERED 
(
	[RolesId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RolesModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RolesModel](
	[RolesId] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[RolesName] [nvarchar](50) NOT NULL,
	[OrderBy] [int] NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_RolesModel] PRIMARY KEY CLUSTERED 
(
	[RolesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SalaryDetailModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalaryDetailModel](
	[SalaryDetailId] [int] IDENTITY(1,1) NOT NULL,
	[SalaryMasterId] [int] NULL,
	[EmployeeId] [int] NULL,
	[Tip] [decimal](18, 2) NULL,
	[Commission] [decimal](18, 2) NULL,
	[Salary] [decimal](18, 2) NULL,
 CONSTRAINT [PK_SalaryDetailModel] PRIMARY KEY CLUSTERED 
(
	[SalaryDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SalaryMasterModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalaryMasterModel](
	[SalaryMasterId] [int] IDENTITY(1,1) NOT NULL,
	[FromDate] [datetime] NULL,
	[ToDate] [datetime] NULL,
	[Note] [ntext] NULL,
	[PayDate] [datetime] NULL,
 CONSTRAINT [PK_SalaryMasterModel] PRIMARY KEY CLUSTERED 
(
	[SalaryMasterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StatusModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusModel](
	[StatusId] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [nvarchar](50) NULL,
	[Description] [nvarchar](2000) NULL,
	[Detail] [nvarchar](4000) NULL,
	[StatusNameForSMS] [nvarchar](50) NULL,
 CONSTRAINT [PK_StatusModel] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StoreModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StoreModel](
	[StoreId] [int] IDENTITY(1000,1) NOT NULL,
	[StoreCode] [nvarchar](50) NULL,
	[StoreName] [nvarchar](500) NULL,
	[Phone] [nvarchar](50) NULL,
	[ProvinceId] [int] NULL,
	[DistrictId] [int] NULL,
	[Address] [nvarchar](1000) NULL,
	[Actived] [bit] NOT NULL,
	[ShortName] [nvarchar](500) NULL,
 CONSTRAINT [PK_StoreModel] PRIMARY KEY CLUSTERED 
(
	[StoreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SupplierModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SupplierModel](
	[SupplierId] [int] IDENTITY(10000,1) NOT NULL,
	[SupplierCode] [nvarchar](50) NULL,
	[SupplierName] [nvarchar](300) NULL,
	[Phone] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[TaxCode] [nvarchar](50) NULL,
	[hasInvoice] [bit] NOT NULL,
	[isPersonal] [bit] NOT NULL,
	[IdentityCard] [nvarchar](50) NULL,
	[ProvinceId] [int] NULL,
	[DistrictId] [int] NULL,
	[Address] [nvarchar](500) NULL,
	[BankName] [nvarchar](500) NULL,
	[BankBranch] [nvarchar](500) NULL,
	[BankAccountNumber] [nvarchar](50) NULL,
	[BankOwner] [nvarchar](50) NULL,
	[Note] [ntext] NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_SupplierModel] PRIMARY KEY CLUSTERED 
(
	[SupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SYS_tblFile]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SYS_tblFile](
	[FileId] [int] IDENTITY(1,1) NOT NULL,
	[FileTitle] [nvarchar](100) NOT NULL,
	[FileName] [nvarchar](100) NOT NULL,
	[Extension] [nvarchar](100) NOT NULL,
	[ContentType] [nvarchar](200) NOT NULL,
	[FolderId] [int] NOT NULL,
	[FileContent] [varbinary](max) NULL,
	[FileDescription] [nvarchar](max) NULL,
	[Size] [int] NULL,
	[Width] [int] NULL,
	[Height] [int] NULL,
	[CreatedByUserId] [int] NULL,
	[CreatedOnDate] [datetime] NULL,
	[LastModifiedByUserId] [int] NULL,
	[LastModifiedOnDate] [datetime] NULL,
 CONSTRAINT [PK_Files] PRIMARY KEY CLUSTERED 
(
	[FileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SYS_tblFolder]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SYS_tblFolder](
	[FolderId] [int] IDENTITY(1,1) NOT NULL,
	[FolderKey] [varchar](50) NULL,
	[FolderPath] [varchar](300) NOT NULL,
	[CreatedByUserId] [int] NULL,
	[CreatedOnDate] [datetime] NULL,
	[LastModifiedByUserId] [int] NULL,
	[LastModifiedOnDate] [datetime] NULL,
 CONSTRAINT [PK__Folders__ACD7107F027D5126] PRIMARY KEY CLUSTERED 
(
	[FolderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TrainerModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrainerModel](
	[TrainerId] [int] IDENTITY(1000,1) NOT NULL,
	[TrainerName] [nvarchar](2000) NULL,
	[Url] [nvarchar](2000) NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_TrainerModel] PRIMARY KEY CLUSTERED 
(
	[TrainerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UnitModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnitModel](
	[UnitId] [int] IDENTITY(1,1) NOT NULL,
	[UnitName] [nvarchar](100) NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_UnitModel] PRIMARY KEY CLUSTERED 
(
	[UnitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VATTypeModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VATTypeModel](
	[VATType] [nvarchar](50) NOT NULL,
	[VATTypeName] [nvarchar](50) NULL,
 CONSTRAINT [PK_VATTypeModel] PRIMARY KEY CLUSTERED 
(
	[VATType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WarehouseInventoryDetailModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WarehouseInventoryDetailModel](
	[WarehouseInventoryDetailId] [int] IDENTITY(1000,1) NOT NULL,
	[WarehouseInventoryMasterId] [int] NULL,
	[ProductId] [int] NULL,
	[Specifications] [nvarchar](500) NULL,
	[Inventory] [decimal](21, 5) NULL,
	[ActualInventory] [decimal](21, 5) NULL,
	[AmountDifference] [decimal](21, 5) NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_WarehouseInventoryDetailModel] PRIMARY KEY CLUSTERED 
(
	[WarehouseInventoryDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WarehouseInventoryMasterModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WarehouseInventoryMasterModel](
	[WarehouseInventoryMasterId] [int] IDENTITY(1000,1) NOT NULL,
	[WarehouseInventoryMasterCode] [nvarchar](50) NULL,
	[WarehouseId] [int] NULL,
	[TotalQty] [decimal](18, 2) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedAccount] [nvarchar](50) NULL,
	[CreatedEmployeeId] [int] NULL,
	[DeletedDate] [datetime] NULL,
	[DeletedAccount] [nvarchar](50) NULL,
	[DeletedEmployeeId] [int] NULL,
	[Note] [nvarchar](500) NULL,
	[CreatedIEOther] [bit] NOT NULL,
	[Actived] [bit] NOT NULL,
 CONSTRAINT [PK_WarehouseInventoryMasterModel] PRIMARY KEY CLUSTERED 
(
	[WarehouseInventoryMasterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WarehouseModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WarehouseModel](
	[WarehouseId] [int] IDENTITY(1,1) NOT NULL,
	[WarehouseName] [nvarchar](200) NULL,
	[Address] [nvarchar](2000) NULL,
	[ProvinceId] [int] NULL,
	[DistrictId] [int] NULL,
	[Actived] [bit] NOT NULL,
	[StoreId] [int] NULL,
	[WarehouseCode] [nvarchar](50) NULL,
 CONSTRAINT [PK_WarehouseModel] PRIMARY KEY CLUSTERED 
(
	[WarehouseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Website_AdsModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Website_AdsModel](
	[AdsId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](200) NULL,
	[LocationId] [int] NULL,
	[Href] [nvarchar](300) NULL,
	[ImageUrl] [nvarchar](300) NULL,
	[Width] [int] NULL,
	[Height] [int] NULL,
	[Content] [nvarchar](4000) NULL,
 CONSTRAINT [PK_Website_AdsModel] PRIMARY KEY CLUSTERED 
(
	[AdsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Website_Counter]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Website_Counter](
	[ID] [int] IDENTITY(10000,1) NOT NULL,
	[Views] [bigint] NULL,
	[Date] [date] NULL,
 CONSTRAINT [PK_Counter] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Website_LocationModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Website_LocationModel](
	[LocationId] [int] IDENTITY(1,1) NOT NULL,
	[LocationName] [nvarchar](100) NULL,
	[Description] [nvarchar](300) NULL,
	[LocationWidth] [int] NULL,
	[LocationHeight] [int] NULL,
	[Actived] [bit] NULL,
 CONSTRAINT [PK_Website_LocationModel] PRIMARY KEY CLUSTERED 
(
	[LocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Website_NewsModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Website_NewsModel](
	[NewsID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NULL,
	[Title] [nvarchar](200) NULL,
	[Description] [nvarchar](4000) NULL,
	[Details] [ntext] NULL,
	[isHot] [bit] NULL,
	[OrderIndex] [int] NULL,
	[ImageUrl] [nvarchar](300) NULL,
	[FileId] [int] NULL,
	[Visible] [bit] NULL,
	[UserId] [int] NULL,
	[SEOTitle] [nvarchar](4000) NULL,
	[PostDate] [datetime] NULL,
	[Views] [int] NULL,
	[TitleEn] [nvarchar](200) NULL,
	[DescriptionEn] [nvarchar](4000) NULL,
	[DetailsEn] [ntext] NULL,
	[Actived] [bit] NULL,
 CONSTRAINT [PK__Website_NewsModel] PRIMARY KEY CLUSTERED 
(
	[NewsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Website_SettingModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Website_SettingModel](
	[SettingName] [char](10) NOT NULL,
	[Details] [nvarchar](max) NULL,
 CONSTRAINT [PK__Website_Setting] PRIMARY KEY CLUSTERED 
(
	[SettingName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[AccessModel]  WITH NOCHECK ADD  CONSTRAINT [FK_AccessModel_PageModel] FOREIGN KEY([PageId])
REFERENCES [dbo].[PageModel] ([PageId])
GO
ALTER TABLE [dbo].[AccessModel] CHECK CONSTRAINT [FK_AccessModel_PageModel]
GO
ALTER TABLE [dbo].[AccessModel]  WITH CHECK ADD  CONSTRAINT [FK_AccessModel_RolesModel] FOREIGN KEY([RolesId])
REFERENCES [dbo].[RolesModel] ([RolesId])
GO
ALTER TABLE [dbo].[AccessModel] CHECK CONSTRAINT [FK_AccessModel_RolesModel]
GO
ALTER TABLE [dbo].[AccountModel]  WITH CHECK ADD  CONSTRAINT [FK_AccountModel_CustomerModel] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[CustomerModel] ([CustomerId])
GO
ALTER TABLE [dbo].[AccountModel] CHECK CONSTRAINT [FK_AccountModel_CustomerModel]
GO
ALTER TABLE [dbo].[AccountModel]  WITH CHECK ADD  CONSTRAINT [FK_AccountModel_EmployeeModel] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[EmployeeModel] ([EmployeeId])
GO
ALTER TABLE [dbo].[AccountModel] CHECK CONSTRAINT [FK_AccountModel_EmployeeModel]
GO
ALTER TABLE [dbo].[AccountModel]  WITH CHECK ADD  CONSTRAINT [FK_AccountModel_RolesModel] FOREIGN KEY([RolesId])
REFERENCES [dbo].[RolesModel] ([RolesId])
GO
ALTER TABLE [dbo].[AccountModel] CHECK CONSTRAINT [FK_AccountModel_RolesModel]
GO
ALTER TABLE [dbo].[AM_AccountModel]  WITH CHECK ADD  CONSTRAINT [FK_AM_AccountModel_AM_AccountTypeModel] FOREIGN KEY([AMAccountTypeCode])
REFERENCES [dbo].[AM_AccountTypeModel] ([AMAccountTypeCode])
GO
ALTER TABLE [dbo].[AM_AccountModel] CHECK CONSTRAINT [FK_AM_AccountModel_AM_AccountTypeModel]
GO
ALTER TABLE [dbo].[AM_AccountModel]  WITH CHECK ADD  CONSTRAINT [FK_AM_AccountModel_StoreModel] FOREIGN KEY([StoreId])
REFERENCES [dbo].[StoreModel] ([StoreId])
GO
ALTER TABLE [dbo].[AM_AccountModel] CHECK CONSTRAINT [FK_AM_AccountModel_StoreModel]
GO
ALTER TABLE [dbo].[AM_TransactionModel]  WITH NOCHECK ADD  CONSTRAINT [FK_AM_TransactionModel_AM_AccountModel] FOREIGN KEY([AMAccountId])
REFERENCES [dbo].[AM_AccountModel] ([AMAccountId])
GO
ALTER TABLE [dbo].[AM_TransactionModel] CHECK CONSTRAINT [FK_AM_TransactionModel_AM_AccountModel]
GO
ALTER TABLE [dbo].[AM_TransactionModel]  WITH NOCHECK ADD  CONSTRAINT [FK_AM_TransactionModel_AM_ContactItemTypeModel] FOREIGN KEY([ContactItemTypeCode])
REFERENCES [dbo].[AM_ContactItemTypeModel] ([ContactItemTypeCode])
GO
ALTER TABLE [dbo].[AM_TransactionModel] CHECK CONSTRAINT [FK_AM_TransactionModel_AM_ContactItemTypeModel]
GO
ALTER TABLE [dbo].[AM_TransactionModel]  WITH NOCHECK ADD  CONSTRAINT [FK_AM_TransactionModel_AM_TransactionTypeModel] FOREIGN KEY([TransactionTypeCode])
REFERENCES [dbo].[AM_TransactionTypeModel] ([TransactionTypeCode])
GO
ALTER TABLE [dbo].[AM_TransactionModel] CHECK CONSTRAINT [FK_AM_TransactionModel_AM_TransactionTypeModel]
GO
ALTER TABLE [dbo].[AM_TransactionModel]  WITH NOCHECK ADD  CONSTRAINT [FK_AM_TransactionModel_StoreModel] FOREIGN KEY([StoreId])
REFERENCES [dbo].[StoreModel] ([StoreId])
GO
ALTER TABLE [dbo].[AM_TransactionModel] CHECK CONSTRAINT [FK_AM_TransactionModel_StoreModel]
GO
ALTER TABLE [dbo].[CalendarModel]  WITH CHECK ADD  CONSTRAINT [FK_CalendarModel_CourseModel] FOREIGN KEY([CourseId])
REFERENCES [dbo].[CourseModel] ([CourseId])
GO
ALTER TABLE [dbo].[CalendarModel] CHECK CONSTRAINT [FK_CalendarModel_CourseModel]
GO
ALTER TABLE [dbo].[CalendarModel]  WITH CHECK ADD  CONSTRAINT [FK_CalendarModel_LocationModel] FOREIGN KEY([LocationId])
REFERENCES [dbo].[LocationModel] ([LocationId])
GO
ALTER TABLE [dbo].[CalendarModel] CHECK CONSTRAINT [FK_CalendarModel_LocationModel]
GO
ALTER TABLE [dbo].[CourseModel]  WITH CHECK ADD  CONSTRAINT [FK_CourseModel_CategoryModel] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[CategoryModel] ([CategoryId])
GO
ALTER TABLE [dbo].[CourseModel] CHECK CONSTRAINT [FK_CourseModel_CategoryModel]
GO
ALTER TABLE [dbo].[CRM_EmailParameterModel]  WITH CHECK ADD  CONSTRAINT [FK_CRM_EmailParameterModel_CRM_EmailTemplateModel] FOREIGN KEY([EmailTemplateId])
REFERENCES [dbo].[CRM_EmailTemplateModel] ([EmailTemplateId])
GO
ALTER TABLE [dbo].[CRM_EmailParameterModel] CHECK CONSTRAINT [FK_CRM_EmailParameterModel_CRM_EmailTemplateModel]
GO
ALTER TABLE [dbo].[CRM_Remider_EmailParameter_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_CRM_Remider_EmailParameter_Mapping_CRM_EmailParameterModel] FOREIGN KEY([EmailParameterId])
REFERENCES [dbo].[CRM_EmailParameterModel] ([EmailParameterId])
GO
ALTER TABLE [dbo].[CRM_Remider_EmailParameter_Mapping] CHECK CONSTRAINT [FK_CRM_Remider_EmailParameter_Mapping_CRM_EmailParameterModel]
GO
ALTER TABLE [dbo].[CRM_Remider_EmailParameter_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_CRM_Remider_EmailParameter_Mapping_CRM_EmailTemplateModel] FOREIGN KEY([EmailTemplateId])
REFERENCES [dbo].[CRM_EmailTemplateModel] ([EmailTemplateId])
GO
ALTER TABLE [dbo].[CRM_Remider_EmailParameter_Mapping] CHECK CONSTRAINT [FK_CRM_Remider_EmailParameter_Mapping_CRM_EmailTemplateModel]
GO
ALTER TABLE [dbo].[CRM_Remider_EmailParameter_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_CRM_Remider_EmailParameter_Mapping_CRM_RemiderModel] FOREIGN KEY([RemiderId])
REFERENCES [dbo].[CRM_RemiderModel] ([RemiderId])
GO
ALTER TABLE [dbo].[CRM_Remider_EmailParameter_Mapping] CHECK CONSTRAINT [FK_CRM_Remider_EmailParameter_Mapping_CRM_RemiderModel]
GO
ALTER TABLE [dbo].[CRM_Remider_SMSParameter_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_CRM_Remider_SMSParameter_Mapping_CRM_RemiderModel] FOREIGN KEY([RemiderId])
REFERENCES [dbo].[CRM_RemiderModel] ([RemiderId])
GO
ALTER TABLE [dbo].[CRM_Remider_SMSParameter_Mapping] CHECK CONSTRAINT [FK_CRM_Remider_SMSParameter_Mapping_CRM_RemiderModel]
GO
ALTER TABLE [dbo].[CRM_Remider_SMSParameter_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_CRM_Remider_SMSParameter_Mapping_CRM_SMSParameterModel] FOREIGN KEY([SMSParameterId])
REFERENCES [dbo].[CRM_SMSParameterModel] ([SMSParameterId])
GO
ALTER TABLE [dbo].[CRM_Remider_SMSParameter_Mapping] CHECK CONSTRAINT [FK_CRM_Remider_SMSParameter_Mapping_CRM_SMSParameterModel]
GO
ALTER TABLE [dbo].[CRM_Remider_SMSParameter_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_CRM_Remider_SMSParameter_Mapping_CRM_SMSTemplateModel] FOREIGN KEY([SMSTemplateId])
REFERENCES [dbo].[CRM_SMSTemplateModel] ([SMSTemplateId])
GO
ALTER TABLE [dbo].[CRM_Remider_SMSParameter_Mapping] CHECK CONSTRAINT [FK_CRM_Remider_SMSParameter_Mapping_CRM_SMSTemplateModel]
GO
ALTER TABLE [dbo].[CRM_RemiderModel]  WITH CHECK ADD  CONSTRAINT [FK_CRM_RemiderModel_CRM_EmailTemplateModel] FOREIGN KEY([EmailTemplateId])
REFERENCES [dbo].[CRM_EmailTemplateModel] ([EmailTemplateId])
GO
ALTER TABLE [dbo].[CRM_RemiderModel] CHECK CONSTRAINT [FK_CRM_RemiderModel_CRM_EmailTemplateModel]
GO
ALTER TABLE [dbo].[CRM_RemiderModel]  WITH CHECK ADD  CONSTRAINT [FK_CRM_RemiderModel_CRM_ObjectModel] FOREIGN KEY([ObjectId])
REFERENCES [dbo].[CRM_ObjectModel] ([ObjectId])
GO
ALTER TABLE [dbo].[CRM_RemiderModel] CHECK CONSTRAINT [FK_CRM_RemiderModel_CRM_ObjectModel]
GO
ALTER TABLE [dbo].[CRM_RemiderModel]  WITH CHECK ADD  CONSTRAINT [FK_CRM_RemiderModel_CRM_PeriodModel] FOREIGN KEY([PeriodCode])
REFERENCES [dbo].[CRM_PeriodModel] ([PeriodCode])
GO
ALTER TABLE [dbo].[CRM_RemiderModel] CHECK CONSTRAINT [FK_CRM_RemiderModel_CRM_PeriodModel]
GO
ALTER TABLE [dbo].[CRM_RemiderModel]  WITH CHECK ADD  CONSTRAINT [FK_CRM_RemiderModel_CRM_SMSTemplateModel] FOREIGN KEY([SMSTemplateId])
REFERENCES [dbo].[CRM_SMSTemplateModel] ([SMSTemplateId])
GO
ALTER TABLE [dbo].[CRM_RemiderModel] CHECK CONSTRAINT [FK_CRM_RemiderModel_CRM_SMSTemplateModel]
GO
ALTER TABLE [dbo].[CRM_SMSParameterModel]  WITH CHECK ADD  CONSTRAINT [FK_CRM_SMSParameterModel_CRM_SMSTemplateModel] FOREIGN KEY([SMSTemplateId])
REFERENCES [dbo].[CRM_SMSTemplateModel] ([SMSTemplateId])
GO
ALTER TABLE [dbo].[CRM_SMSParameterModel] CHECK CONSTRAINT [FK_CRM_SMSParameterModel_CRM_SMSTemplateModel]
GO
ALTER TABLE [dbo].[CustomerModel]  WITH CHECK ADD  CONSTRAINT [FK_CustomerModel_CustomerLevelModel] FOREIGN KEY([CustomerLevelId])
REFERENCES [dbo].[CustomerLevelModel] ([CustomerLevelId])
GO
ALTER TABLE [dbo].[CustomerModel] CHECK CONSTRAINT [FK_CustomerModel_CustomerLevelModel]
GO
ALTER TABLE [dbo].[CustomerModel]  WITH CHECK ADD  CONSTRAINT [FK_CustomerModel_DistrictModel] FOREIGN KEY([DistrictId])
REFERENCES [dbo].[DistrictModel] ([DistrictId])
GO
ALTER TABLE [dbo].[CustomerModel] CHECK CONSTRAINT [FK_CustomerModel_DistrictModel]
GO
ALTER TABLE [dbo].[CustomerModel]  WITH CHECK ADD  CONSTRAINT [FK_CustomerModel_ProvinceModel] FOREIGN KEY([ProvinceId])
REFERENCES [dbo].[ProvinceModel] ([ProvinceId])
GO
ALTER TABLE [dbo].[CustomerModel] CHECK CONSTRAINT [FK_CustomerModel_ProvinceModel]
GO
ALTER TABLE [dbo].[Daily_ChicCut_OrderDetailModel]  WITH CHECK ADD  CONSTRAINT [FK_Daily_ChicCut_OrderDetailModel_Daily_ChicCut_OrderModel] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Daily_ChicCut_OrderModel] ([OrderId])
GO
ALTER TABLE [dbo].[Daily_ChicCut_OrderDetailModel] CHECK CONSTRAINT [FK_Daily_ChicCut_OrderDetailModel_Daily_ChicCut_OrderModel]
GO
ALTER TABLE [dbo].[Daily_ChicCut_OrderDetailModel]  WITH CHECK ADD  CONSTRAINT [FK_Daily_ChicCut_OrderDetailModel_Master_ChicCut_ServiceModel] FOREIGN KEY([ServiceId])
REFERENCES [dbo].[Master_ChicCut_ServiceModel] ([ServiceId])
GO
ALTER TABLE [dbo].[Daily_ChicCut_OrderDetailModel] CHECK CONSTRAINT [FK_Daily_ChicCut_OrderDetailModel_Master_ChicCut_ServiceModel]
GO
ALTER TABLE [dbo].[Daily_ChicCut_OrderModel]  WITH CHECK ADD  CONSTRAINT [FK_Daily_ChicCut_OrderModel_CustomerModel] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[CustomerModel] ([CustomerId])
GO
ALTER TABLE [dbo].[Daily_ChicCut_OrderModel] CHECK CONSTRAINT [FK_Daily_ChicCut_OrderModel_CustomerModel]
GO
ALTER TABLE [dbo].[Daily_ChicCut_OrderModel]  WITH CHECK ADD  CONSTRAINT [FK_Daily_ChicCut_OrderModel_Daily_ChicCut_OrderStatusModel] FOREIGN KEY([OrderStatusId])
REFERENCES [dbo].[Daily_ChicCut_OrderStatusModel] ([OrderStatusId])
GO
ALTER TABLE [dbo].[Daily_ChicCut_OrderModel] CHECK CONSTRAINT [FK_Daily_ChicCut_OrderModel_Daily_ChicCut_OrderStatusModel]
GO
ALTER TABLE [dbo].[Daily_ChicCut_OrderModel]  WITH CHECK ADD  CONSTRAINT [FK_Daily_ChicCut_OrderModel_DiscountTypeModel] FOREIGN KEY([BillDiscountTypeId])
REFERENCES [dbo].[DiscountTypeModel] ([DiscountTypeId])
GO
ALTER TABLE [dbo].[Daily_ChicCut_OrderModel] CHECK CONSTRAINT [FK_Daily_ChicCut_OrderModel_DiscountTypeModel]
GO
ALTER TABLE [dbo].[Daily_ChicCut_OrderModel]  WITH CHECK ADD  CONSTRAINT [FK_Daily_ChicCut_OrderModel_Master_ChicCut_HairTypeModel] FOREIGN KEY([HairTypeId])
REFERENCES [dbo].[Master_ChicCut_HairTypeModel] ([HairTypeId])
GO
ALTER TABLE [dbo].[Daily_ChicCut_OrderModel] CHECK CONSTRAINT [FK_Daily_ChicCut_OrderModel_Master_ChicCut_HairTypeModel]
GO
ALTER TABLE [dbo].[Daily_ChicCut_OrderProductDetailModel]  WITH CHECK ADD  CONSTRAINT [FK_Daily_ChicCut_OrderProductDetailModel_Daily_ChicCut_OrderModel] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Daily_ChicCut_OrderModel] ([OrderId])
GO
ALTER TABLE [dbo].[Daily_ChicCut_OrderProductDetailModel] CHECK CONSTRAINT [FK_Daily_ChicCut_OrderProductDetailModel_Daily_ChicCut_OrderModel]
GO
ALTER TABLE [dbo].[Daily_ChicCut_OrderProductDetailModel]  WITH CHECK ADD  CONSTRAINT [FK_Daily_ChicCut_OrderProductDetailModel_ProductModel] FOREIGN KEY([ProductId])
REFERENCES [dbo].[ProductModel] ([ProductId])
GO
ALTER TABLE [dbo].[Daily_ChicCut_OrderProductDetailModel] CHECK CONSTRAINT [FK_Daily_ChicCut_OrderProductDetailModel_ProductModel]
GO
ALTER TABLE [dbo].[Daily_ChicCut_Pre_OrderDetailModel]  WITH CHECK ADD  CONSTRAINT [FK_Daily_ChicCut_Pre_OrderDetailModel_Daily_ChicCut_Pre_OrderModel] FOREIGN KEY([PreOrderId])
REFERENCES [dbo].[Daily_ChicCut_Pre_OrderModel] ([PreOrderId])
GO
ALTER TABLE [dbo].[Daily_ChicCut_Pre_OrderDetailModel] CHECK CONSTRAINT [FK_Daily_ChicCut_Pre_OrderDetailModel_Daily_ChicCut_Pre_OrderModel]
GO
ALTER TABLE [dbo].[DiscountModel]  WITH CHECK ADD  CONSTRAINT [FK_DiscountModel_CalendarModel] FOREIGN KEY([CalendarId])
REFERENCES [dbo].[CalendarModel] ([CalendarId])
GO
ALTER TABLE [dbo].[DiscountModel] CHECK CONSTRAINT [FK_DiscountModel_CalendarModel]
GO
ALTER TABLE [dbo].[DistrictModel]  WITH CHECK ADD  CONSTRAINT [FK_DistrictModel_ProvinceModel] FOREIGN KEY([ProvinceId])
REFERENCES [dbo].[ProvinceModel] ([ProvinceId])
GO
ALTER TABLE [dbo].[DistrictModel] CHECK CONSTRAINT [FK_DistrictModel_ProvinceModel]
GO
ALTER TABLE [dbo].[EmployeeModel]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeModel_StoreModel] FOREIGN KEY([StoreId])
REFERENCES [dbo].[StoreModel] ([StoreId])
GO
ALTER TABLE [dbo].[EmployeeModel] CHECK CONSTRAINT [FK_EmployeeModel_StoreModel]
GO
ALTER TABLE [dbo].[ExchangeRateModel]  WITH CHECK ADD  CONSTRAINT [FK_ExchangeRateModel_CurrencyModel] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[CurrencyModel] ([CurrencyId])
GO
ALTER TABLE [dbo].[ExchangeRateModel] CHECK CONSTRAINT [FK_ExchangeRateModel_CurrencyModel]
GO
ALTER TABLE [dbo].[IEOtherDetailModel]  WITH CHECK ADD  CONSTRAINT [FK_IEOtherDetailModel_IEOtherMasterModel] FOREIGN KEY([IEOtherMasterId])
REFERENCES [dbo].[IEOtherMasterModel] ([IEOtherMasterId])
GO
ALTER TABLE [dbo].[IEOtherDetailModel] CHECK CONSTRAINT [FK_IEOtherDetailModel_IEOtherMasterModel]
GO
ALTER TABLE [dbo].[IEOtherDetailModel]  WITH NOCHECK ADD  CONSTRAINT [FK_IEOtherDetailModel_ProductModel] FOREIGN KEY([ProductId])
REFERENCES [dbo].[ProductModel] ([ProductId])
GO
ALTER TABLE [dbo].[IEOtherDetailModel] CHECK CONSTRAINT [FK_IEOtherDetailModel_ProductModel]
GO
ALTER TABLE [dbo].[IEOtherMasterModel]  WITH NOCHECK ADD  CONSTRAINT [FK_IEOtherMasterModel_InventoryTypeModel] FOREIGN KEY([InventoryTypeId])
REFERENCES [dbo].[InventoryTypeModel] ([InventoryTypeId])
GO
ALTER TABLE [dbo].[IEOtherMasterModel] CHECK CONSTRAINT [FK_IEOtherMasterModel_InventoryTypeModel]
GO
ALTER TABLE [dbo].[IEOtherMasterModel]  WITH NOCHECK ADD  CONSTRAINT [FK_IEOtherMasterModel_WarehouseModel] FOREIGN KEY([WarehouseId])
REFERENCES [dbo].[WarehouseModel] ([WarehouseId])
GO
ALTER TABLE [dbo].[IEOtherMasterModel] CHECK CONSTRAINT [FK_IEOtherMasterModel_WarehouseModel]
GO
ALTER TABLE [dbo].[ImportDetailModel]  WITH CHECK ADD  CONSTRAINT [FK_ImportDetailModel_ImportMasterModel] FOREIGN KEY([ImportMasterId])
REFERENCES [dbo].[ImportMasterModel] ([ImportMasterId])
GO
ALTER TABLE [dbo].[ImportDetailModel] CHECK CONSTRAINT [FK_ImportDetailModel_ImportMasterModel]
GO
ALTER TABLE [dbo].[ImportDetailModel]  WITH CHECK ADD  CONSTRAINT [FK_ImportDetailModel_ProductModel] FOREIGN KEY([ProductId])
REFERENCES [dbo].[ProductModel] ([ProductId])
GO
ALTER TABLE [dbo].[ImportDetailModel] CHECK CONSTRAINT [FK_ImportDetailModel_ProductModel]
GO
ALTER TABLE [dbo].[ImportMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_ImportMasterModel_CurrencyModel] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[CurrencyModel] ([CurrencyId])
GO
ALTER TABLE [dbo].[ImportMasterModel] CHECK CONSTRAINT [FK_ImportMasterModel_CurrencyModel]
GO
ALTER TABLE [dbo].[ImportMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_ImportMasterModel_ManualDiscountTypeModel] FOREIGN KEY([ManualDiscountType])
REFERENCES [dbo].[ManualDiscountTypeModel] ([ManualDiscountType])
GO
ALTER TABLE [dbo].[ImportMasterModel] CHECK CONSTRAINT [FK_ImportMasterModel_ManualDiscountTypeModel]
GO
ALTER TABLE [dbo].[ImportMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_ImportMasterModel_SupplierModel] FOREIGN KEY([SupplierId])
REFERENCES [dbo].[SupplierModel] ([SupplierId])
GO
ALTER TABLE [dbo].[ImportMasterModel] CHECK CONSTRAINT [FK_ImportMasterModel_SupplierModel]
GO
ALTER TABLE [dbo].[ImportMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_ImportMasterModel_VATTypeModel] FOREIGN KEY([VATType])
REFERENCES [dbo].[VATTypeModel] ([VATType])
GO
ALTER TABLE [dbo].[ImportMasterModel] CHECK CONSTRAINT [FK_ImportMasterModel_VATTypeModel]
GO
ALTER TABLE [dbo].[ImportMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_ImportMasterModel_WarehouseModel] FOREIGN KEY([WarehouseId])
REFERENCES [dbo].[WarehouseModel] ([WarehouseId])
GO
ALTER TABLE [dbo].[ImportMasterModel] CHECK CONSTRAINT [FK_ImportMasterModel_WarehouseModel]
GO
ALTER TABLE [dbo].[InventoryDetailModel]  WITH CHECK ADD  CONSTRAINT [FK_InventoryDetailModel_InventoryMasterModel] FOREIGN KEY([InventoryMasterId])
REFERENCES [dbo].[InventoryMasterModel] ([InventoryMasterId])
GO
ALTER TABLE [dbo].[InventoryDetailModel] CHECK CONSTRAINT [FK_InventoryDetailModel_InventoryMasterModel]
GO
ALTER TABLE [dbo].[InventoryDetailModel]  WITH CHECK ADD  CONSTRAINT [FK_InventoryDetailModel_ProductModel] FOREIGN KEY([ProductId])
REFERENCES [dbo].[ProductModel] ([ProductId])
GO
ALTER TABLE [dbo].[InventoryDetailModel] CHECK CONSTRAINT [FK_InventoryDetailModel_ProductModel]
GO
ALTER TABLE [dbo].[InventoryMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_ReventoryMasterModel_ReventoryTypeModel] FOREIGN KEY([InventoryTypeId])
REFERENCES [dbo].[InventoryTypeModel] ([InventoryTypeId])
GO
ALTER TABLE [dbo].[InventoryMasterModel] CHECK CONSTRAINT [FK_ReventoryMasterModel_ReventoryTypeModel]
GO
ALTER TABLE [dbo].[Master_ChicCut_QuantificationDetailModel]  WITH CHECK ADD  CONSTRAINT [FK_Master_ChicCut_QuantificationDetailModel_Master_ChicCut_QuantificationMasterModel] FOREIGN KEY([QuantificationMasterId])
REFERENCES [dbo].[Master_ChicCut_QuantificationMasterModel] ([QuantificationMasterId])
GO
ALTER TABLE [dbo].[Master_ChicCut_QuantificationDetailModel] CHECK CONSTRAINT [FK_Master_ChicCut_QuantificationDetailModel_Master_ChicCut_QuantificationMasterModel]
GO
ALTER TABLE [dbo].[Master_ChicCut_QuantificationDetailModel]  WITH CHECK ADD  CONSTRAINT [FK_Master_ChicCut_QuantificationDetailModel_ProductModel] FOREIGN KEY([ProductId])
REFERENCES [dbo].[ProductModel] ([ProductId])
GO
ALTER TABLE [dbo].[Master_ChicCut_QuantificationDetailModel] CHECK CONSTRAINT [FK_Master_ChicCut_QuantificationDetailModel_ProductModel]
GO
ALTER TABLE [dbo].[Master_ChicCut_QuantificationMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_Master_ChicCut_QuantificationMasterModel_Master_ChicCut_ServiceModel] FOREIGN KEY([ServiceId])
REFERENCES [dbo].[Master_ChicCut_ServiceModel] ([ServiceId])
GO
ALTER TABLE [dbo].[Master_ChicCut_QuantificationMasterModel] CHECK CONSTRAINT [FK_Master_ChicCut_QuantificationMasterModel_Master_ChicCut_ServiceModel]
GO
ALTER TABLE [dbo].[Master_ChicCut_ServiceModel]  WITH CHECK ADD  CONSTRAINT [FK_Master_ChicCut_ServiceModel_Master_ChicCut_HairTypeModel] FOREIGN KEY([HairTypeId])
REFERENCES [dbo].[Master_ChicCut_HairTypeModel] ([HairTypeId])
GO
ALTER TABLE [dbo].[Master_ChicCut_ServiceModel] CHECK CONSTRAINT [FK_Master_ChicCut_ServiceModel_Master_ChicCut_HairTypeModel]
GO
ALTER TABLE [dbo].[Master_ChicCut_ServiceModel]  WITH CHECK ADD  CONSTRAINT [FK_Master_ChicCut_ServiceModel_Master_ChicCut_ServiceCategoryModel] FOREIGN KEY([ServiceCategoryId])
REFERENCES [dbo].[Master_ChicCut_ServiceCategoryModel] ([ServiceCategoryId])
GO
ALTER TABLE [dbo].[Master_ChicCut_ServiceModel] CHECK CONSTRAINT [FK_Master_ChicCut_ServiceModel_Master_ChicCut_ServiceCategoryModel]
GO
ALTER TABLE [dbo].[MenuLanguageModel]  WITH CHECK ADD  CONSTRAINT [FK_MenuLanguageModel_LanguageModel] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[LanguageModel] ([LanguageId])
GO
ALTER TABLE [dbo].[MenuLanguageModel] CHECK CONSTRAINT [FK_MenuLanguageModel_LanguageModel]
GO
ALTER TABLE [dbo].[MenuLanguageModel]  WITH CHECK ADD  CONSTRAINT [FK_MenuLanguageModel_MenuModel] FOREIGN KEY([MenuId])
REFERENCES [dbo].[MenuModel] ([MenuId])
GO
ALTER TABLE [dbo].[MenuLanguageModel] CHECK CONSTRAINT [FK_MenuLanguageModel_MenuModel]
GO
ALTER TABLE [dbo].[OrderDetailModel]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetailModel_DiscountTypeModel] FOREIGN KEY([DiscountTypeId])
REFERENCES [dbo].[DiscountTypeModel] ([DiscountTypeId])
GO
ALTER TABLE [dbo].[OrderDetailModel] CHECK CONSTRAINT [FK_OrderDetailModel_DiscountTypeModel]
GO
ALTER TABLE [dbo].[OrderDetailModel]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetailModel_OrderMasterModel] FOREIGN KEY([OrderId])
REFERENCES [dbo].[OrderMasterModel] ([OrderId])
GO
ALTER TABLE [dbo].[OrderDetailModel] CHECK CONSTRAINT [FK_OrderDetailModel_OrderMasterModel]
GO
ALTER TABLE [dbo].[OrderDetailModel]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetailModel_ProductModel] FOREIGN KEY([ProductId])
REFERENCES [dbo].[ProductModel] ([ProductId])
GO
ALTER TABLE [dbo].[OrderDetailModel] CHECK CONSTRAINT [FK_OrderDetailModel_ProductModel]
GO
ALTER TABLE [dbo].[OrderMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_OrderMasterModel_CustomerModel] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[CustomerModel] ([CustomerId])
GO
ALTER TABLE [dbo].[OrderMasterModel] CHECK CONSTRAINT [FK_OrderMasterModel_CustomerModel]
GO
ALTER TABLE [dbo].[OrderMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_OrderMasterModel_DiscountTypeModel] FOREIGN KEY([BillDiscountTypeId])
REFERENCES [dbo].[DiscountTypeModel] ([DiscountTypeId])
GO
ALTER TABLE [dbo].[OrderMasterModel] CHECK CONSTRAINT [FK_OrderMasterModel_DiscountTypeModel]
GO
ALTER TABLE [dbo].[OrderMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_OrderMasterModel_DistrictModel] FOREIGN KEY([DistrictId])
REFERENCES [dbo].[DistrictModel] ([DistrictId])
GO
ALTER TABLE [dbo].[OrderMasterModel] CHECK CONSTRAINT [FK_OrderMasterModel_DistrictModel]
GO
ALTER TABLE [dbo].[OrderMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_OrderMasterModel_OrderStatusModel] FOREIGN KEY([OrderStatusId])
REFERENCES [dbo].[OrderStatusModel] ([OrderStatusId])
GO
ALTER TABLE [dbo].[OrderMasterModel] CHECK CONSTRAINT [FK_OrderMasterModel_OrderStatusModel]
GO
ALTER TABLE [dbo].[OrderMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_OrderMasterModel_PaymentMethodModel] FOREIGN KEY([PaymentMethodId])
REFERENCES [dbo].[PaymentMethodModel] ([PaymentMethodId])
GO
ALTER TABLE [dbo].[OrderMasterModel] CHECK CONSTRAINT [FK_OrderMasterModel_PaymentMethodModel]
GO
ALTER TABLE [dbo].[OrderMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_OrderMasterModel_ProvinceModel] FOREIGN KEY([ProvinceId])
REFERENCES [dbo].[ProvinceModel] ([ProvinceId])
GO
ALTER TABLE [dbo].[OrderMasterModel] CHECK CONSTRAINT [FK_OrderMasterModel_ProvinceModel]
GO
ALTER TABLE [dbo].[OrderMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_OrderMasterModel_WarehouseModel] FOREIGN KEY([WarehouseId])
REFERENCES [dbo].[WarehouseModel] ([WarehouseId])
GO
ALTER TABLE [dbo].[OrderMasterModel] CHECK CONSTRAINT [FK_OrderMasterModel_WarehouseModel]
GO
ALTER TABLE [dbo].[OrderReturnDetailModel]  WITH CHECK ADD  CONSTRAINT [FK_OrderReturnDetailModel_OrderReturnModel] FOREIGN KEY([OrderReturnId])
REFERENCES [dbo].[OrderReturnModel] ([OrderReturnMasterId])
GO
ALTER TABLE [dbo].[OrderReturnDetailModel] CHECK CONSTRAINT [FK_OrderReturnDetailModel_OrderReturnModel]
GO
ALTER TABLE [dbo].[PageLanguageModel]  WITH CHECK ADD  CONSTRAINT [FK_PageLanguageModel_LanguageModel] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[LanguageModel] ([LanguageId])
GO
ALTER TABLE [dbo].[PageLanguageModel] CHECK CONSTRAINT [FK_PageLanguageModel_LanguageModel]
GO
ALTER TABLE [dbo].[PageLanguageModel]  WITH NOCHECK ADD  CONSTRAINT [FK_PageLanguageModel_PageModel] FOREIGN KEY([PageId])
REFERENCES [dbo].[PageModel] ([PageId])
GO
ALTER TABLE [dbo].[PageLanguageModel] CHECK CONSTRAINT [FK_PageLanguageModel_PageModel]
GO
ALTER TABLE [dbo].[PageModel]  WITH CHECK ADD  CONSTRAINT [FK_PageModel_MenuModel] FOREIGN KEY([MenuId])
REFERENCES [dbo].[MenuModel] ([MenuId])
GO
ALTER TABLE [dbo].[PageModel] CHECK CONSTRAINT [FK_PageModel_MenuModel]
GO
ALTER TABLE [dbo].[PreImportDetailModel]  WITH CHECK ADD  CONSTRAINT [FK_PreImportDetailModel_PreImportMasterModel] FOREIGN KEY([PreImportMasterId])
REFERENCES [dbo].[PreImportMasterModel] ([PreImportMasterId])
GO
ALTER TABLE [dbo].[PreImportDetailModel] CHECK CONSTRAINT [FK_PreImportDetailModel_PreImportMasterModel]
GO
ALTER TABLE [dbo].[PreImportDetailModel]  WITH CHECK ADD  CONSTRAINT [FK_PreImportDetailModel_ProductModel] FOREIGN KEY([ProductId])
REFERENCES [dbo].[ProductModel] ([ProductId])
GO
ALTER TABLE [dbo].[PreImportDetailModel] CHECK CONSTRAINT [FK_PreImportDetailModel_ProductModel]
GO
ALTER TABLE [dbo].[PreImportMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_PreImportMasterModel_CurrencyModel] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[CurrencyModel] ([CurrencyId])
GO
ALTER TABLE [dbo].[PreImportMasterModel] CHECK CONSTRAINT [FK_PreImportMasterModel_CurrencyModel]
GO
ALTER TABLE [dbo].[PreImportMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_PreImportMasterModel_ManualDiscountTypeModel] FOREIGN KEY([ManualDiscountType])
REFERENCES [dbo].[ManualDiscountTypeModel] ([ManualDiscountType])
GO
ALTER TABLE [dbo].[PreImportMasterModel] CHECK CONSTRAINT [FK_PreImportMasterModel_ManualDiscountTypeModel]
GO
ALTER TABLE [dbo].[PreImportMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_PreImportMasterModel_SupplierModel] FOREIGN KEY([SupplierId])
REFERENCES [dbo].[SupplierModel] ([SupplierId])
GO
ALTER TABLE [dbo].[PreImportMasterModel] CHECK CONSTRAINT [FK_PreImportMasterModel_SupplierModel]
GO
ALTER TABLE [dbo].[PreImportMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_PreImportMasterModel_VATTypeModel] FOREIGN KEY([VATType])
REFERENCES [dbo].[VATTypeModel] ([VATType])
GO
ALTER TABLE [dbo].[PreImportMasterModel] CHECK CONSTRAINT [FK_PreImportMasterModel_VATTypeModel]
GO
ALTER TABLE [dbo].[PreImportMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_PreImportMasterModel_WarehouseModel] FOREIGN KEY([WarehouseId])
REFERENCES [dbo].[WarehouseModel] ([WarehouseId])
GO
ALTER TABLE [dbo].[PreImportMasterModel] CHECK CONSTRAINT [FK_PreImportMasterModel_WarehouseModel]
GO
ALTER TABLE [dbo].[PreOrderDetailModel]  WITH CHECK ADD  CONSTRAINT [FK_PreOrderDetailModel_DiscountTypeModel] FOREIGN KEY([DiscountTypeId])
REFERENCES [dbo].[DiscountTypeModel] ([DiscountTypeId])
GO
ALTER TABLE [dbo].[PreOrderDetailModel] CHECK CONSTRAINT [FK_PreOrderDetailModel_DiscountTypeModel]
GO
ALTER TABLE [dbo].[PreOrderDetailModel]  WITH CHECK ADD  CONSTRAINT [FK_PreOrderDetailModel_PreOrderMasterModel] FOREIGN KEY([PreOrderId])
REFERENCES [dbo].[PreOrderMasterModel] ([PreOrderId])
GO
ALTER TABLE [dbo].[PreOrderDetailModel] CHECK CONSTRAINT [FK_PreOrderDetailModel_PreOrderMasterModel]
GO
ALTER TABLE [dbo].[PreOrderDetailModel]  WITH CHECK ADD  CONSTRAINT [FK_PreOrderDetailModel_ProductModel] FOREIGN KEY([ProductId])
REFERENCES [dbo].[ProductModel] ([ProductId])
GO
ALTER TABLE [dbo].[PreOrderDetailModel] CHECK CONSTRAINT [FK_PreOrderDetailModel_ProductModel]
GO
ALTER TABLE [dbo].[PreOrderMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_PreOrderMasterModel_CustomerModel] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[CustomerModel] ([CustomerId])
GO
ALTER TABLE [dbo].[PreOrderMasterModel] CHECK CONSTRAINT [FK_PreOrderMasterModel_CustomerModel]
GO
ALTER TABLE [dbo].[PreOrderMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_PreOrderMasterModel_DiscountTypeModel] FOREIGN KEY([BillDiscountTypeId])
REFERENCES [dbo].[DiscountTypeModel] ([DiscountTypeId])
GO
ALTER TABLE [dbo].[PreOrderMasterModel] CHECK CONSTRAINT [FK_PreOrderMasterModel_DiscountTypeModel]
GO
ALTER TABLE [dbo].[PreOrderMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_PreOrderMasterModel_DistrictModel] FOREIGN KEY([DistrictId])
REFERENCES [dbo].[DistrictModel] ([DistrictId])
GO
ALTER TABLE [dbo].[PreOrderMasterModel] CHECK CONSTRAINT [FK_PreOrderMasterModel_DistrictModel]
GO
ALTER TABLE [dbo].[PreOrderMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_PreOrderMasterModel_OrderStatusModel] FOREIGN KEY([OrderStatusId])
REFERENCES [dbo].[OrderStatusModel] ([OrderStatusId])
GO
ALTER TABLE [dbo].[PreOrderMasterModel] CHECK CONSTRAINT [FK_PreOrderMasterModel_OrderStatusModel]
GO
ALTER TABLE [dbo].[PreOrderMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_PreOrderMasterModel_PaymentMethodModel] FOREIGN KEY([PaymentMethodId])
REFERENCES [dbo].[PaymentMethodModel] ([PaymentMethodId])
GO
ALTER TABLE [dbo].[PreOrderMasterModel] CHECK CONSTRAINT [FK_PreOrderMasterModel_PaymentMethodModel]
GO
ALTER TABLE [dbo].[PreOrderMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_PreOrderMasterModel_ProvinceModel] FOREIGN KEY([ProvinceId])
REFERENCES [dbo].[ProvinceModel] ([ProvinceId])
GO
ALTER TABLE [dbo].[PreOrderMasterModel] CHECK CONSTRAINT [FK_PreOrderMasterModel_ProvinceModel]
GO
ALTER TABLE [dbo].[PreOrderMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_PreOrderMasterModel_WarehouseModel] FOREIGN KEY([WarehouseId])
REFERENCES [dbo].[WarehouseModel] ([WarehouseId])
GO
ALTER TABLE [dbo].[PreOrderMasterModel] CHECK CONSTRAINT [FK_PreOrderMasterModel_WarehouseModel]
GO
ALTER TABLE [dbo].[ProductAlertModel]  WITH CHECK ADD  CONSTRAINT [FK_ProductAlertModel_ProductModel] FOREIGN KEY([ProductId])
REFERENCES [dbo].[ProductModel] ([ProductId])
GO
ALTER TABLE [dbo].[ProductAlertModel] CHECK CONSTRAINT [FK_ProductAlertModel_ProductModel]
GO
ALTER TABLE [dbo].[ProductAlertModel]  WITH CHECK ADD  CONSTRAINT [FK_ProductAlertModel_RolesModel] FOREIGN KEY([RolesId])
REFERENCES [dbo].[RolesModel] ([RolesId])
GO
ALTER TABLE [dbo].[ProductAlertModel] CHECK CONSTRAINT [FK_ProductAlertModel_RolesModel]
GO
ALTER TABLE [dbo].[ProductAlertModel]  WITH CHECK ADD  CONSTRAINT [FK_ProductAlertModel_WarehouseModel] FOREIGN KEY([WarehouseId])
REFERENCES [dbo].[WarehouseModel] ([WarehouseId])
GO
ALTER TABLE [dbo].[ProductAlertModel] CHECK CONSTRAINT [FK_ProductAlertModel_WarehouseModel]
GO
ALTER TABLE [dbo].[ProductImageModel]  WITH NOCHECK ADD  CONSTRAINT [FK_ProductImageModel_ProductModel] FOREIGN KEY([ProductId])
REFERENCES [dbo].[ProductModel] ([ProductId])
GO
ALTER TABLE [dbo].[ProductImageModel] CHECK CONSTRAINT [FK_ProductImageModel_ProductModel]
GO
ALTER TABLE [dbo].[ProductPriceModel]  WITH CHECK ADD  CONSTRAINT [FK_ProductPriceModel_CustomerLevelModel] FOREIGN KEY([CustomerLevelId])
REFERENCES [dbo].[CustomerLevelModel] ([CustomerLevelId])
GO
ALTER TABLE [dbo].[ProductPriceModel] CHECK CONSTRAINT [FK_ProductPriceModel_CustomerLevelModel]
GO
ALTER TABLE [dbo].[ProductPriceModel]  WITH CHECK ADD  CONSTRAINT [FK_ProductPriceModel_ProductModel] FOREIGN KEY([ProductId])
REFERENCES [dbo].[ProductModel] ([ProductId])
GO
ALTER TABLE [dbo].[ProductPriceModel] CHECK CONSTRAINT [FK_ProductPriceModel_ProductModel]
GO
ALTER TABLE [dbo].[RegistryModel]  WITH CHECK ADD  CONSTRAINT [FK__RegistryM__Cours__13F1F5EB] FOREIGN KEY([CourseId])
REFERENCES [dbo].[CourseModel] ([CourseId])
GO
ALTER TABLE [dbo].[RegistryModel] CHECK CONSTRAINT [FK__RegistryM__Cours__13F1F5EB]
GO
ALTER TABLE [dbo].[ReturnDetailModel]  WITH CHECK ADD  CONSTRAINT [FK_ReturnDetailModel_ProductModel] FOREIGN KEY([ProductId])
REFERENCES [dbo].[ProductModel] ([ProductId])
GO
ALTER TABLE [dbo].[ReturnDetailModel] CHECK CONSTRAINT [FK_ReturnDetailModel_ProductModel]
GO
ALTER TABLE [dbo].[ReturnDetailModel]  WITH CHECK ADD  CONSTRAINT [FK_ReturnDetailModel_ReturnMasterModel] FOREIGN KEY([ReturnMasterId])
REFERENCES [dbo].[ReturnMasterModel] ([ReturnMasterId])
GO
ALTER TABLE [dbo].[ReturnDetailModel] CHECK CONSTRAINT [FK_ReturnDetailModel_ReturnMasterModel]
GO
ALTER TABLE [dbo].[ReturnMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_ReturnMasterModel_CurrencyModel] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[CurrencyModel] ([CurrencyId])
GO
ALTER TABLE [dbo].[ReturnMasterModel] CHECK CONSTRAINT [FK_ReturnMasterModel_CurrencyModel]
GO
ALTER TABLE [dbo].[ReturnMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_ReturnMasterModel_ManualDiscountTypeModel] FOREIGN KEY([ManualDiscountType])
REFERENCES [dbo].[ManualDiscountTypeModel] ([ManualDiscountType])
GO
ALTER TABLE [dbo].[ReturnMasterModel] CHECK CONSTRAINT [FK_ReturnMasterModel_ManualDiscountTypeModel]
GO
ALTER TABLE [dbo].[ReturnMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_ReturnMasterModel_SupplierModel] FOREIGN KEY([SupplierId])
REFERENCES [dbo].[SupplierModel] ([SupplierId])
GO
ALTER TABLE [dbo].[ReturnMasterModel] CHECK CONSTRAINT [FK_ReturnMasterModel_SupplierModel]
GO
ALTER TABLE [dbo].[ReturnMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_ReturnMasterModel_VATTypeModel] FOREIGN KEY([VATType])
REFERENCES [dbo].[VATTypeModel] ([VATType])
GO
ALTER TABLE [dbo].[ReturnMasterModel] CHECK CONSTRAINT [FK_ReturnMasterModel_VATTypeModel]
GO
ALTER TABLE [dbo].[ReturnMasterModel]  WITH CHECK ADD  CONSTRAINT [FK_ReturnMasterModel_WarehouseModel] FOREIGN KEY([WarehouseId])
REFERENCES [dbo].[WarehouseModel] ([WarehouseId])
GO
ALTER TABLE [dbo].[ReturnMasterModel] CHECK CONSTRAINT [FK_ReturnMasterModel_WarehouseModel]
GO
ALTER TABLE [dbo].[RolesLanguageModel]  WITH CHECK ADD  CONSTRAINT [FK_RolesLanguageModel_LanguageModel] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[LanguageModel] ([LanguageId])
GO
ALTER TABLE [dbo].[RolesLanguageModel] CHECK CONSTRAINT [FK_RolesLanguageModel_LanguageModel]
GO
ALTER TABLE [dbo].[RolesLanguageModel]  WITH NOCHECK ADD  CONSTRAINT [FK_RolesLanguageModel_RolesModel] FOREIGN KEY([RolesId])
REFERENCES [dbo].[RolesModel] ([RolesId])
GO
ALTER TABLE [dbo].[RolesLanguageModel] CHECK CONSTRAINT [FK_RolesLanguageModel_RolesModel]
GO
ALTER TABLE [dbo].[StoreModel]  WITH CHECK ADD  CONSTRAINT [FK_StoreModel_DistrictModel] FOREIGN KEY([DistrictId])
REFERENCES [dbo].[DistrictModel] ([DistrictId])
GO
ALTER TABLE [dbo].[StoreModel] CHECK CONSTRAINT [FK_StoreModel_DistrictModel]
GO
ALTER TABLE [dbo].[StoreModel]  WITH CHECK ADD  CONSTRAINT [FK_StoreModel_ProvinceModel] FOREIGN KEY([ProvinceId])
REFERENCES [dbo].[ProvinceModel] ([ProvinceId])
GO
ALTER TABLE [dbo].[StoreModel] CHECK CONSTRAINT [FK_StoreModel_ProvinceModel]
GO
ALTER TABLE [dbo].[SupplierModel]  WITH CHECK ADD  CONSTRAINT [FK_SupplierModel_DistrictModel] FOREIGN KEY([DistrictId])
REFERENCES [dbo].[DistrictModel] ([DistrictId])
GO
ALTER TABLE [dbo].[SupplierModel] CHECK CONSTRAINT [FK_SupplierModel_DistrictModel]
GO
ALTER TABLE [dbo].[SupplierModel]  WITH CHECK ADD  CONSTRAINT [FK_SupplierModel_ProvinceModel] FOREIGN KEY([ProvinceId])
REFERENCES [dbo].[ProvinceModel] ([ProvinceId])
GO
ALTER TABLE [dbo].[SupplierModel] CHECK CONSTRAINT [FK_SupplierModel_ProvinceModel]
GO
ALTER TABLE [dbo].[WarehouseInventoryDetailModel]  WITH CHECK ADD  CONSTRAINT [FK_WarehouseInventoryDetailModel_WarehouseInventoryMasterModel] FOREIGN KEY([WarehouseInventoryMasterId])
REFERENCES [dbo].[WarehouseInventoryMasterModel] ([WarehouseInventoryMasterId])
GO
ALTER TABLE [dbo].[WarehouseInventoryDetailModel] CHECK CONSTRAINT [FK_WarehouseInventoryDetailModel_WarehouseInventoryMasterModel]
GO
ALTER TABLE [dbo].[WarehouseModel]  WITH CHECK ADD  CONSTRAINT [FK_WarehouseModel_DistrictModel] FOREIGN KEY([DistrictId])
REFERENCES [dbo].[DistrictModel] ([DistrictId])
GO
ALTER TABLE [dbo].[WarehouseModel] CHECK CONSTRAINT [FK_WarehouseModel_DistrictModel]
GO
ALTER TABLE [dbo].[WarehouseModel]  WITH CHECK ADD  CONSTRAINT [FK_WarehouseModel_ProvinceModel] FOREIGN KEY([ProvinceId])
REFERENCES [dbo].[ProvinceModel] ([ProvinceId])
GO
ALTER TABLE [dbo].[WarehouseModel] CHECK CONSTRAINT [FK_WarehouseModel_ProvinceModel]
GO
ALTER TABLE [dbo].[WarehouseModel]  WITH CHECK ADD  CONSTRAINT [FK_WarehouseModel_StoreModel] FOREIGN KEY([StoreId])
REFERENCES [dbo].[StoreModel] ([StoreId])
GO
ALTER TABLE [dbo].[WarehouseModel] CHECK CONSTRAINT [FK_WarehouseModel_StoreModel]
GO
ALTER TABLE [dbo].[Website_AdsModel]  WITH CHECK ADD  CONSTRAINT [FK_Website_AdsModel_Website_LocationModel] FOREIGN KEY([LocationId])
REFERENCES [dbo].[Website_LocationModel] ([LocationId])
GO
ALTER TABLE [dbo].[Website_AdsModel] CHECK CONSTRAINT [FK_Website_AdsModel_Website_LocationModel]
GO
ALTER TABLE [dbo].[Website_NewsModel]  WITH CHECK ADD  CONSTRAINT [FK_Website_NewsModel_CategoryModel] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[CategoryModel] ([CategoryId])
GO
ALTER TABLE [dbo].[Website_NewsModel] CHECK CONSTRAINT [FK_Website_NewsModel_CategoryModel]
GO
/****** Object:  StoredProcedure [dbo].[h_category_DeleteCategory]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[h_category_DeleteCategory]
  @CategoryID int
AS
BEGIN
	SET NOCOUNT ON;
	begin TRY
	
	declare @ADNCode nvarchar(4000)
	select @ADNCode = ADNCode from CategoryModel where CategoryID = @CategoryID
	
	UPDATE [dbo].[CategoryModel]
	SET Actived = 0
	WHERE ADNCode LIKE (@ADNCode + '%') 
	return 1
	
	end try
	begin catch
		return 0
	end catch
END

GO
/****** Object:  StoredProcedure [dbo].[h_category_FindCategory]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[h_category_FindCategory]
	@parameter nvarchar(4000)
AS
BEGIN

	SET NOCOUNT ON;
	
		SELECT [CategoryID]
		  ,[CategoryName]
		  ,[CategoryNameEn]
		  ,[OrderBy]
		  ,[Parent]
		  ,[Description]
		  ,[ImageUrl]
		  ,[SEOCategoryName]
		  ,isHasChildren
	  FROM [dbo].[CategoryModel]
	 where ([CategoryName]  like '%@parameter%' or @parameter = '')
	 AND Actived = 1
	 

END

GO
/****** Object:  StoredProcedure [dbo].[h_category_GetCatagoryBy]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[h_category_GetCatagoryBy]
	@CategoryID int,
	@Lang char(5) = 'vi-vn'
AS
BEGIN

	SET NOCOUNT ON;
IF @Lang = 'vi-vn'
BEGIN 
	SELECT [CategoryID]
      ,[CategoryName]
      ,[CategoryNameEn]
      ,[OrderBy]
      ,[Parent]
      ,[Description]
      ,[DescriptionEn]
      ,[ImageUrl]
      ,[SEOCategoryName]
      ,[isHasChildren]
      ,ADNCode
  FROM [CategoryModel]
  where CategoryID = @CategoryID and
		Actived = 1  
  order by [OrderBy]  
END
ELSE	
	
	SELECT [CategoryID]
      ,[CategoryNameEn] AS [CategoryName]
      ,[OrderBy]
      ,[Parent]
      ,[DescriptionEn] AS [Description]
      ,[ImageUrl]
      ,[SEOCategoryName]
      ,[isHasChildren]
  FROM [CategoryModel]
  where CategoryID = @CategoryID and
		Actived = 1  
  order by [OrderBy] 

END

GO
/****** Object:  StoredProcedure [dbo].[h_category_GetCatagoryByParent]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[h_category_GetCatagoryByParent]
	@Parent int = 0,
	@Lang char(5) = 'vi-vn'
AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRY	
	if @Lang = 'vi-vn'
	BEGIN
		SELECT [CategoryID]
		  ,[CategoryName]
		  ,[CategoryNameEn]
		  ,[OrderBy]
		  ,[Parent]
		  ,[Description]
		  ,ImageUrl
		  ,[SEOCategoryName]
		  ,[isHasChildren]
		  ,ADNCode
		  ,[isDisplayOnHomePage]
		FROM [dbo].[CategoryModel]
		where (Parent = @Parent) and
			Actived = 1  
		Order by OrderBy
	end 
	else
	BEGIN	
		SELECT [CategoryID]
		  ,[CategoryNameEn] as [CategoryName]
		  ,[CategoryNameEn]
		  ,[OrderBy]
		  ,[Parent]
		  ,DescriptionEn as [Description]
		  ,ImageUrl
		  ,[SEOCategoryName]		  
		  ,[isHasChildren]
		  ,ADNCode
		  ,[isDisplayOnHomePage]
		FROM [dbo].[CategoryModel]
		where (Parent = @Parent) and
			Actived = 1  
		Order by OrderBy
	end
	END TRY
	BEGIN CATCH 
	END CATCH	 
END

GO
/****** Object:  StoredProcedure [dbo].[h_category_GetCategoryType]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[h_category_GetCategoryType]
AS
BEGIN

	SET NOCOUNT ON;
		
		SELECT CategoryID
		  ,CategoryName
		  ,OrderBy
		FROM CategoryModel
		where Actived = 1 and Parent = 0
	

END

GO
/****** Object:  StoredProcedure [dbo].[h_category_InsertCategory]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[h_category_InsertCategory]
			@CategoryName nvarchar(4000),
			@CategoryNameEn nvarchar(4000),
           @OrderBy int,
           @Parent int,
           @Description NTEXT,
           @DescriptionEn NTEXT,
           @ImageUrl nvarchar(4000),
           @SEOCategoryName nvarchar(4000),
           @isHasChildren bit
AS
BEGIN

	SET NOCOUNT ON;
	begin try
	
		declare @catid int
		declare @ADNCode nvarchar(4000)
		
		INSERT INTO [dbo].[CategoryModel]
			   ([CategoryName]
			   ,[CategoryNameEn]
			   ,[OrderBy]
			   ,[Parent]
			   ,[Description]
			   ,[DescriptionEn]
			   ,[ImageUrl]
			   ,[SEOCategoryName]
			   ,[isHasChildren]
			   ,[Actived])
		 VALUES
			   (@CategoryName ,
			   @CategoryNameEn ,
			   @OrderBy ,
			   @Parent ,
			   @Description ,
			   @DescriptionEn ,
			   @ImageUrl ,
			   @SEOCategoryName ,
			   @isHasChildren,
			   1)
		set @catid = SCOPE_IDENTITY()
		
		select @ADNCode = ADNCode from CategoryModel where CategoryID = @Parent
		
		UPDATE [dbo].[CategoryModel]
		SET [ADNCode] = @ADNCode + '.' + CONVERT(nvarchar(10), [CategoryID])
		where CategoryID = @catid
		return @catid
	end try
	begin catch
		return 0
	end catch

END

GO
/****** Object:  StoredProcedure [dbo].[h_category_SelectAllCategory]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[h_category_SelectAllCategory]
	
AS
BEGIN

	SET NOCOUNT ON;
	SELECT [CategoryID]
      ,[CategoryName]
      ,[OrderBy]
      ,[Parent]
      ,[Description]
      ,[ImageUrl]
      ,[SEOCategoryName]
  FROM [dbo].[CategoryModel]
  where Actived = 1


END


GO
/****** Object:  StoredProcedure [dbo].[h_category_UpdateCategory]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[h_category_UpdateCategory]
			   @CategoryName nvarchar(4000),
			   @CategoryNameEn nvarchar(4000),
			   @OrderBy int,
			   @Parent int,
			   @Description ntext,
			   @DescriptionEn ntext,
			   @ImageUrl nvarchar(4000),
			   @SEOCategoryName nvarchar(4000),
			   @isHasChildren bit,
			   @CategoryID int
	AS
	BEGIN
	SET NOCOUNT ON;
	begin try
		 begin tran UpdateCategory
			declare @ADNCodeOld nvarchar(4000)
			declare @ADNCodeNew nvarchar(4000)
			
			UPDATE [dbo].[CategoryModel]
			SET [CategoryName] = @CategoryName
			  ,[CategoryNameEn] = @CategoryNameEn
			  ,[OrderBy] = @OrderBy
			  ,[Parent] = @Parent
			  ,[Description] = @Description
			  ,[DescriptionEn] = @DescriptionEn
			  ,[ImageUrl] = @ImageUrl
			  ,isHasChildren = @isHasChildren
			  ,[SEOCategoryName] = @SEOCategoryName
			WHERE CategoryID = @CategoryID
		
			select @ADNCodeOld = ADNCode from CategoryModel where CategoryID = @CategoryID
			select @ADNCodeNew = ADNCode from CategoryModel where CategoryID = @Parent
			
			--update adncode category
			UPDATE [dbo].[CategoryModel]
			SET [ADNCode] = @ADNCodeNew + '.' + CONVERT(nvarchar(10), [CategoryID])
			where CategoryID = @CategoryID
			
			--update adncode childen
			set @ADNCodeNew = @ADNCodeNew + '.' +  CONVERT(nvarchar(10), @CategoryID)
			update CategoryModel
			set [ADNCode] = replace([ADNCode],@ADNCodeOld,@ADNCodeNew)
			where CategoryID in (select CategoryID from CategoryModel where ADNCode like @ADNCodeOld+'%')
			
		commit tran UpdateCategory
			
		return 1
	end try
	begin catch
		rollback tran UpdateCategory
		return 0
	end catch
end

GO
/****** Object:  StoredProcedure [dbo].[h_Counter_UpViews]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[h_Counter_UpViews]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    declare @ret int
    
	declare @id int
	select [id]
	into #kq
	from [Website_Counter]
	where [Date] = convert(varchar(10),GETDATE(), 101) 
	
	if exists ( select id from #kq)
		begin
			update [Website_Counter] set Views = Views + 1 where ID = (select id from #kq)
		end
	else
		begin
			insert into [Website_Counter] values (1,GETDATE())
		end
END

GO
/****** Object:  StoredProcedure [dbo].[InsertCategory]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[InsertCategory]
			@CategoryName nvarchar(4000),
			@CategoryNameEn nvarchar(4000),
           @OrderBy int,
           @Parent int,
           @Description NTEXT,
           @DescriptionEn NTEXT,
           @ImageUrl nvarchar(4000),
           @SEOCategoryName nvarchar(4000),
           @isHasChildren bit
AS
BEGIN

	SET NOCOUNT ON;
	begin try
	
		declare @catid int
		declare @ADNCode nvarchar(4000)
		
		INSERT INTO [dbo].[CategoryModel]
			   ([CategoryName]
			   ,[CategoryNameEn]
			   ,[OrderBy]
			   ,[Parent]
			   ,[Description]
			   ,[DescriptionEn]
			   ,[ImageUrl]
			   ,[SEOCategoryName]
			   ,[isHasChildren]
			   ,[Actived])
		 VALUES
			   (@CategoryName ,
			   @CategoryNameEn ,
			   @OrderBy ,
			   @Parent ,
			   @Description ,
			   @DescriptionEn ,
			   @ImageUrl ,
			   @SEOCategoryName ,
			   @isHasChildren,
			   1)
		set @catid = SCOPE_IDENTITY()
		
		select @ADNCode = ADNCode from CategoryModel where CategoryID = @Parent
		
		UPDATE [dbo].[CategoryModel]
		SET [ADNCode] = @ADNCode + '.' + CONVERT(nvarchar(10), [CategoryID])
		where CategoryID = @catid
		return @catid
	end try
	begin catch
		return 0
	end catch

END

GO
/****** Object:  StoredProcedure [dbo].[msp_ResetDatabase]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vũ Hoài Nam
-- Create date: 04/06/2016
-- Description:	Xóa dữ database các nghiệp vụ sau
-- nhập hàng từ nhà cung cấp
-- bán hàng
-- xuất nhập tồn
-- =============================================
CREATE PROCEDURE [dbo].[msp_ResetDatabase]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DELETE dbo.ImportDetailModel
	DELETE dbo.ImportMasterModel
	
	DELETE dbo.OrderDetailModel
	DELETE dbo.OrderMasterModel
	
	DELETE dbo.InventoryDetailModel
	DELETE dbo.InventoryMasterModel
	
END

GO
/****** Object:  StoredProcedure [dbo].[n_Category_GetWithFormat]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[n_Category_GetWithFormat]
@Parent int, -- display all category in
@CategoryID int = 0 -- category isn't display
as

declare @ADNCode nvarchar(4000)
select @ADNCode = ADNCode from CategoryModel where CategoryID = @Parent


declare @ADNCodeNoDisplay nvarchar(4000) = 'NoLike'

	
if(@CategoryID <> 0)
begin
	select @ADNCodeNoDisplay = ADNCode from CategoryModel where CategoryID = @CategoryID
end

SELECT  
      replace(replace(replace(replace(
      replace(replace(replace(replace(
      replace(replace(replace(replace(
      SUBSTRING (cat.ADNCode,0,coalesce(len('x' + ltrim(cat.ADNCode)), '') - len(coalesce(replace(cat.ADNCode, '.', ''), ''))-2)
      ,'1','&nbsp;&nbsp;&nbsp;&nbsp;'),'2','&nbsp;&nbsp;&nbsp;&nbsp;'),'3','&nbsp;&nbsp;&nbsp;&nbsp;'),'4','&nbsp;&nbsp;&nbsp;&nbsp;')
      ,'5','&nbsp;&nbsp;&nbsp;&nbsp;'),'6','&nbsp;&nbsp;&nbsp;&nbsp;'),'7','&nbsp;&nbsp;&nbsp;&nbsp;'),'8','&nbsp;&nbsp;&nbsp;&nbsp;')
      ,'9','&nbsp;&nbsp;&nbsp;&nbsp;'),'10','&nbsp;&nbsp;&nbsp;&nbsp;'),'.','&nbsp;&nbsp;&nbsp;&nbsp;'),'0','&nbsp;&nbsp;&nbsp;&nbsp;')
      +'-- '+cat.[CategoryName] as CategoryName
      ,cat.[CategoryID]
  FROM [dbo].[CategoryModel] as cat, CategoryModel as catParent
  where cat.Actived = 1 and catParent.Actived = 1 and cat.Parent = catParent.CategoryID and
  cat.ADNCode like (@ADNCode + '%') and 
  cat.ADNCode not like (@ADNCodeNoDisplay + '%')
  order by cat.ADNCode

GO
/****** Object:  StoredProcedure [dbo].[n_Category_GetWithFormatTest]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[n_Category_GetWithFormatTest]
@Parent int = 2, -- display all category in
@CategoryID int = 0 -- category isn't display
as

declare @ADNCode nvarchar(4000)
select @ADNCode = ADNCode from CategoryModel where CategoryID = @Parent


declare @ADNCodeNoDisplay nvarchar(4000) = 'NoLike'

	
if(@CategoryID <> 0)
begin
	select @ADNCodeNoDisplay = ADNCode from CategoryModel where CategoryID = @CategoryID
end

SELECT cat.ADNCode , 
      replace(replace(replace(replace(
      replace(replace(replace(replace(
      replace(replace(replace(replace(
      SUBSTRING (cat.ADNCode,0,len(ltrim(cat.ADNCode)) - len(replace(cat.ADNCode, '.', '')) - 1)
      ,'1','&nbsp;&nbsp;&nbsp;&nbsp;'),'2','&nbsp;&nbsp;&nbsp;&nbsp;'),'3','&nbsp;&nbsp;&nbsp;&nbsp;'),'4','&nbsp;&nbsp;&nbsp;&nbsp;')
      ,'5','&nbsp;&nbsp;&nbsp;&nbsp;'),'6','&nbsp;&nbsp;&nbsp;&nbsp;'),'7','&nbsp;&nbsp;&nbsp;&nbsp;'),'8','&nbsp;&nbsp;&nbsp;&nbsp;')
      ,'9','&nbsp;&nbsp;&nbsp;&nbsp;'),'10','&nbsp;&nbsp;&nbsp;&nbsp;'),'.','&nbsp;&nbsp;&nbsp;&nbsp;'),'0','&nbsp;&nbsp;&nbsp;&nbsp;')
      +'-- '+cat.[CategoryName] as CategoryName
      ,cat.[CategoryID]
  FROM [dbo].[CategoryModel] as cat, CategoryModel as catParent
  where cat.Actived = 1 and catParent.Actived = 1 and cat.Parent = catParent.CategoryID and
  cat.ADNCode like (@ADNCode + '%') and 
  cat.ADNCode not like (@ADNCodeNoDisplay + '%')
  order by cat.ADNCode

--exec  [dbo].[n_Category_GetWithFormatTest]
GO
/****** Object:  StoredProcedure [dbo].[QTHT_MenuModel_GetMenuByRolesId]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[QTHT_MenuModel_GetMenuByRolesId]
	-- Add the parameters for the stored procedure here
	@RolesId int,
	@LanguageId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	if(@LanguageId = 10001)
	begin
		SELECT   distinct( MenuModel.MenuId), MenuModel.MenuName,MenuModel.icon, MenuModel.OrderBy
		FROM         PageModel INNER JOIN
							  MenuModel ON PageModel.MenuId = MenuModel.MenuId INNER JOIN
							  AccessModel ON PageModel.PageId = AccessModel.PageId
		WHERE     (AccessModel.RolesId = @RolesId and PageModel.Actived = 1)
		order by MenuModel.OrderBy
	end
	else
	begin
		select menu.MenuId, menu.icon, menu.OrderBy,MenuLanguageModel.MenuName
		from	(SELECT   distinct( MenuModel.MenuId), MenuModel.icon, MenuModel.OrderBy
				FROM         PageModel INNER JOIN
									  MenuModel ON PageModel.MenuId = MenuModel.MenuId INNER JOIN
									  AccessModel ON PageModel.PageId = AccessModel.PageId
				WHERE     (AccessModel.RolesId = @RolesId and PageModel.Actived = 1)
				) menu, MenuLanguageModel 
		where menu.MenuId = MenuLanguageModel.MenuId and
			MenuLanguageModel.LanguageId = @LanguageId
		order by menu.OrderBy
	end
END

GO
/****** Object:  StoredProcedure [dbo].[QTHT_PageModel_GetPageByRolesId]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[QTHT_PageModel_GetPageByRolesId]
	@RolesId int,
	@LanguageId int
AS
BEGIN
	
		SET NOCOUNT ON;
		if(@LanguageId = 10001)
		begin
			SELECT     PageModel.PageId, PageModel.PageName, PageModel.PageUrl,[MenuId],PageModel.Icon,PageModel.OrderBy, PageModel.Actived
			FROM         PageModel INNER JOIN
								  AccessModel ON PageModel.PageId = AccessModel.PageId
			WHERE     (AccessModel.RolesId = @RolesId and PageModel.Actived = 1)
			order BY PageModel.OrderBy
		end
		else
		begin
				select page.PageId,PageLanguageModel.PageName,page.PageUrl,page.MenuId,page.Icon,page.OrderBy,page.Actived
				from	(SELECT PageModel.PageId, PageModel.PageUrl,[MenuId],PageModel.Icon,PageModel.OrderBy, PageModel.Actived
						FROM    PageModel INNER JOIN
								AccessModel ON PageModel.PageId = AccessModel.PageId
						WHERE	(AccessModel.RolesId = @RolesId and PageModel.Actived = 1)) page, PageLanguageModel
				where page.PageId = PageLanguageModel.PageId and
					  PageLanguageModel.LanguageId = @LanguageId
				order BY page.OrderBy
		end
END

GO
/****** Object:  StoredProcedure [dbo].[Reset_Data]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Reset_Data]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete IEOtherDetailModel
	delete IEOtherMasterModel

	delete [ChicCut].[dbo].[ImportDetailModel]
	delete [ChicCut].[dbo].[ImportMasterModel]

	delete [ChicCut].[dbo].[InventoryDetailModel]
	delete [ChicCut].[dbo].[InventoryMasterModel]
	
	delete OrderDetailModel
	delete OrderMasterModel

	delete Daily_ChicCut_Pre_OrderDetailModel
	delete Daily_ChicCut_Pre_OrderModel

	delete Daily_ChicCut_OrderDetailModel
	delete Daily_ChicCut_OrderModel
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateCategory]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[UpdateCategory]
			   @CategoryName nvarchar(4000),
			   @CategoryNameEn nvarchar(4000),
			   @OrderBy int,
			   @Parent int,
			   @Description ntext,
			   @DescriptionEn ntext,
			   @ImageUrl nvarchar(4000),
			   @SEOCategoryName nvarchar(4000),
			   @isHasChildren bit,
			   @CategoryID int,
			   @isDisplayOnHomePage bit,
			   @Keywords nvarchar(200),
			   @KeywordsEn nvarchar(200)
	AS
	BEGIN
	SET NOCOUNT ON;
	begin try
		 begin tran UpdateCategory
			declare @ADNCodeOld nvarchar(4000)
			declare @ADNCodeNew nvarchar(4000)
			
			UPDATE [dbo].[CategoryModel]
			SET [CategoryName] = @CategoryName
			  ,[CategoryNameEn] = @CategoryNameEn
			  ,[OrderBy] = @OrderBy
			  ,[Parent] = @Parent
			  ,[Description] = @Description
			  ,[DescriptionEn] = @DescriptionEn
			  ,[ImageUrl] = @ImageUrl
			  ,isHasChildren = @isHasChildren
			  ,[SEOCategoryName] = @SEOCategoryName
			  ,[isDisplayOnHomePage] = @isDisplayOnHomePage
			  ,[Keywords] = @Keywords
			  ,[KeywordsEn] = @KeywordsEn
			WHERE CategoryID = @CategoryID
		
			select @ADNCodeOld = ADNCode from CategoryModel where CategoryID = @CategoryID
			select @ADNCodeNew = ADNCode from CategoryModel where CategoryID = @Parent
			
			--update adncode category
			UPDATE [dbo].[CategoryModel]
			SET [ADNCode] = @ADNCodeNew + '.' + CONVERT(nvarchar(10), [CategoryID])
			where CategoryID = @CategoryID
			
			--update adncode childen
			set @ADNCodeNew = @ADNCodeNew + '.' +  CONVERT(nvarchar(10), @CategoryID)
			update CategoryModel
			set [ADNCode] = replace([ADNCode],@ADNCodeOld,@ADNCodeNew)
			where CategoryID in (select CategoryID from CategoryModel where ADNCode like @ADNCodeOld+'%')
			
		commit tran UpdateCategory
			
		return 1
	end try
	begin catch
		rollback tran UpdateCategory
		return 0
	end catch
end

GO
/****** Object:  StoredProcedure [dbo].[usp_BaoCaoDoanhThuTheoNhanVien]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nguyễn Văn Phong
-- Create date: 23/9/2016
-- Description:	Báo cáo doanh thu bán hàng theo nhân viên
-- Edit: Linh - 22/1/2018
-- =============================================
CREATE PROCEDURE [dbo].[usp_BaoCaoDoanhThuTheoNhanVien]
@StoreId int,
@StaffId int = null,
@CashierUserId int = NULL ,
@CurrentSaleId int = NULL , --Nếu chọn xem tất cả -> lấy những record của n.v này và n.v nó quản lý.
@FromDate date  ,
@ToDate date 
AS
BEGIN
	
	SET NOCOUNT ON;
	--B1. Select ra những đơn hàng thoả điều kiện
	CREATE TABLE #tempData (
		CreatedDate DATE,
		TotalPrice decimal,
		AdditionalPrice decimal,
		TotalBillDiscount decimal,
		TotalVAT decimal,
		Revenue decimal,
		SumCOGSOfOrderDetail decimal,
		Tip decimal,
		Commission decimal,
		ProductCommission decimal,
		HolidayCommission decimal,
		Profit decimal
	)
	insert into #tempData(
							CreatedDate,--Ngày
							TotalPrice ,--Tổng tiền hóa đơn (chưa trừ giảm giá)
							AdditionalPrice, -- Phụ thu
							TotalBillDiscount ,-- Giảm giá
							TotalVAT ,-- VAT
							Revenue ,-- Doanh thu 
							SumCOGSOfOrderDetail ,-- Vốn
							Tip, -- Tiền boa
							Commission, -- Hoa hồng cho thợ phụ (dịch vụ)
							ProductCommission, -- Hoa hồng sản phẩm
							HolidayCommission, -- Hoa hồng ngày lễ
							Profit -- Lợi nhuận
						 )
	--Doanh thu dich vu
	select CAST(p.CashierDate AS DATE ) as CreatedDate,
			   p.SumPriceOfOrderDetail, -- tổng giá đơn hàng
			   ISNULL(p.AdditionalPrice,0) as AdditionalPrice, -- phụ thu
			   ISNULL(p.TotalBillDiscount,0)as TotalBillDiscount, -- tổng giảm giá
			   0 as TotalVAT, -- Tổng VAT
			   p.SumPriceOfOrderDetail + ISNULL(p.AdditionalPrice,0) - ISNULL(p.TotalBillDiscount,0) - 0 AS Revenue,-- Doanh thu 
			   ISNULL(p.SumCOGSOfOrderDetail,0) as COGS,-- tổng giá vốn
			   ISNULL(p.Tip,0) as Tip,-- Tiền boa
			   ISNULL(p.Commission,0) as Commission,-- Hoa hồng cho thợ phụ (dịch vụ)
			   ISNULL(p.ProductCommission,0) as ProductCommission,-- Hoa hồng sản phẩm
			   ISNULL(p.HolidayCommission,0) as HolidayCommission,-- Hoa hồng ngày lễ
			   p.SumPriceOfOrderDetail + ISNULL(p.AdditionalPrice,0) - ISNULL(p.TotalBillDiscount,0) - ISNULL(p.SumCOGSOfOrderDetail,0)  - ISNULL(p.Tip,0)  - ISNULL(p.Commission,0) - ISNULL(p.ProductCommission,0) - ISNULL(p.HolidayCommission,0) as Profit  -- lợi nhuận
	from Daily_ChicCut_OrderModel p
	where OrderStatusId = 3 -- da thanh toan
		  --and p.StoreId = @StoreId 
		  and ((@CashierUserId is null) or ( p.CashierUserId = @CashierUserId))
		  and ((@StaffId is null) or ( p.StaffId = @StaffId))
		  and @FromDate <= CAST(p.CashierDate as date) and CAST(p.CashierDate as date) <= @ToDate
	Order By CashierDate desc 
   
   --select * from  #tempData 
    -- B2 : tính tổng gom nhóm theo Ngay
	SELECT   REPLACE(STR(CAST(DAY(p.CreatedDate) AS nvarchar(50) ), 2), SPACE(1), '0')  +'/'+ REPLACE(STR(CAST(MONTH(p.CreatedDate) AS nvarchar(50) ), 2), SPACE(1), '0')   + '/' + CAST(YEAR(p.CreatedDate) AS nvarchar(50) )  as ViewTime,
		   CAST(p.CreatedDate AS DATE ),
		   SUM(p.TotalPrice) as TotalPrice,
		   SUM(ISNULL(p.AdditionalPrice,0)) as AdditionalPrice,
		   SUM(p.TotalBillDiscount) as TotalBillDiscount,
		   SUM(p.TotalVAT) as TotalVAT,
		   SUM(p.Revenue) as Revenue,
		   SUM(ISNULL(p.SumCOGSOfOrderDetail,0)) as COGS,
		   SUM(ISNULL(p.Tip,0)) as Tip,
		   SUM(ISNULL(p.Commission,0)) as Commission,
		   SUM(ISNULL(p.ProductCommission,0)) as ProductCommission,
		   SUM(ISNULL(p.HolidayCommission,0)) as HolidayCommission,
		   SUM(p.Profit) as Profit 
	FROM #tempData p
	GROUP BY  CAST(p.CreatedDate AS DATE ), REPLACE(STR(CAST(DAY(p.CreatedDate) AS nvarchar(50) ), 2), SPACE(1), '0')  +'/'+ REPLACE(STR(CAST(MONTH(p.CreatedDate) AS nvarchar(50) ), 2), SPACE(1), '0')   + '/' + CAST(YEAR(p.CreatedDate) AS nvarchar(50) ) 
	ORDER BY  CAST(p.CreatedDate AS DATE ) , REPLACE(STR(CAST(DAY(p.CreatedDate) AS nvarchar(50) ), 2), SPACE(1), '0')  +'/'+ REPLACE(STR(CAST(MONTH(p.CreatedDate) AS nvarchar(50) ), 2), SPACE(1), '0')   + '/' + CAST(YEAR(p.CreatedDate) AS nvarchar(50) ) 
END 
-- exec usp_BaoCaoDoanhThuTheoNhanVien @StoreId=1000,@StaffId=default,@CashierUserId=default,@CurrentSaleId=10001,@FromDate='2018-01-22 00:00:00',@ToDate='2018-01-22 00:00:00'
GO
/****** Object:  StoredProcedure [dbo].[usp_BaoCaoDoanhThuTheoQuy]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nguyễn Văn Phong
-- Create date: 23/9/2016
-- Description:	Báo cáo doanh thu bán hàng theo nhân viên
-- =============================================
CREATE PROCEDURE [dbo].[usp_BaoCaoDoanhThuTheoQuy]
@StoreId int,
@EmployeeId int = null,
@SaleId int = NULL ,
@CurrentSaleId int = NULL , --Nếu chọn xem tất cả -> lấy những record của n.v này và n.v nó quản lý.
@FromQuater int,
@FromYearQuater int,
@ToQuater int,
@ToYearQuater int
AS
BEGIN
	
	SET NOCOUNT ON;
	IF exists (select NAME from sysobjects where NAME = '#tempData')
	BEGIN
		drop table #tempData
	END
	--B1. Select ra những đơn hàng thoả điều kiện
	CREATE TABLE #tempData (
		CreatedDate DATE,
		TotalPrice decimal,
		TotalBillDiscount decimal,
		TotalVAT decimal,
		Revenue decimal,
		SumCOGSOfOrderDetail decimal,
		Profit decimal
	)
	insert into #tempData(
							CreatedDate,
							TotalPrice ,
							TotalBillDiscount ,
							TotalVAT ,
							Revenue ,
							SumCOGSOfOrderDetail ,
							Profit 
						 )
	   SELECT  CAST(p.CreatedDate AS DATE ) as CreatedDate,
			   p.TotalPrice,
			   ISNULL(p.TotalBillDiscount,0),
			   ISNULL(p.TotalVAT,0),
			   p.TotalPrice - ISNULL(p.TotalBillDiscount,0) - ISNULL(p.TotalVAT,0) AS Revenue,
			   ISNULL(p.SumCOGSOfOrderDetail,0) COGS,
			   p.TotalPrice - ISNULL(p.TotalBillDiscount,0) - ISNULL(p.TotalVAT,0) - ISNULL(p.SumCOGSOfOrderDetail,0) as Profit 
		FROM OrderMasterModel p
		inner join EmployeeModel emp on p.SaleId = emp.EmployeeId
		WHERE p.Actived = 1 
			  and p.StoreId = @StoreId 
			  and ((@EmployeeId is null) or (p.CreatedEmployeeId = @EmployeeId))
			 -- and ((@SaleId is null) or ( p.SaleId = @SaleId))
			  and ( ((@SaleId is null) and (emp.EmployeeId = @CurrentSaleId or emp.ParentId =  @CurrentSaleId) )or ( p.SaleId = @SaleId))
			  and ( ( YEAR(p.CreatedDate ) = @FromYearQuater and  DATEPART(QUARTER, p.CreatedDate) >= @FromQuater ) or  ((YEAR(p.CreatedDate ) > @FromYearQuater)) )
				       and ( (YEAR(p.CreatedDate ) = @ToYearQuater and  DATEPART(QUARTER, p.CreatedDate) <= @ToQuater ) or  ((YEAR(p.CreatedDate ) < @ToYearQuater)) )
     order by p.OrderId  
-- B2 : tính tổng gom nhóm theo Quý ../2016
	SELECT   ( N'Quý ' + CAST(DATEPART(QUARTER, p.CreatedDate) AS nvarchar(10) ) + ' / ' + CAST(YEAR(p.CreatedDate) AS nvarchar(10) ) ) AS ViewTime,
		  -- CAST(p.CreatedDate AS DATE ),
		   SUM(p.TotalPrice) as TotalPrice,
		   SUM(p.TotalBillDiscount) as TotalBillDiscount,
		   SUM(p.TotalVAT) as TotalVAT,
		   SUM(p.Revenue) as Revenue,
		   SUM(ISNULL(p.SumCOGSOfOrderDetail,0)) as COGS,
		   SUM(p.Profit) as Profit 
	FROM #tempData p
	GROUP BY ( N'Quý ' + CAST(DATEPART(QUARTER, p.CreatedDate) AS nvarchar(10) ) + ' / ' + CAST(YEAR(p.CreatedDate) AS nvarchar(10) ) )
	
END 

GO
/****** Object:  StoredProcedure [dbo].[usp_BaoCaoDoanhThuTheoThang]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nguyễn Văn Phong
-- Create date: 23/9/2016
-- Description:	Báo cáo doanh thu bán hàng theo tháng
-- =============================================
CREATE PROCEDURE [dbo].[usp_BaoCaoDoanhThuTheoThang]
@StoreId int,
@EmployeeId int = null,
@SaleId int = NULL ,
@CurrentSaleId int = NULL , --Nếu chọn xem tất cả -> lấy những record của n.v này và n.v nó quản lý.
@FromMonth int,
@FromYearMonth int,
@ToMonth int,
@ToYearMonth int
AS
BEGIN
	
	SET NOCOUNT ON;
	IF exists (select NAME from sysobjects where NAME = '#tempData')
	BEGIN
		drop table #tempData
	END
	--B1. Select ra những đơn hàng thoả điều kiện
	CREATE TABLE #tempData (
		CreatedDate DATE,
		TotalPrice decimal,
		TotalBillDiscount decimal,
		TotalVAT decimal,
		Revenue decimal,
		SumCOGSOfOrderDetail decimal,
		Profit decimal
	)
	insert into #tempData(
							CreatedDate,
							TotalPrice ,
							TotalBillDiscount ,
							TotalVAT ,
							Revenue ,
							SumCOGSOfOrderDetail ,
							Profit 
						 )
	   SELECT  CAST(p.CreatedDate AS DATE ) as CreatedDate,
			   p.TotalPrice,
			   ISNULL(p.TotalBillDiscount,0),
			   ISNULL(p.TotalVAT,0),
			   p.TotalPrice - ISNULL(p.TotalBillDiscount,0) - ISNULL(p.TotalVAT,0) AS Revenue,
			   ISNULL(p.SumCOGSOfOrderDetail,0) COGS,
			   p.TotalPrice - ISNULL(p.TotalBillDiscount,0) - ISNULL(p.TotalVAT,0) - ISNULL(p.SumCOGSOfOrderDetail,0) as Profit 
		FROM OrderMasterModel p
		inner join EmployeeModel emp on p.SaleId = emp.EmployeeId
		WHERE p.Actived = 1 
			  and p.StoreId = @StoreId 
			  and ((@EmployeeId is null) or (p.CreatedEmployeeId = @EmployeeId))
			 -- and ((@SaleId is null) or ( p.SaleId = @SaleId) )
			 and ( ((@SaleId is null) and (emp.EmployeeId = @CurrentSaleId or emp.ParentId =  @CurrentSaleId) )or ( p.SaleId = @SaleId))

			   -- From : + Bằng năm : Xét tháng
				--       + Năm lớn hơn @FromYearMonth
				-- To : + Bằng năm : Xét tháng
				--      + Năm nhỏ hơn
			  and (  (( YEAR(p.CreatedDate ) = @FromYearMonth) and  (Month(p.CreatedDate) >= @FromMonth ) ) or  (YEAR(p.CreatedDate ) > @FromYearMonth) )
				       and ( (YEAR(p.CreatedDate ) = @ToYearMonth and  Month(p.CreatedDate) <= @ToMonth ) or  ((YEAR(p.CreatedDate ) < @ToYearMonth)) )
--select * from #tempData
-- B2 : tính tổng gom nhóm theo THÁNG ../2016 
	SELECT    ( N'Tháng ' + REPLACE(STR(CAST(MONTH(p.CreatedDate) AS nvarchar(50) ), 2), SPACE(1), '0') + ' / ' + CAST(YEAR(p.CreatedDate) AS nvarchar(10) ) ) AS ViewTime,
		  -- CAST(p.CreatedDate AS DATE ),
		   SUM(p.TotalPrice) as TotalPrice,
		   SUM(p.TotalBillDiscount) as TotalBillDiscount,
		   SUM(p.TotalVAT) as TotalVAT,
		   SUM(p.Revenue) as Revenue,
		   SUM(ISNULL(p.SumCOGSOfOrderDetail,0)) as COGS,
		   SUM(p.Profit) as Profit 
	FROM #tempData p
	GROUP BY  ( N'Tháng ' + REPLACE(STR(CAST(MONTH(p.CreatedDate) AS nvarchar(50) ), 2), SPACE(1), '0') + ' / ' + CAST(YEAR(p.CreatedDate) AS nvarchar(10) ) )
	ORDER BY ( N'Tháng ' + REPLACE(STR(CAST(MONTH(p.CreatedDate) AS nvarchar(50) ), 2), SPACE(1), '0') + ' / ' + CAST(YEAR(p.CreatedDate) AS nvarchar(10) ) )
END 

GO
/****** Object:  StoredProcedure [dbo].[usp_BaoCaoNgay]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nguyễn Văn Phong
-- Create date: 23/9/2016
-- Description:	Báo cáo doanh thu bán hàng theo nhân viên
-- Edit: Linh 26/12/2017
-- =============================================
CREATE PROCEDURE [dbo].[usp_BaoCaoNgay]
@StoreId int,
@PaymentMethodId int,
@FromDate datetime,
@ToDate datetime
AS
BEGIN
	
	SET NOCOUNT ON;
	IF exists (select NAME from sysobjects where NAME = '#BaoCaoNgaytempData')
	BEGIN
		drop table #BaoCaoNgaytempData
	END
	CREATE TABLE #BaoCaoNgaytempData (
		ServiceName nvarchar(500),
		HairTypeName nvarchar(100),
		--Phương thức thanh toán
		PaymentMethodName nvarchar(100),
		Price decimal(18,2),
		Qty decimal(18,2),
		UnitPrice decimal(18,2)

	)
	
	--B1. Select ra những đơn hàng thoả điều kiện
	--Dich vu cat toc
	insert into #BaoCaoNgaytempData(ServiceName,HairTypeName, PaymentMethodName, Price,Qty,UnitPrice)
	select s.ServiceName,'' as HairTypeName, p.PaymentMethodName, od.Price,od.Qty,od.UnitPrice
	from Daily_ChicCut_OrderModel o
	inner join Daily_ChicCut_OrderDetailModel od on o.OrderId = od.OrderId
	inner join Master_ChicCut_ServiceModel s on od.ServiceId = s.ServiceId
	inner join Master_ChicCut_HairTypeModel h on s.HairTypeId = h.HairTypeId
	--Phương thức thanh toán
	inner join PaymentMethodModel p on o.PaymentMethodId = p.PaymentMethodId
	where @FromDate <= o.CashierDate and o.CashierDate <= @ToDate and s.ServiceCategoryId = 10 and o.OrderStatusId <> 4 
	and (@PaymentMethodId is null OR p.PaymentMethodId = @PaymentMethodId)

	--Dich vu
	insert into #BaoCaoNgaytempData(ServiceName,HairTypeName, PaymentMethodName, Price,Qty,UnitPrice)
	select s.ServiceName,h.HairTypeName, p.PaymentMethodName, od.Price,od.Qty,od.UnitPrice
	from Daily_ChicCut_OrderModel o
	inner join Daily_ChicCut_OrderDetailModel od on o.OrderId = od.OrderId
	inner join Master_ChicCut_ServiceModel s on od.ServiceId = s.ServiceId
	inner join Master_ChicCut_HairTypeModel h on s.HairTypeId = h.HairTypeId
	--Phương thức thanh toán
	inner join PaymentMethodModel p on o.PaymentMethodId = p.PaymentMethodId
	where @FromDate <= o.CashierDate and o.CashierDate <= @ToDate and s.ServiceCategoryId <> 10  and o.OrderStatusId <> 4 
	and (@PaymentMethodId is null OR p.PaymentMethodId = @PaymentMethodId)

	--San pham
	insert into #BaoCaoNgaytempData(ServiceName,HairTypeName,PaymentMethodName,Price,Qty,UnitPrice)
	SELECT p.ProductName
	   , N'Sản Phẩm' as HairTypeName
	   , pm.PaymentMethodName
	   ,pd.[Price]
	   ,pd.[Qty]
	   ,pd.[UnitPrice]
	FROM Daily_ChicCut_OrderModel o
	inner join [dbo].[Daily_ChicCut_OrderProductDetailModel] pd on o.OrderId = pd.OrderId
	inner join ProductModel p on pd.ProductId = p.ProductId
	--Phương thức thanh toán
	inner join PaymentMethodModel pm on o.PaymentMethodId = pm.PaymentMethodId
	where @FromDate <= o.CashierDate and o.CashierDate <= @ToDate  and o.OrderStatusId <> 4 
	and (@PaymentMethodId is null OR pm.PaymentMethodId = @PaymentMethodId)

	--Giam gia
	insert into #BaoCaoNgaytempData(ServiceName,HairTypeName, PaymentMethodName, Price,Qty,UnitPrice)
	select N'Z-Giảm giá' as ServiceName,'' as HairTypeName, '' as PaymentMethodName, 0 as Price,0 as Qty, (0 - o.TotalBillDiscount) as UnitPrice
	from Daily_ChicCut_OrderModel o
	--Phương thức thanh toán
	inner join PaymentMethodModel pm on o.PaymentMethodId = pm.PaymentMethodId
	where @FromDate <= o.CashierDate and o.CashierDate <= @ToDate  and o.OrderStatusId <> 4 
	and (@PaymentMethodId is null OR pm.PaymentMethodId = @PaymentMethodId)



	select ServiceName, HairTypeName, PaymentMethodName, Price, sum(Qty) as Qty, isnull(sum(UnitPrice),0) as UnitPrice
	from #BaoCaoNgaytempData
	group by  ServiceName, HairTypeName, PaymentMethodName, Price
	order by ServiceName
END 
--exec sp_executesql N'usp_BaoCaoNgay @StoreId, @PaymentMethodId, @FromDate,@ToDate',N'@StoreId int,@PaymentMethodId nvarchar(4000),@FromDate datetime,@ToDate datetime',@StoreId=1000,@PaymentMethodId=null,@FromDate='2017-12-26 00:00:00',@ToDate='2017-12-26 23:59:59'

GO
/****** Object:  StoredProcedure [dbo].[usp_BaoCaoThuChi]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Linh>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_BaoCaoThuChi]
	@StoreId INT,
	@FromDate DATETIME = null,
	@ToDate DATETIME = null
AS
BEGIN
	SET NOCOUNT ON;
    IF exists (SELECT NAME FROM sysobjects WHERE NAME = '#HeaderInfomation')--Chỉ chạy trong Store
    BEGIN
		DROP TABLE #HeaderInfomation
    END
    
    IF exists (SELECT NAME FROM sysobjects WHERE NAME = '#Detail')
    BEGIN
		DROP TABLE #Detail
    END
    
	--Bước 1: Tạo bảng ảo
	CREATE TABLE #HeaderInfomation( 
	    StoreName NVARCHAR(500),
		[Address] NVARCHAR(500),
		FromDate DATETIME,
		ToDate DATETIME
	)
	CREATE TABLE #Detail(
		CreatedDate DATE,
		GrossRevenue DECIMAL,
		Import DECIMAL,
		--GrossProfit DECIMAL
	)	
	CREATE TABLE #DoanhThu(
		CashierDate DATE,
		Revenue DECIMAL,
	)	
	CREATE TABLE #NhapHang(
		CreatedDate DATE,
		TotalPrice DECIMAL,
	)
	--Bước 2: Xử lý Insert cơ sở dữ liệu
	--2.1: Insert header
	INSERT INTO #HeaderInfomation
	(
		StoreName, 
		[Address],
		FromDate,
		ToDate
	)
	SELECT
		s.StoreName, 
		s.[Address],
		@FromDate,
		@ToDate
	FROM StoreModel s
	WHERE s.StoreId = @StoreId

	----2.2: Insert detail
	INSERT INTO #Detail(
							CreatedDate
						 )
	--Ngày: select các ngày trong tháng
	SELECT [Date] = DATEADD(Day, Number, @FromDate) 
	FROM  master..spt_values 
	WHERE Type='P'
		AND DATEADD(day, Number, @FromDate) <= @ToDate
   
	--UPDATE #Detail
	--Doanh thu
	INSERT INTO #DoanhThu(
							CashierDate,
							Revenue
						 )
	select CAST(CashierDate as date) as CashierDate, SUM(p.SumPriceOfOrderDetail - ISNULL(p.TotalBillDiscount,0) - 0) AS Revenue
		from Daily_ChicCut_OrderModel p
		where OrderStatusId = 3 -- da thanh toan
		and @FromDate <= CashierDate 
		and CashierDate <= @ToDate
		group by CAST(CashierDate as date)

	UPDATE #Detail
	SET GrossRevenue = 
	ISNULL((
		select dt.Revenue
		from #DoanhThu dt
		where dt.CashierDate = #Detail.CreatedDate
	),0)

	--Nhập hàng
	INSERT INTO #NhapHang(
							CreatedDate,
							TotalPrice
						 )
	select CAST(CreatedDate as date) as CreatedDate, SUM(imp.TotalPrice) AS TotalPrice
		from ImportMasterModel imp
		where imp.Actived = 1
		and @FromDate <= CreatedDate 
		and CreatedDate <= @ToDate
		group by CAST(CreatedDate as date)

	UPDATE #Detail
	SET Import = 
	ISNULL((
		select nh.TotalPrice
		from #NhapHang nh
		where nh.CreatedDate = #Detail.CreatedDate
	),0)
   
	--Bước cuối: Select kết quả
	--SELECT 
	--	CreatedDate,
	--	TotalPrice
	--FROM #NhapHang

	--SELECT 
	--	CashierDate,
	--	Revenue
	--FROM #DoanhThu

	SELECT 
		StoreName,
		[Address],
		FromDate,
		ToDate
	FROM  #HeaderInfomation
	
	SELECT 
		CreatedDate,
		GrossRevenue,
		Import
		--GrossProfit
	FROM  #Detail
END

-- exec usp_BaoCaoThuChi @FromDate='2017-11-01 00:00:00',@ToDate='2017-11-30 23:59:59',@StoreId=1000
GO
/****** Object:  StoredProcedure [dbo].[usp_BaoCaoThuChiTienMatTheoNgay]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nguyễn Văn Phong
-- Create date: 29/9/2016
-- Description:	Báo cáo thu - chi theo ngay
-- =============================================
CREATE PROCEDURE [dbo].[usp_BaoCaoThuChiTienMatTheoNgay]
@StoreId int,
@EmployeeId int = null, 
@CurrentEmployeeId int = null, --Nếu chọn xem tất cả -> lấy những record của n.v này và n.v nó quản lý.
@FromDate date  ,
@ToDate date 
AS
BEGIN
	
	SET NOCOUNT ON;
		IF exists (select NAME from sysobjects where NAME = '#tempData')
		BEGIN
			drop table #tempData
		END
		--B1. Select ra những record thoả điều kiện
		CREATE TABLE #tempData (
			CreatedDate DATE,
			Amount decimal,
			TransactionTypeCode nvarchar(50)
	)
	insert into #tempData (
			CreatedDate ,
			Amount ,
			TransactionTypeCode)
    select p.CreateDate, p.Amount, p.TransactionTypeCode
	from AM_TransactionModel as p
	inner join EmployeeModel emp on p.CreateEmpId = emp.EmployeeId

	where @FromDate <= CAST(p.CreateDate AS DATE) AND CAST(p.CreateDate AS DATE) <= @ToDate
		  AND p.StoreId = @StoreId
		 -- AND ((@EmployeeId is null) or (p.CreateEmpId = @EmployeeId))
		  and ( ((@EmployeeId is null) and (emp.EmployeeId = @CurrentEmployeeId or emp.ParentId =  @CurrentEmployeeId) )or ( p.CreateEmpId = @EmployeeId))
		  --AND p.CreateEmpId = @EmployeeId
	ORDER BY cast(p.CreateDate as date)
   --select * from #tempData

   --Bước 2 : Select kết quả
   SELECT CAST(DAY(p.CreatedDate) AS nvarchar(50) ) +'/'+ CAST(MONTH(p.CreatedDate) AS nvarchar(50) ) + '/' + CAST(YEAR(p.CreatedDate) AS nvarchar(50) )  as ViewTime,
		  SUM(CASE WHEN pp.isImport = 1 THEN ISNULL(p.Amount,0) ELSE 0 END) as TotalRevenue,
		  SUM(CASE WHEN pp.isImport = 0 THEN ISNULL(p.Amount,0) ELSE 0 END) as TotalExpenditure,
		  SUM(CASE WHEN pp.isImport = 1 THEN ISNULL(p.Amount,0) ELSE 0 END) -  SUM(CASE WHEN pp.isImport = 0 THEN ISNULL(p.Amount,0) ELSE 0 END) as TotalDifference
   FROM #tempData AS p
   inner join AM_TransactionTypeModel as pp on p.TransactionTypeCode = pp.TransactionTypeCode
   GROUP BY CAST(DAY(p.CreatedDate) AS nvarchar(50) ) +'/'+ CAST(MONTH(p.CreatedDate) AS nvarchar(50) ) + '/' + CAST(YEAR(p.CreatedDate) AS nvarchar(50) ) ,cast(p.CreatedDate as date)
  -- ORDER BY cast(p.CreatedDate as date)

END 
--EXEC usp_BaoCaoThuChiTienMatTheoNgay 1000,10001,'2016-8-28','2016-8-28'
--SELECT padded_id = REPLACE(STR(1, 4), SPACE(1), '0') 


GO
/****** Object:  StoredProcedure [dbo].[usp_BaoCaoThuChiTienMatTheoQuy]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nguyễn Văn Phong
-- Create date: 30/9/2016
-- Description:	Báo cáo thu - chi theo Quý
-- =============================================
CREATE PROCEDURE [dbo].[usp_BaoCaoThuChiTienMatTheoQuy]
@StoreId int,
@EmployeeId int = null,
@CurrentEmployeeId int = null, --Nếu chọn xem tất cả -> lấy những record của n.v này và n.v nó quản lý.
@FromQuater int,
@FromYearQuater int,
@ToQuater int,
@ToYearQuater int
AS
BEGIN
	
	SET NOCOUNT ON;
		IF exists (select NAME from sysobjects where NAME = '#tempData')
		BEGIN
			drop table #tempData
		END
		--B1. Select ra những record thoả điều kiện
		CREATE TABLE #tempData (
			CreatedDate DATE,
			Amount decimal,
			TransactionTypeCode nvarchar(50)
	)
	insert into #tempData (
			CreatedDate ,
			Amount ,
			TransactionTypeCode)
    select p.CreateDate, p.Amount, p.TransactionTypeCode
	from AM_TransactionModel as p
	inner join EmployeeModel emp on p.CreateEmpId = emp.EmployeeId

	where  ( ( YEAR(p.CreateDate ) = @FromYearQuater and  DATEPART(QUARTER, p.CreateDate) >= @FromQuater ) or  ((YEAR(p.CreateDate ) > @FromYearQuater)) )
				       and ( (YEAR(p.CreateDate ) = @ToYearQuater and  DATEPART(QUARTER, p.CreateDate) <= @ToQuater ) or  ((YEAR(p.CreateDate ) < @ToYearQuater)) )
		  AND p.StoreId = @StoreId
		--  AND ((@EmployeeId is null) or (p.CreateEmpId = @EmployeeId))
		 and ( ((@EmployeeId is null) and (emp.EmployeeId = @CurrentEmployeeId or emp.ParentId =  @CurrentEmployeeId) )or ( p.CreateEmpId = @EmployeeId))

		 -- AND p.CreateEmpId = @EmployeeId
    ORDER BY cast(p.CreateDate as date)
 --  select * from #tempData
   --Bước 2 : Select kết quả
   SELECT ( N'Quý ' + CAST(DATEPART(QUARTER, p.CreatedDate) AS nvarchar(10) ) + ' / ' + CAST(YEAR(p.CreatedDate) AS nvarchar(10) ) ) AS ViewTime,
		  SUM(CASE WHEN pp.isImport = 1 THEN ISNULL(p.Amount,0) ELSE 0 END) as TotalRevenue,
		  SUM(CASE WHEN pp.isImport = 0 THEN ISNULL(p.Amount,0) ELSE 0 END) as TotalExpenditure,
		  SUM(CASE WHEN pp.isImport = 1 THEN ISNULL(p.Amount,0) ELSE 0 END) -  SUM(CASE WHEN pp.isImport = 0 THEN ISNULL(p.Amount,0) ELSE 0 END) as TotalDifference
   FROM #tempData AS p
   inner join AM_TransactionTypeModel as pp on p.TransactionTypeCode = pp.TransactionTypeCode
   GROUP BY ( N'Quý ' + CAST(DATEPART(QUARTER, p.CreatedDate) AS nvarchar(10) ) + ' / ' + CAST(YEAR(p.CreatedDate) AS nvarchar(10) ) ) 
  -- ORDER BY cast(p.CreatedDate as date)

END 
--exec usp_BaoCaoThuChiTienMatTheoQuy 1000,10001,1,2016,3,2016
--SELECT padded_id = REPLACE(STR(1, 4), SPACE(1), '0') => Padleft in sql


GO
/****** Object:  StoredProcedure [dbo].[usp_BaoCaoThuChiTienMatTheoThang]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nguyễn Văn Phong
-- Create date: 30/9/2016
-- Description:	Báo cáo thu - chi theo Tháng
-- =============================================
CREATE PROCEDURE [dbo].[usp_BaoCaoThuChiTienMatTheoThang]
@StoreId int,
@EmployeeId int = null,
@CurrentEmployeeId int = null, --Nếu chọn xem tất cả -> lấy những record của n.v này và n.v nó quản lý.
@FromMonth int,
@FromYearMonth int,
@ToMonth int,
@ToYearMonth int
AS
BEGIN
	
	SET NOCOUNT ON;
		IF exists (select NAME from sysobjects where NAME = '#tempData')
		BEGIN
			drop table #tempData
		END
		--B1. Select ra những record thoả điều kiện
		CREATE TABLE #tempData (
			CreatedDate DATE,
			Amount decimal,
			TransactionTypeCode nvarchar(50)
	)
	insert into #tempData (
			CreatedDate ,
			Amount ,
			TransactionTypeCode)
    select p.CreateDate, p.Amount, p.TransactionTypeCode
	from AM_TransactionModel as p
	inner join EmployeeModel emp on p.CreateEmpId = emp.EmployeeId

	where  (  (( YEAR(p.CreateDate ) = @FromYearMonth) and  (Month(p.CreateDate) >= @FromMonth ) ) or  (YEAR(p.CreateDate ) > @FromYearMonth) )
				       and ( (YEAR(p.CreateDate ) = @ToYearMonth and  Month(p.CreateDate) <= @ToMonth ) or  ((YEAR(p.CreateDate ) < @ToYearMonth)) )
		  AND p.StoreId = @StoreId
		 -- AND ((@EmployeeId is null) or (p.CreateEmpId = @EmployeeId))
		  and ( ((@EmployeeId is null) and (emp.EmployeeId = @CurrentEmployeeId or emp.ParentId =  @CurrentEmployeeId) )or ( p.CreateEmpId = @EmployeeId))
		  --AND p.CreateEmpId = @EmployeeId
    ORDER BY cast(p.CreateDate as date)
 --  select * from #tempData
   --Bước 2 : Select kết quả
   SELECT  ( N'Tháng ' + REPLACE(STR(CAST(MONTH(p.CreatedDate) AS nvarchar(50) ), 2), SPACE(1), '0') + ' / ' + CAST(YEAR(p.CreatedDate) AS nvarchar(10) ) ) AS ViewTime,
		  SUM(CASE WHEN pp.isImport = 1 THEN ISNULL(p.Amount,0) ELSE 0 END) as TotalRevenue,
		  SUM(CASE WHEN pp.isImport = 0 THEN ISNULL(p.Amount,0) ELSE 0 END) as TotalExpenditure,
		  SUM(CASE WHEN pp.isImport = 1 THEN ISNULL(p.Amount,0) ELSE 0 END) -  SUM(CASE WHEN pp.isImport = 0 THEN ISNULL(p.Amount,0) ELSE 0 END) as TotalDifference
   FROM #tempData AS p
   inner join AM_TransactionTypeModel as pp on p.TransactionTypeCode = pp.TransactionTypeCode
   GROUP BY  ( N'Tháng ' + REPLACE(STR(CAST(MONTH(p.CreatedDate) AS nvarchar(50) ), 2), SPACE(1), '0') + ' / ' + CAST(YEAR(p.CreatedDate) AS nvarchar(10) ) ) 
   ORDER BY ( N'Tháng ' + REPLACE(STR(CAST(MONTH(p.CreatedDate) AS nvarchar(50) ), 2), SPACE(1), '0') + ' / ' + CAST(YEAR(p.CreatedDate) AS nvarchar(10) ) )

END 
--exec usp_BaoCaoThuChiTienMatTheoQuy 1000,10001,1,2016,3,2016
--SELECT padded_id = REPLACE(STR(1, 4), SPACE(1), '0') => Padleft in sql


GO
/****** Object:  StoredProcedure [dbo].[usp_Baocaotonkho]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Linh>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROC [dbo].[usp_Baocaotonkho]
	@StoreId INT,
	@WarehouseId INT = null,
	@CategoryId INT = null,
	@Date DATETIME = null
AS
BEGIN
	SET NOCOUNT ON;
    IF exists (SELECT NAME FROM sysobjects WHERE NAME = '#HeaderInfomation')--Chỉ chạy trong Store
    BEGIN
		DROP TABLE #HeaderInfomation
    END
    
    IF exists (SELECT NAME FROM sysobjects WHERE NAME = '#Detail')
    BEGIN
		DROP TABLE #Detail
    END
    
	--Bước 1: Tạo bảng ảo
	CREATE TABLE #HeaderInfomation( 
	    StoreName NVARCHAR(500),
		WarehouseName NVARCHAR(500),
		CreatedDate DATETIME
	)
	CREATE TABLE #Detail(
		STT INT,
		ProductId INT,
		ProductCode NVARCHAR(500),
		ProductName NVARCHAR(500),
		Specifications NVARCHAR(500),
		ImportPrice DECIMAL(18,2),
		Price DECIMAL(18,2),
		InventoryQty DECIMAL(18,2),
	)	

	--Bước 2: Xử lý Insert cơ sở dữ liệu

	--INSERT INTO #HeaderInfomation(StoreName, WarehouseName, CreatedDate)
	--VALUES ('Chic Cut Salon', N'489 Hồng Bàng', @Date)

	--2.1: Insert header
	INSERT INTO #HeaderInfomation
	(
		StoreName, 
		WarehouseName, 
		CreatedDate
	)
	SELECT
		s.StoreName, 
		w.WarehouseName, 
		@Date
	FROM StoreModel s, WarehouseModel w
	WHERE s.StoreId = @StoreId

	--INSERT INTO #Detail(STT, ProductName, ProductCode, InventoryQty)
	--VALUES(1, N'Thuốc nhuộm', 'WK_TN9/3', 50)

	--INSERT INTO #Detail(STT, ProductName, ProductCode, InventoryQty)
	--VALUES(2, N'Thuốc nhuộm', 'WCL_TN9/16', 50)

	--2.2: Insert detail
	--TH1: Tất cả sản phẩm -> CategoryId = 2
	IF @CategoryId = 2
	BEGIN
		INSERT INTO #Detail
		(
			STT,
			ProductId,
			ProductCode, 
			ProductName,
			Specifications,
			ImportPrice,
			Price,
			InventoryQty
		)
		SELECT 
			ROW_NUMBER()Over(Order by p.ProductId),
			P.ProductId,
			p.ProductCode,
			p.ProductName,
			p.Specifications,
			p.ImportPrice, 
			pp.Price,
			0
		FROM ProductModel p
			LEFT JOIN ProductPriceModel pp ON p.ProductId = pp.ProductId
	END
	--TH2: HIển thị sản phẩm theo danh mục
	ELSE
	BEGIN
		INSERT INTO #Detail
		(
			STT,
			ProductId,
			ProductCode, 
			ProductName,
			Specifications,
			ImportPrice,
			Price
		)
		SELECT 
			ROW_NUMBER()Over(Order by p.ProductId),
			P.ProductId,
			p.ProductCode,
			p.ProductName,
			p.Specifications,
			p.ImportPrice, 
			pp.Price
		FROM ProductModel p
			LEFT JOIN ProductPriceModel pp ON p.ProductId = pp.ProductId
			LEFT JOIN CategoryModel c ON p.CategoryId = c.CategoryId
		WHERE p.CategoryId = @CategoryId
	END
		 
	-- 2.3: Update dữ liệu tồn kho
	--Update detail
	UPDATE #Detail
	SET InventoryQty = 
	Isnull((
		SELECT TOP 1 EndInventoryQty
		FROM InventoryDetailModel ivd
			INNER JOIN InventoryMasterModel ivm on ivm.InventoryMasterId = ivd.InventoryMasterId
		WHERE ivm.Actived = 1
			AND ivd.ProductId = #Detail.ProductId
			AND ivm.CreatedDate <= @Date
		ORDER BY CreatedDate desc
	),0)
	
	--Bước cuối: Select kết quả
	SELECT 
		StoreName, 
		WarehouseName, 
		CreatedDate
	FROM  #HeaderInfomation
	
	SELECT 
		STT,
		ProductCode, 
		ProductName,
		Specifications, 
		ImportPrice,
		Price, 
		InventoryQty
	FROM  #Detail
	
END

-- exec usp_BaoCaoTonKho @Date='2017-11-18 23:59:59',@StoreId=1000,@WarehouseId=1,@CategoryId=2
GO
/****** Object:  StoredProcedure [dbo].[usp_BaoCaoTonKhoChicCut]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nguyễn Thị Kiều Nga
-- Create date: 04/04/2017
-- Description:	Báo cáo tồn kho
-- =============================================
CREATE PROCEDURE [dbo].[usp_BaoCaoTonKhoChicCut] (
		@CategoryId int = 2 ,
		@ToDate date 
) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF exists (select NAME from sysobjects where NAME = '#ListInventory')
	BEGIN
		drop table #ListInventory
	END
	CREATE TABLE #ListInventory(
	    STT int,
		ProductId int,
		ProductCode nvarchar(500),
		ProductName nvarchar(500),
		Inventory decimal(18,2),
		Specifications nvarchar(100),
		CategoryName nvarchar(500),
		CategoryId int
	)
	INSERT INTO #ListInventory 
	(
		STT,
		ProductId,
		ProductCode,
		ProductName,
		Specifications,
		CategoryName,
		CategoryId
	)
	SELECT	ROW_NUMBER()Over(Order by p.ProductId ),
			p.ProductId,
			p.ProductCode,
			p.ProductName,
			p.Specifications,
			ca.CategoryName,
			ca.CategoryId
	FROM ProductModel p
	LEFT JOIN CategoryModel ca on p.CategoryId = ca.CategoryId
	
	WHERE 
		p.Actived = 1 AND 
		(ca.ADNCode like (SELECT ADNCode FROM CategoryModel WHERE CategoryId = @CategoryId) + '%' ) 
		--@FromDate <= CAST(im.CreatedDate AS DATE) AND CAST(im.CreatedDate AS DATE) <= @ToDate
	Order by ca.CategoryId,p.ProductId 

	UPDATE #ListInventory
	SET Inventory = (
		SELECT TOP 1 EndInventoryQty
		FROM InventoryDetailModel Indetail
		INNER JOIN InventoryMasterModel Inmaster on Inmaster.InventoryMasterId = Indetail.InventoryMasterId
		WHERE Inmaster.Actived = 1
		AND Indetail.ProductId = #ListInventory.ProductId
		AND CAST(Inmaster.CreatedDate AS DATE) <= @ToDate
		ORDER BY InventoryDetailId desc
	)

	SELECT  STT,
			ProductId,
		    ProductName,
			ProductCode,
			ISNULL(Inventory,0) AS Inventory,
			Specifications,
			CategoryName,
			CategoryId
   FROM #ListInventory
END

--EXEC [usp_ListCheckinfo]

GO
/****** Object:  StoredProcedure [dbo].[usp_BaoCaoXNT]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Linh>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_BaoCaoXNT]
	@StoreId INT,
	@WarehouseId INT = null,
	@CategoryId INT = null,
	@FromDate DATETIME = null,
	@ToDate DATETIME = null
AS
BEGIN
	SET NOCOUNT ON;
    IF exists (SELECT NAME FROM sysobjects WHERE NAME = '#HeaderInfomation')--Chỉ chạy trong Store
    BEGIN
		DROP TABLE #HeaderInfomation
    END
    
    IF exists (SELECT NAME FROM sysobjects WHERE NAME = '#Detail')
    BEGIN
		DROP TABLE #Detail
    END
    
	--Bước 1: Tạo bảng ảo
	CREATE TABLE #HeaderInfomation( 
	    StoreName NVARCHAR(500),
		WarehouseName NVARCHAR(500),
		FromDate DATETIME,
		ToDate DATETIME
	)
	CREATE TABLE #Detail(
		STT INT,
		ProductId INT,
		ProductCode NVARCHAR(500),
		ProductName NVARCHAR(500),
		Specifications NVARCHAR(500),
		BeginQty DECIMAL(18,2),
		ImportQty DECIMAL(18,2),
		ExportQty DECIMAL(18,2),
		EndQty DECIMAL(18,2)
	)	

	--Bước 2: Xử lý Insert cơ sở dữ liệu

	--INSERT INTO #HeaderInfomation(StoreName, WarehouseName, CreatedDate)
	--VALUES ('Chic Cut Salon', N'489 Hồng Bàng', @Date)

	--2.1: Insert header
	INSERT INTO #HeaderInfomation
	(
		StoreName, 
		WarehouseName, 
		FromDate,
		ToDate
	)
	SELECT
		s.StoreName, 
		w.WarehouseName, 
		@FromDate,
		@ToDate
	FROM StoreModel s, WarehouseModel w
	WHERE s.StoreId = @StoreId

	----INSERT INTO #Detail(STT, ProductName, ProductCode, InventoryQty)
	----VALUES(1, N'Thuốc nhuộm', 'WK_TN9/3', 50)

	----INSERT INTO #Detail(STT, ProductName, ProductCode, InventoryQty)
	----VALUES(2, N'Thuốc nhuộm', 'WCL_TN9/16', 50)

	----2.2: Insert detail
	----TH1: Tất cả sản phẩm -> CategoryId = 2
	IF @CategoryId = 2
	BEGIN
		INSERT INTO #Detail
		(
			STT,
			ProductId,
			ProductCode, 
			ProductName,
			Specifications,
			BeginQty,
			ImportQty, 
			ExportQty,
			EndQty
		)
		SELECT 
			ROW_NUMBER()Over(Order by p.ProductId), 
			p.ProductId,
			p.ProductCode,
			p.ProductName,
			p.Specifications,
			0.00 as BeginQty,
			0.00 as ImportQty,
			0.00 as ExportQty,
			0.00 as EndQty
		FROM ProductModel p
	END
	--TH2: HIển thị sản phẩm theo danh mục
	ELSE
	BEGIN
		INSERT INTO #Detail
		(
			STT,
			ProductId,
			ProductCode, 
			ProductName,
			Specifications,
			BeginQty,
			ImportQty, 
			ExportQty,
			EndQty
		)
		SELECT 
			ROW_NUMBER()Over(Order by p.ProductId),
			P.ProductId,
			p.ProductCode,
			p.ProductName,
			p.Specifications,
			0.00 as BeginQty,
			0.00 as ImportQty,
			0.00 as ExportQty,
			0.00 as EndQty
		FROM ProductModel p
			LEFT JOIN CategoryModel c ON p.CategoryId = c.CategoryId
		WHERE p.CategoryId = @CategoryId
	END
		 
	---- 2.3: Update dữ liệu xuất nhập tồn
	----Update detail
	-- Tồn Đầu
	UPDATE #Detail
	SET BeginQty = 
	ISNULL((
		SELECT TOP 1 EndInventoryQty
		FROM InventoryDetailModel ivd
			INNER JOIN InventoryMasterModel ivm on ivm.InventoryMasterId = ivd.InventoryMasterId
		WHERE ivm.Actived = 1
			AND ivd.ProductId = #Detail.ProductId
			AND ivm.CreatedDate < @FromDate
		ORDER BY CreatedDate DESC
	),0)
	-- Nhập
	UPDATE #Detail
	SET ImportQty = 
	ISNULL((
		SELECT TOP 1 SUM(ImportQty) AS ImportQty
		FROM InventoryDetailModel ivd
			INNER JOIN InventoryMasterModel ivm on ivm.InventoryMasterId = ivd.InventoryMasterId
		WHERE ivm.Actived = 1
			AND ivd.ProductId = #Detail.ProductId
			AND @FromDate < ivm.CreatedDate 
			AND ivm.CreatedDate <= @ToDate
	),0)
	-- Xuất
	UPDATE #Detail
	SET ExportQty = 
	ISNULL((
		SELECT TOP 1  SUM(ExportQty) AS ExportQty
		FROM ( 
			--Vì sản phẩm bán (xuất kho) bị trừ trùng ngày nên sum distinct InventoryDetailModel theo InventoryMasterId
			SELECT DISTINCT ivd.InventoryMasterId, ExportQty
			FROM InventoryDetailModel ivd
			INNER JOIN InventoryMasterModel ivm on ivm.InventoryMasterId = ivd.InventoryMasterId
			WHERE ivm.Actived = 1
			AND ivd.ProductId = #Detail.ProductId
			AND @FromDate < ivm.CreatedDate 
			AND ivm.CreatedDate <= @ToDate ) as SumExportQty
	),0)
	-- Tồn cuối
	UPDATE #Detail
	SET EndQty = 
	ISNULL((
		SELECT TOP 1 EndInventoryQty
		FROM InventoryDetailModel ivd
			INNER JOIN InventoryMasterModel ivm on ivm.InventoryMasterId = ivd.InventoryMasterId
		WHERE ivm.Actived = 1
			AND ivd.ProductId = #Detail.ProductId
			AND ivm.CreatedDate <= @ToDate
		ORDER BY CreatedDate DESC
	),0)

	--Bước cuối: Select kết quả
	SELECT 
		StoreName, 
		WarehouseName, 
		FromDate,
		ToDate
	FROM  #HeaderInfomation
	
	SELECT 
		STT,
		ProductCode, 
		ProductName,
		Specifications, 
		BeginQty,
		ImportQty, 
		ExportQty,
		EndQty
	FROM  #Detail
	
END

-- exec usp_BaoCaoXNT @FromDate='2017-11-01 00:00:00',@ToDate='2017-11-18 23:59:59',@StoreId=1000,@WarehouseId=1,@CategoryId=2
GO
/****** Object:  StoredProcedure [dbo].[usp_BaoCaoXuatNhapTon]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_BaoCaoXuatNhapTon]
AS
BEGIN
	SET NOCOUNT ON;

	
	 IF exists (select NAME from sysobjects where NAME = '#tempData')
    BEGIN
		drop table #tempData
    END

	SELECT pm.ProductId
		   ,cat.CategoryName
		   ,pm.ProductName
		   ,ISNULL(pp.BeginInventoryQty,0) AS BeginInventoryQty
		   ,ISNULL(pp.ImportQty, 0) AS ImportQty
		   ,ISNULL(pp.ExportQty, 0) AS ExportQty
		   ,ISNULL(pp.EndInventoryQty, 0) AS EndInventoryQty
		   ,p.CreatedDate as CreatedTime
		   ,CAST(p.CreatedDate  as date) as CreatedDate
		   ,sm.ShortName
		   ,p.InventoryCode
		   ,em.FullName AS CreatedAccount
		   ,wm.WarehouseName
	into #tempData
	FROM InventoryMasterModel p
	inner join InventoryDetailModel pp on p.InventoryMasterId = pp.InventoryMasterId and p.Actived = 1
	inner join StoreModel sm on p.StoreId = sm.StoreId
	
	inner join AccountModel am on p.CreatedAccount = am.UserName
	inner join EmployeeModel em on am.EmployeeId = em.EmployeeId
	
	inner join WarehouseModel wm on p.WarehouseModelId = wm.WarehouseId
	inner join ProductModel pm on pp.ProductId = pm.ProductId

	inner join CategoryModel cat on pm.CategoryId = cat.CategoryId


	--where Month(p.CreatedDate) = 8 and DAY(p.CreatedDate) = 28
	ORDER BY p.CreatedDate 
	
	select --z.ProductId,
		   t.CategoryName, t.ProductName, z.CreatedDate, z.BeginInventoryQty, z.ImportQty, z.ExportQty, t.EndInventoryQty, t.ShortName
		   ,t.InventoryCode
		   ,t.CreatedAccount
		   ,t.WarehouseName
	from (	select x.ProductId, x.CreatedDate, y.BeginInventoryQty, x.ImportQty, x.ExportQty, x.MaxTime
			from (
				select a.ProductId, a.CreatedDate, a.ImportQty, a.ExportQty, min(b.CreatedTime) as MinTime, max(b.CreatedTime) as MaxTime--, b.BeginInventoryQty--, b.EndInventoryQty
				from (select ProductId--, CategoryName, ProductName
					   ,CreatedDate 
					   ,sum(ImportQty) AS ImportQty
					   ,sum(ExportQty) AS ExportQty
				from #tempData
				group by CategoryName, ProductName, ProductId ,CreatedDate) a
				inner join #tempData b on (a.ProductId = b.ProductId and a.CreatedDate = b.CreatedDate)
				group by a.ProductId, a.CreatedDate, a.ImportQty, a.ExportQty) as x
				inner join #tempData y  on  (x.ProductId = y.ProductId and x.CreatedDate = y.CreatedDate and x.MinTime = y.CreatedTime)
			) as z
			inner join #tempData t  on  (z.ProductId = t.ProductId and z.CreatedDate = t.CreatedDate and z.MaxTime = t.CreatedTime)

END
--EXEC [usp_BaoCaoXuatNhapTon]


-- CAM BIEN THANH RAIL MCA  0 31 1 30  - 2016-08-28
GO
/****** Object:  StoredProcedure [dbo].[usp_BaoCaoXuatNhapTonDay]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_BaoCaoXuatNhapTonDay]
@FromDate date ,
@ToDate date ,
@WarehouseId decimal = null
AS
BEGIN
	SET NOCOUNT ON;

	IF exists (select NAME from sysobjects where NAME = '#tempData')
	BEGIN
		drop table #tempData
	END
	--Tính tồn đầu , cuối
	CREATE TABLE #tempData (
		ProductId INT,
		BeginInventoryQty INT,
		CreatedDate DATE,
		EndInventoryQty INT,
		InventoryMasterId  INT ,
		InventoryDetailId  INT 
	)
	--1.Tồn đầu
	insert into #tempData(
							ProductId,
							BeginInventoryQty,
							CreatedDate ,
							InventoryMasterId,
							InventoryDetailId
						 )
	SELECT p.ProductId, 
			p.BeginInventoryQty, 
			CAST(pp.CreatedDate as date)  as CreatedDate ,
		    pp.InventoryMasterId,
			p.InventoryDetailId
	FROM InventoryDetailModel p
	inner join InventoryMasterModel pp on p.InventoryMasterId = pp.InventoryMasterId and pp.Actived = 1
	INNER JOIN (select MIN(p1.InventoryDetailId) as InventoryDetailId   
				from InventoryDetailModel p1
			    inner join InventoryMasterModel pp1 on p1.InventoryMasterId = pp1.InventoryMasterId and pp1.Actived = 1 and (@WarehouseId is null or pp1.WarehouseModelId = @WarehouseId)
				group by ProductId, CAST(pp1.CreatedDate as date)
				having CAST(pp1.CreatedDate as date) >= @FromDate and CAST(pp1.CreatedDate as date) <= @ToDate
			  )x on p.InventoryDetailId = x.InventoryDetailId
    order by CAST(pp.CreatedDate as date)
	
  -- 2.Tồn cuối
 
	update #tempData
    set EndInventoryQty = (
  select detail.EndInventoryQty 
  from  InventoryMasterModel pp 
  INNER JOIN  InventoryDetailModel detail on detail.InventoryMasterId = pp.InventoryMasterId and pp.Actived = 1
  INNER JOIN (select MAX(p1.InventoryDetailId) as InventoryDetailId   
				from InventoryDetailModel p1
			    inner join InventoryMasterModel pp1 on p1.InventoryMasterId = pp1.InventoryMasterId and pp1.Actived = 1 and (@WarehouseId is null or pp1.WarehouseModelId = @WarehouseId)
				group by ProductId, CAST(pp1.CreatedDate as date)
				having CAST(pp1.CreatedDate as date) >= @FromDate and CAST(pp1.CreatedDate as date) <= @ToDate
			  )x on detail.InventoryDetailId = x.InventoryDetailId
where detail.ProductId = #tempData.ProductId  and CAST(pp.CreatedDate as date) = #tempData.CreatedDate)

-- Lấy Sum ImportQty, ExportQty
    IF exists (select NAME from sysobjects where NAME = '#tempData2')
	BEGIN
		drop table #tempData2
	END
	CREATE TABLE #tempData2 (
	    ProductId int,
		CreatedDate DATE,
		ImportQty int ,
		ExportQty int
	)
	insert into #tempData2 
	select p.ProductId ,
	       CAST(pp.CreatedDate AS DATE),
	       SUM(ISNULL(p.ImportQty,0)),
		   SUM(ISNULL(p.ExportQty,0))
	from  InventoryDetailModel p
	inner join InventoryMasterModel pp on p.InventoryMasterId = pp.InventoryMasterId and pp.Actived = 1 and (@WarehouseId is null or pp.WarehouseModelId = @WarehouseId)
	GROUP BY p.ProductId , CAST(pp.CreatedDate AS DATE)
	having CAST(pp.CreatedDate as date) >= @FromDate and CAST(pp.CreatedDate as date) <= @ToDate

	--Join các bảng phụ để lấy tên hiển thị
	select 
	       cat.CategoryName,
	       pm.ProductName,
		   p.CreatedDate,
	       p.BeginInventoryQty,
		   pp.ImportQty,
		   pp.ExportQty,
		   EndInventoryQty,
		   sm.ShortName,
		 --  invenmaster.InventoryCode,
		  -- em.FullName AS CreatedAccount,
		   wm.WarehouseCode as WarehouseName
	from #tempData p
	inner join #tempData2 pp on p.CreatedDate = pp.CreatedDate and p.ProductId = pp.ProductId
	inner join ProductModel pm on p.ProductId = pm.ProductId
	inner join CategoryModel cat on pm.CategoryId = cat.CategoryId
	inner join InventoryMasterModel invenmaster on p.InventoryMasterId =  invenmaster.InventoryMasterId
	inner join StoreModel sm on invenmaster.StoreId = sm.StoreId

	--inner join AccountModel am on invenmaster.CreatedAccount = am.UserName
	--inner join EmployeeModel em on am.EmployeeId = em.EmployeeId

	inner join WarehouseModel wm on invenmaster.WarehouseModelId = wm.WarehouseId
END

--EXEC [usp_BaoCaoXuatNhapTonTest]
--EXEC [usp_BaoCaoXuatNhapTonTest2] '2016-09-1', '2016-09-28'

-- CAM BIEN THANH RAIL MCA  0 31 1 30  - 2016-08-28
GO
/****** Object:  StoredProcedure [dbo].[usp_BaoCaoXuatNhapTonMonth]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_BaoCaoXuatNhapTonMonth]
@FromMonth int,
@FromYearMonth int,
@ToMonth int,
@ToYearMonth int,
@WarehouseId decimal = null
AS
BEGIN
	SET NOCOUNT ON;

	IF exists (select NAME from sysobjects where NAME = '#tempData')
	BEGIN
		drop table #tempData
	END
	--Tính tồn đầu , cuối
	CREATE TABLE #tempData (
		ProductId INT,
		BeginInventoryQty decimal,
		CreatedDate DATE,
		EndInventoryQty decimal,
		InventoryMasterId  INT ,
		InventoryDetailId  INT 
	)
	--1.Tồn đầu
	insert into #tempData(
							ProductId,
							BeginInventoryQty,
							CreatedDate ,
							InventoryMasterId,
							InventoryDetailId
						 )
	SELECT p.ProductId, 
			p.BeginInventoryQty, 
			CAST(pp.CreatedDate as date)  as CreatedDate ,
		    pp.InventoryMasterId,
			p.InventoryDetailId
	FROM InventoryDetailModel p
	inner join InventoryMasterModel pp on p.InventoryMasterId = pp.InventoryMasterId and pp.Actived = 1
	INNER JOIN (select MIN(p1.InventoryDetailId) as InventoryDetailId   
				from InventoryDetailModel p1
			    inner join InventoryMasterModel pp1 on p1.InventoryMasterId = pp1.InventoryMasterId and pp1.Actived = 1 and (@WarehouseId is null or pp1.WarehouseModelId = @WarehouseId)
				group by ProductId, YEAR(pp1.CreatedDate ), DATEPART(QUARTER, pp1.CreatedDate), MONTH(pp1.CreatedDate )
					-- From : + Bằng năm : Xét tháng
				--        + Năm lớn hơn @FromYearMonth
				-- To : + Bằng năm : Xét tháng
				--        + Năm nhỏ hơn
				having ( ( YEAR(pp1.CreatedDate ) = @FromYearMonth and  Month(pp1.CreatedDate) >= @FromMonth ) or  ((YEAR(pp1.CreatedDate ) > @FromYearMonth)) )
				       and ( (YEAR(pp1.CreatedDate ) = @FromYearMonth and  Month(pp1.CreatedDate) <= @ToMonth ) or  ((YEAR(pp1.CreatedDate ) < @ToYearMonth)) )
			  )x on p.InventoryDetailId = x.InventoryDetailId
    order by CAST(pp.CreatedDate as date)
	
  -- 2.Tồn cuối
 
	update #tempData
    set EndInventoryQty = (
  select detail.EndInventoryQty 
  from  InventoryMasterModel pp 
  INNER JOIN  InventoryDetailModel detail on detail.InventoryMasterId = pp.InventoryMasterId and pp.Actived = 1 
  INNER JOIN (select MAX(p1.InventoryDetailId) as InventoryDetailId 
				from InventoryDetailModel p1
			    inner join InventoryMasterModel pp1 on p1.InventoryMasterId = pp1.InventoryMasterId and pp1.Actived = 1 and (@WarehouseId is null or pp1.WarehouseModelId = @WarehouseId)
				group by ProductId, YEAR(pp1.CreatedDate ), DATEPART(QUARTER, pp1.CreatedDate), MONTH(pp1.CreatedDate )
			  )x on detail.InventoryDetailId = x.InventoryDetailId
where detail.ProductId = #tempData.ProductId  
						and Year(pp.CreatedDate) = YEAR(#tempData.CreatedDate) 
						and DATEPART(QUARTER, pp.CreatedDate) = DATEPART(QUARTER, #tempData.CreatedDate)
						and MONTH(pp.CreatedDate) = MONTH(#tempData.CreatedDate )
				)

-- Lấy Sum ImportQty, ExportQty
    IF exists (select NAME from sysobjects where NAME = '#tempData2')
	BEGIN
		drop table #tempData2
	END
	CREATE TABLE #tempData2 (
	    ProductId int,
		Nam int,
		Quy int,
		Thang int,
		ImportQty decimal ,
		ExportQty decimal
	)
	insert into #tempData2 
	select p.ProductId ,
	       Year(pp.CreatedDate),
		   DATEPART(QUARTER, pp.CreatedDate),
		   MONTH(pp.CreatedDate),
	       SUM(ISNULL(p.ImportQty,0)),
		   SUM(ISNULL(p.ExportQty,0))
	from  InventoryDetailModel p
	inner join InventoryMasterModel pp on p.InventoryMasterId = pp.InventoryMasterId and pp.Actived = 1 and (@WarehouseId is null or pp.WarehouseModelId = @WarehouseId)
	GROUP BY p.ProductId , YEAR(pp.CreatedDate ), DATEPART(QUARTER, pp.CreatedDate), MONTH(pp.CreatedDate)

	--Join các bảng phụ để lấy tên hiển thị
	select 
	       cat.CategoryName,
	       pm.ProductName,
		  -- p.CreatedDate,
		 ( N'Tháng ' + REPLACE(STR(CAST(MONTH(p.CreatedDate) AS nvarchar(50) ), 2), SPACE(1), '0') + ' / ' + CAST(YEAR(p.CreatedDate) AS nvarchar(10) ) ) AS CreatedDateString ,
	       p.BeginInventoryQty,
		   pp.ImportQty,
		   pp.ExportQty,
		   EndInventoryQty,
		   sm.ShortName,
		   --invenmaster.InventoryCode,
		   --em.FullName AS CreatedAccount,
		   wm.WarehouseCode as WarehouseName
	from #tempData p
	inner join #tempData2 pp on 
								YEAR(p.CreatedDate) = pp.Nam 
							and DATEPART(QUARTER, p.CreatedDate) = pp.Quy 
							and MONTH(P.CreatedDate) = pp.Thang 
							and  p.ProductId = pp.ProductId
	inner join ProductModel pm on p.ProductId = pm.ProductId
	inner join CategoryModel cat on pm.CategoryId = cat.CategoryId
	inner join InventoryMasterModel invenmaster on p.InventoryMasterId =  invenmaster.InventoryMasterId
	inner join StoreModel sm on invenmaster.StoreId = sm.StoreId

	--inner join AccountModel am on invenmaster.CreatedAccount = am.UserName
	--inner join EmployeeModel em on am.EmployeeId = em.EmployeeId

	inner join WarehouseModel wm on invenmaster.WarehouseModelId = wm.WarehouseId

	order by  ( N'Tháng ' + REPLACE(STR(CAST(MONTH(p.CreatedDate) AS nvarchar(50) ), 2), SPACE(1), '0') + ' / ' + CAST(YEAR(p.CreatedDate) AS nvarchar(10) ) )
END

--EXEC [usp_BaoCaoXuatNhapTonDay]
--EXEC [usp_BaoCaoXuatNhapTonQuater]
--EXEC [usp_BaoCaoXuatNhapTonMonth]


GO
/****** Object:  StoredProcedure [dbo].[usp_BaoCaoXuatNhapTonQuater]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_BaoCaoXuatNhapTonQuater]
@FromQuater int,
@FromYearQuater int,
@ToQuater int,
@ToYearQuater int,
@WarehouseId decimal = null
AS
BEGIN
	SET NOCOUNT ON;

	IF exists (select NAME from sysobjects where NAME = '#tempData')
	BEGIN
		drop table #tempData
	END
	--Tính tồn đầu , cuối
	CREATE TABLE #tempData (
		ProductId INT,
		BeginInventoryQty decimal,
		CreatedDate DATE,
		EndInventoryQty decimal,
		InventoryMasterId  INT ,
		InventoryDetailId  INT 
	)
	--1.Tồn đầu
	insert into #tempData(
							ProductId,
							BeginInventoryQty,
							CreatedDate ,
							InventoryMasterId,
							InventoryDetailId
						 )
	SELECT p.ProductId, 
			p.BeginInventoryQty, 
			CAST(pp.CreatedDate as date)  as CreatedDate ,
		    pp.InventoryMasterId,
			p.InventoryDetailId
	FROM InventoryDetailModel p
	inner join InventoryMasterModel pp on p.InventoryMasterId = pp.InventoryMasterId and pp.Actived = 1
	INNER JOIN (select MIN(p1.InventoryDetailId) as InventoryDetailId   
				from InventoryDetailModel p1
			    inner join InventoryMasterModel pp1 on p1.InventoryMasterId = pp1.InventoryMasterId and pp1.Actived = 1 and (@WarehouseId is null or pp1.WarehouseModelId = @WarehouseId)
				group by ProductId, YEAR(pp1.CreatedDate ), DATEPART(QUARTER, pp1.CreatedDate)
				-- From : + Bằng năm : Xét quý
				--        + Năm lớn hơn @FromYearQuater
				-- To : + Bằng năm : Xét quý
				--        + Năm nhỏ hơn
				having ( ( YEAR(pp1.CreatedDate ) = @FromYearQuater and  DATEPART(QUARTER, pp1.CreatedDate) >= @FromQuater ) or  ((YEAR(pp1.CreatedDate ) > @FromYearQuater)) )
				       and ( (YEAR(pp1.CreatedDate ) = @ToYearQuater and  DATEPART(QUARTER, pp1.CreatedDate) <= @ToQuater ) or  ((YEAR(pp1.CreatedDate ) < @ToYearQuater)) )
					  
			  )x on p.InventoryDetailId = x.InventoryDetailId
    order by CAST(pp.CreatedDate as date)
	
  -- 2.Tồn cuối
 
	update #tempData
    set EndInventoryQty = (
  select detail.EndInventoryQty 
  from  InventoryMasterModel pp 
  INNER JOIN  InventoryDetailModel detail on detail.InventoryMasterId = pp.InventoryMasterId and pp.Actived = 1
  INNER JOIN (select MAX(p1.InventoryDetailId) as InventoryDetailId 
				from InventoryDetailModel p1
			    inner join InventoryMasterModel pp1 on p1.InventoryMasterId = pp1.InventoryMasterId and pp1.Actived = 1 and (@WarehouseId is null or pp1.WarehouseModelId = @WarehouseId)
				group by ProductId, YEAR(pp1.CreatedDate ), DATEPART(QUARTER, pp1.CreatedDate)
				
			  )x on detail.InventoryDetailId = x.InventoryDetailId
where detail.ProductId = #tempData.ProductId  and Year(pp.CreatedDate) = YEAR(#tempData.CreatedDate) and DATEPART(QUARTER, pp.CreatedDate) = DATEPART(QUARTER, #tempData.CreatedDate)) 

-- Lấy Sum ImportQty, ExportQty
    IF exists (select NAME from sysobjects where NAME = '#tempData2')
	BEGIN
		drop table #tempData2
	END
	CREATE TABLE #tempData2 (
	    ProductId int,
		Nam int,
		Quy int,
		ImportQty decimal ,
		ExportQty decimal
	)
	insert into #tempData2 
	select p.ProductId ,
	       Year(pp.CreatedDate),
		   DATEPART(QUARTER, pp.CreatedDate),
	       SUM(ISNULL(p.ImportQty,0)),
		   SUM(ISNULL(p.ExportQty,0))
	from  InventoryDetailModel p
	inner join InventoryMasterModel pp on p.InventoryMasterId = pp.InventoryMasterId and pp.Actived = 1 and (@WarehouseId is null or pp.WarehouseModelId = @WarehouseId)
	GROUP BY p.ProductId , YEAR(pp.CreatedDate ), DATEPART(QUARTER, pp.CreatedDate)

	--Join các bảng phụ để lấy tên hiển thị
	select 
	       cat.CategoryName,
	       pm.ProductName,
		  -- p.CreatedDate,
		 ( N'Quý ' + CAST(DATEPART(QUARTER, p.CreatedDate) AS nvarchar(10) ) + ' / ' + CAST(YEAR(p.CreatedDate) AS nvarchar(10) ) ) AS CreatedDateString ,
	       p.BeginInventoryQty,
		   pp.ImportQty,
		   pp.ExportQty,
		   EndInventoryQty,
		   sm.ShortName,
		   --invenmaster.InventoryCode,
		   --em.FullName AS CreatedAccount,
		   wm.WarehouseCode as WarehouseName
	from #tempData p
	inner join #tempData2 pp on YEAR(p.CreatedDate) = pp.Nam and DATEPART(QUARTER, p.CreatedDate) = pp.Quy  and  p.ProductId = pp.ProductId
	inner join ProductModel pm on p.ProductId = pm.ProductId
	inner join CategoryModel cat on pm.CategoryId = cat.CategoryId
	inner join InventoryMasterModel invenmaster on p.InventoryMasterId =  invenmaster.InventoryMasterId
	inner join StoreModel sm on invenmaster.StoreId = sm.StoreId

	--inner join AccountModel am on invenmaster.CreatedAccount = am.UserName
	--inner join EmployeeModel em on am.EmployeeId = em.EmployeeId

	inner join WarehouseModel wm on invenmaster.WarehouseModelId = wm.WarehouseId
	ORDER BY  ( N'Quý ' + CAST(DATEPART(QUARTER, p.CreatedDate) AS nvarchar(10) ) + ' / ' + CAST(YEAR(p.CreatedDate) AS nvarchar(10) ) )
	--order by CAST(p.CreatedDate as date)
END

--EXEC [usp_BaoCaoXuatNhapTonTest]
--EXEC [usp_BaoCaoXuatNhapTonQuater]


GO
/****** Object:  StoredProcedure [dbo].[usp_CategoryProductAll]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_CategoryProductAll]
AS
	BEGIN
	IF exists (select NAME from sysobjects where NAME = '#CategoryProductReport')
    BEGIN
		drop table #CategoryProductReport
    END
    
    CREATE TABLE #CategoryProductReport(
		ProductId int,
		CategoryName nvarchar(500),
		EndInventoryQty decimal(21,5),
		TotalCogs decimal(21,5)
	)	
	insert into #CategoryProductReport 
	(
		ProductId,
		CategoryName,
		EndInventoryQty,
		TotalCogs
	)

	SELECT  p.ProductId,
			ISNULL(cate.CategoryNameEn,'') +' | ' + ISNULL(p.ProductName,'') +' | '+ ISNULL(p.Specifications,'') AS CategoryName,
			ISNULL(ivd.EndInventoryQty,0) AS EndInventoryQty,
			ISNULL(P.COGS*ivd.EndInventoryQty,0 ) AS TotalCogs			
	FROM InventoryDetailModel ivd
	INNER JOIN ProductModel AS P ON ivd.ProductId = P.ProductId
	INNER JOIN CategoryModel AS cate ON cate.CategoryId = P.CategoryId
	WHERE InventoryDetailId IN( SELECT MAX(InventoryDetailId) 
								FROM InventoryDetailModel id inner join InventoryMasterModel im on id.InventoryMasterId = im.InventoryMasterId
								where im.Actived = 1
								GROUP BY ProductId)	
				AND P.Actived = 1
						
	-- insert tong cong
	 insert into #CategoryProductReport 
	(
		ProductId,
		CategoryName,
		EndInventoryQty,
		TotalCogs
	)
	SELECT -1,
			N'Tất cả',
		   ISNULL(SUM(cate.EndInventoryQty),0) AS EndInventoryQty,
		   ISNULL(SUM(cate.TotalCogs),0) AS TotalCogs
	FROM #CategoryProductReport cate

	SELECT *
	FROM #CategoryProductReport AS Ca
	Order by Ca.ProductId DESC
		 								
	END


GO
/****** Object:  StoredProcedure [dbo].[usp_CategoryProductAllPa]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[usp_CategoryProductAllPa]
@CategoryId int,
@isWithChild bit = 0
AS
	BEGIN
	IF exists (select NAME from sysobjects where NAME = '#CategoryProductReport')
    BEGIN
		drop table #CategoryProductReport
    END
    
    CREATE TABLE #CategoryProductReport(
		ProductId int,
		CategoryName nvarchar(500),
		EndInventoryQty decimal,
		TotalCogs decimal
	)	
	insert into #CategoryProductReport 
	(
		ProductId,
		CategoryName,
		EndInventoryQty,
		TotalCogs
	)

	SELECT  p.ProductId,
			p.ProductName AS CategoryName,
			ISNULL(ivd.EndInventoryQty,0) AS EndInventoryQty,
			ISNULL(P.COGS*ivd.EndInventoryQty,0 ) AS TotalCogs			
	FROM InventoryDetailModel ivd
	INNER JOIN ProductModel AS P ON ivd.ProductId = P.ProductId
	INNER JOIN CategoryModel AS cate ON cate.CategoryId = P.CategoryId
	WHERE (InventoryDetailId IN( SELECT MAX(InventoryDetailId) 
								FROM InventoryDetailModel 
								GROUP BY ProductId)	
			AND (cate.CategoryId = @CategoryId or (@isWithChild = 1 and cate.Parent = @CategoryId)))
			AND P.Actived = 1
	-- insert tong cong
	 insert into #CategoryProductReport 
	(
		ProductId,
		CategoryName,
		EndInventoryQty,
		TotalCogs
	)
	SELECT -1,
			N'Tất cả',
		   ISNULL(SUM(cate.EndInventoryQty),0) AS EndInventoryQty,
		   ISNULL(SUM(cate.TotalCogs),0) AS TotalCogs
	FROM #CategoryProductReport cate

	SELECT *
	FROM #CategoryProductReport AS Ca
	Order by Ca.ProductId DESC
		 								
	END


GO
/****** Object:  StoredProcedure [dbo].[usp_CategoryProductReport]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_CategoryProductReport]
@CategoryId int
AS
	BEGIN
	IF exists (select NAME from sysobjects where NAME = '#CategoryProductReport')
    BEGIN
		drop table #CategoryProductReport
    END
    
    CREATE TABLE #CategoryProductReport(
		ProductId int,
		CategoryName nvarchar(500),
		EndInventoryQty decimal(21,5),
		TotalCogs decimal(21,5)
	)	
	insert into #CategoryProductReport 
	(
		ProductId,
		CategoryName,
		EndInventoryQty,
		TotalCogs
	)

	SELECT  p.ProductId,
			ISNULL(p.ProductCode,'') +' | ' + ISNULL(p.ProductName,'') +' | '+  ISNULL(p.Specifications,'') AS CategoryName,
			ISNULL(ivd.EndInventoryQty,0) AS EndInventoryQty,
			ISNULL(P.COGS*ivd.EndInventoryQty,0 ) AS TotalCogs			
	FROM InventoryDetailModel ivd
	INNER JOIN ProductModel AS P ON ivd.ProductId = P.ProductId
	WHERE InventoryDetailId IN( SELECT MAX(InventoryDetailId) 
								FROM InventoryDetailModel  id inner join InventoryMasterModel im on id.InventoryMasterId = im.InventoryMasterId
								where im.Actived = 1
								GROUP BY ProductId)
		 AND p.CategoryId = @CategoryId	
		AND P.Actived = 1

	
	-- insert tong cong
	 insert into #CategoryProductReport 
	(
		ProductId,
		CategoryName,
		EndInventoryQty,
		TotalCogs
	)
	SELECT -1,
			N'Tất cả',
		   ISNULL(SUM(cate.EndInventoryQty),0) AS EndInventoryQty,
		   ISNULL(SUM(cate.TotalCogs),0) AS TotalCogs
	FROM #CategoryProductReport cate

	SELECT *
	FROM #CategoryProductReport
		 								
	END


GO
/****** Object:  StoredProcedure [dbo].[usp_CategoryProductTypeAll]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_CategoryProductTypeAll]
AS
	BEGIN
	IF exists (select NAME from sysobjects where NAME = '#EndInventoryProduct')
    BEGIN
		drop table #EndInventoryProduct
    END
    
    IF exists (select NAME from sysobjects where NAME = '#CategoryProductTypeReport')
    BEGIN
		drop table #CategoryProductTypeReport
    END

    
	CREATE TABLE #EndInventoryProduct(
		ProductId int,
		CategoryId int,
		TotalCogs decimal,
		EndInventoryQty decimal
	)	
	
	CREATE TABLE #CategoryProductTypeReport(
		CategoryId int,
		CategoryName nvarchar(500),
		EndInventoryQty decimal,
		TotalCogs decimal
	)	
	

	
	insert into #EndInventoryProduct 
	(
		ProductId,
		CategoryId,
		TotalCogs,
		EndInventoryQty
	)
	SELECT ivd.ProductId,
			p.CategoryId,
			ISNULL(P.COGS * ivd.EndInventoryQty,0 ) AS TotalCogs,
			ISNULL(ivd.EndInventoryQty,0) AS EndInventoryQty
	FROM InventoryDetailModel ivd
	INNER JOIN ProductModel AS P ON ivd.ProductId = P.ProductId
	WHERE InventoryDetailId IN( SELECT MAX(InventoryDetailId) 
								FROM InventoryDetailModel 
								GROUP BY ProductId)
				AND P.Actived = 1
						
								
	insert into #CategoryProductTypeReport 
	(
		CategoryId,
		CategoryName,
		EndInventoryQty,
		TotalCogs
	)

	SELECT cate.CategoryId
			,cate.CategoryName,
		   ISNULL(SUM(E.EndInventoryQty),0) AS EndInventoryQty,
		   ISNULL(SUM(E.TotalCogs),0) AS TotalCogs
	FROM CategoryModel AS cate
	LEFT JOIN #EndInventoryProduct AS E ON cate.CategoryId = E.CategoryId
	Where cate.Parent in
		(SELECT CATE.CategoryId
		 FROM CategoryModel CATE
		 WHERE CATE.Parent = '2' ) 
	OR (cate.CategoryId='17' OR cate.CategoryId='2') 
	OR (cate.Parent ='2' And cate.CategoryId !='17' And cate.CategoryId !='2' )
	Group by cate.CategoryId,cate.CategoryName
	
	insert into #CategoryProductTypeReport 
	(
		CategoryId,
		CategoryName,
		EndInventoryQty,
		TotalCogs
	)

	SELECT -1,
			N'Tất cả',
		   ISNULL(SUM(cate.EndInventoryQty),0) AS EndInventoryQty,
		   ISNULL(SUM(cate.TotalCogs),0) AS TotalCogs
	FROM #CategoryProductTypeReport cate

	SELECT *
	FROM #CategoryProductTypeReport
	
	END


GO
/****** Object:  StoredProcedure [dbo].[usp_CategoryProductTypeReport]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_CategoryProductTypeReport]
@CategoryId int
AS
	BEGIN
	IF exists (select NAME from sysobjects where NAME = '#EndInventoryProduct')
    BEGIN
		drop table #EndInventoryProduct
    END
    
    IF exists (select NAME from sysobjects where NAME = '#CategoryProductTypeReport')
    BEGIN
		drop table #CategoryProductTypeReport
    END

    
	CREATE TABLE #EndInventoryProduct(
		ProductId int,
		CategoryId int,
		TotalCogs decimal,
		EndInventoryQty decimal
	)	
	
	CREATE TABLE #CategoryProductTypeReport(
		CategoryId int,
		CategoryName nvarchar(500),
		EndInventoryQty decimal,
		TotalCogs decimal
	)	
	

	
	insert into #EndInventoryProduct 
	(
		ProductId,
		CategoryId,
		TotalCogs,
		EndInventoryQty
	)
	SELECT ivd.ProductId,
			p.CategoryId,
			ISNULL(P.COGS * ivd.EndInventoryQty,0 ) AS TotalCogs,
			ISNULL(ivd.EndInventoryQty,0) AS EndInventoryQty
	FROM InventoryDetailModel ivd
	INNER JOIN ProductModel AS P ON ivd.ProductId = P.ProductId
	WHERE InventoryDetailId IN( SELECT MAX(InventoryDetailId) 
								FROM InventoryDetailModel 
								GROUP BY ProductId)		
			AND P.Actived = 1

	
	
	IF(@CategoryId ='2')
	begin
		insert into #CategoryProductTypeReport 
		(
			CategoryId,
			CategoryName,
			EndInventoryQty,
			TotalCogs
		)
		SELECT cate.CategoryId
				,cate.CategoryName,
			   ISNULL(SUM(E.EndInventoryQty),0) AS EndInventoryQty,
			   ISNULL(SUM(E.TotalCogs),0) AS TotalCogs
		FROM CategoryModel AS cate
		LEFT JOIN #EndInventoryProduct AS E ON cate.CategoryId = E.CategoryId
		Where (cate.CategoryId ='2')
		Group by cate.CategoryId,cate.CategoryName
	end
	else
	begin
			insert into #CategoryProductTypeReport 
		(
			CategoryId,
			CategoryName,
			EndInventoryQty,
			TotalCogs
		)

		SELECT cate.CategoryId
				,cate.CategoryName,
			   ISNULL(SUM(E.EndInventoryQty),0) AS EndInventoryQty,
			   ISNULL(SUM(E.TotalCogs),0) AS TotalCogs
		FROM CategoryModel AS cate
		LEFT JOIN #EndInventoryProduct AS E ON cate.CategoryId = E.CategoryId
		Where (cate.Parent=@CategoryId) OR (cate.CategoryId = @CategoryId)
		Group by cate.CategoryId,cate.CategoryName
	end							
	
	
	
	--Insert tính tổng
	insert into #CategoryProductTypeReport 
	(
		CategoryId,
		CategoryName,
		EndInventoryQty,
		TotalCogs
	)

	SELECT -1,
			N'Tất cả',
		   ISNULL(SUM(cate.EndInventoryQty),0) AS EndInventoryQty,
		   ISNULL(SUM(cate.TotalCogs),0) AS TotalCogs
	FROM #CategoryProductTypeReport cate
    --------------------------------------
    
	SELECT *
	FROM #CategoryProductTypeReport
	
	END


GO
/****** Object:  StoredProcedure [dbo].[usp_CategoryReport]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_CategoryReport]
AS
	BEGIN
	IF exists (select NAME from sysobjects where NAME = '#EndInventoryProduct')
    BEGIN
		drop table #EndInventoryProduct
    END
    
    IF exists (select NAME from sysobjects where NAME = '#GroupInventoryParent')
    BEGIN
		drop table #GroupInventoryParent
    END

    IF exists (select NAME from sysobjects where NAME = '#CategoryReport')
    BEGIN
		drop table #CategoryReport
    END
    
	CREATE TABLE #EndInventoryProduct(
		ProductId int,
		CategoryId int,
		TotalCogs decimal,
		EndInventoryQty decimal
	)
	
	CREATE TABLE #GroupInventoryParent(
		Parent int,
		EndInventoryQty decimal,
		TotalCogs decimal
	)
	
	CREATE TABLE #CategoryReport(
		CategoryId int,
		CategoryName nvarchar(500),
		EndInventoryQty decimal,
		TotalCogs decimal
	)

	-- Tồn cuối sản phẩm
	insert into #EndInventoryProduct 
	(
		ProductId,
		CategoryId,
		TotalCogs,
		EndInventoryQty
	)
	SELECT ivd.ProductId,
			p.CategoryId,
			ISNULL(P.COGS *ivd.EndInventoryQty ,0 ) AS TotalCogs,
			ISNULL(ivd.EndInventoryQty,0) AS EndInventoryQty
	FROM InventoryDetailModel ivd
	INNER JOIN ProductModel AS P ON ivd.ProductId = P.ProductId
	WHERE InventoryDetailId IN( SELECT MAX(InventoryDetailId) 
								FROM InventoryDetailModel 
								GROUP BY ProductId)
		AND P.Actived = 1

								
		
	-- Nhóm theo Parent							
	insert into #GroupInventoryParent 
	(
		Parent,
		EndInventoryQty,
		TotalCogs
	)
	SELECT cate.Parent,
		   ISNULL(SUM(E.EndInventoryQty),0) AS InventoryQty,
		   ISNULL(SUM(E.TotalCogs),0) AS TotalCogs
	FROM CategoryModel AS cate
	LEFT JOIN #EndInventoryProduct AS E ON cate.CategoryId = E.CategoryId
	Where cate.Parent !='2' AND cate.Parent !='0' AND cate.Parent !='1'
	Group by cate.Parent

    -- Insert Sản phẩm khác và sản phẩm 
	insert into #GroupInventoryParent 
	(
		Parent,
		EndInventoryQty,
		TotalCogs
	)	
	SELECT cate.CategoryId,
		   ISNULL(SUM(E.EndInventoryQty),0) AS InventoryQty,
		   ISNULL(SUM(E.TotalCogs),0) AS TotalCogs
	FROM CategoryModel cate
		LEFT JOIN #EndInventoryProduct AS E ON cate.CategoryId = E.CategoryId
	WHERE (cate.CategoryId='17' OR cate.CategoryId='2')
	Group by cate.CategoryId 
	
	-- Sản phẩm chưa phân danh mục con
	update #GroupInventoryParent
	set EndInventoryQty = EndInventoryQty + C.InventoryQty,
		TotalCogs = #GroupInventoryParent.TotalCogs + C.TotalCogs
	from  (SELECT cate.CategoryId,
		   ISNULL(SUM(E.EndInventoryQty),0) AS InventoryQty,
		   ISNULL(SUM(E.TotalCogs),0) AS TotalCogs
			FROM CategoryModel AS cate
			LEFT JOIN #EndInventoryProduct AS E ON cate.CategoryId = E.CategoryId
			Where cate.Parent = 2
			Group by cate.CategoryId) AS C
	where #GroupInventoryParent.Parent != 17 and #GroupInventoryParent.Parent != 2 And  #GroupInventoryParent.Parent = C.CategoryId


	insert into #CategoryReport 
	(
		CategoryId,
		CategoryName,
		EndInventoryQty,
		TotalCogs
	)
	SELECT	Cate.CategoryId,
			Case When Cate.CategoryId ='2' Then N'Sản phẩm (Chưa phân danh mục)' else Cate.CategoryName end,
			ISNULL (GP.EndInventoryQty,0) AS EndInventoryQty, 
			ISNULL(GP.TotalCogs,0) AS TotalCogs
	FROM CategoryModel Cate
		LEFT JOIN #GroupInventoryParent As GP ON Cate.CategoryId = GP.Parent
	Where Cate.Parent = '2'  OR GP.Parent ='2'
	order by OrderBy
	
	-- Insert Tất cả
	insert into #CategoryReport 
	(
		CategoryId,
		CategoryName,
		EndInventoryQty,
		TotalCogs
	)
	SELECT	-1,
			N'Tất cả',
			ISNULL (sum(Cate.EndInventoryQty),0) AS EndInventoryQty, 
			ISNULL(sum(Cate.TotalCogs),0) AS TotalCogs
	FROM #CategoryReport Cate
	
	SELECT *
	From #CategoryReport
	
	END


GO
/****** Object:  StoredProcedure [dbo].[usp_CategoryReport2]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_CategoryReport2]
AS
	BEGIN
	IF exists (select NAME from sysobjects where NAME = '#EndInventoryProduct')
    BEGIN
		drop table #EndInventoryProduct
    END
    
    IF exists (select NAME from sysobjects where NAME = '#GroupInventoryParent')
    BEGIN
		drop table #GroupInventoryParent
    END

    
	CREATE TABLE #EndInventoryProduct(
		ProductId int,
		CategoryId int,
		COGS decimal,
		EndInventoryQty decimal
	)
	
	CREATE TABLE #GroupInventoryParent(
		Parent int,
		EndInventoryQty decimal,
		TotalCogs decimal
	)
	
	
	insert into #EndInventoryProduct 
	(
		ProductId,
		CategoryId,
		COGS,
		EndInventoryQty
	)
	SELECT ivd.ProductId,
			p.CategoryId,
			ISNULL(P.COGS,0 ) AS COGS,
			ISNULL(ivd.EndInventoryQty,0)
	FROM InventoryDetailModel ivd
	INNER JOIN ProductModel AS P ON ivd.ProductId = P.ProductId
	WHERE InventoryDetailId IN( SELECT MAX(InventoryDetailId) 
								FROM InventoryDetailModel 
								GROUP BY ProductId)
	select *
	from #EndInventoryProduct							
								
	insert into #GroupInventoryParent 
	(
		Parent,
		EndInventoryQty,
		TotalCogs
	)
	SELECT cate.Parent,
		   ISNULL(SUM(E.EndInventoryQty),0) AS InventoryQty,
		   ISNULL(SUM(E.COGS*E.EndInventoryQty),0) AS TotalCogs
	FROM CategoryModel AS cate
	LEFT JOIN #EndInventoryProduct AS E ON cate.CategoryId = E.CategoryId
	Group by cate.Parent
	
	select *
	from #GroupInventoryParent
	
	--SELECT	Cate.CategoryId,
	--		Cate.CategoryName,
	--		ISNULL (GP.EndInventoryQty,0) AS EndInventoryQty, 
	--		ISNULL(GP.TotalCogs,0) AS TotalCogs
	--FROM CategoryModel Cate
	--	Inner join #GroupInventoryParent As GP ON Cate.CategoryId = GP.Parent
	--Where Cate.Parent = '2'
	
	END
--	exec usp_CategoryReport2
GO
/****** Object:  StoredProcedure [dbo].[usp_CategoryReportChicCut]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_CategoryReportChicCut]
AS
	BEGIN
	IF exists (select NAME from sysobjects where NAME = '#EndInventoryProduct')
    BEGIN
		drop table #EndInventoryProduct
    END
    

    IF exists (select NAME from sysobjects where NAME = '#CategoryReport')
    BEGIN
		drop table #CategoryReport
    END
    
	CREATE TABLE #EndInventoryProduct(
		ProductId int,
		CategoryId int,
		TotalCogs decimal(21,5),
		EndInventoryQty decimal(21,5)
	)
	
	
	CREATE TABLE #CategoryReport(
		CategoryId int,
		CategoryName nvarchar(500),
		EndInventoryQty decimal(21,5),
		TotalCogs decimal(21,5)
	)

	-- Tồn cuối sản phẩm
	insert into #EndInventoryProduct 
	(
		ProductId,
		CategoryId,
		EndInventoryQty,
		TotalCogs
	)
	SELECT ivd.ProductId,
			p.CategoryId,
			ISNULL(ivd.EndInventoryQty,0) AS EndInventoryQty,
			ISNULL(P.COGS *ivd.EndInventoryQty ,0 ) AS TotalCogs
	FROM InventoryDetailModel ivd
	INNER JOIN ProductModel AS P ON ivd.ProductId = P.ProductId
	WHERE InventoryDetailId IN( SELECT MAX(InventoryDetailId) 
								FROM InventoryDetailModel  id inner join InventoryMasterModel im on id.InventoryMasterId = im.InventoryMasterId
								where im.Actived = 1
								GROUP BY ProductId)
		AND P.Actived = 1

		
	insert into #CategoryReport 
	(
		CategoryId,
		CategoryName,
		EndInventoryQty,
		TotalCogs
	)
	SELECT	Cate.CategoryId,
			(Case When Cate.CategoryId ='2' Then N'Sản phẩm (Chưa phân danh mục)' else Cate.CategoryName end) as CategoryName,
			ISNULL (sum(E.EndInventoryQty),0) AS EndInventoryQty, 
			ISNULL(sum(E.TotalCogs),0) AS TotalCogs
	FROM CategoryModel Cate
		LEFT JOIN #EndInventoryProduct As E ON Cate.CategoryId = E.CategoryId
	Where Cate.Parent = '2'
	group by Cate.CategoryId,CategoryName
	
	-- Insert Tất cả
	insert into #CategoryReport 
	(
		CategoryId,
		CategoryName,
		EndInventoryQty,
		TotalCogs
	)
	SELECT	-1,
			N'Tất cả',
			ISNULL (sum(Cate.EndInventoryQty),0) AS EndInventoryQty, 
			ISNULL(sum(Cate.TotalCogs),0) AS TotalCogs
	FROM #CategoryReport Cate
	
	SELECT 
	CategoryId,
	CategoryName,
	EndInventoryQty,
	TotalCogs

	From #CategoryReport
	
	END

	--EXEC [dbo].[usp_CategoryReportChicCut]
GO
/****** Object:  StoredProcedure [dbo].[usp_ChiTietDonHang]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nguyễn Văn Phong >
-- Create date: <2016/10/4>
-- Description:	<Chi tiết công nợ đơn hàng >
-- =============================================
CREATE PROCEDURE [dbo].[usp_ChiTietDonHang] 
 @CustomerId int	
AS
BEGIN
	SET NOCOUNT ON;
		select C.OrderId,
		   C.OrderCode,
		   C.CreatedDate,
		   C.Loai,
		   C.TotalPrice,
		   C.RemainingAmountAccrued,
		   C.Cindex
		from 
		(SELECT A.*
		FROM (select P.OrderId,
				 p.OrderCode,
			   p.CreatedDate,
			   N'Bán hàng' as Loai,
			   p.TotalPrice,
			   (p.RemainingAmountAccrued + ISNULL(p.Paid,0)) as RemainingAmountAccrued,
			  1 as Cindex
		from OrderMasterModel as p
		WHERE p.Actived = 1 and p.CustomerId = @CustomerId
		) A
		UNION
		SELECT B.*
		FROM (select P.OrderId,
			   p.OrderCode,
			   p.CreatedDate,
			   N'Thanh toán' as Loai,
			  (0 - p.Paid) as Paid,
			  p.RemainingAmountAccrued,
			  2 as Cindex
		from OrderMasterModel as p 
		Where ISNULL(p.Paid,0) != 0 and p.Actived = 1 and p.CustomerId = @CustomerId) B
		) as C
		order by C.CreatedDate desc, c.Cindex desc

		--EXEC usp_ChiTietDonHang 10020
END

GO
/****** Object:  StoredProcedure [dbo].[usp_Daily_ChicCut_Order_Canceled]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_Daily_ChicCut_Order_Canceled] (
@OrderId INT, 
@CanceledDate DATETIME, 
@CanceledUserId int
)
AS
	BEGIN
		set nocount on;
		declare @trancount int;
		set @trancount = @@trancount;
			print @@trancount
			BEGIN TRY
				 if @trancount = 0
					begin transaction
				else
					save transaction usp_my_procedure_name;

			--PRINT @@TRANCOUNT
			    -- Bước 1
			    -- Thieu 1: lay cai actived = true moi lam
			    -- Thieu 2: set actived = false cua inventory master
			    IF ((SELECT OrderStatusId FROM Daily_ChicCut_OrderModel WHERE OrderId = @OrderId) = 3) -- 3 là Đã thanh toán thì mới Huỷ
			    BEGIN
					UPDATE Daily_ChicCut_OrderModel
					SET OrderStatusId = 4, -- Xét đã huỷ
						CanceledDate = @CanceledDate,
						CanceledUserId = @CanceledUserId
					WHERE OrderId = @OrderId
					print 'complete 1'
					-- Bước 2 : 
						--1.lấy CreateDate để so sánh CreateDate trong InventoryMasterModel : Lọc ra danh sách cần cập nhật
						  DECLARE @CreatedDate DATETIME;
						  SELECT @CreatedDate = InvenMaster.CreatedDate
						  FROM InventoryMasterModel InvenMaster
						  WHERE  InvenMaster.BusinessId = @OrderId and 
								 InvenMaster.BusinessName='Daily_ChicCut_OrderModel'
						  --Xét actived = false cua inventory master
						  UPDATE InventoryMasterModel
						  SET Actived = 0,
							  DeletedDate = @CanceledDate,
						      DeletedEmployeeId = @CanceledUserId
						  WHERE BusinessId = @OrderId and 
								BusinessName='Daily_ChicCut_OrderModel'
						print 'complete 2'
						IF exists (select NAME from sysobjects where NAME = '#ImportDetail')
						BEGIN
							drop table #ImportDetail
						END
						CREATE TABLE #ImportDetail(
							ProductId int,
							Qty decimal(21,5)
						)
						insert into #ImportDetail
						SELECT InvenDetail.ProductId, InvenDetail.ExportQty
						FROM [dbo].[InventoryMasterModel] InvenMaster
						INNER JOIN [dbo].[InventoryDetailModel] InvenDetail on InvenMaster.InventoryMasterId = InvenDetail.InventoryMasterId
						WHERE InvenMaster.BusinessId = @OrderId and InvenMaster.BusinessName = 'Daily_ChicCut_OrderModel'
							print 'complete 2.2'
						--3. Lấy ra danh sách sản phẩm cần update sau  @CreatedDate
						 -- Bảng tạm 2 : Lấy InventoryDetailId, ProductId, Qty;
						IF exists (select NAME from sysobjects where NAME = '#InvenDetail')
						BEGIN
							drop table #InvenDetail
						END
						CREATE TABLE #InvenDetail(
							InventoryDetailId int,
							ProductId int,
							Qty decimal(21,5)
						)
						INSERT INTO #InvenDetail (InventoryDetailId, ProductId, Qty)
						SELECT InvenDetail.InventoryDetailId, InvenDetail.ProductId , tblTempt.Qty
							FROM InventoryDetailModel InvenDetail
							INNER JOIN InventoryMasterModel InvenMaster on InvenMaster.InventoryMasterId =  InvenDetail.InventoryMasterId
							, (SELECT #ImportDetail.ProductId, #ImportDetail.Qty
								FROM  #ImportDetail) as tblTempt
							WHERE InvenMaster.CreatedDate > @CreatedDate AND InvenDetail.ProductId = tblTempt.ProductId
						print 'complete 2.3'

						Update InventoryDetailModel
						SET BeginInventoryQty = BeginInventoryQty + (Select Qty from #InvenDetail Where #InvenDetail.InventoryDetailId = InventoryDetailModel.InventoryDetailId and ProductId = InventoryDetailModel.ProductId)	
						, EndInventoryQty = BeginInventoryQty + ISNULL(ImportQty, 0) - ISNULL(ExportQty,0) + (Select Qty from #InvenDetail Where #InvenDetail.InventoryDetailId = InventoryDetailModel.InventoryDetailId and ProductId = InventoryDetailModel.ProductId)	
						Where InventoryDetailId in (Select InventoryDetailId from #InvenDetail)
						--Select *
						--from 	#InvenDetail
						--print 'complete 3'  
			  END
			  
				if @trancount = 0
					commit;
			  --PRINT @@TRANCOUNT
			END TRY
			BEGIN CATCH
					declare @error int, @message varchar(4000), @xstate int;
					select @error = ERROR_NUMBER(), @message = ERROR_MESSAGE(), @xstate = XACT_STATE();
					if @xstate = -1
						rollback;
					if @xstate = 1 and @trancount = 0
						rollback
					if @xstate = 1 and @trancount > 0
						rollback transaction usp_my_procedure_name;
					raiserror ('usp_my_procedure_name: %d: %s', 16, 1, @error, @message) ;
					
			END CATCH
	END

GO
/****** Object:  StoredProcedure [dbo].[usp_DanhSachNoPhaiThuKhachHang]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nguyễn Văn Phong>
-- Create date: <11/10/2015>
-- Description:	<Báo cáo danh sách nợ phải thu khách hàng>
-- =============================================
CREATE PROCEDURE [dbo].[usp_DanhSachNoPhaiThuKhachHang]
	@FromDate date = null,
	@ToDate date  = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF(@FromDate is null)
	BEGIN
		SET @FromDate = DATEADD(YEAR,-100,GETDATE())
	END
	IF(@ToDate is null)
	BEGIN
		SET @ToDate = GETDATE()
	END

	  IF exists (select NAME from sysobjects where NAME = '#LstCustomerInfo')--Chỉ chạy trong Store
		BEGIN
			drop table #LstCustomerInfo
		END

    CREATE TABLE #LstCustomerInfo(
	    CustomerId int,
	    FullName NVARCHAR(500),
		Phone NVARCHAR(50),
		Email NVARCHAR(50),
		CustomerLevelName NVARCHAR(50),
		SoDuNoDauKy decimal(18,2),
		SoDuNoCuoiKy decimal(18,2)
	)

	insert into #LstCustomerInfo(
	    CustomerId ,
	    FullName ,
		Phone ,
		Email ,
		CustomerLevelName 
	)
	SELECT cus.CustomerId,
	       cus.Fullname,
		   cus.Phone,
		   cus.Email,
		   cuslevel.CustomerLevelName
	FROM [dbo].[CustomerModel] cus
	inner join [dbo].[CustomerLevelModel] cuslevel on cus.[CustomerLevelId] = cuslevel.[CustomerLevelId]

	-- Update Số dư nợ đầu kỳ, cuối kỳ
	update #LstCustomerInfo 
	set SoDuNoDauKy = ISNULL((
					 select TOP 1 RemainingAmountAccrued 
					 from [dbo].[AM_DebtModel] as p
					 where p.CustomerId = #LstCustomerInfo.CustomerId 
					 AND (@FromDate is null or Cast(TimeOfDebt as date) < @FromDate) 			
					 order by TimeOfDebt desc
					),0)
	,SoDuNoCuoiKy = ISNULL((
					 select TOP 1 RemainingAmountAccrued 
					 from [dbo].[AM_DebtModel]  as p
					 where p.CustomerId = #LstCustomerInfo.CustomerId 
					 AND (@ToDate IS NULL OR Cast(TimeOfDebt as date) <= @ToDate )
					 order by TimeOfDebt desc
					),0)
  --select @FromDate, @ToDate

  select *
  from #LstCustomerInfo
  --exec usp_DanhSachNoPhaiThuKhachHang '2016-10-5',null
END

GO
/****** Object:  StoredProcedure [dbo].[usp_DanhSachNoPhaiTraNhaCungCap]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nguyễn Văn Phong>
-- Create date: <12/10/2015>
-- Description:	<Báo cáo danh sách nợ PHẢI TRẢ NHÀ CUNG CẤP>
-- =============================================
CREATE PROCEDURE [dbo].[usp_DanhSachNoPhaiTraNhaCungCap]
	@FromDate date = null,
	@ToDate date  = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF(@FromDate is null)
	BEGIN
		SET @FromDate = DATEADD(YEAR,-100,GETDATE())
	END
	IF(@ToDate is null)
	BEGIN
		SET @ToDate = GETDATE()
	END

	  IF exists (select NAME from sysobjects where NAME = '#LstSupplierInfo')--Chỉ chạy trong Store
		BEGIN
			drop table #LstSupplierInfo
		END

    CREATE TABLE #LstSupplierInfo(
	    SupplierId int,
	    SupplierName NVARCHAR(500),
		Phone NVARCHAR(50),
		Email NVARCHAR(50),
		SoDuNoDauKy decimal(18,2),
		SoDuNoCuoiKy decimal(18,2)
	)

	insert into #LstSupplierInfo(
	    SupplierId ,
	    SupplierName ,
		Phone ,
		Email
	)
	SELECT sup.SupplierId,
	       sup.SupplierName,
		   sup.Phone,
		   sup.Email
	FROM [dbo].[SupplierModel] sup

	-- Update Số dư nợ đầu kỳ, cuối kỳ
	update #LstSupplierInfo 
	set SoDuNoDauKy = ISNULL((
					 select TOP 1 RemainingAmountAccrued 
					 from [dbo].[AM_DebtModel] as p
					 where p.SupplierId = #LstSupplierInfo.SupplierId 
					 AND ( @FromDate IS NULL OR Cast(TimeOfDebt as date) < @FromDate ) 
					 order by TimeOfDebt desc
					),0)
	,SoDuNoCuoiKy = ISNULL((
					 select TOP 1 RemainingAmountAccrued 
					 from [dbo].[AM_DebtModel]  as p
					 where p.SupplierId = #LstSupplierInfo.SupplierId 
					 AND (@ToDate IS NULL OR Cast(TimeOfDebt as date) <= @ToDate) 
					 order by TimeOfDebt desc
					),0)
  --select @FromDate, @ToDate

  select *
  from #LstSupplierInfo
  --exec usp_DanhSachNoPhaiTraNhaCungCap '2016-10-5',null
END

GO
/****** Object:  StoredProcedure [dbo].[usp_DanhSachXuatNhapTon_PhongTest]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_DanhSachXuatNhapTon_PhongTest]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	SET NOCOUNT ON;
    IF exists (select NAME from sysobjects where NAME = '#HeaderInfomation')--Chỉ chạy trong Store
    BEGIN
		drop table #HeaderInfomation
    END
    
    IF exists (select NAME from sysobjects where NAME = '#Detail')
    BEGIN
		drop table #Detail
    END
    
    IF exists (select NAME from sysobjects where NAME = '#Price')
    BEGIN
		drop table #Price
    END

    
	CREATE TABLE #HeaderInfomation(
		PrintTime DATETIME,
		TotalProduct int
	)
	
	CREATE TABLE #Detail(
		STT INT,
		ProductId INT,
		ProductName NVARCHAR(500),
		COGS decimal(18, 2),
		Price1 decimal(18, 2),
		Price2 decimal(18, 2),
		Price3 decimal(18, 2),
		EndInventoryQty decimal(18, 2),
		 )	
	insert into #HeaderInfomation 
	(
		PrintTime,
		TotalProduct
	)
	SELECT GETDATE(),
	       COUNT(distinct ivd.ProductId)
	FROM InventoryDetailModel AS ivd  

	insert into #Detail (
			STT ,
			ProductId,
			ProductName,
			COGS ,
			EndInventoryQty
		)
	
    SELECT ROW_NUMBER()Over(Order by InventoryDetailId ),
		  pd.ProductId,
		  pd.ProductName,
		  ivd.COGS,
		  ivd.EndInventoryQty
    FROM InventoryDetailModel ivd
         LEFT JOIN ProductModel pd ON ivd.ProductId = pd.ProductId
    WHERE InventoryDetailId IN 
		 ( SELECT MAX(InventoryDetailId) 
		   FROM InventoryDetailModel 
		   GROUP BY ProductId )
	ORDER BY ivd.InventoryDetailId	 
	-- Update price1,2,3
	UPDATE #Detail
	SET Price1 = (SELECT Price FROM ProductPriceModel WHERE #Detail.ProductId = ProductPriceModel.ProductId and ProductPriceModel.CustomerLevelId = 1 )

	UPDATE #Detail
	SET Price2 = (SELECT Price FROM ProductPriceModel WHERE #Detail.ProductId = ProductPriceModel.ProductId and ProductPriceModel.CustomerLevelId = 2 )
	
	UPDATE #Detail
	SET Price3 = (SELECT Price FROM ProductPriceModel WHERE #Detail.ProductId = ProductPriceModel.ProductId and ProductPriceModel.CustomerLevelId = 3 )



	SELECT PrintTime,
		   TotalProduct
	FROM  #HeaderInfomation
	
	SELECT 
		STT ,
		ProductId,
		ProductName ,
		COGS ,
		Price1 ,
		Price2,
		Price3,
		EndInventoryQty
	 FROM  #Detail
	
END
--EXEC [usp_DanhSachXuatNhapTon_PhongTest]

GO
/****** Object:  StoredProcedure [dbo].[usp_DanhSachXuatNhapTonSP]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_DanhSachXuatNhapTonSP]
		--@CategoryId int ,
		--@ProductId int,
		--@InventoryMasterId int,
		--@EmployeeId int ,
		--@FromDate datetime,
		--@ToDate datetime,
		--@WarehouseId datetime 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	SET NOCOUNT ON;
    IF exists (select NAME from sysobjects where NAME = '#Detail')--Chỉ chạy trong Store
    BEGIN
		drop table #Detail
    END
    IF exists (select NAME from sysobjects where NAME = '#HeaderInfomation')--Chỉ chạy trong Store
    BEGIN
		drop table #HeaderInfomation
    END
    
     
	CREATE TABLE #HeaderInfomation(
		PrintTime DATETIME,
		TotalProduct int
	)
	
	insert into #HeaderInfomation 
	(
		PrintTime,
		TotalProduct
	)
	SELECT GETDATE(),
	       COUNT(distinct ivd.ProductId)
	FROM InventoryDetailModel AS ivd  
	
	CREATE TABLE #Detail(
        InventoryDetailId INT,    
        InventoryTypeCode NVARCHAR(500),
        EmployeeName NVARCHAR(500),
        CreatedDate DATETIME,
        ProductName NVARCHAR(500),
        BeginInventoryQty decimal,
        COGS decimal,
        Price decimal,
        ImportQty decimal,
        ExportQty decimal,
        UnitPrice decimal,
        EndInventoryQty decimal,
        ActionUrl NVARCHAR(500),
        BusinessId INT,
        InventoryCode NVARCHAR(500)
		 )	   	
	--- Insert Detail
	insert into #Detail (
			InventoryDetailId ,
			InventoryTypeCode,
			EmployeeName,
			CreatedDate,
			ProductName,
			BeginInventoryQty,
			COGS ,
			Price ,
			ImportQty,
			ExportQty,
			UnitPrice,
			EndInventoryQty,
			ActionUrl,
			BusinessId,
			InventoryCode
		)
	
    SELECT
			ivd.InventoryDetailId ,
			ivt.InventoryTypeCode,
			e.FullName,
			ivm.CreatedDate,
			pd.ProductName,
			ivd.BeginInventoryQty,
			ivd.COGS ,
			ivd.Price ,
			ivd.ImportQty,
			ivd.ExportQty,
			ivd.UnitPrice,
			ivd.EndInventoryQty,
			ivm.ActionUrl,
			ivm.BusinessId,
			ivm.InventoryCode
    FROM  InventoryDetailModel ivd
          LEFT JOIN InventoryMasterModel ivm ON ivm.InventoryMasterId = ivd.InventoryMasterId
          LEFT JOIN InventoryTypeModel ivt ON ivm.InventoryTypeId= ivt.InventoryTypeId
          LEFT JOIN ProductModel pd ON ivd.ProductId = pd.ProductId
          LEFT JOIN EmployeeModel e ON ivm.CreatedEmployeeId= e.EmployeeId
		
			--JOIN ProductPriceModel pdr ON pd.ProductId= pdr.ProductId
    WHERE InventoryDetailId IN 
		
		 ( SELECT MAX(InventoryDetailId) 
		   FROM InventoryDetailModel 
		   GROUP BY ProductId )
			--	And
			--(@WarehouseId IS NULL OR ivm.WarehouseModelId =@WarehouseId) AND
			--(@InventoryMasterId IS NULL OR ivm.InventoryMasterId =@InventoryMasterId) AND
			--(@EmployeeId  IS null OR e.EmployeeId =@EmployeeId) AND
	
			--(@ProductId  IS null OR pd.ProductId =@ProductId)
			
	SELECT PrintTime,
		   TotalProduct
	FROM  #HeaderInfomation
			
	SELECT 
		InventoryDetailId ,
		InventoryTypeCode,
		EmployeeName,
		CreatedDate,
		ProductName,
		BeginInventoryQty,
		COGS ,
		Price ,
		ImportQty,
		ExportQty,
		UnitPrice,
		EndInventoryQty,
		ActionUrl,
		BusinessId,
		InventoryCode
	 FROM  #Detail
	
END
--EXEC [usp_DanhSachXuatNhapTonSP]

GO
/****** Object:  StoredProcedure [dbo].[usp_DanhSachXuatNhapTonSp2]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_DanhSachXuatNhapTonSp2]
AS
BEGIN
	SET NOCOUNT ON;
    IF exists (select NAME from sysobjects where NAME = '#HeaderInfomation')--Chỉ chạy trong Store
    BEGIN
		drop table #HeaderInfomation
    END
    
    IF exists (select NAME from sysobjects where NAME = '#Detail')
    BEGIN
		drop table #Detail
    END
    
	CREATE TABLE #HeaderInfomation(
		PrintTime DATETIME,
		TotalProduct int
	)
	
	CREATE TABLE #Detail(
		STT INT,
		ProductId INT,
		ProductName NVARCHAR(500),
		WarehouseName NVARCHAR(500),
		COGS decimal(18, 2),
		Price1 decimal(18, 2),
		--Price2 decimal(18, 2),
		--Price3 decimal(18, 2),
		EndInventoryQty decimal(18, 2),
		 )	
	insert into #HeaderInfomation 
	(
		PrintTime,
		TotalProduct
	)
	SELECT GETDATE(),
	       COUNT(distinct ivd.ProductId)
	FROM InventoryDetailModel AS ivd  

	insert into #Detail (
			STT ,
			ProductId,
			ProductName,
			WarehouseName,
			COGS ,
			EndInventoryQty
		)
	
    SELECT ROW_NUMBER()Over(Order by InventoryDetailId ),
		  pd.ProductId,
		  ISNULL(pd.ProductCode,'') +' | '+ ISNULL(pd.ProductName,'') +' | '+ ISNULL(pd.Specifications,''),
		  wh.WarehouseName,
		  pd.COGS,
		  ivd.EndInventoryQty
    FROM InventoryDetailModel ivd
		 INNER JOIN InventoryMasterModel ivm ON ivd.InventoryMasterId =ivm.InventoryMasterId
         LEFT JOIN ProductModel pd ON ivd.ProductId = pd.ProductId
         LEFT JOIN WarehouseModel wh ON ivm.WarehouseModelId = wh.WarehouseId
    WHERE InventoryDetailId IN 
		 ( SELECT MAX(InventoryDetailId) 
		   FROM InventoryDetailModel 
		   GROUP BY ProductId ) 
	ORDER BY ivd.InventoryDetailId	 
	-- Update price1,2,3
	UPDATE #Detail
	SET Price1 = (SELECT Price FROM ProductPriceModel WHERE #Detail.ProductId = ProductPriceModel.ProductId and ProductPriceModel.CustomerLevelId = 1 )

	--UPDATE #Detail
	--SET Price2 = (SELECT Price FROM ProductPriceModel WHERE #Detail.ProductId = ProductPriceModel.ProductId and ProductPriceModel.CustomerLevelId = 2 )
	
	--UPDATE #Detail
	--SET Price3 = (SELECT Price FROM ProductPriceModel WHERE #Detail.ProductId = ProductPriceModel.ProductId and ProductPriceModel.CustomerLevelId = 3 )



	SELECT PrintTime,
		   TotalProduct
	FROM  #HeaderInfomation
	
	SELECT 
		STT ,
		ProductId,
		ProductName ,
		WarehouseName,
		COGS ,
		Price1 ,
		--Price2,
		--Price3,
		EndInventoryQty
	 FROM  #Detail
	
END
--EXEC [usp_DanhSachXuatNhapTon_PhongTest]

GO
/****** Object:  StoredProcedure [dbo].[usp_Delete_Import_Sell_Invent]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_Delete_Import_Sell_Invent] 
AS
	BEGIN
	--XOÁ KIỂM KHO
	 DELETE
	 FROM [dbo].[WarehouseInventoryDetailModel]
	 DELETE
	 FROM [dbo].[WarehouseInventoryMasterModel]

	 -- XOÁ NHẬP HÀNG NCC
	 DELETE
	 FROM ImportDetailModel
	 DELETE
	 FROM ImportMasterModel
	 
	   -- XOÁ TRẢ HÀNG NCC
	 DELETE
	 FROM ReturnDetailModel
	 DELETE
	 FROM ReturnMasterModel

	 -- XOÁ XUẤT NHÂP KHO KHÁC
	 DELETE
	 FROM IEOtherDetailModel
	 DELETE
	 FROM IEOtherMasterModel

	 
	 -- XOÁ INVENTORY DETAIL
	 DELETE
	 FROM InventoryDetailModel
	 -- XOÁ INVENTORY MASTER
	 DELETE
	 FROM InventoryMasterModel


	  -- XOÁ BÁN HÀNG
	 DELETE
	 FROM OrderDetailModel
	 DELETE
	 FROM OrderMasterModel
	 
	  -- XOÁ KH TRẢ HÀNG
	 DELETE
	 FROM [dbo].[OrderReturnDetailModel]
	 DELETE
	 FROM [dbo].[OrderReturnModel]

	
	 -- Xoá thu chi tiền mặt
	 DELETE
	 FROM [dbo].[AM_TransactionModel]

	 -- Xoá công nợ 
	 DELETE
	 FROM AM_DebtModel
	 ---- Xoá ProductPrice
	 --DELETE
	 --FROM ProductPriceModel
	 
	 ---- Xoá ProductImage
	 --DELETE
	 --FROM ProductImageModel
	 
	 ---- XOÁ Product
	 --DELETE
	 --FROM ProductModel
	 
	END

GO
/****** Object:  StoredProcedure [dbo].[usp_DeMoReport]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_DeMoReport]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	SET NOCOUNT ON;
	
    IF exists (select NAME from sysobjects where NAME = '#HeaderInfomation')--Chỉ chạy trong Store
    BEGIN
		drop table #HeaderInfomation
    END
    
    IF exists (select NAME from sysobjects where NAME = '#Detail')
    BEGIN
		drop table #Detail
    END
    
	CREATE TABLE #HeaderInfomation(
	 Title NVARCHAR(500),
	 CreaterDate DATETIME
	)
	
	CREATE TABLE #Detail(
		STT INT,
		Id INT,
		Name NVARCHAR(500)
	)
	
	insert into #HeaderInfomation (Title ,CreaterDate)
	values (N'Báo Cáo', GETDATE())
	
	--- Insert Detail
	insert into #Detail (STT,Id , Name )values (1, 123, N'Phong')
	insert into #Detail (STT,Id , Name )values (2, 345, N'Nam')
	

	SELECT *
	FROM #HeaderInfomation

	SELECT *
    FROM  #Detail
END
-- EXEC [dbo].[[usp_DeMoReport]] 

GO
/****** Object:  StoredProcedure [dbo].[usp_HoaDon]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vũ Hoài Nam
-- Create date: 30.05.2016
-- Description:	Mẫu in hóa đơn bán hàng
-- =============================================
CREATE PROCEDURE [dbo].[usp_HoaDon]
	-- Add the parameters for the stored procedure here
	@OrderId int
AS
BEGIN
	SET NOCOUNT ON;
	
	CREATE TABLE #HeaderInfomation(
		Title NVARCHAR(500),
		OrderCode NVARCHAR(50),
		CreatedDate DATETIME
	)
	CREATE TABLE #Detail(
		STT INT,
		ProductId INT,
		ProductCode NVARCHAR(500),
		ProductName NVARCHAR(500),
		Qty DECIMAL,
		Price DECIMAL,
		UnitPriceBeforeDiscount DECIMAL,
		UnitDiscount DECIMAL,
		UnitPrice DECIMAL,
		Note NVARCHAR(1000)
	)
	--Create #HeaderInfomation Data
	INSERT #HeaderInfomation
	        ( Title, OrderCode, CreatedDate )
	VALUES  ( N'Phiếu Tính Tiền', -- Title - nvarchar(500)
	          N'PBH-1605-0001', -- OrderCode - nvarchar(50)
	          '2016-05-30 10:03:07'  -- CreatedDate - datetime
	          )
	
	--Create #Detail Data
	INSERT #Detail
	        ( STT ,
	          ProductId ,
	          ProductCode ,
	          ProductName ,
	          Qty ,
	          Price ,
	          UnitPriceBeforeDiscount ,
	          UnitDiscount ,
	          UnitPrice ,
	          Note
	        )
	VALUES  ( 1 , -- STT - int
	          1 , -- ProductId - int
	          N'SP 1' , -- ProductCode - nvarchar(500)
	          N'' , -- ProductName - nvarchar(500)
	          NULL , -- Qty - decimal
	          NULL , -- Price - decimal
	          NULL , -- UnitPriceBeforeDiscount - decimal
	          NULL , -- UnitDiscount - decimal
	          NULL , -- UnitPrice - decimal
	          N''  -- Note - nvarchar(1000)
	        )
	        
	INSERT #Detail
	        ( STT ,
	          ProductId ,
	          ProductCode ,
	          ProductName ,
	          Qty ,
	          Price ,
	          UnitPriceBeforeDiscount ,
	          UnitDiscount ,
	          UnitPrice ,
	          Note
	        )
	VALUES  ( 2 , -- STT - int
	          2 , -- ProductId - int
	          N'SP 2' , -- ProductCode - nvarchar(500)
	          N'' , -- ProductName - nvarchar(500)
	          NULL , -- Qty - decimal
	          NULL , -- Price - decimal
	          NULL , -- UnitPriceBeforeDiscount - decimal
	          NULL , -- UnitDiscount - decimal
	          NULL , -- UnitPrice - decimal
	          N''  -- Note - nvarchar(1000)
	        )
	        
	INSERT #Detail
	        ( STT ,
	          ProductId ,
	          ProductCode ,
	          ProductName ,
	          Qty ,
	          Price ,
	          UnitPriceBeforeDiscount ,
	          UnitDiscount ,
	          UnitPrice ,
	          Note
	        )
	VALUES  ( 3 , -- STT - int
	          3 , -- ProductId - int
	          N'SP 3' , -- ProductCode - nvarchar(500)
	          N'' , -- ProductName - nvarchar(500)
	          NULL , -- Qty - decimal
	          NULL , -- Price - decimal
	          NULL , -- UnitPriceBeforeDiscount - decimal
	          NULL , -- UnitDiscount - decimal
	          NULL , -- UnitPrice - decimal
	          N''  -- Note - nvarchar(1000)
	        )
	SELECT * FROM #HeaderInfomation
	SELECT * FROM #Detail
	
END

GO
/****** Object:  StoredProcedure [dbo].[usp_HoaDonBanHang]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_HoaDonBanHang]
	-- Add the parameters for the stored procedure here
	@OrderId int
AS
BEGIN
	SET NOCOUNT ON;
	
    IF exists (select NAME from sysobjects where NAME = '#HeaderInfomation')--Chỉ chạy trong Store
    BEGIN
		drop table #HeaderInfomation
    END
    
    IF exists (select NAME from sysobjects where NAME = '#Detail')
    BEGIN
		drop table #Detail
    END
    
	CREATE TABLE #HeaderInfomation(
	    Storename NVARCHAR(500),
	    AddressStore NVARCHAR(500),
	    PhoneStore NVARCHAR(500),
	    Titel NVARCHAR(500),
		CustomerName NVARCHAR(500),
		CompanyName NVARCHAR(500),
		[Address] NVARCHAR(500),
		CreateEmployee NVARCHAR(500),
		WarehouseName NVARCHAR(500),
		PrintTime DATETIME,
		OrderCode NVARCHAR(500),
		CreatedDate DATETIME,
		CreatedAccount NVARCHAR(500) NULL,
		TotalPriceConvertToText NVARCHAR(500),
		Note NVARCHAR(500),
		SumPrice decimal,
		BillDiscount nvarchar(50), -- Giảm giá
		BillVAT nvarchar(100), -- VAT (%)
		BillVATValue decimal(18,2),
		TotalPrice DECIMAL,
		GuestAmountPaid decimal,
		RemainingAmount decimal,
		PaymentMethod nvarchar(100), -- Số tiền khách trả (Chuyển khoản, Tiền mặt)
	)
	
	
	CREATE TABLE #Detail(
		STT INT,
		ProductId INT,
		ProductCode NVARCHAR(500),
		ProductName NVARCHAR(500),
		Qty DECIMAL,
		Price DECIMAL,
		UnitPriceBeforeDiscount DECIMAL,
		UnitDiscount DECIMAL,
		UnitPrice DECIMAL,
		Note NVARCHAR(500)
	)
	
	insert into #HeaderInfomation 
	(Storename
	,AddressStore
	,PhoneStore
	,Titel
	,CustomerName
	, CompanyName
	, [Address]
	, CreateEmployee
	, WarehouseName
	, PrintTime
	, OrderCode
	, CreatedDate
	, CreatedAccount
	, TotalPriceConvertToText
	, Note
    , BillDiscount
	, BillVAT
	, BillVATValue
	, TotalPrice
	, PaymentMethod
	, GuestAmountPaid
	, RemainingAmount
	)
	SELECT sm.StoreName 
		 ,sm.[Address]  as AddressStore
		 ,sm.Phone as PhoneStore
		 ,N'HOÁ ĐƠN BÁN HÀNG'
	     ,( ord.FullName + ' - ' + ord.Phone) as CustomerName
		 , ord.CompanyName
		 , (pro.ProvinceName +',' + dis.DistrictName + ' ' + ord.Address ) as [Address]  
		 , em.FullName as CreateEmployee
		 , wa.WarehouseName
		 , GETDATE() as PrintTime
		 , ord.OrderCode
		 , ord.CreatedDate
		 , ord.SaleName 
		 , dbo.Num2Text(ord.TotalPrice) as TotalPriceConvertToText
		 , ord.Note
		 ,REPLACE(CONVERT(nvarchar(50),CASt(ISNULL(ord.BillDiscount,0) as money),1),'.00', '') + ' ' + CASE WHEN ord.BillDiscountTypeId = 2 THEN '%' ELSE '' END 
		 , 'VAT ' + CAST(ISNULL(ord.BillVAT, 0 ) as nvarchar(100) ) +'%' as BillVAT
		 , ord.TotalPrice * (ord.BillVAT * 0.01 ) as  BillVATValue
		 , ord.TotalPrice
		 , CASE WHEN ord.Paid > 0 THEN N'Số tiền khách trả (tiền mặt) : ' WHEN ord.MoneyTransfer > 0 THEN N'Số tiền khách trả (chuyển khoản) : ' ELSE N'Số tiền khách trả : ' END
		 , ord.Paid + ord.MoneyTransfer 
		 , ord.RemainingAmount
	FROM OrderMasterModel ord
	LEFT JOIN ProvinceModel as pro on ord.ProvinceId = pro.ProvinceId 
	LEFT JOIN DistrictModel as dis on ord.DistrictId = dis.DistrictId 
	INNER JOIN WarehouseModel as wa on ord.WarehouseId = wa.WarehouseId 
	--INNER JOIN AccountModel as ac on ac.UserName = ord.CreatedAccount 
	LEFT JOIN EmployeeModel EM ON ord.CreatedEmployeeId = em.EmployeeId
	LEFT JOIN StoreModel sm on ord.StoreId = sm.StoreId 
	Where ord.OrderId = @OrderId
	-- update Quận - thành phố
	UPDATE #HeaderInfomation
	SET AddressStore = AddressStore + 
									  (SELECT (', ' + DIST.Appellation + ' ' + DIST.DistrictName + ', ' + ProvinceModel.ProvinceName) AS name
									   FROM OrderMasterModel AS ord
									   INNER JOIN StoreModel ON ORD.StoreId = StoreModel.StoreId
									   INNER JOIN ProvinceModel ON StoreModel.ProvinceId = ProvinceModel.ProvinceId
									   INNER JOIN DistrictModel AS DIST ON StoreModel.DistrictId = DIST.DistrictId
									   WHERE ord.OrderId = @OrderId
									   )
	
	update #HeaderInfomation
	set SumPrice = 
	(
		Select Sum(detail.UnitPrice) 
		from OrderDetailModel as detail
		WHERE detail.OrderId = @OrderId
		--GROUP BY @OrderId
	)
	--- Insert Detail
	insert into #Detail (
     STT,
     ProductId,
     ProductCode,
     ProductName,
     Qty,
     Price,
	 UnitPriceBeforeDiscount,
	 UnitDiscount,
	 UnitPrice,
	 Note
	)
    SELECT 
         ROW_NUMBER()Over(Order by OrderId ), 
		 detail.ProductId, 
		 p.ProductCode, 
		 p.ProductName, 
		 detail.Quantity, 
		 detail.Price,
		 detail.Price * detail.Quantity as UnitPriceBeforeDiscount , 
		 detail.UnitDiscount , 
		 detail.UnitPrice,
		 detail.Note
	FROM OrderDetailModel as detail
	     left join ProductModel as p on detail.ProductId = p.ProductId
	WHERE OrderId = @OrderId
	Order by OrderId

	SELECT Storename
	,AddressStore
	,PhoneStore
	,Titel
	,CustomerName
	, CompanyName
	, [Address]
	, CreateEmployee
	, WarehouseName
	, PrintTime
	, OrderCode
	, CreatedDate
	, CreatedAccount
	, TotalPriceConvertToText
	, Note
    , ISNULL(BillDiscount,0) as BillDiscount
	, BillVAT
	, ISNULL(BillVATValue,0) AS BillVATValue
	, ISNULL(TotalPrice,0) as TotalPrice
	, ISNULL(SumPrice,0) as SumPrice
	, PaymentMethod
	, GuestAmountPaid
	, RemainingAmount
	FROM  #HeaderInfomation
	
	SELECT 
	 STT,
     ProductId,
     ProductCode,
     ProductName,
     Qty,
     Price,
	 UnitPriceBeforeDiscount,
	 UnitDiscount,
	 UnitPrice,
	 Note
	 FROM  #Detail
END
-- EXEC [dbo].[usp_HoaDonBanHang] 1068

GO
/****** Object:  StoredProcedure [dbo].[usp_HoaDonKhachHangTraHang]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_HoaDonKhachHangTraHang]
	-- Add the parameters for the stored procedure here
	@OrderReturnMasterId int
AS
BEGIN
	SET NOCOUNT ON;
	
    IF exists (select NAME from sysobjects where NAME = '#HeaderInfomation')--Chỉ chạy trong Store
    BEGIN
		drop table #HeaderInfomation
    END
    
    IF exists (select NAME from sysobjects where NAME = '#Detail')
    BEGIN
		drop table #Detail
    END
    
	CREATE TABLE #HeaderInfomation(
	    Storename NVARCHAR(500),
	    AddressStore NVARCHAR(500),
	    PhoneStore NVARCHAR(500),
	    Titel NVARCHAR(500),
		CustomerName NVARCHAR(500),
		CompanyName NVARCHAR(500),
		[Address] NVARCHAR(500),
		CreateEmployee NVARCHAR(500),
		WarehouseName NVARCHAR(500),
		PrintTime DATETIME,
		OrderCode NVARCHAR(500),
		CreatedDate DATETIME,
		CreatedAccount NVARCHAR(500) NULL,
		TotalPriceConvertToText NVARCHAR(500),
		Note NVARCHAR(500),
		SumPrice decimal,
		BillDiscount DECIMAL, -- Giảm giá
		BillVAT nvarchar(100), -- VAT (%)
		BillVATValue decimal(18,2),
		TotalPrice DECIMAL
	)
	
	
	CREATE TABLE #Detail(
		STT INT,
		ProductId INT,
		ProductCode NVARCHAR(500),
		ProductName NVARCHAR(500),
		Qty DECIMAL,
		Price DECIMAL,
		UnitPriceBeforeDiscount DECIMAL,
		UnitDiscount DECIMAL,
		UnitPrice DECIMAL,
		Note NVARCHAR(500)
	)
	
	insert into #HeaderInfomation 
	(Storename
	,AddressStore
	,PhoneStore
	,Titel
	,CustomerName
	, CompanyName
	, [Address]
	, CreateEmployee
	, WarehouseName
	, PrintTime
	, OrderCode
	, CreatedDate
	, CreatedAccount
	, TotalPriceConvertToText
	, Note
    , BillDiscount
	, BillVAT
	, BillVATValue
	, TotalPrice
	)
	SELECT sm.StoreName 
		 ,sm.[Address]  as AddressStore
		 ,sm.Phone as PhoneStore
		 ,N'HOÁ ĐƠN KHÁCH HÀNG TRẢ HÀNG'
	     ,( ord.FullName + ' - ' + ord.Phone) as CustomerName
		 , ord.CompanyName
		 , (pro.ProvinceName +',' + dis.DistrictName + ' ' + ord.Address ) as [Address]  
		 , em.FullName as CreateEmployee
		 , wa.WarehouseName
		 , GETDATE() as PrintTime
		 , p.OrderReturnMasterCode as OrderCode
		 , p.CreatedDate
		 , ord.SaleName 
		 , dbo.Num2Text(p.TotalPrice) as TotalPriceConvertToText
		 , p.Note
		 , p.BillDiscount
		 , 'VAT ' + CAST(ISNULL(p.BillVAT, 0 ) as nvarchar(100) ) +'%' as BillVAT
		 , p.TotalPrice * (p.BillVAT * 0.01 ) as  BillVATValue
		 , p.TotalPrice
	FROM [dbo].[OrderReturnModel] as p
	inner join OrderMasterModel ord on p.OrderId = ord.OrderId
	LEFT JOIN ProvinceModel as pro on ord.ProvinceId = pro.ProvinceId 
	LEFT JOIN DistrictModel as dis on ord.DistrictId = dis.DistrictId 
	INNER JOIN WarehouseModel as wa on ord.WarehouseId = wa.WarehouseId 
	--INNER JOIN AccountModel as ac on ac.UserName = ord.CreatedAccount 
	LEFT JOIN EmployeeModel EM ON ord.CreatedEmployeeId = em.EmployeeId
	LEFT JOIN StoreModel sm on ord.StoreId = sm.StoreId 
	Where p.OrderReturnMasterId = @OrderReturnMasterId
	-- update Quận - thành phố
	UPDATE #HeaderInfomation
	SET AddressStore = AddressStore + 
									  (SELECT (', ' + DIST.Appellation + ' ' + DIST.DistrictName + ', ' + ProvinceModel.ProvinceName) AS name
									   FROM OrderMasterModel AS ord
									   INNER JOIN [dbo].[OrderReturnModel] p ON p.OrderId = ord.OrderId
									   INNER JOIN StoreModel ON ORD.StoreId = StoreModel.StoreId
									   INNER JOIN ProvinceModel ON StoreModel.ProvinceId = ProvinceModel.ProvinceId
									   INNER JOIN DistrictModel AS DIST ON StoreModel.DistrictId = DIST.DistrictId
									   WHERE p.OrderReturnMasterId = @OrderReturnMasterId
									   )
	
	update #HeaderInfomation
	set SumPrice = 
	(
		Select Sum(detail.UnitPrice) 
		from OrderReturnDetailModel as detail
		WHERE detail.OrderReturnId = @OrderReturnMasterId
		--GROUP BY @OrderId
	)
	--- Insert Detail
	insert into #Detail (
     STT,
     ProductId,
     ProductCode,
     ProductName,
     Qty,
     Price,
	 UnitPriceBeforeDiscount,
	 UnitDiscount,
	 UnitPrice,
	 Note
	)
    SELECT 
         ROW_NUMBER()Over(Order by OrderReturnId ), 
		 detail.ProductId, 
		 p.ProductCode, 
		 p.ProductName, 
		 detail.ReturnQuantity, 
		 detail.Price,
		 detail.Price * detail.ReturnQuantity as UnitPriceBeforeDiscount , 
		 CAST(0 AS decimal(18,2) ), 
		 detail.UnitPrice,
		 detail.Note
	FROM OrderReturnDetailModel as detail
	     left join ProductModel as p on detail.ProductId = p.ProductId
	WHERE OrderReturnId = @OrderReturnMasterId
	Order by OrderReturnId

	SELECT Storename
	,AddressStore
	,PhoneStore
	,Titel
	,CustomerName
	, CompanyName
	, [Address]
	, CreateEmployee
	, WarehouseName
	, PrintTime
	, OrderCode
	, CreatedDate
	, CreatedAccount
	, TotalPriceConvertToText
	, Note
    , ISNULL(BillDiscount,0) as BillDiscount
	, BillVAT
	, ISNULL(BillVATValue,0) AS BillVATValue
	, ISNULL(TotalPrice,0) as TotalPrice
	, ISNULL(SumPrice,0) as SumPrice 
	FROM  #HeaderInfomation
	
	SELECT 
	 STT,
     ProductId,
     ProductCode,
     ProductName,
     Qty,
     Price,
	 UnitPriceBeforeDiscount,
	 UnitDiscount,
	 UnitPrice,
	 Note
	 FROM  #Detail
END
-- EXEC [usp_HoaDonKhachHangTraHang] 2

GO
/****** Object:  StoredProcedure [dbo].[usp_HoaDonNhapNhaCungCap]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_HoaDonNhapNhaCungCap]
	-- Add the parameters for the stored procedure here
	@ImportMasterId int
AS
BEGIN
	SET NOCOUNT ON;
	-- Select for Header
	 SELECT sup.SupplierName,
	        wa.WarehouseName,
		    GETDATE() as PrintTime,
			im.ImportMasterCode as ImportMasterId,
			im.CreatedDate,
			em.FullName as CreatedAccount,
			im.TotalPrice,
			dbo.Num2Text (im.TotalPrice) as TotalPriceConvertToText,
			im.Note,
			REPLACE(CONVERT(nvarchar(50),CASt(ISNULL(im.ManualDiscount,0) as money),1),'.00', '') + ' ' + CASE WHEN im.ManualDiscountType = 'PERCENT' THEN '%' ELSE '' END  as BillDiscount,
			'VAT ' + CAST(CAST(ISNULL(im.VATValue, 0 ) AS int) as nvarchar(100) ) +'%' as BillVAT,
			im.TotalVAT as BillVATValue,
			im.Paid as GuestAmountPaid,
			im.RemainingAmount,
			im.SumPriceOfOrderDetail as Sumprice
	FROM ImportMasterModel as im, SupplierModel as sup, WarehouseModel as wa, AccountModel as ac, EmployeeModel as em
	WHERE sup.SupplierId = im.SupplierId and wa.WarehouseId = im.WarehouseId and ac.UserName = im.CreatedAccount and em.EmployeeId = ac.EmployeeId and im.ImportMasterId = @ImportMasterId
    
	
	-- Select for Detail
    SELECT ROW_NUMBER()over( order by ImportDetailId) as STT
		   ,pro.ProductCode as ProductId
		   , pro.ProductName
		   , imdetail.Qty
		   , imdetail.Price
		   , imdetail.UnitPrice
		   , ISNULL(imdetail.ShippingFee, 0) as ShippingFee
    FROM ImportDetailModel as imdetail , ProductModel as pro
    WHERE imdetail.ProductId = pro.ProductId and imdetail.ImportMasterId = @ImportMasterId

END
--EXEC usp_HoaDonNhapNhaCungCap 1131
GO
/****** Object:  StoredProcedure [dbo].[usp_HoaDonTraHangNhaCungCap]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_HoaDonTraHangNhaCungCap]
	-- Add the parameters for the stored procedure here
	@ReturnMasterId int
AS
BEGIN
	SET NOCOUNT ON;
	-- Select for Header
	SELECT sup.SupplierName,
		   wa.WarehouseName, 
		   GETDATE() as PrintTime, 
		   im.ReturnMasterCode as ImportMasterId, 
		   im.CreatedDate,
		   em.FullName as CreatedAccount,
		   im.TotalPrice,
		   dbo.Num2Text (im.TotalPrice) as TotalPriceConvertToText,
		   im.Note
	FROM ReturnMasterModel as im
	inner join SupplierModel as sup on sup.SupplierId = im.SupplierId
    inner join WarehouseModel as wa on wa.WarehouseId = im.WarehouseId
	inner join AccountModel as ac on ac.UserName = im.CreatedAccount
	inner join EmployeeModel as em on  em.EmployeeId = ac.EmployeeId
	WHERE im.ReturnMasterId = @ReturnMasterId
    
	
	-- Select for Detail
    SELECT ROW_NUMBER()over( order by ReturnMasterId) as STT,
		   pro.ProductCode as ProductId, 
		   pro.ProductName, 
		   imdetail.ReturnQty as Qty,
		   imdetail.Price, 
		   imdetail.UnitPrice
    FROM ReturnDetailModel as imdetail 
	inner join ProductModel as pro on imdetail.ProductId = pro.ProductId
    WHERE imdetail.ReturnMasterId = @ReturnMasterId

END

GO
/****** Object:  StoredProcedure [dbo].[usp_HoaDonXuatNhapKhac]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_HoaDonXuatNhapKhac]
	-- Add the parameters for the stored procedure here
	@IEOtherMasterId int
AS
BEGIN
	SET NOCOUNT ON;
    IF exists (select NAME from sysobjects where NAME = '#HeaderInfomation')--Chỉ chạy trong Store
    BEGIN
		drop table #HeaderInfomation
    END
    
    IF exists (select NAME from sysobjects where NAME = '#Detail')
    BEGIN
		drop table #Detail
    END
    
	CREATE TABLE #HeaderInfomation(
		InventoryTypeName NVARCHAR(500),
		WarehouseName NVARCHAR(500),
		PrintTime DATETIME,
		IEOtherMasterCode NVARCHAR(500),
		CreatedDate DATETIME,
		CreatedAccount NVARCHAR(500) NULL,
		TotalPrice DECIMAL,
		TotalPriceConvertToText NVARCHAR(500),
		Note NVARCHAR(500),
		CustomerName NVARCHAR(500)
	)
	
	
	CREATE TABLE #Detail(
		STT INT,
		ProductId NVARCHAR(500),
		ProductName NVARCHAR(500),
		Qty DECIMAL,
		Price DECIMAL,
		UnitPrice DECIMAL,
		Note NVARCHAR(500)
	)
	
	insert into #HeaderInfomation 
	(
		InventoryTypeName ,
		WarehouseName ,
		PrintTime ,
		IEOtherMasterCode ,
		CreatedDate ,
		CreatedAccount ,
		TotalPrice ,
		TotalPriceConvertToText,
		Note ,
		CustomerName 
	)
	SELECT INVENTYPE.InventoryTypeName,
		   WM.WarehouseName, GETDATE(), 
		   IEOmaster.IEOtherMasterCode, 
		   IEOmaster.CreatedDate, 
		   IEOmaster.CreatedAccount, 
		   IEOmaster.TotalPrice,
		   dbo.Num2Text(IEOmaster.TotalPrice),
		   IEOmaster.Note,
		   IEOmaster.CustomerName + '-' + IEOmaster.Phone
	FROM IEOtherMasterModel as IEOmaster 
		 INNER JOIN InventoryTypeModel AS INVENTYPE ON IEOmaster.InventoryTypeId = INVENTYPE.InventoryTypeId
		 INNER JOIN WarehouseModel AS WM ON IEOmaster.WarehouseId = WM.WarehouseId
	WHERE IEOmaster.IEOtherMasterId = @IEOtherMasterId
	
	----- Insert Detail
	insert into #Detail (
		STT ,
		ProductId ,
		ProductName ,
		Qty ,
		Price ,
		UnitPrice ,
		Note 
		)
    SELECT ROW_NUMBER()Over(Order by IEOtherDetailId ), 
		   PM.ProductCode,
		   PM.ProductName,
		   CASE WHEN Detail.ImportQty = 0 THEN Detail.ExportQty ELSE Detail.ImportQty END,
		   detail.Price,
		   detail.UnitPrice,
		   detail.Note
    FROM IEOtherDetailModel as detail
		 LEFT JOIN ProductModel AS PM ON detail.ProductId = PM.ProductId
	WHERE Detail.IEOtherMasterId  = @IEOtherMasterId
	ORDER BY IEOtherDetailId	 
         

	SELECT InventoryTypeName ,
		WarehouseName ,
		PrintTime ,
		IEOtherMasterCode ,
		CreatedDate ,
		CreatedAccount ,
		ISNULL(TotalPrice,0) AS TotalPrice  ,
		TotalPriceConvertToText,
		Note ,
		CustomerName  
	FROM  #HeaderInfomation
	
	SELECT 
	    STT ,
		ProductId ,
		ProductName ,
		Qty ,
		Price ,
		UnitPrice ,
		Note 
	 FROM  #Detail
END
-- EXEC [dbo].[usp_HoaDonXuatNhapKhac] 1000

GO
/****** Object:  StoredProcedure [dbo].[usp_HoaDonYeuCauNhapHangTuNhaCungCap]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_HoaDonYeuCauNhapHangTuNhaCungCap]
	@PreImportMasterId int
AS
BEGIN
	SET NOCOUNT ON;
	-- Select for Header
	 SELECT sup.SupplierName,
	        wa.WarehouseName,
		    GETDATE() as PrintTime,
			im.PreImportMasterCode as ImportMasterId,
			im.CreatedDate,
			em.FullName as CreatedAccount,
			im.TotalPrice,
			dbo.Num2Text (im.TotalPrice) as TotalPriceConvertToText,
			im.Note,
			REPLACE(CONVERT(nvarchar(50),CASt(ISNULL(im.ManualDiscount,0) as money),1),'.00', '') + ' ' + CASE WHEN im.ManualDiscountType = 'PERCENT' THEN '%' ELSE '' END  as BillDiscount,
			'VAT ' + CAST(CAST(ISNULL(im.VATValue, 0 ) AS int) as nvarchar(100) ) +'%' as BillVAT,
			im.TotalVAT as BillVATValue,
			im.Paid as GuestAmountPaid,
			im.RemainingAmount,
			im.SumPriceOfOrderDetail as Sumprice
	FROM PreImportMasterModel as im
	inner join SupplierModel as sup on sup.SupplierId = im.SupplierId
	inner join WarehouseModel as wa on wa.WarehouseId = im.WarehouseId
	inner join AccountModel as ac on ac.UserName = im.CreatedAccount
	inner join EmployeeModel as em on em.EmployeeId = ac.EmployeeId
	WHERE im.PreImportMasterId = @PreImportMasterId and im.Actived = 1
    
	
	-- Select for Detail
    SELECT ROW_NUMBER()over( order by PreImportDetailId) as STT
		   ,pro.ProductCode as ProductId
		   , pro.ProductName
		   , imdetail.Qty
		   , imdetail.Price
		   , imdetail.UnitPrice
		   , ISNULL(imdetail.ShippingFee, 0) as ShippingFee
    FROM PreImportDetailModel as imdetail
	INNER JOIN ProductModel as pro on imdetail.ProductId = pro.ProductId
    WHERE imdetail.PreImportMasterId = @PreImportMasterId

END
--EXEC usp_HoaDonYeuCauNhapHangTuNhaCungCap 1001
GO
/****** Object:  StoredProcedure [dbo].[usp_IEOtherCanceled]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_IEOtherCanceled] (@IEOtherMasterId INT, @DeletedDate DATETIME, @DeletedAccount nvarchar(50), @DeletedEmployeeId int)
AS
	BEGIN
		BEGIN TRAN
			BEGIN TRY
			    -- Thieu 1: lay cai actived = true moi lam
			    -- Thieu 2: set actived = false cua inventory master
			    IF ((SELECT Actived FROM IEOtherMasterModel WHERE IEOtherMasterId = @IEOtherMasterId) = 1)
			    BEGIN
					UPDATE IEOtherMasterModel
					SET Actived = 0,
						DeletedDate = @DeletedDate,
						DeletedAccount = @DeletedAccount,
						DeletedEmployeeId = @DeletedEmployeeId
					WHERE IEOtherMasterId = @IEOtherMasterId
			   
					-- Bước 2 : 
						--1.lấy CreateDate để so sánh CreateDate trong InventoryMasterModel : Lọc ra danh sách cần cập nhật
						  DECLARE @CreatedDate DATETIME;
						  SELECT @CreatedDate = InvenMaster.CreatedDate
						  FROM InventoryMasterModel InvenMaster
						  WHERE  InvenMaster.BusinessId = @IEOtherMasterId and 
								 InvenMaster.BusinessName='IEOtherMasterModel'
						  --Xét actived = false cua inventory master
						  UPDATE InventoryMasterModel
						  SET Actived = 0,
							  DeletedDate = @DeletedDate,
							  DeletedAccount = @DeletedAccount,
						      DeletedEmployeeId = @DeletedEmployeeId
						  WHERE BusinessId = @IEOtherMasterId and 
								BusinessName='IEOtherMasterModel'
						
						IF exists (select NAME from sysobjects where NAME = '#IEOtherDetail')
						BEGIN
							drop table #IEOtherDetail
						END
						CREATE TABLE #IEOtherDetail(
							ProductId int,
							Qty decimal
						)
						insert into #IEOtherDetail
						SELECT DETAIL.ProductId, (CASE WHEN ImportQty !=0 THEN ImportQty ELSE ExportQty END )
						FROM IEOtherDetailModel AS DETAIL
						     INNER JOIN IEOtherMasterModel AS IEOTHERMASTER ON IEOTHERMASTER.IEOtherMasterId = DETAIL.IEOtherMasterId
						WHERE IEOTHERMASTER.IEOtherMasterId = @IEOtherMasterId
						 -- TEST
						 SELECT *
						 FROM #IEOtherDetail
						
						
						--3. Lấy ra danh sách sản phẩm cần update sau  @CreatedDate
						 -- Bảng tạm 2 : Lấy InventoryDetailId, ProductId, Qty;
						IF exists (select NAME from sysobjects where NAME = '#InvenDetail')
						BEGIN
							drop table #InvenDetail
						END
						CREATE TABLE #InvenDetail(
							InventoryDetailId int,
							ProductId int,
							Qty decimal
						)
						INSERT INTO #InvenDetail (InventoryDetailId, ProductId, Qty)
						SELECT InvenDetail.InventoryDetailId, InvenDetail.ProductId , tblTempt.Qty
							FROM InventoryDetailModel InvenDetail
							INNER JOIN InventoryMasterModel InvenMaster on InvenMaster.InventoryMasterId =  InvenDetail.InventoryMasterId
							, (SELECT #IEOtherDetail.ProductId, #IEOtherDetail.Qty
								FROM  #IEOtherDetail) as tblTempt
							WHERE InvenMaster.CreatedDate > @CreatedDate AND InvenDetail.ProductId = tblTempt.ProductId
						 -- TEST
						 SELECT *
						 FROM #InvenDetail
						
						-- Update
						-- xác đinh nhập hay xuất
						DECLARE @IsImport int;
						SELECT @IsImport = InventoryTypeModel.isImport
						FROM IEOtherMasterModel AS IEOtherMaster
							INNER JOIN InventoryTypeModel ON InventoryTypeModel.InventoryTypeId = IEOtherMaster.InventoryTypeId
						IF(@IsImport = 1)	
							BEGIN
								Update InventoryDetailModel
								SET BeginInventoryQty = BeginInventoryQty - (Select Qty from #InvenDetail Where #InvenDetail.InventoryDetailId = InventoryDetailModel.InventoryDetailId and ProductId = InventoryDetailModel.ProductId)	
								, EndInventoryQty = BeginInventoryQty + ImportQty - ExportQty - (Select Qty from #InvenDetail Where #InvenDetail.InventoryDetailId = InventoryDetailModel.InventoryDetailId and ProductId = InventoryDetailModel.ProductId)	
								Where InventoryDetailId in (Select InventoryDetailId from #InvenDetail)
							END
						ELSE
							BEGIN
								Update InventoryDetailModel
								SET BeginInventoryQty = BeginInventoryQty + (Select Qty from #InvenDetail Where #InvenDetail.InventoryDetailId = InventoryDetailModel.InventoryDetailId and ProductId = InventoryDetailModel.ProductId)	
								, EndInventoryQty = BeginInventoryQty + ImportQty - ExportQty - (Select Qty from #InvenDetail Where #InvenDetail.InventoryDetailId = InventoryDetailModel.InventoryDetailId and ProductId = InventoryDetailModel.ProductId)	
								Where InventoryDetailId in (Select InventoryDetailId from #InvenDetail)
							END	
			  COMMIT TRAN;
			  --PRINT @@TRANCOUNT
			  END
			END TRY
			BEGIN CATCH
					IF @@Trancount > 0
					ROLLBACK TRAN;
			END CATCH
	END

GO
/****** Object:  StoredProcedure [dbo].[usp_ImportCanceled]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_ImportCanceled] (@ImportMasterId INT, @DeletedDate DATETIME, @DeletedAccount nvarchar(50), @DeletedEmployeeId int)
AS
	BEGIN
		BEGIN TRAN
			BEGIN TRY
			--PRINT @@TRANCOUNT
			    -- Bước 1
			    -- Thieu 1: lay cai actived = true moi lam
			    -- Thieu 2: set actived = false cua inventory master
			    IF ((SELECT Actived FROM ImportMasterModel WHERE ImportMasterId = @ImportMasterId) = 1)
			    BEGIN
					UPDATE ImportMasterModel
					SET Actived = 0,
						DeletedDate = @DeletedDate,
						DeletedAccount = @DeletedAccount,
						DeletedEmployeeId = @DeletedEmployeeId
					WHERE ImportMasterId = @ImportMasterId
					-- Bước 2 : 
						--1.lấy CreateDate để so sánh CreateDate trong InventoryMasterModel : Lọc ra danh sách cần cập nhật
						  DECLARE @CreatedDate DATETIME;
						  SELECT @CreatedDate = InvenMaster.CreatedDate
						  FROM InventoryMasterModel InvenMaster
						  WHERE  InvenMaster.BusinessId = @ImportMasterId and 
								 InvenMaster.BusinessName='ImportMasterModel'
						  --Xét actived = false cua inventory master
						  UPDATE InventoryMasterModel
						  SET Actived = 0,
							  DeletedDate = @DeletedDate,
							  DeletedAccount = @DeletedAccount,
						      DeletedEmployeeId = @DeletedEmployeeId
						  WHERE BusinessId = @ImportMasterId and 
								BusinessName='ImportMasterModel'
						
						IF exists (select NAME from sysobjects where NAME = '#ImportDetail')
						BEGIN
							drop table #ImportDetail
						END
						CREATE TABLE #ImportDetail(
							ProductId int,
							Qty decimal
						)
						insert into #ImportDetail
						SELECT ImportDetail.ProductId, ImportDetail.Qty
						  FROM ImportMasterModel ImportMaster
						  INNER JOIN ImportDetailModel ImportDetail on ImportMaster.ImportMasterId = ImportDetail.ImportMasterId
						  WHERE ImportMaster.ImportMasterId = @ImportMasterId
						
						--3. Lấy ra danh sách sản phẩm cần update sau  @CreatedDate
						 -- Bảng tạm 2 : Lấy InventoryDetailId, ProductId, Qty;
						IF exists (select NAME from sysobjects where NAME = '#InvenDetail')
						BEGIN
							drop table #InvenDetail
						END
						CREATE TABLE #InvenDetail(
							InventoryDetailId int,
							ProductId int,
							Qty decimal
						)
						INSERT INTO #InvenDetail (InventoryDetailId, ProductId, Qty)
						SELECT InvenDetail.InventoryDetailId, InvenDetail.ProductId , tblTempt.Qty
							FROM InventoryDetailModel InvenDetail
							INNER JOIN InventoryMasterModel InvenMaster on InvenMaster.InventoryMasterId =  InvenDetail.InventoryMasterId
							, (SELECT #ImportDetail.ProductId, #ImportDetail.Qty
								FROM  #ImportDetail) as tblTempt
							WHERE InvenMaster.CreatedDate > @CreatedDate AND InvenDetail.ProductId = tblTempt.ProductId
						-- Update
						Update InventoryDetailModel
						SET BeginInventoryQty = BeginInventoryQty - (Select Qty from #InvenDetail Where #InvenDetail.InventoryDetailId = InventoryDetailModel.InventoryDetailId and ProductId = InventoryDetailModel.ProductId)	
						, EndInventoryQty = BeginInventoryQty + ISNULL(ImportQty,0) - ISNULL(ExportQty,0) - (Select Qty from #InvenDetail Where #InvenDetail.InventoryDetailId = InventoryDetailModel.InventoryDetailId and ProductId = InventoryDetailModel.ProductId)	
						Where InventoryDetailId in (Select InventoryDetailId from #InvenDetail)
						
						--Cập nhật công nợ NCC khi huỷ đơn nhập hàng
						--B1. Lấy CreadateImport và RemainingAmount, @SuplierId
						DECLARE @CreadateImport datetime,@RemainingAmount decimal(18,2),@SuplierId int
						SELECT @SuplierId = SupplierId,@RemainingAmount = RemainingAmount
						FROM ImportMasterModel
						WHERE ImportMasterId = @ImportMasterId

						SELECT @CreadateImport = TimeOfDebt
						FROM AM_DebtModel
						WHERE ImportId = @ImportMasterId
						--B2. Cập nhật lại RemainingAmountAccrued  của AM_DebtModel có TimeOfDate sau @CreadateImport
						UPDATE AM_DebtModel
						SET RemainingAmountAccrued = RemainingAmountAccrued - @RemainingAmount
						WHERE  TimeOfDebt > @CreadateImport and SupplierId = @SuplierId and ImportId <> @ImportMasterId

						--B3 . Xoá AM_DebtModel có  ImportId = @ImportMasterId
						DELETE 
						FROM AM_DebtModel
						WHERE ImportId = @ImportMasterId
						Select *
						from 	#InvenDetail
							  
						  
			  COMMIT TRAN;
			  --PRINT @@TRANCOUNT
			  END
			END TRY
			BEGIN CATCH
					IF @@Trancount > 0
					ROLLBACK TRAN;
			END CATCH
	END

GO
/****** Object:  StoredProcedure [dbo].[usp_ImportUpdateProduct]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_ImportUpdateProduct]
@UpdateProductList  UpdateProductList Readonly,
@PriceList PriceList Readonly

AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @cols AS NVARCHAR(MAX),
			@colsCustomerLevelId AS NVARCHAR(MAX),
			@queryPriceList  AS NVARCHAR(MAX),
			@query AS NVARCHAR(MAX)

	select @cols = STUFF((SELECT ', Price' + QUOTENAME(CustomerLevelId) 
                    from @PriceList
                    group by CustomerLevelId
                    order by CustomerLevelId
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')

	select @colsCustomerLevelId = STUFF((SELECT ',' + QUOTENAME(CustomerLevelId) 
                    from @PriceList
                    group by CustomerLevelId
                    order by CustomerLevelId
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')

set @queryPriceList ='
SELECT ProductId,' + @colsCustomerLevelId + ' from 
             (
				select p.ProductId,pp.CustomerLevelId, pp.Price
				from @PriceList
            ) x
            pivot 
            (
                sum(Price)
                for CustomerLevelId in (' + @colsCustomerLevelId + ')
            ) p
'
set @query = 
	'Insert into ProductUpdateDetailModel
	(
		ProductUpdateMasterId ,
		ProductId,
		ProductStoreCode,
		ProductCode,
		ProductName,
		ImportPrice,
		ExchangeRate,
		ImportPrice,
		'+@cols+'
	)
	select Update.ProductUpdateMasterId,
	       Update.ProductId,
		   Update.ProductStoreCode,
		   Update.ProductCode,
		   Update.ProductName,
		   Update.ImportPrice,
		   Update.ExchangeRate,
		   Update.ImportPrice,
		   '+@colsCustomerLevelId+'

	from @UpdateProductList Update 
	LEFT JOIN ('+@queryPriceList+') Price on Price.ProductId = Update.ProductId
	'

execute(@query);

END

GO
/****** Object:  StoredProcedure [dbo].[usp_InsertPrice]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertPrice] (
	@CustomerLevelID int
)
AS
BEGIN
SET NOCOUNT ON;
--select * from ProductPriceModel
insert into ProductPriceModel(CustomerLevelId,ProductId, Price)

select @CustomerLevelID as CustomerLevelId, ProductId, 0 as Price
from ProductModel
END
--delete ProductPriceModel where CustomerLevelId = 6
GO
/****** Object:  StoredProcedure [dbo].[usp_ListCheckinfo]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_ListCheckinfo] (
		@ProductId int = NULL,
	    @ProductName nvarchar(500) = NULL,
	    @CustomerLevelId int,
		@txtkhoanggiaduoi int = NULL,
		@txtkhoanggiatren int = NULL,
		@CategoryId int = 2 ,
		@OriginOfProductId int = NULL
) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF exists (select NAME from sysobjects where NAME = '#ListCheckinfo')
	BEGIN
		drop table #ListCheckinfo
	END
	CREATE TABLE #ListCheckinfo(
	    STT int,
		ProductId int,
		ProductName nvarchar(500),
		Inventory decimal(18,2),
		ImportPrice decimal(18,2),
		ShippingFee decimal(18,2),
		ExchangeRate decimal(18,2),
		Price1 decimal(18,2),
		--Price2 decimal(18,2),
		--Price3 decimal(18,2),
		--Price4 decimal(18,2),
		OriginOfProduct nvarchar(500),
		ProductStoreCode nvarchar(50),
		ProductCode nvarchar(50),
		Specifications nvarchar(100),
		CategoryName nvarchar(500),
		CategoryId int
	)
	INSERT INTO #ListCheckinfo 
	(
		STT,
		ProductId,
		ProductName,
	--	Inventory,
		OriginOfProduct,
		ImportPrice,
		ShippingFee,
		ExchangeRate,
		Price1,
		--Price2,
		--Price3,
		--Price4,
		ProductStoreCode,
		ProductCode,
		Specifications,
		CategoryName,
		CategoryId
	)
	SELECT	ROW_NUMBER()Over(Order by p.ProductId ),
			p.ProductId,
			p.ProductName,
			orig.OriginOfProductName,
			ISNULL(p.ImportPrice,0) AS ImportPrice,
			ISNULL(p.ShippingFee,0) AS ShippingFee,
			ISNULL(p.ExchangeRate,0) AS ExchangeRate,
			ISNULL(tmp1.Price,0) AS Price1,
			--ISNULL(tmp2.Price,0) AS Price2,
			--ISNULL(tmp3.Price,0) AS Price3,
			--ISNULL(tmp4.Price,0) AS Price4,
			p.ProductStoreCode,
			p.ProductCode,
			p.Specifications,
			cate.CategoryName,
			cate.CategoryId
	FROM ProductModel p
	LEFT JOIN CategoryModel ca on p.[CategoryId] = ca.CategoryId
	LEFT JOIN OriginOfProductModel orig on p.OriginOfProductId = orig.OriginOfProductId
	LEFT JOIN [ProductPriceModel] tmp1 on (tmp1.ProductId  = p.ProductId AND  tmp1.CustomerLevelId = 1)
	LEFT JOIN [CategoryModel] cate on cate.CategoryId = p.CategoryId
	--LEFT JOIN [ProductPriceModel] tmp2 on (tmp2.ProductId  = p.ProductId AND  tmp2.CustomerLevelId = 2) 
	--LEFT JOIN [ProductPriceModel] tmp3 on (tmp3.ProductId  = p.ProductId AND  tmp3.CustomerLevelId = 3)
	--LEFT JOIN [ProductPriceModel] tmp4 on (tmp4.ProductId  = p.ProductId AND  tmp4.CustomerLevelId = 4)
	--LEFT JOIN [dbo].[CustomerLevelModel] cuslevel on (tmp1.CustomerLevelId = cuslevel.CustomerLevelId OR tmp2.CustomerLevelId = cuslevel.CustomerLevelId or tmp3.CustomerLevelId = cuslevel.CustomerLevelId)
	WHERE 
	p.Actived = 1 AND 
	(ca.ADNCode like (SELECT ADNCode FROM CategoryModel WHERE CategoryId = @CategoryId) + '%' ) AND
	(@OriginOfProductId IS NULL OR p.OriginOfProductId = @OriginOfProductId) AND
	(@ProductId IS NULL OR p.ProductId = @ProductId) AND 
	(@ProductName IS NULL OR p.ProductName LIKE + '%' + @ProductName + '%') AND
    (@txtkhoanggiaduoi IS NULL  or (@txtkhoanggiaduoi <= tmp1.Price)) AND
    (@txtkhoanggiatren IS NULL  or (@txtkhoanggiatren >= tmp1.Price)) 
 --  (p.ProductStoreCode IS NOT NULL) 
 -- -- AND @CustomerLevelId = 0 or cuslevel.CustomerLevelId = @CustomerLevelId

	Order by cate.CategoryId,p.ProductId 

	UPDATE #ListCheckinfo
	SET Inventory = (
		SELECT TOP 1 EndInventoryQty
		FROM InventoryDetailModel Indetail
		INNER JOIN InventoryMasterModel Inmaster on Inmaster.InventoryMasterId = Indetail.InventoryMasterId
		WHERE Inmaster.Actived = 1
		AND Indetail.ProductId = #ListCheckinfo.ProductId
		ORDER BY InventoryDetailId desc
	)

	SELECT  STT,
			ProductId,
		    ProductName,
			ISNULL(Inventory,0) AS Inventory,
			ImportPrice,
			ShippingFee,
			ExchangeRate,
			Price1 ,
			--Price2 ,
			--Price3 ,
			--Price4,
			OriginOfProduct ,
			ProductStoreCode ,
			ProductCode,
			Specifications,
			CategoryName,
			CategoryId
   FROM #ListCheckinfo
END

--EXEC [usp_ListCheckinfo]

GO
/****** Object:  StoredProcedure [dbo].[usp_ListCheckinfoDynamic]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_ListCheckinfoDynamic] (
		@ProductId int = NULL,
	    @ProductName nvarchar(500) = NULL,
	    @CustomerLevelId int = Null,
		@txtkhoanggiaduoi int = NULL,
		@txtkhoanggiatren int = NULL,
		@CategoryId int = 2 ,
		@OriginOfProductId int = NULL
) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF exists (select NAME from sysobjects where NAME = '#yt')
	BEGIN
		drop table #yt
	END
	DECLARE @cols AS NVARCHAR(MAX),
		@query  AS NVARCHAR(MAX),
		@cols2  NVARCHAR(MAX),
		@price NVARCHAR(MAX),
		@checkinfor NVARCHAR(MAX),
		@UpdateCheckinfor NVARCHAR(MAX),
		@end NVARCHAR(MAX)

--CREATE TABLE #yt 
--(
--  ProductId int, 
--  CustomerLevelId int, 
--  Price decimal
--)
--INSERT INTO #yt
--(
--  ProductId, 
--  CustomerLevelId,
--  Price
--)
--select p.ProductId,pp.CustomerLevelId, pp.Price
--from ProductModel p
--left join ProductPriceModel pp on pp.ProductId = p.ProductId

select @cols = STUFF((SELECT ',' + QUOTENAME(CustomerLevelId) 
                    from CustomerLevelModel
                    group by CustomerLevelId
                    order by CustomerLevelId
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')
select @cols2
      = STUFF((SELECT ','+ QUOTENAME(CustomerLevelId)+' decimal'
                    from CustomerLevelModel
                    group by CustomerLevelId
                    order by CustomerLevelId
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')

set @price = '
			IF exists (select NAME from sysobjects where NAME = ''#yt2'')
			BEGIN
				drop table #yt2
			END

			CREATE TABLE #yt2 
			(
			  ProductId int,
			  ' + @cols2 + ' 
			)
			INSERT INTO #yt2
			(
			  ProductId, 
			  ' + @cols + '
			)
			SELECT ProductId,' + @cols + ' from 
             (
				 --select ProductId,CustomerLevelId,Price
				--from #yt
				select p.ProductId,pp.CustomerLevelId, pp.Price
				from ProductModel p
				left join ProductPriceModel pp on pp.ProductId = p.ProductId
            ) x
            pivot 
            (
                sum(Price)
                for CustomerLevelId in (' + @cols + ')
            ) p
			'
set @checkinfor =
		'IF exists (select NAME from sysobjects where NAME = ''#ListCheckinfo'')
		BEGIN
			drop table #ListCheckinfo
		END

		CREATE TABLE #ListCheckinfo(
	 --   STT int,
		ProductId int,
		ProductName nvarchar(500),
		Inventory decimal(18,2),
		ImportPrice decimal(18,2),
		ShippingFee decimal(18,2),
		ExchangeRate decimal(18,2),
		' + @cols2 + ' ,
		OriginOfProduct nvarchar(500),
		ProductStoreCode nvarchar(50),
		ProductCode nvarchar(50)
	)
	INSERT INTO #ListCheckinfo 
	(
		--STT,
		ProductId,
		ProductName,
		OriginOfProduct,
		ImportPrice,
		ShippingFee,
		ExchangeRate,
		' + @cols + ',
		ProductStoreCode,
		ProductCode
	)
	SELECT	--ROW_NUMBER()Over(Order by p.ProductId ),
			p.ProductId, 
			p.ProductName,
			orig.OriginOfProductName,
			ISNULL(p.ImportPrice,0) AS ImportPrice,
			ISNULL(p.ShippingFee,0) AS ShippingFee,
			ISNULL(p.ExchangeRate,0) AS ExchangeRate,
			' + @cols + ',
			p.ProductStoreCode,
			p.ProductCode
	FROM ProductModel p
	LEFT JOIN CategoryModel ca on p.[CategoryId] = ca.CategoryId
	LEFT JOIN OriginOfProductModel orig on p.OriginOfProductId = orig.OriginOfProductId
	LEFT JOIN #yt2 price on price.ProductId = p.ProductId
	where
	p.Actived = 1 
 	AND (ca.ADNCode like (SELECT ADNCode FROM CategoryModel WHERE CategoryId = '+ CAST(@CategoryId AS nvarchar(max) ) +' ) + ''%'' ) 
	AND ('+ CAST(ISNULL(@OriginOfProductId, -1 ) AS nvarchar(max) ) +' = -1 OR p.OriginOfProductId = '+ CAST(ISNULL(@OriginOfProductId,-1) AS nvarchar(max) ) +')
	AND ('+ CAST(ISNULL(@ProductId,-1) AS nvarchar(max) ) +'=-1 OR p.ProductId = '+ CAST(ISNULL(@ProductId,-1) AS nvarchar(max) ) +') 
	AND ('+ CAST(ISNULL(@ProductName,-1) AS nvarchar(max) ) +'=-1 OR p.ProductId = '+ CAST(ISNULL(@ProductName,-1) AS nvarchar(max) ) +') 
	--AND ('+ CAST(ISNULL(@txtkhoanggiaduoi,-1) AS nvarchar(max) ) +' =-1  or ('+ CAST(ISNULL(@txtkhoanggiaduoi,-1) AS nvarchar(max) ) +'<= #yt2.[1] or'+ CAST(ISNULL(@txtkhoanggiaduoi,-1) AS nvarchar(max) ) +' <= #yt2.[2] or '+ CAST(ISNULL(@txtkhoanggiaduoi,-1) AS nvarchar(max) ) +'<= #yt2.[3])) 
	--AND ('+ CAST(ISNULL(@txtkhoanggiatren,-1) AS nvarchar(max) ) +'=-1  or ('+ CAST(ISNULL(@txtkhoanggiatren,-1) AS nvarchar(max) ) +'>= #yt2.[1] or'+ CAST(ISNULL(@txtkhoanggiatren,-1) AS nvarchar(max) ) +'>= #yt2.[2] or'+ CAST(ISNULL(@txtkhoanggiatren,-1) AS nvarchar(max) ) +'>= #yt2.[3])) 
	AND (p.ProductStoreCode IS NOT NULL) 
	Order by p.ProductId desc'

set @UpdateCheckinfor='
	UPDATE #ListCheckinfo
	SET Inventory = (
		SELECT TOP 1 EndInventoryQty
		FROM InventoryDetailModel Indetail
		INNER JOIN InventoryMasterModel Inmaster on Inmaster.InventoryMasterId = Indetail.InventoryMasterId
		WHERE Inmaster.Actived = 1
		AND Indetail.ProductId = #ListCheckinfo.ProductId
		ORDER BY InventoryDetailId desc
	)
	'

set @end ='
	SELECT  --STT,
			ProductId,
		    ProductName ,
			Inventory ,
			ImportPrice,
			ShippingFee,
			ExchangeRate,
			' + @cols + ',
			OriginOfProduct ,
			ProductStoreCode ,
			ProductCode
   FROM #ListCheckinfo'

set @query = @price + @checkinfor+ @UpdateCheckinfor + @end;
execute(@query);
END

--EXEC [usp_ListCheckinfoDynamic]
GO
/****** Object:  StoredProcedure [dbo].[usp_ListImportUpdateProduct]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_ListImportUpdateProduct] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @cols AS NVARCHAR(MAX),
		@query  AS NVARCHAR(MAX),
		@cols2  NVARCHAR(MAX),
		@price NVARCHAR(MAX),
		@checkinfor NVARCHAR(MAX),
		@end NVARCHAR(MAX)

select @cols = STUFF((SELECT ',' + QUOTENAME(CustomerLevelId) 
                    from CustomerLevelModel
                    group by CustomerLevelId
                    order by CustomerLevelId
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')
select @cols2
      = STUFF((SELECT ','+ QUOTENAME(CustomerLevelId)+' decimal'
                    from CustomerLevelModel
                    group by CustomerLevelId
                    order by CustomerLevelId
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')

set @price = '
			IF exists (select NAME from sysobjects where NAME = ''#yt2'')
			BEGIN
				drop table #yt2
			END

			CREATE TABLE #yt2 
			(
			  ProductId int,
			  ' + @cols2 + ' 
			)
			INSERT INTO #yt2
			(
			  ProductId, 
			  ' + @cols + '
			)
			SELECT ProductId,' + @cols + ' from 
             (
				select p.ProductId,pp.CustomerLevelId, pp.Price
				from ProductModel p
				left join ProductPriceModel pp on pp.ProductId = p.ProductId
            ) x
            pivot 
            (
                sum(Price)
                for CustomerLevelId in (' + @cols + ')
            ) p
			'
set @checkinfor =
		'IF exists (select NAME from sysobjects where NAME = ''#ListCheckinfo'')
		BEGIN
			drop table #ListCheckinfo
		END

		CREATE TABLE #ListCheckinfo(
	 --   STT int,
		ProductId int,
		ProductName nvarchar(500),
		ImportPrice decimal(18,2),
		ShippingFee decimal(18,2),
		ExchangeRate decimal(18,2),
		' + @cols2 + ' ,
		ProductStoreCode nvarchar(50),
		ProductCode nvarchar(50)
	)
	INSERT INTO #ListCheckinfo 
	(
		ProductId,
		ProductName,
		ImportPrice,
		ShippingFee,
		ExchangeRate,
		' + @cols + ',
		ProductStoreCode,
		ProductCode
	)
	SELECT	
			p.ProductId, 
			p.ProductName,
			ISNULL(p.ImportPrice,0) AS ImportPrice,
			ISNULL(p.ShippingFee,0) AS ShippingFee,
			ISNULL(p.ExchangeRate,0) AS ExchangeRate,
			' + @cols + ',
			p.ProductStoreCode,
			p.ProductCode
	FROM ProductModel p
	LEFT JOIN CategoryModel ca on p.[CategoryId] = ca.CategoryId
	LEFT JOIN #yt2 price on price.ProductId = p.ProductId
	where
	p.Actived = 1 
	AND (p.ProductStoreCode IS NOT NULL) 
	Order by p.ProductId desc'

set @end ='
	SELECT
			ProductId,
			ProductCode,
			ProductStoreCode,
		    ProductName ,
			ImportPrice,
			ShippingFee,
			ExchangeRate,
			' + @cols + '		
   FROM #ListCheckinfo'

set @query = @price + @checkinfor + @end;
execute(@query);
END

--EXEC [usp_ListCheckinfoDynamic]
GO
/****** Object:  StoredProcedure [dbo].[usp_OrderReturnDetailList]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE PROC [dbo].[usp_OrderReturnDetailList](@OrderID int)
  AS
	BEGIN

	Select rd.ProductId, sum(rd.[ReturnQuantity]) as [ReturnQuantity] 
	into #tempTable
	from OrderReturnModel rm 
		inner join OrderReturnDetailModel rd on rm.[OrderReturnMasterId] = rd.[OrderReturnId]
	where rm.[OrderId] = @OrderID and 
		rm.Actived = 1
	group by rd.ProductId

	  SELECT odm.ProductId , 
			pm.ProductName, 
			odm.Price, 
			--idm.ShippingFee, 
			odm.Quantity as [SellQuantity],
		    ISNULL(r.[ReturnQuantity], 0) as  ReturnedQuantity,
			odm.Note
			--idm.UnitShippingWeight,
		    --0 as UnitPrice,
			--idm.UnitCOGS
	  FROM [dbo].[OrderDetailModel] odm
	  inner join ProductModel pm on odm.ProductId = pm.ProductId
	  -- tính số lượng đã trả
	  left join #tempTable r on pm.ProductId =  r.ProductId
	  WHERE odm.OrderId = @OrderID 
	  
	END


	--EXEC [dbo].[usp_OrderReturnDetailList] '1005'

	
	
GO
/****** Object:  StoredProcedure [dbo].[usp_PhieuNhapKho]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_PhieuNhapKho]
	-- Add the parameters for the stored procedure here
	@StoreId int,
	@FromDate Datetime = null,
	@ToDate Datetime = null,
	@SupplierId int = null,
	@EmployeeId int = null
AS
BEGIN
	SET NOCOUNT ON;
	
    IF exists (select NAME from sysobjects where NAME = '#HeaderInfomation')--Chỉ chạy trong Store
    BEGIN
		drop table #HeaderInfomation
    END
    
    IF exists (select NAME from sysobjects where NAME = '#Detail')
    BEGIN
		drop table #Detail
    END
    
	CREATE TABLE #HeaderInfomation(
	    Storename NVARCHAR(500),
	    AddressStore NVARCHAR(500),
	    PhoneStore NVARCHAR(500),
		Govement NVARCHAR(500),
	    Titel NVARCHAR(500),
		PrintTime NVARCHAR(500),
		TotalPrice DECIMAL,
		TotalPriceConvertToText NVARCHAR(500),
		TotalQty DECIMAL
	)
	
	
	CREATE TABLE #Detail(
		STT INT,
		ProductName NVARCHAR(500),
		ProductCode NVARCHAR(500),
		UnitName NVARCHAR(50),
		Qty DECIMAL,
		Price DECIMAL,
		UnitPrice DECIMAL,
		Note NVARCHAR(500)
	)
	
	insert into #HeaderInfomation 
	(
		Storename,
	    AddressStore ,
	    PhoneStore ,
		Govement ,
	    Titel ,
		PrintTime
		--TotalPrice ,
		--TotalPriceConvertToText 
	)
	SELECT sm.StoreName 
		 ,sm.[Address]  as AddressStore
		 ,sm.Phone as PhoneStore
		,N'Mẫu số :  02 -  VT(Ban hành theo QĐ 15/2006/QĐ-BTC ngày 20/03/2006của Bộ Trưởng Bộ Tài Chính)'
		,N'BÁO CÁO NHẬP KHO'
		,CASE WHEN  CONVERT(DATE,@FromDate) = CONVERT(DATE,@ToDate) 
					THEN  N'Ngày ' + Cast( DAY(@FromDate) as NVARCHAR(10)) + N' Tháng ' + CAST(Month(@FromDate) AS nvarchar(10) ) + N' Năm ' + CAST(Year(@FromDate) AS nvarchar(10) ) 
					ELSE  N'Từ ngày ' +Cast( DAY(@FromDate) as NVARCHAR(10))+'/'+Cast( Month(@FromDate) as NVARCHAR(10))+'/'+Cast( Year(@FromDate) as NVARCHAR(10))+ N'   Đến ngày ' +Cast( DAY(@ToDate) as NVARCHAR(10))+'/'+Cast( Month(@ToDate) as NVARCHAR(10))+'/'+Cast( Year(@ToDate) as NVARCHAR(10)) 
					END	
	FROM StoreModel sm 
	LEFT JOIN ProvinceModel as pro on sm.ProvinceId = pro.ProvinceId 
	LEFT JOIN DistrictModel as dis on sm.DistrictId = dis.DistrictId 
	WHERE sm.StoreId = @StoreId

	--- Tạo bảng tạm lấy ProductId và Qty
	 IF exists (select NAME from sysobjects where NAME = '#Detailtmpt')
    BEGIN
		drop table #Detailtmpt
    END
	CREATE TABLE #Detailtmpt(
		ProductId INT,
		Qty DECIMAL ,
		Price decimal ,
		Note nvarchar(50)
	)
	
	insert into #Detailtmpt (
     ProductId,
	 Price,
	 Note,
     Qty
	)
    SELECT detail.ProductId,
		   ISNULL(detail.COGS,0) + ISNULL(detail.Price,0) as price,
		   LEFT(Invenmaster.InventoryCode,3) as Note,
		   SUM(ISNULL(detail.ImportQty, 0) ) as Qty
	FROM InventoryDetailModel as detail
	inner join InventoryMasterModel as Invenmaster on detail.InventoryMasterId = Invenmaster.InventoryMasterId AND Invenmaster.Actived = 1
	inner join ImportMasterModel as imt on Invenmaster.BusinessId = imt.ImportMasterId
	WHERE (@FromDate is null or CONVERT(DATE,Invenmaster.CreatedDate) >= CONVERT(DATE,@FromDate))
		 AND(@ToDate is null or CONVERT(DATE,Invenmaster.CreatedDate) <= CONVERT(DATE,@ToDate))
		 AND Invenmaster.StoreId = @StoreId 
		 AND ISNULL(detail.ImportQty, 0) != 0
		 AND (@SupplierId is null or @SupplierId = imt.SupplierId)
		 AND (@EmployeeId is null or @EmployeeId = Invenmaster.CreatedEmployeeId)
	GROUP BY   detail.ProductId , ISNULL(detail.COGS,0) + ISNULL(detail.Price,0) , LEFT(Invenmaster.InventoryCode,3)		

	--select * from #Detailtmpt

	-- insert bảng Detail
	insert into #Detail (
	    STT ,
		ProductName ,
		ProductCode ,
		UnitName,
		Qty ,
		Price ,
		UnitPrice,
		Note
	)
	SELECT 
			ROW_NUMBER()Over(Order by p.ProductId) ,
			p.ProductName,
			p.ProductCode,
			unit.UnitName,
			ptem.Qty,
			ptem.Price,
			ptem.Qty * ptem.Price,
			ptem.Note
	FROM ProductModel as p
	LEFT JOIN UnitModel as unit on p.UnitId = unit.UnitId
	INNER JOIN #Detailtmpt as ptem on p.ProductId = ptem.ProductId

	-- CẬP NHẬT TỔNG TIỀN
	update #HeaderInfomation
	set TotalPrice = (select SUM(UnitPrice) from #Detail ),
	TotalPriceConvertToText =  dbo.Num2Text((select SUM(UnitPrice) from #Detail )),
	TotalQty = (select SUM(Qty) from #Detail )

	SELECT  Storename ,
			AddressStore ,
			PhoneStore ,
			--Govement ,
			Titel ,
			PrintTime ,
			TotalPrice ,
			TotalPriceConvertToText ,
			TotalQty 
	FROM  #HeaderInfomation
	
	SELECT  
		STT ,
		ProductName ,
		ProductCode ,
		UnitName,
		Qty ,
		Price ,
		UnitPrice,
		Note
	 FROM  #Detail
END


GO
/****** Object:  StoredProcedure [dbo].[usp_PhieuXuatKho]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_PhieuXuatKho]
	-- Add the parameters for the stored procedure here
	@StoreId int,
	@FromDate Datetime = null,
	@ToDate Datetime = null,
	@CustomerId int = null,
	@EmployeeId int = null
AS
BEGIN
	SET NOCOUNT ON;
	
    IF exists (select NAME from sysobjects where NAME = '#HeaderInfomation')--Chỉ chạy trong Store
    BEGIN
		drop table #HeaderInfomation
    END
    
    IF exists (select NAME from sysobjects where NAME = '#Detail')
    BEGIN
		drop table #Detail
    END
    
	CREATE TABLE #HeaderInfomation(
	    Storename NVARCHAR(500),
	    AddressStore NVARCHAR(500),
	    PhoneStore NVARCHAR(500),
		Govement NVARCHAR(500),
	    Titel NVARCHAR(500),
		PrintTime NVARCHAR(500),
		TotalPrice DECIMAL,
		TotalPriceConvertToText NVARCHAR(500),
		TotalQty DECIMAL
	)
	
	
	CREATE TABLE #Detail(
		STT INT,
		ProductName NVARCHAR(500),
		ProductCode NVARCHAR(500),
		UnitName NVARCHAR(50),
		Qty DECIMAL,
		Price DECIMAL,
		UnitPrice DECIMAL,
		Note NVARCHAR(500)
	)
	
	insert into #HeaderInfomation 
	(
		Storename,
	    AddressStore ,
	    PhoneStore ,
		Govement ,
	    Titel ,
		PrintTime
		--TotalPrice ,
		--TotalPriceConvertToText 
	)
	SELECT sm.StoreName 
		 ,sm.[Address]  as AddressStore
		 ,sm.Phone as PhoneStore
		,N'Mẫu số :  02 -  VT(Ban hành theo QĐ 15/2006/QĐ-BTC ngày 20/03/2006của Bộ Trưởng Bộ Tài Chính)'
		,N'BÁO CÁO XUẤT KHO'
		,CASE WHEN  CONVERT(DATE,@FromDate) = CONVERT(DATE,@ToDate) 
					THEN  N'Ngày ' + Cast( DAY(@FromDate) as NVARCHAR(10)) + N' Tháng ' + CAST(Month(@FromDate) AS nvarchar(10) ) + N' Năm ' + CAST(Year(@FromDate) AS nvarchar(10) ) 
					ELSE  N'Từ ngày ' +Cast( DAY(@FromDate) as NVARCHAR(10))+'/'+Cast( Month(@FromDate) as NVARCHAR(10))+'/'+Cast( Year(@FromDate) as NVARCHAR(10))+ N'   Đến ngày ' +Cast( DAY(@ToDate) as NVARCHAR(10))+'/'+Cast( Month(@ToDate) as NVARCHAR(10))+'/'+Cast( Year(@ToDate) as NVARCHAR(10)) 
					END	
	FROM StoreModel sm 
	LEFT JOIN ProvinceModel as pro on sm.ProvinceId = pro.ProvinceId 
	LEFT JOIN DistrictModel as dis on sm.DistrictId = dis.DistrictId 
	WHERE sm.StoreId = @StoreId

	--- Tạo bảng tạm lấy ProductId và Qty
	 IF exists (select NAME from sysobjects where NAME = '#Detailtmpt')
    BEGIN
		drop table #Detailtmpt
    END
	CREATE TABLE #Detailtmpt(
		ProductId INT,
		Qty DECIMAL ,
		Price decimal ,
		Note nvarchar(50)
	)
	
	insert into #Detailtmpt (
     ProductId,
	 Price,
	 Note,
     Qty
	)
 SELECT detail.ProductId,
		   ISNULL(detail.COGS,0) + ISNULL(detail.Price,0) as price,
		   LEFT(Invenmaster.InventoryCode,3) as Note,
		   SUM(ISNULL(detail.ExportQty, 0) ) as Qty
	FROM InventoryDetailModel as detail
	inner join InventoryMasterModel as Invenmaster on detail.InventoryMasterId = Invenmaster.InventoryMasterId AND Invenmaster.Actived = 1
	inner join OrderMasterModel as od on Invenmaster.BusinessId = od.OrderId
	WHERE (@FromDate is null or CONVERT(DATE,Invenmaster.CreatedDate) >= CONVERT(DATE,@FromDate))
		 AND(@ToDate is null or CONVERT(DATE,Invenmaster.CreatedDate) <= CONVERT(DATE,@ToDate))
		 AND Invenmaster.StoreId = @StoreId 
		 AND ISNULL(detail.ExportQty, 0) != 0
		 AND (@CustomerId is null or @CustomerId = od.CustomerId)
		 AND (@EmployeeId is null or @EmployeeId = Invenmaster.CreatedEmployeeId)
	GROUP BY   detail.ProductId , ISNULL(detail.COGS,0) + ISNULL(detail.Price,0) , LEFT(Invenmaster.InventoryCode,3)

	-- insert bảng Detail
	insert into #Detail (
	    STT ,
		ProductName ,
		ProductCode ,
		UnitName,
		Qty ,
		Price ,
		UnitPrice
	)
	SELECT 
			ROW_NUMBER()Over(Order by p.ProductId) ,
			p.ProductName,
			p.ProductCode,
			unit.UnitName,
			ptem.Qty,
			p.ImportPrice,
			ptem.Qty * p.ImportPrice
	FROM ProductModel as p
	LEFT JOIN UnitModel as unit on p.UnitId = unit.UnitId
	INNER JOIN #Detailtmpt as ptem on p.ProductId = ptem.ProductId

	-- CẬP NHẬT TỔNG TIỀN
	update #HeaderInfomation
	set TotalPrice = (select SUM(UnitPrice) from #Detail ),
	TotalPriceConvertToText =  dbo.Num2Text((select SUM(UnitPrice) from #Detail )),
	TotalQty = (select SUM(Qty) from #Detail )
	
	SELECT  Storename ,
			AddressStore ,
			PhoneStore ,
			--Govement ,
			Titel ,
			PrintTime ,
			TotalPrice ,
			TotalPriceConvertToText ,
			TotalQty 
	FROM  #HeaderInfomation
	
	SELECT  
		STT ,
		ProductName ,
		ProductCode ,
		UnitName,
		Qty ,
		Price ,
		UnitPrice
	 FROM  #Detail
END
-- EXEC [dbo].[usp_PhieuXuatKho] 1001
GO
/****** Object:  StoredProcedure [dbo].[usp_Preview_AM_TransactionModel]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/

CREATE proc [dbo].[usp_Preview_AM_TransactionModel]
as
SELECT TOP 1000 [TransactionId] --  Tự tăng
      ,[StoreId]				--	Mã cửa hàng
      ,[AMAccountId]			--	1.TIENMAT || 2. NGANHANG
      ,[TransactionTypeCode]	--	BHBAN: Nghiệp vụ bán hàng
      ,[ContactItemTypeCode]	--	KH : Khách hàng
      ,[CustomerId]				--	CustomerId
      ,[SupplierId]				--	NULL
      ,[EmployeeId]				--	Người tạo
      ,[OtherId]				--	NULL
      ,[Amount]					--	Số tiền (thu - chi)
      ,[OrderId]				--	1234
      ,[ImportMasterId]			--	NULL
      ,[IEOtherMasterId]		--	NULL
      ,[Note]					--	Ghi chú
      ,[CreateDate]				--	Ngày tạo
      ,[CreateEmpId]			--	Người tạo
  FROM [XuanBao_Dev].[dbo].[AM_TransactionModel]
    --Thêm mới thu - chi tiền mặt
  SELECT TOP 1000 [TransactionId] --  Tự tăng
      ,[StoreId]				--	Mã cửa hàng
      ,[AMAccountId]			--	1.TIENMAT (mặc định)
      ,[TransactionTypeCode]	--	 TCCHI
      ,[ContactItemTypeCode]	--	
      ,[CustomerId]				--	
      ,[SupplierId]				--	
      ,[EmployeeId]				--	
      ,[OtherId]				--	NULL
      ,[Amount]					--	
      ,[OrderId]				--	NULL
      ,[ImportMasterId]			--	NULL
      ,[IEOtherMasterId]		--	NULL
      ,[Note]					--	Ghi chú
      ,[CreateDate]				--	Ngày tạo
      ,[CreateEmpId]			--	Người tạo
  FROM [XuanBao_Dev].[dbo].[AM_TransactionModel]
  -- Nhập hàng từ nhà cung cấp
   SELECT TOP 1000 [TransactionId] --  Tự tăng
      ,[StoreId]				--	Mã cửa hàng
      ,[AMAccountId]			--	1.TIENMAT (mặc định)
      ,[TransactionTypeCode]	--	 NXNHAP
      ,[ContactItemTypeCode]	--	NCC
      ,[CustomerId]				--	NULL
      ,[SupplierId]				--	model.SupplierId
      ,[EmployeeId]				--	NULL
      ,[OtherId]				--	NULL
      ,[Amount]					--	
      ,[OrderId]				--	NULL
      ,[ImportMasterId]			--	model.ImportMasterId
      ,[IEOtherMasterId]		--	NULL
      ,[Note]					--	Ghi chú
      ,[CreateDate]				--	Ngày tạo
      ,[CreateEmpId]			--	Người tạo
  FROM [XuanBao_Dev].[dbo].[AM_TransactionModel]
 
GO
/****** Object:  StoredProcedure [dbo].[usp_ReceiptVoucher]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_ReceiptVoucher]
	-- Add the parameters for the stored procedure here
	@TransactionId int
AS
BEGIN
	SET NOCOUNT ON;
	
    IF exists (select NAME from sysobjects where NAME = '#HeaderInfomation')--Chỉ chạy trong Store
    BEGIN
		drop table #HeaderInfomation
    END
	CREATE TABLE #HeaderInfomation(
		CreateDate NVARCHAR(500),
		CustomerName NVARCHAR(500),
	    Addresss NVARCHAR(500),
		Amount DECIMAL,
		AmountConvertToText NVARCHAR(500),
		Govement NVARCHAR(500),
		Denominator NVARCHAR(500),
	    Title NVARCHAR(500),
		StoreName NVARCHAR(500),
		CustomerNameLabel NVARCHAR(50),
		Debit NVARCHAR(50),
		Credit NVARCHAR(50),
		ContactItemTypeCode NVARCHAR(50),
		PayReason NVARCHAR(500),
		FooterLabelLeft NVARCHAR(50),
		FooterLabelRight NVARCHAR(50)
	)
	
	insert into #HeaderInfomation 
	(   CreateDate,
		CustomerName,
	    Addresss,
		Amount,
		AmountConvertToText,
		Govement,
		Denominator,
		StoreName,
		ContactItemTypeCode
	)
	SELECT 
		  N'Ngày ' + Cast( DAY(AM.CreateDate) as NVARCHAR(10)) + N' Tháng ' + CAST(Month(AM.CreateDate) AS nvarchar(10) ) + N' Năm ' + CAST(Year(AM.CreateDate) AS nvarchar(10) )
		 , Isnull(cm.FullName, '') + Isnull(supm.SupplierName, '') + Isnull(emp.FullName, '') + ' - ' + Isnull(cm.Phone, '') +  Isnull(supm.Phone, '')  +  Isnull(emp.Phone , '' )
		 , AM.[Address]
		 , AM.Amount
		 , dbo.Num2Text(AM.Amount)
		 , N'(Ban hành theo QĐ số 19/2006/QĐ-BTC ngày 30/3/2006 của bộ trưởng BTC)'
		 , N'C30-BB'
		 , sm.StoreName 
		 , AM.ContactItemTypeCode
	FROM [dbo].[AM_TransactionModel] AM
	LEFT JOIN [dbo].[CustomerModel] as cm on AM.CustomerId = cm.CustomerId
	LEFT JOIN [dbo].[SupplierModel] as supm on AM.SupplierId = supm.SupplierId
	LEFT JOIN [dbo].[EmployeeModel] as emp on AM.EmployeeId = emp.EmployeeId
	INNER JOIN StoreModel as sm on AM.StoreId = sm.StoreId 
	Where AM.TransactionId = @TransactionId

	-- Xác định CustomerNameLabel
	DECLARE @Isimpot bit, @ContactItemTypeCode nvarchar(50) ;
	SELECT @Isimpot = isImport
	FROM [dbo].[AM_TransactionModel] AM
	INNER JOIN [dbo].[AM_TransactionTypeModel] TM ON AM.TransactionTypeCode = TM.TransactionTypeCode
	WHERE AM.TransactionId = @TransactionId

	SELECT @ContactItemTypeCode = ContactItemTypeCode
	FROM #HeaderInfomation

	IF(@Isimpot = 1)
	BEGIN
		UPDATE #HeaderInfomation
		SET CustomerNameLabel = N'Họ tên người nộp tiền : ',
			Title = N'PHIẾU THU',
			Debit = '111',
			Credit = CASE 
						 WHEN ContactItemTypeCode ='KH' THEN '131' 
						 WHEN ContactItemTypeCode ='NCC' THEN '331' 
						 WHEN ContactItemTypeCode ='NV' THEN '141' 
				     END,
			PayReason = N'Thu tiền bán hàng',
			FooterLabelLeft = N'Người nộp tiền',
			FooterLabelRight = N'Thủ quỹ'
	END
	ELSE
	BEGIN
		UPDATE #HeaderInfomation
		SET CustomerNameLabel = N'Họ tên người nhận tiền : ',
			Title = N'PHIẾU CHI',
			Credit = '111',
			Debit = CASE 
						 WHEN ContactItemTypeCode ='KH' THEN '131' 
						 WHEN ContactItemTypeCode ='NCC' THEN '331' 
						 WHEN ContactItemTypeCode ='NV' THEN '141' 
				     END,
			PayReason = N'Trả tiền nhận hàng',
			FooterLabelRight = N'Người nộp tiền',
			FooterLabelLeft = N'Thủ quỹ'
	END
	SELECT 
		CreateDate,
		CustomerName,
	    Addresss,
		Amount,
		AmountConvertToText,
		Govement,
		Denominator,
	    Title,
		StoreName,
		CustomerNameLabel,
		Debit,
		Credit,
		PayReason,
		FooterLabelRight,
		FooterLabelLeft
	FROM  #HeaderInfomation
	
END
-- EXEC [dbo].[usp_ReceiptVoucher] 1001

GO
/****** Object:  StoredProcedure [dbo].[usp_ReturnCanceled]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_ReturnCanceled] (@ReturnMasterId INT, @DeletedDate DATETIME, @DeletedAccount nvarchar(50), @DeletedEmployeeId int)
AS
	BEGIN
		BEGIN TRAN
			BEGIN TRY
			--PRINT @@TRANCOUNT
			    -- Bước 1
			    -- Thieu 1: lay cai actived = true moi lam
			    -- Thieu 2: set actived = false cua inventory master
			    IF ((SELECT Actived FROM ReturnmasterModel WHERE ReturnMasterId = @ReturnMasterId) = 1)
			    BEGIN
					UPDATE ReturnmasterModel
					SET Actived = 0,
						DeletedDate = @DeletedDate,
						DeletedAccount = @DeletedAccount,
						DeletedEmployeeId = @DeletedEmployeeId
					WHERE ReturnMasterId = @ReturnMasterId
					-- Bước 2 : 
						--1.lấy CreateDate để so sánh CreateDate trong InventoryMasterModel : Lọc ra danh sách cần cập nhật
						  DECLARE @CreatedDate DATETIME;
						  SELECT @CreatedDate = InvenMaster.CreatedDate
						  FROM InventoryMasterModel InvenMaster
						  WHERE  InvenMaster.BusinessId = @ReturnMasterId and 
								 InvenMaster.BusinessName='ReturnMasterModel'
						  --Xét actived = false cua inventory master
						  UPDATE InventoryMasterModel
						  SET Actived = 0,
							  DeletedDate = @DeletedDate,
							  DeletedAccount = @DeletedAccount,
						      DeletedEmployeeId = @DeletedEmployeeId
						  WHERE BusinessId = @ReturnMasterId and 
								BusinessName='ReturnMasterModel'
						
						IF exists (select NAME from sysobjects where NAME = '#ReturnDetail')
						BEGIN
							drop table #ReturnDetail
						END
						CREATE TABLE #ReturnDetail(
							ProductId int,
							Qty decimal
						)
						insert into #ReturnDetail
						SELECT ReturnDetail.ProductId, ReturnDetail.ReturnQty
						  FROM ReturnMasterModel ReturntMaster
						  INNER JOIN ReturnDetailModel ReturnDetail on ReturntMaster.ReturnMasterId = ReturnDetail.ReturnMasterId
						  WHERE ReturntMaster.ReturnMasterId = @ReturnMasterId
						
						--3. Lấy ra danh sách sản phẩm cần update sau  @CreatedDate
						 -- Bảng tạm 2 : Lấy InventoryDetailId, ProductId, Qty;
						IF exists (select NAME from sysobjects where NAME = '#InvenDetail')
						BEGIN
							drop table #InvenDetail
						END
						CREATE TABLE #InvenDetail(
							InventoryDetailId int,
							ProductId int,
							Qty decimal
						)
						INSERT INTO #InvenDetail (InventoryDetailId, ProductId, Qty)
						SELECT InvenDetail.InventoryDetailId, InvenDetail.ProductId , tblTempt.Qty
							FROM InventoryDetailModel InvenDetail
							INNER JOIN InventoryMasterModel InvenMaster on InvenMaster.InventoryMasterId =  InvenDetail.InventoryMasterId and InvenMaster.Actived = 1 -- Bỏ qua những InvenDetail ĐÃ XOÁ
							, (SELECT #ReturnDetail.ProductId, #ReturnDetail.Qty
								FROM  #ReturnDetail) as tblTempt
							WHERE InvenMaster.CreatedDate > @CreatedDate AND InvenDetail.ProductId = tblTempt.ProductId
						--Xem danh sách inventdetail cần update
						SELECT * 
						FROM #InvenDetail
						-- Update
						Update InventoryDetailModel
						SET BeginInventoryQty = BeginInventoryQty + (Select Qty from #InvenDetail Where #InvenDetail.InventoryDetailId = InventoryDetailModel.InventoryDetailId and ProductId = InventoryDetailModel.ProductId)	
						, EndInventoryQty = BeginInventoryQty + ISNULL(ImportQty , 0) - ISNULL(ExportQty , 0) + (Select Qty from #InvenDetail Where #InvenDetail.InventoryDetailId = InventoryDetailModel.InventoryDetailId and ProductId = InventoryDetailModel.ProductId)	
						Where InventoryDetailId in (Select InventoryDetailId from #InvenDetail)
						
						--Cập nhật công nợ NCC khi huỷ đơn nhập hàng
						--B1. Lấy CreadateImport và RemainingAmount,@CustomerId
						DECLARE @CreadateReturnMaster datetime,@RemainingAmount decimal(18,2),@Supplier int
						SELECT @Supplier = SupplierId,@RemainingAmount = RemainingAmount
						FROM ReturnMasterModel 
						WHERE ReturnMasterId = @ReturnMasterId

						SELECT @CreadateReturnMaster = TimeOfDebt
						FROM AM_DebtModel
						WHERE ReturnMasterId = @ReturnMasterId

						--B2. Cập nhật lại RemainingAmountAccrued  của AM_DebtModel có TimeOfDate sau @CreadateImport
						UPDATE AM_DebtModel
						SET RemainingAmountAccrued = RemainingAmountAccrued + @RemainingAmount
						WHERE  TimeOfDebt > @CreadateReturnMaster and SupplierId = @Supplier and ReturnMasterId <> @ReturnMasterId

						--B3 . Xoá AM_DebtModel có  ReturnMasterId = @ReturnMasterId
						DELETE 
						FROM AM_DebtModel
						WHERE ReturnMasterId = @ReturnMasterId


						Select *
						from 	#InvenDetail -- xem danh sách InventoryDetail  càn update
							  
						  
			  COMMIT TRAN;
			  --PRINT @@TRANCOUNT
			  END
			END TRY
			BEGIN CATCH
					IF @@Trancount > 0
					ROLLBACK TRAN;
			END CATCH
	END

GO
/****** Object:  StoredProcedure [dbo].[usp_ReturnDetailList]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE PROC [dbo].[usp_ReturnDetailList](@ImportMasterId int)
  AS
	BEGIN

	Select rd.ProductId, sum(rd.ReturnQty) as ReturnQty
	into #tempTable
	from ReturnMasterModel rm 
		inner join ReturnDetailModel rd on rm.ReturnMasterId = rd.ReturnMasterId
	  
	where rm.ImportMasterId = @ImportMasterId and 
		rm.Actived = 1
	group by rd.ProductId

	  SELECT idm.ProductId , 
			pm.ProductName, 
			idm.Price, 
			idm.ShippingFee, 
			idm.Qty AS ImportQty,
		    ISNULL(r.ReturnQty, 0) AS  ReturnedQty, 
		    ivdm.EndInventoryQty AS InventoryQty,
			idm.UnitShippingWeight,
		    --0 as UnitPrice,
			idm.UnitCOGS
	  FROM ImportDetailModel idm
	  inner join ProductModel pm on idm.ProductId = pm.ProductId
	  inner join InventoryDetailModel ivdm on idm.ProductId = ivdm.ProductId
	  -- tính số lượng đã trả
	  left join #tempTable r on pm.ProductId =  r.ProductId

	  WHERE idm.ImportMasterId = @ImportMasterId 
	   and  InventoryDetailId = (SELECT MAX(InventoryDetailId)
										FROM InventoryDetailModel detailinner
									    inner join InventoryMasterModel invmaster on detailinner.InventoryMasterId = invmaster.InventoryMasterId -- Thêm điều kiện để bỏ qua sản phẩm tồn kho ĐÃ XOÁ
										WHERE ProductId = idm.ProductId  
										and invmaster.Actived = 1 --Bỏ qua tồn kho đã xoá
										)
	END


	--EXEC [dbo].[usp_ReturnDetailList] '1073'

	
	
GO
/****** Object:  StoredProcedure [dbo].[usp_SellCanceled]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_SellCanceled] (@OrderId INT, @DeletedDate DATETIME, @DeletedAccount nvarchar(50), @DeletedEmployeeId int)
AS
	BEGIN
		BEGIN TRAN
			BEGIN TRY
			--PRINT @@TRANCOUNT
			    -- Bước 1
			    -- Thieu 1: lay cai actived = true moi lam
			    -- Thieu 2: set actived = false cua inventory master
			    IF ((SELECT Actived FROM OrderMasterModel WHERE OrderId = @OrderId) = 1)
			    BEGIN
					UPDATE OrderMasterModel
					SET Actived = 0,
						DeletedDate = @DeletedDate,
						DeletedAccount = @DeletedAccount,
						DeletedEmployeeId = @DeletedEmployeeId
					WHERE OrderId = @OrderId
					-- Bước 2 : 
						--1.lấy CreateDate để so sánh CreateDate trong InventoryMasterModel : Lọc ra danh sách cần cập nhật
						  DECLARE @CreatedDate DATETIME;
						  SELECT @CreatedDate = InvenMaster.CreatedDate
						  FROM InventoryMasterModel InvenMaster
						  WHERE  InvenMaster.BusinessId = @OrderId and 
								 InvenMaster.BusinessName='OrderMasterModel'
						  --Xét actived = false cua inventory master
						  UPDATE InventoryMasterModel
						  SET Actived = 0,
							  DeletedDate = @DeletedDate,
							  DeletedAccount = @DeletedAccount,
						      DeletedEmployeeId = @DeletedEmployeeId
						  WHERE BusinessId = @OrderId and 
								BusinessName='OrderMasterModel'
						
						IF exists (select NAME from sysobjects where NAME = '#ImportDetail')
						BEGIN
							drop table #ImportDetail
						END
						CREATE TABLE #ImportDetail(
							ProductId int,
							Qty decimal
						)
						insert into #ImportDetail
						SELECT OrderDetail.ProductId, OrderDetail.Quantity
						  FROM OrderMasterModel OrderMaster
						  INNER JOIN OrderDetailModel OrderDetail on OrderMaster.OrderId = OrderDetail.OrderId
						  WHERE OrderMaster.OrderId = @OrderId
						
						--3. Lấy ra danh sách sản phẩm cần update sau  @CreatedDate
						 -- Bảng tạm 2 : Lấy InventoryDetailId, ProductId, Qty;
						IF exists (select NAME from sysobjects where NAME = '#InvenDetail')
						BEGIN
							drop table #InvenDetail
						END
						CREATE TABLE #InvenDetail(
							InventoryDetailId int,
							ProductId int,
							Qty decimal
						)
						INSERT INTO #InvenDetail (InventoryDetailId, ProductId, Qty)
						SELECT InvenDetail.InventoryDetailId, InvenDetail.ProductId , tblTempt.Qty
							FROM InventoryDetailModel InvenDetail
							INNER JOIN InventoryMasterModel InvenMaster on InvenMaster.InventoryMasterId =  InvenDetail.InventoryMasterId
							, (SELECT #ImportDetail.ProductId, #ImportDetail.Qty
								FROM  #ImportDetail) as tblTempt
							WHERE InvenMaster.CreatedDate > @CreatedDate AND InvenDetail.ProductId = tblTempt.ProductId
						-- Update
						Update InventoryDetailModel
						SET BeginInventoryQty = BeginInventoryQty + (Select Qty from #InvenDetail Where #InvenDetail.InventoryDetailId = InventoryDetailModel.InventoryDetailId and ProductId = InventoryDetailModel.ProductId)	
						, EndInventoryQty = BeginInventoryQty + ISNULL(ImportQty, 0) - ISNULL(ExportQty,0) + (Select Qty from #InvenDetail Where #InvenDetail.InventoryDetailId = InventoryDetailModel.InventoryDetailId and ProductId = InventoryDetailModel.ProductId)	
						Where InventoryDetailId in (Select InventoryDetailId from #InvenDetail)
						
						--Cập nhật công nợ NCC khi huỷ đơn nhập hàng
						--B1. Lấy CreadateImport và RemainingAmount,@CustomerId
						DECLARE @CreadateOrder datetime,@RemainingAmount decimal(18,2),@CustomerId int
						SELECT @CustomerId = CustomerId,@RemainingAmount = RemainingAmount
						FROM OrderMasterModel
						WHERE OrderId = @OrderId

						SELECT @CreadateOrder = TimeOfDebt
						FROM AM_DebtModel
						WHERE OrderId = @OrderId

						--B2. Cập nhật lại RemainingAmountAccrued  của AM_DebtModel có TimeOfDate sau @CreadateImport
						UPDATE AM_DebtModel
						SET RemainingAmountAccrued = RemainingAmountAccrued - @RemainingAmount
						WHERE  TimeOfDebt > @CreadateOrder and CustomerId = @CustomerId and OrderId <> @OrderId

						--B3 . Xoá AM_DebtModel có  ImportId = @ImportMasterId
						DELETE 
						FROM AM_DebtModel
						WHERE OrderId = @OrderId

						

						Select *
						from 	#InvenDetail
							  
						  
			  COMMIT TRAN;
			  --PRINT @@TRANCOUNT
			  END
			END TRY
			BEGIN CATCH
					IF @@Trancount > 0
					ROLLBACK TRAN;
			END CATCH
	END

GO
/****** Object:  StoredProcedure [dbo].[usp_SellReturnCanceled]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_SellReturnCanceled] (@OrderReturnMasterId INT, @DeletedDate DATETIME, @DeletedAccount nvarchar(50), @DeletedEmployeeId int)
AS
	BEGIN
		BEGIN TRAN
			BEGIN TRY
			--PRINT @@TRANCOUNT
			    -- Bước 1
			    -- Thieu 1: lay cai actived = true moi lam
			    -- Thieu 2: set actived = false cua inventory master
			    IF ((SELECT Actived FROM OrderReturnModel WHERE OrderReturnMasterId = @OrderReturnMasterId) = 1)
			    BEGIN
					UPDATE OrderReturnModel
					SET Actived = 0,
						DeletedDate = @DeletedDate,
						DeletedAccount = @DeletedAccount,
						DeletedEmployeeId = @DeletedEmployeeId
					WHERE OrderReturnMasterId = @OrderReturnMasterId
					-- Bước 2 : 
						--1.lấy CreateDate để so sánh CreateDate trong InventoryMasterModel : Lọc ra danh sách cần cập nhật
						  DECLARE @CreatedDate DATETIME;
						  SELECT @CreatedDate = InvenMaster.CreatedDate
						  FROM InventoryMasterModel InvenMaster
						  WHERE  InvenMaster.BusinessId = @OrderReturnMasterId and 
								 InvenMaster.BusinessName='OrderReturnMaster'
						  --Xét actived = false cua inventory master
						  UPDATE InventoryMasterModel
						  SET Actived = 0,
							  DeletedDate = @DeletedDate,
							  DeletedAccount = @DeletedAccount,
						      DeletedEmployeeId = @DeletedEmployeeId
						  WHERE BusinessId = @OrderReturnMasterId and 
								BusinessName='OrderReturnMaster'
						
						IF exists (select NAME from sysobjects where NAME = '#ImportDetail')
						BEGIN
							drop table #ImportDetail
						END
						CREATE TABLE #ImportDetail(
							ProductId int,
							Qty decimal
						)
						insert into #ImportDetail
						SELECT 
								OrderDetail.ProductId,
							    OrderDetail.[ReturnQuantity]
						  FROM OrderReturnModel OrderMaster
						  INNER JOIN OrderReturnDetailModel OrderDetail on OrderMaster.[OrderReturnMasterId] = OrderDetail.[OrderReturnId]
						  WHERE OrderMaster.OrderReturnMasterId = @OrderReturnMasterId
						
						--3. Lấy ra danh sách sản phẩm cần update sau  @CreatedDate
						 -- Bảng tạm 2 : Lấy InventoryDetailId, ProductId, Qty;
						IF exists (select NAME from sysobjects where NAME = '#InvenDetail')
						BEGIN
							drop table #InvenDetail
						END
						CREATE TABLE #InvenDetail(
							InventoryDetailId int,
							ProductId int,
							Qty decimal
						)
						INSERT INTO #InvenDetail (InventoryDetailId, ProductId, Qty)
						SELECT InvenDetail.InventoryDetailId, InvenDetail.ProductId , tblTempt.Qty
							FROM InventoryDetailModel InvenDetail
							INNER JOIN InventoryMasterModel InvenMaster on InvenMaster.InventoryMasterId =  InvenDetail.InventoryMasterId
							, (SELECT #ImportDetail.ProductId, #ImportDetail.Qty
								FROM  #ImportDetail) as tblTempt
							WHERE InvenMaster.CreatedDate > @CreatedDate AND InvenDetail.ProductId = tblTempt.ProductId
						-- Update
						Update InventoryDetailModel
						SET BeginInventoryQty = BeginInventoryQty - (Select Qty from #InvenDetail Where #InvenDetail.InventoryDetailId = InventoryDetailModel.InventoryDetailId and ProductId = InventoryDetailModel.ProductId)	
						, EndInventoryQty = BeginInventoryQty + ISNULL(ImportQty,0)- ISNULL(ExportQty, 0) - (Select Qty from #InvenDetail Where #InvenDetail.InventoryDetailId = InventoryDetailModel.InventoryDetailId and ProductId = InventoryDetailModel.ProductId)	
						Where InventoryDetailId in (Select InventoryDetailId from #InvenDetail)
						
						--Cập nhật công nợ NCC khi huỷ đơn nhập hàng
						--B1. Lấy CreadateImport và RemainingAmount,@CustomerId
						DECLARE @CreadateOrderReturn datetime,@RemainingAmount decimal(18,2),@CustomerId int
						SELECT @CustomerId = od.CustomerId,@RemainingAmount = odre.RemainingAmount
						FROM OrderReturnModel odre
						inner join OrderMasterModel od on odre.OrderId = od.OrderId
						WHERE OrderReturnMasterId = @OrderReturnMasterId

						SELECT @CreadateOrderReturn = TimeOfDebt
						FROM AM_DebtModel
						WHERE OrderReturnId = @OrderReturnMasterId

						--B2. Cập nhật lại RemainingAmountAccrued  của AM_DebtModel có TimeOfDate sau @CreadateImport
						UPDATE AM_DebtModel
						SET RemainingAmountAccrued = RemainingAmountAccrued + @RemainingAmount
						WHERE  TimeOfDebt > @CreadateOrderReturn and CustomerId = @CustomerId and OrderReturnId <> @OrderReturnMasterId

						--B3 . Xoá AM_DebtModel có  ImportId = @ImportMasterId
						DELETE 
						FROM AM_DebtModel
						WHERE OrderReturnId = @OrderReturnMasterId


						Select *
						from 	#InvenDetail
							  
						  
			  COMMIT TRAN;
			  --PRINT @@TRANCOUNT
			  END
			END TRY
			BEGIN CATCH
					IF @@Trancount > 0
					ROLLBACK TRAN;
			END CATCH
	END

GO
/****** Object:  StoredProcedure [dbo].[usp_temp_Cursor]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE PROC [dbo].[usp_temp_Cursor]
as
DECLARE @ImportMasterId INT
SET @ImportMasterId = 1019

--Khởi tạo ngày hủy, id nghiệp vụ
DECLARE @CreateDate DATETIME
DECLARE @BusinessId INT
DECLARE @InventoryTypeId INT
DECLARE @CurrentActived BIT

--set giá trị ngày hủy, id nghiệp vụ
SELECT @CreateDate = CreatedDate, @BusinessId = i.ImportMasterId, @InventoryTypeId = InventoryTypeId, @CurrentActived = Actived
FROM dbo.[ImportMasterModel] i
WHERE i.ImportMasterId = @ImportMasterId

--Test 
--select @CreateDate, @BusinessId, @InventoryTypeId
--IF	@CurrentActived = 1
--BEGIN
----Set actived = false
--UPDATE [ImportMasterModel]
--SET Actived = 0
--WHERE ImportMasterId = @ImportMasterId

-- Những Product Đã Import
SELECT d.ProductId,d.Qty, d.Price, d.UnitPrice, d.UnitShippingWeight,d.ImportMasterId--,*
  FROM [dbo].[ImportMasterModel] m
  INNER JOIN dbo.ImportDetailModel d ON m.ImportMasterId = d.ImportMasterId
  WHERE d.ImportMasterId = @ImportMasterId
  
-- Hủy inventory
--UPDATE  dbo.InventoryMasterModel
--SET Actived = 0
--WHERE BusinessName = 'ImportMasterModel' AND 
--	  InventoryTypeId = @InventoryTypeId AND 
--	  BusinessId = @ImportMasterId

--lặp Inventory detail cần được hủy
--update những inventory sau đó sảy ra
SELECT d.ProductId,* 
	FROM dbo.InventoryMasterModel m
	INNER JOIN dbo.InventoryDetailModel d ON m.InventoryMasterId = d.InventoryMasterId
	WHERE m.BusinessName = 'ImportMasterModel' AND 
		  m.InventoryTypeId = @InventoryTypeId AND 
		  m.BusinessId = @ImportMasterId
		  
DECLARE @ProductId INT

DECLARE my_cursor  CURSOR FOR   
SELECT d.ProductId 
FROM dbo.InventoryMasterModel m
	INNER JOIN dbo.InventoryDetailModel d ON m.InventoryMasterId = d.InventoryMasterId
	WHERE m.BusinessName = 'ImportMasterModel' AND 
		  m.InventoryTypeId = @InventoryTypeId AND 
		  m.BusinessId = @ImportMasterId
OPEN my_cursor  
FETCH NEXT FROM my_cursor   
INTO @ProductId
WHILE @@FETCH_STATUS = 0  
BEGIN

--Những Inventory Cần được update		  
SELECT * 
	FROM dbo.InventoryMasterModel m
	INNER JOIN dbo.InventoryDetailModel d ON m.InventoryMasterId = d.InventoryMasterId
	WHERE m.CreatedDate > @CreateDate AND d.ProductId = @ProductId
	
 CLOSE my_cursor  
    DEALLOCATE my_cursor  
        -- Get the next vendor.  
    FETCH NEXT FROM my_cursor   
    INTO @ProductId
END   
CLOSE vendor_cursor;  
DEALLOCATE vendor_cursor;  


--END 

GO
/****** Object:  StoredProcedure [dbo].[usp_ThongTinChiTietGiaoDichCongNoKhachHang]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nguyễn Văn Phong>
-- Create date: <8/10/2015>
-- Description:	<Báo cáo CHI TIẾT GIAO DICH công nợ khách hàng>
-- =============================================
CREATE PROCEDURE [dbo].[usp_ThongTinChiTietGiaoDichCongNoKhachHang]
	@CustomerId int,
	@FromDate date,
	@ToDate date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	 -- GIÁ TRỊ BÁN HÀNG
	 select     p.CreatedDate as DateTransaction,
			   p.OrderCode as TransactionCode,
			   '+' as Change,
			   (p.TotalPrice) as Amout,
			    p.[RemainingAmountAccrued] + ISNULL(p.Paid,0) as RemainingAmountAccrued,
			    N'Bán hàng' as Description,
			   1 as Zindex
		from OrderMasterModel as p
		Where --(p.TotalPrice - ISNULL(p.Paid,0)) != 0  AND
			   p.Actived = 1 AND
			   p.CustomerId = @CustomerId AND
                @FromDate <= CAST(p.CreatedDate as date) and CAST(p.CreatedDate as date) <= @ToDate
      UNION
	    -- THANH TOÁN MUA HÀNG
        select     p.CreatedDate as DateTransaction, 
			   p.OrderCode as TransactionCode,
			   '-' as Change,
			   (p.Paid) as Amout,
			    p.[RemainingAmountAccrued],
			    N'Thanh toán mua hàng' as Description,
			   2 as Zindex 
		from OrderMasterModel as p
		Where --(p.TotalPrice - ISNULL(p.Paid,0)) != 0  AND
		       ISNULL(p.Paid,0) != 0 AND
			   p.Actived = 1 AND
			   p.CustomerId = @CustomerId AND
                @FromDate <= CAST(p.CreatedDate as date) and CAST(p.CreatedDate as date) <= @ToDate
  UNION
  -- Trả hàng
  	select  p.CreatedDate as DateTransaction,
			   p.OrderReturnMasterCode as TransactionCode,
			   '-' as Change,
			   (p.TotalPrice) as Amout,
			    p.[RemainingAmountAccrued] + ISNULL(p.Paid,0) as RemainingAmountAccrued,
			    N'Trả hàng' as Description,
			   2 as Zindex
		from OrderReturnModel as p inner join OrderMasterModel o on p.OrderId = o.OrderId
		Where --(p.TotalPrice - ISNULL(p.Paid,0)) != 0  AND
			   p.Actived = 1 AND
			   o.CustomerId = @CustomerId AND
                @FromDate <= CAST(p.CreatedDate as date) and CAST(p.CreatedDate as date) <= @ToDate
    UNION
  -- Trả tiền khách trả hàng
  	select  p.CreatedDate as DateTransaction,
			   p.OrderReturnMasterCode as TransactionCode,
			   '+' as Change,
			    ISNULL(p.Paid,0) as Amout,
			    ISNULL(p.[RemainingAmountAccrued],0) - ISNULL(p.Paid,0) as RemainingAmountAccrued,
			    N'Trả tiền khách trả hàng' as Description,
			   2 as Zindex
		from OrderReturnModel as p inner join OrderMasterModel o on p.OrderId = o.OrderId
		Where --(p.TotalPrice - ISNULL(p.Paid,0)) != 0  AND
			   p.Actived = 1 AND
			   o.CustomerId = @CustomerId AND
                @FromDate <= CAST(p.CreatedDate as date) and CAST(p.CreatedDate as date) <= @ToDate
  UNION
  -- THU TIỀN MẶT
	select     p.CreateDate as DateTransaction,
			   N'TCTHU' as TransactionCode,
				'-' as Change,
				(p.Amount) as Amout,
				p.[RemainingAmountAccrued],
				N'Thu tiền mặt "' + RTRIM(LTRIM(ISNULL(p.Note,''))) + '"' as Description,
				3 as Zindex
		from AM_TransactionModel as p
		Where --(p.TotalPrice - ISNULL(p.Paid,0)) != 0  AND 
		        p.TransactionTypeCode = 'TCTHU' AND
				p.CustomerId = @CustomerId AND
				@FromDate <= CAST(p.CreateDate as date) and CAST(p.CreateDate as date) <= @ToDate
	  -- CHI TIỀN MẶT
  UNION
	select     p.CreateDate as DateTransaction,
			   N'TCCHI' as TransactionCode,
				'+' as Change,
				(p.Amount) as Amout,
				p.[RemainingAmountAccrued],
				N'Chi tiền mặt "' + RTRIM(LTRIM(ISNULL(p.Note,''))) + '"' as Description,
				4 as Zindex
		from AM_TransactionModel as p
		Where --(p.TotalPrice - ISNULL(p.Paid,0)) != 0  AND 
		        p.TransactionTypeCode = 'TCCHI' AND
				p.CustomerId = @CustomerId AND
				@FromDate <= CAST(p.CreateDate as date) and CAST(p.CreateDate as date) <= @ToDate
     -- THU NGÂN HÀNG
  UNION
	select     p.CreateDate as DateTransaction,
			   N'NHNOP' as TransactionCode,
				'-' as Change,
				(p.Amount) as Amout,
				p.[RemainingAmountAccrued],
				N'Thu tiền chuyển khoản NH' + ISNULL(p.Note,'') as Description,
				3 as Zindex
		from AM_TransactionModel as p
		Where --(p.TotalPrice - ISNULL(p.Paid,0)) != 0  AND 
		        p.TransactionTypeCode = 'NHNOP' AND
				p.CustomerId = @CustomerId AND
				@FromDate <= CAST(p.CreateDate as date) and CAST(p.CreateDate as date) <= @ToDate
      -- CHI NGÂN HÀNG
  UNION
	select     p.CreateDate as DateTransaction,
			   N'NHRUT' as TransactionCode,
				'+' as Change,
				(p.Amount) as Amout,
				p.[RemainingAmountAccrued],
				N'Chi tiền chuyển khoản NH' + ISNULL(p.Note,'') as Description,
				3 as Zindex
		from AM_TransactionModel as p
		Where --(p.TotalPrice - ISNULL(p.Paid,0)) != 0  AND 
		        p.TransactionTypeCode = 'NHRUT' AND
				p.CustomerId = @CustomerId AND
				@FromDate <= CAST(p.CreateDate as date) and CAST(p.CreateDate as date) <= @ToDate
	

	order by DateTransaction desc , Zindex desc
END

GO
/****** Object:  StoredProcedure [dbo].[usp_ThongTinChiTietGiaoDichCongNoNCC]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nguyễn Văn Phong>
-- Create date: <10/10/2015>
-- Description:	<Báo cáo CHI TIẾT GIAO DICH công nợ NCC>
-- =============================================
CREATE PROCEDURE [dbo].[usp_ThongTinChiTietGiaoDichCongNoNCC]
	@SupplierId int,
	@FromDateSup date,
	@ToDateSup date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	 -- GIÁ TRỊ NHẬP HÀNG NCC
	 select     p.CreatedDate as DateTransaction,--Ngày nhập hàng
			   p.ImportMasterCode as TransactionCode,-- mã nhập hàng
			   '+' as Change,
			   (p.TotalPrice) as Amout,--Số tiền phải trả
			    p.[RemainingAmountAccrued] + ISNULL(p.Paid,0) as RemainingAmountAccrued,--số tiền dư nợ
			    N'Nhập hàng' as Description,
			   1 as Zindex
		from dbo.ImportMasterModel as p
		Where --(p.TotalPrice - ISNULL(p.Paid,0)) != 0  AND
			   p.Actived = 1 AND
			   p.SupplierId = @SupplierId AND
               @FromDateSup <= CAST(p.CreatedDate as date) and CAST(p.CreatedDate as date) <= @ToDateSup
      UNION
	    -- THANH TOÁN NHẬP HÀNG NCC
        select  p.CreatedDate as DateTransaction, 
			    p.ImportMasterCode as TransactionCode,
			   '-' as Change,
			   (p.Paid) as Amout,
			    p.[RemainingAmountAccrued],
			    N'Thanh toán mua hàng' as Description,
			   2 as Zindex 
		from ImportMasterModel as p
		Where --(p.TotalPrice - ISNULL(p.Paid,0)) != 0  AND
		       ISNULL(p.Paid,0) != 0 AND
			   p.Actived = 1 AND
			   p.SupplierId = @SupplierId AND
               @FromDateSup <= CAST(p.CreatedDate as date) and CAST(p.CreatedDate as date) <= @ToDateSup
		UNION
		 -- Tra hang
        select  p.CreatedDate as DateTransaction, 
			    p.ReturnMasterCode as TransactionCode,
			   '-' as Change,
			   (p.Paid) as Amout,
			    ISNULL(p.[RemainingAmountAccrued],0) - ISNULL(p.Paid,0) as RemainingAmountAccrued,--số tiền dư nợ
			    N'Trả hàng' as Description,
			   3 as Zindex 
		from ReturnMasterModel as p
		Where --(p.TotalPrice - ISNULL(p.Paid,0)) != 0  AND
		       ISNULL(p.Paid,0) != 0 AND
			   p.Actived = 1 AND
			   p.SupplierId = @SupplierId AND
               @FromDateSup <= CAST(p.CreatedDate as date) and CAST(p.CreatedDate as date) <= @ToDateSup
	UNION
	 -- Thu tien Tra hang
        select  p.CreatedDate as DateTransaction, 
			    p.ReturnMasterCode as TransactionCode,
			   '+' as Change,
			   (p.Paid) as Amout,
			     ISNULL(p.[RemainingAmountAccrued],0) as RemainingAmountAccrued,
			    N' Thu Tiền Trả hàng' as Description,
			   3 as Zindex 
		from ReturnMasterModel as p
		Where --(p.TotalPrice - ISNULL(p.Paid,0)) != 0  AND
		       ISNULL(p.Paid,0) != 0 AND
			   p.Actived = 1 AND
			   p.SupplierId = @SupplierId AND
               @FromDateSup <= CAST(p.CreatedDate as date) and CAST(p.CreatedDate as date) <= @ToDateSup

   -- THU TIỀN MẶT
  UNION
	select     p.CreateDate as DateTransaction,
			   N'TCTHU' as TransactionCode,
				'-' as Change,
				(p.Amount) as Amout,
				p.[RemainingAmountAccrued],
				N'Thu tiền mặt "' + RTRIM(LTRIM(ISNULL(p.Note,''))) + '"' as Description,
				3 as Zindex
		from AM_TransactionModel as p
		Where --(p.TotalPrice - ISNULL(p.Paid,0)) != 0  AND 
		        p.TransactionTypeCode = 'TCTHU' AND
				p.SupplierId = @SupplierId AND
				@FromDateSup <= CAST(p.CreateDate as date) and CAST(p.CreateDate as date) <= @ToDateSup
	  -- CHI TIỀN MẶT
  UNION
	select     p.CreateDate as DateTransaction,
			   N'TCCHI' as TransactionCode,
				'+' as Change,
				(p.Amount) as Amout,
				p.[RemainingAmountAccrued],
				N'Chi tiền mặt "' + RTRIM(LTRIM(ISNULL(p.Note,''))) + '"' as Description,
				4 as Zindex
		from AM_TransactionModel as p
		Where --(p.TotalPrice - ISNULL(p.Paid,0)) != 0  AND 
		        p.TransactionTypeCode = 'TCCHI' AND
				p.SupplierId = @SupplierId AND
				@FromDateSup <= CAST(p.CreateDate as date) and CAST(p.CreateDate as date) <= @ToDateSup
     -- THU NGÂN HÀNG
  UNION
	select     p.CreateDate as DateTransaction,
			   N'NHNOP' as TransactionCode,
				'-' as Change,
				(p.Amount) as Amout,
				p.[RemainingAmountAccrued],
				N'Thu tiền chuyển khoản NH' + ISNULL(p.Note,'') as Description,
				3 as Zindex
		from AM_TransactionModel as p
		Where --(p.TotalPrice - ISNULL(p.Paid,0)) != 0  AND 
		        p.TransactionTypeCode = 'NHNOP' AND
				p.SupplierId = @SupplierId AND
				@FromDateSup <= CAST(p.CreateDate as date) and CAST(p.CreateDate as date) <= @ToDateSup
      -- CHI NGÂN HÀNG
  UNION
	select     p.CreateDate as DateTransaction,
			   N'NHRUT' as TransactionCode,
				'+' as Change,
				(p.Amount) as Amout,
				p.[RemainingAmountAccrued],
				N'Chi tiền chuyển khoản NH' + ISNULL(p.Note,'') as Description,
				3 as Zindex
		from AM_TransactionModel as p
		Where --(p.TotalPrice - ISNULL(p.Paid,0)) != 0  AND 
		        p.TransactionTypeCode = 'NHRUT' AND
				p.SupplierId = @SupplierId AND
				@FromDateSup <= CAST(p.CreateDate as date) and CAST(p.CreateDate as date) <= @ToDateSup


	order by DateTransaction desc , Zindex desc
END

GO
/****** Object:  StoredProcedure [dbo].[usp_ThongTinCongNoKhachHang]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nguyễn Văn Phong>
-- Create date: <8/10/2015>
-- Description:	<Báo cáo công nợ khách hàng>
-- =============================================
CREATE PROCEDURE [dbo].[usp_ThongTinCongNoKhachHang]
	@CustomerId int,
	@FromDate date = null,
	@ToDate date  = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	  IF exists (select NAME from sysobjects where NAME = '#CustomerInfo')--Chỉ chạy trong Store
		BEGIN
			drop table #CustomerInfo
		END

    CREATE TABLE #CustomerInfo(
	    FullName NVARCHAR(500),
		Phone NVARCHAR(50),
		Email NVARCHAR(50),
		Address NVARCHAR(50),
		BirthDay date,
		GenderString NVARCHAR(50),
		ProvinceId int,
		DistrictId int,
		CustomerLevelName NVARCHAR(50),
		NoPhaiThu decimal(18,2),
		SoDuNoDauKy decimal(18,2),
		SoDuNoCuoiKy decimal(18,2)
	)

	insert into #CustomerInfo(
	    Fullname ,
		Phone ,
		Email ,
		Address ,
		BirthDay ,
		GenderString ,
		ProvinceId ,
		DistrictId ,
		CustomerLevelName 
	)
	SELECT cus.Fullname,
		   cus.Phone,
		   cus.Email,
		   cus.[Address],
		   cus.BirthDay,
		   CASE WHEN cus.Gender = 1 THEN N'Nam'  WHEN cus.Gender = 0 THEN N'Nữ' ELSE '' END ,
		   cus.ProvinceId,
		   cus.DistrictId,
		   cuslevel.CustomerLevelName
	FROM [dbo].[CustomerModel] cus
	inner join [dbo].[CustomerLevelModel] cuslevel on cus.[CustomerLevelId] = cuslevel.[CustomerLevelId]
	WHERE cus.[CustomerId] = @CustomerId

	-- Update Nợ phải thu
	update #CustomerInfo
	set NoPhaiThu = ISNULL((
					 select TOP 1 RemainingAmountAccrued 
					 from [dbo].[AM_DebtModel] 
					 where CustomerId = @CustomerId
					 order by DebtId desc
					),0)

	-- Update Số dư nợ đầu kỳ, cuối kỳ
	update #CustomerInfo
	set SoDuNoDauKy = ISNULL((
					 select TOP 1 RemainingAmountAccrued 
					 from [dbo].[AM_DebtModel] 
					 where CustomerId = @CustomerId 
					 --and Cast(TimeOfDebt as date) >= @FromDate and Cast(TimeOfDebt as date) <= @ToDate
					 AND (@FromDate IS NULL OR Cast(TimeOfDebt as date) < @FromDate ) 
					 order by TimeOfDebt desc
					),0)
	,SoDuNoCuoiKy = ISNULL((
					 select TOP 1 RemainingAmountAccrued 
					 from [dbo].[AM_DebtModel] 
					 where CustomerId = @CustomerId 
					 AND (@ToDate IS NULL OR  Cast(TimeOfDebt as date) <= @ToDate )
					 order by TimeOfDebt desc
					),0)


	select p.FullName,
		   p.Phone,
		   p.Email,
		   p.Address,
		   p.BirthDay,
		   p.GenderString,
		   prov.[ProvinceName],
		    dis.Appellation + ' ' +  dis.DistrictName as DistrictName,
		   p.CustomerLevelName, 
		   p.NoPhaiThu,
		   p.SoDuNoDauKy,
		   p.SoDuNoCuoiKy
	from #CustomerInfo as p
	left join [dbo].[ProvinceModel] prov on p.ProvinceId = prov.ProvinceId
	left join [dbo].[DistrictModel] dis on p.DistrictId = dis.DistrictId
END

GO
/****** Object:  StoredProcedure [dbo].[usp_ThongTinCongNoNhaCungCap]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nguyễn Văn Phong>
-- Create date: <10/10/2015>
-- Description:	<Báo cáo công nợ Nhà cung cấp>
-- =============================================
CREATE PROCEDURE [dbo].[usp_ThongTinCongNoNhaCungCap]
	@SupplierId int,
	@FromDateSup date,
	@ToDateSup date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	  IF exists (select NAME from sysobjects where NAME = '#SupplierInfo')--Chỉ chạy trong Store
		BEGIN
			drop table #SupplierInfo
		END

    CREATE TABLE #SupplierInfo(
	    SupplierName NVARCHAR(500),
		Phone NVARCHAR(50),
		Email NVARCHAR(50),
		Address NVARCHAR(50),
		ProvinceId int,
		DistrictId int,
		BankName NVARCHAR(50), 
		BankAccountNumber NVARCHAR(50), 
		BankOwner NVARCHAR(50),
		NoPhaiTra decimal(18,2),
		SoDuNoDauKy decimal(18,2),
		SoDuNoCuoiKy decimal(18,2)
	)

	insert into #SupplierInfo(
	    SupplierName ,
		Phone ,
		Email ,
		Address ,
		ProvinceId ,
		DistrictId ,
		BankName,
		BankAccountNumber,
		BankOwner
	)
	SELECT sup.SupplierName,
		   sup.Phone,
		   sup.Email,
		   sup.[Address],
		   sup.ProvinceId,
		   sup.DistrictId,
		   sup.BankName,
		   sup.BankAccountNumber,
		   sup.BankOwner
	FROM dbo.SupplierModel sup
	WHERE sup.SupplierId = @SupplierId

	-- Update Nợ phải thu
	update #SupplierInfo
	set NoPhaiTra = ISNULL((
					 select TOP 1 RemainingAmountAccrued 
					 from [dbo].[AM_DebtModel] 
					 where SupplierId = @SupplierId
					 order by TimeOfDebt desc
					),0)

	-- Update Số dư nợ đầu kỳ, cuối kỳ
	update #SupplierInfo
	set SoDuNoDauKy = ISNULL((
					 select TOP 1 RemainingAmountAccrued 
					 from [dbo].[AM_DebtModel] 
					 where SupplierId = @SupplierId
					 --and Cast(TimeOfDebt as date) >= @FromDate and Cast(TimeOfDebt as date) <= @ToDate
					 and Cast(TimeOfDebt as date) < @FromDateSup
					 order by TimeOfDebt desc
					),0)
	,SoDuNoCuoiKy = ISNULL((
					 select TOP 1 RemainingAmountAccrued 
					 from [dbo].[AM_DebtModel] 
					 where SupplierId = @SupplierId 
					 and Cast(TimeOfDebt as date) <= @ToDateSup 
					 order by TimeOfDebt desc
					),0)


	select p.SupplierName,
		   p.Phone,
		   p.Email,
		   p.Address,
		   prov.[ProvinceName],
		   dis.Appellation + ' ' +  dis.DistrictName as DistrictName,
		   p.BankName,
		   p.BankAccountNumber,
		   p.BankOwner,
		   p.NoPhaiTra,
		   p.SoDuNoDauKy,
		   p.SoDuNoCuoiKy
	from #SupplierInfo as p
	left join [dbo].[ProvinceModel] prov on p.ProvinceId = prov.ProvinceId
	left join [dbo].[DistrictModel] dis on p.DistrictId = dis.DistrictId
END

GO
/****** Object:  StoredProcedure [dbo].[usp_TonCuoiSPTuongUngVoiKho]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nguyễn Văn Phong>
-- Create date: <29/11/2016>
-- Description:	<Tính tồn cuối SP tương ứng với kho để Xem chi tiết sản phẩm kiểm kho>
-- =============================================
CREATE PROCEDURE [dbo].[usp_TonCuoiSPTuongUngVoiKho]
	@WarehouseId int
	,@ProductLst ProductList READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--Bước 1: Select tồn cuối của mỗi sản phẩm tương ứng với mỗi kho
	SELECT   invenMa.WarehouseModelId,invenDe.ProductId,  invenDe.EndInventoryQty as TonTrongDatabase
	FROM InventoryDetailModel invenDe
	INNER JOIN @ProductLst P ON invenDe.ProductId = P.ProductId
	INNER JOIN InventoryMasterModel invenMa on (invenDe.InventoryMasterId = invenMa.InventoryMasterId and invenMa.Actived = 1)
	WHERE invenMa.WarehouseModelId = @WarehouseId 
		  --AND invenDe.ProductId IN( SELECT Item FROM @ProductLst)
		  AND  invenDe.InventoryDetailId IN (
										SELECT MAX(InventoryDetailId) 
										FROM InventoryDetailModel  D
										INNER JOIN InventoryMasterModel M ON (D.InventoryMasterId = M.InventoryMasterId and M.Actived = 1)
										GROUP BY ProductId
										)
--EXEC  usp_TonCuoiSPTuongUngVoiKho 6
END

GO
/****** Object:  StoredProcedure [dbo].[usp_TonKhoCanhBaoHienThiTrangChu]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Phong>
-- Create date: <24/11/2016>
-- Description:	<Tồn kho cảnh báo hiển thị trang chủ>
-- =============================================
CREATE PROCEDURE [dbo].[usp_TonKhoCanhBaoHienThiTrangChu] 
@RolesId int = 1	
AS
BEGIN
	
	SET NOCOUNT ON;
	 IF exists (select NAME from sysobjects where NAME = '#TonCuoiSanPhamTuongUngVoiKho')--Chỉ chạy trong Store
    BEGIN
		drop table #TonCuoiSanPhamTuongUngVoiKho
    END

	CREATE TABLE #TonCuoiSanPhamTuongUngVoiKho(
		WarehouseId INT,
		ProductId INT,
		EndInventoryQty decimal(18, 2)
		 )	
		 
   --Bước 1: Select tồn cuối của mỗi sản phẩm tương ứng với mỗi kho
	insert into #TonCuoiSanPhamTuongUngVoiKho 
	SELECT   invenMa.WarehouseModelId,invenDe.ProductId,  invenDe.EndInventoryQty
	FROM InventoryDetailModel invenDe
	INNER JOIN InventoryMasterModel invenMa on (invenDe.InventoryMasterId = invenMa.InventoryMasterId and invenMa.Actived = 1)
	WHERE invenDe.InventoryDetailId IN (
										SELECT MAX(InventoryDetailId) 
										FROM InventoryDetailModel  D
										INNER JOIN InventoryMasterModel M ON (D.InventoryMasterId = M.InventoryMasterId and M.Actived = 1)
										GROUP BY ProductId
										)
  --  SELECT * FROM #TonCuoiSanPhamTuongUngVoiKho
	--Bước 2: Chọn ra những Product thoả cảnh báo
	SELECT wm.WarehouseCode as WarehouseName
		   , pm.ProductName
		   , ISNULL(pTmp.EndInventoryQty,0) as EndInventoryQty
		   , p.QtyAlert
	FROM ProductAlertModel p
	LEFT JOIN #TonCuoiSanPhamTuongUngVoiKho pTmp on (p.ProductId = pTmp.ProductId and p.WarehouseId = pTmp.WarehouseId)
	INNER JOIN ProductModel pm on p.ProductId = pm.ProductId
	INNER JOIN WarehouseModel wm on p.WarehouseId = wm.WarehouseId
	WHERE (p.QtyAlert > ISNULL(pTmp.EndInventoryQty,0))  AND P.RolesId = @RolesId

END

GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateProduct]    Script Date: 3/1/2018 3:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_UpdateProduct]
	@ProductUpdateMasterId int
AS
BEGIN
		-- B1: Update ProductModel
		Update ProductModel
		SET ProductStoreCode = d.ProductStoreCode,
			ProductCode = d.ProductCode,
			ProductName = d.ProductName,
			ImportPrice = d.ImportPrice,
			ExchangeRate = d.ExchangeRate,
			ShippingFee = d.ShippingFee,
			COGS = (d.ImportPrice* d.ExchangeRate) + d.ShippingFee
		From (	SELECT *
				FROM ProductUpdateDetailModel
				Where ProductUpdateMasterId = @ProductUpdateMasterId
						AND Actived = 1  ) AS d
		Where ProductModel.ProductId = d.ProductId
		
		
		-- B2 :Update Giá Vip
		
			--Vip
		Update ProductPriceModel 
		SET Price = d.Price1
		From (SELECT *
				FROM ProductUpdateDetailModel
				Where ProductUpdateMasterId = @ProductUpdateMasterId 
				AND Actived = 1) AS d
		Where ProductPriceModel.ProductId = d.ProductId 
			  AND ProductPriceModel.CustomerLevelId = 1
			  
			-- Vip-Bac  
		Update ProductPriceModel 
		SET Price = d.Price2
		From (SELECT *
				FROM ProductUpdateDetailModel
				Where ProductUpdateMasterId = @ProductUpdateMasterId 
				AND Actived = 1) AS d
		Where ProductPriceModel.ProductId = d.ProductId 
			  AND ProductPriceModel.CustomerLevelId = 2
			  
			 --Vip-Vang
		Update ProductPriceModel 
		SET Price = d.Price3
		From (SELECT *
				FROM ProductUpdateDetailModel
				Where ProductUpdateMasterId = @ProductUpdateMasterId 
				AND Actived = 1) AS d
		Where ProductPriceModel.ProductId = d.ProductId 
			  AND ProductPriceModel.CustomerLevelId = 3
		
			--Vip-Bach kim
		Update ProductPriceModel 
		SET Price = d.Price4
		From (SELECT *
				FROM ProductUpdateDetailModel
				Where ProductUpdateMasterId = @ProductUpdateMasterId 
				AND Actived = 1) AS d
		Where ProductPriceModel.ProductId = d.ProductId 
			  AND ProductPriceModel.CustomerLevelId = 4
		
		-- B3:	CreatedIEOther = true
		Update ProductUpdateMasterModel 
		SET CreatedIEOther = 1
		Where ProductUpdateMasterModel.ProductUpdateMasterId = @ProductUpdateMasterId

		
END




GO
USE [master]
GO
ALTER DATABASE [ChicCut_Dev] SET  READ_WRITE 
GO
