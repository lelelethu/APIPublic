
/* Start DeviceAvailableGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[DeviceAvailableGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [DeviceAvailableGetById];
GO
CREATE PROCEDURE [dbo].[DeviceAvailableGetById]
	@Id int = null
AS
BEGIN
	SELECT
		[Id],
		[UserId],
		[KeyId],
		[UniqueDeviceId]
	FROM [DeviceAvailable]
	WHERE [Id] = @Id
END
GO
/* End DeviceAvailableGetById */

/* Start DeviceAvailableGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[DeviceAvailableGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [DeviceAvailableGetAll];
GO
CREATE PROCEDURE [dbo].[DeviceAvailableGetAll]
AS
BEGIN
	SELECT
		[Id],
		[UserId],
		[KeyId],
		[UniqueDeviceId]
	FROM [DeviceAvailable]
END
GO
/* End DeviceAvailableGetAll */

/* Start DeviceAvailableGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[DeviceAvailableGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [DeviceAvailableGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[DeviceAvailableGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Id],
		[UserId],
		[KeyId],
		[UniqueDeviceId]
	FROM [DeviceAvailable]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End DeviceAvailableGetAllOnPage */

/* Start DeviceAvailableInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[DeviceAvailableInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [DeviceAvailableInsert];
GO
CREATE PROCEDURE [dbo].[DeviceAvailableInsert]
	@UserId int = null,
	@KeyId int = null,
	@UniqueDeviceId nvarchar(50) = null
AS
BEGIN
	INSERT INTO [DeviceAvailable]
	(
		[UserId],
		[KeyId],
		[UniqueDeviceId]
	)
	VALUES
	(
		@UserId,
		@KeyId,
		@UniqueDeviceId
	)
END
GO
/* End DeviceAvailableInsert */

/* Start DeviceAvailableUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[DeviceAvailableUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [DeviceAvailableUpdate];
GO
CREATE PROCEDURE [dbo].[DeviceAvailableUpdate]
	@Id int = null,
	@UserId int = null,
	@KeyId int = null,
	@UniqueDeviceId nvarchar(50) = null
AS
BEGIN
	UPDATE [DeviceAvailable] SET
		[UserId] = @UserId,
		[KeyId] = @KeyId,
		[UniqueDeviceId] = @UniqueDeviceId
	WHERE [Id] = @Id
END
GO
/* End DeviceAvailableUpdate */

/* Start DeviceAvailableDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[DeviceAvailableDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [DeviceAvailableDelete];
GO
CREATE PROCEDURE [dbo].[DeviceAvailableDelete]
	@Id int = null
AS
BEGIN
	DELETE [DeviceAvailable]
	WHERE [Id] = @Id
END
GO
/* End DeviceAvailableDelete */

/* Start DeviceAvailableDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[DeviceAvailableDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [DeviceAvailableDeleteAll];
GO
CREATE PROCEDURE [dbo].[DeviceAvailableDeleteAll]
AS
BEGIN
	DELETE [DeviceAvailable]
END
GO
/* End DeviceAvailableDeleteAll */
