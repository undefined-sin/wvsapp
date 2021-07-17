USE [GlobalAccount]
GO

/****** Object:  Table [dbo].[Account]    Script Date: 17/07/2021 06:27:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Account](
	[AccountID] [int] IDENTITY(1,1) NOT NULL,
	[AccountName] [varchar](20) NOT NULL,
	[PasswordHash] [varchar](32) NOT NULL,
	[Pin] [varchar](4) NOT NULL DEFAULT (''),
	[ReadEULA] [tinyint] NOT NULL DEFAULT ((0)),
	[IsBanned] [tinyint] NOT NULL DEFAULT ((0)),
	[AccountStatusID] [int] NOT NULL DEFAULT ((0)),
	[PrivateStatusID] [int] NOT NULL DEFAULT ((0)),
	[BirthDate] [datetime] NOT NULL,
	[CurrentIP] [varchar](15) NOT NULL DEFAULT (''),
	[Admin] [tinyint] NOT NULL DEFAULT ((0)),
	[NeedVerification] [int] NOT NULL DEFAULT ((0)),
	[AccountFlags] [int] NOT NULL DEFAULT ((0)),
	[ChatBlock] [int] NOT NULL DEFAULT ((0)),
	[PacketDump] [int] NOT NULL DEFAULT ((0)),
	[Gender] [smallint] NOT NULL CONSTRAINT [DF_Account_Gender]  DEFAULT ((-1)),
	[RegisterDate] [datetime] NOT NULL CONSTRAINT [DF_Account_RegisterDate]  DEFAULT (getdate()),
	[maplePoint] [int] NULL CONSTRAINT [DF_Account_maplePoint]  DEFAULT ((0)),
	[PurchaseExp] [int] NULL DEFAULT ((0)),
	[Email] [varchar](70) NULL,
	[NexonCash] [int] NULL CONSTRAINT [DF_Account_NexonCash]  DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


