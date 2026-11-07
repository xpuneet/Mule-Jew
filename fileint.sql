/****** Object:  Table [dbo].[BlobConnectionConfigs]    Script Date: 07/11/2026 10:47:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlobConnectionConfigs](
	[ID] [nvarchar](100) NOT NULL,
	[StorageName] [nvarchar](100) NULL,
	[ServiceEndPoint] [nvarchar](150) NULL,
	[ContainerName] [nvarchar](100) NULL,
	[ServicePrincipal] [nvarchar](150) NULL,
	[URL] [nvarchar](150) NULL,
	[ClientId] [nvarchar](150) NULL,
	[ClientSecretKey] [nvarchar](150) NULL,
	[CreationDateTime] [datetime] NULL,
	[UpdationDateTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FileActionExecutions]    Script Date: 07/11/2026 10:47:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FileActionExecutions](
	[ID] [uniqueidentifier] NOT NULL,
	[FileActionID] [nvarchar](100) NOT NULL,
	[CorrelationID] [uniqueidentifier] NOT NULL,
	[ProcessDate] [date] NULL,
	[Status] [nvarchar](100) NULL,
	[TokenFileName] [nvarchar](100) NULL,
	[ActualFileName] [nvarchar](100) NULL,
	[TokenSent] [bit] NULL,
	[RecordCount] [int] NULL,
	[LastRunId] [int] NULL,
	[LastMagicNumber] [int] NULL,
	[CreationDateTime] [datetime] NULL,
	[UpdationDateTime] [datetime] NULL,
	[ErrorMessage] [nvarchar](max) NULL,
	[PipelineID] [nvarchar](200) NULL,
	[LastRunTotalAmount] [decimal](18, 2) NULL,
	[OutputFileName] [nvarchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FileActions]    Script Date: 07/11/2026 10:47:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FileActions](
	[ID] [nvarchar](100) NOT NULL,
	[IntegrationKeyID] [nvarchar](100) NOT NULL,
	[ActionName] [nvarchar](max) NOT NULL,
	[SourceID] [nvarchar](100) NOT NULL,
	[DestinationID] [nvarchar](100) NOT NULL,
	[PipelineName] [nvarchar](100) NOT NULL,
	[SourceFileNameFormat] [nvarchar](100) NULL,
	[SourceFolderPath] [nvarchar](250) NULL,
	[SourceArchive] [bit] NULL,
	[SourceArchivePath] [nvarchar](100) NULL,
	[DestinationFileNameFormat] [nvarchar](100) NULL,
	[DestinationFolderPath] [nvarchar](200) NULL,
	[RetryCount] [int] NOT NULL,
	[BlobTriggerPath] [nvarchar](100) NULL,
	[CreationDateTime] [datetime] NULL,
	[UpdationDateTime] [datetime] NULL,
	[SourceErrorPath] [nvarchar](150) NULL,
	[RetentionNoofDays] [int] NULL,
	[RetentionNoofFiles] [int] NULL,
	[SourceDelete] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FilesIntegration]    Script Date: 07/11/2026 10:47:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FilesIntegration](
	[ID] [nvarchar](100) NOT NULL,
	[IntegrationKey] [nvarchar](100) NOT NULL,
	[SourceSystem] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[ProjectName] [nvarchar](100) NULL,
	[SchedulerName] [nvarchar](100) NULL,
	[TokenAckRequired] [bit] NULL,
	[TokenFileName] [nvarchar](100) NULL,
	[CreationDateTime] [datetime] NULL,
	[UpdationDateTime] [datetime] NULL,
	[StartsWith] [nvarchar](150) NULL,
	[EndsWith] [nvarchar](150) NULL,
	[IsSynchronizedToken] [bit] NULL,
	[FileContainsFilter] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SFTPConnectionConfigs]    Script Date: 07/11/2026 10:47:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SFTPConnectionConfigs](
	[ID] [nvarchar](100) NOT NULL,
	[IPAddress] [nvarchar](150) NULL,
	[Port] [nvarchar](100) NULL,
	[Username] [nvarchar](100) NULL,
	[Password] [nvarchar](150) NULL,
	[FolderPath] [nvarchar](max) NULL,
	[CreationDateTime] [datetime] NULL,
	[UpdationDateTime] [datetime] NULL,
	[PasswordKey] [nvarchar](255) NULL,
	[RSABase64Key] [nvarchar](max) NULL,
	[SSHKey] [nvarchar](max) NULL,
	[PassPhraseKey] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[BlobConnectionConfigs] ADD  DEFAULT (getdate()) FOR [CreationDateTime]
GO
ALTER TABLE [dbo].[FileActionExecutions] ADD  DEFAULT (getdate()) FOR [CreationDateTime]
GO
ALTER TABLE [dbo].[FileActions] ADD  DEFAULT (getdate()) FOR [CreationDateTime]
GO
ALTER TABLE [dbo].[FilesIntegration] ADD  CONSTRAINT [DF_FilesIntegration_CreationDateTime]  DEFAULT (getdate()) FOR [CreationDateTime]
GO
ALTER TABLE [dbo].[SFTPConnectionConfigs] ADD  DEFAULT (getdate()) FOR [CreationDateTime]
GO
ALTER TABLE [dbo].[FileActionExecutions]  WITH CHECK ADD  CONSTRAINT [FK_FileActionExecutions] FOREIGN KEY([FileActionID])
REFERENCES [dbo].[FileActions] ([ID])
GO
ALTER TABLE [dbo].[FileActionExecutions] CHECK CONSTRAINT [FK_FileActionExecutions]
GO
ALTER TABLE [dbo].[FileActions]  WITH CHECK ADD  CONSTRAINT [FK_IntegrationFileActions] FOREIGN KEY([IntegrationKeyID])
REFERENCES [dbo].[FilesIntegration] ([ID])
GO
ALTER TABLE [dbo].[FileActions] CHECK CONSTRAINT [FK_IntegrationFileActions]
GO
