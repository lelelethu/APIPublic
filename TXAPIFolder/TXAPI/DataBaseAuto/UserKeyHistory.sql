
/* Start UserKeyHistoryGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyHistoryGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyHistoryGetById];
GO
CREATE PROCEDURE [dbo].[UserKeyHistoryGetById]
	@Id bigint = null
AS
BEGIN
	SELECT
		[Id],
		[UserId],
		[KeyId],
		[WebName],
		[GameName],
		[Bet_expected],
		[Amount],
		[Result],
		[GameId],
		[Status],
		[IsDone],
		[CreateTime]
	FROM [UserKeyHistory]
	WHERE [Id] = @Id
END
GO
/* End UserKeyHistoryGetById */

/* Start UserKeyHistoryGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyHistoryGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyHistoryGetAll];
GO
CREATE PROCEDURE [dbo].[UserKeyHistoryGetAll]
AS
BEGIN
	SELECT
		[Id],
		[UserId],
		[KeyId],
		[WebName],
		[GameName],
		[Bet_expected],
		[Amount],
		[Result],
		[GameId],
		[Status],
		[IsDone],
		[CreateTime]
	FROM [UserKeyHistory]
END
GO
/* End UserKeyHistoryGetAll */

/* Start UserKeyHistoryGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyHistoryGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyHistoryGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[UserKeyHistoryGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Id],
		[UserId],
		[KeyId],
		[WebName],
		[GameName],
		[Bet_expected],
		[Amount],
		[Result],
		[GameId],
		[Status],
		[IsDone],
		[CreateTime]
	FROM [UserKeyHistory]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End UserKeyHistoryGetAllOnPage */

/* Start UserKeyHistoryInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyHistoryInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyHistoryInsert];
GO
CREATE PROCEDURE [dbo].[UserKeyHistoryInsert]
	@UserId int = null,
	@KeyId int = null,
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@Bet_expected bit = null,
	@Amount float = null,
	@Result bit = null,
	@GameId bigint = null,
	@Status int = null,
	@IsDone int = null,
	@CreateTime datetime = null
AS
BEGIN
	INSERT INTO [UserKeyHistory]
	(
		[UserId],
		[KeyId],
		[WebName],
		[GameName],
		[Bet_expected],
		[Amount],
		[Result],
		[GameId],
		[Status],
		[IsDone],
		[CreateTime]
	)
	VALUES
	(
		@UserId,
		@KeyId,
		@WebName,
		@GameName,
		@Bet_expected,
		@Amount,
		@Result,
		@GameId,
		@Status,
		@IsDone,
		@CreateTime
	)
END
GO
/* End UserKeyHistoryInsert */

/* Start UserKeyHistoryUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyHistoryUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyHistoryUpdate];
GO
CREATE PROCEDURE [dbo].[UserKeyHistoryUpdate]
	@Id bigint = null,
	@UserId int = null,
	@KeyId int = null,
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@Bet_expected bit = null,
	@Amount float = null,
	@Result bit = null,
	@GameId bigint = null,
	@Status int = null,
	@IsDone int = null,
	@CreateTime datetime = null
AS
BEGIN
	UPDATE [UserKeyHistory] SET
		[UserId] = @UserId,
		[KeyId] = @KeyId,
		[WebName] = @WebName,
		[GameName] = @GameName,
		[Bet_expected] = @Bet_expected,
		[Amount] = @Amount,
		[Result] = @Result,
		[GameId] = @GameId,
		[Status] = @Status,
		[IsDone] = @IsDone,
		[CreateTime] = @CreateTime
	WHERE [Id] = @Id
END
GO
/* End UserKeyHistoryUpdate */

/* Start UserKeyHistoryDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyHistoryDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyHistoryDelete];
GO
CREATE PROCEDURE [dbo].[UserKeyHistoryDelete]
	@Id bigint = null
AS
BEGIN
	DELETE [UserKeyHistory]
	WHERE [Id] = @Id
END
GO
/* End UserKeyHistoryDelete */

/* Start UserKeyHistoryDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyHistoryDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyHistoryDeleteAll];
GO
CREATE PROCEDURE [dbo].[UserKeyHistoryDeleteAll]
AS
BEGIN
	DELETE [UserKeyHistory]
END
GO
/* End UserKeyHistoryDeleteAll */
