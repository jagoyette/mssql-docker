use master
GO

-- Create the database
IF NOT EXISTS (SELECT * FROM master.sys.databases WHERE name = N'SIDEXIS') CREATE DATABASE SIDEXIS
ALTER DATABASE SIDEXIS SET RECOVERY SIMPLE
ALTER DATABASE SIDEXIS COLLATE Latin1_General_CI_AS
GO

-- Create login for SXAdmin
IF EXISTS (SELECT * from master.sys.sql_logins where name='SXAdmin') DROP LOGIN [SXAdmin]
CREATE LOGIN SXAdmin WITH PASSWORD = N'boards', CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF
GO

-- set sysadmin role
sp_addsrvrolemember @loginame = N'SXAdmin', @rolename = N'sysadmin'
GO

-- Create login for SXUser
IF EXISTS (SELECT * from master.sys.sql_logins where name='SXUser') DROP LOGIN [SXUser]
CREATE LOGIN SXUser WITH PASSWORD = N'sirona', CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF
GO

-- Set default database
sp_defaultdb @loginame = N'SXUser', @defdb = N'SIDEXIS'
GO

-- Create database user
USE SIDEXIS; IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'SXUser') DROP USER [SXUser]
USE SIDEXIS CREATE USER [SXUser] FOR LOGIN [SXUser]
USE SIDEXIS exec sp_addrolemember  @rolename='db_datareader', @membername='SXUser'
USE SIDEXIS exec sp_addrolemember  @rolename='db_datawriter', @membername='SXUser'
GO
