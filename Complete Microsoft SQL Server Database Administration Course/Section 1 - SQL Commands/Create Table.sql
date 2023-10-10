USE [OurFirstDatabase]
GO

/****** Object:  Table [dbo].[personalInfo]    Script Date: 10/10/2023 4:36:01 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[personalInfo](
	[ID] [int] NOT NULL,
	[firstName] [varchar](50) NULL,
	[lastName] [varchar](50) NULL,
	[dob] [date] NOT NULL
) ON [PRIMARY]
GO


