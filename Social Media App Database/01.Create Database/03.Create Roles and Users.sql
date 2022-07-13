----------------------------------------------------------------------
--																	--
--					CREATE ROLES LOGINS AND USERS					--
--																	--
----------------------------------------------------------------------

USE [SocialMediaApp];
GO

CREATE LOGIN [SocialMediaAdmin] 
	WITH PASSWORD = '@Februarie22', 
	DEFAULT_DATABASE = [SocialMediaApp], 
	DEFAULT_LANGUAGE = [us_english], 
	CHECK_EXPIRATION = OFF, 
	CHECK_POLICY=ON;
GO

ALTER LOGIN [SocialMediaAdmin] ENABLE
GO

CREATE USER Administrator FOR LOGIN SocialMediaAdmin;
GO

CREATE ROLE DbAdmin AUTHORIZATION Administrator;
GO

GRANT CONTROL ON DATABASE::SocialMediaApp TO DbAdmin;
GO

EXEC sp_addrolemember @rolename = 'DbAdmin', @membername = 'Administrator';
GO

SETUSER 'Administrator';
GO
