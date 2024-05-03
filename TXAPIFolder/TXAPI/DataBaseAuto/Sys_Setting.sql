
/* Start Sys_SettingGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Sys_SettingGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Sys_SettingGetAll];
GO
CREATE PROCEDURE [dbo].[Sys_SettingGetAll]
AS
BEGIN
	SELECT
		[AdminKey],
		[DataKey]
	FROM [Sys_Setting]
END
GO
/* End Sys_SettingGetAll */

/* Start Sys_SettingGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Sys_SettingGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Sys_SettingGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[Sys_SettingGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[AdminKey],
		[DataKey]
	FROM [Sys_Setting]
	ORDER BY AdminKey
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End Sys_SettingGetAllOnPage */

/* Start Sys_SettingInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Sys_SettingInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Sys_SettingInsert];
GO
CREATE PROCEDURE [dbo].[Sys_SettingInsert]
	@AdminKey nvarchar(50) = null,
	@DataKey nvarchar(50) = null
AS
BEGIN
	INSERT INTO [Sys_Setting]
	(
		[AdminKey],
		[DataKey]
	)
	VALUES
	(
		@AdminKey,
		@DataKey
	)
END
GO
/* End Sys_SettingInsert */

/* Start Sys_SettingDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[Sys_SettingDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [Sys_SettingDeleteAll];
GO
CREATE PROCEDURE [dbo].[Sys_SettingDeleteAll]
AS
BEGIN
	DELETE [Sys_Setting]
END
GO
/* End Sys_SettingDeleteAll */
