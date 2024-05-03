
/* Start RoleFunctionsGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[RoleFunctionsGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [RoleFunctionsGetById];
GO
CREATE PROCEDURE [dbo].[RoleFunctionsGetById]
	@RoleId uniqueidentifier = null
AS
BEGIN
	SELECT
		[RoleId],
		[FunctionId]
	FROM [RoleFunctions]
	WHERE [RoleId] = @RoleId
END
GO
/* End RoleFunctionsGetById */

/* Start RoleFunctionsGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[RoleFunctionsGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [RoleFunctionsGetAll];
GO
CREATE PROCEDURE [dbo].[RoleFunctionsGetAll]
AS
BEGIN
	SELECT
		[RoleId],
		[FunctionId]
	FROM [RoleFunctions]
END
GO
/* End RoleFunctionsGetAll */

/* Start RoleFunctionsGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[RoleFunctionsGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [RoleFunctionsGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[RoleFunctionsGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[RoleId],
		[FunctionId]
	FROM [RoleFunctions]
	ORDER BY [RoleId] ,[FunctionId]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End RoleFunctionsGetAllOnPage */

/* Start RoleFunctionsInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[RoleFunctionsInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [RoleFunctionsInsert];
GO
CREATE PROCEDURE [dbo].[RoleFunctionsInsert]
AS
BEGIN
	INSERT INTO [RoleFunctions]
	(
	)
	VALUES
	(
	)
END
GO
/* End RoleFunctionsInsert */

/* Start RoleFunctionsUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[RoleFunctionsUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [RoleFunctionsUpdate];
GO
CREATE PROCEDURE [dbo].[RoleFunctionsUpdate]
	@RoleId uniqueidentifier = null,
	@FunctionId uniqueidentifier = null
AS
BEGIN
	UPDATE [RoleFunctions] SET
	WHERE [RoleId] = @RoleId
END
GO
/* End RoleFunctionsUpdate */

/* Start RoleFunctionsDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[RoleFunctionsDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [RoleFunctionsDelete];
GO
CREATE PROCEDURE [dbo].[RoleFunctionsDelete]
	@RoleId uniqueidentifier = null
AS
BEGIN
	DELETE [RoleFunctions]
	WHERE [RoleId] = @RoleId
END
GO
/* End RoleFunctionsDelete */

/* Start RoleFunctionsDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[RoleFunctionsDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [RoleFunctionsDeleteAll];
GO
CREATE PROCEDURE [dbo].[RoleFunctionsDeleteAll]
AS
BEGIN
	DELETE [RoleFunctions]
END
GO
/* End RoleFunctionsDeleteAll */
