
/* Start ResultWSS_8STRGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_8STRGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_8STRGetById];
GO
CREATE PROCEDURE [dbo].[ResultWSS_8STRGetById]
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
	FROM [ResultWSS_8STR]
	WHERE [Id] = @Id
END
GO
/* End ResultWSS_8STRGetById */

/* Start ResultWSS_8STRGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_8STRGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_8STRGetAll];
GO
CREATE PROCEDURE [dbo].[ResultWSS_8STRGetAll]
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
	FROM [ResultWSS_8STR]
END
GO
/* End ResultWSS_8STRGetAll */

/* Start ResultWSS_8STRGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_8STRGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_8STRGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[ResultWSS_8STRGetAllOnPage]
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
	FROM [ResultWSS_8STR]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End ResultWSS_8STRGetAllOnPage */

/* Start ResultWSS_8STRInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_8STRInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_8STRInsert];
GO
CREATE PROCEDURE [dbo].[ResultWSS_8STRInsert]
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@GameId bigint = null,
	@ResultStr varchar(15) = null,
	@GameDateEnd datetime = null,
	@CreatedDate datetime = null
AS
BEGIN
	INSERT INTO [ResultWSS_8STR]
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
/* End ResultWSS_8STRInsert */

/* Start ResultWSS_8STRUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_8STRUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_8STRUpdate];
GO
CREATE PROCEDURE [dbo].[ResultWSS_8STRUpdate]
	@Id int = null,
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@GameId bigint = null,
	@ResultStr varchar(15) = null,
	@GameDateEnd datetime = null,
	@CreatedDate datetime = null
AS
BEGIN
	UPDATE [ResultWSS_8STR] SET
		[WebName] = @WebName,
		[GameName] = @GameName,
		[GameId] = @GameId,
		[ResultStr] = @ResultStr,
		[GameDateEnd] = @GameDateEnd,
		[CreatedDate] = @CreatedDate
	WHERE [Id] = @Id
END
GO
/* End ResultWSS_8STRUpdate */

/* Start ResultWSS_8STRDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_8STRDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_8STRDelete];
GO
CREATE PROCEDURE [dbo].[ResultWSS_8STRDelete]
	@Id int = null
AS
BEGIN
	DELETE [ResultWSS_8STR]
	WHERE [Id] = @Id
END
GO
/* End ResultWSS_8STRDelete */

/* Start ResultWSS_8STRDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_8STRDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_8STRDeleteAll];
GO
CREATE PROCEDURE [dbo].[ResultWSS_8STRDeleteAll]
AS
BEGIN
	DELETE [ResultWSS_8STR]
END
GO
/* End ResultWSS_8STRDeleteAll */
