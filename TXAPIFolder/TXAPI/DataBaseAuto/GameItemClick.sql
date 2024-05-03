
/* Start GameItemClickGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[GameItemClickGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [GameItemClickGetById];
GO
CREATE PROCEDURE [dbo].[GameItemClickGetById]
	@Id int = null
AS
BEGIN
	SELECT
		[Id],
		[GameId],
		[ItemClick],
		[OrderItem],
		[Name],
		[Action],
		[Type],
		[Status],
		[IsDelete]
	FROM [GameItemClick]
	WHERE [Id] = @Id
END
GO
/* End GameItemClickGetById */

/* Start GameItemClickGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[GameItemClickGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [GameItemClickGetAll];
GO
CREATE PROCEDURE [dbo].[GameItemClickGetAll]
AS
BEGIN
	SELECT
		[Id],
		[GameId],
		[ItemClick],
		[OrderItem],
		[Name],
		[Action],
		[Type],
		[Status],
		[IsDelete]
	FROM [GameItemClick]
END
GO
/* End GameItemClickGetAll */

/* Start GameItemClickGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[GameItemClickGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [GameItemClickGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[GameItemClickGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Id],
		[GameId],
		[ItemClick],
		[OrderItem],
		[Name],
		[Action],
		[Type],
		[Status],
		[IsDelete]
	FROM [GameItemClick]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End GameItemClickGetAllOnPage */

/* Start GameItemClickInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[GameItemClickInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [GameItemClickInsert];
GO
CREATE PROCEDURE [dbo].[GameItemClickInsert]
	@GameId bigint = null,
	@ItemClick int = null,
	@OrderItem int = null,
	@Name nvarchar(50) = null,
	@Action nvarchar(50) = null,
	@Type nvarchar(50) = null,
	@Status smallint = null,
	@IsDelete bit = null
AS
BEGIN
	INSERT INTO [GameItemClick]
	(
		[GameId],
		[ItemClick],
		[OrderItem],
		[Name],
		[Action],
		[Type],
		[Status],
		[IsDelete]
	)
	VALUES
	(
		@GameId,
		@ItemClick,
		@OrderItem,
		@Name,
		@Action,
		@Type,
		@Status,
		@IsDelete
	)
END
GO
/* End GameItemClickInsert */

/* Start GameItemClickUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[GameItemClickUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [GameItemClickUpdate];
GO
CREATE PROCEDURE [dbo].[GameItemClickUpdate]
	@Id int = null,
	@GameId bigint = null,
	@ItemClick int = null,
	@OrderItem int = null,
	@Name nvarchar(50) = null,
	@Action nvarchar(50) = null,
	@Type nvarchar(50) = null,
	@Status smallint = null,
	@IsDelete bit = null
AS
BEGIN
	UPDATE [GameItemClick] SET
		[GameId] = @GameId,
		[ItemClick] = @ItemClick,
		[OrderItem] = @OrderItem,
		[Name] = @Name,
		[Action] = @Action,
		[Type] = @Type,
		[Status] = @Status,
		[IsDelete] = @IsDelete
	WHERE [Id] = @Id
END
GO
/* End GameItemClickUpdate */

/* Start GameItemClickDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[GameItemClickDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [GameItemClickDelete];
GO
CREATE PROCEDURE [dbo].[GameItemClickDelete]
	@Id int = null
AS
BEGIN
	DELETE [GameItemClick]
	WHERE [Id] = @Id
END
GO
/* End GameItemClickDelete */

/* Start GameItemClickDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[GameItemClickDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [GameItemClickDeleteAll];
GO
CREATE PROCEDURE [dbo].[GameItemClickDeleteAll]
AS
BEGIN
	DELETE [GameItemClick]
END
GO
/* End GameItemClickDeleteAll */
