
/* Start KeyGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[KeyGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [KeyGetById];
GO
CREATE PROCEDURE [dbo].[KeyGetById]
	@Id int = null
AS
BEGIN
	SELECT
		[Status],
		[Id],
		[Key],
		[AmountUnit],
		[ExpireDate],
		[LimitMoney],
		[FromTime],
		[ToTime],
		[CreatedDate],
		[CreatedBy]
	FROM [Key]
	WHERE [Id] = @Id
END
GO
/* End KeyGetById */

/* Start KeyGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[KeyGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [KeyGetAll];
GO
CREATE PROCEDURE [dbo].[KeyGetAll]
AS
BEGIN
	SELECT
		[Status],
		[Id],
		[Key],
		[AmountUnit],
		[ExpireDate],
		[LimitMoney],
		[FromTime],
		[ToTime],
		[CreatedDate],
		[CreatedBy]
	FROM [Key]
END
GO
/* End KeyGetAll */

/* Start KeyGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[KeyGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [KeyGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[KeyGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Status],
		[Id],
		[Key],
		[AmountUnit],
		[ExpireDate],
		[LimitMoney],
		[FromTime],
		[ToTime],
		[CreatedDate],
		[CreatedBy]
	FROM [Key]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End KeyGetAllOnPage */

/* Start KeyInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[KeyInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [KeyInsert];
GO
CREATE PROCEDURE [dbo].[KeyInsert]
	@Status bit = null,
	@Key nvarchar(256) = null,
	@AmountUnit float = null,
	@ExpireDate date = null,
	@LimitMoney float = null,
	@FromTime time(7) = null,
	@ToTime time(7) = null,
	@CreatedDate date = null,
	@CreatedBy int = null
AS
BEGIN
	INSERT INTO [Key]
	(
		[Status],
		[Key],
		[AmountUnit],
		[ExpireDate],
		[LimitMoney],
		[FromTime],
		[ToTime],
		[CreatedDate],
		[CreatedBy]
	)
	VALUES
	(
		@Status,
		@Key,
		@AmountUnit,
		@ExpireDate,
		@LimitMoney,
		@FromTime,
		@ToTime,
		@CreatedDate,
		@CreatedBy
	)
END
GO
/* End KeyInsert */

/* Start KeyUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[KeyUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [KeyUpdate];
GO
CREATE PROCEDURE [dbo].[KeyUpdate]
	@Status bit = null,
	@Id int = null,
	@Key nvarchar(256) = null,
	@AmountUnit float = null,
	@ExpireDate date = null,
	@LimitMoney float = null,
	@FromTime time(7) = null,
	@ToTime time(7) = null,
	@CreatedDate date = null,
	@CreatedBy int = null
AS
BEGIN
	UPDATE [Key] SET
		[Status] = @Status,
		[Key] = @Key,
		[AmountUnit] = @AmountUnit,
		[ExpireDate] = @ExpireDate,
		[LimitMoney] = @LimitMoney,
		[FromTime] = @FromTime,
		[ToTime] = @ToTime,
		[CreatedDate] = @CreatedDate,
		[CreatedBy] = @CreatedBy
	WHERE [Id] = @Id
END
GO
/* End KeyUpdate */

/* Start KeyDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[KeyDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [KeyDelete];
GO
CREATE PROCEDURE [dbo].[KeyDelete]
	@Id int = null
AS
BEGIN
	DELETE [Key]
	WHERE [Id] = @Id
END
GO
/* End KeyDelete */

/* Start KeyDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[KeyDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [KeyDeleteAll];
GO
CREATE PROCEDURE [dbo].[KeyDeleteAll]
AS
BEGIN
	DELETE [Key]
END
GO
/* End KeyDeleteAll */
