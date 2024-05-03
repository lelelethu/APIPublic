
/* Start ResultWSS_10STRGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_10STRGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_10STRGetById];
GO
CREATE PROCEDURE [dbo].[ResultWSS_10STRGetById]
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
	FROM [ResultWSS_10STR]
	WHERE [Id] = @Id
END
GO
/* End ResultWSS_10STRGetById */

/* Start ResultWSS_10STRGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_10STRGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_10STRGetAll];
GO
CREATE PROCEDURE [dbo].[ResultWSS_10STRGetAll]
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
	FROM [ResultWSS_10STR]
END
GO
/* End ResultWSS_10STRGetAll */

/* Start ResultWSS_10STRGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_10STRGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_10STRGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[ResultWSS_10STRGetAllOnPage]
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
	FROM [ResultWSS_10STR]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End ResultWSS_10STRGetAllOnPage */

/* Start ResultWSS_10STRInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_10STRInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_10STRInsert];
GO
CREATE PROCEDURE [dbo].[ResultWSS_10STRInsert]
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@GameId bigint = null,
	@ResultStr varchar(50) = null,
	@GameDateEnd datetime = null,
	@CreatedDate datetime = null
AS
BEGIN
	INSERT INTO [ResultWSS_10STR]
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
/* End ResultWSS_10STRInsert */

/* Start ResultWSS_10STRUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_10STRUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_10STRUpdate];
GO
CREATE PROCEDURE [dbo].[ResultWSS_10STRUpdate]
	@Id int = null,
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@GameId bigint = null,
	@ResultStr varchar(50) = null,
	@GameDateEnd datetime = null,
	@CreatedDate datetime = null
AS
BEGIN
	UPDATE [ResultWSS_10STR] SET
		[WebName] = @WebName,
		[GameName] = @GameName,
		[GameId] = @GameId,
		[ResultStr] = @ResultStr,
		[GameDateEnd] = @GameDateEnd,
		[CreatedDate] = @CreatedDate
	WHERE [Id] = @Id
END
GO
/* End ResultWSS_10STRUpdate */

/* Start ResultWSS_10STRDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_10STRDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_10STRDelete];
GO
CREATE PROCEDURE [dbo].[ResultWSS_10STRDelete]
	@Id int = null
AS
BEGIN
	DELETE [ResultWSS_10STR]
	WHERE [Id] = @Id
END
GO
/* End ResultWSS_10STRDelete */

/* Start ResultWSS_10STRDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_10STRDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_10STRDeleteAll];
GO
CREATE PROCEDURE [dbo].[ResultWSS_10STRDeleteAll]
AS
BEGIN
	DELETE [ResultWSS_10STR]
END
GO
/* End ResultWSS_10STRDeleteAll */
