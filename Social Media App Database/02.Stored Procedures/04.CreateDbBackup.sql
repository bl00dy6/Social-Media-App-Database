CREATE PROCEDURE [SYSTEM].CreateDbBackup
(
	@DbName VARCHAR(200) = [SocialMediaApp],
	@DiskPath VARCHAR(MAX) = 'D:\D\SI T-SQL\SocialMediaApp Backup\SocialMediaApp.bak'
)
/*
	Author: Adrian Alexe
	Date: 18.06.2022
	Description: Creates Backup
	Sample: EXEC [SYSTEM].CreateDbBackup; - ok
			EXEC [SYSTEM].CreateDbBackup @DbName = DEFAULT, @DiskPath = DEFAULT; - ok
*/
AS
BEGIN
	DECLARE @ErrMsg VARCHAR(1000);
	DECLARE @ErrSev INT;
	DECLARE @ErrLine INT;
		BEGIN TRY
			BACKUP DATABASE @DbName
			TO DISK = @DiskPath
			WITH FORMAT;
			PRINT 'Backup completed!';
		END TRY
		BEGIN CATCH
				BEGIN
					SET @ErrMsg = (SELECT ERROR_MESSAGE());
					SET @ErrSev = (SELECT ERROR_SEVERITY());
					SET @ErrLine = (SELECT ERROR_LINE());
							INSERT INTO [SocialMediaApp].[LOG].Errors(ErrInfo, ErrorMessage, ErrorSeverity, ErrorLine)
							SELECT	@DbName + ' - Backup Failed ' + ' SP - usp_CreateDbBackup',
									@ErrMsg,
									@ErrSev,
									@ErrLine;
							RAISERROR(@ErrMsg, @ErrSev, @ErrLine);
							PRINT 'Backup Failed!';
				END;
		END CATCH
END;
