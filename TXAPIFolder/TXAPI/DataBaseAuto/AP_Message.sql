
/* Start AP_MessageGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[AP_MessageGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [AP_MessageGetById];
GO
CREATE PROCEDURE [dbo].[AP_MessageGetById]
	@Id bigint = null
AS
BEGIN
	SELECT
		[Id],
		[Code],
		[APIName],
		[Message],
		[Description],
		[CreatedDate]
	FROM [AP_Message]
	WHERE [Id] = @Id
END
GO
/* End AP_MessageGetById */

/* Start AP_MessageGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[AP_MessageGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [AP_MessageGetAll];
GO
CREATE PROCEDURE [dbo].[AP_MessageGetAll]
AS
BEGIN
	SELECT
		[Id],
		[Code],
		[APIName],
		[Message],
		[Description],
		[CreatedDate]
	FROM [AP_Message]
END
GO
/* End AP_MessageGetAll */

/* Start AP_MessageGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[AP_MessageGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [AP_MessageGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[AP_MessageGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Id],
		[Code],
		[APIName],
		[Message],
		[Description],
		[CreatedDate]
	FROM [AP_Message]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End AP_MessageGetAllOnPage */

/* Start AP_MessageInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[AP_MessageInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [AP_MessageInsert];
GO
CREATE PROCEDURE [dbo].[AP_MessageInsert]
	@Code nvarchar(256) = null,
	@APIName nvarchar(256) = null,
	@Message nvarchar(max) = null,
	@Description nvarchar(max) = null,
	@CreatedDate datetime = null
AS
BEGIN
	INSERT INTO [AP_Message]
	(
		[Code],
		[APIName],
		[Message],
		[Description],
		[CreatedDate]
	)
	VALUES
	(
		@Code,
		@APIName,
		@Message,
		@Description,
		@CreatedDate
	)
END
GO
/* End AP_MessageInsert */

/* Start AP_MessageUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[AP_MessageUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [AP_MessageUpdate];
GO
CREATE PROCEDURE [dbo].[AP_MessageUpdate]
	@Id bigint = null,
	@Code nvarchar(256) = null,
	@APIName nvarchar(256) = null,
	@Message nvarchar(max) = null,
	@Description nvarchar(max) = null,
	@CreatedDate datetime = null
AS
BEGIN
	UPDATE [AP_Message] SET
		[Code] = @Code,
		[APIName] = @APIName,
		[Message] = @Message,
		[Description] = @Description,
		[CreatedDate] = @CreatedDate
	WHERE [Id] = @Id
END
GO
/* End AP_MessageUpdate */

/* Start AP_MessageDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[AP_MessageDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [AP_MessageDelete];
GO
CREATE PROCEDURE [dbo].[AP_MessageDelete]
	@Id bigint = null
AS
BEGIN
	DELETE [AP_Message]
	WHERE [Id] = @Id
END
GO
/* End AP_MessageDelete */

/* Start AP_MessageDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[AP_MessageDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [AP_MessageDeleteAll];
GO
CREATE PROCEDURE [dbo].[AP_MessageDeleteAll]
AS
BEGIN
	DELETE [AP_Message]
END
GO
/* End AP_MessageDeleteAll */
