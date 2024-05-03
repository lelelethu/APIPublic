
/* Start __MigrationHistoryGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[__MigrationHistoryGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [__MigrationHistoryGetById];
GO
CREATE PROCEDURE [dbo].[__MigrationHistoryGetById]
	@MigrationId nvarchar(150) = null
AS
BEGIN
	SELECT
		[MigrationId],
		[ContextKey],
		[Model],
		[ProductVersion]
	FROM [__MigrationHistory]
	WHERE [MigrationId] = @MigrationId
END
GO
/* End __MigrationHistoryGetById */

/* Start __MigrationHistoryGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[__MigrationHistoryGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [__MigrationHistoryGetAll];
GO
CREATE PROCEDURE [dbo].[__MigrationHistoryGetAll]
AS
BEGIN
	SELECT
		[MigrationId],
		[ContextKey],
		[Model],
		[ProductVersion]
	FROM [__MigrationHistory]
END
GO
/* End __MigrationHistoryGetAll */

/* Start __MigrationHistoryGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[__MigrationHistoryGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [__MigrationHistoryGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[__MigrationHistoryGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[MigrationId],
		[ContextKey],
		[Model],
		[ProductVersion]
	FROM [__MigrationHistory]
	ORDER BY [MigrationId] ,[ContextKey]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End __MigrationHistoryGetAllOnPage */

/* Start __MigrationHistoryInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[__MigrationHistoryInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [__MigrationHistoryInsert];
GO
CREATE PROCEDURE [dbo].[__MigrationHistoryInsert]
	@Model varbinary(max) = null,
	@ProductVersion nvarchar(32) = null
AS
BEGIN
	INSERT INTO [__MigrationHistory]
	(
		[Model],
		[ProductVersion]
	)
	VALUES
	(
		@Model,
		@ProductVersion
	)
END
GO
/* End __MigrationHistoryInsert */

/* Start __MigrationHistoryUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[__MigrationHistoryUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [__MigrationHistoryUpdate];
GO
CREATE PROCEDURE [dbo].[__MigrationHistoryUpdate]
	@MigrationId nvarchar(150) = null,
	@ContextKey nvarchar(300) = null,
	@Model varbinary(max) = null,
	@ProductVersion nvarchar(32) = null
AS
BEGIN
	UPDATE [__MigrationHistory] SET
		[Model] = @Model,
		[ProductVersion] = @ProductVersion
	WHERE [MigrationId] = @MigrationId
END
GO
/* End __MigrationHistoryUpdate */

/* Start __MigrationHistoryDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[__MigrationHistoryDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [__MigrationHistoryDelete];
GO
CREATE PROCEDURE [dbo].[__MigrationHistoryDelete]
	@MigrationId nvarchar(150) = null
AS
BEGIN
	DELETE [__MigrationHistory]
	WHERE [MigrationId] = @MigrationId
END
GO
/* End __MigrationHistoryDelete */

/* Start __MigrationHistoryDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[__MigrationHistoryDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [__MigrationHistoryDeleteAll];
GO
CREATE PROCEDURE [dbo].[__MigrationHistoryDeleteAll]
AS
BEGIN
	DELETE [__MigrationHistory]
END
GO
/* End __MigrationHistoryDeleteAll */
