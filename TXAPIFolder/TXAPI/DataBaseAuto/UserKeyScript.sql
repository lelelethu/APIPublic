
/* Start UserKeyScriptGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyScriptGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyScriptGetById];
GO
CREATE PROCEDURE [dbo].[UserKeyScriptGetById]
	@Id bigint = null
AS
BEGIN
	SELECT
		[Id],
		[UserId],
		[KeyId],
		[Bet_script],
		[WebName],
		[GameName],
		[GameId],
		[Status],
		[CreateTime]
	FROM [UserKeyScript]
	WHERE [Id] = @Id
END
GO
/* End UserKeyScriptGetById */

/* Start UserKeyScriptGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyScriptGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyScriptGetAll];
GO
CREATE PROCEDURE [dbo].[UserKeyScriptGetAll]
AS
BEGIN
	SELECT
		[Id],
		[UserId],
		[KeyId],
		[Bet_script],
		[WebName],
		[GameName],
		[GameId],
		[Status],
		[CreateTime]
	FROM [UserKeyScript]
END
GO
/* End UserKeyScriptGetAll */

/* Start UserKeyScriptGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyScriptGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyScriptGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[UserKeyScriptGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Id],
		[UserId],
		[KeyId],
		[Bet_script],
		[WebName],
		[GameName],
		[GameId],
		[Status],
		[CreateTime]
	FROM [UserKeyScript]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End UserKeyScriptGetAllOnPage */

/* Start UserKeyScriptInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyScriptInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyScriptInsert];
GO
CREATE PROCEDURE [dbo].[UserKeyScriptInsert]
	@UserId int = null,
	@KeyId int = null,
	@Bet_script bit = null,
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@GameId bigint = null,
	@Status int = null,
	@CreateTime datetime = null
AS
BEGIN
	INSERT INTO [UserKeyScript]
	(
		[UserId],
		[KeyId],
		[Bet_script],
		[WebName],
		[GameName],
		[GameId],
		[Status],
		[CreateTime]
	)
	VALUES
	(
		@UserId,
		@KeyId,
		@Bet_script,
		@WebName,
		@GameName,
		@GameId,
		@Status,
		@CreateTime
	)
END
GO
/* End UserKeyScriptInsert */

/* Start UserKeyScriptUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyScriptUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyScriptUpdate];
GO
CREATE PROCEDURE [dbo].[UserKeyScriptUpdate]
	@Id bigint = null,
	@UserId int = null,
	@KeyId int = null,
	@Bet_script bit = null,
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@GameId bigint = null,
	@Status int = null,
	@CreateTime datetime = null
AS
BEGIN
	UPDATE [UserKeyScript] SET
		[UserId] = @UserId,
		[KeyId] = @KeyId,
		[Bet_script] = @Bet_script,
		[WebName] = @WebName,
		[GameName] = @GameName,
		[GameId] = @GameId,
		[Status] = @Status,
		[CreateTime] = @CreateTime
	WHERE [Id] = @Id
END
GO
/* End UserKeyScriptUpdate */

/* Start UserKeyScriptDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyScriptDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyScriptDelete];
GO
CREATE PROCEDURE [dbo].[UserKeyScriptDelete]
	@Id bigint = null
AS
BEGIN
	DELETE [UserKeyScript]
	WHERE [Id] = @Id
END
GO
/* End UserKeyScriptDelete */

/* Start UserKeyScriptDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyScriptDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyScriptDeleteAll];
GO
CREATE PROCEDURE [dbo].[UserKeyScriptDeleteAll]
AS
BEGIN
	DELETE [UserKeyScript]
END
GO
/* End UserKeyScriptDeleteAll */
