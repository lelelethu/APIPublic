
/* Start UserKeyHistoryImageGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyHistoryImageGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyHistoryImageGetById];
GO
CREATE PROCEDURE [dbo].[UserKeyHistoryImageGetById]
	@Id bigint = null
AS
BEGIN
	SELECT
		[Id],
		[Image],
		[CreatedDate],
		[UserKeyHistoryId],
		[GameId]
	FROM [UserKeyHistoryImage]
	WHERE [Id] = @Id
END
GO
/* End UserKeyHistoryImageGetById */

/* Start UserKeyHistoryImageGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyHistoryImageGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyHistoryImageGetAll];
GO
CREATE PROCEDURE [dbo].[UserKeyHistoryImageGetAll]
AS
BEGIN
	SELECT
		[Id],
		[Image],
		[CreatedDate],
		[UserKeyHistoryId],
		[GameId]
	FROM [UserKeyHistoryImage]
END
GO
/* End UserKeyHistoryImageGetAll */

/* Start UserKeyHistoryImageGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyHistoryImageGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyHistoryImageGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[UserKeyHistoryImageGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Id],
		[Image],
		[CreatedDate],
		[UserKeyHistoryId],
		[GameId]
	FROM [UserKeyHistoryImage]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End UserKeyHistoryImageGetAllOnPage */

/* Start UserKeyHistoryImageInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyHistoryImageInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyHistoryImageInsert];
GO
CREATE PROCEDURE [dbo].[UserKeyHistoryImageInsert]
	@Image nvarchar(256) = null,
	@CreatedDate datetime = null,
	@UserKeyHistoryId bigint = null,
	@GameId bigint = null
AS
BEGIN
	INSERT INTO [UserKeyHistoryImage]
	(
		[Image],
		[CreatedDate],
		[UserKeyHistoryId],
		[GameId]
	)
	VALUES
	(
		@Image,
		@CreatedDate,
		@UserKeyHistoryId,
		@GameId
	)
END
GO
/* End UserKeyHistoryImageInsert */

/* Start UserKeyHistoryImageUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyHistoryImageUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyHistoryImageUpdate];
GO
CREATE PROCEDURE [dbo].[UserKeyHistoryImageUpdate]
	@Id bigint = null,
	@Image nvarchar(256) = null,
	@CreatedDate datetime = null,
	@UserKeyHistoryId bigint = null,
	@GameId bigint = null
AS
BEGIN
	UPDATE [UserKeyHistoryImage] SET
		[Image] = @Image,
		[CreatedDate] = @CreatedDate,
		[UserKeyHistoryId] = @UserKeyHistoryId,
		[GameId] = @GameId
	WHERE [Id] = @Id
END
GO
/* End UserKeyHistoryImageUpdate */

/* Start UserKeyHistoryImageDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyHistoryImageDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyHistoryImageDelete];
GO
CREATE PROCEDURE [dbo].[UserKeyHistoryImageDelete]
	@Id bigint = null
AS
BEGIN
	DELETE [UserKeyHistoryImage]
	WHERE [Id] = @Id
END
GO
/* End UserKeyHistoryImageDelete */

/* Start UserKeyHistoryImageDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyHistoryImageDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyHistoryImageDeleteAll];
GO
CREATE PROCEDURE [dbo].[UserKeyHistoryImageDeleteAll]
AS
BEGIN
	DELETE [UserKeyHistoryImage]
END
GO
/* End UserKeyHistoryImageDeleteAll */
