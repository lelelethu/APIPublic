
/* Start Base10GameGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Base10GameGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Base10GameGetById];
GO
CREATE PROCEDURE [dbo].[Base10GameGetById]
	@BaseGame varchar(300) = null
AS
BEGIN
	SELECT
		[BaseGame]
	FROM [Base10Game]
	WHERE [BaseGame] = @BaseGame
END
GO
/* End Base10GameGetById */

/* Start Base10GameGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Base10GameGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Base10GameGetAll];
GO
CREATE PROCEDURE [dbo].[Base10GameGetAll]
AS
BEGIN
	SELECT
		[BaseGame]
	FROM [Base10Game]
END
GO
/* End Base10GameGetAll */

/* Start Base10GameGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Base10GameGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Base10GameGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[Base10GameGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[BaseGame]
	FROM [Base10Game]
	ORDER BY [BaseGame]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End Base10GameGetAllOnPage */

/* Start Base10GameInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Base10GameInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Base10GameInsert];
GO
CREATE PROCEDURE [dbo].[Base10GameInsert]
AS
BEGIN
	INSERT INTO [Base10Game]
	(
	)
	VALUES
	(
	)
END
GO
/* End Base10GameInsert */

/* Start Base10GameUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Base10GameUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Base10GameUpdate];
GO
CREATE PROCEDURE [dbo].[Base10GameUpdate]
	@BaseGame varchar(300) = null
AS
BEGIN
	UPDATE [Base10Game] SET
	WHERE [BaseGame] = @BaseGame
END
GO
/* End Base10GameUpdate */

/* Start Base10GameDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Base10GameDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Base10GameDelete];
GO
CREATE PROCEDURE [dbo].[Base10GameDelete]
	@BaseGame varchar(300) = null
AS
BEGIN
	DELETE [Base10Game]
	WHERE [BaseGame] = @BaseGame
END
GO
/* End Base10GameDelete */

/* Start Base10GameDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Base10GameDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Base10GameDeleteAll];
GO
CREATE PROCEDURE [dbo].[Base10GameDeleteAll]
AS
BEGIN
	DELETE [Base10Game]
END
GO
/* End Base10GameDeleteAll */
