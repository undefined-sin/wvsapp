USE [GameWorld]
GO

/****** Object:  Table [dbo].[ItemSlot_CON]    Script Date: 10/05/2021 17:57:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[ItemSlot_CON](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[CharacterID] [int] NOT NULL,
	[POS] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[ExpireDate] [datetime] NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Attribute] [int] NOT NULL,
	[ItemSN] [bigint] NOT NULL,
 CONSTRAINT [PK_ItemSlot_CON] PRIMARY KEY CLUSTERED 
(
	[SN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


