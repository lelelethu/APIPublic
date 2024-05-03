
/* Start Base12GameGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Base12GameGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Base12GameGetById];
GO
CREATE PROCEDURE [dbo].[Base12GameGetById]
	@BaseGame varchar(300) = null
AS
BEGIN
	SELECT
		[BaseGame]
	FROM [Base12Game]
	WHERE [BaseGame] = @BaseGame
END
GO
/* End Base12GameGetById */

/* Start Base12GameGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Base12GameGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Base12GameGetAll];
GO
CREATE PROCEDURE [dbo].[Base12GameGetAll]
AS
BEGIN
	SELECT
		[BaseGame]
	FROM [Base12Game]
END
GO
/* End Base12GameGetAll */

/* Start Base12GameGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Base12GameGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Base12GameGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[Base12GameGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[BaseGame]
	FROM [Base12Game]
	ORDER BY [BaseGame]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End Base12GameGetAllOnPage */

/* Start Base12GameInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Base12GameInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Base12GameInsert];
GO
CREATE PROCEDURE [dbo].[Base12GameInsert]
AS
BEGIN
	INSERT INTO [Base12Game]
	(
	)
	VALUES
	(
	)
END
GO
/* End Base12GameInsert */

/* Start Base12GameUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Base12GameUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Base12GameUpdate];
GO
CREATE PROCEDURE [dbo].[Base12GameUpdate]
	@BaseGame varchar(300) = null
AS
BEGIN
	UPDATE [Base12Game] SET
	WHERE [BaseGame] = @BaseGame
END
GO
/* End Base12GameUpdate */

/* Start Base12GameDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Base12GameDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Base12GameDelete];
GO
CREATE PROCEDURE [dbo].[Base12GameDelete]
	@BaseGame varchar(300) = null
AS
BEGIN
	DELETE [Base12Game]
	WHERE [BaseGame] = @BaseGame
END
GO
/* End Base12GameDelete */

/* Start Base12GameDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Base12GameDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Base12GameDeleteAll];
GO
CREATE PROCEDURE [dbo].[Base12GameDeleteAll]
AS
BEGIN
	DELETE [Base12Game]
END
GO
/* End Base12GameDeleteAll */
