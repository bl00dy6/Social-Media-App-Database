ALTER PROC [CHECK].ValidUsername(@username VARCHAR(100))
/*
	Author: Adrian Alexe
	Date: 16.06.2022
	Description: Checks if inserted username is valid
	Sample: EXEC [CHECK].ValidUsername @username = 'adrian1999'; - ok
			EXEC [CHECK].ValidUsername @username = 'adri[]an1999'; - fail
			EXEC [CHECK].ValidUsername @username = 'garrison.flatley'; - username in use
*/
AS
BEGIN     
  DECLARE @bitUserVal AS BIT;
  DECLARE @UserText VARCHAR(100);

  SET @UserText=LTRIM(RTRIM(@username));

  SET @bitUserVal = CASE  WHEN @UserText = '' THEN 0
                          WHEN @UserText LIKE '% %' THEN 0
                          WHEN @UserText LIKE ('%["(),:;\]%') THEN 0                                                                                  
                          WHEN (@UserText LIKE '%[%' or @UserText LIKE '%]%') THEN 0
                          WHEN @UserText LIKE '%@%.%' THEN 0
                          ELSE 1 
                      END;
	IF (@bitUserVal = 0)
		RAISERROR('Please input a valid username', 16, 1);
	ELSE IF EXISTS (SELECT 1 FROM [user].accounts WHERE username = @UserText)
		RAISERROR('Username already in use', 16, 1);
	ELSE IF LEN(@UserText) > 30
		RAISERROR('Username too long, maximum 30 characters allowed', 16, 1);
	ELSE
		PRINT 'Valid Username';
END;
GO