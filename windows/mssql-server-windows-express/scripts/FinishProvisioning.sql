USE [SIDEXIS]
GO

INSERT INTO [dbo].[ProvisioningJob]
           ([Id]
           ,[PackageId]
           ,[Package]
           ,[VersionId]
           ,[Version]
           ,[TenantId]
           ,[Tenant]
           ,[StartedAt]
           ,[IsContinuation]
           ,[JobType]
           ,[TargetType]
           ,[Target]
           ,[JobStatus]
           ,[DbServer]
           ,[DbSqlServerInstance]
           ,[DbPort]
           ,[DbSqlServerAuthenticationMode]
           ,[DbSqlServerNetworkProtocol]
           ,[DbSqlServerBrowserIsActive]
           ,[DbSqlServerAdminUser]
           ,[DbSqlServerAdminPassword]
           ,[DbSqlServerStandardUser]
           ,[DbSqlServerStandardPassword]
           ,[DbSqlServerIsIntegratedSecurityAvailable]
           ,[DbSqlServerSeedUser]
           ,[DbSqlServerSeedPassword]
           ,[DbSqlServerWindowsAdmins]
           ,[DbSqlServerWindowsStandardUsers]
           ,[DbBackupShare]
           ,[DbBackupTime]
           ,[DbBackupIntervallHours]
           ,[DbBackupRetentionDays]
           ,[ServiceHostType]
           ,[ServiceUriHostName]
           ,[ServiceUriScheme]
           ,[ServiceUriPort]
           ,[ServiceUriSslPort]
           ,[ServiceUriHostHeader]
           ,[ServiceUriRootPath]
           ,[WindowsServiceUserType]
           ,[WindowsServiceUserName]
           ,[WindowsServicePassword]
           ,[PdataPath]
           ,[PdataShareIsOnNas]
           ,[PdataShareUsers]
           ,[DeploymentPath]
           ,[DeploymentShareIsOnNas]
           ,[DeploymentShareUsers]
           ,[PluginConfigurationMigrationStatus]
           ,[StationConfigurationMigrationStatus]
           ,[GlobalConfigurationMigrationStatus])
     VALUES 
			-- Server Provisioning Data
			(NEWID(),
			'f93ca92f-7c0b-4da6-8327-cad1a7f80ea6',
			'SIDEXIS 4',
			'430e1156-6996-42d9-af5f-a0acb11ab430',
			'4.3.0',
			NULL,
			Default,
			GETDATE(),
			'False',
			0,
			0,
			HOST_NAME(),
			4,
			HOST_NAME(),
			'SIDEXIS_SQL',
			42916,
			NULL,
			NULL,
			NULL,
			'SXAdmin',
			'boards',
			'SXUser',
			'sirona',
			'True',
			'Sa',
			NULL,
			NULL,
			NULL,
			NULL,
			'22:00:00',
			24,
			7,
			NULL,
			HOST_NAME(),
			NULL,
			42927,
			42928,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			'\\' + HOST_NAME() + '\PDATA',
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			0,
			0,
			0),

			-- Client Provisioning Data
			(NEWID(),
			'f93ca92f-7c0b-4da6-8327-cad1a7f80ea6',
			'SIDEXIS 4',
			'430e1156-6996-42d9-af5f-a0acb11ab430',
			'4.3.0',
			NULL,
			Default,
			GETDATE(),
			'False',
			0,
			1,
			HOST_NAME(),
			4,
			HOST_NAME(),
			'SIDEXIS_SQL',
			42916,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			'SXUser',
			'sirona',
			'False',
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			HOST_NAME(),
			NULL,
			42927,
			42928,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			'\\' + HOST_NAME() + '\PDATA',
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			0,
			0,
			0)
GO