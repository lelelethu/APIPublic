
/* Start FunctionsGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[FunctionsGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [FunctionsGetById];
GO
CREATE PROCEDURE [dbo].[FunctionsGetById]
	@Id uniqueidentifier = null
AS
BEGIN
	SELECT
		[Id],
		[Controller],
		[Action],
		[ReturnType],
		[Attributes]
	FROM [Functions]
	WHERE [Id] = @Id
END
GO
/* End FunctionsGetById */

/* Start FunctionsGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[FunctionsGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [FunctionsGetAll];
GO
CREATE PROCEDURE [dbo].[FunctionsGetAll]
AS
BEGIN
	SELECT
		[Id],
		[Controller],
		[Action],
		[ReturnType],
		[Attributes]
	FROM [Functions]
END
GO
/* End FunctionsGetAll */

/* Start FunctionsGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[FunctionsGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [FunctionsGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[FunctionsGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Id],
		[Controller],
		[Action],
		[ReturnType],
		[Attributes]
	FROM [Functions]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End FunctionsGetAllOnPage */

/* Start FunctionsInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[FunctionsInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [FunctionsInsert];
GO
CREATE PROCEDURE [dbo].[FunctionsInsert]
	@Controller nvarchar(64) = null,
	@Action nvarchar(64) = null,
	@ReturnType nvarchar(64) = null,
	@Attributes nvarchar(256) = null
AS
BEGIN
	INSERT INTO [Functions]
	(
		[Controller],
		[Action],
		[ReturnType],
		[Attributes]
	)
	VALUES
	(
		@Controller,
		@Action,
		@ReturnType,
		@Attributes
	)
END
GO
/* End FunctionsInsert */

/* Start FunctionsUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[FunctionsUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [FunctionsUpdate];
GO
CREATE PROCEDURE [dbo].[FunctionsUpdate]
	@Id uniqueidentifier = null,
	@Controller nvarchar(64) = null,
	@Action nvarchar(64) = null,
	@ReturnType nvarchar(64) = null,
	@Attributes nvarchar(256) = null
AS
BEGIN
	UPDATE [Functions] SET
		[Controller] = @Controller,
		[Action] = @Action,
		[ReturnType] = @ReturnType,
		[Attributes] = @Attributes
	WHERE [Id] = @Id
END
GO
/* End FunctionsUpdate */

/* Start FunctionsDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[FunctionsDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [FunctionsDelete];
GO
CREATE PROCEDURE [dbo].[FunctionsDelete]
	@Id uniqueidentifier = null
AS
BEGIN
	DELETE [Functions]
	WHERE [Id] = @Id
END
GO
/* End FunctionsDelete */

/* Start FunctionsDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[FunctionsDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [FunctionsDeleteAll];
GO
CREATE PROCEDURE [dbo].[FunctionsDeleteAll]
AS
BEGIN
	DELETE [Functions]
END
GO
/* End FunctionsDeleteAll */
