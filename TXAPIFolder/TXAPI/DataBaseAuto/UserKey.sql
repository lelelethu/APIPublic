
/* Start UserKeyGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyGetById];
GO
CREATE PROCEDURE [dbo].[UserKeyGetById]
	@Id int = null
AS
BEGIN
	SELECT
		[Id],
		[UserId],
		[KeyId],
		[Status]
	FROM [UserKey]
	WHERE [Id] = @Id
END
GO
/* End UserKeyGetById */

/* Start UserKeyGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyGetAll];
GO
CREATE PROCEDURE [dbo].[UserKeyGetAll]
AS
BEGIN
	SELECT
		[Id],
		[UserId],
		[KeyId],
		[Status]
	FROM [UserKey]
END
GO
/* End UserKeyGetAll */

/* Start UserKeyGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[UserKeyGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Id],
		[UserId],
		[KeyId],
		[Status]
	FROM [UserKey]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End UserKeyGetAllOnPage */

/* Start UserKeyInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyInsert];
GO
CREATE PROCEDURE [dbo].[UserKeyInsert]
	@UserId int = null,
	@KeyId int = null,
	@Status bit = null
AS
BEGIN
	INSERT INTO [UserKey]
	(
		[UserId],
		[KeyId],
		[Status]
	)
	VALUES
	(
		@UserId,
		@KeyId,
		@Status
	)
END
GO
/* End UserKeyInsert */

/* Start UserKeyUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyUpdate];
GO
CREATE PROCEDURE [dbo].[UserKeyUpdate]
	@Id int = null,
	@UserId int = null,
	@KeyId int = null,
	@Status bit = null
AS
BEGIN
	UPDATE [UserKey] SET
		[UserId] = @UserId,
		[KeyId] = @KeyId,
		[Status] = @Status
	WHERE [Id] = @Id
END
GO
/* End UserKeyUpdate */

/* Start UserKeyDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyDelete];
GO
CREATE PROCEDURE [dbo].[UserKeyDelete]
	@Id int = null
AS
BEGIN
	DELETE [UserKey]
	WHERE [Id] = @Id
END
GO
/* End UserKeyDelete */

/* Start UserKeyDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyDeleteAll];
GO
CREATE PROCEDURE [dbo].[UserKeyDeleteAll]
AS
BEGIN
	DELETE [UserKey]
END
GO
/* End UserKeyDeleteAll */
