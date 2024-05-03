
/* Start ApClientClickHistoryGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ApClientClickHistoryGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ApClientClickHistoryGetAll];
GO
CREATE PROCEDURE [dbo].[ApClientClickHistoryGetAll]
AS
BEGIN
	SELECT
		[Id],
		[WebName],
		[GameName],
		[CreatedDate],
		[UserId],
		[KeyId],
		[UniqueDeviceId],
		[X],
		[Y],
		[Amount],
		[ActionName],
		[ClickResult],
		[ClickCount]
	FROM [ApClientClickHistory]
END
GO
/* End ApClientClickHistoryGetAll */

/* Start ApClientClickHistoryGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ApClientClickHistoryGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ApClientClickHistoryGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[ApClientClickHistoryGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Id],
		[WebName],
		[GameName],
		[CreatedDate],
		[UserId],
		[KeyId],
		[UniqueDeviceId],
		[X],
		[Y],
		[Amount],
		[ActionName],
		[ClickResult],
		[ClickCount]
	FROM [ApClientClickHistory]
	ORDER BY Id
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End ApClientClickHistoryGetAllOnPage */

/* Start ApClientClickHistoryInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ApClientClickHistoryInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ApClientClickHistoryInsert];
GO
CREATE PROCEDURE [dbo].[ApClientClickHistoryInsert]
	@Id bigint = null,
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@CreatedDate datetime = null,
	@UserId int = null,
	@KeyId int = null,
	@UniqueDeviceId nvarchar(256) = null,
	@X int = null,
	@Y int = null,
	@Amount float = null,
	@ActionName nvarchar(256) = null,
	@ClickResult bit = null,
	@ClickCount int = null
AS
BEGIN
	INSERT INTO [ApClientClickHistory]
	(
		[Id],
		[WebName],
		[GameName],
		[CreatedDate],
		[UserId],
		[KeyId],
		[UniqueDeviceId],
		[X],
		[Y],
		[Amount],
		[ActionName],
		[ClickResult],
		[ClickCount]
	)
	VALUES
	(
		@Id,
		@WebName,
		@GameName,
		@CreatedDate,
		@UserId,
		@KeyId,
		@UniqueDeviceId,
		@X,
		@Y,
		@Amount,
		@ActionName,
		@ClickResult,
		@ClickCount
	)
END
GO
/* End ApClientClickHistoryInsert */

/* Start ApClientClickHistoryDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ApClientClickHistoryDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ApClientClickHistoryDeleteAll];
GO
CREATE PROCEDURE [dbo].[ApClientClickHistoryDeleteAll]
AS
BEGIN
	DELETE [ApClientClickHistory]
END
GO
/* End ApClientClickHistoryDeleteAll */
