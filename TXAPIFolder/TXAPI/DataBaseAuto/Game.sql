
/* Start GameGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[GameGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [GameGetById];
GO
CREATE PROCEDURE [dbo].[GameGetById]
	@Id int = null
AS
BEGIN
	SELECT
		[Id],
		[Name],
		[WebName],
		[GameName],
		[Desc],
		[TargetPackage],
		[Apk],
		[CreatedDate]
	FROM [Game]
	WHERE [Id] = @Id
END
GO
/* End GameGetById */

/* Start GameGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[GameGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [GameGetAll];
GO
CREATE PROCEDURE [dbo].[GameGetAll]
AS
BEGIN
	SELECT
		[Id],
		[Name],
		[WebName],
		[GameName],
		[Desc],
		[TargetPackage],
		[Apk],
		[CreatedDate]
	FROM [Game]
END
GO
/* End GameGetAll */

/* Start GameGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[GameGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [GameGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[GameGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Id],
		[Name],
		[WebName],
		[GameName],
		[Desc],
		[TargetPackage],
		[Apk],
		[CreatedDate]
	FROM [Game]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End GameGetAllOnPage */

/* Start GameInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[GameInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [GameInsert];
GO
CREATE PROCEDURE [dbo].[GameInsert]
	@Name nvarchar(256) = null,
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@Desc nvarchar(256) = null,
	@TargetPackage nvarchar(256) = null,
	@Apk nvarchar(256) = null,
	@CreatedDate date = null
AS
BEGIN
	INSERT INTO [Game]
	(
		[Name],
		[WebName],
		[GameName],
		[Desc],
		[TargetPackage],
		[Apk],
		[CreatedDate]
	)
	VALUES
	(
		@Name,
		@WebName,
		@GameName,
		@Desc,
		@TargetPackage,
		@Apk,
		@CreatedDate
	)
END
GO
/* End GameInsert */

/* Start GameUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[GameUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [GameUpdate];
GO
CREATE PROCEDURE [dbo].[GameUpdate]
	@Id int = null,
	@Name nvarchar(256) = null,
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@Desc nvarchar(256) = null,
	@TargetPackage nvarchar(256) = null,
	@Apk nvarchar(256) = null,
	@CreatedDate date = null
AS
BEGIN
	UPDATE [Game] SET
		[Name] = @Name,
		[WebName] = @WebName,
		[GameName] = @GameName,
		[Desc] = @Desc,
		[TargetPackage] = @TargetPackage,
		[Apk] = @Apk,
		[CreatedDate] = @CreatedDate
	WHERE [Id] = @Id
END
GO
/* End GameUpdate */

/* Start GameDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[GameDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [GameDelete];
GO
CREATE PROCEDURE [dbo].[GameDelete]
	@Id int = null
AS
BEGIN
	DELETE [Game]
	WHERE [Id] = @Id
END
GO
/* End GameDelete */

/* Start GameDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[GameDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [GameDeleteAll];
GO
CREATE PROCEDURE [dbo].[GameDeleteAll]
AS
BEGIN
	DELETE [Game]
END
GO
/* End GameDeleteAll */
