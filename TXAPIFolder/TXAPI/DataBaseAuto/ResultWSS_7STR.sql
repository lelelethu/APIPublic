
/* Start ResultWSS_7STRGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_7STRGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_7STRGetAll];
GO
CREATE PROCEDURE [dbo].[ResultWSS_7STRGetAll]
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
	FROM [ResultWSS_7STR]
END
GO
/* End ResultWSS_7STRGetAll */

/* Start ResultWSS_7STRGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_7STRGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_7STRGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[ResultWSS_7STRGetAllOnPage]
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
	FROM [ResultWSS_7STR]
	ORDER BY Id
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End ResultWSS_7STRGetAllOnPage */

/* Start ResultWSS_7STRInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_7STRInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_7STRInsert];
GO
CREATE PROCEDURE [dbo].[ResultWSS_7STRInsert]
	@Id int = null,
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@GameId bigint = null,
	@ResultStr varchar(13) = null,
	@GameDateEnd datetime = null,
	@CreatedDate datetime = null
AS
BEGIN
	INSERT INTO [ResultWSS_7STR]
	(
		[Id],
		[WebName],
		[GameName],
		[GameId],
		[ResultStr],
		[GameDateEnd],
		[CreatedDate]
	)
	VALUES
	(
		@Id,
		@WebName,
		@GameName,
		@GameId,
		@ResultStr,
		@GameDateEnd,
		@CreatedDate
	)
END
GO
/* End ResultWSS_7STRInsert */

/* Start ResultWSS_7STRDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultWSS_7STRDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultWSS_7STRDeleteAll];
GO
CREATE PROCEDURE [dbo].[ResultWSS_7STRDeleteAll]
AS
BEGIN
	DELETE [ResultWSS_7STR]
END
GO
/* End ResultWSS_7STRDeleteAll */
