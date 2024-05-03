
/* Start UsersGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UsersGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UsersGetById];
GO
CREATE PROCEDURE [dbo].[UsersGetById]
	@Id int = null
AS
BEGIN
	SELECT
		[Id],
		[RoleId],
		[CreatedDate],
		[IsDelete],
		[ExpriedDate],
		[Email],
		[CreatedBy],
		[UpdatedDate],
		[UdpatedBy],
		[Name],
		[BirthDay],
		[UserType],
		[ImageURL],
		[Address],
		[Phone],
		[UserName],
		[FirstName],
		[LastName],
		[Password]
	FROM [Users]
	WHERE [Id] = @Id
END
GO
/* End UsersGetById */

/* Start UsersGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UsersGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UsersGetAll];
GO
CREATE PROCEDURE [dbo].[UsersGetAll]
AS
BEGIN
	SELECT
		[Id],
		[RoleId],
		[CreatedDate],
		[IsDelete],
		[ExpriedDate],
		[Email],
		[CreatedBy],
		[UpdatedDate],
		[UdpatedBy],
		[Name],
		[BirthDay],
		[UserType],
		[ImageURL],
		[Address],
		[Phone],
		[UserName],
		[FirstName],
		[LastName],
		[Password]
	FROM [Users]
END
GO
/* End UsersGetAll */

/* Start UsersGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UsersGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UsersGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[UsersGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Id],
		[RoleId],
		[CreatedDate],
		[IsDelete],
		[ExpriedDate],
		[Email],
		[CreatedBy],
		[UpdatedDate],
		[UdpatedBy],
		[Name],
		[BirthDay],
		[UserType],
		[ImageURL],
		[Address],
		[Phone],
		[UserName],
		[FirstName],
		[LastName],
		[Password]
	FROM [Users]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End UsersGetAllOnPage */

/* Start UsersInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UsersInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UsersInsert];
GO
CREATE PROCEDURE [dbo].[UsersInsert]
	@RoleId uniqueidentifier = null,
	@CreatedDate datetime = null,
	@IsDelete bit = null,
	@ExpriedDate datetime = null,
	@Email nvarchar(512) = null,
	@CreatedBy nvarchar(max) = null,
	@UpdatedDate datetime = null,
	@UdpatedBy nvarchar(max) = null,
	@Name nvarchar(128) = null,
	@BirthDay datetime = null,
	@UserType nvarchar(32) = null,
	@ImageURL nvarchar(255) = null,
	@Address nvarchar(255) = null,
	@Phone nvarchar(16) = null,
	@UserName nvarchar(512) = null,
	@FirstName nvarchar(512) = null,
	@LastName nvarchar(512) = null,
	@Password nvarchar(256) = null
AS
BEGIN
	INSERT INTO [Users]
	(
		[RoleId],
		[CreatedDate],
		[IsDelete],
		[ExpriedDate],
		[Email],
		[CreatedBy],
		[UpdatedDate],
		[UdpatedBy],
		[Name],
		[BirthDay],
		[UserType],
		[ImageURL],
		[Address],
		[Phone],
		[UserName],
		[FirstName],
		[LastName],
		[Password]
	)
	VALUES
	(
		@RoleId,
		@CreatedDate,
		@IsDelete,
		@ExpriedDate,
		@Email,
		@CreatedBy,
		@UpdatedDate,
		@UdpatedBy,
		@Name,
		@BirthDay,
		@UserType,
		@ImageURL,
		@Address,
		@Phone,
		@UserName,
		@FirstName,
		@LastName,
		@Password
	)
END
GO
/* End UsersInsert */

/* Start UsersUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UsersUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UsersUpdate];
GO
CREATE PROCEDURE [dbo].[UsersUpdate]
	@Id int = null,
	@RoleId uniqueidentifier = null,
	@CreatedDate datetime = null,
	@IsDelete bit = null,
	@ExpriedDate datetime = null,
	@Email nvarchar(512) = null,
	@CreatedBy nvarchar(max) = null,
	@UpdatedDate datetime = null,
	@UdpatedBy nvarchar(max) = null,
	@Name nvarchar(128) = null,
	@BirthDay datetime = null,
	@UserType nvarchar(32) = null,
	@ImageURL nvarchar(255) = null,
	@Address nvarchar(255) = null,
	@Phone nvarchar(16) = null,
	@UserName nvarchar(512) = null,
	@FirstName nvarchar(512) = null,
	@LastName nvarchar(512) = null,
	@Password nvarchar(256) = null
AS
BEGIN
	UPDATE [Users] SET
		[RoleId] = @RoleId,
		[CreatedDate] = @CreatedDate,
		[IsDelete] = @IsDelete,
		[ExpriedDate] = @ExpriedDate,
		[Email] = @Email,
		[CreatedBy] = @CreatedBy,
		[UpdatedDate] = @UpdatedDate,
		[UdpatedBy] = @UdpatedBy,
		[Name] = @Name,
		[BirthDay] = @BirthDay,
		[UserType] = @UserType,
		[ImageURL] = @ImageURL,
		[Address] = @Address,
		[Phone] = @Phone,
		[UserName] = @UserName,
		[FirstName] = @FirstName,
		[LastName] = @LastName,
		[Password] = @Password
	WHERE [Id] = @Id
END
GO
/* End UsersUpdate */

/* Start UsersDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UsersDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UsersDelete];
GO
CREATE PROCEDURE [dbo].[UsersDelete]
	@Id int = null
AS
BEGIN
	DELETE [Users]
	WHERE [Id] = @Id
END
GO
/* End UsersDelete */

/* Start UsersDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UsersDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UsersDeleteAll];
GO
CREATE PROCEDURE [dbo].[UsersDeleteAll]
AS
BEGIN
	DELETE [Users]
END
GO
/* End UsersDeleteAll */
