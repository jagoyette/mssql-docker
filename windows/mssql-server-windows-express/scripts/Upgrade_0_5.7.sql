GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO


IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'Diagnosis') DROP TABLE dbo.Diagnosis;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'Exam') DROP TABLE dbo.Exam;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'ExamMediaBase') DROP TABLE dbo.ExamMediaBase;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'Finding') DROP TABLE dbo.Finding;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'MediaBaseQualityCheck') DROP TABLE dbo.MediaBaseQualityCheck;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'MediaBase') DROP TABLE dbo.MediaBase;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'MediaFrame') DROP TABLE dbo.MediaFrame;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'MediaSession') DROP TABLE dbo.MediaSession;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'MediaSettings') DROP TABLE dbo.MediaSettings;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'MediaWorkspace')  DROP TABLE dbo.MediaWorkspace;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'MetaData')  DROP TABLE dbo.MetaData;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'Patient')  DROP TABLE dbo.Patient;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'OwsOrder')  DROP TABLE dbo.OwsOrder;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'OwsUserRole')  DROP TABLE dbo.OwsUserRole;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'Role')  DROP TABLE dbo.[Role];
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'OwsUser')  DROP TABLE dbo.OwsUser;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'MediaBaseDescriptorLocalization')  DROP TABLE MediaBaseDescriptorLocalization;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'MediaBaseDescriptor')  DROP TABLE dbo.MediaBaseDescriptor;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'HardwareSetHardwareComponent') DROP TABLE dbo.HardwareSetHardwareComponent;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'OwsQualityCheck') DROP TABLE dbo.OwsQualityCheck;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'OwsHardwareComponent') DROP TABLE dbo.OwsHardwareComponent;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'OwsHardwareSet') DROP TABLE dbo.OwsHardwareSet;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'OwsQualityCheckStandard') DROP TABLE dbo.OwsQualityCheckStandard;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'OwsDevice') DROP TABLE dbo.OwsDevice;




GO

