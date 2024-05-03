
/* Start StatusTESGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[StatusTESGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [StatusTESGetById];
GO
CREATE PROCEDURE [dbo].[StatusTESGetById]
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
	FROM [StatusTES]
	WHERE [Id] = @Id
END
GO
/* End StatusTESGetById */

/* Start StatusTESGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[StatusTESGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [StatusTESGetAll];
GO
CREATE PROCEDURE [dbo].[StatusTESGetAll]
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
	FROM [StatusTES]
END
GO
/* End StatusTESGetAll */

/* Start StatusTESGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[StatusTESGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [StatusTESGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[StatusTESGetAllOnPage]
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
	FROM [StatusTES]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End StatusTESGetAllOnPage */

/* Start StatusTESInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[StatusTESInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [StatusTESInsert];
GO
CREATE PROCEDURE [dbo].[StatusTESInsert]
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@Status smallint = null,
	@LastResult bit = null,
	@GameDateEnd datetime = null,
	@ModifieldDate datetime = null,
	@GameId bigint = null
AS
BEGIN
	INSERT INTO [StatusTES]
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
/* End StatusTESInsert */

/* Start StatusTESUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[StatusTESUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [StatusTESUpdate];
GO
CREATE PROCEDURE [dbo].[StatusTESUpdate]
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
	UPDATE [StatusTES] SET
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
/* End StatusTESUpdate */

/* Start StatusTESDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[StatusTESDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [StatusTESDelete];
GO
CREATE PROCEDURE [dbo].[StatusTESDelete]
	@Id smallint = null
AS
BEGIN
	DELETE [StatusTES]
	WHERE [Id] = @Id
END
GO
/* End StatusTESDelete */

/* Start StatusTESDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[StatusTESDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [StatusTESDeleteAll];
GO
CREATE PROCEDURE [dbo].[StatusTESDeleteAll]
AS
BEGIN
	DELETE [StatusTES]
END
GO
/* End StatusTESDeleteAll */
