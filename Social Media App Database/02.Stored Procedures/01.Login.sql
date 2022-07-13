ALTER PROCEDURE [user].Login
@Email NVARCHAR(100),
@Password NVARCHAR(64)
AS
/*
	Author: Alexe Adrian
	Date: 01.07.2022
	Description: Change user's password
	Sample: EXEC [user].Login 'adrian86@yahoo.com', 'Adrian86@'; - Login - after creating user account
			EXEC [user].Login 'adrian86@yahoo.com', 'Adria#n86@'; - Fail to login
*/
BEGIN

	DECLARE @CurrentPassHash BINARY(64) = HASHBYTES('SHA2_256', @Password);
	DECLARE @userID INT;

	IF NOT EXISTS	(	
						SELECT 1 FROM [user].accounts 
						WHERE reg_email = @Email AND [password] = @CurrentPassHash
					)
		BEGIN
			RAISERROR('Invalid Email or Paswword', 16 , 1);
			RETURN;
		END;
	ELSE
		PRINT 'Welcome!'
END;