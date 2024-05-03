
/* Start StatusWSSGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[StatusWSSGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [StatusWSSGetById];
GO
CREATE PROCEDURE [dbo].[StatusWSSGetById]
	@Id smallint = null
AS
BEGIN
	SELECT
		[Id],
		[WebName],
		[GameName],
		[Status],
		[LastResult],
		[GameDateEnd],
		[ModifieldDate],
		[GameId]
	FROM [StatusWSS]
	WHERE [Id] = @Id
END
GO
/* End StatusWSSGetById */

/* Start StatusWSSGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[StatusWSSGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [StatusWSSGetAll];
GO
CREATE PROCEDURE [dbo].[StatusWSSGetAll]
AS
BEGIN
	SELECT
		[Id],
		[WebName],
		[GameName],
		[Status],
		[LastResult],
		[GameDateEnd],
		[ModifieldDate],
		[GameId]
	FROM [StatusWSS]
END
GO
/* End StatusWSSGetAll */

/* Start StatusWSSGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[StatusWSSGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [StatusWSSGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[StatusWSSGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Id],
		[WebName],
		[GameName],
		[Status],
		[LastResult],
		[GameDateEnd],
		[ModifieldDate],
		[GameId]
	FROM [StatusWSS]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End StatusWSSGetAllOnPage */

/* Start StatusWSSInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[StatusWSSInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [StatusWSSInsert];
GO
CREATE PROCEDURE [dbo].[StatusWSSInsert]
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@Status smallint = null,
	@LastResult bit = null,
	@GameDateEnd datetime = null,
	@ModifieldDate datetime = null,
	@GameId bigint = null
AS
BEGIN
	INSERT INTO [StatusWSS]
	(
		[WebName],
		[GameName],
		[Status],
		[LastResult],
		[GameDateEnd],
		[ModifieldDate],
		[GameId]
	)
	VALUES
	(
		@WebName,
		@GameName,
		@Status,
		@LastResult,
		@GameDateEnd,
		@ModifieldDate,
		@GameId
	)
END
GO
/* End StatusWSSInsert */

/* Start StatusWSSUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[StatusWSSUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [StatusWSSUpdate];
GO
CREATE PROCEDURE [dbo].[StatusWSSUpdate]
	@Id smallint = null,
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@Status smallint = null,
	@LastResult bit = null,
	@GameDateEnd datetime = null,
	@ModifieldDate datetime = null,
	@GameId bigint = null
AS
BEGIN
	UPDATE [StatusWSS] SET
		[WebName] = @WebName,
		[GameName] = @GameName,
		[Status] = @Status,
		[LastResult] = @LastResult,
		[GameDateEnd] = @GameDateEnd,
		[ModifieldDate] = @ModifieldDate,
		[GameId] = @GameId
	WHERE [Id] = @Id
END
GO
/* End StatusWSSUpdate */

/* Start StatusWSSDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[StatusWSSDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [StatusWSSDelete];
GO
CREATE PROCEDURE [dbo].[StatusWSSDelete]
	@Id smallint = null
AS
BEGIN
	DELETE [StatusWSS]
	WHERE [Id] = @Id
END
GO
/* End StatusWSSDelete */

/* Start StatusWSSDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[StatusWSSDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [StatusWSSDeleteAll];
GO
CREATE PROCEDURE [dbo].[StatusWSSDeleteAll]
AS
BEGIN
	DELETE [StatusWSS]
END
GO
/* End StatusWSSDeleteAll */
