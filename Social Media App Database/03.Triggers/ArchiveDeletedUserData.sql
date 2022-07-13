USE SocialMediaApp;
GO
CREATE TRIGGER utr_InsertDeletedUserDataIntoHistoryTbl
ON [user].info
FOR DELETE
/*
	Author: Adrian Alexe
	Date: 06.07.2022
	Description: Archive all user data from a deleted account to [user].history table.
*/
AS
BEGIN
		DECLARE @DeletedID INT,
				@first_name NVARCHAR(100),
				@last_name  NVARCHAR(100),
				@phone NVARCHAR(30),
				@public_email NVARCHAR(100),
				@address NVARCHAR(100),
				@city NVARCHAR(40),
				@gender CHAR(1),
				@birth_date DATE;

		SELECT [user_id] INTO #TempDeletedTbl
			FROM deleted;
		WHILE (EXISTS(SELECT [user_id] FROM #TempDeletedTbl))
			BEGIN
				SELECT TOP 1 @DeletedID = [user_id] 
					FROM #TempDeletedTbl;

				SELECT	@first_name = first_name,
						@last_name = last_name,
						@phone = phone,
						@public_email = public_email,
						@address = [address],
						@city = city,
						@gender = gender,
						@birth_date = birth_date	
				FROM deleted 
				WHERE [user_id] = @DeletedID;

				UPDATE [user].history
				SET	first_name =	@first_name,
					last_name =		@last_name,
					phone =			@phone,
					public_email =	@public_email,
					[address] =		@address,
					city =			@city,
					gender =		@gender,
					birth_date =	@birth_date

				WHERE [user_id] =	@DeletedID;

				DELETE FROM #TempDeletedTbl WHERE [user_id] = @DeletedID;
			END;
END;