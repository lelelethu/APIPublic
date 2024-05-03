
/* Start ResultWSSGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSSGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSSGetById];
GO
CREATE PROCEDURE [dbo].[ResultWSSGetById]
	@Id bigint = null
AS
BEGIN
	SELECT
		[Id],
		[WebName],
		[GameName],
		[GameId],
		[Result],
		[GameDateEnd],
		[CreatedDate]
	FROM [ResultWSS]
	WHERE [Id] = @Id
END
GO
/* End ResultWSSGetById */

/* Start ResultWSSGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSSGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSSGetAll];
GO
CREATE PROCEDURE [dbo].[ResultWSSGetAll]
AS
BEGIN
	SELECT
		[Id],
		[WebName],
		[GameName],
		[GameId],
		[Result],
		[GameDateEnd],
		[CreatedDate]
	FROM [ResultWSS]
END
GO
/* End ResultWSSGetAll */

/* Start ResultWSSGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSSGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSSGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[ResultWSSGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Id],
		[WebName],
		[GameName],
		[GameId],
		[Result],
		[GameDateEnd],
		[CreatedDate]
	FROM [ResultWSS]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End ResultWSSGetAllOnPage */

/* Start ResultWSSInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSSInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSSInsert];
GO
CREATE PROCEDURE [dbo].[ResultWSSInsert]
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@GameId bigint = null,
	@Result bit = null,
	@GameDateEnd datetime = null,
	@CreatedDate datetime = null
AS
BEGIN
	INSERT INTO [ResultWSS]
	(
		[WebName],
		[GameName],
		[GameId],
		[Result],
		[GameDateEnd],
		[CreatedDate]
	)
	VALUES
	(
		@WebName,
		@GameName,
		@GameId,
		@Result,
		@GameDateEnd,
		@CreatedDate
	)
END
GO
/* End ResultWSSInsert */

/* Start ResultWSSUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSSUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSSUpdate];
GO
CREATE PROCEDURE [dbo].[ResultWSSUpdate]
	@Id bigint = null,
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@GameId bigint = null,
	@Result bit = null,
	@GameDateEnd datetime = null,
	@CreatedDate datetime = null
AS
BEGIN
	UPDATE [ResultWSS] SET
		[WebName] = @WebName,
		[GameName] = @GameName,
		[GameId] = @GameId,
		[Result] = @Result,
		[GameDateEnd] = @GameDateEnd,
		[CreatedDate] = @CreatedDate
	WHERE [Id] = @Id
END
GO
/* End ResultWSSUpdate */

/* Start ResultWSSDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSSDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSSDelete];
GO
CREATE PROCEDURE [dbo].[ResultWSSDelete]
	@Id bigint = null
AS
BEGIN
	DELETE [ResultWSS]
	WHERE [Id] = @Id
END
GO
/* End ResultWSSDelete */

/* Start ResultWSSDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSSDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSSDeleteAll];
GO
CREATE PROCEDURE [dbo].[ResultWSSDeleteAll]
AS
BEGIN
	DELETE [ResultWSS]
END
GO
/* End ResultWSSDeleteAll */