GO
PRINT N'Creating [dbo].[Configuration]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'Configuration')
CREATE TABLE [dbo].[Configuration] (
    [ConfigGroupKey] INT            NOT NULL,
    [ConfigKey]      NVARCHAR (255) NOT NULL,
    [ConfigValue]    NVARCHAR (255) NOT NULL,
    CONSTRAINT [PK_Configuration] PRIMARY KEY CLUSTERED ([ConfigGroupKey] ASC, [ConfigKey] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[Finding]...';


GO
CREATE TABLE [dbo].[Finding] (
    [Id]                  INT              IDENTITY (1, 1) NOT NULL,
    [Guid]                UNIQUEIDENTIFIER NOT NULL,
    [AnatomicRegions]     NVARCHAR (1000)  NOT NULL,
    [AssociatedExamGuid]  UNIQUEIDENTIFIER NULL,
    [AssociatedViewGuid]  UNIQUEIDENTIFIER NULL,
    [AudioGuid]           UNIQUEIDENTIFIER NULL,
    [CreationTimeStamp]   DATETIME         NOT NULL,
    [Description]         NVARCHAR (MAX)   NOT NULL,
    [ExternalId]          NVARCHAR (200)   NULL,
    [Radius]              FLOAT (53)       NULL,
    [Title]               NVARCHAR (250)   NOT NULL,
    [AssociatedMediaId]   INT              NULL,
    [ResponsibleDoctorId] INT              NOT NULL,
    [PatientId]           INT              NOT NULL,
    [DiagnosisId]         INT              NULL,
    [ImageFilePath]       NVARCHAR (512)   NULL,
    [IsDeleted]           BIT              NOT NULL,
    [DeletionDate]        DATETIME         NULL,
    CONSTRAINT [PK_Finding] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UC_Finding_Guid] UNIQUE NONCLUSTERED ([Guid] ASC)
);


GO
PRINT N'Creating [dbo].[HardwareSetHardwareComponent]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [dbo].[HardwareSetHardwareComponent] (
    [HardwareSetId]       INT NOT NULL,
    [HardwareComponentId] INT NOT NULL
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[MediaBase]...';


GO
CREATE TABLE [dbo].[MediaBase] (
    [MediaBaseId]           INT              IDENTITY (1, 1) NOT NULL,
    [AnatomicRegions]       NVARCHAR (1000)  NULL,
    [PatientId]             INT              NULL,
    [ParentGuid]            UNIQUEIDENTIFIER NULL,
    [RootNode]              UNIQUEIDENTIFIER NOT NULL,
    [Guid]                  UNIQUEIDENTIFIER NOT NULL,
    [MediaBaseDescriptorId] INT              NULL,
    [OrderId]               INT              NULL,
    [Name]                  NVARCHAR (300)   NULL,
    [CreationDate]          DATETIME         NOT NULL,
	[InsertionDate]         DATETIME         NOT NULL,
	[LatestUseDate]         DATETIME         NULL,
    [MediaFile]             NVARCHAR (256)   NULL,
    [PreviewFilePath]       NVARCHAR (256)   NULL,
    [MediaHash]             NVARCHAR (50)    NULL,
    [FileType]              NVARCHAR (50)    NULL,
	[WasCreatedOnSite]      BIT              NULL DEFAULT(NULL),
    [IsInitial]             BIT              NULL,
    [IsDeleted]             BIT              NOT NULL,
	[IsHidden]              BIT              NOT NULL,
    [DeletionDate]          DATETIME         NULL,
    [OutsourcedDate]        DATETIME         NULL,
    [InsourcedDate]         DATETIME         NULL,
    [OutsourcingType]       NVARCHAR (50)    NULL,
    [OutsourcingVolume]     NVARCHAR (512)   NULL,
    [OutsourcedFile]        NVARCHAR (256)   NULL,
    [OutsourcedLocation]    NVARCHAR (1)     NULL,
    [Vendor]                NVARCHAR (100)   NULL,
    CONSTRAINT [PK_MediaBase] PRIMARY KEY CLUSTERED ([MediaBaseId] ASC),
    CONSTRAINT [UC_MediaBase_Guid] UNIQUE NONCLUSTERED ([Guid] ASC)
);


GO
PRINT N'Creating [dbo].[MediaBaseDescriptor]...';


GO
CREATE TABLE [dbo].[MediaBaseDescriptor] (
    [MediaBaseDescriptorId]  INT            IDENTITY (200, 1) NOT NULL,
    [MediaCategory]          NVARCHAR (255) NOT NULL,
    [ClassicTakeType]        NVARCHAR (128) NULL,
    [Classification]         NVARCHAR (128) NULL,
    [IsDisplayable]          BIT            NOT NULL,
    [IsXRay]                 BIT            NOT NULL,
    [LogicalName]            NVARCHAR (255) NOT NULL,
    [IconUri]                NVARCHAR (255) NULL,
    [DefaultAnatomicRegions] NVARCHAR (255) NULL,
    [IsDeleted]              BIT            NOT NULL,
    [DeletionDate]           DATETIME       NULL,
    CONSTRAINT [PK_MediaBaseDescriptor] PRIMARY KEY CLUSTERED ([MediaBaseDescriptorId] ASC),
    CONSTRAINT [UC_MediaBaseDescriptor_LogicalName] UNIQUE NONCLUSTERED ([LogicalName] ASC)
);


GO
PRINT N'Creating [dbo].[MediaBaseDescriptor].[UQ_MediaBaseDescriptor_ASC]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_MediaBaseDescriptor_ASC]
    ON [dbo].[MediaBaseDescriptor]([LogicalName] ASC);


GO
PRINT N'Creating [dbo].[MediaBaseDescriptorLocalization]...';


GO
CREATE TABLE [dbo].[MediaBaseDescriptorLocalization] (
    [CultureCode]       NVARCHAR (10)   NOT NULL,
    [ShortName]         NVARCHAR (300)  NOT NULL,
    [VerboseName]       NVARCHAR (2000) NOT NULL,
    [MediaDescriptorId] INT             NOT NULL,
    [Id]                INT             IDENTITY (8000, 1) NOT NULL,
    [IsDeleted]         BIT             NOT NULL,
    [DeletionDate]      DATETIME        NULL,
    CONSTRAINT [PK_MediaBaseDescriptorLocalization] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[MediaBaseDescriptorLocalization].[UQ_MediaBaseDescriptorLocalization_ASC]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_MediaBaseDescriptorLocalization_ASC]
    ON [dbo].[MediaBaseDescriptorLocalization]([Id] ASC);


GO
PRINT N'Creating [dbo].[MediaBaseDescriptorLocalization].[IX_MediaBaseDescriptorLocalization_MediaDescriptorId_ASC]...';

CREATE NONCLUSTERED INDEX [IX_MediaBaseDescriptorLocalization_MediaDescriptorId_ASC] ON [dbo].[MediaBaseDescriptorLocalization] ([MediaDescriptorId] ASC)

GO
PRINT N'Creating [dbo].[MediaBaseQualityCheck]...';


GO
CREATE TABLE [dbo].[MediaBaseQualityCheck] (
    [MediaBaseId]    INT NOT NULL,
    [QualityCheckId] INT NOT NULL,
    CONSTRAINT [PK_MediaBaseUnitHardwareSet] PRIMARY KEY CLUSTERED ([MediaBaseId] ASC)
);


GO
PRINT N'Creating [dbo].[MediaFrame]...';


GO
CREATE TABLE [dbo].[MediaFrame] (
    [MediaFrameId]           INT              IDENTITY (1, 1) NOT NULL,
    [Guid]                   UNIQUEIDENTIFIER NOT NULL,
    [Title]                  NVARCHAR (300)   NULL,
    [MediaWorkspaceId]       INT              NULL,
    [MediaBaseGuid]          UNIQUEIDENTIFIER NULL,
    [FrameTypeQualifiedName] NVARCHAR (1000)  NOT NULL,
    [IsDeleted]              BIT              NOT NULL,
    [DeletionDate]           DATETIME         NULL,
    CONSTRAINT [PK_MediaFrame] PRIMARY KEY CLUSTERED ([MediaFrameId] ASC)
);


GO
PRINT N'Creating [dbo].[MediaFrame].[UQ_MediaFrame_GUID_ASC]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_MediaFrame_GUID_ASC]
    ON [dbo].[MediaFrame]([Guid] ASC);


GO

PRINT N'Creating [dbo].[MediaFrame].[UQ_MediaFrame_MediaFrameId_ASC]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_MediaFrame_MediaFrameId_ASC]
    ON [dbo].[MediaFrame]([MediaFrameId] ASC);


GO
PRINT N'Creating [dbo].[MediaSession]...';


GO
CREATE TABLE [dbo].[MediaSession] (
    [Guid]                      UNIQUEIDENTIFIER NOT NULL,
    [CreationTimeStamp]         DATETIME         NULL,
    [LastModified]              DATETIME         NULL,
    [PatientGuid]               UNIQUEIDENTIFIER NULL,
    [MediaSessionId]            INT              IDENTITY (1, 1) NOT NULL,
    [PreviewFile]               NVARCHAR (256)   NOT NULL,
    [IsDeleted]                 BIT              NOT NULL,
    [DeletionDate]              DATETIME         NULL,
    [CurrentMediaWorkspaceGuid] UNIQUEIDENTIFIER NULL,
    [Title]                     NVARCHAR (350)   NULL,
    [RecentListDate]            DATETIME         NOT NULL,
    CONSTRAINT [PK_MediaSession] PRIMARY KEY CLUSTERED ([MediaSessionId] ASC),
    CONSTRAINT [UC_MediaSession_Guid] UNIQUE NONCLUSTERED ([Guid] ASC)
);


GO
PRINT N'Creating [dbo].[MediaWorkspace]...';


GO
CREATE TABLE [dbo].[MediaWorkspace] (
    [Guid]              UNIQUEIDENTIFIER NOT NULL,
    [Title]             NVARCHAR (300)   NULL,
    [CreationTimeStamp] DATETIME         NULL,
    [LastModified]      DATETIME         NULL,
    [WorkspaceType]     NTEXT            NOT NULL,
    [PreviewFile]       NVARCHAR (500)   NULL,
    [PreviewLocation]   NVARCHAR (5)     NULL,
    [MediaSessionId]    INT              NULL,
    [MediaWorkspaceId]  INT              IDENTITY (1, 1) NOT NULL,
    [IsDeleted]         BIT              NOT NULL,
    [DeletionDate]      DATETIME         NULL,
    CONSTRAINT [PK_MediaWorkspace] PRIMARY KEY CLUSTERED ([MediaWorkspaceId] ASC),
    CONSTRAINT [UC_MediaWorkspace_Guid] UNIQUE NONCLUSTERED ([Guid] ASC)
);


GO
PRINT N'Creating [dbo].[OwsDevice]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
CREATE TABLE [dbo].[OwsDevice] (
    [DeviceId]     INT              IDENTITY (1, 1) NOT NULL,
    [Guid]         UNIQUEIDENTIFIER NOT NULL,
    [DeviceUid]    NVARCHAR (4000)  NOT NULL,
    [DeviceType]   NVARCHAR (350)   NOT NULL,
    [SerialNumber] NVARCHAR (350)   NULL,
    [IsActive]     BIT              NOT NULL,
    [IsDeleted]    BIT              NOT NULL,
    [DeletionDate] DATETIME         NULL,
    [Name]         [nvarchar](2048) NULL,
    [Location]     [nvarchar](2048) NULL,
    CONSTRAINT [PK_OwsUnit] PRIMARY KEY CLUSTERED ([DeviceId] ASC),
    CONSTRAINT [UC_OwsUnit_Guid] UNIQUE NONCLUSTERED ([Guid] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[OwsHardwareComponent]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [dbo].[OwsHardwareComponent] (
    [HardwareComponentId] INT              IDENTITY (1, 1) NOT NULL,
    [Guid]                UNIQUEIDENTIFIER NOT NULL,
    [Name]                NVARCHAR (500)   NOT NULL,
    [ComponentType]       NVARCHAR (350)   NOT NULL,
    [SerialNumber]        NVARCHAR (350)   NULL,
    [IsActive]            BIT              NOT NULL,
    [IsDeleted]           BIT              NOT NULL,
    [DeletionDate]        DATETIME         NULL,
    CONSTRAINT [PK_OwsHardwareComponent] PRIMARY KEY CLUSTERED ([HardwareComponentId] ASC),
    CONSTRAINT [UC_OwsHardwareComponent_Guid] UNIQUE NONCLUSTERED ([Guid] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[OwsHardwareSet]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [dbo].[OwsHardwareSet] (
    [HardwareSetId]   INT              IDENTITY (1, 1) NOT NULL,
    [Guid]            UNIQUEIDENTIFIER NOT NULL,
    [Name]            NVARCHAR (500)   NOT NULL,
    [IsActive]        BIT              NOT NULL,
    [IsDeleted]       BIT              NOT NULL,
    [DeletionDate]    DATETIME         NULL,
    [DeviceId]        INT              NULL,
    [HardwareSetType] INT              NULL,
	[HardwareSetUId]  NVARCHAR (500)   NOT NULL,
    CONSTRAINT [PK_OwsHardwareSet] PRIMARY KEY CLUSTERED ([HardwareSetId] ASC),
    CONSTRAINT [UC_OwsHardwareSet_Guid] UNIQUE NONCLUSTERED ([Guid] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;

GO
PRINT N'Creating [dbo].[OwsQualityCheckStandard]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [dbo].[OwsQualityCheckStandard] (
    [StandardId]      INT              IDENTITY (1, 1) NOT NULL,
    [Guid]            UNIQUEIDENTIFIER NOT NULL,
    [Name]            NVARCHAR (500)   NOT NULL,
    [IsActive]        BIT              NOT NULL,
    [IsDeleted]       BIT              NOT NULL,
    [DeletionDate]    DATETIME         NULL,    
    CONSTRAINT [PK_OwsQualityCheckStandard] PRIMARY KEY CLUSTERED ([StandardId] ASC),
    CONSTRAINT [UC_OwsQualityCheckStandard_Guid] UNIQUE NONCLUSTERED ([Guid] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[OwsOrder]...';


GO
CREATE TABLE [dbo].[OwsOrder] (
    [OrderId]                 INT              IDENTITY (1, 1) NOT NULL,
    [Guid]                    UNIQUEIDENTIFIER NOT NULL,
    [MediaBaseDescriptorId]   INT              NULL,
    [AnatomicRegions]         NVARCHAR (1000)  NULL,
    [Reason]                  NVARCHAR (2000)  NULL,
    [PatientGuid]             UNIQUEIDENTIFIER NULL,
    [PatientFirstName]        NVARCHAR (128)   NULL,
    [PatientLastName]         NVARCHAR (128)   NULL,
    [PatientSex]              NVARCHAR (10)    NULL,
    [PatientBirthday]         DATETIME         NULL,
    [IsPatientPregnant]       BIT              NULL,
    [WeekOfPregnancy]         INT              NULL,
    [IndicatingDoctor]        INT              NULL,
    [ExternalOrderId]         BIGINT           NULL,
    [ExternalAccessionNumber] NVARCHAR (128)   NULL,
    [OrderState]              NVARCHAR (255)   NOT NULL,
    [ScanMode]                NVARCHAR (255)   NOT NULL,
    [RequestingStation]       NVARCHAR (128)   NULL,
    [CreationTimeStamp]       DATETIME         NOT NULL,
    [PatientId]               INT              NOT NULL,
    [RadiologyTech]           INT              NULL,
    [IsDeleted]               BIT              NOT NULL,
    [DeletionDate]            DATETIME         NULL,
    [Parent]                  UNIQUEIDENTIFIER NULL,
    [ExecutionMode]           NVARCHAR (255)   NULL,
    CONSTRAINT [PK_OwsOrder] PRIMARY KEY CLUSTERED ([OrderId] ASC),
    CONSTRAINT [UC_OwsOrder_Guid] UNIQUE NONCLUSTERED ([Guid] ASC)
);


GO
PRINT N'Creating [dbo].[OwsQualityCheck]...';


GO
CREATE TABLE [dbo].[OwsQualityCheck] (
    [QualityCheckId]           INT              IDENTITY (1, 1) NOT NULL,
    [Guid]                     UNIQUEIDENTIFIER NOT NULL,
    [CreationDate]             DATETIME         NOT NULL,
    [Description]              NVARCHAR (2048)  NOT NULL,
    [HardwareSetId]            INT              NULL,
    [AcceptanceQualityCheckId] INT              NULL,
    [IsDeleted]                BIT              NOT NULL,
    [DeletionDate]             DATETIME         NULL,
    [Interval]                 INT              NULL,
    [StandardId]               INT              NULL,
    [Comment]                  NVARCHAR (2048)  NULL,
    CONSTRAINT [PK_QualityCheck] PRIMARY KEY CLUSTERED ([QualityCheckId] ASC),
    CONSTRAINT [UC_QualityCheck_Guid] UNIQUE NONCLUSTERED ([Guid] ASC)
);


GO
PRINT N'Creating [dbo].[OwsUser]...';


GO
CREATE TABLE [dbo].[OwsUser] (
    [UserId]       INT              IDENTITY (5, 1) NOT NULL,
    [Guid]         UNIQUEIDENTIFIER NOT NULL,
    [Degree]       NVARCHAR (50)    NULL,
    [FirstName]    NVARCHAR (128)   NULL,
    [LastName]     NVARCHAR (128)   NULL,
    [IsActive]     BIT              NULL,
    [IsDeleted]    BIT              NOT NULL,
    [DeletionDate] DATETIME         NULL,
	[Password]		NVARCHAR(255)	NULL,
	[IsVisible]		BIT				NOT NULL DEFAULT(1)
    CONSTRAINT [PK_OwsUser] PRIMARY KEY CLUSTERED ([UserId] ASC),
    CONSTRAINT [UC_OwsUser_Guid] UNIQUE NONCLUSTERED ([Guid] ASC)
);


GO
PRINT N'Creating [dbo].[OwsUserRole]...';


GO
CREATE TABLE [dbo].[OwsUserRole] (
    [UserId]       INT      NOT NULL,
    [RoleId]       INT      NOT NULL,
    [IsDeleted]    BIT      NOT NULL,
    [DeletionDate] DATETIME NULL
);


GO
PRINT N'Creating [dbo].[Patient]...';


GO
CREATE TABLE [dbo].[Patient] (
    [PatientId]         INT              IDENTITY (1, 1) NOT NULL,
    [Guid]              UNIQUEIDENTIFIER NOT NULL,
    [FirstName]         NVARCHAR (128)   NOT NULL,
    [LastName]          NVARCHAR (128)   NOT NULL,
    [Sex]               NVARCHAR (10)    NOT NULL,
    [Birthday]          DATETIME         NULL,
    [EntryDate]         DATETIME         NOT NULL,
    [SocialInsuranceNo] NVARCHAR (256)   NULL,
    [CardId]            NVARCHAR (32)    NULL,
    [IsCardIdExternal]  BIT    		     NOT NULL DEFAULT(0),
    [AdditionalData]    NTEXT            NULL,
    [LastDisplayed]     DATETIME         NULL,
    [ServerId]          NVARCHAR (64)    NULL,
    [PicturePath]       NVARCHAR (255)   NULL,
    [DoctorId]          INT              NULL,
    [Birthplace]        NVARCHAR (200)   NULL,
    [Degree]            NVARCHAR (50)    NULL,
    [MidName]           NVARCHAR (128)   NULL,
    [IsDeleted]         BIT              NOT NULL,
    [DeletionDate]      DATETIME         NULL,
    CONSTRAINT [PK_Patient] PRIMARY KEY CLUSTERED ([PatientId] ASC),
    CONSTRAINT [UC_Patient_Guid] UNIQUE NONCLUSTERED ([Guid] ASC)
);


GO

PRINT N'Creating [dbo].[Patient].[IX_Patient_CardId_IsDel]...';

CREATE NONCLUSTERED INDEX [IX_Patient_CardId_IsDel] ON [dbo].[Patient] ([CardId], [IsDeleted])
GO

CREATE NONCLUSTERED INDEX [IX_Patient_CardId]
    ON [dbo].[Patient](CardId)
GO

CREATE NONCLUSTERED INDEX [IX_Patient_LastName]
	ON [dbo].[Patient] ([LastName])
GO

PRINT N'Creating [dbo].[ProvisioningJob]...';


GO
-- Very important! For filtered indexes
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;

GO
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND  TABLE_NAME = 'ProvisioningJob')
CREATE TABLE [dbo].[ProvisioningJob] (
    [Id]                                       UNIQUEIDENTIFIER NOT NULL,
    [PackageId]                                UNIQUEIDENTIFIER NOT NULL,
    [Package]                                  NVARCHAR (255)   NULL,
    [VersionId]                                UNIQUEIDENTIFIER NOT NULL,
    [Version]                                  NVARCHAR (50)    NULL,
    [TenantId]                                 UNIQUEIDENTIFIER NULL,
    [Tenant]                                   NVARCHAR (255)   NULL,
    [StartedAt]                                DATETIME         NOT NULL,
    [IsContinuation]                           BIT              NOT NULL,
    [JobType]                                  INT              NOT NULL,
    [TargetType]                               INT              NOT NULL,
    [Target]                                   NVARCHAR (255)   NOT NULL,
    [JobStatus]                                INT              NOT NULL,
    [DbServer]                                 NVARCHAR (255)   NULL,
    [DbSqlServerInstance]                      NVARCHAR (50)    NULL,
    [DbPort]                                   INT              NULL,
    [DbSqlServerAuthenticationMode]            INT              NULL,
    [DbSqlServerNetworkProtocol]               INT              NULL,
    [DbSqlServerBrowserIsActive]               BIT              NULL,
    [DbSqlServerAdminUser]                     NVARCHAR (50)    NULL,
    [DbSqlServerAdminPassword]                 NVARCHAR (50)    NULL,
    [DbSqlServerStandardUser]                  NVARCHAR (50)    NULL,
    [DbSqlServerStandardPassword]              NVARCHAR (50)    NULL,
    [DbSqlServerIsIntegratedSecurityAvailable] BIT              NOT NULL,
    [DbSqlServerSeedUser]                      NVARCHAR(50)     NULL, 
    [DbSqlServerSeedPassword]                  NVARCHAR(50)     NULL, 	
    [DbSqlServerWindowsAdmins]                 NVARCHAR (255)   NULL,
    [DbSqlServerWindowsStandardUsers]          NVARCHAR (255)   NULL,
    [DbBackupShare]						       NVARCHAR (255)   NULL,
    [DbBackupTime]                             TIME (0)         NULL,
    [DbBackupIntervallHours]                   INT              NULL,
    [DbBackupRetentionDays]                    INT              NULL,
    [ServiceHostType]                          INT              NULL,
    [ServiceUriHostName]                       NVARCHAR (255)   NULL,
    [ServiceUriScheme]                         NVARCHAR (10)    NULL,
    [ServiceUriPort]                           INT              NULL,
    [ServiceUriSslPort]                        INT              NULL,
    [ServiceUriHostHeader]                     NVARCHAR (50)    NULL,
    [ServiceUriRootPath]                       NVARCHAR (50)    NULL,
    [WindowsServiceUserType]                   INT              NULL,
    [WindowsServiceUserName]                   NVARCHAR (255)   NULL,
    [WindowsServicePassword]                   NVARCHAR (50)    NULL,
    [PdataPath]                                NVARCHAR (255)   NULL,
    [PdataShareIsOnNas]                        BIT              NULL,
    [PdataShareUsers]                          NVARCHAR (255)   NULL,
    [DeploymentPath]                           NVARCHAR (255)   NULL,
    [DeploymentShareIsOnNas]                   BIT              NULL,
    [DeploymentShareUsers]                     NVARCHAR (50)    NULL,
    [PluginConfigurationMigrationStatus]       INT              NOT NULL,
    [StationConfigurationMigrationStatus]      INT              NOT NULL,
    [GlobalConfigurationMigrationStatus]       INT              NOT NULL,
    CONSTRAINT [PK_ProvisioningJob] PRIMARY KEY CLUSTERED ([Id] ASC)
);


PRINT N'Creating [dbo].[UQ_ProvisioningJob_TargetType]...';

-- Prevent double ProvisioningJob Server entries --
CREATE UNIQUE NONCLUSTERED INDEX [UQ_ProvisioningJob_TargetType]
    ON [dbo].[ProvisioningJob]([TargetType])    
    WHERE [TargetType] = 0;
GO

GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[Role]...';


GO
CREATE TABLE [dbo].[Role] (
    [RoleId]       INT              IDENTITY (10, 1) NOT NULL,
    [Guid]         UNIQUEIDENTIFIER NOT NULL,
    [RoleName]     NVARCHAR (128)   NOT NULL,
    [IsDeleted]    BIT              NOT NULL,
    [DeletionDate] DATETIME         NULL,
	[IsVisible]		BIT				NOT NULL DEFAULT(1)
    CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED ([RoleId] ASC),
    CONSTRAINT [UC_Role_Guid] UNIQUE NONCLUSTERED ([Guid] ASC)
);


GO
PRINT N'Creating [dbo].[OwsQualityCheckSummaryView]...';


GO
CREATE VIEW [dbo].[OwsQualityCheckSummaryView] 
AS
WITH [QCV] AS
(
SELECT [QC].[QualityCheckId],
       [QC].[Guid],
       [QC].[CreationDate],
       [QC].[Description],       
       [QC].[IsDeleted],
       [QC].[Interval],
       [QC].[Comment],
       [AQC].[Guid] AS [AcceptanceQualityCheckGuid],
       cast (CASE WHEN [QC].[AcceptanceQualityCheckId] IS NULL THEN 1 ELSE 0 END as bit) AS [IsAcceptance],
	   CASE WHEN [QC].[AcceptanceQualityCheckId] IS NULL THEN [QC].[HardwareSetId] ELSE [AQC].[HardwareSetId] END AS [HardwareSetId],
	   [QC].[StandardId]
FROM [dbo].[OwsQualityCheck] [QC] left outer join [dbo].[OwsQualityCheck] [AQC] 
  on [AQC].[QualityCheckId] = [QC].[AcceptanceQualityCheckId])
SELECT [QCV].[QualityCheckId],
       [QCV].[Guid],
       [QCV].[CreationDate],
       [QCV].[Description],       
       [QCV].[IsDeleted],
       [QCV].[Interval],
       [QCV].[Comment],
       [QCV].[AcceptanceQualityCheckGuid],
       [QCV].[IsAcceptance],
       [HS].[Guid] as [HardwareSetGuid],
       [HS].[Name] as [HardwareSetName],
       [DVC].[Guid] as [DeviceGuid],
       [HS].[HardwareSetType],
       [DVC].[Name] as [DeviceName],
       [DVC].[Location] as [DeviceLocation],
       [QCS].[Guid] as [StandardGuid],
       [QCS].[Name] as [StandardName]
FROM [QCV] left outer join [dbo].[OwsHardwareSet] [HS] 
  on [QCV].[HardwareSetId] = [HS].[HardwareSetId]
 left outer join [dbo].[OwsDevice] [DVC] on [HS].[DeviceId] = [DVC].[DeviceId] 
 left outer join [dbo].[OwsQualityCheckStandard] [QCS] on [QCV].[StandardId] = [QCS].[StandardId];

GO
PRINT N'Creating [dbo].[DF_Finding_IsDeleted]...';


GO
ALTER TABLE [dbo].[Finding]
    ADD CONSTRAINT [DF_Finding_IsDeleted] DEFAULT ((0)) FOR [IsDeleted];


GO
PRINT N'Creating [dbo].[DF_MediaBase_IsDeleted]...';


GO
ALTER TABLE [dbo].[MediaBase]
    ADD CONSTRAINT [DF_MediaBase_IsDeleted] DEFAULT ((0)) FOR [IsDeleted];
GO
ALTER TABLE [dbo].[MediaBase]
    ADD CONSTRAINT [DF_MediaBase_IsHidden] DEFAULT ((0)) FOR [IsHidden];

GO
PRINT N'Creating [dbo].[DF_MediaBase_Vendor]...';


GO
ALTER TABLE [dbo].[MediaBase]
    ADD CONSTRAINT [DF_MediaBase_Vendor] DEFAULT ('') FOR [Vendor];


GO
PRINT N'Creating [dbo].[DF_MediaBaseDescriptor_IsDeleted]...';


GO
ALTER TABLE [dbo].[MediaBaseDescriptor]
    ADD CONSTRAINT [DF_MediaBaseDescriptor_IsDeleted] DEFAULT ((0)) FOR [IsDeleted];


GO
PRINT N'Creating [dbo].[DF_MediaBaseDescriptorLocalization_IsDeleted]...';


GO
ALTER TABLE [dbo].[MediaBaseDescriptorLocalization]
    ADD CONSTRAINT [DF_MediaBaseDescriptorLocalization_IsDeleted] DEFAULT ((0)) FOR [IsDeleted];


GO
PRINT N'Creating [dbo].[DF_MediaFrame_IsDeleted]...';


GO
ALTER TABLE [dbo].[MediaFrame]
    ADD CONSTRAINT [DF_MediaFrame_IsDeleted] DEFAULT ((0)) FOR [IsDeleted];


GO
PRINT N'Creating [dbo].[DF_MediaSession_IsDeleted]...';


GO
ALTER TABLE [dbo].[MediaSession]
    ADD CONSTRAINT [DF_MediaSession_IsDeleted] DEFAULT ((0)) FOR [IsDeleted];


GO
PRINT N'Creating [dbo].[DF_MediaSession_CurrentMediaWorkspaceGuid]...';


GO
ALTER TABLE [dbo].[MediaSession]
    ADD CONSTRAINT [DF_MediaSession_CurrentMediaWorkspaceGuid] DEFAULT (NULL) FOR [CurrentMediaWorkspaceGuid];


GO
PRINT N'Creating [dbo].[DF_MediaWorkspace_IsDeleted]...';


GO
ALTER TABLE [dbo].[MediaWorkspace]
    ADD CONSTRAINT [DF_MediaWorkspace_IsDeleted] DEFAULT ((0)) FOR [IsDeleted];


GO
PRINT N'Creating [dbo].[DF_OwsUnit_IsActive]...';


GO
ALTER TABLE [dbo].[OwsDevice]
    ADD CONSTRAINT [DF_OwsUnit_IsActive] DEFAULT ((1)) FOR [IsActive];


GO
PRINT N'Creating [dbo].[DF_OwsUnit_IsDeleted]...';


GO
ALTER TABLE [dbo].[OwsDevice]
    ADD CONSTRAINT [DF_OwsUnit_IsDeleted] DEFAULT ((0)) FOR [IsDeleted];


GO
PRINT N'Creating [dbo].[DF_OwsHardwareComponent_IsActive]...';


GO
ALTER TABLE [dbo].[OwsHardwareComponent]
    ADD CONSTRAINT [DF_OwsHardwareComponent_IsActive] DEFAULT 1 FOR [IsActive];


GO
PRINT N'Creating [dbo].[DF_OwsHardwareComponent_IsDeleted]...';


GO
ALTER TABLE [dbo].[OwsHardwareComponent]
    ADD CONSTRAINT [DF_OwsHardwareComponent_IsDeleted] DEFAULT 0 FOR [IsDeleted];


GO
PRINT N'Creating [dbo].[DF_OwsHardwareSet_IsActive]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
ALTER TABLE [dbo].[OwsHardwareSet]
    ADD CONSTRAINT [DF_OwsHardwareSet_IsActive] DEFAULT ((1)) FOR [IsActive];


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[DF_OwsHardwareSet_IsDeleted]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
ALTER TABLE [dbo].[OwsHardwareSet]
    ADD CONSTRAINT [DF_OwsHardwareSet_IsDeleted] DEFAULT ((0)) FOR [IsDeleted];


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;

GO
PRINT N'Creating [dbo].[DF_OwsQualityCheckStandard_IsActive]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
ALTER TABLE [dbo].[OwsQualityCheckStandard]
    ADD CONSTRAINT [DF_OwsQualityCheckStandard_IsActive] DEFAULT ((1)) FOR [IsActive];


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[DF_OwsQualityCheckStandard_IsDeleted]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
ALTER TABLE [dbo].[OwsQualityCheckStandard]
    ADD CONSTRAINT [DF_OwsQualityCheckStandard_IsDeleted] DEFAULT ((0)) FOR [IsDeleted];


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[DF_OwsOrder_IsDeleted]...';


GO
ALTER TABLE [dbo].[OwsOrder]
    ADD CONSTRAINT [DF_OwsOrder_IsDeleted] DEFAULT ((0)) FOR [IsDeleted];


GO
PRINT N'Creating [dbo].[DF_OwsOrder_Parent]...';


GO
ALTER TABLE [dbo].[OwsOrder]
    ADD CONSTRAINT [DF_OwsOrder_Parent] DEFAULT NULL FOR [Parent];


GO
PRINT N'Creating [dbo].[DF_OwsUser_IsDeleted]...';


GO
ALTER TABLE [dbo].[OwsUser]
    ADD CONSTRAINT [DF_OwsUser_IsDeleted] DEFAULT ((0)) FOR [IsDeleted];


GO
PRINT N'Creating [dbo].[DF_OwsUserRole_IsDeleted]...';


GO
ALTER TABLE [dbo].[OwsUserRole]
    ADD CONSTRAINT [DF_OwsUserRole_IsDeleted] DEFAULT ((0)) FOR [IsDeleted];


GO
PRINT N'Creating [dbo].[DF_Patient_IsDeleted]...';


GO
ALTER TABLE [dbo].[Patient]
    ADD CONSTRAINT [DF_Patient_IsDeleted] DEFAULT ((0)) FOR [IsDeleted];


GO
PRINT N'Creating [dbo].[DF_Role_IsDeleted]...';


GO
ALTER TABLE [dbo].[Role]
    ADD CONSTRAINT [DF_Role_IsDeleted] DEFAULT ((0)) FOR [IsDeleted];


GO
PRINT N'Creating [dbo].[FK_Finding_Patient_Id]...';


GO
ALTER TABLE [dbo].[Finding] WITH NOCHECK
    ADD CONSTRAINT [FK_Finding_Patient_Id] FOREIGN KEY ([PatientId]) REFERENCES [dbo].[Patient] ([PatientId]);


GO
PRINT N'Creating [dbo].[FK_Finding_OwsUser_Id]...';


GO
ALTER TABLE [dbo].[Finding] WITH NOCHECK
    ADD CONSTRAINT [FK_Finding_OwsUser_Id] FOREIGN KEY ([ResponsibleDoctorId]) REFERENCES [dbo].[OwsUser] ([UserId]);


GO
PRINT N'Creating [dbo].[FK_HardwareSetHardwareComponent_OwsHardwareComponent]...';


GO
ALTER TABLE [dbo].[HardwareSetHardwareComponent] WITH NOCHECK
    ADD CONSTRAINT [FK_HardwareSetHardwareComponent_OwsHardwareComponent] FOREIGN KEY ([HardwareComponentId]) REFERENCES [dbo].[OwsHardwareComponent] ([HardwareComponentId]);


GO
PRINT N'Creating [dbo].[FK_HardwareSet-HardwareComponent_OwsHardwareSet]...';


GO
ALTER TABLE [dbo].[HardwareSetHardwareComponent] WITH NOCHECK
    ADD CONSTRAINT [FK_HardwareSet-HardwareComponent_OwsHardwareSet] FOREIGN KEY ([HardwareSetId]) REFERENCES [dbo].[OwsHardwareSet] ([HardwareSetId]);


GO
PRINT N'Creating [dbo].[FK_MediaBase_MediaDescriptor_Id]...';


GO
ALTER TABLE [dbo].[MediaBase] WITH NOCHECK
    ADD CONSTRAINT [FK_MediaBase_MediaDescriptor_Id] FOREIGN KEY ([MediaBaseDescriptorId]) REFERENCES [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId]);


GO
PRINT N'Creating [dbo].[FK_MediaBaseDescriptorLocalization_MediaBaseDescriptor_Id]...';


GO
ALTER TABLE [dbo].[MediaBaseDescriptorLocalization] WITH NOCHECK
    ADD CONSTRAINT [FK_MediaBaseDescriptorLocalization_MediaBaseDescriptor_Id] FOREIGN KEY ([MediaDescriptorId]) REFERENCES [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId]);


GO
PRINT N'Creating [dbo].[FK_MediaBaseUnitHardwareSet_MediaBase]...';


GO
ALTER TABLE [dbo].[MediaBaseQualityCheck] WITH NOCHECK
    ADD CONSTRAINT [FK_MediaBaseUnitHardwareSet_MediaBase] FOREIGN KEY ([MediaBaseId]) REFERENCES [dbo].[MediaBase] ([MediaBaseId]);


GO
PRINT N'Creating [dbo].[FK_MediaBaseUnitHardwareSet_UnitHardwareSet]...';


GO
ALTER TABLE [dbo].[MediaBaseQualityCheck] WITH NOCHECK
    ADD CONSTRAINT [FK_MediaBaseUnitHardwareSet_UnitHardwareSet] FOREIGN KEY ([QualityCheckId]) REFERENCES [dbo].[OwsQualityCheck] ([QualityCheckId]);


GO
PRINT N'Creating [dbo].[FK_MediaFrame_MediaWorkspace_Id]...';


GO
ALTER TABLE [dbo].[MediaFrame] WITH NOCHECK
    ADD CONSTRAINT [FK_MediaFrame_MediaWorkspace_Id] FOREIGN KEY ([MediaWorkspaceId]) REFERENCES [dbo].[MediaWorkspace] ([MediaWorkspaceId]);



GO
PRINT N'Creating [dbo].[FK_MediaWorkspace_MediaSession_Id]...';


GO
ALTER TABLE [dbo].[MediaWorkspace] WITH NOCHECK
    ADD CONSTRAINT [FK_MediaWorkspace_MediaSession_Id] FOREIGN KEY ([MediaSessionId]) REFERENCES [dbo].[MediaSession] ([MediaSessionId]);


GO
PRINT N'Creating [dbo].[FK_OwsHardwareSet_OwsDevice]...';


GO
ALTER TABLE [dbo].[OwsHardwareSet] WITH NOCHECK
    ADD CONSTRAINT [FK_OwsHardwareSet_OwsDevice] FOREIGN KEY ([DeviceId]) REFERENCES [dbo].[OwsDevice] ([DeviceId]);


GO
PRINT N'Creating [dbo].[FK_OwsOrder_OwsUser_IndicatingDoctor]...';


GO
ALTER TABLE [dbo].[OwsOrder] WITH NOCHECK
    ADD CONSTRAINT [FK_OwsOrder_OwsUser_IndicatingDoctor] FOREIGN KEY ([IndicatingDoctor]) REFERENCES [dbo].[OwsUser] ([UserId]);


GO
PRINT N'Creating [dbo].[FK_OwsOrder_MediaBaseDescriptor]...';


GO
ALTER TABLE [dbo].[OwsOrder] WITH NOCHECK
    ADD CONSTRAINT [FK_OwsOrder_MediaBaseDescriptor] FOREIGN KEY ([MediaBaseDescriptorId]) REFERENCES [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId]);


GO
PRINT N'Creating [dbo].[FK_OwsQualityCheck_OwsHardwareSet]...';


GO
ALTER TABLE [dbo].[OwsQualityCheck] WITH NOCHECK
    ADD CONSTRAINT [FK_OwsQualityCheck_OwsHardwareSet] FOREIGN KEY ([HardwareSetId]) REFERENCES [dbo].[OwsHardwareSet] ([HardwareSetId]);


GO
PRINT N'Creating [dbo].[FK_OwsQualityCheck_OwsQualityCheck]...';


GO
ALTER TABLE [dbo].[OwsQualityCheck] WITH NOCHECK
    ADD CONSTRAINT [FK_OwsQualityCheck_OwsQualityCheck] FOREIGN KEY ([AcceptanceQualityCheckId]) REFERENCES [dbo].[OwsQualityCheck] ([QualityCheckId]);

	
GO
PRINT N'Creating [dbo].[FK_OwsQualityCheck_OwsQualityCheckStandard]...';


GO
ALTER TABLE [dbo].[OwsQualityCheck] WITH NOCHECK
    ADD CONSTRAINT [FK_OwsQualityCheck_OwsQualityCheckStandard] FOREIGN KEY ([StandardId]) REFERENCES [dbo].[OwsQualityCheckStandard] ([StandardId]);


GO
PRINT N'Creating [dbo].[FK_OwsUserRole_OwsUser]...';


GO
ALTER TABLE [dbo].[OwsUserRole] WITH NOCHECK
    ADD CONSTRAINT [FK_OwsUserRole_OwsUser] FOREIGN KEY ([UserId]) REFERENCES [dbo].[OwsUser] ([UserId]);


GO
PRINT N'Creating [dbo].[FK_OwsUserRole_Role]...';


GO
ALTER TABLE [dbo].[OwsUserRole] WITH NOCHECK
    ADD CONSTRAINT [FK_OwsUserRole_Role] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Role] ([RoleId]);
GO

PRINT N'Creating [dbo].[FK_MediaFrame_MediaBase_Guid]...';
GO

ALTER TABLE [dbo].[MediaFrame] WITH NOCHECK
    ADD CONSTRAINT [FK_MediaFrame_MediaBase_Guid] FOREIGN KEY ([MediaBaseGuid]) REFERENCES [dbo].[MediaBase] ([Guid]);
GO

PRINT N'Creating [dbo].[FK_Finding_MediaBase_Id]...';
GO

ALTER TABLE [dbo].[Finding] WITH NOCHECK
    ADD CONSTRAINT [FK_Finding_MediaBase_Id] FOREIGN KEY ([AssociatedMediaId]) REFERENCES [dbo].[MediaBase] ([MediaBaseId]);
GO

PRINT N'Creating [dbo].[FK_MediaBase_Patient_Id]...';
GO

ALTER TABLE [dbo].[MediaBase] WITH NOCHECK
    ADD CONSTRAINT [FK_MediaBase_Patient_Id] FOREIGN KEY ([PatientId]) REFERENCES [dbo].[Patient] ([PatientId]);
GO

PRINT N'Creating [dbo].[FK_MediaBase_Order_Id]...';
GO

ALTER TABLE [dbo].[MediaBase] WITH NOCHECK
    ADD CONSTRAINT [FK_MediaBase_Order_Id] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[OwsOrder] ([OrderId]);
GO

PRINT N'Creating [dbo].[FK_OwsOrder_Patient_Id]...';
GO

ALTER TABLE [dbo].[OwsOrder] WITH NOCHECK
    ADD CONSTRAINT [FK_OwsOrder_Patient_Id] FOREIGN KEY ([PatientId]) REFERENCES [dbo].[Patient] ([PatientId]);
GO

-- Configuration
IF EXISTS (SELECT * FROM dbo.Configuration WHERE ConfigGroupKey=0 AND ConfigKey='CurrentVersion')
UPDATE dbo.Configuration
SET ConfigValue='5.7'
WHERE ConfigGroupKey=0 AND ConfigKey='CurrentVersion'

IF NOT EXISTS (SELECT * FROM dbo.Configuration WHERE ConfigGroupKey=0 AND ConfigKey='CurrentVersion')
INSERT INTO dbo.Configuration
(ConfigGroupKey, ConfigKey, ConfigValue)
VALUES
(0, 'CurrentVersion', '5.7');

IF NOT EXISTS (SELECT * FROM dbo.Configuration WHERE ConfigGroupKey=0 AND ConfigKey='ProvisioningStatus')
INSERT INTO dbo.Configuration
(ConfigGroupKey, ConfigKey, ConfigValue)
VALUES
(0, 'ProvisioningStatus', '0');

IF NOT EXISTS (SELECT * FROM dbo.Configuration WHERE ConfigGroupKey=0 AND ConfigKey='MigrationStatus')
INSERT INTO dbo.Configuration
(ConfigGroupKey, ConfigKey, ConfigValue)
VALUES
(0, 'MigrationStatus', '0');

-- OwsUser
SET IDENTITY_INSERT dbo.OwsUser ON

INSERT INTO dbo.OwsUser
(UserId, [Guid], Degree, FirstName, LastName, IsActive, IsDeleted, [Password], IsVisible)
VALUES
(1, '9F50B5CC-F3C4-4F3D-8039-CCD18EB500F9', 'Dr.', 'Hans', 'Demo', 1, 0, NULL, 1),
(2, '970CCDDE-2752-4FA8-B5A1-0240D98CCF8D', NULL, 'Administrator', 'Administrator', 1, 0, NULL, 0);

SET IDENTITY_INSERT dbo.OwsUser OFF

-- Role
SET IDENTITY_INSERT dbo.[Role] ON

INSERT INTO dbo.[Role]
(RoleId, [Guid], RoleName, IsDeleted, IsVisible)
VALUES
(1, '55A0A1E6-ED6A-4B6D-A4A8-B584AEDDD967', 'Doctor', 0, 1),
(2, 'AC9E478C-4830-4C8E-962E-01276A596ABB', 'DentalAssistant', 0, 1),
(3, 'D2928C65-6CB2-43DF-AA85-A08C25706872', 'RadiologyTech', 0, 1),
(4, '663335F5-CD3D-4AB0-845D-65CED54F78E7', 'Administrator', 0, 0);


SET IDENTITY_INSERT dbo.[Role] OFF

-- OwsUserRole
INSERT INTO dbo.OwsUserRole
(UserId, RoleId, IsDeleted)
VALUES
(1, 1, 0),
(2, 4, 0);

-- MediaBaseDescriptor
SET IDENTITY_INSERT [dbo].[MediaBaseDescriptor] ON

INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (1, N'Scan', N'XV', N'Void', 0, 1, N'XRay3D.Scan', N'MediaDescriptors\3D.png', N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (3, N'Volume', N'XV', N'ExtraoralXRayVolume', 1, 1, N'XRay3D.Volume', N'MediaDescriptors\3D.png', N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (4, N'RasterImage', N'XV', N'ExtraoralXRay', 1, 1, N'XRay3D.Projection', N'MediaDescriptors\3DProjection.png', N'Mandible,Maxilla', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (5, N'RasterImage', N'XP', N'ExtraoralXRayOPG', 1, 1, N'XRay3D.Projection.Panorama', N'MediaDescriptors\3DPAN.png', N'Mandible,Maxilla', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (6, N'RasterImage', N'XP', N'ExtraoralXRayOPG', 1, 1, N'XRay3D.Projection.Panorama.TDI', N'MediaDescriptors\3DPAN.png', N'Mandible,Maxilla', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (7, N'RasterImage', N'XS', N'ExtraoralXRayTransversal', 1, 1, N'XRay3D.Projection.Transversal', N'MediaDescriptors\TSA.png', N'Mandible,Maxilla', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (8, N'RasterImage', N'XS', N'ExtraoralXRayLongitudinal', 1, 1, N'XRay3D.Projection.Longitudinal', N'MediaDescriptors\LSA.png', N'Mandible,Maxilla', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (9, N'RasterImage', N'XS', N'ExtraoralXRayAxial', 1, 1, N'XRay3D.Projection.Axial', N'MediaDescriptors\Axial.png', N'Mandible,Maxilla', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (10, N'RasterImage', N'XS', N'ExtraoralXRayCoronal', 1, 1, N'XRay3D.Projection.Coronal', N'MediaDescriptors\Coronal.png', N'Mandible,Maxilla', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (11, N'RasterImage', N'XS', N'ExtraoralXRaySagittal', 1, 1, N'XRay3D.Projection.Sagittal', N'MediaDescriptors\Sagittal.png', N'Mandible,Maxilla', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (12, N'RasterImage', N'XS', N'ExtraoralXRayCephLateral', 1, 1, N'XRay3D.Projection.Lateral', N'MediaDescriptors\CephLateral.png', N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (13, N'RasterImage', N'XC', N'ExtraoralXRayCephAP', 1, 1, N'XRay3D.Projection.AP', N'MediaDescriptors\CephAP.png', N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (14, N'RasterImage', N'XC', N'ExtraoralXRayCephPA', 1, 1, N'XRay3D.Projection.PA', N'MediaDescriptors\CephPA.png', N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (15, N'RasterImage', N'XI', N'IntraoralXRay', 1, 1, N'XRay2D.Intraoral', N'MediaDescriptors\Intraoral.png', N'', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (16, N'RasterImage', N'XI', N'IntraoralXRayEndoSequence', 1, 1, N'XRay2D.Intraoral.Endo', N'MediaDescriptors\Intraoral.png', N'', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (17, N'RasterImage', N'XI', N'IntraoralXRayBitewing', 1, 1, N'XRay2D.Intraoral.Bitewing', N'MediaDescriptors\Intraoral.png', N'', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (18, N'RasterImage', N'XI', N'IntraoralXRayStatus', 1, 1, N'XRay2D.Intraoral.PhotoStatus', N'MediaDescriptors\Intraoral.png', N'', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (19, N'RasterImage', N'XP', N'ExtraoralXRayOPG', 1, 1, N'XRay2D.Extraoral.Panorama', N'MediaDescriptors\Panorama.png', N'Mandible,Maxilla', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (20, N'RasterImage', N'XC', N'ExtraoralXRayCeph', 1, 1, N'XRay2D.Extraoral.Ceph', N'MediaDescriptors\CephAP.png', N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (21, N'RasterImage', N'XS', N'ExtraoralXRayTransversal', 1, 1, N'XRay2D.Extraoral.Transversal', N'MediaDescriptors\2DTSA.png', N'Mandible,Maxilla', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (22, N'RasterImage', N'X?', N'ExtraoralXRay', 1, 1, N'XRay2D', N'MediaDescriptors\Image2D.png', N'Mandible,Maxilla', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (23, N'RasterImage', N'VI', N'IntraoralPhoto', 1, 0, N'Image2D.Intraoral', N'MediaDescriptors\Image2D.png',  N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (24, N'RasterImage', N'VI', N'IntraoralPhotoStatus', 1, 0, N'Image2D.Intraoral.PhotoStatus', N'MediaDescriptors\Image2D.png',  N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (25, N'RasterImage', N'V?', N'ExtraoralPhoto', 1, 0, N'Image2D.Extraoral', N'MediaDescriptors\Image2D.png',  N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (26, N'RasterImage', N'V?', N'ExtraoralPhotoStatus', 1, 0, N'Image2D.Extraoral.PhotoStatus', N'MediaDescriptors\Image2D.png',  N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (27, N'RasterImage', N'??', N'Photo', 1, 0, N'Image2D', N'MediaDescriptors\Image2D.png',  N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (28, N'Scan', NULL, N'Void', 0, 0, N'FS.Scan', N'MediaDescriptors\FSProjection.png', N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (29, N'RasterImage', N'VF', N'ExtraoralPhoto', 1, 0, N'FS.Projection', N'MediaDescriptors\FacescanProjection.png', N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (30, N'Surface', N'VF', N'Void', 0, 0, N'FS.Surface', N'MediaDescriptors\FSProjection.png', N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (31, N'TextureSequence', NULL, N'ExtraoralPhoto', 0, 0, N'FS.TextureSequence', N'MediaDescriptors\FSProjection.png', N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (32, N'Mesh', NULL, N'ExtraoralPhoto', 0, 0, N'FS.Mesh', N'MediaDescriptors\FSProjection.png', N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (33, N'Mesh', NULL, N'IntraoralPhoto', 1, 0, N'Mesh.Implant', N'MediaDescriptors\Image2D.png', N'Mandible,Maxilla', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (34, N'Mesh', NULL, N'IntraoralPhoto', 1, 0, N'Mesh.Intraoral', N'MediaDescriptors\Image2D.png', N'Mandible,Maxilla', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (35, N'Scan', NULL, N'Void', 0, 1, N'XRay2D.Scan', N'MediaDescriptors\Image2D.png', N'Mandible,Maxilla', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (36, N'RasterImage', N'XP', N'ExtraoralXRayOPG', 1, 1, N'XRay2D.Extraoral.Projection', N'MediaDescriptors\Panorama.png', N'Mandible,Maxilla', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (37, N'Scan', N'XP', N'Void', 0, 1, N'FF.Scan', N'MediaDescriptors\Panorama.png', N'Mandible,Maxilla', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (38, N'Scan', NULL, N'Void', 0, 1, N'Scan', N'MediaDescriptors\Scan.png', N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (39, N'Volume', N'4XV', N'ExtraoralXRayVolume', 1, 1, N'XRay3D.MainVolume.VO4', N'MediaDescriptors\XRay3D.MainVolume.VO4.png', N'Head,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (40, N'Scan', N'VF', N'ExtraoralVideo', 0, 0, N'FS.Scan.FS1', N'MediaDescriptors\FS.Scan.FS1.png', N'Head,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (41, N'Volume', N'1XV', N'ExtraoralXRayVolume', 1, 1, N'XRay3D.MainVolume.VO1', N'MediaDescriptors\XRay3D.MainVolume.VO1.png', N'Head,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (42, N'Volume', N'2XV', N'ExtraoralXRayVolume', 1, 1, N'XRay3D.MainVolume.VO2', N'MediaDescriptors\XRay3D.MainVolume.VO2.png', N'Head,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (43, N'Volume', N'5XV', N'ExtraoralXRayVolume', 1, 1, N'XRay3D.MainVolume.VO5', N'MediaDescriptors\XRay3D.MainVolume.VO5.png', N'Head,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (44, N'Volume', N'G2XV', N'ExtraoralXRayVolume', 1, 0, N'XRay3D.MainVolume.VOG', N'MediaDescriptors\XRay3D.MainVolume.VOG.png', N'Head,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (45, N'RasterImage', N'01XP', N'ExtraoralXRayOPG', 1, 1, N'XRay2D.Extraoral.Panorama.P1', N'MediaDescriptors\XRay2D.Extraoral.Panorama.P1.png', N'Maxilla,Mandible,MandibularJoints,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (46, N'RasterImage', N'01XP', N'ExtraoralXRayOPG', 1, 1, N'XRay2D.Extraoral.Panorama.P1_A', N'MediaDescriptors\XRay2D.Extraoral.Panorama.P1_A.png', N'Maxilla,Mandible,MandibularJoints,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (47, N'RasterImage', N'11XP', N'ExtraoralXRayOPG', 1, 1, N'XRay2D.Extraoral.Panorama.P1_C', N'MediaDescriptors\XRay2D.Extraoral.Panorama.P1_C.png', N'Maxilla,Mandible,MandibularJoints,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (48, N'RasterImage', N'02XP', N'ExtraoralXRayOPG', 1, 1, N'XRay2D.Extraoral.Panorama.P2', N'MediaDescriptors\XRay2D.Extraoral.Panorama.P2.png', N'Maxilla,Mandible,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (49, N'RasterImage', N'02XP', N'ExtraoralXRayOPG', 1, 1, N'XRay2D.Extraoral.Panorama.P2_A', N'MediaDescriptors\XRay2D.Extraoral.Panorama.P2_A.png', N'Maxilla,Mandible,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (50, N'RasterImage', N'02XP', N'ExtraoralXRayOPG', 1, 1, N'XRay2D.Extraoral.Panorama.P2_C', N'MediaDescriptors\XRay2D.Extraoral.Panorama.P2_C.png', N'Maxilla,Mandible,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (51, N'RasterImage', N'10XP', N'ExtraoralXRayOPG', 1, 1, N'XRay2D.Extraoral.Panorama.P10', N'MediaDescriptors\XRay2D.Extraoral.Panorama.P10.png', N'Deciduous,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (52, N'RasterImage', N'10XP', N'ExtraoralXRayOPG', 1, 1, N'XRay2D.Extraoral.Panorama.P10_A', N'MediaDescriptors\XRay2D.Extraoral.Panorama.P10_A.png', N'Deciduous,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (53, N'RasterImage', N'10XP', N'ExtraoralXRayOPG', 1, 1, N'XRay2D.Extraoral.Panorama.P10_C', N'MediaDescriptors\XRay2D.Extraoral.Panorama.P10_C.png', N'Deciduous,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (54, N'RasterImage', N'12XP', N'ExtraoralXRayOPG', 1, 1, N'XRay2D.Extraoral.Panorama.P12', N'MediaDescriptors\XRay2D.Extraoral.Panorama.P12.png', N'Incisor,Canine,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (55, N'RasterImage', N'01XP', N'ExtraoralXRayBitewing', 1, 1, N'XRay2D.Extraoral.Panorama.BW1', N'MediaDescriptors\XRay2D.Extraoral.Panorama.BW1.png', N'Molar,Premolar,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (56, N'RasterImage', N'01XP', N'ExtraoralXRayBitewing', 1, 1, N'XRay2D.Extraoral.Panorama.BW2', N'MediaDescriptors\XRay2D.Extraoral.Panorama.BW2.png', N'Incisor,Canine,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (57, N'RasterImage', N'06XP', N'ExtraoralXRayTMJ', 1, 1, N'XRay2D.Extraoral.Panorama.TMJ11', N'MediaDescriptors\XRay2D.Extraoral.Panorama.TMJ11.png', N'MandibularJoints,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (58, N'RasterImage', N'06XP', N'ExtraoralXRayTMJ', 1, 1, N'XRay2D.Extraoral.Panorama.TMJ1A1', N'MediaDescriptors\XRay2D.Extraoral.Panorama.TMJ1A1.png', N'MandibularJoints,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (59, N'RasterImage', N'07XP', N'ExtraoralXRayTMJ', 1, 1, N'XRay2D.Extraoral.Panorama.TMJ21', N'MediaDescriptors\XRay2D.Extraoral.Panorama.TMJ21.png', N'MandibularJoints,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (60, N'RasterImage', N'07XP', N'ExtraoralXRayTMJ', 1, 1, N'XRay2D.Extraoral.Panorama.TMJ2A1', N'MediaDescriptors\XRay2D.Extraoral.Panorama.TMJ2A1.png', N'MandibularJoints,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (61, N'RasterImage', N'04XP', N'ExtraoralXRayTMJ', 1, 1, N'XRay2D.Extraoral.Panorama.TMJ3', N'MediaDescriptors\XRay2D.Extraoral.Panorama.TMJ3.png', N'MandibularJoints,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (62, N'RasterImage', N'05XP', N'ExtraoralXRayTMJ', 1, 1, N'XRay2D.Extraoral.Panorama.TMJ4', N'MediaDescriptors\XRay2D.Extraoral.Panorama.TMJ4.png', N'MandibularJoints,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (63, N'RasterImage', N'08XP', N'ExtraoralXRayTMJ', 1, 1, N'XRay2D.Extraoral.Panorama.TMJ5', N'MediaDescriptors\XRay2D.Extraoral.Panorama.TMJ5.png', N'MandibularJoints,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (64, N'RasterImage', N'09XP', N'ExtraoralXRayTMJ', 1, 1, N'XRay2D.Extraoral.Panorama.TMJ6', N'MediaDescriptors\XRay2D.Extraoral.Panorama.TMJ6.png', N'MandibularJoints,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (65, N'RasterImage', N'13XP', N'ExtraoralXRaySinus', 1, 1, N'XRay2D.Extraoral.Panorama.S1', N'MediaDescriptors\XRay2D.Extraoral.Panorama.S1.png', N'ParanasalSinuses,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (66, N'RasterImage', N'03XP', N'ExtraoralXRaySinus', 1, 1, N'XRay2D.Extraoral.Panorama.S2', N'MediaDescriptors\XRay2D.Extraoral.Panorama.S2.png', N'ParanasalSinuses,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (67, N'RasterImage', N'13XP', N'ExtraoralXRaySinus', 1, 1, N'XRay2D.Extraoral.Panorama.S3', N'MediaDescriptors\XRay2D.Extraoral.Panorama.S3.png', N'ParanasalSinuses,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (68, N'RasterImage', N'03XP', N'ExtraoralXRaySinus', 1, 1, N'XRay2D.Extraoral.Panorama.S4', N'MediaDescriptors\XRay2D.Extraoral.Panorama.S4.png', N'ParanasalSinuses,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (69, N'RasterImage', N'16XP', N'ExtraoralXRay', 1, 1, N'XRay2D.Extraoral.Panorama.MS1', N'MediaDescriptors\XRay2D.Extraoral.Panorama.MS1.png', N'Molar,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (70, N'RasterImage', N'01XC', N'ExtraoralXRayCephPA', 1, 1, N'XRay2D.Extraoral.Ceph.C1', N'MediaDescriptors\XRay2D.Extraoral.Ceph.C1.png', N'Head,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (71, N'RasterImage', N'02XC', N'ExtraoralXRayCephAP', 1, 1, N'XRay2D.Extraoral.Ceph.C2', N'MediaDescriptors\XRay2D.Extraoral.Ceph.C2.png', N'Head,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (72, N'RasterImage', N'03XC', N'ExtraoralXRayCephLateral', 1, 1, N'XRay2D.Extraoral.Ceph.C3', N'MediaDescriptors\XRay2D.Extraoral.Ceph.C3.png', N'Head,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (73, N'RasterImage', N'03XC', N'ExtraoralXRayCephLateral', 1, 1, N'XRay2D.Extraoral.Ceph.C3_F', N'MediaDescriptors\XRay2D.Extraoral.Ceph.C3_F.png', N'Head,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (74, N'RasterImage', N'04XC', N'ExtraoralXRayCeph', 1, 1, N'XRay2D.Extraoral.Ceph.C4', N'MediaDescriptors\XRay2D.Extraoral.Ceph.C4.png', N'Hand,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (75, N'Volume', N'1NXV', N'ExtraoralXRayVolume', 1, 1, N'XRay3D.MainVolume.VO11', N'MediaDescriptors\XRay3D.MainVolume.VO11.png', N'RightMolar,RightMandibularJoint,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (76, N'Volume', N'2NXV', N'ExtraoralXRayVolume', 1, 1, N'XRay3D.MainVolume.VO12', N'MediaDescriptors\XRay3D.MainVolume.VO12.png', N'RightMolar,RightPremolar,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (77, N'Volume', N'3NXV', N'ExtraoralXRayVolume', 1, 1, N'XRay3D.MainVolume.VO13', N'MediaDescriptors\XRay3D.MainVolume.VO13.png', N'Canine,Incisor,Premolar,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (78, N'Volume', N'4NXV', N'ExtraoralXRayVolume', 1, 1, N'XRay3D.MainVolume.VO14', N'MediaDescriptors\XRay3D.MainVolume.VO14.png', N'LeftMolar,LeftPremolar,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (79, N'Volume', N'5NXV', N'ExtraoralXRayVolume', 1, 1, N'XRay3D.MainVolume.VO15', N'MediaDescriptors\XRay3D.MainVolume.VO15.png', N'LeftMandibularJoint,LeftMolar,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (80, N'Volume', N'1FXV', N'ExtraoralXRayVolume', 1, 1, N'XRay3D.MainVolume.VO21', N'MediaDescriptors\XRay3D.MainVolume.VO21.png', N'RightMolar,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (81, N'Volume', N'2FXV', N'ExtraoralXRayVolume', 1, 1, N'XRay3D.MainVolume.VO22', N'MediaDescriptors\XRay3D.MainVolume.VO22.png', N'RightPremolar,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (82, N'Volume', N'3FXV', N'ExtraoralXRayVolume', 1, 1, N'XRay3D.MainVolume.VO23', N'MediaDescriptors\XRay3D.MainVolume.VO23.png', N'Canine,Incisor,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (83, N'Volume', N'4FXV', N'ExtraoralXRayVolume', 1, 1, N'XRay3D.MainVolume.VO24', N'MediaDescriptors\XRay3D.MainVolume.VO24.png', N'LeftPremolar,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (84, N'Volume', N'5FXV', N'ExtraoralXRayVolume', 1, 1, N'XRay3D.MainVolume.VO25', N'MediaDescriptors\XRay3D.MainVolume.VO25.png', N'LeftMolar,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (85, N'RasterImage', N'XS', N'ExtraoralXRayTransversal', 1, 1, N'XRay2D.Extraoral.Transversal.TSA_S', N'MediaDescriptors\XRay2D.Extraoral.Transversal.TSA_S.png', N'Maxilla,Mandible,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (86, N'RasterImage', N'10XP', N'ExtraoralXRayOPG', 1, 1, N'XRay2D.Extraoral.Panorama.P20', N'MediaDescriptors\XRay2D.Extraoral.Panorama.P20.png', N'Deciduous,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (87, N'RasterImage', N'01XP', N'ExtraoralXRayBitewing', 1, 1, N'XRay2D.Extraoral.Panorama.BW10', N'MediaDescriptors\XRay2D.Extraoral.Panorama.BW10.png', N'Molar,Premolar,', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (88, N'RasterImage', N'V?', N'Photo', 1, 0, N'Image2D.ColorPhoto', N'MediaDescriptors\Image2D.png',  N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (89, N'RasterImage', N'VC', N'Photo', 1, 0, N'Image2D.Intraoral.CADCAM', N'MediaDescriptors\Image2D.png',  N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (90, N'Scan', NULL, N'IntraoralXRayStatus', 1, 0, N'Viewset.XRay2D.Intraoral.BITEWINGS', N'MediaDescriptors\Viewset.XRay2D.Intraoral.BITEWINGS.png', N'', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (91, N'Scan', NULL, N'IntraoralXRayStatus', 1, 0, N'Viewset.XRay2D.Intraoral.CHECKUP', N'MediaDescriptors\Viewset.XRay2D.Intraoral.CHECKUP.png', N'', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (92, N'Scan', NULL, N'IntraoralXRayStatus', 1, 0, N'Viewset.XRay2D.Intraoral.ENDO_HORIZONTAL_(15)', N'MediaDescriptors\Viewset.XRay2D.Intraoral.ENDO_HORIZONTAL_(15).png', N'', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (93, N'Scan', NULL, N'IntraoralXRayStatus', 1, 0, N'Viewset.XRay2D.Intraoral.FULL_MOUTH_SERIES_(18)', N'MediaDescriptors\Viewset.XRay2D.Intraoral.FULL_MOUTH_SERIES_(18).png', N'', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (94, N'Scan', NULL, N'IntraoralXRayStatus', 1, 0, N'Viewset.XRay2D.Intraoral.FULL_MOUTH_SERIES_(21)', N'MediaDescriptors\Viewset.XRay2D.Intraoral.FULL_MOUTH_SERIES_(21).png', N'', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (95, N'Scan', NULL, N'IntraoralXRayStatus', 1, 0, N'Viewset.XRay2D.Intraoral.PANO_WITH_4_BITEWINGS', N'MediaDescriptors\Viewset.XRay2D.Intraoral.PANO_WITH_4_BITEWINGS.png', N'', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (96, N'Scan', NULL, N'IntraoralXRayStatus', 1, 0, N'Viewset.XRay2D.Intraoral.VERTICAL_ENDO', N'MediaDescriptors\Viewset.XRay2D.Intraoral.VERTICAL_ENDO.png', N'', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (97, N'Order', N'??', N'Void', 0, 0, N'Image', N'UnknownImage.png', N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (98, N'Order', N'V?', N'Photo', 0, 0, N'Photo', N'MediaDescriptors\Image2D.png', N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (99, N'Order', N'X?', N'XRay', 0, 1, N'XRay', N'MediaDescriptors\Xray.png', N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (100, N'Order', N'XV', N'ExtraoralXRayVolume', 0, 1, N'XRay3D', N'MediaDescriptors\3D.png', N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (101, N'Volume', N'XV', N'ExtraoralXRayVolume', 1, 1, N'XRay3D.Volume.3rdParty', N'MediaDescriptors\3D_3rd.png', N'Head', 0, NULL)

INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (102, N'Surface', NULL, N'Void', 0, 0, N'CADCAM.Surface', N'MediaDescriptors\Image2D.png', N'Maxilla', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (103, N'TextureSequence', N'NULL', N'IntraoralPhoto', 0, 0, N'CADCAM.TextureSequence', N'MediaDescriptors\Image2D.png', N'Mandible', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (104, N'CADCAM', NULL, N'CADCAM', 1, 0, N'CADCAM.CadCamCase', N'MediaDescriptors\CadCamCase.png', N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (105, N'CADCAM', NULL, N'CADCAM', 1, 0, N'CADCAM.CadCamCase.Cerec', N'MediaDescriptors\CadCamCaseCerec.png', N'Head', 0, NULL)
INSERT [dbo].[MediaBaseDescriptor] ([MediaBaseDescriptorId], [MediaCategory], [ClassicTakeType], [Classification], [IsDisplayable], [IsXRay], [LogicalName], [IconUri], [DefaultAnatomicRegions], [IsDeleted], [DeletionDate]) VALUES (106, N'Scan', NULL, N'IntraoralXRayStatus', 1, 0, N'Viewset', N'MediaDescriptors\Viewset.png', N'Head', 0, NULL)
SET IDENTITY_INSERT [dbo].[MediaBaseDescriptor] OFF

-- MediaBaseDescriptorLocalization
SET IDENTITY_INSERT [dbo].[MediaBaseDescriptorLocalization] ON

INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Scan', N'3D scan', 1, 1502, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Volume', N'Volume', 3, 1503, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Projection', N'3D projection', 4, 1504, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'3D panoramic', N'Reconstructed panoramic image from 3D volume', 5, 1505, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'3D panoramic (TDI)', N'Reconstructed panoramic image from 3D volume', 6, 1506, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Projection (cross-sectional)', N'Reconstructed cross-sectional slice from 3D volume', 7, 1507, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Projection (tangential)', N'Reconstructed tangential slice from 3D volume', 8, 1508, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Projection (axial)', N'Reconstructed axial projection from 3D volume', 9, 1509, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Projection (coronal)', N'Reconstructed coronal projection from 3D volume', 10, 1510, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Projection (sagittal)', N'Reconstructed sagittal projection from 3D volume', 11, 1511, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Projection (lateral)', N'Recontructed lateral projection from 3D volume', 12, 1512, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Projection (ceph a.p.)', N'Reconstructed ceph a.p. projection from 3D volume', 13, 1513, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Projection (ceph p.a.)', N'Reconstructed ceph p.a. projection from 3D volume', 14, 1514, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Intraoral', N'Intraoral X-ray image', 15, 1515, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Endo', N'Endo sequence', 16, 1516, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Bitewing', N'Bitewing image', 17, 1517, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Intraoral X-ray status', N'Intraoral X-ray status', 18, 1518, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Panoramic', N'Panoramic X-ray image', 19, 1519, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Ceph', N'Ceph X-ray image', 20, 1520, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Cross-sectional slice', N'Transversal slice', 21, 1521, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'X-ray', N'Unknown X-ray image', 22, 1522, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Intraoral video', N'Intraoral video image', 23, 1523, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Intraoral photo status', N'Intraoral photo status', 24, 1524, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Extraoral image', N'Extraoral image', 25, 1525, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Extraoral photo status', N'Extraoral photo status', 26, 1526, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Photo', N'Unknown image', 27, 1527, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Facescan', N'Facescan', 28, 1528, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'FS projection', N'Facescan projection', 29, 1529, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'FS surface', N'Facescan surface', 30, 1530, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'FS Texture', N'Facescan texture', 31, 1531, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'FS mesh', N'Facescan mesh', 32, 1532, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Implant', N'Implant', 33, 1533, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Intraoral mesh', N'Intraoral mesh', 34, 1534, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Scan', N'Scan', 38, 1535, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'2D scan', N'2D X-ray scan', 35, 1536, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'2D projection (extraoral)', N'Reconstructed extraoral projection from 2D X-ray scan', 36, 1537, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'FFP scan', N'Full frame PAN scan', 37, 1538, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Scan', N'3D-Scan', 1, 1539, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Volumen', N'Volumen', 3, 1540, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Projektion', N'3D-Projektion', 4, 1541, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'3D-Panorama', N'Berechnete Panorama-Schnittansicht aus 3D-Volumen', 5, 1542, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'3D-Panorama (TDI)', N'Berechnete Panorama-Schnittansicht aus 3D-Volumen', 6, 1543, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Projektion (transversal)', N'Berechnete transversale Schnittansicht aus 3D-Volumen', 7, 1544, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Projektion (longitudinal)', N'Berechnete longitudinale Schnittansicht aus 3D-Volumen', 8, 1545, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Projektion (axial)', N'Berechnete axiale Schnittansicht aus 3D-Volumen', 9, 1546, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Projektion (coronal)', N'Berechnete coronale Schnittansicht aus 3D-Volumen', 10, 1547, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Projektion (sagittal)', N'Berechnete sagittale Schnittansicht aus 3D-Volumen', 11, 1548, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Projektion (lateral)', N'Berechnete laterale Schnittansicht aus 3D-Volumen', 12, 1549, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Projektion (ceph a.p.)', N'Berechnete ceph a.p. Schnittansicht aus 3D-Volumen', 13, 1550, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Projektion (ceph p.a.)', N'Berechnete ceph p.a. Schnittansicht aus 3D-Volumen', 14, 1551, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Intraoral', N'Intraorales Röntgenbild', 15, 1552, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Endo', N'Endo Sequenz', 16, 1553, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Bissflügel', N'Bissflügelaufnahme', 17, 1554, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Intraoraler Röntgenstatus', N'Intraoraler Röntgenstatus', 18, 1555, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Panorama', N'OPG Aufnahme', 19, 1556, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Ceph', N'Ceph Röntgenbild', 20, 1557, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Transversale Schnittansicht', N'Transversale Schnittansicht', 21, 1558, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Röntgenbild', N'Unbekanntes Röntgenbild', 22, 1559, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Intraoral Video', N'Intraorales Videobild', 23, 1560, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Intraoraler Fotostatus', N'Intraoraler Fotostatus', 24, 1561, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Extraorales Bild', N'Extraorales Bild', 25, 1562, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Extraoraler Fotostatus', N'Extraoraler Fotostatus', 26, 1563, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Foto', N'Unbekanntes Bild', 27, 1564, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Oberflächenaufnahme', N'Oberflächenaufnahme', 28, 1565, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'FS Projektion', N'Facescan Projektion', 29, 1566, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'FS Oberfläche', N'Facescan Oberfläche', 30, 1567, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'FS Textur', N'Facescan Textur', 31, 1568, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'FS Gitter', N'Facescan Gitter', 32, 1569, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Implantat', N'Implantat', 33, 1570, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Intraorales Gitter', N'Intraorales Gitter', 34, 1571, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Scan', N'Scan', 38, 1572, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'2D-Scan', N'2D-Röntgenaufnahme', 35, 1573, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'2D-Projektion (extraoral)', N'Berechnete extraorale Schnittansicht aus 2D-Aufnahme', 36, 1574, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'FFP-Scan', N'Fullframe-PAN Scan', 37, 1575, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'VO4', N'?????????????', 39, 1576, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'VO4', N'?????????????', 39, 1577, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'VO4', N'?????????????', 39, 1578, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'VO4', N'?????????????', 39, 1579, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'VO4', N'Standard scan for fast provision of views.', 39, 1580, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'VO4', N'Standard scan for fast provision of views.', 39, 1581, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'VO4', N'Standard Scan für die schnelle Bereitstellung der Ansichten.', 39, 1582, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'VO4', N'Standard Scan für die schnelle Bereitstellung der Ansichten.', 39, 1583, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'VO4', N'Standard scan for fast provision of views.', 39, 1584, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'VO4', N'Standard scan for fast provision of views.', 39, 1585, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'VO4', N'Exploración estándar para disponer rápidamente de las vistas.', 39, 1586, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'VO4', N'Exploración estándar para disponer rápidamente de las vistas.', 39, 1587, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'VO4', N'Scan standard pour la mise à disposition rapide de vues.', 39, 1588, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'VO4', N'Scan standard pour la mise à disposition rapide de vues.', 39, 1589, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'VO4', N'Standard scan for fast provision of views.', 39, 1590, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'VO4', N'Standard scan for fast provision of views.', 39, 1591, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'VO4', N'Scansione standard per la disponibilità rapida delle viste.', 39, 1592, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'VO4', N'Scansione standard per la disponibilità rapida delle viste.', 39, 1593, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'VO4', N'???????????????????????', 39, 1594, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'VO4', N'???????????????????????', 39, 1595, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'VO4', N'??? ??? ??? ?? ?? ??.', 39, 1596, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'VO4', N'??? ??? ??? ?? ?? ??.', 39, 1597, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'VO4', N'Standaardscan voor de snelle beschikbaarheid van de opnamen', 39, 1598, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'VO4', N'Standaardscan voor de snelle beschikbaarheid van de opnamen', 39, 1599, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'VO4', N'Standardskanning for raskt tilgjengelige opptak', 39, 1600, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'VO4', N'Standardskanning for raskt tilgjengelige opptak', 39, 1601, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'VO4', N'Standardskanning for raskt tilgjengelige opptak', 39, 1602, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'VO4', N'Standard scan for fast provision of views.', 39, 1603, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'VO4', N'Standard scan for fast provision of views.', 39, 1604, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'VO4', N'Scan standard para disponibilização rápida das visualizações', 39, 1605, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'VO4', N'Scan standard para disponibilização rápida das visualizações', 39, 1606, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'VO4', N'??????????? ???????????? ??? ??????? ?????????? ?????.', 39, 1607, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'VO4', N'??????????? ???????????? ??? ??????? ?????????? ?????.', 39, 1608, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'VO4', N'Standard scanning för snabb iordningställning av bilder.', 39, 1609, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'VO4', N'Standard scanning för snabb iordningställning av bilder.', 39, 1610, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'VO4', N'?????????????', 39, 1611, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'VO4', N'?????????????', 39, 1612, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'VO4', N'?????????????', 39, 1613, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'FS1', N'Oberflächenaufnahme', 40, 1614, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'FS1', N'Surface scan', 40, 1615, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'VO1', N'??????????????', 41, 1616, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'VO1', N'??????????????', 41, 1617, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'VO1', N'??????????????', 41, 1618, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'VO1', N'??????????????', 41, 1619, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'VO1', N'High-resolution scan with the possibility of a secondary reconstruction.', 41, 1620, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'VO1', N'High-resolution scan with the possibility of a secondary reconstruction.', 41, 1621, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'VO1', N'Hochauflösender Scan mit der Möglichkeit einer Sekundär- Rekonstruktion.', 41, 1622, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'VO1', N'Hochauflösender Scan mit der Möglichkeit einer Sekundär- Rekonstruktion.', 41, 1623, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'VO1', N'High-resolution scan with the possibility of a secondary reconstruction.', 41, 1624, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'VO1', N'High-resolution scan with the possibility of a secondary reconstruction.', 41, 1625, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'VO1', N'Exploración de alta resolución con posibilidad de crear reconstrucciones secundarias.', 41, 1626, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'VO1', N'Exploración de alta resolución con posibilidad de crear reconstrucciones secundarias.', 41, 1627, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'VO1', N'Scan haute définition avec la possibilité d''une reconstruction secondaire.', 41, 1628, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'VO1', N'Scan haute définition avec la possibilité d''une reconstruction secondaire.', 41, 1629, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'VO1', N'High-resolution scan with the possibility of a secondary reconstruction.', 41, 1630, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'VO1', N'High-resolution scan with the possibility of a secondary reconstruction.', 41, 1631, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'VO1', N'Scansione ad alta risoluzione con la possibilità di una ricostruzione secondaria.', 41, 1632, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'VO1', N'Scansione ad alta risoluzione con la possibilità di una ricostruzione secondaria.', 41, 1633, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'VO1', N'??????????????????????', 41, 1634, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'VO1', N'??????????????????????', 41, 1635, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'VO1', N'?? ??? ??? ??? ???? ??.', 41, 1636, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'VO1', N'?? ??? ??? ??? ???? ??.', 41, 1637, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'VO1', N'Scan met hoge resolutie, met mogelijkheid tot een secundaire reconstructie', 41, 1638, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'VO1', N'Scan met hoge resolutie, met mogelijkheid tot een secundaire reconstructie', 41, 1639, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'VO1', N'Skanning med høy oppløsning med mulighet for sekundær rekonstruksjon', 41, 1640, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'VO1', N'Skanning med høy oppløsning med mulighet for sekundær rekonstruksjon', 41, 1641, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'VO1', N'Skanning med høy oppløsning med mulighet for sekundær rekonstruksjon', 41, 1642, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'VO1', N'High-resolution scan with the possibility of a secondary reconstruction.', 41, 1643, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'VO1', N'High-resolution scan with the possibility of a secondary reconstruction.', 41, 1644, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'VO1', N'Scan de alta resolução com possibilidade de reconstrução secundária', 41, 1645, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'VO1', N'Scan de alta resolução com possibilidade de reconstrução secundária', 41, 1646, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'VO1', N'???????????? ???????? ?????????? ? ???????????? ????????? ?????????????.', 41, 1647, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'VO1', N'???????????? ???????? ?????????? ? ???????????? ????????? ?????????????.', 41, 1648, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'VO1', N'Högupplösande scanning med möjlighet till en sekundär rekonstruktion.', 41, 1649, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'VO1', N'Högupplösande scanning med möjlighet till en sekundär rekonstruktion.', 41, 1650, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'VO1', N'????????????????', 41, 1651, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'VO1', N'????????????????', 41, 1652, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'VO1', N'????????????????', 41, 1653, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'VO2', N'?????????????', 42, 1654, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'VO2', N'?????????????', 42, 1655, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'VO2', N'?????????????', 42, 1656, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'VO2', N'?????????????', 42, 1657, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'VO2', N'Standard scan for fast provision of views.', 42, 1658, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'VO2', N'Standard scan for fast provision of views.', 42, 1659, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'VO2', N'Standard Scan für die schnelle Bereitstellung der Ansichten.', 42, 1660, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'VO2', N'Standard Scan für die schnelle Bereitstellung der Ansichten.', 42, 1661, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'VO2', N'Standard scan for fast provision of views.', 42, 1662, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'VO2', N'Standard scan for fast provision of views.', 42, 1663, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'VO2', N'Exploración estándar para disponer rápidamente de las vistas.', 42, 1664, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'VO2', N'Exploración estándar para disponer rápidamente de las vistas.', 42, 1665, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'VO2', N'Scan standard pour la mise à disposition rapide de vues.', 42, 1666, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'VO2', N'Scan standard pour la mise à disposition rapide de vues.', 42, 1667, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'VO2', N'Standard scan for fast provision of views.', 42, 1668, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'VO2', N'Standard scan for fast provision of views.', 42, 1669, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'VO2', N'Scansione standard per la disponibilità rapida delle viste.', 42, 1670, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'VO2', N'Scansione standard per la disponibilità rapida delle viste.', 42, 1671, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'VO2', N'???????????????????????', 42, 1672, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'VO2', N'???????????????????????', 42, 1673, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'VO2', N'??? ??? ??? ?? ?? ??.', 42, 1674, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'VO2', N'??? ??? ??? ?? ?? ??.', 42, 1675, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'VO2', N'Standaardscan voor de snelle beschikbaarheid van de opnamen', 42, 1676, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'VO2', N'Standaardscan voor de snelle beschikbaarheid van de opnamen', 42, 1677, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'VO2', N'Standardskanning for raskt tilgjengelige opptak', 42, 1678, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'VO2', N'Standardskanning for raskt tilgjengelige opptak', 42, 1679, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'VO2', N'Standardskanning for raskt tilgjengelige opptak', 42, 1680, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'VO2', N'Standard scan for fast provision of views.', 42, 1681, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'VO2', N'Standard scan for fast provision of views.', 42, 1682, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'VO2', N'Scan standard para disponibilização rápida das visualizações', 42, 1683, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'VO2', N'Scan standard para disponibilização rápida das visualizações', 42, 1684, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'VO2', N'??????????? ???????????? ??? ??????? ?????????? ?????.', 42, 1685, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'VO2', N'??????????? ???????????? ??? ??????? ?????????? ?????.', 42, 1686, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'VO2', N'Standard scanning för snabb iordningställning av bilder.', 42, 1687, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'VO2', N'Standard scanning för snabb iordningställning av bilder.', 42, 1688, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'VO2', N'?????????????', 42, 1689, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'VO2', N'?????????????', 42, 1690, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'VO2', N'?????????????', 42, 1691, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'VO5', N'??????????????', 43, 1692, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'VO5', N'??????????????', 43, 1693, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'VO5', N'??????????????', 43, 1694, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'VO5', N'??????????????', 43, 1695, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'VO5', N'High-resolution scan with the possibility of a secondary reconstruction.', 43, 1696, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'VO5', N'High-resolution scan with the possibility of a secondary reconstruction.', 43, 1697, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'VO5', N'Hochauflösender Scan mit der Möglichkeit einer Sekundär- Rekonstruktion.', 43, 1698, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'VO5', N'Hochauflösender Scan mit der Möglichkeit einer Sekundär- Rekonstruktion.', 43, 1699, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'VO5', N'High-resolution scan with the possibility of a secondary reconstruction.', 43, 1700, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'VO5', N'High-resolution scan with the possibility of a secondary reconstruction.', 43, 1701, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'VO5', N'Exploración de alta resolución con posibilidad de crear reconstrucciones secundarias.', 43, 1702, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'VO5', N'Exploración de alta resolución con posibilidad de crear reconstrucciones secundarias.', 43, 1703, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'VO5', N'Scan haute définition avec la possibilité d''une reconstruction secondaire.', 43, 1704, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'VO5', N'Scan haute définition avec la possibilité d''une reconstruction secondaire.', 43, 1705, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'VO5', N'High-resolution scan with the possibility of a secondary reconstruction.', 43, 1706, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'VO5', N'High-resolution scan with the possibility of a secondary reconstruction.', 43, 1707, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'VO5', N'Scansione ad alta risoluzione con la possibilità di una ricostruzione secondaria.', 43, 1708, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'VO5', N'Scansione ad alta risoluzione con la possibilità di una ricostruzione secondaria.', 43, 1709, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'VO5', N'??????????????????????', 43, 1710, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'VO5', N'??????????????????????', 43, 1711, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'VO5', N'?? ??? ??? ??? ???? ??.', 43, 1712, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'VO5', N'?? ??? ??? ??? ???? ??.', 43, 1713, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'VO5', N'Scan met hoge resolutie, met mogelijkheid tot een secundaire reconstructie', 43, 1714, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'VO5', N'Scan met hoge resolutie, met mogelijkheid tot een secundaire reconstructie', 43, 1715, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'VO5', N'Skanning med høy oppløsning med mulighet for sekundær rekonstruksjon', 43, 1716, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'VO5', N'Skanning med høy oppløsning med mulighet for sekundær rekonstruksjon', 43, 1717, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'VO5', N'Skanning med høy oppløsning med mulighet for sekundær rekonstruksjon', 43, 1718, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'VO5', N'High-resolution scan with the possibility of a secondary reconstruction.', 43, 1719, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'VO5', N'High-resolution scan with the possibility of a secondary reconstruction.', 43, 1720, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'VO5', N'Scan de alta resolução com possibilidade de reconstrução secundária', 43, 1721, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'VO5', N'Scan de alta resolução com possibilidade de reconstrução secundária', 43, 1722, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'VO5', N'???????????? ???????? ?????????? ? ???????????? ????????? ?????????????.', 43, 1723, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'VO5', N'???????????? ???????? ?????????? ? ???????????? ????????? ?????????????.', 43, 1724, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'VO5', N'Högupplösande scanning med möjlighet till en sekundär rekonstruktion.', 43, 1725, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'VO5', N'Högupplösande scanning med möjlighet till en sekundär rekonstruktion.', 43, 1726, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'VO5', N'????????????????', 43, 1727, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'VO5', N'????????????????', 43, 1728, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'VO5', N'????????????????', 43, 1729, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'VOG', N'?????,??X?????????????????', 44, 1730, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'VOG', N'?????,??X?????????????????', 44, 1731, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'VOG', N'?????,??X?????????????????', 44, 1732, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'VOG', N'?????,??X?????????????????', 44, 1733, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'VOG', N'Scan for small objects, e.g. X-ray templates, study objects. Not suitable for patient scans.', 44, 1734, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'VOG', N'Scan for small objects, e.g. X-ray templates, study objects. Not suitable for patient scans.', 44, 1735, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'VOG', N'Scan für kleine Objekte, z.B. Röntgenschablonen, Studienobjekte. Nicht geeignet für Patientenscans.', 44, 1736, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'VOG', N'Scan für kleine Objekte, z.B. Röntgenschablonen, Studienobjekte. Nicht geeignet für Patientenscans.', 44, 1737, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'VOG', N'Scan for small objects, e.g. X-ray templates, study objects. Not suitable for patient scans.', 44, 1738, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'VOG', N'Scan for small objects, e.g. X-ray templates, study objects. Not suitable for patient scans.', 44, 1739, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'VOG', N'Exploración de objetos pequeños, p. ej. plantillas radiográficas, objetos de estudio. No indicado para exploraciones de pacientes.', 44, 1740, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'VOG', N'Exploración de objetos pequeños, p. ej. plantillas radiográficas, objetos de estudio. No indicado para exploraciones de pacientes.', 44, 1741, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'VOG', N'Scan pour petits objets, p. ex. gabarits de radiographie, objets d''études. Ne convient pas pour des scans de patients.', 44, 1742, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'VOG', N'Scan pour petits objets, p. ex. gabarits de radiographie, objets d''études. Ne convient pas pour des scans de patients.', 44, 1743, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'VOG', N'Scan for small objects, e.g. X-ray templates, study objects. Not suitable for patient scans.', 44, 1744, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'VOG', N'Scan for small objects, e.g. X-ray templates, study objects. Not suitable for patient scans.', 44, 1745, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'VOG', N'Scansione per piccoli oggetti, ad es. sagoma radiologica, oggetti di studio. Non adatta per la scansione dei pazienti.', 44, 1746, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'VOG', N'Scansione per piccoli oggetti, ad es. sagoma radiologica, oggetti di studio. Non adatta per la scansione dei pazienti.', 44, 1747, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'VOG', N'???????????(X??????????????)????????????????', 44, 1748, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'VOG', N'???????????(X??????????????)????????????????', 44, 1749, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'VOG', N'X-?? ???, ?? ?? ?? ? ?? ??? ?? ??. ?? ???? ???? ??.', 44, 1750, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'VOG', N'X-?? ???, ?? ?? ?? ? ?? ??? ?? ??. ?? ???? ???? ??.', 44, 1751, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'VOG', N'Scan voor kleine objecten, bv. Röntgensjablonen, studieobjecten. Niet geschikt voor patiëntenscans.', 44, 1752, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'VOG', N'Scan voor kleine objecten, bv. Röntgensjablonen, studieobjecten. Niet geschikt voor patiëntenscans.', 44, 1753, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'VOG', N'Skanning for små objekter, f.eks. røntgensjablonger eller studieobjekter. Ikke egnet for skanning av pasienter.', 44, 1754, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'VOG', N'Skanning for små objekter, f.eks. røntgensjablonger eller studieobjekter. Ikke egnet for skanning av pasienter.', 44, 1755, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'VOG', N'Skanning for små objekter, f.eks. røntgensjablonger eller studieobjekter. Ikke egnet for skanning av pasienter.', 44, 1756, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'VOG', N'Scan for small objects, e.g. X-ray templates, study objects. Not suitable for patient scans.', 44, 1757, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'VOG', N'Scan for small objects, e.g. X-ray templates, study objects. Not suitable for patient scans.', 44, 1758, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'VOG', N'Scan para pequenos objetos, p. ex. moldes de raios x, objetos de estudo. Não indicado para scan de pacientes.', 44, 1759, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'VOG', N'Scan para pequenos objetos, p. ex. moldes de raios x, objetos de estudo. Não indicado para scan de pacientes.', 44, 1760, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'VOG', N'???????????? ??? ?????? ????????, ????????, ????????????? ????????, ???????? ????????????. ?????????? ??? ???????????? ????????.', 44, 1761, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'VOG', N'???????????? ??? ?????? ????????, ????????, ????????????? ????????, ???????? ????????????. ?????????? ??? ???????????? ????????.', 44, 1762, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'VOG', N'Scanning för små objekt, t.ex. röntgenschabloner, studieobjekt. Inte lämpligt för patientscanning.', 44, 1763, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'VOG', N'Scanning för små objekt, t.ex. röntgenschabloner, studieobjekt. Inte lämpligt för patientscanning.', 44, 1764, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'VOG', N'????????,?? X ??????????????????', 44, 1765, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'VOG', N'????????,?? X ??????????????????', 44, 1766, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'VOG', N'????????,?? X ??????????????????', 44, 1767, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'P1', N'??????', 45, 1768, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'P1', N'??????', 45, 1769, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'P1', N'??????', 45, 1770, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'P1', N'??????', 45, 1771, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'P1', N'Standard panoramic exposure', 45, 1772, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'P1', N'Standard panoramic exposure', 45, 1773, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'P1', N'Standard-Panoramaaufnahme', 45, 1774, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'P1', N'Standard-Panoramaaufnahme', 45, 1775, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'P1', N'Standard panoramic exposure', 45, 1776, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'P1', N'Standard panoramic exposure', 45, 1777, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'P1', N'Radiografía panorámica estándar', 45, 1778, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'P1', N'Radiografía panorámica estándar', 45, 1779, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'P1', N'Radiographie panoramique standard', 45, 1780, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'P1', N'Radiographie panoramique standard', 45, 1781, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'P1', N'Standard panoramic exposure', 45, 1782, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'P1', N'Standard panoramic exposure', 45, 1783, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'P1', N'Radiografia panoramica standard', 45, 1784, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'P1', N'Radiografia panoramica standard', 45, 1785, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'P1', N'?????????', 45, 1786, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'P1', N'?????????', 45, 1787, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'P1', N'?? ???? ??', 45, 1788, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'P1', N'?? ???? ??', 45, 1789, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'P1', N'Standaard panorama-opname', 45, 1790, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'P1', N'Standaard panorama-opname', 45, 1791, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'P1', N'Normalt panoramaopptak', 45, 1792, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'P1', N'Normalt panoramaopptak', 45, 1793, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'P1', N'Normalt panoramaopptak', 45, 1794, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'P1', N'Standard panoramic exposure', 45, 1795, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'P1', N'Standard panoramic exposure', 45, 1796, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'P1', N'Imagem normal panorâmica, completa', 45, 1797, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'P1', N'Imagem normal panorâmica, completa', 45, 1798, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'P1', N'??????????? ?????????? ??????????????', 45, 1799, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'P1', N'??????????? ?????????? ??????????????', 45, 1800, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'P1', N'Standard panoramabild', 45, 1801, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'P1', N'Standard panoramabild', 45, 1802, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'P1', N'??????', 45, 1803, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'P1', N'??????', 45, 1804, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'P1', N'??????', 45, 1805, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'P1 A', N'??????????', 46, 1806, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'P1 A', N'??????????', 46, 1807, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'P1 A', N'??????????', 46, 1808, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'P1 A', N'??????????', 46, 1809, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'P1 A', N'Artifact-reduced standard panoramic exposure', 46, 1810, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'P1 A', N'Artifact-reduced standard panoramic exposure', 46, 1811, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'P1 A', N'Artefaktreduzierte Standard-Panoramaaufnahme', 46, 1812, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'P1 A', N'Artefaktreduzierte Standard-Panoramaaufnahme', 46, 1813, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'P1 A', N'Artifact-reduced standard panoramic exposure', 46, 1814, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'P1 A', N'Artifact-reduced standard panoramic exposure', 46, 1815, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'P1 A', N'Radiografía panorámica estándar con reducción de artefactos', 46, 1816, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'P1 A', N'Radiografía panorámica estándar con reducción de artefactos', 46, 1817, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'P1 A', N'Radiographie panoramique standard, avec réduction des artefacts', 46, 1818, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'P1 A', N'Radiographie panoramique standard, avec réduction des artefacts', 46, 1819, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'P1 A', N'Artifact-reduced standard panoramic exposure', 46, 1820, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'P1 A', N'Artifact-reduced standard panoramic exposure', 46, 1821, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'P1 A', N'Radiografia panoramica standard con riduzione degli artefatti', 46, 1822, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'P1 A', N'Radiografia panoramica standard con riduzione degli artefatti', 46, 1823, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'P1 A', N'??????????????????', 46, 1824, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'P1 A', N'??????????????????', 46, 1825, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'P1 A', N'????? ??? ?? ???? ??', 46, 1826, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'P1 A', N'????? ??? ?? ???? ??', 46, 1827, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'P1 A', N'Artefactgereduceerde standaard panorama-opname', 46, 1828, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'P1 A', N'Artefactgereduceerde standaard panorama-opname', 46, 1829, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'P1 A', N'Normalt panoramaopptak med færre artefakter', 46, 1830, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'P1 A', N'Normalt panoramaopptak med færre artefakter', 46, 1831, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'P1 A', N'Normalt panoramaopptak med færre artefakter', 46, 1832, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'P1 A', N'Artifact-reduced standard panoramic exposure', 46, 1833, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'P1 A', N'Artifact-reduced standard panoramic exposure', 46, 1834, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'P1 A', N'Imagem normal panorâmica com redução de artefactos', 46, 1835, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'P1 A', N'Imagem normal panorâmica com redução de artefactos', 46, 1836, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'P1 A', N'??????????? ?????????? ?????????????? ? ??????????? ??????????', 46, 1837, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'P1 A', N'??????????? ?????????? ?????????????? ? ??????????? ??????????', 46, 1838, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'P1 A', N'Artefaktreducerad standard panoramabild', 46, 1839, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'P1 A', N'Artefaktreducerad standard panoramabild', 46, 1840, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'P1 A', N'???????????', 46, 1841, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'P1 A', N'???????????', 46, 1842, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'P1 A', N'???????????', 46, 1843, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'P1 C', N'??????????,??1.25?', 47, 1844, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'P1 C', N'??????????,??1.25?', 47, 1845, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'P1 C', N'??????????,??1.25?', 47, 1846, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'P1 C', N'??????????,??1.25?', 47, 1847, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'P1 C', N'Constantly magnified standard panoramic exposure with 1.25-fold magnification', 47, 1848, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'P1 C', N'Constantly magnified standard panoramic exposure with 1.25-fold magnification', 47, 1849, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'P1 C', N'Konstant vergrößerte Standard-Panoramaaufnahme mit 1,25-facher Vergrößerung', 47, 1850, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'P1 C', N'Konstant vergrößerte Standard-Panoramaaufnahme mit 1,25-facher Vergrößerung', 47, 1851, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'P1 C', N'Constantly magnified standard panoramic exposure with 1.25-fold magnification', 47, 1852, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'P1 C', N'Constantly magnified standard panoramic exposure with 1.25-fold magnification', 47, 1853, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'P1 C', N'Radiografía panorámica estándar con ampliación constante (factor 1,25)', 47, 1854, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'P1 C', N'Radiografía panorámica estándar con ampliación constante (factor 1,25)', 47, 1855, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'P1 C', N'Radiographie panoramique standard, avec grossissement constant de 1,25', 47, 1856, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'P1 C', N'Radiographie panoramique standard, avec grossissement constant de 1,25', 47, 1857, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'P1 C', N'Constantly magnified standard panoramic exposure with 1.25-fold magnification', 47, 1858, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'P1 C', N'Constantly magnified standard panoramic exposure with 1.25-fold magnification', 47, 1859, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'P1 C', N'Radiografia panoramica standard con ingrandimento costante di 1,25 volte', 47, 1860, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'P1 C', N'Radiografia panoramica standard con ingrandimento costante di 1,25 volte', 47, 1861, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'P1 C', N'???1.25????????????????', 47, 1862, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'P1 C', N'???1.25????????????????', 47, 1863, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'P1 C', N'1.25? ??? ???? ??? ?? ???? ??', 47, 1864, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'P1 C', N'1.25? ??? ???? ??? ?? ???? ??', 47, 1865, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'P1 C', N'Constant vergrote standaard panorama-opname met 1,25-voudige vergroting', 47, 1866, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'P1 C', N'Constant vergrote standaard panorama-opname met 1,25-voudige vergroting', 47, 1867, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'P1 C', N'Normalt panoramaopptak konstant forstørret 1,25 ganger', 47, 1868, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'P1 C', N'Normalt panoramaopptak konstant forstørret 1,25 ganger', 47, 1869, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'P1 C', N'Normalt panoramaopptak konstant forstørret 1,25 ganger', 47, 1870, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'P1 C', N'Constantly magnified standard panoramic exposure with 1.25-fold magnification', 47, 1871, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'P1 C', N'Constantly magnified standard panoramic exposure with 1.25-fold magnification', 47, 1872, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'P1 C', N'Imagem normal panorâmica, de ampliação constante, com ampliação de 1,25 x', 47, 1873, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'P1 C', N'Imagem normal panorâmica, de ampliação constante, com ampliação de 1,25 x', 47, 1874, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'P1 C', N'??????????? ?????????? ?????????????? ? ?????????? 1,25-??????? ???????????', 47, 1875, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'P1 C', N'??????????? ?????????? ?????????????? ? ?????????? 1,25-??????? ???????????', 47, 1876, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'P1 C', N'Konstant förstorad standard panoramabild med 1,25 x förstoring', 47, 1877, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'P1 C', N'Konstant förstorad standard panoramabild med 1,25 x förstoring', 47, 1878, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'P1 C', N'1.25 ????????????', 47, 1879, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'P1 C', N'1.25 ????????????', 47, 1880, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'P1 C', N'1.25 ????????????', 47, 1881, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'P2', N'????,?????', 48, 1882, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'P2', N'????,?????', 48, 1883, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'P2', N'????,?????', 48, 1884, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'P2', N'????,?????', 48, 1885, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'P2', N'Panoramic exposure without ascending rami', 48, 1886, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'P2', N'Panoramic exposure without ascending rami', 48, 1887, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'P2', N'Panoramaaufnahme ohne aufsteigende Äste', 48, 1888, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'P2', N'Panoramaaufnahme ohne aufsteigende Äste', 48, 1889, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'P2', N'Panoramic exposure without ascending rami', 48, 1890, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'P2', N'Panoramic exposure without ascending rami', 48, 1891, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'P2', N'Radiografía panorámica sin ramas ascendentes', 48, 1892, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'P2', N'Radiografía panorámica sin ramas ascendentes', 48, 1893, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'P2', N'Radiographie panoramique, sans branches montantes', 48, 1894, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'P2', N'Radiographie panoramique, sans branches montantes', 48, 1895, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'P2', N'Panoramic exposure without ascending rami', 48, 1896, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'P2', N'Panoramic exposure without ascending rami', 48, 1897, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'P2', N'Radiografia panoramica senza rami ascendenti', 48, 1898, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'P2', N'Radiografia panoramica senza rami ascendenti', 48, 1899, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'P2', N'????????????', 48, 1900, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'P2', N'????????????', 48, 1901, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'P2', N'?? ??? ??? ???? ??', 48, 1902, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'P2', N'?? ??? ??? ???? ??', 48, 1903, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'P2', N'Panorama-opname zonder opklimmende takken', 48, 1904, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'P2', N'Panorama-opname zonder opklimmende takken', 48, 1905, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'P2', N'Panoramaopptak, uten oppadstigende forgreininger', 48, 1906, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'P2', N'Panoramaopptak, uten oppadstigende forgreininger', 48, 1907, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'P2', N'Panoramaopptak, uten oppadstigende forgreininger', 48, 1908, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'P2', N'Panoramic exposure without ascending rami', 48, 1909, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'P2', N'Panoramic exposure without ascending rami', 48, 1910, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'P2', N'Imagem normal panorâmica, sem ramificações ascendentes', 48, 1911, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'P2', N'Imagem normal panorâmica, sem ramificações ascendentes', 48, 1912, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'P2', N'?????????? ?????????????? ??? ?????????? ??????', 48, 1913, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'P2', N'?????????? ?????????????? ??? ?????????? ??????', 48, 1914, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'P2', N'Panoramabild utan uppåtgående grenar', 48, 1915, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'P2', N'Panoramabild utan uppåtgående grenar', 48, 1916, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'P2', N'????,???', 48, 1917, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'P2', N'????,???', 48, 1918, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'P2', N'????,???', 48, 1919, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'P2 A', N'????????,?????', 49, 1920, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'P2 A', N'????????,?????', 49, 1921, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'P2 A', N'????????,?????', 49, 1922, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'P2 A', N'????????,?????', 49, 1923, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'P2 A', N'Artifact-reduced panoramic exposure without ascending rami', 49, 1924, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'P2 A', N'Artifact-reduced panoramic exposure without ascending rami', 49, 1925, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'P2 A', N'Artefaktreduzierte Panoramaaufnahme ohne aufsteigende Äste', 49, 1926, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'P2 A', N'Artefaktreduzierte Panoramaaufnahme ohne aufsteigende Äste', 49, 1927, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'P2 A', N'Artifact-reduced panoramic exposure without ascending rami', 49, 1928, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'P2 A', N'Artifact-reduced panoramic exposure without ascending rami', 49, 1929, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'P2 A', N'Radiografía panorámica con reducción de artefactos sin ramas ascendentes', 49, 1930, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'P2 A', N'Radiografía panorámica con reducción de artefactos sin ramas ascendentes', 49, 1931, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'P2 A', N'Radiographie panoramique, avec réduction des artefacts, sans branches montantes', 49, 1932, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'P2 A', N'Radiographie panoramique, avec réduction des artefacts, sans branches montantes', 49, 1933, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'P2 A', N'Artifact-reduced panoramic exposure without ascending rami', 49, 1934, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'P2 A', N'Artifact-reduced panoramic exposure without ascending rami', 49, 1935, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'P2 A', N'Radiografia panoramica con riduzione degli artefatti senza rami ascendenti', 49, 1936, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'P2 A', N'Radiografia panoramica con riduzione degli artefatti senza rami ascendenti', 49, 1937, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'P2 A', N'?????????????????????', 49, 1938, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'P2 A', N'?????????????????????', 49, 1939, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'P2 A', N'?? ??? ???? ???? ??? ???? ??', 49, 1940, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'P2 A', N'?? ??? ???? ???? ??? ???? ??', 49, 1941, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'P2 A', N'Artefactgereduceerde panorama-opname zonder opklimmende takken', 49, 1942, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'P2 A', N'Artefactgereduceerde panorama-opname zonder opklimmende takken', 49, 1943, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'P2 A', N'Panoramaopptak med færre artefakter og uten oppadstigende forgreininger', 49, 1944, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'P2 A', N'Panoramaopptak med færre artefakter og uten oppadstigende forgreininger', 49, 1945, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'P2 A', N'Panoramaopptak med færre artefakter og uten oppadstigende forgreininger', 49, 1946, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'P2 A', N'Artifact-reduced panoramic exposure without ascending rami', 49, 1947, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'P2 A', N'Artifact-reduced panoramic exposure without ascending rami', 49, 1948, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'P2 A', N'Imagem normal panorâmica com redução de artefactos, sem ramificações ascendentes', 49, 1949, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'P2 A', N'Imagem normal panorâmica com redução de artefactos, sem ramificações ascendentes', 49, 1950, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'P2 A', N'?????????? ?????????????? ? ??????????? ?????????? ??? ?????????? ??????', 49, 1951, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'P2 A', N'?????????? ?????????????? ? ??????????? ?????????? ??? ?????????? ??????', 49, 1952, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'P2 A', N'Artefaktreducerad panoramabild utan uppåtgående grenar', 49, 1953, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'P2 A', N'Artefaktreducerad panoramabild utan uppåtgående grenar', 49, 1954, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'P2 A', N'?????????,???', 49, 1955, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'P2 A', N'?????????,???', 49, 1956, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'P2 A', N'?????????,???', 49, 1957, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'P2 C', N'????????,?????,????1.25?', 50, 1958, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'P2 C', N'????????,?????,????1.25?', 50, 1959, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'P2 C', N'????????,?????,????1.25?', 50, 1960, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'P2 C', N'????????,?????,????1.25?', 50, 1961, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'P2 C', N'Constantly magnified panoramic exposure, without ascending rami, with 1.25-fold magnification', 50, 1962, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'P2 C', N'Constantly magnified panoramic exposure, without ascending rami, with 1.25-fold magnification', 50, 1963, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'P2 C', N'Konstant vergrößerte Panoramaaufnahme, ohne aufsteigende Äste mit 1,25-facher Vergrößerung', 50, 1964, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'P2 C', N'Konstant vergrößerte Panoramaaufnahme, ohne aufsteigende Äste mit 1,25-facher Vergrößerung', 50, 1965, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'P2 C', N'Constantly magnified panoramic exposure, without ascending rami, with 1.25-fold magnification', 50, 1966, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'P2 C', N'Constantly magnified panoramic exposure, without ascending rami, with 1.25-fold magnification', 50, 1967, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'P2 C', N'Radiografía panorámica con ampliación constante (factor 1,25), sin ramas ascendentes', 50, 1968, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'P2 C', N'Radiografía panorámica con ampliación constante (factor 1,25), sin ramas ascendentes', 50, 1969, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'P2 C', N'Radiographie panoramique, avec grossissement constant de 1,25, sans branches montantes', 50, 1970, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'P2 C', N'Radiographie panoramique, avec grossissement constant de 1,25, sans branches montantes', 50, 1971, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'P2 C', N'Constantly magnified panoramic exposure, without ascending rami, with 1.25-fold magnification', 50, 1972, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'P2 C', N'Constantly magnified panoramic exposure, without ascending rami, with 1.25-fold magnification', 50, 1973, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'P2 C', N'Radiografia panoramica con ingrandimento costante di 1,25 volte, senza rami ascendenti', 50, 1974, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'P2 C', N'Radiografia panoramica con ingrandimento costante di 1,25 volte, senza rami ascendenti', 50, 1975, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'P2 C', N'???1.25???????????????????', 50, 1976, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'P2 C', N'???1.25???????????????????', 50, 1977, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'P2 C', N'1.25? ??? ???? ??? ???? ??, ?? ?? ??', 50, 1978, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'P2 C', N'1.25? ??? ???? ??? ???? ??, ?? ?? ??', 50, 1979, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'P2 C', N'Constant vergrote panorama-opname, zonder opklimmende takken met 1,25-voudige vergroting', 50, 1980, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'P2 C', N'Constant vergrote panorama-opname, zonder opklimmende takken met 1,25-voudige vergroting', 50, 1981, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'P2 C', N'Panoramaopptak uten oppadstigende forgreininger, forstørret 1,25 ganger', 50, 1982, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'P2 C', N'Panoramaopptak uten oppadstigende forgreininger, forstørret 1,25 ganger', 50, 1983, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'P2 C', N'Panoramaopptak uten oppadstigende forgreininger, forstørret 1,25 ganger', 50, 1984, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'P2 C', N'Constantly magnified panoramic exposure, without ascending rami, with 1.25-fold magnification', 50, 1985, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'P2 C', N'Constantly magnified panoramic exposure, without ascending rami, with 1.25-fold magnification', 50, 1986, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'P2 C', N'Imagem normal panorâmica de ampliação constante, sem ramificações ascendentes, com ampliação de 1,25 x', 50, 1987, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'P2 C', N'Imagem normal panorâmica de ampliação constante, sem ramificações ascendentes, com ampliação de 1,25 x', 50, 1988, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'P2 C', N'?????????? ??????????????, ??? ?????????? ??????, ? ?????????? 1,25-??????? ???????????', 50, 1989, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'P2 C', N'?????????? ??????????????, ??? ?????????? ??????, ? ?????????? 1,25-??????? ???????????', 50, 1990, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'P2 C', N'Konstant förstorad panoramabild, utan uppåtgående grenar med 1,25 x förstoring', 50, 1991, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'P2 C', N'Konstant förstorad panoramabild, utan uppåtgående grenar med 1,25 x förstoring', 50, 1992, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'P2 C', N'1.25 ??????????,???', 50, 1993, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'P2 C', N'1.25 ??????????,???', 50, 1994, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'P2 C', N'1.25 ??????????,???', 50, 1995, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'P10', N'????????', 51, 1996, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'P10', N'????????', 51, 1997, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'P10', N'????????', 51, 1998, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'P10', N'????????', 51, 1999, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'P10', N'Standard panoramic exposure of a child', 51, 2000, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'P10', N'Standard panoramic exposure of a child', 51, 2001, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'P10', N'Kinder Standard-Panoramaaufnahme', 51, 2002, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'P10', N'Kinder Standard-Panoramaaufnahme', 51, 2003, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'P10', N'Standard panoramic exposure of a child', 51, 2004, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'P10', N'Standard panoramic exposure of a child', 51, 2005, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'P10', N'Radiografía panorámica estándar pediátrica', 51, 2006, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'P10', N'Radiografía panorámica estándar pediátrica', 51, 2007, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'P10', N'Radiographie panoramique standard enfants', 51, 2008, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'P10', N'Radiographie panoramique standard enfants', 51, 2009, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'P10', N'Standard panoramic exposure of a child', 51, 2010, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'P10', N'Standard panoramic exposure of a child', 51, 2011, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'P10', N'Radiografia panoramica standard per bambini', 51, 2012, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'P10', N'Radiografia panoramica standard per bambini', 51, 2013, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'P10', N'????????????', 51, 2014, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'P10', N'????????????', 51, 2015, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'P10', N'??? ?? ???? ??', 51, 2016, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'P10', N'??? ?? ???? ??', 51, 2017, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'P10', N'Standaard panorama-opame voor kinderen', 51, 2018, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'P10', N'Standaard panorama-opame voor kinderen', 51, 2019, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'P10', N'Normalt panoramaopptak av barn', 51, 2020, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'P10', N'Normalt panoramaopptak av barn', 51, 2021, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'P10', N'Normalt panoramaopptak av barn', 51, 2022, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'P10', N'Standard panoramic exposure of a child', 51, 2023, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'P10', N'Standard panoramic exposure of a child', 51, 2024, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'P10', N'Imagem normal panorâmica de criança', 51, 2025, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'P10', N'Imagem normal panorâmica de criança', 51, 2026, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'P10', N'??????????? ?????????? ??????????????, ???????', 51, 2027, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'P10', N'??????????? ?????????? ??????????????, ???????', 51, 2028, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'P10', N'Barn standard panoramabild', 51, 2029, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'P10', N'Barn standard panoramabild', 51, 2030, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'P10', N'????????', 51, 2031, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'P10', N'????????', 51, 2032, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'P10', N'????????', 51, 2033, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'P10 A', N'????????????', 52, 2034, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'P10 A', N'????????????', 52, 2035, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'P10 A', N'????????????', 52, 2036, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'P10 A', N'????????????', 52, 2037, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'P10 A', N'Artifact-reduced standard panoramic exposure of a child', 52, 2038, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'P10 A', N'Artifact-reduced standard panoramic exposure of a child', 52, 2039, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'P10 A', N'Artefaktreduzierte Kinder Standard-Panoramaaufnahme', 52, 2040, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'P10 A', N'Artefaktreduzierte Kinder Standard-Panoramaaufnahme', 52, 2041, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'P10 A', N'Artifact-reduced standard panoramic exposure of a child', 52, 2042, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'P10 A', N'Artifact-reduced standard panoramic exposure of a child', 52, 2043, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'P10 A', N'Radiografía panorámica estándar pediátrica con reducción de artefactos', 52, 2044, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'P10 A', N'Radiografía panorámica estándar pediátrica con reducción de artefactos', 52, 2045, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'P10 A', N'Radiographie panoramique standard enfants, avec réduction des artefacts', 52, 2046, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'P10 A', N'Radiographie panoramique standard enfants, avec réduction des artefacts', 52, 2047, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'P10 A', N'Artifact-reduced standard panoramic exposure of a child', 52, 2048, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'P10 A', N'Artifact-reduced standard panoramic exposure of a child', 52, 2049, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'P10 A', N'Radiografia panoramica standard per bambini con riduzione degli artefatti', 52, 2050, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'P10 A', N'Radiografia panoramica standard per bambini con riduzione degli artefatti', 52, 2051, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'P10 A', N'?????????????????????', 52, 2052, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'P10 A', N'?????????????????????', 52, 2053, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'P10 A', N'????? ??? ??? ?? ???? ??', 52, 2054, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'P10 A', N'????? ??? ??? ?? ???? ??', 52, 2055, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'P10 A', N'Artefactgereduceerde standaard panorama-opname voor kinderen', 52, 2056, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'P10 A', N'Artefactgereduceerde standaard panorama-opname voor kinderen', 52, 2057, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'P10 A', N'Normalt panoramaopptak av barn med færre artefakter', 52, 2058, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'P10 A', N'Normalt panoramaopptak av barn med færre artefakter', 52, 2059, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'P10 A', N'Normalt panoramaopptak av barn med færre artefakter', 52, 2060, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'P10 A', N'Artifact-reduced standard panoramic exposure of a child', 52, 2061, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'P10 A', N'Artifact-reduced standard panoramic exposure of a child', 52, 2062, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'P10 A', N'Imagem normal panorâmica de criança com redução de artefactos', 52, 2063, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'P10 A', N'Imagem normal panorâmica de criança com redução de artefactos', 52, 2064, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'P10 A', N'??????????? ?????????? ?????????????? ? ??????????? ??????????, ???????', 52, 2065, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'P10 A', N'??????????? ?????????? ?????????????? ? ??????????? ??????????, ???????', 52, 2066, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'P10 A', N'Artefaktreducerad barn standard panoramabild', 52, 2067, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'P10 A', N'Artefaktreducerad barn standard panoramabild', 52, 2068, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'P10 A', N'?????????????', 52, 2069, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'P10 A', N'?????????????', 52, 2070, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'P10 A', N'?????????????', 52, 2071, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'P10 C', N'????????????,????1.25?', 53, 2072, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'P10 C', N'????????????,????1.25?', 53, 2073, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'P10 C', N'????????????,????1.25?', 53, 2074, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'P10 C', N'????????????,????1.25?', 53, 2075, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'P10 C', N'Constantly magnified standard panoramic exposure of a child with 1.25-fold magnification', 53, 2076, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'P10 C', N'Constantly magnified standard panoramic exposure of a child with 1.25-fold magnification', 53, 2077, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'P10 C', N'Konstant vergrößerte Kinder Standard-Panoramaaufnahme mit konstanter Vergrößerung (1,25-fach)', 53, 2078, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'P10 C', N'Konstant vergrößerte Kinder Standard-Panoramaaufnahme mit konstanter Vergrößerung (1,25-fach)', 53, 2079, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'P10 C', N'Constantly magnified standard panoramic exposure of a child with 1.25-fold magnification', 53, 2080, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'P10 C', N'Constantly magnified standard panoramic exposure of a child with 1.25-fold magnification', 53, 2081, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'P10 C', N'Radiografía panorámica estándar pediátrica con ampliación constante (factor 1,25)', 53, 2082, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'P10 C', N'Radiografía panorámica estándar pediátrica con ampliación constante (factor 1,25)', 53, 2083, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'P10 C', N'Radiographie panoramique standard enfants, avec grossissement constant de 1,25', 53, 2084, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'P10 C', N'Radiographie panoramique standard enfants, avec grossissement constant de 1,25', 53, 2085, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'P10 C', N'Constantly magnified standard panoramic exposure of a child with 1.25-fold magnification', 53, 2086, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'P10 C', N'Constantly magnified standard panoramic exposure of a child with 1.25-fold magnification', 53, 2087, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'P10 C', N'Radiografia panoramica standard per bambini con ingrandimento costante (di 1,25 volte)', 53, 2088, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'P10 C', N'Radiografia panoramica standard per bambini con ingrandimento costante (di 1,25 volte)', 53, 2089, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'P10 C', N'???1.25???????????????????', 53, 2090, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'P10 C', N'???1.25???????????????????', 53, 2091, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'P10 C', N'1.25? ??? ???? ??? ??? ?? ???? ??', 53, 2092, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'P10 C', N'1.25? ??? ???? ??? ??? ?? ???? ??', 53, 2093, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'P10 C', N'Constant vergrote standaard panorama-opname voor kinderen  (1,25-voudige vergroting)', 53, 2094, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'P10 C', N'Constant vergrote standaard panorama-opname voor kinderen  (1,25-voudige vergroting)', 53, 2095, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'P10 C', N'Normalt panoramaopptak av barn konstant forstørret 1,25 ganger', 53, 2096, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'P10 C', N'Normalt panoramaopptak av barn konstant forstørret 1,25 ganger', 53, 2097, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'P10 C', N'Normalt panoramaopptak av barn konstant forstørret 1,25 ganger', 53, 2098, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'P10 C', N'Constantly magnified standard panoramic exposure of a child with 1.25-fold magnification', 53, 2099, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'P10 C', N'Constantly magnified standard panoramic exposure of a child with 1.25-fold magnification', 53, 2100, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'P10 C', N'Imagem normal panorâmica de criança de ampliação constante, com ampliação de 1,25 x', 53, 2101, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'P10 C', N'Imagem normal panorâmica de criança de ampliação constante, com ampliação de 1,25 x', 53, 2102, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'P10 C', N'??????????? ?????????? ?????????????? ? ?????????? 1,25-??????? ???????????, ???????', 53, 2103, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'P10 C', N'??????????? ?????????? ?????????????? ? ?????????? 1,25-??????? ???????????, ???????', 53, 2104, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'P10 C', N'Konstant förstorad barn standard panoramabild med konstant förstoring (1,25 x)', 53, 2105, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'P10 C', N'Konstant förstorad barn standard panoramabild med konstant förstoring (1,25 x)', 53, 2106, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'P10 C', N'1.25 ??????????????', 53, 2107, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'P10 C', N'1.25 ??????????????', 53, 2108, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'P10 C', N'1.25 ??????????????', 53, 2109, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'P12', N'???????', 54, 2110, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'P12', N'???????', 54, 2111, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'P12', N'???????', 54, 2112, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'P12', N'???????', 54, 2113, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'P12', N'Thick-film exposure in anterior tooth region', 54, 2114, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'P12', N'Thick-film exposure in anterior tooth region', 54, 2115, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'P12', N'Dickschichtaufnahme im Frontzahnbereich', 54, 2116, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'P12', N'Dickschichtaufnahme im Frontzahnbereich', 54, 2117, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'P12', N'Thick-film exposure in anterior tooth region', 54, 2118, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'P12', N'Thick-film exposure in anterior tooth region', 54, 2119, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'P12', N'Zonografía de la región de los incisivos', 54, 2120, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'P12', N'Zonografía de la región de los incisivos', 54, 2121, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'P12', N'Coupe épaisse dans le bloc antérieur', 54, 2122, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'P12', N'Coupe épaisse dans le bloc antérieur', 54, 2123, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'P12', N'Thick-film exposure in anterior tooth region', 54, 2124, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'P12', N'Thick-film exposure in anterior tooth region', 54, 2125, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'P12', N'Zonografia nell''area dei denti frontali', 54, 2126, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'P12', N'Zonografia nell''area dei denti frontali', 54, 2127, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'P12', N'?????????', 54, 2128, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'P12', N'?????????', 54, 2129, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'P12', N'?? ??? ?? ??', 54, 2130, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'P12', N'?? ??? ?? ??', 54, 2131, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'P12', N'Weergave van het bereik van de voortanden met grote laagdikte', 54, 2132, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'P12', N'Weergave van het bereik van de voortanden met grote laagdikte', 54, 2133, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'P12', N'Opptak av fortannområde med stor lagtykkelse', 54, 2134, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'P12', N'Opptak av fortannområde med stor lagtykkelse', 54, 2135, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'P12', N'Opptak av fortannområde med stor lagtykkelse', 54, 2136, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'P12', N'Thick-film exposure in anterior tooth region', 54, 2137, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'P12', N'Thick-film exposure in anterior tooth region', 54, 2138, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'P12', N'Apresentação da área de dentes frontais com espessura maior da camada', 54, 2139, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'P12', N'Apresentação da área de dentes frontais com espessura maior da camada', 54, 2140, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'P12', N'?????????????? ???????? ???? ? ??????? ??????????? ?????', 54, 2141, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'P12', N'?????????????? ???????? ???? ? ??????? ??????????? ?????', 54, 2142, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'P12', N'Tjockskiktbild i framtandsområdet', 54, 2143, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'P12', N'Tjockskiktbild i framtandsområdet', 54, 2144, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'P12', N'??????????', 54, 2145, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'P12', N'??????????', 54, 2146, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'P12', N'??????????', 54, 2147, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'BW1', N'??????', 55, 2148, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'BW1', N'??????', 55, 2149, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'BW1', N'??????', 55, 2150, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'BW1', N'??????', 55, 2151, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'BW1', N'Bite wing exposure in posterior tooth region', 55, 2152, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'BW1', N'Bite wing exposure in posterior tooth region', 55, 2153, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'BW1', N'Bissflügelaufnahme im Seitenzahnbereich', 55, 2154, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'BW1', N'Bissflügelaufnahme im Seitenzahnbereich', 55, 2155, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'BW1', N'Bite wing exposure in posterior tooth region', 55, 2156, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'BW1', N'Bite wing exposure in posterior tooth region', 55, 2157, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'BW1', N'Radiografía con ala de mordida de la región de los dientes posteriores', 55, 2158, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'BW1', N'Radiografía con ala de mordida de la región de los dientes posteriores', 55, 2159, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'BW1', N'Radiographie interproximale du secteur dentaire latéral', 55, 2160, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'BW1', N'Radiographie interproximale du secteur dentaire latéral', 55, 2161, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'BW1', N'Bite wing exposure in posterior tooth region', 55, 2162, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'BW1', N'Bite wing exposure in posterior tooth region', 55, 2163, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'BW1', N'Radiografia bite-wing nell''area dei denti laterali', 55, 2164, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'BW1', N'Radiografia bite-wing nell''area dei denti laterali', 55, 2165, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'BW1', N'??????????????', 55, 2166, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'BW1', N'??????????????', 55, 2167, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'BW1', N'?? ??? ?? ??', 55, 2168, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'BW1', N'?? ??? ?? ??', 55, 2169, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'BW1', N'Bijtstukopname in het bereik van de zijtanden', 55, 2170, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'BW1', N'Bijtstukopname in het bereik van de zijtanden', 55, 2171, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'BW1', N'Bite-wing-opptak i sidetannområdet', 55, 2172, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'BW1', N'Bite-wing-opptak i sidetannområdet', 55, 2173, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'BW1', N'Bite-wing-opptak i sidetannområdet', 55, 2174, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'BW1', N'Bite wing exposure in posterior tooth region', 55, 2175, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'BW1', N'Bite wing exposure in posterior tooth region', 55, 2176, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'BW1', N'Imagem da asa de mordente na área de dentes laterais', 55, 2177, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'BW1', N'Imagem da asa de mordente na área de dentes laterais', 55, 2178, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'BW1', N'?????? ???????? ??????? ? ??????? ??????? ?????', 55, 2179, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'BW1', N'?????? ???????? ??????? ? ??????? ??????? ?????', 55, 2180, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'BW1', N'Bitvingebild i kindtandsområdet', 55, 2181, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'BW1', N'Bitvingebild i kindtandsområdet', 55, 2182, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'BW1', N'?????????', 55, 2183, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'BW1', N'?????????', 55, 2184, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'BW1', N'?????????', 55, 2185, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'BW2', N'??????', 56, 2186, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'BW2', N'??????', 56, 2187, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'BW2', N'??????', 56, 2188, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'BW2', N'??????', 56, 2189, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'BW2', N'Bite wing exposure in anterior tooth region', 56, 2190, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'BW2', N'Bite wing exposure in anterior tooth region', 56, 2191, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'BW2', N'Bissflügelaufnahme im Frontzahnbereich', 56, 2192, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'BW2', N'Bissflügelaufnahme im Frontzahnbereich', 56, 2193, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'BW2', N'Bite wing exposure in anterior tooth region', 56, 2194, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'BW2', N'Bite wing exposure in anterior tooth region', 56, 2195, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'BW2', N'Radiografía con ala de mordida de la región de los incisivos', 56, 2196, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'BW2', N'Radiografía con ala de mordida de la región de los incisivos', 56, 2197, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'BW2', N'Radiographie interproximale du bloc antérieur', 56, 2198, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'BW2', N'Radiographie interproximale du bloc antérieur', 56, 2199, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'BW2', N'Bite wing exposure in anterior tooth region', 56, 2200, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'BW2', N'Bite wing exposure in anterior tooth region', 56, 2201, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'BW2', N'Radiografia bite-wing nell''area dei denti frontali', 56, 2202, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'BW2', N'Radiografia bite-wing nell''area dei denti frontali', 56, 2203, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'BW2', N'??????????????', 56, 2204, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'BW2', N'??????????????', 56, 2205, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'BW2', N'?? ??? ?? ??', 56, 2206, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'BW2', N'?? ??? ?? ??', 56, 2207, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'BW2', N'Bijstukopname in het bereik van de voortanden', 56, 2208, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'BW2', N'Bijstukopname in het bereik van de voortanden', 56, 2209, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'BW2', N'Bite-wing-opptak i fortannområdet', 56, 2210, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'BW2', N'Bite-wing-opptak i fortannområdet', 56, 2211, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'BW2', N'Bite-wing-opptak i fortannområdet', 56, 2212, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'BW2', N'Bite wing exposure in anterior tooth region', 56, 2213, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'BW2', N'Bite wing exposure in anterior tooth region', 56, 2214, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'BW2', N'Imagem da asa de mordente na área de dentes frontais', 56, 2215, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'BW2', N'Imagem da asa de mordente na área de dentes frontais', 56, 2216, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'BW2', N'?????? ???????? ??????? ? ??????? ??????????? ?????', 56, 2217, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'BW2', N'?????? ???????? ??????? ? ??????? ??????????? ?????', 56, 2218, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'BW2', N'Bitvingebild i framtandsområdet', 56, 2219, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'BW2', N'Bitvingebild i framtandsområdet', 56, 2220, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'BW2', N'?????????', 56, 2221, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'BW2', N'?????????', 56, 2222, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'BW2', N'?????????', 56, 2223, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'TM1.1', N'????????????,??2?', 57, 2224, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'TM1.1', N'????????????,??2?', 57, 2225, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'TM1.1', N'????????????,??2?', 57, 2226, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'TM1.1', N'????????????,??2?', 57, 2227, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'TM1.1', N'2-x lateral temporomandibular joint exposure with open and closed mouth', 57, 2228, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'TM1.1', N'2-x lateral temporomandibular joint exposure with open and closed mouth', 57, 2229, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'TM1.1', N'2-Fach laterale Kiefergelenkaufnahme bei geschlossenem und geöffneten Mund', 57, 2230, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'TM1.1', N'2-Fach laterale Kiefergelenkaufnahme bei geschlossenem und geöffneten Mund', 57, 2231, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'TM1.1', N'2-x lateral temporomandibular joint exposure with open and closed mouth', 57, 2232, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'TM1.1', N'2-x lateral temporomandibular joint exposure with open and closed mouth', 57, 2233, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'TM1.1', N'Radiografía lateral doble de la articulación temporomaxilar con la boca abierta y cerrada', 57, 2234, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'TM1.1', N'Radiografía lateral doble de la articulación temporomaxilar con la boca abierta y cerrada', 57, 2235, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'TM1.1', N'Radiographie latérale double des ATM, bouche ouverte et fermée', 57, 2236, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'TM1.1', N'Radiographie latérale double des ATM, bouche ouverte et fermée', 57, 2237, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'TM1.1', N'2-x lateral temporomandibular joint exposure with open and closed mouth', 57, 2238, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'TM1.1', N'2-x lateral temporomandibular joint exposure with open and closed mouth', 57, 2239, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'TM1.1', N'Radiografia doppia dell''articolazione temporomandibolare laterale con bocca aperta e chiusa', 57, 2240, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'TM1.1', N'Radiografia doppia dell''articolazione temporomandibolare laterale con bocca aperta e chiusa', 57, 2241, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'TM1.1', N'?????????(?????????)', 57, 2242, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'TM1.1', N'?????????(?????????)', 57, 2243, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'TM1.1', N'?? ?? ??? ?? ???? ?? ??? 2? ??', 57, 2244, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'TM1.1', N'?? ?? ??? ?? ???? ?? ??? 2? ??', 57, 2245, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'TM1.1', N'2-voudige laterale opname van kaakgewricht bij gesloten en geopende mond', 57, 2246, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'TM1.1', N'2-voudige laterale opname van kaakgewricht bij gesloten en geopende mond', 57, 2247, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'TM1.1', N'Opptak av kjeveleddene med åpen/lukket munn (2 lag)', 57, 2248, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'TM1.1', N'Opptak av kjeveleddene med åpen/lukket munn (2 lag)', 57, 2249, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'TM1.1', N'Opptak av kjeveleddene med åpen/lukket munn (2 lag)', 57, 2250, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'TM1.1', N'2-x lateral temporomandibular joint exposure with open and closed mouth', 57, 2251, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'TM1.1', N'2-x lateral temporomandibular joint exposure with open and closed mouth', 57, 2252, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'TM1.1', N'Imagem das articulações temporomandibulares com boca aberta e fechada', 57, 2253, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'TM1.1', N'Imagem das articulações temporomandibulares com boca aberta e fechada', 57, 2254, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'TM1.1', N'2-??????? ??????? ?????????????? ???? ? ???????? ? ???????? ????', 57, 2255, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'TM1.1', N'2-??????? ??????? ?????????????? ???? ? ???????? ? ???????? ????', 57, 2256, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'TM1.1', N'2-faldig lateral käkledsbild med stängd och öppen mun', 57, 2257, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'TM1.1', N'2-faldig lateral käkledsbild med stängd och öppen mun', 57, 2258, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'TM1.1', N'2 ?????????,???', 57, 2259, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'TM1.1', N'2 ?????????,???', 57, 2260, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'TM1.1', N'2 ?????????,???', 57, 2261, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'TM1A.1', N'????????????,????,??2?', 58, 2262, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'TM1A.1', N'????????????,????,??2?', 58, 2263, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'TM1A.1', N'????????????,????,??2?', 58, 2264, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'TM1A.1', N'????????????,????,??2?', 58, 2265, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'TM1A.1', N'Artifact-reduced 2-x lateral temporomandibular joint exposure with open and closed mouth', 58, 2266, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'TM1A.1', N'Artifact-reduced 2-x lateral temporomandibular joint exposure with open and closed mouth', 58, 2267, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'TM1A.1', N'Artefaktreduzierte 2-fach laterale Kiefergelenkaufnahme bei geschlossenem und geöffneten Mund', 58, 2268, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'TM1A.1', N'Artefaktreduzierte 2-fach laterale Kiefergelenkaufnahme bei geschlossenem und geöffneten Mund', 58, 2269, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'TM1A.1', N'Artifact-reduced 2-x lateral temporomandibular joint exposure with open and closed mouth', 58, 2270, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'TM1A.1', N'Artifact-reduced 2-x lateral temporomandibular joint exposure with open and closed mouth', 58, 2271, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'TM1A.1', N'Radiografía lateral doble de la articulación temporomaxilar con reducción de artefactos con la boca abierta y cerrada', 58, 2272, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'TM1A.1', N'Radiografía lateral doble de la articulación temporomaxilar con reducción de artefactos con la boca abierta y cerrada', 58, 2273, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'TM1A.1', N'Radiographie latérale double des ATM, avec réduction des artefacts, bouche ouverte et fermée', 58, 2274, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'TM1A.1', N'Radiographie latérale double des ATM, avec réduction des artefacts, bouche ouverte et fermée', 58, 2275, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'TM1A.1', N'Artifact-reduced 2-x lateral temporomandibular joint exposure with open and closed mouth', 58, 2276, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'TM1A.1', N'Artifact-reduced 2-x lateral temporomandibular joint exposure with open and closed mouth', 58, 2277, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'TM1A.1', N'Radiografia doppia dell''articolazione termporomandibolare laterale con riduzione degli artefatti con bocca aperta e chiusa', 58, 2278, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'TM1A.1', N'Radiografia doppia dell''articolazione termporomandibolare laterale con riduzione degli artefatti con bocca aperta e chiusa', 58, 2279, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'TM1A.1', N'??????????????????(?????????)', 58, 2280, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'TM1A.1', N'??????????????????(?????????)', 58, 2281, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'TM1A.1', N'?? ?? ??? ?? ???? ????? ??? ?? ??? 2? ??', 58, 2282, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'TM1A.1', N'?? ?? ??? ?? ???? ????? ??? ?? ??? 2? ??', 58, 2283, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'TM1A.1', N'Artefactgereduceerde 2-voudige laterale opname van het kaakgewricht bij gesloten en geopende mond', 58, 2284, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'TM1A.1', N'Artefactgereduceerde 2-voudige laterale opname van het kaakgewricht bij gesloten en geopende mond', 58, 2285, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'TM1A.1', N'Opptak av kjeveleddene med færre artefakter og åpen/lukket munn (2 lag)', 58, 2286, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'TM1A.1', N'Opptak av kjeveleddene med færre artefakter og åpen/lukket munn (2 lag)', 58, 2287, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'TM1A.1', N'Opptak av kjeveleddene med færre artefakter og åpen/lukket munn (2 lag)', 58, 2288, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'TM1A.1', N'Artifact-reduced 2-x lateral temporomandibular joint exposure with open and closed mouth', 58, 2289, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'TM1A.1', N'Artifact-reduced 2-x lateral temporomandibular joint exposure with open and closed mouth', 58, 2290, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'TM1A.1', N'Imagem das articulações temporomandibulares com redução de artefactos, com boca aberta e fechada', 58, 2291, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'TM1A.1', N'Imagem das articulações temporomandibulares com redução de artefactos, com boca aberta e fechada', 58, 2292, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'TM1A.1', N'2-??????? ??????? ?????????????? ???? ? ??????????? ?????????? ? ???????? ? ???????? ????', 58, 2293, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'TM1A.1', N'2-??????? ??????? ?????????????? ???? ? ??????????? ?????????? ? ???????? ? ???????? ????', 58, 2294, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'TM1A.1', N'Artefaktreducerad 2-faldig lateral käkledsbild med stängd och öppen mun', 58, 2295, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'TM1A.1', N'Artefaktreducerad 2-faldig lateral käkledsbild med stängd och öppen mun', 58, 2296, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'TM1A.1', N'????? 2 ?????????,???', 58, 2297, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'TM1A.1', N'????? 2 ?????????,???', 58, 2298, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'TM1A.1', N'????? 2 ?????????,???', 58, 2299, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'TM2.1', N'????????????,??2?', 59, 2300, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'TM2.1', N'????????????,??2?', 59, 2301, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'TM2.1', N'????????????,??2?', 59, 2302, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'TM2.1', N'????????????,??2?', 59, 2303, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'TM2.1', N'2-x axial temporomandibular joint exposure with open and closed mouth', 59, 2304, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'TM2.1', N'2-x axial temporomandibular joint exposure with open and closed mouth', 59, 2305, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'TM2.1', N'2-Fach axiale Kiefergelenkaufnahme bei geschlossenem und geöffneten Mund', 59, 2306, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'TM2.1', N'2-Fach axiale Kiefergelenkaufnahme bei geschlossenem und geöffneten Mund', 59, 2307, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'TM2.1', N'2-x axial temporomandibular joint exposure with open and closed mouth', 59, 2308, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'TM2.1', N'2-x axial temporomandibular joint exposure with open and closed mouth', 59, 2309, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'TM2.1', N'Radiografía axial doble de la articulación temporomaxilar con la boca abierta y cerrada', 59, 2310, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'TM2.1', N'Radiografía axial doble de la articulación temporomaxilar con la boca abierta y cerrada', 59, 2311, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'TM2.1', N'Radiographie axiale double des ATM, bouche ouverte et fermée', 59, 2312, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'TM2.1', N'Radiographie axiale double des ATM, bouche ouverte et fermée', 59, 2313, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'TM2.1', N'2-x axial temporomandibular joint exposure with open and closed mouth', 59, 2314, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'TM2.1', N'2-x axial temporomandibular joint exposure with open and closed mouth', 59, 2315, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'TM2.1', N'Radiografia doppia dell''articolazione termporomandibolare assiale con bocca aperta e chiusa', 59, 2316, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'TM2.1', N'Radiografia doppia dell''articolazione termporomandibolare assiale con bocca aperta e chiusa', 59, 2317, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'TM2.1', N'??????????(?????????)', 59, 2318, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'TM2.1', N'??????????(?????????)', 59, 2319, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'TM2.1', N'?? ?? ??? ?? ???? ??? ??? 2? ??', 59, 2320, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'TM2.1', N'?? ?? ??? ?? ???? ??? ??? 2? ??', 59, 2321, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'TM2.1', N'2-voudige axiale opname van het kaakgewricht bij gesloten en geopende mond', 59, 2322, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'TM2.1', N'2-voudige axiale opname van het kaakgewricht bij gesloten en geopende mond', 59, 2323, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'TM2.1', N'To-lag axiale gjennomstrålingsopptak med lukket og åpen munn.', 59, 2324, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'TM2.1', N'To-lag axiale gjennomstrålingsopptak med lukket og åpen munn.', 59, 2325, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'TM2.1', N'To-lag axiale gjennomstrålingsopptak med lukket og åpen munn.', 59, 2326, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'TM2.1', N'2-x axial temporomandibular joint exposure with open and closed mouth', 59, 2327, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'TM2.1', N'2-x axial temporomandibular joint exposure with open and closed mouth', 59, 2328, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'TM2.1', N'Imagem das articulações temporomandibulares em projeção posterior - anterior com boca aberta e fechada', 59, 2329, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'TM2.1', N'Imagem das articulações temporomandibulares em projeção posterior - anterior com boca aberta e fechada', 59, 2330, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'TM2.1', N'2-??????? ?????????? ?????????????? ???? ? ???????? ? ???????? ????', 59, 2331, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'TM2.1', N'2-??????? ?????????? ?????????????? ???? ? ???????? ? ???????? ????', 59, 2332, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'TM2.1', N'2-faldig axial käkledsbild med stängd och öppen mun', 59, 2333, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'TM2.1', N'2-faldig axial käkledsbild med stängd och öppen mun', 59, 2334, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'TM2.1', N'2 ?????????,???', 59, 2335, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'TM2.1', N'2 ?????????,???', 59, 2336, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'TM2.1', N'2 ?????????,???', 59, 2337, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'TM2A.1', N'????????????,????,??2?', 60, 2338, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'TM2A.1', N'????????????,????,??2?', 60, 2339, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'TM2A.1', N'????????????,????,??2?', 60, 2340, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'TM2A.1', N'????????????,????,??2?', 60, 2341, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'TM2A.1', N'Artifact-reduced 2-x axial temporomandibular joint exposure with open and closed mouth', 60, 2342, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'TM2A.1', N'Artifact-reduced 2-x axial temporomandibular joint exposure with open and closed mouth', 60, 2343, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'TM2A.1', N'Artefaktreduzierte 2-fach axiale Kiefergelenkaufnahme bei geschlossenem und geöffneten Mund', 60, 2344, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'TM2A.1', N'Artefaktreduzierte 2-fach axiale Kiefergelenkaufnahme bei geschlossenem und geöffneten Mund', 60, 2345, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'TM2A.1', N'Artifact-reduced 2-x axial temporomandibular joint exposure with open and closed mouth', 60, 2346, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'TM2A.1', N'Artifact-reduced 2-x axial temporomandibular joint exposure with open and closed mouth', 60, 2347, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'TM2A.1', N'Radiografía axial doble de la articulación temporomaxilar con reducción de artefactos con la boca abierta y cerrada', 60, 2348, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'TM2A.1', N'Radiografía axial doble de la articulación temporomaxilar con reducción de artefactos con la boca abierta y cerrada', 60, 2349, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'TM2A.1', N'Radiographie axiale double des ATM, avec réduction des artefacts, bouche ouverte et fermée', 60, 2350, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'TM2A.1', N'Radiographie axiale double des ATM, avec réduction des artefacts, bouche ouverte et fermée', 60, 2351, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'TM2A.1', N'Artifact-reduced 2-x axial temporomandibular joint exposure with open and closed mouth', 60, 2352, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'TM2A.1', N'Artifact-reduced 2-x axial temporomandibular joint exposure with open and closed mouth', 60, 2353, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'TM2A.1', N'Radiografia doppia dell''articolazione termporomandibolare assiale con riduzione degli artefatti con bocca aperta e chiusa', 60, 2354, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'TM2A.1', N'Radiografia doppia dell''articolazione termporomandibolare assiale con riduzione degli artefatti con bocca aperta e chiusa', 60, 2355, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'TM2A.1', N'???????????????????(?????????)', 60, 2356, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'TM2A.1', N'???????????????????(?????????)', 60, 2357, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'TM2A.1', N'?? ?? ??? ?? ???? ????? ??? ??? ??? 2? ??', 60, 2358, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'TM2A.1', N'?? ?? ??? ?? ???? ????? ??? ??? ??? 2? ??', 60, 2359, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'TM2A.1', N'Artefactgereduceerde 2-voudige axiale opname van het kaakgewricht bij gesloten en geopende mond', 60, 2360, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'TM2A.1', N'Artefactgereduceerde 2-voudige axiale opname van het kaakgewricht bij gesloten en geopende mond', 60, 2361, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'TM2A.1', N'To-lag axiale gjennomstrålingsopptak med færre artefakter og åpen/lukket munn', 60, 2362, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'TM2A.1', N'To-lag axiale gjennomstrålingsopptak med færre artefakter og åpen/lukket munn', 60, 2363, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'TM2A.1', N'To-lag axiale gjennomstrålingsopptak med færre artefakter og åpen/lukket munn', 60, 2364, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'TM2A.1', N'Artifact-reduced 2-x axial temporomandibular joint exposure with open and closed mouth', 60, 2365, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'TM2A.1', N'Artifact-reduced 2-x axial temporomandibular joint exposure with open and closed mouth', 60, 2366, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'TM2A.1', N'Imagem das articulações temporomandibulares em projeção posterior - anterior, com redução de artefactos, com boca aberta e fechada', 60, 2367, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'TM2A.1', N'Imagem das articulações temporomandibulares em projeção posterior - anterior, com redução de artefactos, com boca aberta e fechada', 60, 2368, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'TM2A.1', N'2-??????? ?????????? ?????????????? ???? ? ??????????? ?????????? ? ???????? ? ???????? ????', 60, 2369, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'TM2A.1', N'2-??????? ?????????? ?????????????? ???? ? ??????????? ?????????? ? ???????? ? ???????? ????', 60, 2370, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'TM2A.1', N'Artefaktreducerad 2-faldig axial käkledsbild med stängd och öppen mun', 60, 2371, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'TM2A.1', N'Artefaktreducerad 2-faldig axial käkledsbild med stängd och öppen mun', 60, 2372, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'TM2A.1', N'????? 2 ?????????,???', 60, 2373, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'TM2A.1', N'????? 2 ?????????,???', 60, 2374, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'TM2A.1', N'????? 2 ?????????,???', 60, 2375, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'TM3', N'???????', 61, 2376, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'TM3', N'???????', 61, 2377, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'TM3', N'???????', 61, 2378, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'TM3', N'???????', 61, 2379, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'TM3', N'Lateral temporomandibular joint exposure', 61, 2380, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'TM3', N'Lateral temporomandibular joint exposure', 61, 2381, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'TM3', N'Laterale Kiefergelenkaufnahme', 61, 2382, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'TM3', N'Laterale Kiefergelenkaufnahme', 61, 2383, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'TM3', N'Lateral temporomandibular joint exposure', 61, 2384, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'TM3', N'Lateral temporomandibular joint exposure', 61, 2385, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'TM3', N'Radiografía lateral de la articulación temporomaxilar', 61, 2386, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'TM3', N'Radiografía lateral de la articulación temporomaxilar', 61, 2387, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'TM3', N'Radiographie latérale des ATM', 61, 2388, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'TM3', N'Radiographie latérale des ATM', 61, 2389, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'TM3', N'Lateral temporomandibular joint exposure', 61, 2390, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'TM3', N'Lateral temporomandibular joint exposure', 61, 2391, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'TM3', N'Radiografia dell''articolazione temporomandibolare laterale', 61, 2392, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'TM3', N'Radiografia dell''articolazione temporomandibolare laterale', 61, 2393, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'TM3', N'???????', 61, 2394, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'TM3', N'???????', 61, 2395, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'TM3', N'?? ??? ??', 61, 2396, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'TM3', N'?? ??? ??', 61, 2397, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'TM3', N'Laterale opname van het kaakgewricht', 61, 2398, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'TM3', N'Laterale opname van het kaakgewricht', 61, 2399, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'TM3', N'Kjeveledd lateralt opptak', 61, 2400, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'TM3', N'Kjeveledd lateralt opptak', 61, 2401, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'TM3', N'Kjeveledd lateralt opptak', 61, 2402, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'TM3', N'Lateral temporomandibular joint exposure', 61, 2403, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'TM3', N'Lateral temporomandibular joint exposure', 61, 2404, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'TM3', N'Articulações temporomandibulares lateral (ramificações ascendentes)', 61, 2405, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'TM3', N'Articulações temporomandibulares lateral (ramificações ascendentes)', 61, 2406, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'TM3', N'??????? ?????????????? ????', 61, 2407, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'TM3', N'??????? ?????????????? ????', 61, 2408, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'TM3', N'Lateral käkledsbild', 61, 2409, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'TM3', N'Lateral käkledsbild', 61, 2410, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'TM3', N'????????', 61, 2411, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'TM3', N'????????', 61, 2412, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'TM3', N'????????', 61, 2413, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'TM4', N'???????', 62, 2414, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'TM4', N'???????', 62, 2415, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'TM4', N'???????', 62, 2416, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'TM4', N'???????', 62, 2417, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'TM4', N'Axial temporomandibular joint exposure', 62, 2418, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'TM4', N'Axial temporomandibular joint exposure', 62, 2419, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'TM4', N'Axiale Kiefergelenkaufnahme', 62, 2420, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'TM4', N'Axiale Kiefergelenkaufnahme', 62, 2421, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'TM4', N'Axial temporomandibular joint exposure', 62, 2422, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'TM4', N'Axial temporomandibular joint exposure', 62, 2423, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'TM4', N'Radiografía axial de la articulación temporomaxilar', 62, 2424, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'TM4', N'Radiografía axial de la articulación temporomaxilar', 62, 2425, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'TM4', N'Radiographie axiale des ATM', 62, 2426, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'TM4', N'Radiographie axiale des ATM', 62, 2427, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'TM4', N'Axial temporomandibular joint exposure', 62, 2428, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'TM4', N'Axial temporomandibular joint exposure', 62, 2429, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'TM4', N'Radiografia dell''articolazione temporomandibolare assiale', 62, 2430, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'TM4', N'Radiografia dell''articolazione temporomandibolare assiale', 62, 2431, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'TM4', N'????????', 62, 2432, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'TM4', N'????????', 62, 2433, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'TM4', N'??? ??? ??', 62, 2434, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'TM4', N'??? ??? ??', 62, 2435, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'TM4', N'Axiale opname van het kaakgewricht', 62, 2436, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'TM4', N'Axiale opname van het kaakgewricht', 62, 2437, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'TM4', N'Kjeveledd axialt opptak', 62, 2438, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'TM4', N'Kjeveledd axialt opptak', 62, 2439, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'TM4', N'Kjeveledd axialt opptak', 62, 2440, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'TM4', N'Axial temporomandibular joint exposure', 62, 2441, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'TM4', N'Axial temporomandibular joint exposure', 62, 2442, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'TM4', N'Articulações temporomandibulares posterior - anterior', 62, 2443, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'TM4', N'Articulações temporomandibulares posterior - anterior', 62, 2444, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'TM4', N'?????????? ?????????????? ????', 62, 2445, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'TM4', N'?????????? ?????????????? ????', 62, 2446, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'TM4', N'Axial käkledsbild', 62, 2447, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'TM4', N'Axial käkledsbild', 62, 2448, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'TM4', N'????????', 62, 2449, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'TM4', N'????????', 62, 2450, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'TM4', N'????????', 62, 2451, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'TM5', N'??,???????(????????)', 63, 2452, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'TM5', N'??,???????(????????)', 63, 2453, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'TM5', N'??,???????(????????)', 63, 2454, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'TM5', N'??,???????(????????)', 63, 2455, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'TM5', N'Multislicing, lateral temporomandibular joint (6 views in one image)', 63, 2456, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'TM5', N'Multislicing, lateral temporomandibular joint (6 views in one image)', 63, 2457, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'TM5', N'Multischichtung, Kiefergelenk lateral (6-fach-Darstellung auf einem Bild)', 63, 2458, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'TM5', N'Multischichtung, Kiefergelenk lateral (6-fach-Darstellung auf einem Bild)', 63, 2459, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'TM5', N'Multislicing, lateral temporomandibular joint (6 views in one image)', 63, 2460, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'TM5', N'Multislicing, lateral temporomandibular joint (6 views in one image)', 63, 2461, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'TM5', N'Multiestrato, articulación temporomaxilar lateral (visualización séxtuple en una imagen)', 63, 2462, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'TM5', N'Multiestrato, articulación temporomaxilar lateral (visualización séxtuple en una imagen)', 63, 2463, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'TM5', N'Tomographie multiplan des ATM en incidence latérale (sextuple représentation sur une image)', 63, 2464, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'TM5', N'Tomographie multiplan des ATM en incidence latérale (sextuple représentation sur une image)', 63, 2465, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'TM5', N'Multislicing, lateral temporomandibular joint (6 views in one image)', 63, 2466, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'TM5', N'Multislicing, lateral temporomandibular joint (6 views in one image)', 63, 2467, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'TM5', N'Multistrato, articolazione temporomandibolare laterale (rappresentazione sestupla su un''immagine)', 63, 2468, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'TM5', N'Multistrato, articolazione temporomandibolare laterale (rappresentazione sestupla su un''immagine)', 63, 2469, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'TM5', N'?????????????(6?????1????)', 63, 2470, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'TM5', N'?????????????(6?????1????)', 63, 2471, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'TM5', N'?? ???, ?? ???(? ???? 6 ??? ??)', 63, 2472, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'TM5', N'?? ???, ?? ???(? ???? 6 ??? ??)', 63, 2473, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'TM5', N'Multilagig, kaakgewricht lateraal (6-voudige weergave op een beeld)', 63, 2474, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'TM5', N'Multilagig, kaakgewricht lateraal (6-voudige weergave op een beeld)', 63, 2475, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'TM5', N'Multilagdeling kjeveledd lateralt (seks lag på ett bilde)', 63, 2476, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'TM5', N'Multilagdeling kjeveledd lateralt (seks lag på ett bilde)', 63, 2477, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'TM5', N'Multilagdeling kjeveledd lateralt (seks lag på ett bilde)', 63, 2478, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'TM5', N'Multislicing, lateral temporomandibular joint (6 views in one image)', 63, 2479, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'TM5', N'Multislicing, lateral temporomandibular joint (6 views in one image)', 63, 2480, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'TM5', N'Fatias múltiplas, articulação temporomandibular lateral (apresentação 6x numa imagem)', 63, 2481, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'TM5', N'Fatias múltiplas, articulação temporomandibular lateral (apresentação 6x numa imagem)', 63, 2482, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'TM5', N'??????????, ???????-?????????????? ??????? ????? (6-??????? ????????????? ?? ????? ??????)', 63, 2483, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'TM5', N'??????????, ???????-?????????????? ??????? ????? (6-??????? ????????????? ?? ????? ??????)', 63, 2484, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'TM5', N'Multiskikt, käkled lateral (6 x på en bild)', 63, 2485, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'TM5', N'Multiskikt, käkled lateral (6 x på en bild)', 63, 2486, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'TM5', N'??,??????(6 ?????)', 63, 2487, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'TM5', N'??,??????(6 ?????)', 63, 2488, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'TM5', N'??,??????(6 ?????)', 63, 2489, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'TM6', N'??,???????,?—?(????????)', 64, 2490, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'TM6', N'??,???????,?—?(????????)', 64, 2491, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'TM6', N'??,???????,?—?(????????)', 64, 2492, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'TM6', N'??,???????,?—?(????????)', 64, 2493, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'TM6', N'Multislicing, posterior/anterior temporomandibular joint (6 views in one image)', 64, 2494, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'TM6', N'Multislicing, posterior/anterior temporomandibular joint (6 views in one image)', 64, 2495, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'TM6', N'Multischichtung Kiefergelenke posterior / anterior (6-fach-Darstellung auf einem Bild)', 64, 2496, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'TM6', N'Multischichtung Kiefergelenke posterior / anterior (6-fach-Darstellung auf einem Bild)', 64, 2497, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'TM6', N'Multislicing, posterior/anterior temporomandibular joint (6 views in one image)', 64, 2498, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'TM6', N'Multislicing, posterior/anterior temporomandibular joint (6 views in one image)', 64, 2499, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'TM6', N'Multiestrato, articulación temporomaxilar posterior/anterior (visualización séxtuple en una imagen)', 64, 2500, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'TM6', N'Multiestrato, articulación temporomaxilar posterior/anterior (visualización séxtuple en una imagen)', 64, 2501, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'TM6', N'Tomographie multiplan des ATM en incidence postéro/antérieure (sextuple représentation sur une image)', 64, 2502, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'TM6', N'Tomographie multiplan des ATM en incidence postéro/antérieure (sextuple représentation sur une image)', 64, 2503, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'TM6', N'Multislicing, posterior/anterior temporomandibular joint (6 views in one image)', 64, 2504, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'TM6', N'Multislicing, posterior/anterior temporomandibular joint (6 views in one image)', 64, 2505, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'TM6', N'Multistrato articolazioni temporomandibolari posteriore / anteriore (rappresentazione sestupla su un''immagine)', 64, 2506, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'TM6', N'Multistrato articolazioni temporomandibolari posteriore / anteriore (rappresentazione sestupla su un''immagine)', 64, 2507, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'TM6', N'????????PA????(6?????1????)', 64, 2508, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'TM6', N'????????PA????(6?????1????)', 64, 2509, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'TM6', N'?? ???, ??/?? ???(? ???? 6 ??? ??)', 64, 2510, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'TM6', N'?? ???, ??/?? ???(? ???? 6 ??? ??)', 64, 2511, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'TM6', N'Multilagig kaakgewricht posterior / anterior (6-voudige weergave op een beeld)', 64, 2512, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'TM6', N'Multilagig kaakgewricht posterior / anterior (6-voudige weergave op een beeld)', 64, 2513, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'TM6', N'Multilagdeling kjeveledd posteriort/anteriort (seks lag på ett bilde)', 64, 2514, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'TM6', N'Multilagdeling kjeveledd posteriort/anteriort (seks lag på ett bilde)', 64, 2515, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'TM6', N'Multilagdeling kjeveledd posteriort/anteriort (seks lag på ett bilde)', 64, 2516, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'TM6', N'Multislicing, posterior/anterior temporomandibular joint (6 views in one image)', 64, 2517, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'TM6', N'Multislicing, posterior/anterior temporomandibular joint (6 views in one image)', 64, 2518, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'TM6', N'Fatias múltiplas, articulação temporomandibular posterior / anterior (apresentação 6x numa imagem)', 64, 2519, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'TM6', N'Fatias múltiplas, articulação temporomandibular posterior / anterior (apresentação 6x numa imagem)', 64, 2520, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'TM6', N'??????????, ???????-?????????????? ??????? ? ?????-???????? ??????????? (6-??????? ????????????? ?? ????? ??????)', 64, 2521, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'TM6', N'??????????, ???????-?????????????? ??????? ? ?????-???????? ??????????? (6-??????? ????????????? ?? ????? ??????)', 64, 2522, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'TM6', N'Multiskikt käkled posterior / anterior (6 x på en bild)', 64, 2523, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'TM6', N'Multiskikt käkled posterior / anterior (6 x på en bild)', 64, 2524, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'TM6', N'??,??????/??(6 ?????)', 64, 2525, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'TM6', N'??,??????/??(6 ?????)', 64, 2526, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'TM6', N'??,??????/??(6 ?????)', 64, 2527, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'S1', N'???', 65, 2528, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'S1', N'???', 65, 2529, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'S1', N'???', 65, 2530, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'S1', N'???', 65, 2531, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'S1', N'Paranasal sinuses', 65, 2532, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'S1', N'Paranasal sinuses', 65, 2533, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'S1', N'Nasennebenhölen', 65, 2534, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'S1', N'Nasennebenhölen', 65, 2535, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'S1', N'Paranasal sinuses', 65, 2536, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'S1', N'Paranasal sinuses', 65, 2537, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'S1', N'Senos paranasales', 65, 2538, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'S1', N'Senos paranasales', 65, 2539, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'S1', N'Cavités sinusales', 65, 2540, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'S1', N'Cavités sinusales', 65, 2541, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'S1', N'Paranasal sinuses', 65, 2542, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'S1', N'Paranasal sinuses', 65, 2543, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'S1', N'Seni paranasali', 65, 2544, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'S1', N'Seni paranasali', 65, 2545, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'S1', N'???', 65, 2546, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'S1', N'???', 65, 2547, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'S1', N'???', 65, 2548, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'S1', N'???', 65, 2549, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'S1', N'Bijholtes van de neus', 65, 2550, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'S1', N'Bijholtes van de neus', 65, 2551, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'S1', N'Sidehuler nese', 65, 2552, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'S1', N'Sidehuler nese', 65, 2553, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'S1', N'Sidehuler nese', 65, 2554, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'S1', N'Paranasal sinuses', 65, 2555, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'S1', N'Paranasal sinuses', 65, 2556, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'S1', N'Seios paranasais', 65, 2557, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'S1', N'Seios paranasais', 65, 2558, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'S1', N'??????????? ?????? ????', 65, 2559, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'S1', N'??????????? ?????? ????', 65, 2560, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'S1', N'Näsans bihålor', 65, 2561, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'S1', N'Näsans bihålor', 65, 2562, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'S1', N'???', 65, 2563, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'S1', N'???', 65, 2564, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'S1', N'???', 65, 2565, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'S2', N'???', 66, 2566, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'S2', N'???', 66, 2567, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'S2', N'???', 66, 2568, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'S2', N'???', 66, 2569, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'S2', N'Maxillary sinuses, (Sinus maxillaris)', 66, 2570, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'S2', N'Maxillary sinuses, (Sinus maxillaris)', 66, 2571, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'S2', N'Kieferhöhlen, Sinus maxillaris', 66, 2572, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'S2', N'Kieferhöhlen, Sinus maxillaris', 66, 2573, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'S2', N'Maxillary sinuses, (Sinus maxillaris)', 66, 2574, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'S2', N'Maxillary sinuses, (Sinus maxillaris)', 66, 2575, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'S2', N'Senos maxilares', 66, 2576, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'S2', N'Senos maxilares', 66, 2577, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'S2', N'Sinus maxillaris', 66, 2578, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'S2', N'Sinus maxillaris', 66, 2579, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'S2', N'Maxillary sinuses, (Sinus maxillaris)', 66, 2580, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'S2', N'Maxillary sinuses, (Sinus maxillaris)', 66, 2581, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'S2', N'Seni mascellari, seno mascellare', 66, 2582, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'S2', N'Seni mascellari, seno mascellare', 66, 2583, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'S2', N'??????(???)', 66, 2584, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'S2', N'??????(???)', 66, 2585, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'S2', N'???(Sinus maxillaris)', 66, 2586, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'S2', N'???(Sinus maxillaris)', 66, 2587, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'S2', N'Kaakholten, sinus maxillaris', 66, 2588, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'S2', N'Kaakholten, sinus maxillaris', 66, 2589, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'S2', N'Kjevehuler, Sinus maxillaris', 66, 2590, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'S2', N'Kjevehuler, Sinus maxillaris', 66, 2591, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'S2', N'Kjevehuler, Sinus maxillaris', 66, 2592, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'S2', N'Maxillary sinuses, (Sinus maxillaris)', 66, 2593, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'S2', N'Maxillary sinuses, (Sinus maxillaris)', 66, 2594, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'S2', N'Seios maxilares, sinus maxillaris', 66, 2595, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'S2', N'Seios maxilares, sinus maxillaris', 66, 2596, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'S2', N'????????? ??????, Sinus maxillaris', 66, 2597, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'S2', N'????????? ??????, Sinus maxillaris', 66, 2598, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'S2', N'Käkhålor, sinus maxillaris', 66, 2599, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'S2', N'Käkhålor, sinus maxillaris', 66, 2600, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'S2', N'???', 66, 2601, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'S2', N'???', 66, 2602, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'S2', N'???', 66, 2603, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'S3', N'???,????', 67, 2604, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'S3', N'???,????', 67, 2605, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'S3', N'???,????', 67, 2606, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'S3', N'???,????', 67, 2607, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'S3', N'Paranasal sinuses, linear slice orientation', 67, 2608, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'S3', N'Paranasal sinuses, linear slice orientation', 67, 2609, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'S3', N'Nasennebenhöhlen, linearer Schnittverlauf', 67, 2610, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'S3', N'Nasennebenhöhlen, linearer Schnittverlauf', 67, 2611, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'S3', N'Paranasal sinuses, linear slice orientation', 67, 2612, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'S3', N'Paranasal sinuses, linear slice orientation', 67, 2613, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'S3', N'Senos paranasales, recorrido de corte lineal', 67, 2614, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'S3', N'Senos paranasales, recorrido de corte lineal', 67, 2615, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'S3', N'Sinus, coupe linéaire', 67, 2616, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'S3', N'Sinus, coupe linéaire', 67, 2617, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'S3', N'Paranasal sinuses, linear slice orientation', 67, 2618, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'S3', N'Paranasal sinuses, linear slice orientation', 67, 2619, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'S3', N'Seni paranasali, tracciato sezione lineare', 67, 2620, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'S3', N'Seni paranasali, tracciato sezione lineare', 67, 2621, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'S3', N'????????????', 67, 2622, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'S3', N'????????????', 67, 2623, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'S3', N'???, ?? ?? ??', 67, 2624, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'S3', N'???, ?? ?? ??', 67, 2625, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'S3', N'Bijholtes van de neus, lineair snitverloop', 67, 2626, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'S3', N'Bijholtes van de neus, lineair snitverloop', 67, 2627, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'S3', N'Sidehuler nese, lineært snittforløp', 67, 2628, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'S3', N'Sidehuler nese, lineært snittforløp', 67, 2629, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'S3', N'Sidehuler nese, lineært snittforløp', 67, 2630, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'S3', N'Paranasal sinuses, linear slice orientation', 67, 2631, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'S3', N'Paranasal sinuses, linear slice orientation', 67, 2632, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'S3', N'Seios paranasais, orientação linear da fatia', 67, 2633, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'S3', N'Seios paranasais, orientação linear da fatia', 67, 2634, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'S3', N'??????????? ?????? ????, ???????? ??????', 67, 2635, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'S3', N'??????????? ?????? ????, ???????? ??????', 67, 2636, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'S3', N'Näsans bihålor, linjärt snitt', 67, 2637, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'S3', N'Näsans bihålor, linjärt snitt', 67, 2638, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'S3', N'???,????', 67, 2639, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'S3', N'???,????', 67, 2640, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'S3', N'???,????', 67, 2641, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'S4', N'???,????', 68, 2642, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'S4', N'???,????', 68, 2643, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'S4', N'???,????', 68, 2644, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'S4', N'???,????', 68, 2645, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'S4', N'Maxillary sinuses, linear slice orientation', 68, 2646, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'S4', N'Maxillary sinuses, linear slice orientation', 68, 2647, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'S4', N'Kieferhöhlen, Sinus maxillaris, linearer Schnittverlauf', 68, 2648, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'S4', N'Kieferhöhlen, Sinus maxillaris, linearer Schnittverlauf', 68, 2649, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'S4', N'Maxillary sinuses, linear slice orientation', 68, 2650, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'S4', N'Maxillary sinuses, linear slice orientation', 68, 2651, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'S4', N'Senos maxilares, recorrido de corte lineal', 68, 2652, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'S4', N'Senos maxilares, recorrido de corte lineal', 68, 2653, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'S4', N'Sinus maxillaires, coupe linéaire', 68, 2654, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'S4', N'Sinus maxillaires, coupe linéaire', 68, 2655, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'S4', N'Maxillary sinuses, linear slice orientation', 68, 2656, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'S4', N'Maxillary sinuses, linear slice orientation', 68, 2657, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'S4', N'Seni mascellari, seno mascellare, tracciato sezione lineare', 68, 2658, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'S4', N'Seni mascellari, seno mascellare, tracciato sezione lineare', 68, 2659, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'S4', N'???????????????', 68, 2660, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'S4', N'???????????????', 68, 2661, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'S4', N'???(Sinus maxillaris), ?? ?? ??', 68, 2662, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'S4', N'???(Sinus maxillaris), ?? ?? ??', 68, 2663, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'S4', N'Kaakholten, sinus maxillaris, lineair snitverloop', 68, 2664, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'S4', N'Kaakholten, sinus maxillaris, lineair snitverloop', 68, 2665, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'S4', N'Kjevehuler, Sinius maxillaris, lineært snittforløp', 68, 2666, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'S4', N'Kjevehuler, Sinius maxillaris, lineært snittforløp', 68, 2667, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'S4', N'Kjevehuler, Sinius maxillaris, lineært snittforløp', 68, 2668, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'S4', N'Maxillary sinuses, linear slice orientation', 68, 2669, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'S4', N'Maxillary sinuses, linear slice orientation', 68, 2670, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'S4', N'Seios maxilares, sinus maxillaris, orientação linear da fatia', 68, 2671, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'S4', N'Seios maxilares, sinus maxillaris, orientação linear da fatia', 68, 2672, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'S4', N'????????? ??????, Sinus maxillaris, ???????? ??????', 68, 2673, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'S4', N'????????? ??????, Sinus maxillaris, ???????? ??????', 68, 2674, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'S4', N'Käkhålor, sinus maxillaris, linjärt snitt', 68, 2675, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'S4', N'Käkhålor, sinus maxillaris, linjärt snitt', 68, 2676, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'S4', N'???,????', 68, 2677, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'S4', N'???,????', 68, 2678, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'S4', N'???,????', 68, 2679, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'MS1', N'??,??(???????)', 69, 2680, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'MS1', N'??,??(???????)', 69, 2681, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'MS1', N'??,??(???????)', 69, 2682, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'MS1', N'??,??(???????)', 69, 2683, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'MS1', N'Posterior tooth region, multislice (6 views in one image)', 69, 2684, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'MS1', N'Posterior tooth region, multislice (6 views in one image)', 69, 2685, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'MS1', N'Multischichtung im Seitenzahnbereich (6-fach-Darstellung auf einem Bild)', 69, 2686, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'MS1', N'Multischichtung im Seitenzahnbereich (6-fach-Darstellung auf einem Bild)', 69, 2687, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'MS1', N'Posterior tooth region, multislice (6 views in one image)', 69, 2688, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'MS1', N'Posterior tooth region, multislice (6 views in one image)', 69, 2689, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'MS1', N'Multiestrato en la región de los dientes posteriores (visualización séxtuple en una imagen)', 69, 2690, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'MS1', N'Multiestrato en la región de los dientes posteriores (visualización séxtuple en una imagen)', 69, 2691, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'MS1', N'Tomographie multiplan du secteur dentaire latéral (sextuple représentation sur une image', 69, 2692, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'MS1', N'Tomographie multiplan du secteur dentaire latéral (sextuple représentation sur une image', 69, 2693, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'MS1', N'Posterior tooth region, multislice (6 views in one image)', 69, 2694, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'MS1', N'Posterior tooth region, multislice (6 views in one image)', 69, 2695, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'MS1', N'Multistrato nell''area dei denti laterali (rappresentazione sestupla su un''immagine)', 69, 2696, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'MS1', N'Multistrato nell''area dei denti laterali (rappresentazione sestupla su un''immagine)', 69, 2697, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'MS1', N'????????????(6?????1????)', 69, 2698, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'MS1', N'????????????(6?????1????)', 69, 2699, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'MS1', N'?? ???, ?? ??(? ???? 6 ??? ??)', 69, 2700, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'MS1', N'?? ???, ?? ??(? ???? 6 ??? ??)', 69, 2701, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'MS1', N'Multilagig aan de zijtanden (6-voudige weergave in een beeld)', 69, 2702, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'MS1', N'Multilagig aan de zijtanden (6-voudige weergave in een beeld)', 69, 2703, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'MS1', N'Multilagdeling i sidetannområdet (seks lag på ett bilde)', 69, 2704, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'MS1', N'Multilagdeling i sidetannområdet (seks lag på ett bilde)', 69, 2705, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'MS1', N'Multilagdeling i sidetannområdet (seks lag på ett bilde)', 69, 2706, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'MS1', N'Posterior tooth region, multislice (6 views in one image)', 69, 2707, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'MS1', N'Posterior tooth region, multislice (6 views in one image)', 69, 2708, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'MS1', N'Fatias múltiplas na área de dentes laterais (apresentação 6x numa imagem)', 69, 2709, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'MS1', N'Fatias múltiplas na área de dentes laterais (apresentação 6x numa imagem)', 69, 2710, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'MS1', N'?????????? ? ??????? ??????? ????? (6-??????? ????????????? ?? ????? ??????)', 69, 2711, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'MS1', N'?????????? ? ??????? ??????? ????? (6-??????? ????????????? ?? ????? ??????)', 69, 2712, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'MS1', N'Multiskikt i kindtandsområdet (6 x på en bild)', 69, 2713, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'MS1', N'Multiskikt i kindtandsområdet (6 x på en bild)', 69, 2714, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'MS1', N'????????(6 ?????)', 69, 2715, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'MS1', N'????????(6 ?????)', 69, 2716, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'MS1', N'????????(6 ?????)', 69, 2717, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'C1 p.a.', N'??X???,?—?,??', 70, 2718, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'C1 p.a.', N'??X???,?—?,??', 70, 2719, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'C1 p.a.', N'??X???,?—?,??', 70, 2720, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'C1 p.a.', N'??X???,?—?,??', 70, 2721, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'C1 p.a.', N'Anterior-posterior cephalometric exposure, symmetrical', 70, 2722, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'C1 p.a.', N'Anterior-posterior cephalometric exposure, symmetrical', 70, 2723, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'C1 p.a.', N'Fernröntgenaufnahme posterior - anterior, symmetrisch', 70, 2724, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'C1 p.a.', N'Fernröntgenaufnahme posterior - anterior, symmetrisch', 70, 2725, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'C1 p.a.', N'Anterior-posterior cephalometric exposure, symmetrical', 70, 2726, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'C1 p.a.', N'Anterior-posterior cephalometric exposure, symmetrical', 70, 2727, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'C1 p.a.', N'Telerradiografía posterior - anterior, simétrica', 70, 2728, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'C1 p.a.', N'Telerradiografía posterior - anterior, simétrica', 70, 2729, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'C1 p.a.', N'Téléradiographie postéro-antérieure, symétrique', 70, 2730, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'C1 p.a.', N'Téléradiographie postéro-antérieure, symétrique', 70, 2731, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'C1 p.a.', N'Anterior-posterior cephalometric exposure, symmetrical', 70, 2732, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'C1 p.a.', N'Anterior-posterior cephalometric exposure, symmetrical', 70, 2733, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'C1 p.a.', N'Teleradiografia posteriore - anteriore, simmetrica', 70, 2734, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'C1 p.a.', N'Teleradiografia posteriore - anteriore, simmetrica', 70, 2735, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'C1 p.a.', N'AP?????????', 70, 2736, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'C1 p.a.', N'AP?????????', 70, 2737, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'C1 p.a.', N'??-??, ?? ??? X-? ??', 70, 2738, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'C1 p.a.', N'??-??, ?? ??? X-? ??', 70, 2739, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'C1 p.a.', N'Röntgenopname met afstandsbediening posterior - anterior, symmetrisch', 70, 2740, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'C1 p.a.', N'Röntgenopname met afstandsbediening posterior - anterior, symmetrisch', 70, 2741, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'C1 p.a.', N'Fjernrøntgenopptak posteriort – anteriort', 70, 2742, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'C1 p.a.', N'Fjernrøntgenopptak posteriort – anteriort', 70, 2743, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'C1 p.a.', N'Fjernrøntgenopptak posteriort – anteriort', 70, 2744, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'C1 p.a.', N'Anterior-posterior cephalometric exposure, symmetrical', 70, 2745, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'C1 p.a.', N'Anterior-posterior cephalometric exposure, symmetrical', 70, 2746, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'C1 p.a.', N'Telerradiografia posterior - anterior, simétrica', 70, 2747, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'C1 p.a.', N'Telerradiografia posterior - anterior, simétrica', 70, 2748, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'C1 p.a.', N'????????????? ????????????? ?????? ?????-????????, ????????????', 70, 2749, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'C1 p.a.', N'????????????? ????????????? ?????? ?????-????????, ????????????', 70, 2750, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'C1 p.a.', N'Fjärröntgenbild posterior - anterior, symmetrisk', 70, 2751, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'C1 p.a.', N'Fjärröntgenbild posterior - anterior, symmetrisk', 70, 2752, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'C1 p.a.', N'?? X ???,?? - ??,??', 70, 2753, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'C1 p.a.', N'?? X ???,?? - ??,??', 70, 2754, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'C1 p.a.', N'?? X ???,?? - ??,??', 70, 2755, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'C2 a.p.', N'??X???,?—?,??', 71, 2756, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'C2 a.p.', N'??X???,?—?,??', 71, 2757, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'C2 a.p.', N'??X???,?—?,??', 71, 2758, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'C2 a.p.', N'??X???,?—?,??', 71, 2759, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'C2 a.p.', N'Anterior-posterior cephalometric exposure, symmetrical', 71, 2760, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'C2 a.p.', N'Anterior-posterior cephalometric exposure, symmetrical', 71, 2761, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'C2 a.p.', N'Fernröntgenaufnahme, anterior - posterior, symmetrisch', 71, 2762, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'C2 a.p.', N'Fernröntgenaufnahme, anterior - posterior, symmetrisch', 71, 2763, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'C2 a.p.', N'Anterior-posterior cephalometric exposure, symmetrical', 71, 2764, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'C2 a.p.', N'Anterior-posterior cephalometric exposure, symmetrical', 71, 2765, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'C2 a.p.', N'Telerradiografía anterior - posterior, simétrica', 71, 2766, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'C2 a.p.', N'Telerradiografía anterior - posterior, simétrica', 71, 2767, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'C2 a.p.', N'Téléradiographie antéro-postérieure, symétrique', 71, 2768, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'C2 a.p.', N'Téléradiographie antéro-postérieure, symétrique', 71, 2769, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'C2 a.p.', N'Anterior-posterior cephalometric exposure, symmetrical', 71, 2770, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'C2 a.p.', N'Anterior-posterior cephalometric exposure, symmetrical', 71, 2771, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'C2 a.p.', N'Teleradiografia anteriore - posteriore, simmetrica', 71, 2772, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'C2 a.p.', N'Teleradiografia anteriore - posteriore, simmetrica', 71, 2773, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'C2 a.p.', N'AP?????????', 71, 2774, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'C2 a.p.', N'AP?????????', 71, 2775, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'C2 a.p.', N'??-??, ?? ??? X-? ??', 71, 2776, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'C2 a.p.', N'??-??, ?? ??? X-? ??', 71, 2777, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'C2 a.p.', N'Röntgenopname met afstandsbediening, anterior - posterior, symmetrisch', 71, 2778, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'C2 a.p.', N'Röntgenopname met afstandsbediening, anterior - posterior, symmetrisch', 71, 2779, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'C2 a.p.', N'Fjernrøntgenopptak anteriort – posteriort, symmetrisk', 71, 2780, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'C2 a.p.', N'Fjernrøntgenopptak anteriort – posteriort, symmetrisk', 71, 2781, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'C2 a.p.', N'Fjernrøntgenopptak anteriort – posteriort, symmetrisk', 71, 2782, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'C2 a.p.', N'Anterior-posterior cephalometric exposure, symmetrical', 71, 2783, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'C2 a.p.', N'Anterior-posterior cephalometric exposure, symmetrical', 71, 2784, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'C2 a.p.', N'Telerradiografia anterior - posterior, simétrica', 71, 2785, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'C2 a.p.', N'Telerradiografia anterior - posterior, simétrica', 71, 2786, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'C2 a.p.', N'????????????? ????????????? ?????? ???????-??????, ????????????', 71, 2787, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'C2 a.p.', N'????????????? ????????????? ?????? ???????-??????, ????????????', 71, 2788, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'C2 a.p.', N'Fjärröntgenbild anterior - posterior, symmetrisk', 71, 2789, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'C2 a.p.', N'Fjärröntgenbild anterior - posterior, symmetrisk', 71, 2790, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'C2 a.p.', N'?? X ???,?? - ??,??', 71, 2791, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'C2 a.p.', N'?? X ???,?? - ??,??', 71, 2792, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'C2 a.p.', N'?? X ???,?? - ??,??', 71, 2793, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'C3', N'??X???,??', 72, 2794, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'C3', N'??X???,??', 72, 2795, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'C3', N'??X???,??', 72, 2796, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'C3', N'??X???,??', 72, 2797, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'C3', N'Cephalometric exposure, lateral', 72, 2798, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'C3', N'Cephalometric exposure, lateral', 72, 2799, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'C3', N'Fernröntgenaufnahme, lateral', 72, 2800, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'C3', N'Fernröntgenaufnahme, lateral', 72, 2801, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'C3', N'Cephalometric exposure, lateral', 72, 2802, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'C3', N'Cephalometric exposure, lateral', 72, 2803, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'C3', N'Telerradiografía, lateral', 72, 2804, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'C3', N'Telerradiografía, lateral', 72, 2805, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'C3', N'Téléradiographie latérale', 72, 2806, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'C3', N'Téléradiographie latérale', 72, 2807, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'C3', N'Cephalometric exposure, lateral', 72, 2808, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'C3', N'Cephalometric exposure, lateral', 72, 2809, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'C3', N'Teleradiografia, laterale', 72, 2810, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'C3', N'Teleradiografia, laterale', 72, 2811, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'C3', N'?????????', 72, 2812, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'C3', N'?????????', 72, 2813, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'C3', N'??, ??? X-? ??', 72, 2814, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'C3', N'??, ??? X-? ??', 72, 2815, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'C3', N'Röntgenopname met afstandsbediening, lateraal', 72, 2816, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'C3', N'Röntgenopname met afstandsbediening, lateraal', 72, 2817, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'C3', N'Fjernrøntgenopptak, lateralt', 72, 2818, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'C3', N'Fjernrøntgenopptak, lateralt', 72, 2819, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'C3', N'Fjernrøntgenopptak, lateralt', 72, 2820, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'C3', N'Cephalometric exposure, lateral', 72, 2821, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'C3', N'Cephalometric exposure, lateral', 72, 2822, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'C3', N'Telerradiografia, lateral', 72, 2823, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'C3', N'Telerradiografia, lateral', 72, 2824, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'C3', N'????????????? ????????????? ??????, ???????', 72, 2825, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'C3', N'????????????? ????????????? ??????, ???????', 72, 2826, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'C3', N'Fjärröntgenbild, lateral', 72, 2827, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'C3', N'Fjärröntgenbild, lateral', 72, 2828, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'C3', N'?? X ???,??', 72, 2829, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'C3', N'?? X ???,??', 72, 2830, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'C3', N'?? X ???,??', 72, 2831, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'C3 F', N'??X???,??,???', 73, 2832, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'C3 F', N'??X???,??,???', 73, 2833, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'C3 F', N'??X???,??,???', 73, 2834, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'C3 F', N'??X???,??,???', 73, 2835, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'C3 F', N'Cephalometric exposure, lateral, full format', 73, 2836, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'C3 F', N'Cephalometric exposure, lateral, full format', 73, 2837, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'C3 F', N'Fernröntgenaufnahme, lateral, Vollformat', 73, 2838, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'C3 F', N'Fernröntgenaufnahme, lateral, Vollformat', 73, 2839, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'C3 F', N'Cephalometric exposure, lateral, full format', 73, 2840, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'C3 F', N'Cephalometric exposure, lateral, full format', 73, 2841, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'C3 F', N'Telerradiografía a pantalla completa, lateral', 73, 2842, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'C3 F', N'Telerradiografía a pantalla completa, lateral', 73, 2843, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'C3 F', N'Téléradiographie, latérale, en format intégral', 73, 2844, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'C3 F', N'Téléradiographie, latérale, en format intégral', 73, 2845, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'C3 F', N'Cephalometric exposure, lateral, full format', 73, 2846, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'C3 F', N'Cephalometric exposure, lateral, full format', 73, 2847, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'C3 F', N'Teleradiografia, laterale, formato intero', 73, 2848, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'C3 F', N'Teleradiografia, laterale, formato intero', 73, 2849, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'C3 F', N'????????????', 73, 2850, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'C3 F', N'????????????', 73, 2851, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'C3 F', N'??? X-? ??, ??, ? ???', 73, 2852, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'C3 F', N'??? X-? ??, ??, ? ???', 73, 2853, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'C3 F', N'Röntgenopname met afstandsbediening, lateraal, volledig formaat', 73, 2854, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'C3 F', N'Röntgenopname met afstandsbediening, lateraal, volledig formaat', 73, 2855, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'C3 F', N'Fjernrøntgenopptak, lateralt, helformat', 73, 2856, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'C3 F', N'Fjernrøntgenopptak, lateralt, helformat', 73, 2857, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'C3 F', N'Fjernrøntgenopptak, lateralt, helformat', 73, 2858, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'C3 F', N'Cephalometric exposure, lateral, full format', 73, 2859, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'C3 F', N'Cephalometric exposure, lateral, full format', 73, 2860, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'C3 F', N'Telerradiografia, lateral, formato inteiro', 73, 2861, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'C3 F', N'Telerradiografia, lateral, formato inteiro', 73, 2862, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'C3 F', N'????????????? ????????????? ??????, ???????, ?????? ??????', 73, 2863, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'C3 F', N'????????????? ????????????? ??????, ???????, ?????? ??????', 73, 2864, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'C3 F', N'Fjärröntgenbild, lateral, helformat', 73, 2865, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'C3 F', N'Fjärröntgenbild, lateral, helformat', 73, 2866, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'C3 F', N'?? X ???,??,???', 73, 2867, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'C3 F', N'?? X ???,??,???', 73, 2868, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'C3 F', N'?? X ???,??,???', 73, 2869, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'C4', N'?????,??', 74, 2870, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'C4', N'?????,??', 74, 2871, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'C4', N'?????,??', 74, 2872, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'C4', N'?????,??', 74, 2873, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'C4', N'Carpal exposure, symmetrical', 74, 2874, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'C4', N'Carpal exposure, symmetrical', 74, 2875, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'C4', N'Handwurzelaufnahme , symmetrisch', 74, 2876, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'C4', N'Handwurzelaufnahme , symmetrisch', 74, 2877, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'C4', N'Carpal exposure, symmetrical', 74, 2878, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'C4', N'Carpal exposure, symmetrical', 74, 2879, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'C4', N'Radiografía de carpo, simétrica', 74, 2880, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'C4', N'Radiografía de carpo, simétrica', 74, 2881, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'C4', N'Radiographie du poignet, symétrique', 74, 2882, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'C4', N'Radiographie du poignet, symétrique', 74, 2883, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'C4', N'Carpal exposure, symmetrical', 74, 2884, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'C4', N'Carpal exposure, symmetrical', 74, 2885, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'C4', N'Radiografia del carpo, simmetrica', 74, 2886, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'C4', N'Radiografia del carpo, simmetrica', 74, 2887, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'C4', N'????????', 74, 2888, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'C4', N'????????', 74, 2889, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'C4', N'?? ??, ??', 74, 2890, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'C4', N'?? ??, ??', 74, 2891, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'C4', N'Handwortelopname, symmetrisch', 74, 2892, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'C4', N'Handwortelopname, symmetrisch', 74, 2893, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'C4', N'Håndrotopptak, symmetrisk', 74, 2894, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'C4', N'Håndrotopptak, symmetrisk', 74, 2895, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'C4', N'Håndrotopptak, symmetrisk', 74, 2896, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'C4', N'Carpal exposure, symmetrical', 74, 2897, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'C4', N'Carpal exposure, symmetrical', 74, 2898, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'C4', N'Imagem do carpo, simétrica', 74, 2899, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'C4', N'Imagem do carpo, simétrica', 74, 2900, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'C4', N'?????????????? ????????, ????????????', 74, 2901, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'C4', N'?????????????? ????????, ????????????', 74, 2902, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'C4', N'Handledsbild, symmetrisk', 74, 2903, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'C4', N'Handledsbild, symmetrisk', 74, 2904, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'C4', N'?????,??', 74, 2905, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'C4', N'?????,??', 74, 2906, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'C4', N'?????,??', 74, 2907, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 1', 75, 2908, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 1', 75, 2909, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 1', 75, 2910, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 1', 75, 2911, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 1', 75, 2912, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 1', 75, 2913, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'VOL1', N'3D Aufnahme - FoV ø8 cm x H8 cm Drehzentrum 1', 75, 2914, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'VOL1', N'3D Aufnahme - FoV ø8 cm x H8 cm Drehzentrum 1', 75, 2915, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 1', 75, 2916, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 1', 75, 2917, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'VOL1', N'Radiografía 3D: FoV ø8 cm x H8 cm : Isocentro 1', 75, 2918, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'VOL1', N'Radiografía 3D: FoV ø8 cm x H8 cm : Isocentro 1', 75, 2919, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'VOL1', N'Radiographie 3D - FoV ø8 cm x H8 cm : Centre de rotation 1', 75, 2920, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'VOL1', N'Radiographie 3D - FoV ø8 cm x H8 cm : Centre de rotation 1', 75, 2921, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 1', 75, 2922, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 1', 75, 2923, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'VOL1', N'Ripresa 3D - FoV ø8 cm x H8 cm : Centro di rotazione 1', 75, 2924, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'VOL1', N'Ripresa 3D - FoV ø8 cm x H8 cm : Centro di rotazione 1', 75, 2925, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'VOL1', N'3D?? - FoV ø8 cm×H8 cm: ????? 1', 75, 2926, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'VOL1', N'3D?? - FoV ø8 cm×H8 cm: ????? 1', 75, 2927, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ?? ?? 1', 75, 2928, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ?? ?? 1', 75, 2929, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'VOL1', N'3D-opname  - FoV ø8 cm x H8 cm : Draaicentrum 1', 75, 2930, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'VOL1', N'3D-opname  - FoV ø8 cm x H8 cm : Draaicentrum 1', 75, 2931, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'VOL1', N'3D-opptak – FoV ø8 cm x H8 cm : Center of rotation 1', 75, 2932, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'VOL1', N'3D-opptak – FoV ø8 cm x H8 cm : Center of rotation 1', 75, 2933, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'VOL1', N'3D-opptak – FoV ø8 cm x H8 cm : Center of rotation 1', 75, 2934, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 1', 75, 2935, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 1', 75, 2936, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'VOL1', N'Imagem 3D  - FoV ø8 cm x H8 cm : Centro de rotação 1', 75, 2937, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'VOL1', N'Imagem 3D  - FoV ø8 cm x H8 cm : Centro de rotação 1', 75, 2938, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'VOL1', N'3D ?????? - ??????? ?????? ø8 ?? x H8 ?? : ????? ???????? 1', 75, 2939, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'VOL1', N'3D ?????? - ??????? ?????? ø8 ?? x H8 ?? : ????? ???????? 1', 75, 2940, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'VOL1', N'3D bild - FoV ø8 cm x H8 cm : Vridcentrum 1', 75, 2941, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'VOL1', N'3D bild - FoV ø8 cm x H8 cm : Vridcentrum 1', 75, 2942, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 1', 75, 2943, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 1', 75, 2944, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 1', 75, 2945, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 2', 76, 2946, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 2', 76, 2947, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 2', 76, 2948, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 2', 76, 2949, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 2', 76, 2950, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 2', 76, 2951, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'VOL1', N'3D Aufnahme - FoV ø8 cm x H8 cm Drehzentrum2', 76, 2952, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'VOL1', N'3D Aufnahme - FoV ø8 cm x H8 cm Drehzentrum2', 76, 2953, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 2', 76, 2954, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 2', 76, 2955, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'VOL1', N'Radiografía 3D: FoV ø8 cm x H8 cm : Isocentro 2', 76, 2956, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'VOL1', N'Radiografía 3D: FoV ø8 cm x H8 cm : Isocentro 2', 76, 2957, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'VOL1', N'Radiographie 3D - FoV ø8 cm x H8 cm : Centre de rotation 2', 76, 2958, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'VOL1', N'Radiographie 3D - FoV ø8 cm x H8 cm : Centre de rotation 2', 76, 2959, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 2', 76, 2960, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 2', 76, 2961, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'VOL1', N'Ripresa 3D - FoV ø8 cm x H8 cm : Centro di rotazione 2', 76, 2962, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'VOL1', N'Ripresa 3D - FoV ø8 cm x H8 cm : Centro di rotazione 2', 76, 2963, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'VOL1', N'3D?? - FoV ø8 cm×H8 cm: ????? 2', 76, 2964, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'VOL1', N'3D?? - FoV ø8 cm×H8 cm: ????? 2', 76, 2965, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ?? ?? 2', 76, 2966, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ?? ?? 2', 76, 2967, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'VOL1', N'3D-opname  - FoV ø8 cm x H8 cm : Draaicentrum 2', 76, 2968, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'VOL1', N'3D-opname  - FoV ø8 cm x H8 cm : Draaicentrum 2', 76, 2969, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'VOL1', N'3D-opptak – FoV ø8 cm x H8 cm : Center of rotation 2', 76, 2970, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'VOL1', N'3D-opptak – FoV ø8 cm x H8 cm : Center of rotation 2', 76, 2971, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'VOL1', N'3D-opptak – FoV ø8 cm x H8 cm : Center of rotation 2', 76, 2972, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 2', 76, 2973, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 2', 76, 2974, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'VOL1', N'Imagem 3D  - FoV ø8 cm x H8 cm : Centro de rotação 2', 76, 2975, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'VOL1', N'Imagem 3D  - FoV ø8 cm x H8 cm : Centro de rotação 2', 76, 2976, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'VOL1', N'3D ?????? - ??????? ?????? ø8 ?? x H8 ?? : ????? ???????? 2', 76, 2977, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'VOL1', N'3D ?????? - ??????? ?????? ø8 ?? x H8 ?? : ????? ???????? 2', 76, 2978, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'VOL1', N'3D bild - FoV ø8 cm x H8 cm : Vridcentrum 2', 76, 2979, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'VOL1', N'3D bild - FoV ø8 cm x H8 cm : Vridcentrum 2', 76, 2980, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 2', 76, 2981, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 2', 76, 2982, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 2', 76, 2983, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 3', 77, 2984, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 3', 77, 2985, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 3', 77, 2986, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 3', 77, 2987, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 3', 77, 2988, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 3', 77, 2989, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'VOL1', N'3D Aufnahme - FoV ø8 cm x H8 cm Drehzentrum 3', 77, 2990, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'VOL1', N'3D Aufnahme - FoV ø8 cm x H8 cm Drehzentrum 3', 77, 2991, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 3', 77, 2992, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 3', 77, 2993, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'VOL1', N'Radiografía 3D: FoV ø8 cm x H8 cm : Isocentro 3', 77, 2994, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'VOL1', N'Radiografía 3D: FoV ø8 cm x H8 cm : Isocentro 3', 77, 2995, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'VOL1', N'Radiographie 3D - FoV ø8 cm x H8 cm : Centre de rotation 3', 77, 2996, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'VOL1', N'Radiographie 3D - FoV ø8 cm x H8 cm : Centre de rotation 3', 77, 2997, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 3', 77, 2998, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 3', 77, 2999, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'VOL1', N'Ripresa 3D - FoV ø8 cm x H8 cm : Centro di rotazione 3', 77, 3000, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'VOL1', N'Ripresa 3D - FoV ø8 cm x H8 cm : Centro di rotazione 3', 77, 3001, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'VOL1', N'3D?? - FoV ø8 cm×H8 cm: ????? 3', 77, 3002, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'VOL1', N'3D?? - FoV ø8 cm×H8 cm: ????? 3', 77, 3003, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ?? ?? 3', 77, 3004, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ?? ?? 3', 77, 3005, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'VOL1', N'3D-opname  - FoV ø8 cm x H8 cm : Draaicentrum 3', 77, 3006, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'VOL1', N'3D-opname  - FoV ø8 cm x H8 cm : Draaicentrum 3', 77, 3007, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'VOL1', N'3D-opptak – FoV ø8 cm x H8 cm : Center of rotation 3', 77, 3008, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'VOL1', N'3D-opptak – FoV ø8 cm x H8 cm : Center of rotation 3', 77, 3009, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'VOL1', N'3D-opptak – FoV ø8 cm x H8 cm : Center of rotation 3', 77, 3010, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 3', 77, 3011, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 3', 77, 3012, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'VOL1', N'Imagem 3D  - FoV ø8 cm x H8 cm : Centro de rotação 3', 77, 3013, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'VOL1', N'Imagem 3D  - FoV ø8 cm x H8 cm : Centro de rotação 3', 77, 3014, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'VOL1', N'3D ?????? - ??????? ?????? ø8 ?? x H8 ?? : ????? ???????? 3', 77, 3015, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'VOL1', N'3D ?????? - ??????? ?????? ø8 ?? x H8 ?? : ????? ???????? 3', 77, 3016, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'VOL1', N'3D bild - FoV ø8 cm x H8 cm : Vridcentrum 3', 77, 3017, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'VOL1', N'3D bild - FoV ø8 cm x H8 cm : Vridcentrum 3', 77, 3018, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 3', 77, 3019, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 3', 77, 3020, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 3', 77, 3021, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 4', 78, 3022, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 4', 78, 3023, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 4', 78, 3024, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 4', 78, 3025, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 4', 78, 3026, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 4', 78, 3027, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'VOL1', N'3D Aufnahme - FoV ø8 cm x H8 cm Drehzentrum 4', 78, 3028, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'VOL1', N'3D Aufnahme - FoV ø8 cm x H8 cm Drehzentrum 4', 78, 3029, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 4', 78, 3030, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 4', 78, 3031, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'VOL1', N'Radiografía 3D: FoV ø8 cm x H8 cm : Isocentro 4', 78, 3032, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'VOL1', N'Radiografía 3D: FoV ø8 cm x H8 cm : Isocentro 4', 78, 3033, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'VOL1', N'Radiographie 3D - FoV ø8 cm x H8 cm : Centre de rotation 4', 78, 3034, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'VOL1', N'Radiographie 3D - FoV ø8 cm x H8 cm : Centre de rotation 4', 78, 3035, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 4', 78, 3036, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 4', 78, 3037, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'VOL1', N'Ripresa 3D - FoV ø8 cm x H8 cm : Centro di rotazione 4', 78, 3038, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'VOL1', N'Ripresa 3D - FoV ø8 cm x H8 cm : Centro di rotazione 4', 78, 3039, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'VOL1', N'3D?? - FoV ø8 cm×H8 cm: ????? 4', 78, 3040, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'VOL1', N'3D?? - FoV ø8 cm×H8 cm: ????? 4', 78, 3041, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ?? ?? 4', 78, 3042, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ?? ?? 4', 78, 3043, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'VOL1', N'3D-opname  - FoV ø8 cm x H8 cm : Draaicentrum 4', 78, 3044, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'VOL1', N'3D-opname  - FoV ø8 cm x H8 cm : Draaicentrum 4', 78, 3045, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'VOL1', N'3D-opptak – FoV ø8 cm x H8 cm : Center of rotation 4', 78, 3046, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'VOL1', N'3D-opptak – FoV ø8 cm x H8 cm : Center of rotation 4', 78, 3047, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'VOL1', N'3D-opptak – FoV ø8 cm x H8 cm : Center of rotation 4', 78, 3048, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 4', 78, 3049, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 4', 78, 3050, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'VOL1', N'Imagem 3D  - FoV ø8 cm x H8 cm : Centro de rotação 4', 78, 3051, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'VOL1', N'Imagem 3D  - FoV ø8 cm x H8 cm : Centro de rotação 4', 78, 3052, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'VOL1', N'3D ?????? - ??????? ?????? ø8 ?? x H8 ?? : ????? ???????? 4', 78, 3053, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'VOL1', N'3D ?????? - ??????? ?????? ø8 ?? x H8 ?? : ????? ???????? 4', 78, 3054, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'VOL1', N'3D bild - FoV ø8 cm x H8 cm : Vridcentrum 4', 78, 3055, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'VOL1', N'3D bild - FoV ø8 cm x H8 cm : Vridcentrum 4', 78, 3056, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 4', 78, 3057, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 4', 78, 3058, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 4', 78, 3059, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 5', 79, 3060, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 5', 79, 3061, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 5', 79, 3062, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 5', 79, 3063, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 5', 79, 3064, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 5', 79, 3065, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'VOL1', N'3D Aufnahme - FoV ø8 cm x H8 cm Drehzentrum 5', 79, 3066, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'VOL1', N'3D Aufnahme - FoV ø8 cm x H8 cm Drehzentrum 5', 79, 3067, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 5', 79, 3068, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 5', 79, 3069, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'VOL1', N'Radiografía 3D: FoV ø8 cm x H8 cm : Isocentro 5', 79, 3070, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'VOL1', N'Radiografía 3D: FoV ø8 cm x H8 cm : Isocentro 5', 79, 3071, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'VOL1', N'Radiographie 3D - FoV ø8 cm x H8 cm : Centre de rotation 5', 79, 3072, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'VOL1', N'Radiographie 3D - FoV ø8 cm x H8 cm : Centre de rotation 5', 79, 3073, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 5', 79, 3074, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 5', 79, 3075, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'VOL1', N'Ripresa 3D - FoV ø8 cm x H8 cm : Centro di rotazione 5', 79, 3076, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'VOL1', N'Ripresa 3D - FoV ø8 cm x H8 cm : Centro di rotazione 5', 79, 3077, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'VOL1', N'3D?? - FoV ø8 cm×H8 cm: ????? 5', 79, 3078, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'VOL1', N'3D?? - FoV ø8 cm×H8 cm: ????? 5', 79, 3079, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ?? ?? 5', 79, 3080, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ?? ?? 5', 79, 3081, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'VOL1', N'3D-opname  - FoV ø8 cm x H8 cm : Draaicentrum 5', 79, 3082, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'VOL1', N'3D-opname  - FoV ø8 cm x H8 cm : Draaicentrum 5', 79, 3083, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'VOL1', N'3D-opptak – FoV ø8 cm x H8 cm : Center of rotation 5', 79, 3084, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'VOL1', N'3D-opptak – FoV ø8 cm x H8 cm : Center of rotation 5', 79, 3085, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'VOL1', N'3D-opptak – FoV ø8 cm x H8 cm : Center of rotation 5', 79, 3086, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 5', 79, 3087, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'VOL1', N'3D exposure - FoV ø8 cm x H8 cm : Center of rotation 5', 79, 3088, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'VOL1', N'Imagem 3D  - FoV ø8 cm x H8 cm : Centro de rotação 5', 79, 3089, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'VOL1', N'Imagem 3D  - FoV ø8 cm x H8 cm : Centro de rotação 5', 79, 3090, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'VOL1', N'3D ?????? - ??????? ?????? ø8 ?? x H8 ?? : ????? ???????? 5', 79, 3091, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'VOL1', N'3D ?????? - ??????? ?????? ø8 ?? x H8 ?? : ????? ???????? 5', 79, 3092, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'VOL1', N'3D bild - FoV ø8 cm x H8 cm : Vridcentrum 5', 79, 3093, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'VOL1', N'3D bild - FoV ø8 cm x H8 cm : Vridcentrum 5', 79, 3094, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 5', 79, 3095, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 5', 79, 3096, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'VOL1', N'3D ?? - FoV ø8 cm x H8 cm : ???? 5', 79, 3097, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 1', 80, 3098, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 1', 80, 3099, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 1', 80, 3100, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 1', 80, 3101, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 1', 80, 3102, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 1', 80, 3103, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'VOL2', N'3D Aufnahme - FoV ø5 cm x H5,5 cm : Drehzentrum 1', 80, 3104, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'VOL2', N'3D Aufnahme - FoV ø5 cm x H5,5 cm : Drehzentrum 1', 80, 3105, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 1', 80, 3106, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 1', 80, 3107, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'VOL2', N'Radiografía 3D: FoV ø5 cm x H5.5 cm : Isocentro 1', 80, 3108, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'VOL2', N'Radiografía 3D: FoV ø5 cm x H5.5 cm : Isocentro 1', 80, 3109, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'VOL2', N'Radiographie 3D - FoV ø5 cm x H5.5 cm : Centre de rotation 1', 80, 3110, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'VOL2', N'Radiographie 3D - FoV ø5 cm x H5.5 cm : Centre de rotation 1', 80, 3111, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 1', 80, 3112, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 1', 80, 3113, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'VOL2', N'Ripresa 3D - FoV ø5 cm x H5.5 cm : Centro di rotazione 1', 80, 3114, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'VOL2', N'Ripresa 3D - FoV ø5 cm x H5.5 cm : Centro di rotazione 1', 80, 3115, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'VOL2', N'3D?? - FoV ø5 cm×H5,5 cm: ????? 1', 80, 3116, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'VOL2', N'3D?? - FoV ø5 cm×H5,5 cm: ????? 1', 80, 3117, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ?? ?? 1', 80, 3118, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ?? ?? 1', 80, 3119, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'VOL2', N'3D-opname  - FoV ø5 cm x H5.5 cm : Draaicentrum 1', 80, 3120, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'VOL2', N'3D-opname  - FoV ø5 cm x H5.5 cm : Draaicentrum 1', 80, 3121, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'VOL2', N'3D-opptak – FoV ø5 cm x H5.5 cm : Center of rotation 1', 80, 3122, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'VOL2', N'3D-opptak – FoV ø5 cm x H5.5 cm : Center of rotation 1', 80, 3123, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'VOL2', N'3D-opptak – FoV ø5 cm x H5.5 cm : Center of rotation 1', 80, 3124, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 1', 80, 3125, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 1', 80, 3126, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'VOL2', N'Imagem 3D  - FoV ø5 cm x H5.5 cm : Centro de rotação 1', 80, 3127, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'VOL2', N'Imagem 3D  - FoV ø5 cm x H5.5 cm : Centro de rotação 1', 80, 3128, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'VOL2', N'3D ?????? - ??????? ?????? ø5 ?? x H5.5 ?? : ????? ???????? 1', 80, 3129, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'VOL2', N'3D ?????? - ??????? ?????? ø5 ?? x H5.5 ?? : ????? ???????? 1', 80, 3130, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'VOL2', N'3D bild - FoV ø5 cm x H5.5 cm : Vridcentrum 1', 80, 3131, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'VOL2', N'3D bild - FoV ø5 cm x H5.5 cm : Vridcentrum 1', 80, 3132, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 1', 80, 3133, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 1', 80, 3134, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 1', 80, 3135, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 2', 81, 3136, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 2', 81, 3137, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 2', 81, 3138, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 2', 81, 3139, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 2', 81, 3140, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 2', 81, 3141, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'VOL2', N'3D Aufnahme - FoV ø5 cm x H5,5 cm : Drehzentrum 2', 81, 3142, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'VOL2', N'3D Aufnahme - FoV ø5 cm x H5,5 cm : Drehzentrum 2', 81, 3143, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 2', 81, 3144, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 2', 81, 3145, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'VOL2', N'Radiografía 3D: FoV ø5 cm x H5.5 cm : Isocentro 2', 81, 3146, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'VOL2', N'Radiografía 3D: FoV ø5 cm x H5.5 cm : Isocentro 2', 81, 3147, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'VOL2', N'Radiographie 3D - FoV ø5 cm x H5.5 cm : Centre de rotation 2', 81, 3148, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'VOL2', N'Radiographie 3D - FoV ø5 cm x H5.5 cm : Centre de rotation 2', 81, 3149, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 2', 81, 3150, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 2', 81, 3151, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'VOL2', N'Ripresa 3D - FoV ø5 cm x H5.5 cm : Centro di rotazione 2', 81, 3152, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'VOL2', N'Ripresa 3D - FoV ø5 cm x H5.5 cm : Centro di rotazione 2', 81, 3153, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'VOL2', N'3D?? - FoV ø5 cm×H5,5 cm: ????? 2', 81, 3154, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'VOL2', N'3D?? - FoV ø5 cm×H5,5 cm: ????? 2', 81, 3155, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ?? ?? 2', 81, 3156, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ?? ?? 2', 81, 3157, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'VOL2', N'3D-opname  - FoV ø5 cm x H5.5 cm : Draaicentrum 2', 81, 3158, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'VOL2', N'3D-opname  - FoV ø5 cm x H5.5 cm : Draaicentrum 2', 81, 3159, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'VOL2', N'3D-opptak – FoV ø5 cm x H5.5 cm : Center of rotation 2', 81, 3160, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'VOL2', N'3D-opptak – FoV ø5 cm x H5.5 cm : Center of rotation 2', 81, 3161, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'VOL2', N'3D-opptak – FoV ø5 cm x H5.5 cm : Center of rotation 2', 81, 3162, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 2', 81, 3163, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 2', 81, 3164, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'VOL2', N'Imagem 3D  - FoV ø5 cm x H5.5 cm : Centro de rotação 2', 81, 3165, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'VOL2', N'Imagem 3D  - FoV ø5 cm x H5.5 cm : Centro de rotação 2', 81, 3166, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'VOL2', N'3D ?????? - ??????? ?????? ø5 ?? x H5.5 ?? : ????? ???????? 2', 81, 3167, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'VOL2', N'3D ?????? - ??????? ?????? ø5 ?? x H5.5 ?? : ????? ???????? 2', 81, 3168, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'VOL2', N'3D bild - FoV ø5 cm x H5.5 cm : Vridcentrum 2', 81, 3169, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'VOL2', N'3D bild - FoV ø5 cm x H5.5 cm : Vridcentrum 2', 81, 3170, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 2', 81, 3171, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 2', 81, 3172, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 2', 81, 3173, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 3', 82, 3174, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 3', 82, 3175, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 3', 82, 3176, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 3', 82, 3177, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 3', 82, 3178, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 3', 82, 3179, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'VOL2', N'3D Aufnahme - FoV ø5 cm x H5,5 cm : Drehzentrum 3', 82, 3180, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'VOL2', N'3D Aufnahme - FoV ø5 cm x H5,5 cm : Drehzentrum 3', 82, 3181, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 3', 82, 3182, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 3', 82, 3183, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'VOL2', N'Radiografía 3D: FoV ø5 cm x H5.5 cm : Isocentro 3', 82, 3184, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'VOL2', N'Radiografía 3D: FoV ø5 cm x H5.5 cm : Isocentro 3', 82, 3185, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'VOL2', N'Radiographie 3D - FoV ø5 cm x H5.5 cm : Centre de rotation 3', 82, 3186, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'VOL2', N'Radiographie 3D - FoV ø5 cm x H5.5 cm : Centre de rotation 3', 82, 3187, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 3', 82, 3188, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 3', 82, 3189, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'VOL2', N'Ripresa 3D - FoV ø5 cm x H5.5 cm : Centro di rotazione 3', 82, 3190, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'VOL2', N'Ripresa 3D - FoV ø5 cm x H5.5 cm : Centro di rotazione 3', 82, 3191, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'VOL2', N'3D?? - FoV ø5 cm×H5,5 cm: ????? 3', 82, 3192, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'VOL2', N'3D?? - FoV ø5 cm×H5,5 cm: ????? 3', 82, 3193, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ?? ?? 3', 82, 3194, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ?? ?? 3', 82, 3195, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'VOL2', N'3D-opname  - FoV ø5 cm x H5.5 cm : Draaicentrum 3', 82, 3196, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'VOL2', N'3D-opname  - FoV ø5 cm x H5.5 cm : Draaicentrum 3', 82, 3197, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'VOL2', N'3D-opptak – FoV ø5 cm x H5.5 cm : Center of rotation 3', 82, 3198, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'VOL2', N'3D-opptak – FoV ø5 cm x H5.5 cm : Center of rotation 3', 82, 3199, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'VOL2', N'3D-opptak – FoV ø5 cm x H5.5 cm : Center of rotation 3', 82, 3200, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 3', 82, 3201, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 3', 82, 3202, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'VOL2', N'Imagem 3D  - FoV ø5 cm x H5.5 cm : Centro de rotação 3', 82, 3203, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'VOL2', N'Imagem 3D  - FoV ø5 cm x H5.5 cm : Centro de rotação 3', 82, 3204, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'VOL2', N'3D ?????? - ??????? ?????? ø5 ?? x H5.5 ?? : ????? ???????? 3', 82, 3205, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'VOL2', N'3D ?????? - ??????? ?????? ø5 ?? x H5.5 ?? : ????? ???????? 3', 82, 3206, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'VOL2', N'3D bild - FoV ø5 cm x H5.5 cm : Vridcentrum 3', 82, 3207, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'VOL2', N'3D bild - FoV ø5 cm x H5.5 cm : Vridcentrum 3', 82, 3208, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 3', 82, 3209, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 3', 82, 3210, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 3', 82, 3211, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 4', 83, 3212, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 4', 83, 3213, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 4', 83, 3214, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 4', 83, 3215, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 4', 83, 3216, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 4', 83, 3217, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'VOL2', N'3D Aufnahme - FoV ø5 cm x H5,5 cm : Drehzentrum 4', 83, 3218, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'VOL2', N'3D Aufnahme - FoV ø5 cm x H5,5 cm : Drehzentrum 4', 83, 3219, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 4', 83, 3220, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 4', 83, 3221, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'VOL2', N'Radiografía 3D: FoV ø5 cm x H5.5 cm : Isocentro 4', 83, 3222, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'VOL2', N'Radiografía 3D: FoV ø5 cm x H5.5 cm : Isocentro 4', 83, 3223, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'VOL2', N'Radiographie 3D - FoV ø5 cm x H5.5 cm : Centre de rotation 4', 83, 3224, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'VOL2', N'Radiographie 3D - FoV ø5 cm x H5.5 cm : Centre de rotation 4', 83, 3225, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 4', 83, 3226, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 4', 83, 3227, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'VOL2', N'Ripresa 3D - FoV ø5 cm x H5.5 cm : Centro di rotazione 4', 83, 3228, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'VOL2', N'Ripresa 3D - FoV ø5 cm x H5.5 cm : Centro di rotazione 4', 83, 3229, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'VOL2', N'3D?? - FoV ø5 cm×H5,5 cm: ????? 4', 83, 3230, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'VOL2', N'3D?? - FoV ø5 cm×H5,5 cm: ????? 4', 83, 3231, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ?? ?? 4', 83, 3232, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ?? ?? 4', 83, 3233, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'VOL2', N'3D-opname  - FoV ø5 cm x H5.5 cm : Draaicentrum 4', 83, 3234, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'VOL2', N'3D-opname  - FoV ø5 cm x H5.5 cm : Draaicentrum 4', 83, 3235, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'VOL2', N'3D-opptak – FoV ø5 cm x H5.5 cm : Center of rotation 4', 83, 3236, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'VOL2', N'3D-opptak – FoV ø5 cm x H5.5 cm : Center of rotation 4', 83, 3237, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'VOL2', N'3D-opptak – FoV ø5 cm x H5.5 cm : Center of rotation 4', 83, 3238, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 4', 83, 3239, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 4', 83, 3240, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'VOL2', N'Imagem 3D  - FoV ø5 cm x H5.5 cm : Centro de rotação 4', 83, 3241, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'VOL2', N'Imagem 3D  - FoV ø5 cm x H5.5 cm : Centro de rotação 4', 83, 3242, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'VOL2', N'3D ?????? - ??????? ?????? ø5 ?? x H5.5 ?? : ????? ???????? 4', 83, 3243, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'VOL2', N'3D ?????? - ??????? ?????? ø5 ?? x H5.5 ?? : ????? ???????? 4', 83, 3244, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'VOL2', N'3D bild - FoV ø5 cm x H5.5 cm : Vridcentrum 4', 83, 3245, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'VOL2', N'3D bild - FoV ø5 cm x H5.5 cm : Vridcentrum 4', 83, 3246, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 4', 83, 3247, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 4', 83, 3248, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 4', 83, 3249, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 5', 84, 3250, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 5', 84, 3251, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 5', 84, 3252, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 5', 84, 3253, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 5', 84, 3254, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 5', 84, 3255, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'VOL2', N'3D Aufnahme - FoV ø5 cm x H5,5 cm : Drehzentrum 5', 84, 3256, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'VOL2', N'3D Aufnahme - FoV ø5 cm x H5,5 cm : Drehzentrum 5', 84, 3257, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 5', 84, 3258, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 5', 84, 3259, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'VOL2', N'Radiografía 3D: FoV ø5 cm x H5.5 cm : Isocentro 5', 84, 3260, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'VOL2', N'Radiografía 3D: FoV ø5 cm x H5.5 cm : Isocentro 5', 84, 3261, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'VOL2', N'Radiographie 3D - FoV ø5 cm x H5.5 cm : Centre de rotation 5', 84, 3262, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'VOL2', N'Radiographie 3D - FoV ø5 cm x H5.5 cm : Centre de rotation 5', 84, 3263, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 5', 84, 3264, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 5', 84, 3265, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'VOL2', N'Ripresa 3D - FoV ø5 cm x H5.5 cm : Centro di rotazione 5', 84, 3266, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'VOL2', N'Ripresa 3D - FoV ø5 cm x H5.5 cm : Centro di rotazione 5', 84, 3267, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'VOL2', N'3D?? - FoV ø5 cm×H5,5 cm: ????? 5', 84, 3268, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'VOL2', N'3D?? - FoV ø5 cm×H5,5 cm: ????? 5', 84, 3269, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ?? ?? 5', 84, 3270, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ?? ?? 5', 84, 3271, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'VOL2', N'3D-opname  - FoV ø5 cm x H5.5 cm : Draaicentrum 5', 84, 3272, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'VOL2', N'3D-opname  - FoV ø5 cm x H5.5 cm : Draaicentrum 5', 84, 3273, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'VOL2', N'3D-opptak – FoV ø5 cm x H5.5 cm : Center of rotation 5', 84, 3274, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'VOL2', N'3D-opptak – FoV ø5 cm x H5.5 cm : Center of rotation 5', 84, 3275, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'VOL2', N'3D-opptak – FoV ø5 cm x H5.5 cm : Center of rotation 5', 84, 3276, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 5', 84, 3277, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'VOL2', N'3D exposure - FoV ø5 cm x H5.5 cm : Center of rotation 5', 84, 3278, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'VOL2', N'Imagem 3D  - FoV ø5 cm x H5.5 cm : Centro de rotação 5', 84, 3279, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'VOL2', N'Imagem 3D  - FoV ø5 cm x H5.5 cm : Centro de rotação 5', 84, 3280, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'VOL2', N'3D ?????? - ??????? ?????? ø5 ?? x H5.5 ?? : ????? ???????? 5', 84, 3281, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'VOL2', N'3D ?????? - ??????? ?????? ø5 ?? x H5.5 ?? : ????? ???????? 5', 84, 3282, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'VOL2', N'3D bild - FoV ø5 cm x H5.5 cm : Vridcentrum 5', 84, 3283, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'VOL2', N'3D bild - FoV ø5 cm x H5.5 cm : Vridcentrum 5', 84, 3284, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 5', 84, 3285, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 5', 84, 3286, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'VOL2', N'3D ?? - FoV ø5 cm x H5.5 cm : ???? 5', 84, 3287, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'TS', N'??X???,?—?,??', 85, 3288, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'TS', N'??X???,?—?,??', 85, 3289, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'TS', N'??X???,?—?,??', 85, 3290, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'TS', N'??X???,?—?,??', 85, 3291, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'TS', N'Anterior-posterior cephalometric exposure, symmetrical', 85, 3292, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'TS', N'Anterior-posterior cephalometric exposure, symmetrical', 85, 3293, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'TS', N'Fernröntgenaufnahme posterior - anterior, symmetrisch', 85, 3294, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'TS', N'Fernröntgenaufnahme posterior - anterior, symmetrisch', 85, 3295, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'TS', N'Anterior-posterior cephalometric exposure, symmetrical', 85, 3296, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'TS', N'Anterior-posterior cephalometric exposure, symmetrical', 85, 3297, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'TS', N'Telerradiografía posterior - anterior, simétrica', 85, 3298, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'TS', N'Telerradiografía posterior - anterior, simétrica', 85, 3299, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'TS', N'Téléradiographie postéro-antérieure, symétrique', 85, 3300, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'TS', N'Téléradiographie postéro-antérieure, symétrique', 85, 3301, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'TS', N'Anterior-posterior cephalometric exposure, symmetrical', 85, 3302, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'TS', N'Anterior-posterior cephalometric exposure, symmetrical', 85, 3303, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'TS', N'Teleradiografia posteriore - anteriore, simmetrica', 85, 3304, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'TS', N'Teleradiografia posteriore - anteriore, simmetrica', 85, 3305, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'TS', N'AP?????????', 85, 3306, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'TS', N'AP?????????', 85, 3307, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'TS', N'??-??, ?? ??? X-? ??', 85, 3308, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'TS', N'??-??, ?? ??? X-? ??', 85, 3309, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'TS', N'Röntgenopname met afstandsbediening posterior - anterior, symmetrisch', 85, 3310, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'TS', N'Röntgenopname met afstandsbediening posterior - anterior, symmetrisch', 85, 3311, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'TS', N'Fjernrøntgenopptak posteriort – anteriort', 85, 3312, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'TS', N'Fjernrøntgenopptak posteriort – anteriort', 85, 3313, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'TS', N'Fjernrøntgenopptak posteriort – anteriort', 85, 3314, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'TS', N'Anterior-posterior cephalometric exposure, symmetrical', 85, 3315, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'TS', N'Anterior-posterior cephalometric exposure, symmetrical', 85, 3316, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'TS', N'Telerradiografia posterior - anterior, simétrica', 85, 3317, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'TS', N'Telerradiografia posterior - anterior, simétrica', 85, 3318, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'TS', N'????????????? ????????????? ?????? ?????-????????, ????????????', 85, 3319, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'TS', N'????????????? ????????????? ?????? ?????-????????, ????????????', 85, 3320, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'TS', N'Fjärröntgenbild posterior - anterior, symmetrisk', 85, 3321, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'TS', N'Fjärröntgenbild posterior - anterior, symmetrisk', 85, 3322, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'TS', N'?? X ???,?? - ??,??', 85, 3323, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'TS', N'?? X ???,?? - ??,??', 85, 3324, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'TS', N'?? X ???,?? - ??,??', 85, 3325, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'P20', N'????????', 86, 3326, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'P20', N'????????', 86, 3327, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'P20', N'????????', 86, 3328, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'P20', N'????????', 86, 3329, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'P20', N'Standard panoramic exposure of a child', 86, 3330, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'P20', N'Standard panoramic exposure of a child', 86, 3331, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'P20', N'Kinder Standard-Panoramaaufnahme', 86, 3332, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'P20', N'Kinder Standard-Panoramaaufnahme', 86, 3333, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'P20', N'Standard panoramic exposure of a child', 86, 3334, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'P20', N'Standard panoramic exposure of a child', 86, 3335, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'P20', N'Radiografía panorámica estándar pediátrica', 86, 3336, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'P20', N'Radiografía panorámica estándar pediátrica', 86, 3337, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'P20', N'Radiographie panoramique standard enfants', 86, 3338, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'P20', N'Radiographie panoramique standard enfants', 86, 3339, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'P20', N'Standard panoramic exposure of a child', 86, 3340, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'P20', N'Standard panoramic exposure of a child', 86, 3341, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'P20', N'Radiografia panoramica standard per bambini', 86, 3342, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'P20', N'Radiografia panoramica standard per bambini', 86, 3343, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'P20', N'????????????', 86, 3344, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'P20', N'????????????', 86, 3345, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'P20', N'??? ?? ???? ??', 86, 3346, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'P20', N'??? ?? ???? ??', 86, 3347, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'P20', N'Standaard panorama-opame voor kinderen', 86, 3348, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'P20', N'Standaard panorama-opame voor kinderen', 86, 3349, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'P20', N'Normalt panoramaopptak av barn', 86, 3350, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'P20', N'Normalt panoramaopptak av barn', 86, 3351, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'P20', N'Normalt panoramaopptak av barn', 86, 3352, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'P20', N'Standard panoramic exposure of a child', 86, 3353, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'P20', N'Standard panoramic exposure of a child', 86, 3354, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'P20', N'Imagem normal panorâmica de criança', 86, 3355, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'P20', N'Imagem normal panorâmica de criança', 86, 3356, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'P20', N'??????????? ?????????? ??????????????, ???????', 86, 3357, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'P20', N'??????????? ?????????? ??????????????, ???????', 86, 3358, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'P20', N'Barn standard panoramabild', 86, 3359, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'P20', N'Barn standard panoramabild', 86, 3360, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'P20', N'????????', 86, 3361, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'P20', N'????????', 86, 3362, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'P20', N'????????', 86, 3363, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'BW10', N'??????', 87, 3364, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHT', N'BW10', N'??????', 87, 3365, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hant', N'BW10', N'??????', 87, 3366, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh', N'BW10', N'??????', 87, 3367, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs-CZ', N'BW10', N'Bite wing exposure in posterior tooth region', 87, 3368, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'BW10', N'Bite wing exposure in posterior tooth region', 87, 3369, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de-DE', N'BW10', N'Bissflügelaufnahme im Seitenzahnbereich', 87, 3370, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'BW10', N'Bissflügelaufnahme im Seitenzahnbereich', 87, 3371, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'BW10', N'Bite wing exposure in posterior tooth region', 87, 3372, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'BW10', N'Bite wing exposure in posterior tooth region', 87, 3373, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es-ES', N'BW10', N'Radiografía con ala de mordida de la región de los dientes posteriores', 87, 3374, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'BW10', N'Radiografía con ala de mordida de la región de los dientes posteriores', 87, 3375, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr-FR', N'BW10', N'Radiographie interproximale du secteur dentaire latéral', 87, 3376, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'BW10', N'Radiographie interproximale du secteur dentaire latéral', 87, 3377, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu-HU', N'BW10', N'Bite wing exposure in posterior tooth region', 87, 3378, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'BW10', N'Bite wing exposure in posterior tooth region', 87, 3379, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it-IT', N'BW10', N'Radiografia bite-wing nell''area dei denti laterali', 87, 3380, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'BW10', N'Radiografia bite-wing nell''area dei denti laterali', 87, 3381, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja-JP', N'BW10', N'??????????????', 87, 3382, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'BW10', N'??????????????', 87, 3383, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko-KR', N'BW10', N'?? ??? ?? ??', 87, 3384, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'BW10', N'?? ??? ?? ??', 87, 3385, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl-NL', N'BW10', N'Bijtstukopname in het bereik van de zijtanden', 87, 3386, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'BW10', N'Bijtstukopname in het bereik van de zijtanden', 87, 3387, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb-NO', N'BW10', N'Bite-wing-opptak i sidetannområdet', 87, 3388, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nb', N'BW10', N'Bite-wing-opptak i sidetannområdet', 87, 3389, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'BW10', N'Bite-wing-opptak i sidetannområdet', 87, 3390, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl-PL', N'BW10', N'Bite wing exposure in posterior tooth region', 87, 3391, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'BW10', N'Bite wing exposure in posterior tooth region', 87, 3392, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'BW10', N'Imagem da asa de mordente na área de dentes laterais', 87, 3393, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt', N'BW10', N'Imagem da asa de mordente na área de dentes laterais', 87, 3394, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru-RU', N'BW10', N'?????? ???????? ??????? ? ??????? ??????? ?????', 87, 3395, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'BW10', N'?????? ???????? ??????? ? ??????? ??????? ?????', 87, 3396, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv-SE', N'BW10', N'Bitvingebild i kindtandsområdet', 87, 3397, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'BW10', N'Bitvingebild i kindtandsområdet', 87, 3398, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'BW10', N'?????????', 87, 3399, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CHS', N'BW10', N'?????????', 87, 3400, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-Hans', N'BW10', N'?????????', 87, 3401, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Exploración', N'Exploración 3D', 1, 3402, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Volumen', N'Volumen', 3, 3403, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Proyección', N'Proyección 3D', 4, 3404, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Panorámica 3D', N'Vista en corte panorámica calculada a partir de volumen 3D', 5, 3405, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Panorámica 3D (TDI)', N'Vista en corte panorámica calculada a partir de volumen 3D', 6, 3406, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Proyección (transversal)', N'Vista en corte transversal calculada a partir de volumen 3D', 7, 3407, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Proyección (longitudinal)', N'Vista en corte longitudinal calculada a partir de volumen 3D', 8, 3408, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Proyección (axial)', N'Vista en corte axial calculada a partir de volumen 3D', 9, 3409, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Proyección (coronal)', N'Vista en corte coronal calculada a partir de volumen 3D', 10, 3410, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Proyección (sagital)', N'Vista en corte sagital calculada a partir de volumen 3D', 11, 3411, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Proyección (lateral)', N'Vista en corte lateral calculada a partir de volumen 3D', 12, 3412, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Proyección (cefalométrica a.p.)', N'Vista en corte cefalométrica a.p. calculada a partir de volumen 3D', 13, 3413, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Proyección (cefalométrica p.a.)', N'Vista en corte cefalométrica p.a. calculada a partir de volumen 3D', 14, 3414, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Intraoral', N'Radiografía intraoral', 15, 3415, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Endo', N'Secuencia Endo', 16, 3416, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Ala de mordida', N'Radiografía con ala de mordida', 17, 3417, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Radiografía Status intraoral', N'Radiografía Status intraoral', 18, 3418, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Panorámica', N'Radiografía OPG', 19, 3419, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Cefalométrica', N'Radiografía cefalométrica', 20, 3420, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Vista en corte transversal', N'Vista en corte transversal', 21, 3421, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Radiografía', N'Radiografía desconocida', 22, 3422, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Vídeo intraoral', N'Imagen de vídeo intraoral', 23, 3423, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Estado de fotografía intraoral', N'Estado de fotografía intraoral', 24, 3424, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Imagen extraoral', N'Imagen extraoral', 25, 3425, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Estado de fotografía extraoral', N'Estado de fotografía extraoral', 26, 3426, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Fotografía', N'Imagen desconocida', 27, 3427, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Adquisición superficial', N'Adquisición superficial', 28, 3428, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Proyección FS', N'Proyección Facescan', 29, 3429, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Superficie FS', N'Superficie Facescan', 30, 3430, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Textura FS', N'Textura Facescan', 31, 3431, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Rejilla FS', N'Rejilla Facescan', 32, 3432, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Implante', N'Implante', 33, 3433, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Rejilla intraoral', N'Rejilla intraoral', 34, 3434, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Exploración', N'Exploración', 38, 3435, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Exploración 2D', N'Radiografía 2D', 35, 3436, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Proyección 2D (extraoral)', N'Vista en corte extraoral calculada a partir de radiografía 2D', 36, 3437, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Exploración FFP', N'Exploración panorámica de formato completo', 37, 3438, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Scan', N'Scan 3D', 1, 3439, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Volume', N'Volume', 3, 3440, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Projection', N'Projection 3D', 4, 3441, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Panorama 3D', N'Coupe panoramique calculée à partir du volume 3D', 5, 3442, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Panorama 3D (TDI)', N'Coupe panoramique calculée à partir du volume 3D', 6, 3443, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Projection (transversale)', N'Coupe transversale calculée à partir du volume 3D', 7, 3444, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Projection (longitudinale)', N'Coupe longitudinale calculée à partir du volume 3D', 8, 3445, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Projection (axiale)', N'Coupe axiale calculée à partir du volume 3D', 9, 3446, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Projection (coronale)', N'Coupe coronale calculée à partir du volume 3D', 10, 3447, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Projection (sagittale)', N'Coupe sagittale calculée à partir du volume 3D', 11, 3448, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Projection (latérale)', N'Coupe latérale calculée à partir du volume 3D', 12, 3449, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Projection (ceph a.p.)', N'Coupe ceph a.p. calculée à partir du volume 3D', 13, 3450, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Projection (ceph p.a.)', N'Coupe ceph p.a. calculée à partir du volume 3D', 14, 3451, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Intraoral', N'Radiographie intraorale', 15, 3452, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Endo', N'Séquence endo', 16, 3453, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Interproximal', N'Radiographie interproximale (bitewing)', 17, 3454, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Status RX intraoral', N'Status radiographique intraoral', 18, 3455, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Panorama', N'Orthopantogramme', 19, 3456, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Ceph', N'Radiographie Ceph', 20, 3457, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Coupe transversale', N'Coupe transversale', 21, 3458, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Radiographie', N'Radiographie inconnue', 22, 3459, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Vidéo intraorale', N'Image vidéo intraorale', 23, 3460, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Status photo intraoral', N'Status photographique intraoral', 24, 3461, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Image extraorale', N'Image extraorale', 25, 3462, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Status photo extraoral', N'Status photographique extraoral', 26, 3463, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Photo', N'Image inconnue', 27, 3464, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Enregistrement surface', N'Enregistrement de la surface', 28, 3465, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Projection FS', N'Projection Facescan', 29, 3466, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Surface FS', N'Surface Facescan', 30, 3467, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Texture FS', N'Texture Facescan', 31, 3468, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Grille FS', N'Grille Facescan', 32, 3469, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Implant', N'Implant', 33, 3470, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Grille intraorale', N'Grille intraorale', 34, 3471, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Scan', N'Scan', 38, 3472, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Scan 2D', N'Radiographie 2D', 35, 3473, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Projection 2D (extraorale)', N'Coupe extraorale calculée à partir de la radiographie 2D', 36, 3474, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Scan FFP', N'Scan PAN plein écran', 37, 3475, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Scansione', N'Scansione 3D', 1, 3476, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Volumi', N'Volumi', 3, 3477, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Proiezione', N'Proiezione 3D', 4, 3478, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Panoramica 3D', N'Vista di taglio panoramica calcolata da volumi 3D', 5, 3479, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Panoramica 3D (TDI)', N'Vista di taglio panoramica calcolata da volumi 3D', 6, 3480, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Proiezione (trasversale)', N'Vista di taglio trasversale calcolata da volumi 3D', 7, 3481, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Proiezione (longitudinale)', N'Vista di taglio longitudinale calcolata da volumi 3D', 8, 3482, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Proiezione (assiale)', N'Vista di taglio assiale calcolata da volumi 3D', 9, 3483, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Proiezione (coronale)', N'Vista di taglio coronale calcolata da volumi 3D', 10, 3484, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Proiezione (sagittale)', N'Vista di taglio sagittale calcolata da volumi 3D', 11, 3485, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Proiezione (laterale)', N'Vista di taglio sagittale calcolata da volumi 3D', 12, 3486, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Proiezione (ceph a.p.)', N'Vista di taglio ceph a.p. calcolata da volumi 3D', 13, 3487, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Proiezione (ceph p.a.)', N'Vista di taglio ceph p.a. calcolata da volumi 3D', 14, 3488, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Intraorale', N'Radiografia intraorale', 15, 3489, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Endo', N'Sequenza Endo', 16, 3490, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Bite-wing', N'Radiografia bite-wing', 17, 3491, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Stato radiografie intraorali', N'Stato radiografie intraorali', 18, 3492, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Panoramica', N'Ortopantomografia', 19, 3493, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Ceph', N'Radiografia Ceph', 20, 3494, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Vista di taglio trasversale', N'Vista di taglio trasversale', 21, 3495, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Radiografia', N'Radiografia sconosciuta', 22, 3496, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Video intraorale', N'Immagine video intraorale', 23, 3497, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Stato foto intraorale', N'Stato foto intraorale', 24, 3498, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Immagine extraorale', N'Immagine extraorale', 25, 3499, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Stato foto extraorale', N'Stato foto extraorale', 26, 3500, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Foto', N'Immagine sconosciuta', 27, 3501, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Ripresa superficiale', N'Ripresa superficiale', 28, 3502, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Proiezione FS', N'Proiezione Facescan', 29, 3503, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Superficie FS', N'Superficie Facescan', 30, 3504, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Tessuto FS', N'Tessuto Facescan', 31, 3505, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Griglia FS', N'Griglia Facescan', 32, 3506, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Impianto', N'Impianto', 33, 3507, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Griglia intraorale', N'Griglia intraorale', 34, 3508, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Scansione', N'Scansione', 38, 3509, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Scansione 2D', N'Radiografia 2D', 35, 3510, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Proiezione 2D (extraorale)', N'Vista di taglio extraorale calcolata da radiografia 2D', 36, 3511, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Scansione FFP', N'Scansione Fullframe-PAN', 37, 3512, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Color Photo', N'Unknown color image', 88, 3513, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Farbfoto', N'Unbekanntes Farbfoto', 88, 3514, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'FS1', N'Ripresa superficiale', 40, 3515, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'FS1', N'Enregistrement de la surface', 40, 3516, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'FS1', N'Adquisición superficial', 40, 3517, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'VC', N'CEREC Intraoralbild', 89, 1497, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'VC', N'CEREC intraoral image', 89, 1498, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'VC', N'Immagine intraorale CEREC ', 89, 1499, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'VC', N'Image intraorale CEREC ', 89, 1500, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'VC', N'Imagen intraoral CEREC ', 89, 1501, 0, NULL)

INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Bitewings', N'Bitewings template', 90, 1455, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'Bitewings', N'Bitewings template', 90, 1456, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Bissflügelaufnahmen', N'Vorlage für Bissflügelaufnahmen', 90, 1457, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Radiografie bite-wing', N'Modello per radiografie bite-wing', 90, 1458, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Radiographies bitewing', N'Modèle pour radiographies bitewing', 90, 1459, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Radiografías con ala de mordida', N'Plantilla para radiografías con ala de mordida', 90, 1460, 0, NULL)

INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'Checkup', N'Checkup template', 91, 1461, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Checkup', N'Checkup template', 91, 1462, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Kontrolluntersuchung', N'Vorlage für eine Kontrolluntersuchung', 91, 1463, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Check up', N'Modello per check up', 91, 1464, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Examen de contrôle', N'Modèle pour un examen de contrôle', 91, 1465, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Revisión de control', N'Plantilla para una revisión de control', 91, 1466, 0, NULL)

INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'Endo Horizontal (15)', N'Endo intra-oral template with 15 horizontal arbitrary views', 92, 1467, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Endo Horizontal (15)', N'Endo intra-oral template with 15 horizontal arbitrary views', 92, 1468, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Intraorale Aufnahmeserie (15)', N'Intraorale Serie mit 15 Aufnahmen', 92, 1469, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Serie di riprese intraorali (15)', N'Serie intraorale con 15 riprese', 92, 1470, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Série de radiographies intraorales (15)', N'Série intraorale avec 15 radiographies', 92, 1471, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Serie radiográfica intraoral (15)', N'Serie intraoral con 15 radiografías', 92, 1472, 0, NULL)

INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'Full Mouth Series (18)', N'Full Mouth Series template with 18 exposures', 93, 1473, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Full Mouth Series (18)', N'Full Mouth Series template with 18 exposures', 93, 1474, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Intraorale Aufnahmeserie (18)', N'Intraorale Serie mit 18 Aufnahmen', 93, 1475, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Serie di riprese intraorali (18)', N'Serie intraorale con 18 risprese', 93, 1476, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Série de radiographies intraorale (18)', N'Série intraorale avec 18 radiographies', 93, 1477, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Serie radiográfica intraoral (18)', N'Serie intraoral con 18 radiografías', 93, 1478, 0, NULL)

INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'Full Mouth Series (21)', N'Full Mouth Series template with 21 exposures', 94, 1479, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Full Mouth Series (21)', N'Full Mouth Series template with 21 exposures', 94, 1480, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Intraorale Aufnahmeserie (21)', N'Intraorale Serie mit  21 Aufnahmen', 94, 1481, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Serie di riprese intraorali (21)', N'Serie intraorale con 21 risprese', 94, 1482, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Série de radiographies intraorale (21)', N'Série intraorale avec 21 radiographies', 94, 1483, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Serie radiográfica intraoral (21)', N'Serie intraoral con 21 radiografías', 94, 1484, 0, NULL)

INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'Pano With 4 Bitewings', N'Mixed template with 1 Panoramic and 4 Bitewing exposures', 95, 1485, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Pano With 4 Bitewings', N'Mixed template with 1 Panoramic and 4 Bitewing exposures', 95, 1486, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'OPG mit 4 Bissflügelaufnahmen', N'Vorlage mit 1 OPG- und 4 Bissflügelaufnahmen', 95, 1487, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'OPT con 4 radiografie bite-wing', N'Modello per ortopantomogramma e per 4 radiografie bite-wing', 95, 1488, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Panoramique avec 4 bitewings', N'Modèle avec 1 radiographie panoramique et 4 bitewings', 95, 1489, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'OPG con 4 radiografías con ala de mordida', N'Plantilla con 1 radiografía OPG y 4 radiografías con ala de mordida', 95, 1490, 0, NULL)

INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'Vertical Endo', N'Endodontic intra-oral template with arbitrary vertical exposures', 96, 1491, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Vertical Endo', N'Endodontic intra-oral template with arbitrary vertical exposures', 96, 1492, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Endo Vertikal', N'Vorlage für endodontische Intraoralaufnahmen mit vertikaler Ausrichtung', 96, 1493, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Endo verticale', N'Modello per riprese intraorali endodontiche con orientamento verticale', 96, 1494, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Endo vertical', N'Modèle pour radiographies endodontiques intraorales avec orientation verticale', 96, 1495, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Endo vertical', N'Plantilla para radiografías intraorales de endodoncia con alineación vertical', 96, 1496, 0, NULL)

INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'Image', N'Unknown image', 97, 1454, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Image', N'Unknown image', 97, 1453, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Bild', N'Unbekanntes Bild', 97, 1452, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Image', N'Image inconnue', 97, 1451, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Imagen', N'Imagen desconocida', 97, 1450, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Immagine', N'Immagine sconosciuta', 97, 1449, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'Snímek', N'Neznámý snímek', 97, 1448, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'da', N'Billede', N'Ukendt billede', 97, 1447, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fi', N'Kuva', N'Tuntematon kuva', 97, 1446, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hr', N'Slika', N'Nepoznata slika', 97, 1445, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'Kép', N'Ismeretlen kép', 97, 1444, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'lt', N'Atvaizdas', N'Nežinomas atvaizdas', 97, 1443, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'Beeld', N'Onbekend beeld', 97, 1442, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'Bilde', N'Ukjent bilde', 97, 1441, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'Obraz', N'Nieznany obraz', 97, 1440, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'Imagem', N'Imagem desconhecida', 97, 1439, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ro', N'Imagine', N'Imagine necunoscută', 97, 1438, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'Изображение', N'Неизвестное изображение', 97, 1437, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sk', N'Snímka', N'Neznáma snímka', 97, 1436, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sl', N'Slika', N'Neznana slika', 97, 1435, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sr', N'Slika', N'Nepoznata slika', 97, 1434, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'Bild', N'Okänd bild', 97, 1433, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'tr', N'Resim', N'Bilinmeyen resim', 97, 1432, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'图像', N'未知图像', 97, 1431, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'影像', N'未知影像', 97, 1430, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'이미지', N'알수 없는 이미지', 97, 1429, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'画像', N'不明な画像', 97, 1428, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'Photo', N'Unkown photo', 98, 1427, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Photo', N'Unkown photo', 98, 1425, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Foto', N'Unbekanntes Foto', 98, 1424, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Photo', N'Photo inconnue', 98, 1423, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Fotografía', N'Fotografía desconocida', 98, 1422, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Foto', N'Foto sconosciuta', 98, 1421, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'Fotografie', N'Neznámá fotografie', 98, 1420, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'da', N'Foto', N'Ukendt foto', 98, 1419, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fi', N'Valokuva', N'Tuntematon valokuva', 98, 1418, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hr', N'Fotografija', N'Nepoznata fotografija', 98, 1417, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'Fotó', N'Ismeretlen fotó', 98, 1416, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'lt', N'Nuotrauka', N'Nežinoma nuotrauka', 98, 1415, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'Foto', N'Onbekende foto', 98, 1414, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'Foto', N'Ukjent foto', 98, 1413, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'Zdjęcie', N'Nieznane zdjęcie', 98, 1412, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'Foto', N'Foto desconhecida', 98, 1411, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ro', N'Fotografie', N'Fotografie necunoscută', 98, 1410, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'Фото', N'Неизвестное фото', 98, 1409, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sk', N'Fotografia', N'Neznáma fotografia', 98, 1408, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sl', N'Fotografija', N'Neznana fotografija', 98, 1407, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sr', N'Fotografija', N'Nepoznata fotografija', 98, 1406, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'Foto', N'Okänt foto', 98, 1405, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'tr', N'Fotoğraf', N'Bilinmeyen fotoğraf', 98, 1404, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'照片', N'未知照片', 98, 1403, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'照片', N'未知照片', 98, 1402, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'사진', N'알수 없는 사진', 98, 1401, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'写真', N'不明な写真', 98, 1400, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'X-ray', N'Unknown x-ray image', 99, 1399, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'X-ray', N'Unknown x-ray image', 99, 1398, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Röntgen', N'Unbekanntes Röntgenbild', 99, 1397, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Radiographie', N'Radiographie inconnue', 99, 1396, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Rayos X', N'Radiografía desconocida', 99, 1395, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Radiografia', N'Radiografia sconosciuta', 99, 1394, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'Rentgen', N'Neznámý rentgenový snímek', 99, 1393, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'da', N'Røntgen', N'Ukendt røntgenbillede', 99, 1392, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fi', N'Röntgenkuva', N'Tuntematon röntgenkuva', 99, 1391, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hr', N'Rendgen', N'Nepoznatna rendgenska snimka', 99, 1390, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'Röntgen', N'Ismeretlen röntgenkép', 99, 1389, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'lt', N'Rentgenas', N'Nežinomas rentgeno atvaizdas', 99, 1388, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'Röntgen', N'Onbekend röntgenbeeld', 99, 1387, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'Røntgen', N'Ukjent røntgenbilde', 99, 1386, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'Rentgen', N'Nieznane zdjęcie rentgenowskie', 99, 1385, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'Raio-x', N'Raio-x desconhecido', 99, 1384, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ro', N'Radiografie', N'Imagine radiografie necunoscută', 99, 1383, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'Рентгенограмма', N'Неизвестная рентгенограмма', 99, 1382, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sk', N'Röntgen', N'Neznámy röntgenová snímka', 99, 1381, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sl', N'Rentgen', N'Neznana rentgenska slika', 99, 1380, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sr', N'Rendgen', N'Nepoznatni rendgenski snimak', 99, 1379, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'Röntgen', N'Okänd röntgenbild', 99, 1378, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'tr', N'Röntgen', N'Bilinmeyen röntgen resmi', 99, 1377, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'X 射线', N'未知 X 射线图像', 99, 1376, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'X 光', N'未知 X 光影像', 99, 1375, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'엑스레이', N'알수 없는 엑스레이 사진', 99, 1374, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'X線', N'不明なX線', 99, 1373, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en-US', N'3D-Scan', N'3D-Scan', 100, 1372, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'3D-Scan', N'3D-Scan', 100, 1371, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'3D-Scan', N'3D-Scan', 100, 1370, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fr', N'Scan 3D', N'Scan 3D', 100, 1369, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'es', N'Exploración 3D', N'Exploración 3D', 100, 1368, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'it', N'Scansione 3D', N'Scansione 3D', 100, 1367, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'3D sken', N'3D sken', 100, 1366, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'da', N'3D-scanning', N'3D-scanning', 100, 1365, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fi', N'3D-skannaus', N'3D-skannaus', 100, 1364, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hr', N'3D sken', N'3D sken', 100, 1363, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'3D-Scan', N'3D-Scan', 100, 1362, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'lt', N'3D nuskaitymas', N'3D nuskaitymas', 100, 1361, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'3D-scan', N'3D-scan', 100, 1360, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'3D-skanning', N'3D-skanning', 100, 1359, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'Skan 3D', N'Skan 3D', 100, 1358, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'Scan 3D', N'Scan 3D', 100, 1357, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ro', N'Scanare 3D', N'Scanare 3D', 100, 1356, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'3D-скан', N'3D-скан', 100, 1355, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sk', N'3D sken', N'3D sken', 100, 1354, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sl', N'3D slikanje', N'3D slikanje', 100, 1353, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sr', N'3D sken', N'3D sken', 100, 1352, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'3D-Scan', N'3D-Scan', 100, 1351, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'tr', N'3D taraması', N'3D taraması', 100, 1350, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'3D 扫描', N'3D 扫描', 100, 1349, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'3D 掃描', N'3D 掃描', 100, 1348, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'3D 스캔', N'3D 스캔', 100, 1347, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'3Dスキャン', N'3Dスキャン', 100, 1346, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'Bite wing snímky', N'Šablona pro bite wing snímky', 90, 1345, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'da', N'Bitewing-optagelser', N'Skabelon til bitewing-optagelser', 90, 1344, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fi', N'Purentakappalekuvaukset', N'Purentakappalemalli', 90, 1343, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hr', N'Zagrizne rendgenske snimke', N'Predložak za zagrizne rendgenske snimke', 90, 1342, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'Fogsorív felvételek', N'Minta fogsorív felvételekhez', 90, 1341, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'lt', N'Sąkandžio nuotrauka', N'Sąkandžio nuotraukos šablonas', 90, 1340, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'Bijtvleugelopnamen', N'Sjabloon voor bijtvleugelopnamen', 90, 1339, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'Bitewing-opptak', N'Mal for bitewing-opptak', 90, 1338, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'Zdjęcia skrzydłowo-zgryzowe', N'Wzór dla zdjęć skrzydłowo-zgryzowych', 90, 1337, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'Exposição da asa de mordente', N'Modelo para exposições da asa de mordente', 90, 1336, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ro', N'Radiografii retroalveolare', N'Model pentru radiografii retroalveolare', 90, 1335, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'Рентгенография с прикусным держателем', N'Шаблон для рентгенографии с прикусным держателем', 90, 1334, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sk', N'Bite wing snímky', N'Šablóna pre bite wing snímky', 90, 1333, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sl', N'Slikanje z ugrizno tehniko', N'Predloga za slikanje z ugrizno tehniko', 90, 1332, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sr', N'Zagrizni radiogrami', N'Šablon za zagrizne radiograme', 90, 1331, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'Bitvingeexponeringar', N'Mall för bitvingeexponeringar', 90, 1330, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'tr', N'Diş röntgeni film tableti kayıtları', N'Diş röntgeni film tableti kayıtları için şablon', 90, 1329, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'咬翼片', N'咬翼片模板', 90, 1328, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'咬翼片攝影', N'咬翼片攝影版型', 90, 1327, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'교익 촬영', N'교익 촬영 템플릿', 90, 1326, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'バイトウイング撮影', N'バイトウイング撮影用テンプレート', 90, 1325, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'Kontrolní vyšetření', N'Šablona pro kontrolní vyšetření', 91, 1324, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'da', N'Kontrolundersøgelse', N'Skabelon til kontrolundersøgelse', 91, 1323, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fi', N'Tarkastus', N'Tarkastusmalli', 91, 1322, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hr', N'Kontrolni pregled', N'Predložak za kontrolni pregled', 91, 1321, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'Kontrollvizsgálat', N'Minta kontrollvizsgálathoz', 91, 1320, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'lt', N'Kontrolinė apžiūra', N'Kontrolinės apžiūros šablonas', 91, 1319, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'Check-up', N'Sjabloon check-up', 91, 1318, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'Kontrollundersøkelse', N'Mal for en kontrollundersøkelse', 91, 1317, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'Badanie kontrolne', N'Wzór dla badania kontrolnego', 91, 1316, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'Exame de controle', N'Modelo para exame de controle', 91, 1315, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ro', N'Examen medical', N'Model pentru un examen medical', 91, 1314, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'Контрольное обследование', N'Шаблокн для контрольного обследования', 91, 1313, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sk', N'Kontrolné vyšetrenie', N'Šablóna pre kontrolné vyšetrenie', 91, 1312, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sl', N'Kontrolni pregled', N'Predloga za kontrolni pregled', 91, 1311, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sr', N'Kontrolni pregled', N'Šablon za kontrolni pregled', 91, 1310, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'Kontrollundersökning', N'Mall för en kontrollundersökning', 91, 1309, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'tr', N'Kontrol muayenesi', N'Bir kontrol muayenesi için şablon', 91, 1308, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'校验检查', N'校验检查模板', 91, 1307, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'控制檢查', N'控制檢查版型', 91, 1306, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'제어 검사', N'제어 검사 템플릿', 91, 1305, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'コントロール検査', N'コントロール検査用テンプレート', 91, 1304, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'Intraorální série snímků (15)', N'Intraorální série s 15 snímky', 92, 1303, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'da', N'Intraoral optageserie (15)', N'Intraoral serie med 15 optagelser', 92, 1302, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fi', N'Intraoraalinen kuvasarja (15)', N'Intraoraalinen sarja, 15 kuvaa', 92, 1301, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hr', N'Intraoralna serija snimaka (15)', N'Intraoralna serija sa 15 snimaka', 92, 1300, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'Intraorális felvételsorozat (15)', N'Intraorális sorozat 15 felvétellel', 92, 1299, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'lt', N'Intraoralinių nuotraukų serija (15)', N'Intraoralinė serija su 15 nuotraukų', 92, 1298, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'Intra-orale opnameserie (15)', N'Intra-orale serie met 15 opnamen', 92, 1297, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'Intraoral opptaksserie (15)', N'Intraoral serie med 15 opptak', 92, 1296, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'Seria zdjęć wewnątrzustnych (15)', N'Seria 15 zdjęć wewnątrzustnych', 92, 1295, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'Série intraoral de exposições (15)', N'Série intraoral com 15 exposições', 92, 1294, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ro', N'Serie de radiografie intraorală (15)', N'Serie intraorală cu 15 radiografii', 92, 1293, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'Внутриротовая серия снимков (15)', N'Внутриротовая серия из 15 снимков', 92, 1292, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sk', N'Intraorálna séria snímok (15)', N'Intraorálna séria s 15 snímkami', 92, 1291, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sl', N'Niz intraoralnih slik (15)', N'Intraoralni niz s 15 slikami', 92, 1290, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sr', N'Intraoralna serija snimki (15)', N'Intraoralna serija sa 15 snimki', 92, 1289, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'Intraoral exponeringsserie (15)', N'Intraoral serie med 15 exponeringar', 92, 1288, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'tr', N'Ağız içi kayıt serisi (15)', N'15 kayıtla ağız içi serisi', 92, 1287, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'口内曝光系列 (15)', N'口内曝光系列（15 张）', 92, 1286, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'口內連續攝影 (15)', N'口內連續 15 張攝影', 92, 1285, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'경구내 연속 촬영(15)', N'경구내 연속 촬영, 15개 이미지', 92, 1284, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'口腔内のビューセット (15)', N'15撮影の口腔内セット', 92, 1283, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'Intraorální série snímků (18)', N'Intraorální série s 18 snímky', 93, 1282, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'da', N'Intraoral optageserie (18)', N'Intraoral serie med 18 optagelser', 93, 1281, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fi', N'Intraoraalinen kuvasarja (18)', N'Intraoraalinen sarja, 18 kuvaa', 93, 1280, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hr', N'Intraoralna serija snimaka (18)', N'Intraoralna serija sa 18 snimaka', 93, 1279, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'Intraorális felvételsorozat (18)', N'Intraorális sorozat 18 felvétellel', 93, 1278, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'lt', N'Intraoralinių nuotraukų serija (18)', N'Intraoralinė serija su 18 nuotraukų', 93, 1277, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'Intra-orale opnameserie (18)', N'Intra-orale opnameserie met 18 opnamen', 93, 1276, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'Intraoral opptaksserie (18)', N'Intraoral serie med 18 opptak', 93, 1275, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'Seria zdjęć wewnątrzustnych (18)', N'Seria 18 zdjęć wewnątrzustnych', 93, 1274, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'Série intraoral de exposições  (18)', N'Série intraoral com 18 exposições', 93, 1273, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ro', N'Serie de radiografie intraorală (18)', N'Serie intraorală cu 18 radiografii', 93, 1272, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'Внутриротовая серия снимков (18)', N'Внутриротовая серия из 18 снимков', 93, 1271, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sk', N'Intraorálna séria snímok (18)', N'Intraorálna séria s 18 snímkami', 93, 1270, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sl', N'Niz intraoralnih slik (18)', N'Intraoralni niz z 18 slikami', 93, 1269, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sr', N'Intraoralna serija snimki (18)', N'Intraoralna serija sa 18 snimki', 93, 1268, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'Intraoral exponeringsserie (18)', N'Intraoral serie med 18 exponeringar', 93, 1267, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'tr', N'Ağız içi kayıt serisi (18)', N'18 kayıtla ağız içi serisi', 93, 1266, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'口内曝光系列 (18)', N'口内曝光系列（18 张）', 93, 1265, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'口內連續攝影 (18)', N'口內連續 18 張攝影', 93, 1264, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'경구내 연속 촬영(18)', N'경구내 연속 촬영, 18개 이미지', 93, 1263, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'口腔内のビューセット (18)', N'18撮影の口腔内セット', 93, 1262, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'Intraorální série snímků (21)', N'Intraorální série s 21 snímky', 94, 1261, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'da', N'Intraoral optageserie (21)', N'Intraoral serie med 21 optagelser', 94, 1260, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fi', N'Intraoraalinen kuvasarja (21)', N'Intraoraalinen sarja, 21 kuvaa', 94, 1259, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hr', N'Intraoralna serija snimaka (21)', N'Intraoralna serija sa 21 snimkom', 94, 1258, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'Intraorális felvételsorozat (21)', N'Intraorális sorozat 21 felvétellel', 94, 1257, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'lt', N'Intraoralinių nuotraukų serija (21)', N'Intraoralinė serija su 21 nuotrauka', 94, 1256, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'Intra-orale opnameserie (21)', N'Intra-orale serie met 21 opnamen', 94, 1255, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'Intraoral opptaksserie (21)', N'Intraoral serie med 21 opptak', 94, 1254, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'Seria zdjęć wewnątrzustnych (21)', N'Seria 21 zdjęć wewnątrzustnych', 94, 1253, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'Série intraoral de exposições (21)', N'Série intraoral com 21 exposições', 94, 1252, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ro', N'Serie de radiografie intraorală (21)', N'Serie intraorală cu 21 radiografii', 94, 1251, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'Внутриротовая серия снимков (21)', N'Внутриротовая серия из 21 снимка', 94, 1250, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sk', N'Intraorálna séria snímok (21)', N'Intraorálna séria s 21 snímkami', 94, 1249, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sl', N'Niz intraoralnih slik (21)', N'Intraoralni niz z 21 slikami', 94, 1248, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sr', N'Intraoralna serija snimki (21)', N'Intraoralna serija sa 21 snimkom', 94, 1247, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'Intraoral exponeringsserie (21)', N'Intraoral serie med  21 exponeringar', 94, 1246, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'tr', N'Ağız içi kayıt serisi (21)', N'21 kayıtla ağız içi serisi', 94, 1245, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'口内曝光系列 (21)', N'口内曝光系列（21 张）', 94, 1244, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'口內連續攝影 (21)', N'口內連續 21 張攝影', 94, 1243, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'경구내 연속 촬영(21)', N'경구내 연속 촬영, 21개 이미지', 94, 1242, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'口腔内のビューセット (21)', N'21撮影の口腔内セット', 94, 1241, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'OPG se 4 bite wing snímky', N'Šablona s 1 OPG a 4 bite wing snímky', 95, 1240, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'da', N'OPG-panorama med 4 bitewing-optagelser', N'Skabelon med 1 OPG-panorama- og 4 bitewingoptagelser', 95, 1239, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fi', N'OPG ja 4 purentakappalekuvaa', N'Malli, 1 OPG- ja 4 purentakappalekuvaa', 95, 1238, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hr', N'OPG sa 4 zagrizne rendgenske snimke', N'Predložak sa 1 OPG snimkom i 4 zagrizne rendgenske snimke', 95, 1237, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'OPG 4 fogsorív felvétellel', N'Minta 1 OPG és 4 fogsorívfelvétellel', 95, 1236, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'lt', N'OPG su 4 sąkandžio nuotraukomis', N'Šablonas su 1 OPG ir 4 sąkandžio nuotraukomis', 95, 1235, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'OPG met 4 bijtvleugelopnaen', N'Sjabloon met 1 OPG- en 4 bijtvleugelopnamen', 95, 1234, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'OPG med fire bitewing-opptak', N'Mal med ett OPG- og fire bitewing-opptak', 95, 1233, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'Zdjęcie pantomograficzne z 4 zdjęciami skrzydłowo-zgryzowymi', N'Wzór z 1 zdjęciem pantomograficznym i 4 zdjęciami skrzydłowo-zgryzowymi', 95, 1232, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'Ortopantomografia com 4 exposições da asa de mordente', N'Modelo com 1 ortopantomografia e 4 exposições da asa de mordente', 95, 1231, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ro', N'Radiografie panoramică OPG cu 4 radiografii retroalveolare', N'Model cu 1 radiografie panoramică OPG şi 4 radiografii retroalveolare', 95, 1230, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'Панорамная рентгенография из 4 снимков с прикусным держателем', N'Смешанный шаблон с 1 панорамным снимком и 4 снимками с прикусным держателем', 95, 1229, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sk', N'OPG s 4 bite wing snímkami', N'Šablóna s 1 OPG a 4 bite wing snímkami', 95, 1228, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sl', N'Ortopan tomografija s 4 slikanji z ugrizno tehniko', N'Predloga z 1 ortopan tomografijo in 4 slikanji z ugrizno tehniko', 95, 1227, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sr', N'OPG sa 4 zagrizna radiograma', N'Šablon sa 1 OPG snimkom i 4 zagrizna radiograma', 95, 1226, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'OPG med 4 bitvingeexponeringar', N'Mall med 1 OPG- och 4 bitvingeexponeringar', 95, 1225, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'tr', N'4 diş röntgeni film tableti kaydıyla OPG', N'1 OPG ve 4 diş röntgeni film tableti kaydıyla şablon', 95, 1224, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'带有 4 张咬翼片的全景片', N'带 1 张全景片和 4 张咬翼片的模板', 95, 1223, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'全景片及 4 張咬翼片攝影', N'含 1 張全景片及 4 張咬翼片攝影的版型', 95, 1222, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'OPG, 4회 교익 촬영', N'1회 OPG 촬영 및 4회 교익 촬영 템플릿', 95, 1221, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'4バイトウイング撮影のOPG', N'1 OPGと4バイトウイング撮影用テンプレート', 95, 1220, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'cs', N'Endo vertikální', N'Šablona pro endodontické intraorální snímky ve vertikální orientaci', 96, 1219, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'da', N'Endo vertikal', N'Skabelon til endodontiske intraoraloptagelser med vertikal retning', 96, 1218, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'fi', N'Pysty-endo', N'Intraoraalinen endodontiakuvausmalli, pystysuunta', 96, 1217, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hr', N'Endo okomiti', N'Predložak za endodontske intraoralne snimke s okomitim usmjerenjem', 96, 1216, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'hu', N'Endovertikális', N'Minta az endodonciás intraorális felvételekhez vertikális irányban', 96, 1215, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'lt', N'Endo vertikalus', N'Endodontinių intraoralinių nuotraukų su vertikaliu išdėstymu šablonas', 96, 1214, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'nl', N'Endo verticaal', N'Sjabloon voor endodontische intraorale opnamen', 96, 1213, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'no', N'Vertikal endo', N'Mal for endodontiske intraorale opptak med vertikal eksponering', 96, 1212, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pl', N'Endo pionowo', N'Wzór dla wewnątrzustnych zdjęć endodontycznych w kierunku pionowym', 96, 1211, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'pt-BR', N'Endo vertical', N'Modelo para exposições endodônticas com alinhamento vertical', 96, 1210, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ro', N'Endodontic vertical', N'Model pentru radiografii intraorale endodontice cu orientare verticală', 96, 1209, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ru', N'Эндодонтический вертикальный', N'Шаблон для эндодонтических внутриротовых снимков с вертикальной ориентацией', 96, 1208, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sk', N'Endo vertikálne', N'Šablóna pre endodontické intraorálnesnímky vo vertikálnej orientácii', 96, 1207, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sl', N'Endo vertikalno', N'Predloga za endodontsko intraoralno slikanje z vertikalno orientacijo', 96, 1206, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sr', N'Endo vertikalni', N'Šablon za endodontske intraoralne snimke sa vertikalnim usmerenjem', 96, 1205, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'sv', N'Endo Vertikal', N'Mall för endodontiska intraoralexponeringar med vertikal uppriktning', 96, 1204, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'tr', N'Endo dikey', N'Dikey yönde endodontik ağız içi kayıtlar için şablon', 96, 1203, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-CN', N'垂直牙髓', N'口内牙髓垂直对齐曝光模板', 96, 1202, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'zh-TW', N'根管 (垂直式)', N'垂直式牙髓口內攝影版型', 96, 1201, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ko', N'치근단, 수직', N'치근단 치료용 경구내 촬영(수직 방향) 템플릿', 96, 1200, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'ja', N'歯内垂直', N'垂直配置の歯内治療口腔内撮影用テンプレート', 96, 1199, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'3rd party Volume', N'3rd party Volume', 101, 1198, 0, NULL)

INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Surface model of a CAD/CAM object', N'SSurface model of a CAD/CAM object', 102, 1197, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Oberflächenmodell des CAD/CAM Objekts', N'Oberflächenmodell eines CAD/CAM Objekts', 102, 1196, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Texture of a CAD/CAM object', N'Texture of a CAD/CAM object', 103, 1195, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Textur eines CAD/CAM Objekts', N'Oberflächenmodell des Unterkiefers', 103, 1194, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'CAD/CAM planning', N'CAD/CAM planning', 104, 1193, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'CAD/CAM-Planung', N'CAD/CAM-Planung', 104, 1192, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'CEREC CAD/CAM planning', N'CEREC CAD/CAM planning', 105, 1191, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'CEREC CAD/CAM-Planung', N'CEREC CAD/CAM-Planung', 105, 1190, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'de', N'Viewset', N'Unbekanntes Viewset', 106, 1189, 0, NULL)
INSERT [dbo].[MediaBaseDescriptorLocalization] ([CultureCode], [ShortName], [VerboseName], [MediaDescriptorId], [Id], [IsDeleted], [DeletionDate]) VALUES (N'en', N'Viewset', N'Unknown Viewset', 106, 1188, 0, NULL)
SET IDENTITY_INSERT [dbo].[MediaBaseDescriptorLocalization] OFF
GO
Delete FROM [dbo].[MediaBaseDescriptorLocalization] where VerboseName like '%??%';
GO
PRINT N'Checking existing data against newly created constraints';

GO
ALTER TABLE [dbo].[Finding] WITH CHECK CHECK CONSTRAINT [FK_Finding_Patient_Id];

ALTER TABLE [dbo].[Finding] WITH CHECK CHECK CONSTRAINT [FK_Finding_OwsUser_Id];

ALTER TABLE [dbo].[HardwareSetHardwareComponent] WITH CHECK CHECK CONSTRAINT [FK_HardwareSetHardwareComponent_OwsHardwareComponent];

ALTER TABLE [dbo].[HardwareSetHardwareComponent] WITH CHECK CHECK CONSTRAINT [FK_HardwareSet-HardwareComponent_OwsHardwareSet];

ALTER TABLE [dbo].[MediaBase] WITH CHECK CHECK CONSTRAINT [FK_MediaBase_MediaDescriptor_Id];

ALTER TABLE [dbo].[MediaBaseDescriptorLocalization] WITH CHECK CHECK CONSTRAINT [FK_MediaBaseDescriptorLocalization_MediaBaseDescriptor_Id];

ALTER TABLE [dbo].[MediaBaseQualityCheck] WITH CHECK CHECK CONSTRAINT [FK_MediaBaseUnitHardwareSet_MediaBase];

ALTER TABLE [dbo].[MediaBaseQualityCheck] WITH CHECK CHECK CONSTRAINT [FK_MediaBaseUnitHardwareSet_UnitHardwareSet];

ALTER TABLE [dbo].[MediaFrame] WITH CHECK CHECK CONSTRAINT [FK_MediaFrame_MediaWorkspace_Id];

ALTER TABLE [dbo].[MediaWorkspace] WITH CHECK CHECK CONSTRAINT [FK_MediaWorkspace_MediaSession_Id];

ALTER TABLE [dbo].[OwsHardwareSet] WITH CHECK CHECK CONSTRAINT [FK_OwsHardwareSet_OwsDevice];

ALTER TABLE [dbo].[OwsOrder] WITH CHECK CHECK CONSTRAINT [FK_OwsOrder_OwsUser_IndicatingDoctor];

ALTER TABLE [dbo].[OwsOrder] WITH CHECK CHECK CONSTRAINT [FK_OwsOrder_MediaBaseDescriptor];

ALTER TABLE [dbo].[OwsQualityCheck] WITH CHECK CHECK CONSTRAINT [FK_OwsQualityCheck_OwsHardwareSet];

ALTER TABLE [dbo].[OwsQualityCheck] WITH CHECK CHECK CONSTRAINT [FK_OwsQualityCheck_OwsQualityCheckStandard];

ALTER TABLE [dbo].[OwsQualityCheck] WITH CHECK CHECK CONSTRAINT [FK_OwsQualityCheck_OwsQualityCheck];

ALTER TABLE [dbo].[OwsUserRole] WITH CHECK CHECK CONSTRAINT [FK_OwsUserRole_OwsUser];

ALTER TABLE [dbo].[OwsUserRole] WITH CHECK CHECK CONSTRAINT [FK_OwsUserRole_Role];

GO
PRINT N'Update complete.';


GO
