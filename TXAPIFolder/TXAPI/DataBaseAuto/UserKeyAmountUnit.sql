
/* Start UserKeyAmountUnitGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyAmountUnitGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyAmountUnitGetById];
GO
CREATE PROCEDURE [dbo].[UserKeyAmountUnitGetById]
	@Id int = null
AS
BEGIN
	SELECT
		[Id],
		[UserId],
		[KeyId],
		[AmountUnit]
	FROM [UserKeyAmountUnit]
	WHERE [Id] = @Id
END
GO
/* End UserKeyAmountUnitGetById */

/* Start UserKeyAmountUnitGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyAmountUnitGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyAmountUnitGetAll];
GO
CREATE PROCEDURE [dbo].[UserKeyAmountUnitGetAll]
AS
BEGIN
	SELECT
		[Id],
		[UserId],
		[KeyId],
		[AmountUnit]
	FROM [UserKeyAmountUnit]
END
GO
/* End UserKeyAmountUnitGetAll */

/* Start UserKeyAmountUnitGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyAmountUnitGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyAmountUnitGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[UserKeyAmountUnitGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Id],
		[UserId],
		[KeyId],
		[AmountUnit]
	FROM [UserKeyAmountUnit]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End UserKeyAmountUnitGetAllOnPage */

/* Start UserKeyAmountUnitInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyAmountUnitInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyAmountUnitInsert];
GO
CREATE PROCEDURE [dbo].[UserKeyAmountUnitInsert]
	@UserId int = null,
	@KeyId int = null,
	@AmountUnit float = null
AS
BEGIN
	INSERT INTO [UserKeyAmountUnit]
	(
		[UserId],
		[KeyId],
		[AmountUnit]
	)
	VALUES
	(
		@UserId,
		@KeyId,
		@AmountUnit
	)
END
GO
/* End UserKeyAmountUnitInsert */

/* Start UserKeyAmountUnitUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyAmountUnitUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyAmountUnitUpdate];
GO
CREATE PROCEDURE [dbo].[UserKeyAmountUnitUpdate]
	@Id int = null,
	@UserId int = null,
	@KeyId int = null,
	@AmountUnit float = null
AS
BEGIN
	UPDATE [UserKeyAmountUnit] SET
		[UserId] = @UserId,
		[KeyId] = @KeyId,
		[AmountUnit] = @AmountUnit
	WHERE [Id] = @Id
END
GO
/* End UserKeyAmountUnitUpdate */

/* Start UserKeyAmountUnitDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyAmountUnitDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyAmountUnitDelete];
GO
CREATE PROCEDURE [dbo].[UserKeyAmountUnitDelete]
	@Id int = null
AS
BEGIN
	DELETE [UserKeyAmountUnit]
	WHERE [Id] = @Id
END
GO
/* End UserKeyAmountUnitDelete */

/* Start UserKeyAmountUnitDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[UserKeyAmountUnitDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [UserKeyAmountUnitDeleteAll];
GO
CREATE PROCEDURE [dbo].[UserKeyAmountUnitDeleteAll]
AS
BEGIN
	DELETE [UserKeyAmountUnit]
END
GO
/* End UserKeyAmountUnitDeleteAll */
