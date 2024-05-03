
/* Start TokenGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[TokenGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [TokenGetById];
GO
CREATE PROCEDURE [dbo].[TokenGetById]
	@Id bigint = null
AS
BEGIN
	SELECT
		[Id],
		[LinkGame],
		[Token],
		[UserName],
		[EndDate],
		[Status]
	FROM [Token]
	WHERE [Id] = @Id
END
GO
/* End TokenGetById */

/* Start TokenGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[TokenGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [TokenGetAll];
GO
CREATE PROCEDURE [dbo].[TokenGetAll]
AS
BEGIN
	SELECT
		[Id],
		[LinkGame],
		[Token],
		[UserName],
		[EndDate],
		[Status]
	FROM [Token]
END
GO
/* End TokenGetAll */

/* Start TokenGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[TokenGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [TokenGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[TokenGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Id],
		[LinkGame],
		[Token],
		[UserName],
		[EndDate],
		[Status]
	FROM [Token]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End TokenGetAllOnPage */

/* Start TokenInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[TokenInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [TokenInsert];
GO
CREATE PROCEDURE [dbo].[TokenInsert]
	@LinkGame nvarchar(255) = null,
	@Token nchar(255) = null,
	@UserName nchar(255) = null,
	@EndDate datetime = null,
	@Status bit = null
AS
BEGIN
	INSERT INTO [Token]
	(
		[LinkGame],
		[Token],
		[UserName],
		[EndDate],
		[Status]
	)
	VALUES
	(
		@LinkGame,
		@Token,
		@UserName,
		@EndDate,
		@Status
	)
END
GO
/* End TokenInsert */

/* Start TokenUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[TokenUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [TokenUpdate];
GO
CREATE PROCEDURE [dbo].[TokenUpdate]
	@Id bigint = null,
	@LinkGame nvarchar(255) = null,
	@Token nchar(255) = null,
	@UserName nchar(255) = null,
	@EndDate datetime = null,
	@Status bit = null
AS
BEGIN
	UPDATE [Token] SET
		[LinkGame] = @LinkGame,
		[Token] = @Token,
		[UserName] = @UserName,
		[EndDate] = @EndDate,
		[Status] = @Status
	WHERE [Id] = @Id
END
GO
/* End TokenUpdate */

/* Start TokenDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[TokenDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [TokenDelete];
GO
CREATE PROCEDURE [dbo].[TokenDelete]
	@Id bigint = null
AS
BEGIN
	DELETE [Token]
	WHERE [Id] = @Id
END
GO
/* End TokenDelete */

/* Start TokenDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[TokenDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [TokenDeleteAll];
GO
CREATE PROCEDURE [dbo].[TokenDeleteAll]
AS
BEGIN
	DELETE [Token]
END
GO
/* End TokenDeleteAll */
