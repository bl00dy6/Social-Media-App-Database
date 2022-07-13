----------------------------------------------------------------------
--																	--
--						CREATE TABLES								--
--																	--
----------------------------------------------------------------------

USE SocialMediaApp;
GO
--------------------ACCOUNTS------------------------------------------
CREATE TABLE [user].accounts
(
	[user_id]	INT IDENTITY(1,1) NOT NULL,
	reg_email	NVARCHAR(100) NOT NULL UNIQUE,
	username	NVARCHAR(70) NOT NULL UNIQUE,
	[password]	BINARY(64) NOT NULL,
	created_at	DATETIME DEFAULT GETDATE(),
	CONSTRAINT PK_Accounts
		PRIMARY KEY CLUSTERED([user_id] ASC)
);
----------------------------------------------------------------------
GO
--------------------INFO----------------------------------------------
CREATE TABLE [user].info
(
	[user_id]	INT NOT NULL,
	first_name	NVARCHAR(30) NOT NULL,
	middle_name NVARCHAR(30),
	last_name	NVARCHAR(30) NOT NULL,
	public_email	NVARCHAR(100),
	phone		NVARCHAR(30),
	[address]	NVARCHAR(100),
	city		NVARCHAR(40),
	[state]		NVARCHAR(40),
	hometown	NVARCHAR(40),
	gender		CHAR(1),
	birth_date	DATE,
	website		VARCHAR(100),
	religion	NVARCHAR(30),
	intro		NVARCHAR(101),
	CONSTRAINT PK_User_Info
		PRIMARY KEY CLUSTERED([user_id] ASC),
	CONSTRAINT	FK_info_accounts_userid
		FOREIGN KEY([user_id])
			REFERENCES [user].accounts([user_id])
				ON DELETE CASCADE
);
GO
------------------POSTS-----------------------------------------------
CREATE TABLE post.posts
(
	post_id		INT IDENTITY(1, 1) NOT NULL,
	[user_id]	INT NOT NULL,
	shared_post_id	INT,
	title		NVARCHAR(30) NOT NULL,
	[description]	NVARCHAR(100),
	post_added	DATETIME DEFAULT GETDATE(),
	CONSTRAINT PK_Posts
		PRIMARY KEY CLUSTERED(post_id ASC),
	CONSTRAINT FK_posts_accounts_userid
		FOREIGN KEY([user_id])
			REFERENCES [user].accounts([user_id]),
	CONSTRAINT FK_posts_posts_postid
		FOREIGN KEY(shared_post_id)
			REFERENCES post.posts(post_id)
);
------------------Post Table Indexes---------------------------------
CREATE NONCLUSTERED INDEX IX_posts_UserId
	ON post.posts ([user_id] ASC);

CREATE NONCLUSTERED INDEX IX_posts_SharedPostId
	ON post.posts (shared_post_id ASC);
GO
------------------LIKES-----------------------------------------------
CREATE TABLE post.likes
(
	post_id		INT NOT NULL,
	[user_id]	INT NOT NULL,
	like_date	DATETIME DEFAULT GETDATE(),
	CONSTRAINT PK_Likes
		PRIMARY KEY CLUSTERED(post_id ASC, [user_id] ASC),
	CONSTRAINT FK_likes_posts_postid
		FOREIGN KEY(post_id)
			REFERENCES post.posts(post_id),
	CONSTRAINT FK_likes_accounts_userid
		FOREIGN KEY([user_id])
			REFERENCES [user].accounts([user_id])
);
GO
------------------COMMENTS--------------------------------------------
CREATE TABLE post.comments
(
	comment_id	INT IDENTITY(1, 1) NOT NULL,
	post_id		INT NOT NULL,
	[user_id]	INT	NOT NULL,
	reply_to_comment_id	INT,
	comment		NVARCHAR(300) NOT NULL,
	comment_added	DATETIME DEFAULT GETDATE(),
	CONSTRAINT PK_Comments
		PRIMARY KEY CLUSTERED(comment_id ASC),
	CONSTRAINT FK_comments_posts_postid
		FOREIGN KEY(post_id)
			REFERENCES post.posts(post_id),
	CONSTRAINT FK__comments_accounts_userid
		FOREIGN KEY([user_id])
			REFERENCES [user].accounts([user_id]),
	CONSTRAINT FK_comments_comments_commentid
		FOREIGN KEY(reply_to_comment_id)
			REFERENCES post.comments(comment_id)
);
-------------------Comments Table Indexes-----------------------------
CREATE NONCLUSTERED INDEX IX_comments_PostId
	ON post.comments (post_id ASC);

