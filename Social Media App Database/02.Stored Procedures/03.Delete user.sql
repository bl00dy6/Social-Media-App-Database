CREATE PROCEDURE [user].DeleteUser
@UserID INT
/*
	Author: Alexe Adrian
	Date: 15.06.2022
	Description: Delete account
	Sample: EXEC [user].DeleteUser 2;
*/
AS
BEGIN
	DECLARE @Email NVARCHAR(100) = (SELECT reg_email FROM [user].accounts WHERE [user_id] = @UserID);
	BEGIN TRANSACTION
		BEGIN TRY
			INSERT INTO [user].history([user_id], user_email)
			SELECT @UserID,
				   @Email;

			;WITH sh_posts AS 
				(
					SELECT p.post_id, p.shared_post_id
					FROM post.posts p
					WHERE p.[user_id] = @UserID

					UNION ALL

					SELECT pp.post_id, pp.shared_post_id
					FROM post.posts pp	
					JOIN sh_posts sp
						ON sp.post_id = pp.shared_post_id
				)
			DELETE FROM post.likes WHERE post_id IN 
													(SELECT spd.post_id FROM sh_posts spd);
			DELETE FROM post.likes WHERE [user_id] = @UserID;

			;WITH sh_posts AS 
				(
					SELECT p.post_id, p.shared_post_id
					FROM post.posts p
					WHERE p.[user_id] = @UserID

					UNION ALL

					SELECT pp.post_id, pp.shared_post_id
					FROM post.posts pp	
					JOIN sh_posts sp
						ON sp.post_id = pp.shared_post_id
				), commentCTE AS 
					(
						SELECT c.comment_id, c.reply_to_comment_id
						FROM post.comments c
						WHERE c.[user_id] = @UserID

						UNION ALL

						SELECT cc.comment_id, cc.reply_to_comment_id
						FROM post.comments cc	
						JOIN commentCTE ct
							ON ct.comment_id = cc.reply_to_comment_id

				), commentCTE2 AS 
					(
						SELECT c.comment_id, c.reply_to_comment_id
						FROM post.comments c
						WHERE c.post_id IN (SELECT sh.post_id FROM sh_posts sh) 

						UNION ALL

						SELECT cc.comment_id, cc.reply_to_comment_id
						FROM post.comments cc	
						JOIN commentCTE2 ct2
							ON ct2.comment_id = cc.reply_to_comment_id

					)

			DELETE FROM post.comments WHERE comment_id IN 
														  (SELECT dd.comment_id FROM commentCTE dd
														  UNION ALL
														  SELECT dd2.comment_id FROM commentCTE2 dd2);


			;WITH sh_posts AS 
				(
					SELECT p.post_id, p.shared_post_id
					FROM post.posts p
					WHERE p.[user_id] = @UserID

					UNION ALL

					SELECT pp.post_id, pp.shared_post_id
					FROM post.posts pp	
					JOIN sh_posts sp
						ON sp.post_id = pp.shared_post_id
				)
			DELETE FROM post.photos WHERE post_id IN 
													 (SELECT spd.post_id FROM sh_posts spd);


			;WITH sh_posts AS 
				(
					SELECT p.post_id, p.shared_post_id
					FROM post.posts p
					WHERE p.[user_id] = @UserID

					UNION ALL

					SELECT pp.post_id, pp.shared_post_id
					FROM post.posts pp	
					JOIN sh_posts sp
						ON sp.post_id = pp.shared_post_id
				)
			DELETE FROM post.videos WHERE post_id IN 
													 (SELECT spd.post_id FROM sh_posts spd);


			;WITH sh_posts AS 
				(
					SELECT p.post_id, p.shared_post_id
					FROM post.posts p
					WHERE p.[user_id] = @UserID

					UNION ALL

					SELECT pp.post_id, pp.shared_post_id
					FROM post.posts pp	
					JOIN sh_posts sp
						ON sp.post_id = pp.shared_post_id
				)
			DELETE FROM post.posts WHERE post_id IN 
													(SELECT spd.post_id FROM sh_posts spd);
			DELETE FROM post.posts WHERE [user_id] = @UserID;

			DELETE FROM social.followers WHERE followed_id = @UserID OR follower_id = @UserID;
			DELETE FROM social.friends WHERE [user_id] = @UserID OR friend_id = @UserID;
			DELETE FROM [user].accounts WHERE [user_id] = @UserID;
		END TRY
		BEGIN CATCH
			DECLARE @ErrMsg varchar(1000),
					@ErrSev INT,
					@ErrLine INT;
			IF (@@TRANCOUNT > 0)
			BEGIN
				ROLLBACK TRAN;
				PRINT 'Delete account failed';
				SET @ErrMsg = (SELECT ERROR_MESSAGE());
				SET @ErrSev = (SELECT ERROR_SEVERITY());
				SET @ErrLine = (SELECT ERROR_LINE());
				INSERT INTO [LOG].Errors(ErrInfo, ErrorMessage, ErrorSeverity, ErrorLine)
				SELECT	'[user].account Failed to delete account',
						@ErrMsg,
						@ErrSev,
						@ErrLine;
				RAISERROR(@ErrMsg, @ErrSev, @ErrLine);
			END
		END CATCH
	IF (@@TRANCOUNT > 0)
		BEGIN
			COMMIT TRANSACTION;
			PRINT 'Account deleted';
		END;
END;

SELECT *
FROM [user].accounts
WHERE [user_id] = 2;