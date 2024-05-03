
/* Start UserHistoryGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserHistoryGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserHistoryGetById];
GO
CREATE PROCEDURE [dbo].[UserHistoryGetById]
	@Id int = null
AS
BEGIN
	SELECT
		[WebName],
		[GameName],
		[GameId],
		[Bet],
		[Id],
		[UserId],
		[TaskId],
		[ScreenId],
		[BetAmount],
		[Result],
		[ResultClick],
		[CreatedDate]
	FROM [UserHistory]
	WHERE [Id] = @Id
END
GO
/* End UserHistoryGetById */

/* Start UserHistoryGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserHistoryGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserHistoryGetAll];
GO
CREATE PROCEDURE [dbo].[UserHistoryGetAll]
AS
BEGIN
	SELECT
		[WebName],
		[GameName],
		[GameId],
		[Bet],
		[Id],
		[UserId],
		[TaskId],
		[ScreenId],
		[BetAmount],
		[Result],
		[ResultClick],
		[CreatedDate]
	FROM [UserHistory]
END
GO
/* End UserHistoryGetAll */

/* Start UserHistoryGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserHistoryGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserHistoryGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[UserHistoryGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[WebName],
		[GameName],
		[GameId],
		[Bet],
		[Id],
		[UserId],
		[TaskId],
		[ScreenId],
		[BetAmount],
		[Result],
		[ResultClick],
		[CreatedDate]
	FROM [UserHistory]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End UserHistoryGetAllOnPage */

/* Start UserHistoryInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserHistoryInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserHistoryInsert];
GO
CREATE PROCEDURE [dbo].[UserHistoryInsert]
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@GameId bigint = null,
	@Bet nvarchar(256) = null,
	@UserId int = null,
	@TaskId int = null,
	@ScreenId int = null,
	@BetAmount float = null,
	@Result bit = null,
	@ResultClick bit = null,
	@CreatedDate datetime = null
AS
BEGIN
	INSERT INTO [UserHistory]
	(
		[WebName],
		[GameName],
		[GameId],
		[Bet],
		[UserId],
		[TaskId],
		[ScreenId],
		[BetAmount],
		[Result],
		[ResultClick],
		[CreatedDate]
	)
	VALUES
	(
		@WebName,
		@GameName,
		@GameId,
		@Bet,
		@UserId,
		@TaskId,
		@ScreenId,
		@BetAmount,
		@Result,
		@ResultClick,
		@CreatedDate
	)
END
GO
/* End UserHistoryInsert */

/* Start UserHistoryUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserHistoryUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserHistoryUpdate];
GO
CREATE PROCEDURE [dbo].[UserHistoryUpdate]
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@GameId bigint = null,
	@Bet nvarchar(256) = null,
	@Id int = null,
	@UserId int = null,
	@TaskId int = null,
	@ScreenId int = null,
	@BetAmount float = null,
	@Result bit = null,
	@ResultClick bit = null,
	@CreatedDate datetime = null
AS
BEGIN
	UPDATE [UserHistory] SET
		[WebName] = @WebName,
		[GameName] = @GameName,
		[GameId] = @GameId,
		[Bet] = @Bet,
		[UserId] = @UserId,
		[TaskId] = @TaskId,
		[ScreenId] = @ScreenId,
		[BetAmount] = @BetAmount,
		[Result] = @Result,
		[ResultClick] = @ResultClick,
		[CreatedDate] = @CreatedDate
	WHERE [Id] = @Id
END
GO
/* End UserHistoryUpdate */

/* Start UserHistoryDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserHistoryDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserHistoryDelete];
GO
CREATE PROCEDURE [dbo].[UserHistoryDelete]
	@Id int = null
AS
BEGIN
	DELETE [UserHistory]
	WHERE [Id] = @Id
END
GO
/* End UserHistoryDelete */

/* Start UserHistoryDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserHistoryDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserHistoryDeleteAll];
GO
CREATE PROCEDURE [dbo].[UserHistoryDeleteAll]
AS
BEGIN
	DELETE [UserHistory]
END
GO
/* End UserHistoryDeleteAll */