CREATE NONCLUSTERED INDEX IX_comments_UserId
	ON post.comments ([user_id] ASC);

CREATE NONCLUSTERED INDEX IX_comments_Reply
	ON post.comments (reply_to_comment_id ASC);

GO
------------------PHOTOS----------------------------------------------
CREATE TABLE post.photos
(
	post_id		INT NOT NULL,
	photo_url	VARCHAR(100) NOT NULL,
	CONSTRAINT PK_Photos
		PRIMARY KEY CLUSTERED(post_id ASC, photo_url ASC),
	CONSTRAINT FK_photos_posts_postid
		FOREIGN KEY(post_id)
			REFERENCES post.posts(post_id)
				ON DELETE CASCADE
);
GO
------------------VIDEOS----------------------------------------------
CREATE TABLE post.videos
(
	post_id		INT NOT NULL,
	video_url	VARCHAR(100) NOT NULL,
	CONSTRAINT PK_Videos
		PRIMARY KEY CLUSTERED(post_id ASC, video_url ASC),
	CONSTRAINT FK_videos_posts_postid
		FOREIGN KEY(post_id)
			REFERENCES post.posts(post_id)
				ON DELETE CASCADE
);
GO
--------------------FOLLOWERS-----------------------------------------
CREATE TABLE social.followers
(
	follower_id	INT NOT NULL,
	followed_id	INT NOT NULL,
	follow_date	DATETIME DEFAULT GETDATE(),
	CONSTRAINT PK_Followers
		PRIMARY KEY CLUSTERED(follower_id ASC, followed_id ASC),
	CONSTRAINT FK_followers_accounts_followerid
		FOREIGN KEY(follower_id)
			REFERENCES [user].accounts([user_id]),
	CONSTRAINT FK_followers_accounts_followedid
		FOREIGN KEY(follower_id)
			REFERENCES [user].accounts([user_id])
);
GO
--------------------FRIEND STATUS-------------------------------------
CREATE TABLE social.FriendStatus
(
	status_id	INT IDENTITY(1, 1) NOT NULL,
	status_info	VARCHAR(15) NOT NULL,
	CONSTRAINT PK_FrientStatus
		 PRIMARY KEY CLUSTERED(status_id ASC)
);
GO
--------------------FRIENDS-------------------------------------------
CREATE TABLE social.friends
(
	[user_id]	INT NOT NULL,
	friend_id	INT NOT NULL,
	status_id	INT NOT NULL,
	friend_date	DATETIME DEFAULT GETDATE(),
	CONSTRAINT PK_Friends
		PRIMARY KEY CLUSTERED([user_id] ASC, friend_id ASC),
	CONSTRAINT FK_friends_accounts_userid
		FOREIGN KEY([user_id])
			REFERENCES [user].accounts([user_id]),
	CONSTRAINT FK_friends_accounts_friendid
		FOREIGN KEY(friend_id)
			REFERENCES [user].accounts([user_id]),
	CONSTRAINT FK_friends_FriendStatus_statusid
		FOREIGN KEY(status_id)
			REFERENCES social.FriendStatus(status_id)
);
GO
-------------------ERRORS---------------------------------------------
CREATE TABLE [LOG].Errors
(
	ErrID INT IDENTITY(1, 1) PRIMARY KEY,
	[Login] VARCHAR(55) DEFAULT SYSTEM_USER,
	[User] VARCHAR(55)	DEFAULT CURRENT_USER,
	ErrInfo VARCHAR(1000),
	ErrorMessage VARCHAR(200),
	ErrorSeverity INT,
	ErrorLine INT,
	ErrorDate DATETIME DEFAULT GETDATE()
);
GO
--------------------HISTORY-------------------------------------------
CREATE TABLE [user].history
(
	history_id INT IDENTITY(1, 1) PRIMARY KEY,
	user_email NVARCHAR(100),
	first_name NVARCHAR(30),
	last_name NVARCHAR(30),
	phone NVARCHAR(30),
	public_email NVARCHAR(100),
	[address] NVARCHAR(100),
	city NVARCHAR(40),
	gender CHAR(1),
	birth_date DATE,
	deleted_date DATETIME DEFAULT GETDATE()
);
----------------------------------------------------------------------