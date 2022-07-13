ALTER PROC [CHECK].[ValidEmail](@EMAIL VARCHAR(100))
/*
	Author: Adrian Alexe
	Description: Checks if inserted email is valid
	Sample: EXEC [CHECK].ValidEmail 'algepopescu@gmail.com';	- ok
			EXEC [CHECK].ValidEmail 'algepopescugmail.com';		- without @
			EXEC [CHECK].ValidEmail 'alge.popescu@gmail.com';	- ok
			EXEC [CHECK].ValidEmail 'algepopescu@@gmail.com';	- with @@
			EXEC [CHECK].ValidEmail 'alge@popescu@gmail.com';	- with @@
			EXEC [CHECK].ValidEmail 'algepopescu@gmail..com';	- with ..
*/
AS
BEGIN     
  DECLARE @bitEmailVal AS BIT;
  DECLARE @EmailText VARCHAR(100);

  SET @EmailText=LTRIM(RTRIM(@EMAIL));

  SET @bitEmailVal = CASE WHEN @EmailText = '' THEN 0
                          WHEN @EmailText LIKE '% %' THEN 0
                          WHEN @EmailText LIKE ('%["(),:;<>\]%') THEN 0
                          WHEN SUBSTRING(@EmailText,CHARINDEX('@',@EmailText),LEN(@EmailText)) LIKE ('%[!#$%&*+/=?^`_{|]%') THEN 0
                          WHEN (LEFT(@EmailText,1) LIKE ('[-_.+]') OR RIGHT(@EmailText,1) LIKE ('[-_.+]')) THEN 0                                                                                    
                          WHEN (@EmailText LIKE '%[%' or @EmailText LIKE '%]%') THEN 0
                          WHEN @EmailText LIKE '%@%@%' THEN 0
						  WHEN @EmailText LIKE '%@%..%' THEN 0
                          WHEN @EmailText NOT LIKE '_%@_%._%' THEN 0
                          ELSE 1 
                      END;
	IF (@bitEmailVal = 0)
		RAISERROR('Please input a valid email address', 16, 1);
	ELSE IF EXISTS (SELECT 1 FROM [user].accounts WHERE reg_email = @EmailText)
		RAISERROR('Email already in use', 16, 1);
	ELSE IF LEN(@EmailText) > 50
		RAISERROR('Email too long', 16, 1);
	ELSE
		PRINT 'Valid Email';
END;
GO


