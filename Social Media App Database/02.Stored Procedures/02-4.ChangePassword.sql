ALTER PROCEDURE [user].ChangePassword
(
	@Email VARCHAR(100),
	@CurrentPassword NVARCHAR(64),
	@NewPassword1 NVARCHAR(64),
	@NewPassword2 NVARCHAR(64)
)
/*
	Author: Alexe Adrian
	Date: 01.07.2022
	Description: Change user's password
	Sample: EXEC [user].ChangePassword 'adrian86@yahoo.com', 'password', 'Adrian86@', 'Adrian86@'; - login failed
			EXEC [user].ChangePassword 'adrian86@yahoo.com', 'Adrian86@', 'Adrian86@', 'Adrian86@'; - new pass = old pass
			EXEC [user].ChangePassword 'adrian86@yahoo.com', 'Adrian86@', 'Adrian862@', 'Adrian861@'; - pass check failed
			EXEC [user].ChangePassword 'adrian86@yahoo.com', 'Adrian86@', 'Adrian861@', 'Adrian861@' - success
*/
AS
BEGIN
	DECLARE @CurrentPassHash BINARY(64) = HASHBYTES('SHA2_256', @CurrentPassword);
	DECLARE @NewPassHash1 BINARY(64) = HASHBYTES('SHA2_256', @NewPassword1);
	DECLARE @userID INT;

	IF NOT EXISTS	(	
						SELECT 1 FROM [user].accounts 
						WHERE reg_email = @Email AND [password] = @CurrentPassHash
					)
		BEGIN
			RAISERROR('Email or Paswword invalid', 16 , 1);
			RETURN;
		END;
	ELSE
		SELECT @userID =	[user_id] 
							FROM [user].accounts 
							WHERE reg_email = @Email AND [password] = @CurrentPassHash;

	EXEC [CHECK].ValidPass @NewPassword1;

	IF (@NewPassHash1 = @CurrentPassHash)
		BEGIN
			RAISERROR('New password must be different from the current one', 16, 1);
			RETURN;
		END;
	
	IF (@NewPassword1 <> @NewPassword2)
		BEGIN
			RAISERROR('Password do not match', 16, 1);
			RETURN;
		END;
	BEGIN TRANSACTION
		BEGIN TRY
			UPDATE [user].accounts
			SET [password] = @NewPassHash1
			WHERE [user_id] = @userID;
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
					PRINT 'Password change failed';
					INSERT INTO [LOG].Errors(ErrInfo, ErrorMessage, ErrorSeverity, ErrorLine)
					SELECT	'[user].accounts - password change failed',
							@ErrMsg,
							@ErrSev,
							@ErrLine;
				END;
		END CATCH
	IF (@@TRANCOUNT > 0)
		BEGIN
			COMMIT TRANSACTION;
			PRINT 'Password changed';
		END;
END;

--EXEC [user].ChangePassword 'adrian86@yahoo.com', 'Adrian86@', 'Adrian861@', 'Adrian861@';
