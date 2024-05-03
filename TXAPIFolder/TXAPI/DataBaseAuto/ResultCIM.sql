
/* Start ResultCIMGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultCIMGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultCIMGetById];
GO
CREATE PROCEDURE [dbo].[ResultCIMGetById]
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
	FROM [ResultCIM]
	WHERE [Id] = @Id
END
GO
/* End ResultCIMGetById */

/* Start ResultCIMGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultCIMGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultCIMGetAll];
GO
CREATE PROCEDURE [dbo].[ResultCIMGetAll]
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
	FROM [ResultCIM]
END
GO
/* End ResultCIMGetAll */

/* Start ResultCIMGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultCIMGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultCIMGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[ResultCIMGetAllOnPage]
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
	FROM [ResultCIM]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End ResultCIMGetAllOnPage */

/* Start ResultCIMInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultCIMInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultCIMInsert];
GO
CREATE PROCEDURE [dbo].[ResultCIMInsert]
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@GameId bigint = null,
	@Result bit = null,
	@GameDateEnd datetime = null,
	@CreatedDate datetime = null
AS
BEGIN
	INSERT INTO [ResultCIM]
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
/* End ResultCIMInsert */

/* Start ResultCIMUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultCIMUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultCIMUpdate];
GO
CREATE PROCEDURE [dbo].[ResultCIMUpdate]
	@Id bigint = null,
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@GameId bigint = null,
	@Result bit = null,
	@GameDateEnd datetime = null,
	@CreatedDate datetime = null
AS
BEGIN
	UPDATE [ResultCIM] SET
		[WebName] = @WebName,
		[GameName] = @GameName,
		[GameId] = @GameId,
		[Result] = @Result,
		[GameDateEnd] = @GameDateEnd,
		[CreatedDate] = @CreatedDate
	WHERE [Id] = @Id
END
GO
/* End ResultCIMUpdate */

/* Start ResultCIMDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultCIMDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultCIMDelete];
GO
CREATE PROCEDURE [dbo].[ResultCIMDelete]
	@Id bigint = null
AS
BEGIN
	DELETE [ResultCIM]
	WHERE [Id] = @Id
END
GO
/* End ResultCIMDelete */

/* Start ResultCIMDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultCIMDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultCIMDeleteAll];
GO
CREATE PROCEDURE [dbo].[ResultCIMDeleteAll]
AS
BEGIN
	DELETE [ResultCIM]
END
GO
/* End ResultCIMDeleteAll */
