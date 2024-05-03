
/* Start LinkGameJsGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[LinkGameJsGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [LinkGameJsGetById];
GO
CREATE PROCEDURE [dbo].[LinkGameJsGetById]
	@Id bigint = null
AS
BEGIN
	SELECT
		[Id],
		[LinkGame],
		[LinkJs]
	FROM [LinkGameJs]
	WHERE [Id] = @Id
END
GO
/* End LinkGameJsGetById */

/* Start LinkGameJsGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[LinkGameJsGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [LinkGameJsGetAll];
GO
CREATE PROCEDURE [dbo].[LinkGameJsGetAll]
AS
BEGIN
	SELECT
		[Id],
		[LinkGame],
		[LinkJs]
	FROM [LinkGameJs]
END
GO
/* End LinkGameJsGetAll */

/* Start LinkGameJsGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[LinkGameJsGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [LinkGameJsGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[LinkGameJsGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Id],
		[LinkGame],
		[LinkJs]
	FROM [LinkGameJs]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End LinkGameJsGetAllOnPage */

/* Start LinkGameJsInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[LinkGameJsInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [LinkGameJsInsert];
GO
CREATE PROCEDURE [dbo].[LinkGameJsInsert]
	@LinkGame nvarchar(255) = null,
	@LinkJs nvarchar(255) = null
AS
BEGIN
	INSERT INTO [LinkGameJs]
	(
		[LinkGame],
		[LinkJs]
	)
	VALUES
	(
		@LinkGame,
		@LinkJs
	)
END
GO
/* End LinkGameJsInsert */

/* Start LinkGameJsUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[LinkGameJsUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [LinkGameJsUpdate];
GO
CREATE PROCEDURE [dbo].[LinkGameJsUpdate]
	@Id bigint = null,
	@LinkGame nvarchar(255) = null,
	@LinkJs nvarchar(255) = null
AS
BEGIN
	UPDATE [LinkGameJs] SET
		[LinkGame] = @LinkGame,
		[LinkJs] = @LinkJs
	WHERE [Id] = @Id
END
GO
/* End LinkGameJsUpdate */

/* Start LinkGameJsDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[LinkGameJsDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [LinkGameJsDelete];
GO
CREATE PROCEDURE [dbo].[LinkGameJsDelete]
	@Id bigint = null
AS
BEGIN
	DELETE [LinkGameJs]
	WHERE [Id] = @Id
END
GO
/* End LinkGameJsDelete */

/* Start LinkGameJsDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[LinkGameJsDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [LinkGameJsDeleteAll];
GO
CREATE PROCEDURE [dbo].[LinkGameJsDeleteAll]
AS
BEGIN
	DELETE [LinkGameJs]
END
GO
/* End LinkGameJsDeleteAll */
