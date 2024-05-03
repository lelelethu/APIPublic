
/* Start ApClient_ErrorGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ApClient_ErrorGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ApClient_ErrorGetById];
GO
CREATE PROCEDURE [dbo].[ApClient_ErrorGetById]
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
		[Response]
	FROM [ApClient_Error]
	WHERE [Id] = @Id
END
GO
/* End ApClient_ErrorGetById */

/* Start ApClient_ErrorGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ApClient_ErrorGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ApClient_ErrorGetAll];
GO
CREATE PROCEDURE [dbo].[ApClient_ErrorGetAll]
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
		[Response]
	FROM [ApClient_Error]
END
GO
/* End ApClient_ErrorGetAll */

/* Start ApClient_ErrorGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ApClient_ErrorGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ApClient_ErrorGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[ApClient_ErrorGetAllOnPage]
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
		[Response]
	FROM [ApClient_Error]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End ApClient_ErrorGetAllOnPage */

/* Start ApClient_ErrorInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ApClient_ErrorInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ApClient_ErrorInsert];
GO
CREATE PROCEDURE [dbo].[ApClient_ErrorInsert]
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@ErrorMessage nvarchar(max) = null,
	@CreatedDate datetime = null,
	@UserId int = null,
	@KeyId int = null,
	@UniqueDeviceId nvarchar(256) = null,
	@APIName nvarchar(256) = null,
	@Response nvarchar(max) = null
AS
BEGIN
	INSERT INTO [ApClient_Error]
	(
		[WebName],
		[GameName],
		[ErrorMessage],
		[CreatedDate],
		[UserId],
		[KeyId],
		[UniqueDeviceId],
		[APIName],
		[Response]
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
		@Response
	)
END
GO
/* End ApClient_ErrorInsert */

/* Start ApClient_ErrorUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ApClient_ErrorUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ApClient_ErrorUpdate];
GO
CREATE PROCEDURE [dbo].[ApClient_ErrorUpdate]
	@Id bigint = null,
	@WebName nvarchar(256) = null,
	@GameName nvarchar(256) = null,
	@ErrorMessage nvarchar(max) = null,
	@CreatedDate datetime = null,
	@UserId int = null,
	@KeyId int = null,
	@UniqueDeviceId nvarchar(256) = null,
	@APIName nvarchar(256) = null,
	@Response nvarchar(max) = null
AS
BEGIN
	UPDATE [ApClient_Error] SET
		[WebName] = @WebName,
		[GameName] = @GameName,
		[ErrorMessage] = @ErrorMessage,
		[CreatedDate] = @CreatedDate,
		[UserId] = @UserId,
		[KeyId] = @KeyId,
		[UniqueDeviceId] = @UniqueDeviceId,
		[APIName] = @APIName,
		[Response] = @Response
	WHERE [Id] = @Id
END
GO
/* End ApClient_ErrorUpdate */

/* Start ApClient_ErrorDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ApClient_ErrorDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ApClient_ErrorDelete];
GO
CREATE PROCEDURE [dbo].[ApClient_ErrorDelete]
	@Id bigint = null
AS
BEGIN
	DELETE [ApClient_Error]
	WHERE [Id] = @Id
END
GO
/* End ApClient_ErrorDelete */

/* Start ApClient_ErrorDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ApClient_ErrorDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ApClient_ErrorDeleteAll];
GO
CREATE PROCEDURE [dbo].[ApClient_ErrorDeleteAll]
AS
BEGIN
	DELETE [ApClient_Error]
END
GO
/* End ApClient_ErrorDeleteAll */
