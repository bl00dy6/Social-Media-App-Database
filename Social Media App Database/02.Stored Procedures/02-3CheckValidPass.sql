ALTER PROC [CHECK].ValidPass(@password VARCHAR(100))
/*
	Author: Adrian Alexe
	Description: Checks if inserted password is valid
	Sample: EXEC [CHECK].ValidPass 'av5542Ssybd24' - no symbols
			EXEC [CHECK].ValidPass 'awdsRd#$gfdgh' - no numbers
			EXEC [CHECK].ValidPass '$#$@34#%@432' - no letters
			EXEC [CHECK].ValidPass 'agwrs#%@432' - no upper case letters
			EXEC [CHECK].ValidPass '1dfyTj3R&$#)'	  - upper case/letters, symbols and numbers
*/
AS
BEGIN     
  DECLARE @PassValid AS BIT;
  DECLARE @PassString VARCHAR(100);

  SET @PassString = @password;

  SET @PassValid = CASE	WHEN @PassString = '' THEN 0
						WHEN LEN(@PassString) < 8 THEN 0
						WHEN LEN(@PassString) > 64 THEN 0
						WHEN @PassString NOT LIKE ('%[a-z]%') THEN 0
						WHEN(PATINDEX('%[A-Z]%' COLLATE Latin1_General_Bin, @PassString) = 0) THEN 0
                        WHEN @PassString NOT LIKE ('%["@()!#$^&*%,:;<>\]%') THEN 0
						WHEN @PassString NOT LIKE ('%[0-9]%') THEN 0
                          ELSE 1 
                      END;
	IF @PassValid = 0
		BEGIN
			RAISERROR('Please use a password between 8 and 64 characters with at least one special character, number, upper case letter', 16, 1);
			PRINT 'Invalid password';
		END;
	IF @PassValid = 1
		BEGIN
			PRINT 'Valid Password'
		END;
END 
GO