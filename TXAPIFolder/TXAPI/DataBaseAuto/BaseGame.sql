
/* Start BaseGameGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[BaseGameGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [BaseGameGetAll];
GO
CREATE PROCEDURE [dbo].[BaseGameGetAll]
AS
BEGIN
	SELECT
		[BaseGame]
	FROM [BaseGame]
END
GO
/* End BaseGameGetAll */

/* Start BaseGameGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[BaseGameGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [BaseGameGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[BaseGameGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[BaseGame]
	FROM [BaseGame]
	ORDER BY BaseGame
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End BaseGameGetAllOnPage */

/* Start BaseGameInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[BaseGameInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [BaseGameInsert];
GO
CREATE PROCEDURE [dbo].[BaseGameInsert]
	@BaseGame varchar(3000) = null
AS
BEGIN
	INSERT INTO [BaseGame]
	(
		[BaseGame]
	)
	VALUES
	(
		@BaseGame
	)
END
GO
/* End BaseGameInsert */

/* Start BaseGameDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[BaseGameDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [BaseGameDeleteAll];
GO
CREATE PROCEDURE [dbo].[BaseGameDeleteAll]
AS
BEGIN
	DELETE [BaseGame]
END
GO
/* End BaseGameDeleteAll */
