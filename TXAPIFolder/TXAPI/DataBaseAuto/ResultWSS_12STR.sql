
/* Start ResultWSS_12STRGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_12STRGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_12STRGetById];
GO
CREATE PROCEDURE [dbo].[ResultWSS_12STRGetById]
	@Id int = null
AS
BEGIN
	SELECT
		[Id],
		[WebName],
		[GameName],
		[GameId],
		[ResultStr],
		[GameDateEnd],
		[CreatedDate]
	FROM [ResultWSS_12STR]
	WHERE [Id] = @Id
END
GO
/* End ResultWSS_12STRGetById */

/* Start ResultWSS_12STRGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_12STRGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_12STRGetAll];
GO
CREATE PROCEDURE [dbo].[ResultWSS_12STRGetAll]
AS
BEGIN
	SELECT
		[Id],
		[WebName],
		[GameName],
		[GameId],
		[ResultStr],
		[GameDateEnd],
		[CreatedDate]
	FROM [ResultWSS_12STR]
END
GO
/* End ResultWSS_12STRGetAll */

/* Start ResultWSS_12STRGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_12STRGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_12STRGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[ResultWSS_12STRGetAllOnPage]
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
		[ResultStr],
		[GameDateEnd],
		[CreatedDate]
	FROM [ResultWSS_12STR]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End ResultWSS_12STRGetAllOnPage */

/* Start ResultWSS_12STRInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_12STRInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_12STRInsert];
GO
CREATE PROCEDURE [dbo].[ResultWSS_12STRInsert]
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@GameId bigint = null,
	@ResultStr varchar(50) = null,
	@GameDateEnd datetime = null,
	@CreatedDate datetime = null
AS
BEGIN
	INSERT INTO [ResultWSS_12STR]
	(
		[WebName],
		[GameName],
		[GameId],
		[ResultStr],
		[GameDateEnd],
		[CreatedDate]
	)
	VALUES
	(
		@WebName,
		@GameName,
		@GameId,
		@ResultStr,
		@GameDateEnd,
		@CreatedDate
	)
END
GO
/* End ResultWSS_12STRInsert */

/* Start ResultWSS_12STRUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_12STRUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_12STRUpdate];
GO
CREATE PROCEDURE [dbo].[ResultWSS_12STRUpdate]
	@Id int = null,
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@GameId bigint = null,
	@ResultStr varchar(50) = null,
	@GameDateEnd datetime = null,
	@CreatedDate datetime = null
AS
BEGIN
	UPDATE [ResultWSS_12STR] SET
		[WebName] = @WebName,
		[GameName] = @GameName,
		[GameId] = @GameId,
		[ResultStr] = @ResultStr,
		[GameDateEnd] = @GameDateEnd,
		[CreatedDate] = @CreatedDate
	WHERE [Id] = @Id
END
GO
/* End ResultWSS_12STRUpdate */

/* Start ResultWSS_12STRDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_12STRDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_12STRDelete];
GO
CREATE PROCEDURE [dbo].[ResultWSS_12STRDelete]
	@Id int = null
AS
BEGIN
	DELETE [ResultWSS_12STR]
	WHERE [Id] = @Id
END
GO
/* End ResultWSS_12STRDelete */

/* Start ResultWSS_12STRDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_12STRDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_12STRDeleteAll];
GO
CREATE PROCEDURE [dbo].[ResultWSS_12STRDeleteAll]
AS
BEGIN
	DELETE [ResultWSS_12STR]
END
GO
/* End ResultWSS_12STRDeleteAll */
