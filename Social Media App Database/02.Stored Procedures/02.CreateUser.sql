USE SocialMediaApp;
GO

CREATE PROC [user].CreateUser
(
	@reg_email	NVARCHAR(100),
	@username	NVARCHAR(70),
	@password	NVARCHAR(64)
)
/*
	Author: Alexe Adrian
	Date: 15.06.2022
	Description: Create new user
	Sample: EXEC [user].CreateUser 'mara1989@yahoo.com', 'mara89', 'qw56eSr%$%ax';	- no errors
			EXEC [user].CreateUser 'mara1989@yahoo.com', 'mara89', 'qwer%$%ax';		- password error
			EXEC [user].CreateUser 'mara.1989@yahoo..com', 'mara89', 'qwer2%$%ax';	- email error
*/
AS
BEGIN
	BEGIN TRANSACTION
		SET @reg_email = LTRIM(RTRIM(REPLACE(@reg_email, ' ', '')));
		DECLARE @id INT = (SELECT MAX([user_id]) FROM [user].accounts);
		DECLARE @HashPass BINARY(64) = HASHBYTES('SHA2_256', @password);

		BEGIN TRY
			DBCC CHECKIDENT ('[user].accounts', RESEED, @id);
			EXEC [CHECK].ValidEmail @reg_email;
			EXEC [CHECK].ValidUsername @username;
			EXEC [CHECK].ValidPass @password;

			INSERT INTO [user].accounts(reg_email, username, [password])
				SELECT @reg_email, @username, @HashPass;

			SET @id = (SELECT MAX([user_id]) FROM [user].accounts);
			INSERT INTO [user].info([user_id], first_name, last_name)
				VALUES (@id, '', '');			
		END TRY
		BEGIN CATCH
			IF (@@TRANCOUNT > 0)
				BEGIN
					ROLLBACK TRANSACTION;
					DECLARE @ErrMsg varchar(1000),
							@ErrSev INT,
							@ErrLine INT;
					SET @ErrMsg = (SELECT ERROR_MESSAGE());
					SET @ErrSev = (SELECT ERROR_SEVERITY());
					SET @ErrLine = (SELECT ERROR_LINE());

					RAISERROR(@ErrMsg, @ErrSev, @ErrLine);
					INSERT INTO [LOG].Errors(ErrInfo, ErrorMessage, ErrorSeverity, ErrorLine)
						SELECT	'[user].accounts Account Creation Failed!',
								@ErrMsg,
								@ErrSev,
								@ErrLine;
					PRINT 'Account Creation Failed';
				END;
		END CATCH;
	IF (@@TRANCOUNT > 0)
		BEGIN
			COMMIT TRANSACTION;
			PRINT 'Account Created';
		END;
END;
GO

SELECT * 
FROM [user].accounts
ORDER BY [user_id] DESC;

SELECT *
FROM [user].info
ORDER BY [user_id] DESC;


