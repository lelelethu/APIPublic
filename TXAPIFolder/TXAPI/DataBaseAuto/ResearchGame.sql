
/* Start ResearchGameGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResearchGameGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResearchGameGetById];
GO
CREATE PROCEDURE [dbo].[ResearchGameGetById]
	@Id int = null
AS
BEGIN
	SELECT
		[Id],
		[BaseGame],
		[Status]
	FROM [ResearchGame]
	WHERE [Id] = @Id
END
GO
/* End ResearchGameGetById */

/* Start ResearchGameGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResearchGameGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResearchGameGetAll];
GO
CREATE PROCEDURE [dbo].[ResearchGameGetAll]
AS
BEGIN
	SELECT
		[Id],
		[BaseGame],
		[Status]
	FROM [ResearchGame]
END
GO
/* End ResearchGameGetAll */

/* Start ResearchGameGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResearchGameGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResearchGameGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[ResearchGameGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Id],
		[BaseGame],
		[Status]
	FROM [ResearchGame]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End ResearchGameGetAllOnPage */

/* Start ResearchGameInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResearchGameInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResearchGameInsert];
GO
CREATE PROCEDURE [dbo].[ResearchGameInsert]
	@BaseGame varchar(300) = null,
	@Status int = null
AS
BEGIN
	INSERT INTO [ResearchGame]
	(
		[BaseGame],
		[Status]
	)
	VALUES
	(
		@BaseGame,
		@Status
	)
END
GO
/* End ResearchGameInsert */

/* Start ResearchGameUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResearchGameUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResearchGameUpdate];
GO
CREATE PROCEDURE [dbo].[ResearchGameUpdate]
	@Id int = null,
	@BaseGame varchar(300) = null,
	@Status int = null
AS
BEGIN
	UPDATE [ResearchGame] SET
		[BaseGame] = @BaseGame,
		[Status] = @Status
	WHERE [Id] = @Id
END
GO
/* End ResearchGameUpdate */

/* Start ResearchGameDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResearchGameDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResearchGameDelete];
GO
CREATE PROCEDURE [dbo].[ResearchGameDelete]
	@Id int = null
AS
BEGIN
	DELETE [ResearchGame]
	WHERE [Id] = @Id
END
GO
/* End ResearchGameDelete */

/* Start ResearchGameDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResearchGameDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResearchGameDeleteAll];
GO
CREATE PROCEDURE [dbo].[ResearchGameDeleteAll]
AS
BEGIN
	DELETE [ResearchGame]
END
GO
/* End ResearchGameDeleteAll */
