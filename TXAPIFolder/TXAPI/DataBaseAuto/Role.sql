
/* Start RoleGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[RoleGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [RoleGetById];
GO
CREATE PROCEDURE [dbo].[RoleGetById]
	@Id uniqueidentifier = null
AS
BEGIN
	SELECT
		[Id],
		[Name],
		[Description],
		[UserType],
		[UserType1]
	FROM [Role]
	WHERE [Id] = @Id
END
GO
/* End RoleGetById */

/* Start RoleGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[RoleGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [RoleGetAll];
GO
CREATE PROCEDURE [dbo].[RoleGetAll]
AS
BEGIN
	SELECT
		[Id],
		[Name],
		[Description],
		[UserType],
		[UserType1]
	FROM [Role]
END
GO
/* End RoleGetAll */

/* Start RoleGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[RoleGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [RoleGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[RoleGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Id],
		[Name],
		[Description],
		[UserType],
		[UserType1]
	FROM [Role]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End RoleGetAllOnPage */

/* Start RoleInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[RoleInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [RoleInsert];
GO
CREATE PROCEDURE [dbo].[RoleInsert]
	@Name nvarchar(64) = null,
	@Description nvarchar(256) = null,
	@UserType nvarchar(256) = null,
	@UserType1 nvarchar(max) = null
AS
BEGIN
	INSERT INTO [Role]
	(
		[Name],
		[Description],
		[UserType],
		[UserType1]
	)
	VALUES
	(
		@Name,
		@Description,
		@UserType,
		@UserType1
	)
END
GO
/* End RoleInsert */

/* Start RoleUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[RoleUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [RoleUpdate];
GO
CREATE PROCEDURE [dbo].[RoleUpdate]
	@Id uniqueidentifier = null,
	@Name nvarchar(64) = null,
	@Description nvarchar(256) = null,
	@UserType nvarchar(256) = null,
	@UserType1 nvarchar(max) = null
AS
BEGIN
	UPDATE [Role] SET
		[Name] = @Name,
		[Description] = @Description,
		[UserType] = @UserType,
		[UserType1] = @UserType1
	WHERE [Id] = @Id
END
GO
/* End RoleUpdate */

/* Start RoleDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[RoleDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [RoleDelete];
GO
CREATE PROCEDURE [dbo].[RoleDelete]
	@Id uniqueidentifier = null
AS
BEGIN
	DELETE [Role]
	WHERE [Id] = @Id
END
GO
/* End RoleDelete */

/* Start RoleDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[RoleDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [RoleDeleteAll];
GO
CREATE PROCEDURE [dbo].[RoleDeleteAll]
AS
BEGIN
	DELETE [Role]
END
GO
/* End RoleDeleteAll */
