
/* Start ResultWSS_6STRGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_6STRGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_6STRGetById];
GO
CREATE PROCEDURE [dbo].[ResultWSS_6STRGetById]
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
	FROM [ResultWSS_6STR]
	WHERE [Id] = @Id
END
GO
/* End ResultWSS_6STRGetById */

/* Start ResultWSS_6STRGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_6STRGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_6STRGetAll];
GO
CREATE PROCEDURE [dbo].[ResultWSS_6STRGetAll]
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
	FROM [ResultWSS_6STR]
END
GO
/* End ResultWSS_6STRGetAll */

/* Start ResultWSS_6STRGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_6STRGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_6STRGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[ResultWSS_6STRGetAllOnPage]
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
	FROM [ResultWSS_6STR]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End ResultWSS_6STRGetAllOnPage */

/* Start ResultWSS_6STRInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_6STRInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_6STRInsert];
GO
CREATE PROCEDURE [dbo].[ResultWSS_6STRInsert]
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@GameId bigint = null,
	@ResultStr varchar(50) = null,
	@GameDateEnd datetime = null,
	@CreatedDate datetime = null
AS
BEGIN
	INSERT INTO [ResultWSS_6STR]
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
/* End ResultWSS_6STRInsert */

/* Start ResultWSS_6STRUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_6STRUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_6STRUpdate];
GO
CREATE PROCEDURE [dbo].[ResultWSS_6STRUpdate]
	@Id int = null,
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@GameId bigint = null,
	@ResultStr varchar(50) = null,
	@GameDateEnd datetime = null,
	@CreatedDate datetime = null
AS
BEGIN
	UPDATE [ResultWSS_6STR] SET
		[WebName] = @WebName,
		[GameName] = @GameName,
		[GameId] = @GameId,
		[ResultStr] = @ResultStr,
		[GameDateEnd] = @GameDateEnd,
		[CreatedDate] = @CreatedDate
	WHERE [Id] = @Id
END
GO
/* End ResultWSS_6STRUpdate */

/* Start ResultWSS_6STRDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_6STRDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_6STRDelete];
GO
CREATE PROCEDURE [dbo].[ResultWSS_6STRDelete]
	@Id int = null
AS
BEGIN
	DELETE [ResultWSS_6STR]
	WHERE [Id] = @Id
END
GO
/* End ResultWSS_6STRDelete */

/* Start ResultWSS_6STRDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_6STRDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_6STRDeleteAll];
GO
CREATE PROCEDURE [dbo].[ResultWSS_6STRDeleteAll]
AS
BEGIN
	DELETE [ResultWSS_6STR]
END
GO
/* End ResultWSS_6STRDeleteAll */
