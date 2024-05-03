
/* Start ResultTESGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultTESGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultTESGetById];
GO
CREATE PROCEDURE [dbo].[ResultTESGetById]
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
	FROM [ResultTES]
	WHERE [Id] = @Id
END
GO
/* End ResultTESGetById */

/* Start ResultTESGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultTESGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultTESGetAll];
GO
CREATE PROCEDURE [dbo].[ResultTESGetAll]
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
	FROM [ResultTES]
END
GO
/* End ResultTESGetAll */

/* Start ResultTESGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultTESGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultTESGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[ResultTESGetAllOnPage]
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
	FROM [ResultTES]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End ResultTESGetAllOnPage */

/* Start ResultTESInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultTESInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultTESInsert];
GO
CREATE PROCEDURE [dbo].[ResultTESInsert]
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@GameId bigint = null,
	@Result bit = null,
	@GameDateEnd datetime = null,
	@CreatedDate datetime = null
AS
BEGIN
	INSERT INTO [ResultTES]
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
/* End ResultTESInsert */

/* Start ResultTESUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultTESUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultTESUpdate];
GO
CREATE PROCEDURE [dbo].[ResultTESUpdate]
	@Id bigint = null,
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@GameId bigint = null,
	@Result bit = null,
	@GameDateEnd datetime = null,
	@CreatedDate datetime = null
AS
BEGIN
	UPDATE [ResultTES] SET
		[WebName] = @WebName,
		[GameName] = @GameName,
		[GameId] = @GameId,
		[Result] = @Result,
		[GameDateEnd] = @GameDateEnd,
		[CreatedDate] = @CreatedDate
	WHERE [Id] = @Id
END
GO
/* End ResultTESUpdate */

/* Start ResultTESDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultTESDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultTESDelete];
GO
CREATE PROCEDURE [dbo].[ResultTESDelete]
	@Id bigint = null
AS
BEGIN
	DELETE [ResultTES]
	WHERE [Id] = @Id
END
GO
/* End ResultTESDelete */

/* Start ResultTESDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultTESDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultTESDeleteAll];
GO
CREATE PROCEDURE [dbo].[ResultTESDeleteAll]
AS
BEGIN
	DELETE [ResultTES]
END
GO
/* End ResultTESDeleteAll */
