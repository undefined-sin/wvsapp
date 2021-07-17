USE [GameWorld]
GO

/****** Object:  Table [dbo].[Character]    Script Date: 17/07/2021 06:28:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Character](
	[CharacterID] [int] IDENTITY(1,1) NOT NULL,
	[AccountID] [int] NOT NULL,
	[WorldID] [int] NOT NULL,
	[CharacterName] [varchar](20) NOT NULL,
	[Gender] [tinyint] NOT NULL,
	[LogoutDate] [datetime] NOT NULL,
	[C_Skin] [int] NOT NULL,
	[C_Face] [int] NOT NULL,
	[C_Hair] [int] NOT NULL,
	[C_PetLockerSN] [bigint] NOT NULL,
	[B_Level] [tinyint] NOT NULL,
	[B_Job] [smallint] NOT NULL,
	[B_STR] [smallint] NOT NULL,
	[B_DEX] [smallint] NOT NULL,
	[B_INT] [smallint] NOT NULL,
	[B_LUK] [smallint] NOT NULL,
	[S_HP] [smallint] NOT NULL,
	[S_MaxHP] [smallint] NOT NULL,
	[S_MP] [smallint] NOT NULL,
	[S_MaxMP] [smallint] NOT NULL,
	[S_AP] [smallint] NOT NULL,
	[S_SP] [smallint] NOT NULL,
	[S_EXP] [int] NOT NULL,
	[S_POP] [smallint] NOT NULL,
	[S_Money] [int] NOT NULL,
	[P_Map] [int] NOT NULL,
	[P_Portal] [int] NOT NULL,
	[CheckSum] [int] NOT NULL,
	[ItemCountCheckSum] [int] NOT NULL,
 CONSTRAINT [PK_Character] PRIMARY KEY CLUSTERED 
(
	[CharacterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [CHARACTER_UNIQUE_NAME] UNIQUE NONCLUSTERED 
(
	[CharacterName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


