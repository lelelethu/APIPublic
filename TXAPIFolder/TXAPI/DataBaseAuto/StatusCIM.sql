
/* Start StatusCIMGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[StatusCIMGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [StatusCIMGetById];
GO
CREATE PROCEDURE [dbo].[StatusCIMGetById]
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
	FROM [StatusCIM]
	WHERE [Id] = @Id
END
GO
/* End StatusCIMGetById */

/* Start StatusCIMGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[StatusCIMGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [StatusCIMGetAll];
GO
CREATE PROCEDURE [dbo].[StatusCIMGetAll]
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
	FROM [StatusCIM]
END
GO
/* End StatusCIMGetAll */

/* Start StatusCIMGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[StatusCIMGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [StatusCIMGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[StatusCIMGetAllOnPage]
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
	FROM [StatusCIM]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End StatusCIMGetAllOnPage */

/* Start StatusCIMInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[StatusCIMInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [StatusCIMInsert];
GO
CREATE PROCEDURE [dbo].[StatusCIMInsert]
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@Status smallint = null,
	@LastResult bit = null,
	@GameDateEnd datetime = null,
	@ModifieldDate datetime = null,
	@GameId bigint = null
AS
BEGIN
	INSERT INTO [StatusCIM]
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
/* End StatusCIMInsert */

/* Start StatusCIMUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[StatusCIMUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [StatusCIMUpdate];
GO
CREATE PROCEDURE [dbo].[StatusCIMUpdate]
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
	UPDATE [StatusCIM] SET
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
/* End StatusCIMUpdate */

/* Start StatusCIMDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[StatusCIMDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [StatusCIMDelete];
GO
CREATE PROCEDURE [dbo].[StatusCIMDelete]
	@Id smallint = null
AS
BEGIN
	DELETE [StatusCIM]
	WHERE [Id] = @Id
END
GO
/* End StatusCIMDelete */

/* Start StatusCIMDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[StatusCIMDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [StatusCIMDeleteAll];
GO
CREATE PROCEDURE [dbo].[StatusCIMDeleteAll]
AS
BEGIN
	DELETE [StatusCIM]
END
GO
/* End StatusCIMDeleteAll */
