
/* Start TradeHistoryGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[TradeHistoryGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [TradeHistoryGetById];
GO
CREATE PROCEDURE [dbo].[TradeHistoryGetById]
	@Id bigint = null
AS
BEGIN
	SELECT
		[Id],
		[UserId],
		[Bet],
		[WebName],
		[GameName],
		[GameId],
		[BetAmount],
		[Result],
		[ResultClick],
		[CreatedDate],
		[KeyId],
		[TaskId],
		[ScreenId]
	FROM [TradeHistory]
	WHERE [Id] = @Id
END
GO
/* End TradeHistoryGetById */

/* Start TradeHistoryGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[TradeHistoryGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [TradeHistoryGetAll];
GO
CREATE PROCEDURE [dbo].[TradeHistoryGetAll]
AS
BEGIN
	SELECT
		[Id],
		[UserId],
		[Bet],
		[WebName],
		[GameName],
		[GameId],
		[BetAmount],
		[Result],
		[ResultClick],
		[CreatedDate],
		[KeyId],
		[TaskId],
		[ScreenId]
	FROM [TradeHistory]
END
GO
/* End TradeHistoryGetAll */

/* Start TradeHistoryGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[TradeHistoryGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [TradeHistoryGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[TradeHistoryGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Id],
		[UserId],
		[Bet],
		[WebName],
		[GameName],
		[GameId],
		[BetAmount],
		[Result],
		[ResultClick],
		[CreatedDate],
		[KeyId],
		[TaskId],
		[ScreenId]
	FROM [TradeHistory]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End TradeHistoryGetAllOnPage */

/* Start TradeHistoryInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[TradeHistoryInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [TradeHistoryInsert];
GO
CREATE PROCEDURE [dbo].[TradeHistoryInsert]
	@UserId int = null,
	@Bet nvarchar(256) = null,
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@GameId bigint = null,
	@BetAmount float = null,
	@Result bit = null,
	@ResultClick bit = null,
	@CreatedDate datetime = null,
	@KeyId int = null,
	@TaskId int = null,
	@ScreenId int = null
AS
BEGIN
	INSERT INTO [TradeHistory]
	(
		[UserId],
		[Bet],
		[WebName],
		[GameName],
		[GameId],
		[BetAmount],
		[Result],
		[ResultClick],
		[CreatedDate],
		[KeyId],
		[TaskId],
		[ScreenId]
	)
	VALUES
	(
		@UserId,
		@Bet,
		@WebName,
		@GameName,
		@GameId,
		@BetAmount,
		@Result,
		@ResultClick,
		@CreatedDate,
		@KeyId,
		@TaskId,
		@ScreenId
	)
END
GO
/* End TradeHistoryInsert */

/* Start TradeHistoryUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[TradeHistoryUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [TradeHistoryUpdate];
GO
CREATE PROCEDURE [dbo].[TradeHistoryUpdate]
	@Id bigint = null,
	@UserId int = null,
	@Bet nvarchar(256) = null,
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@GameId bigint = null,
	@BetAmount float = null,
	@Result bit = null,
	@ResultClick bit = null,
	@CreatedDate datetime = null,
	@KeyId int = null,
	@TaskId int = null,
	@ScreenId int = null
AS
BEGIN
	UPDATE [TradeHistory] SET
		[UserId] = @UserId,
		[Bet] = @Bet,
		[WebName] = @WebName,
		[GameName] = @GameName,
		[GameId] = @GameId,
		[BetAmount] = @BetAmount,
		[Result] = @Result,
		[ResultClick] = @ResultClick,
		[CreatedDate] = @CreatedDate,
		[KeyId] = @KeyId,
		[TaskId] = @TaskId,
		[ScreenId] = @ScreenId
	WHERE [Id] = @Id
END
GO
/* End TradeHistoryUpdate */

/* Start TradeHistoryDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[TradeHistoryDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [TradeHistoryDelete];
GO
CREATE PROCEDURE [dbo].[TradeHistoryDelete]
	@Id bigint = null
AS
BEGIN
	DELETE [TradeHistory]
	WHERE [Id] = @Id
END
GO
/* End TradeHistoryDelete */

/* Start TradeHistoryDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[TradeHistoryDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [TradeHistoryDeleteAll];
GO
CREATE PROCEDURE [dbo].[TradeHistoryDeleteAll]
AS
BEGIN
	DELETE [TradeHistory]
END
GO
/* End TradeHistoryDeleteAll */
