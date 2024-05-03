
/* Start DeviceGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[DeviceGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [DeviceGetById];
GO
CREATE PROCEDURE [dbo].[DeviceGetById]
	@Id int = null
AS
BEGIN
	SELECT
		[Id],
		[UserId],
		[KeyId],
		[AndroidId],
		[AppId],
		[AppVersionName],
		[IpAddress],
		[IsDevelopmentSetting],
		[IsDeviceRooted],
		[IsEmulator],
		[IsTablet],
		[Language],
		[Manufacturer],
		[Model],
		[NetType],
		[OsVersion],
		[PhoneBrand],
		[ScreenSize],
		[SdkVersionCode],
		[SdkVersionName],
		[UniqueDeviceId],
		[Device],
		[InfoDevice],
		[ModifiledDate],
		[CreatedDate]
	FROM [Device]
	WHERE [Id] = @Id
END
GO
/* End DeviceGetById */

/* Start DeviceGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[DeviceGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [DeviceGetAll];
GO
CREATE PROCEDURE [dbo].[DeviceGetAll]
AS
BEGIN
	SELECT
		[Id],
		[UserId],
		[KeyId],
		[AndroidId],
		[AppId],
		[AppVersionName],
		[IpAddress],
		[IsDevelopmentSetting],
		[IsDeviceRooted],
		[IsEmulator],
		[IsTablet],
		[Language],
		[Manufacturer],
		[Model],
		[NetType],
		[OsVersion],
		[PhoneBrand],
		[ScreenSize],
		[SdkVersionCode],
		[SdkVersionName],
		[UniqueDeviceId],
		[Device],
		[InfoDevice],
		[ModifiledDate],
		[CreatedDate]
	FROM [Device]
END
GO
/* End DeviceGetAll */

/* Start DeviceGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[DeviceGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [DeviceGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[DeviceGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Id],
		[UserId],
		[KeyId],
		[AndroidId],
		[AppId],
		[AppVersionName],
		[IpAddress],
		[IsDevelopmentSetting],
		[IsDeviceRooted],
		[IsEmulator],
		[IsTablet],
		[Language],
		[Manufacturer],
		[Model],
		[NetType],
		[OsVersion],
		[PhoneBrand],
		[ScreenSize],
		[SdkVersionCode],
		[SdkVersionName],
		[UniqueDeviceId],
		[Device],
		[InfoDevice],
		[ModifiledDate],
		[CreatedDate]
	FROM [Device]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End DeviceGetAllOnPage */

/* Start DeviceInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[DeviceInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [DeviceInsert];
GO
CREATE PROCEDURE [dbo].[DeviceInsert]
	@UserId int = null,
	@KeyId int = null,
	@AndroidId nvarchar(50) = null,
	@AppId nvarchar(50) = null,
	@AppVersionName nvarchar(50) = null,
	@IpAddress nvarchar(50) = null,
	@IsDevelopmentSetting bit = null,
	@IsDeviceRooted bit = null,
	@IsEmulator bit = null,
	@IsTablet bit = null,
	@Language nvarchar(50) = null,
	@Manufacturer nvarchar(50) = null,
	@Model nvarchar(50) = null,
	@NetType nvarchar(50) = null,
	@OsVersion nvarchar(50) = null,
	@PhoneBrand nvarchar(50) = null,
	@ScreenSize nvarchar(50) = null,
	@SdkVersionCode int = null,
	@SdkVersionName nvarchar(50) = null,
	@UniqueDeviceId nvarchar(50) = null,
	@Device nvarchar(50) = null,
	@InfoDevice nvarchar(max) = null,
	@ModifiledDate datetime = null,
	@CreatedDate datetime = null
AS
BEGIN
	INSERT INTO [Device]
	(
		[UserId],
		[KeyId],
		[AndroidId],
		[AppId],
		[AppVersionName],
		[IpAddress],
		[IsDevelopmentSetting],
		[IsDeviceRooted],
		[IsEmulator],
		[IsTablet],
		[Language],
		[Manufacturer],
		[Model],
		[NetType],
		[OsVersion],
		[PhoneBrand],
		[ScreenSize],
		[SdkVersionCode],
		[SdkVersionName],
		[UniqueDeviceId],
		[Device],
		[InfoDevice],
		[ModifiledDate],
		[CreatedDate]
	)
	VALUES
	(
		@UserId,
		@KeyId,
		@AndroidId,
		@AppId,
		@AppVersionName,
		@IpAddress,
		@IsDevelopmentSetting,
		@IsDeviceRooted,
		@IsEmulator,
		@IsTablet,
		@Language,
		@Manufacturer,
		@Model,
		@NetType,
		@OsVersion,
		@PhoneBrand,
		@ScreenSize,
		@SdkVersionCode,
		@SdkVersionName,
		@UniqueDeviceId,
		@Device,
		@InfoDevice,
		@ModifiledDate,
		@CreatedDate
	)
END
GO
/* End DeviceInsert */

