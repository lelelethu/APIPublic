
/* Start CustomersGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[CustomersGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [CustomersGetById];
GO
CREATE PROCEDURE [dbo].[CustomersGetById]
	@Id int = null
AS
BEGIN
	SELECT
		[Id],
		[CreatedDate],
		[IsDelete],
		[CreatedBy],
		[UpdatedDate],
		[UdpatedBy],
		[UserName],
		[Password],
		[Address],
		[Phone],
		[PostCode],
		[FirstName],
		[LastName]
	FROM [Customers]
	WHERE [Id] = @Id
END
GO
/* End CustomersGetById */

/* Start CustomersGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[CustomersGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [CustomersGetAll];
GO
CREATE PROCEDURE [dbo].[CustomersGetAll]
AS
BEGIN
	SELECT
		[Id],
		[CreatedDate],
		[IsDelete],
		[CreatedBy],
		[UpdatedDate],
		[UdpatedBy],
		[UserName],
		[Password],
		[Address],
		[Phone],
		[PostCode],
		[FirstName],
		[LastName]
	FROM [Customers]
END
GO
/* End CustomersGetAll */

/* Start CustomersGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[CustomersGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [CustomersGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[CustomersGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Id],
		[CreatedDate],
		[IsDelete],
		[CreatedBy],
		[UpdatedDate],
		[UdpatedBy],
		[UserName],
		[Password],
		[Address],
		[Phone],
		[PostCode],
		[FirstName],
		[LastName]
	FROM [Customers]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End CustomersGetAllOnPage */

/* Start CustomersInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[CustomersInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [CustomersInsert];
GO
CREATE PROCEDURE [dbo].[CustomersInsert]
	@CreatedDate datetime = null,
	@IsDelete bit = null,
	@CreatedBy nvarchar(max) = null,
	@UpdatedDate datetime = null,
	@UdpatedBy nvarchar(max) = null,
	@UserName nvarchar(32) = null,
	@Password nvarchar(32) = null,
	@Address nvarchar(512) = null,
	@Phone nvarchar(16) = null,
	@PostCode nvarchar(32) = null,
	@FirstName nvarchar(max) = null,
	@LastName nvarchar(max) = null
AS
BEGIN
	INSERT INTO [Customers]
	(
		[CreatedDate],
		[IsDelete],
		[CreatedBy],
		[UpdatedDate],
		[UdpatedBy],
		[UserName],
		[Password],
		[Address],
		[Phone],
		[PostCode],
		[FirstName],
		[LastName]
	)
	VALUES
	(
		@CreatedDate,
		@IsDelete,
		@CreatedBy,
		@UpdatedDate,
		@UdpatedBy,
		@UserName,
		@Password,
		@Address,
		@Phone,
		@PostCode,
		@FirstName,
		@LastName
	)
END
GO
/* End CustomersInsert */

/* Start CustomersUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[CustomersUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [CustomersUpdate];
GO
CREATE PROCEDURE [dbo].[CustomersUpdate]
	@Id int = null,
	@CreatedDate datetime = null,
	@IsDelete bit = null,
	@CreatedBy nvarchar(max) = null,
	@UpdatedDate datetime = null,
	@UdpatedBy nvarchar(max) = null,
	@UserName nvarchar(32) = null,
	@Password nvarchar(32) = null,
	@Address nvarchar(512) = null,
	@Phone nvarchar(16) = null,
	@PostCode nvarchar(32) = null,
	@FirstName nvarchar(max) = null,
	@LastName nvarchar(max) = null
AS
BEGIN
	UPDATE [Customers] SET
		[CreatedDate] = @CreatedDate,
		[IsDelete] = @IsDelete,
		[CreatedBy] = @CreatedBy,
		[UpdatedDate] = @UpdatedDate,
		[UdpatedBy] = @UdpatedBy,
		[UserName] = @UserName,
		[Password] = @Password,
		[Address] = @Address,
		[Phone] = @Phone,
		[PostCode] = @PostCode,
		[FirstName] = @FirstName,
		[LastName] = @LastName
	WHERE [Id] = @Id
END
GO
/* End CustomersUpdate */

/* Start CustomersDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[CustomersDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [CustomersDelete];
GO
CREATE PROCEDURE [dbo].[CustomersDelete]
	@Id int = null
AS
BEGIN
	DELETE [Customers]
	WHERE [Id] = @Id
END
GO
/* End CustomersDelete */

/* Start CustomersDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[CustomersDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [CustomersDeleteAll];
GO
CREATE PROCEDURE [dbo].[CustomersDeleteAll]
AS
BEGIN
	DELETE [Customers]
END
GO
/* End CustomersDeleteAll */
