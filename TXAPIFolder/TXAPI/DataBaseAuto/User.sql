
/* Start UserGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserGetById];
GO
CREATE PROCEDURE [dbo].[UserGetById]
	@Id int = null
AS
BEGIN
	SELECT
		[Id],
		[UserName],
		[FirstName],
		[LastName],
		[Email],
		[Password],
		[RoleId],
		[BirthDay],
		[UserType],
		[ImageURL],
		[Address],
		[Phone],
		[CreatedDate],
		[CreatedBy],
		[UpdatedDate],
		[UdpatedBy],
		[IsDelete],
		[ExpriedDate]
	FROM [User]
	WHERE [Id] = @Id
END
GO
/* End UserGetById */

/* Start UserGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserGetAll];
GO
CREATE PROCEDURE [dbo].[UserGetAll]
AS
BEGIN
	SELECT
		[Id],
		[UserName],
		[FirstName],
		[LastName],
		[Email],
		[Password],
		[RoleId],
		[BirthDay],
		[UserType],
		[ImageURL],
		[Address],
		[Phone],
		[CreatedDate],
		[CreatedBy],
		[UpdatedDate],
		[UdpatedBy],
		[IsDelete],
		[ExpriedDate]
	FROM [User]
END
GO
/* End UserGetAll */

/* Start UserGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[UserGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Id],
		[UserName],
		[FirstName],
		[LastName],
		[Email],
		[Password],
		[RoleId],
		[BirthDay],
		[UserType],
		[ImageURL],
		[Address],
		[Phone],
		[CreatedDate],
		[CreatedBy],
		[UpdatedDate],
		[UdpatedBy],
		[IsDelete],
		[ExpriedDate]
	FROM [User]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End UserGetAllOnPage */

/* Start UserInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserInsert];
GO
CREATE PROCEDURE [dbo].[UserInsert]
	@UserName nvarchar(256) = null,
	@FirstName nvarchar(256) = null,
	@LastName nvarchar(256) = null,
	@Email nvarchar(256) = null,
	@Password nvarchar(256) = null,
	@RoleId uniqueidentifier = null,
	@BirthDay datetime = null,
	@UserType nvarchar(256) = null,
	@ImageURL nvarchar(256) = null,
	@Address nvarchar(256) = null,
	@Phone nvarchar(16) = null,
	@CreatedDate datetime = null,
	@CreatedBy nvarchar(256) = null,
	@UpdatedDate datetime = null,
	@UdpatedBy nvarchar(256) = null,
	@IsDelete bit = null,
	@ExpriedDate datetime = null
AS
BEGIN
	INSERT INTO [User]
	(
		[UserName],
		[FirstName],
		[LastName],
		[Email],
		[Password],
		[RoleId],
		[BirthDay],
		[UserType],
		[ImageURL],
		[Address],
		[Phone],
		[CreatedDate],
		[CreatedBy],
		[UpdatedDate],
		[UdpatedBy],
		[IsDelete],
		[ExpriedDate]
	)
	VALUES
	(
		@UserName,
		@FirstName,
		@LastName,
		@Email,
		@Password,
		@RoleId,
		@BirthDay,
		@UserType,
		@ImageURL,
		@Address,
		@Phone,
		@CreatedDate,
		@CreatedBy,
		@UpdatedDate,
		@UdpatedBy,
		@IsDelete,
		@ExpriedDate
	)
END
GO
/* End UserInsert */

/* Start UserUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserUpdate];
GO
CREATE PROCEDURE [dbo].[UserUpdate]
	@Id int = null,
	@UserName nvarchar(256) = null,
	@FirstName nvarchar(256) = null,
	@LastName nvarchar(256) = null,
	@Email nvarchar(256) = null,
	@Password nvarchar(256) = null,
	@RoleId uniqueidentifier = null,
	@BirthDay datetime = null,
	@UserType nvarchar(256) = null,
	@ImageURL nvarchar(256) = null,
	@Address nvarchar(256) = null,
	@Phone nvarchar(16) = null,
	@CreatedDate datetime = null,
	@CreatedBy nvarchar(256) = null,
	@UpdatedDate datetime = null,
	@UdpatedBy nvarchar(256) = null,
	@IsDelete bit = null,
	@ExpriedDate datetime = null
AS
BEGIN
	UPDATE [User] SET
		[UserName] = @UserName,
		[FirstName] = @FirstName,
		[LastName] = @LastName,
		[Email] = @Email,
		[Password] = @Password,
		[RoleId] = @RoleId,
		[BirthDay] = @BirthDay,
		[UserType] = @UserType,
		[ImageURL] = @ImageURL,
		[Address] = @Address,
		[Phone] = @Phone,
		[CreatedDate] = @CreatedDate,
		[CreatedBy] = @CreatedBy,
		[UpdatedDate] = @UpdatedDate,
		[UdpatedBy] = @UdpatedBy,
		[IsDelete] = @IsDelete,
		[ExpriedDate] = @ExpriedDate
	WHERE [Id] = @Id
END
GO
/* End UserUpdate */

/* Start UserDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserDelete];
GO
CREATE PROCEDURE [dbo].[UserDelete]
	@Id int = null
AS
BEGIN
	DELETE [User]
	WHERE [Id] = @Id
END
GO
/* End UserDelete */

/* Start UserDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserDeleteAll];
GO
CREATE PROCEDURE [dbo].[UserDeleteAll]
AS
BEGIN
	DELETE [User]
END
GO
/* End UserDeleteAll */