/* Start DeviceUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[DeviceUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [DeviceUpdate];
GO
CREATE PROCEDURE [dbo].[DeviceUpdate]
	@Id int = null,
	@UserId int = null,
	@KeyId int = null,
	@AndroidId nvarchar(50) = null,
	@AppId nvarchar(50) = null,
	@AppVersionName nvarchar(50) = null,
	@IpAddress nvarchar(50) = null,
	@IsDevelopmentSetting bit = null,
	@IsDeviceRooted bit = null,
	@IsEmulator bit = null,
	@IsTablet bit = null,
	@Language nvarchar(50) = null,
	@Manufacturer nvarchar(50) = null,
	@Model nvarchar(50) = null,
	@NetType nvarchar(50) = null,
	@OsVersion nvarchar(50) = null,
	@PhoneBrand nvarchar(50) = null,
	@ScreenSize nvarchar(50) = null,
	@SdkVersionCode int = null,
	@SdkVersionName nvarchar(50) = null,
	@UniqueDeviceId nvarchar(50) = null,
	@Device nvarchar(50) = null,
	@InfoDevice nvarchar(max) = null,
	@ModifiledDate datetime = null,
	@CreatedDate datetime = null
AS
BEGIN
	UPDATE [Device] SET
		[UserId] = @UserId,
		[KeyId] = @KeyId,
		[AndroidId] = @AndroidId,
		[AppId] = @AppId,
		[AppVersionName] = @AppVersionName,
		[IpAddress] = @IpAddress,
		[IsDevelopmentSetting] = @IsDevelopmentSetting,
		[IsDeviceRooted] = @IsDeviceRooted,
		[IsEmulator] = @IsEmulator,
		[IsTablet] = @IsTablet,
		[Language] = @Language,
		[Manufacturer] = @Manufacturer,
		[Model] = @Model,
		[NetType] = @NetType,
		[OsVersion] = @OsVersion,
		[PhoneBrand] = @PhoneBrand,
		[ScreenSize] = @ScreenSize,
		[SdkVersionCode] = @SdkVersionCode,
		[SdkVersionName] = @SdkVersionName,
		[UniqueDeviceId] = @UniqueDeviceId,
		[Device] = @Device,
		[InfoDevice] = @InfoDevice,
		[ModifiledDate] = @ModifiledDate,
		[CreatedDate] = @CreatedDate
	WHERE [Id] = @Id
END
GO
/* End DeviceUpdate */

/* Start DeviceDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[DeviceDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [DeviceDelete];
GO
CREATE PROCEDURE [dbo].[DeviceDelete]
	@Id int = null
AS
BEGIN
	DELETE [Device]
	WHERE [Id] = @Id
END
GO
/* End DeviceDelete */

/* Start DeviceDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[DeviceDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [DeviceDeleteAll];
GO
CREATE PROCEDURE [dbo].[DeviceDeleteAll]
AS
BEGIN
	DELETE [Device]
END
GO
/* End DeviceDeleteAll */
