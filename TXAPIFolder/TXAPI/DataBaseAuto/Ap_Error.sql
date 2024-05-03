
/* Start Ap_ErrorGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Ap_ErrorGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Ap_ErrorGetById];
GO
CREATE PROCEDURE [dbo].[Ap_ErrorGetById]
	@Id bigint = null
AS
BEGIN
	SELECT
		[Id],
		[WebName],
		[GameName],
		[ErrorMessage],
		[CreatedDate],
		[UserId],
		[KeyId],
		[UniqueDeviceId],
		[APIName],
		[Request]
	FROM [Ap_Error]
	WHERE [Id] = @Id
END
GO
/* End Ap_ErrorGetById */

/* Start Ap_ErrorGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Ap_ErrorGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Ap_ErrorGetAll];
GO
CREATE PROCEDURE [dbo].[Ap_ErrorGetAll]
AS
BEGIN
	SELECT
		[Id],
		[WebName],
		[GameName],
		[ErrorMessage],
		[CreatedDate],
		[UserId],
		[KeyId],
		[UniqueDeviceId],
		[APIName],
		[Request]
	FROM [Ap_Error]
END
GO
/* End Ap_ErrorGetAll */

/* Start Ap_ErrorGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Ap_ErrorGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Ap_ErrorGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[Ap_ErrorGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Id],
		[WebName],
		[GameName],
		[ErrorMessage],
		[CreatedDate],
		[UserId],
		[KeyId],
		[UniqueDeviceId],
		[APIName],
		[Request]
	FROM [Ap_Error]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End Ap_ErrorGetAllOnPage */

/* Start Ap_ErrorInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Ap_ErrorInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Ap_ErrorInsert];
GO
CREATE PROCEDURE [dbo].[Ap_ErrorInsert]
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@ErrorMessage nvarchar(max) = null,
	@CreatedDate datetime = null,
	@UserId int = null,
	@KeyId int = null,
	@UniqueDeviceId nvarchar(256) = null,
	@APIName nvarchar(256) = null,
	@Request nvarchar(max) = null
AS
BEGIN
	INSERT INTO [Ap_Error]
	(
		[WebName],
		[GameName],
		[ErrorMessage],
		[CreatedDate],
		[UserId],
		[KeyId],
		[UniqueDeviceId],
		[APIName],
		[Request]
	)
	VALUES
	(
		@WebName,
		@GameName,
		@ErrorMessage,
		@CreatedDate,
		@UserId,
		@KeyId,
		@UniqueDeviceId,
		@APIName,
		@Request
	)
END
GO
/* End Ap_ErrorInsert */

/* Start Ap_ErrorUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Ap_ErrorUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Ap_ErrorUpdate];
GO
CREATE PROCEDURE [dbo].[Ap_ErrorUpdate]
	@Id bigint = null,
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@ErrorMessage nvarchar(max) = null,
	@CreatedDate datetime = null,
	@UserId int = null,
	@KeyId int = null,
	@UniqueDeviceId nvarchar(256) = null,
	@APIName nvarchar(256) = null,
	@Request nvarchar(max) = null
AS
BEGIN
	UPDATE [Ap_Error] SET
		[WebName] = @WebName,
		[GameName] = @GameName,
		[ErrorMessage] = @ErrorMessage,
		[CreatedDate] = @CreatedDate,
		[UserId] = @UserId,
		[KeyId] = @KeyId,
		[UniqueDeviceId] = @UniqueDeviceId,
		[APIName] = @APIName,
		[Request] = @Request
	WHERE [Id] = @Id
END
GO
/* End Ap_ErrorUpdate */

/* Start Ap_ErrorDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Ap_ErrorDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Ap_ErrorDelete];
GO
CREATE PROCEDURE [dbo].[Ap_ErrorDelete]
	@Id bigint = null
AS
BEGIN
	DELETE [Ap_Error]
	WHERE [Id] = @Id
END
GO
/* End Ap_ErrorDelete */

/* Start Ap_ErrorDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Ap_ErrorDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Ap_ErrorDeleteAll];
GO
CREATE PROCEDURE [dbo].[Ap_ErrorDeleteAll]
AS
BEGIN
	DELETE [Ap_Error]
END
GO
/* End Ap_ErrorDeleteAll */
