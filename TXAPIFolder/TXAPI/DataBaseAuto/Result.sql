
/* Start ResultGetById */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultGetById]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultGetById];
GO
CREATE PROCEDURE [dbo].[ResultGetById]
	@Id bigint = null
AS
BEGIN
	SELECT
		[Id],
		[LinkGame],
		[TenGame],
		[KetQua],
		[CreatedDate]
	FROM [Result]
	WHERE [Id] = @Id
END
GO
/* End ResultGetById */

/* Start ResultGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultGetAll];
GO
CREATE PROCEDURE [dbo].[ResultGetAll]
AS
BEGIN
	SELECT
		[Id],
		[LinkGame],
		[TenGame],
		[KetQua],
		[CreatedDate]
	FROM [Result]
END
GO
/* End ResultGetAll */

/* Start ResultGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[ResultGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[Id],
		[LinkGame],
		[TenGame],
		[KetQua],
		[CreatedDate]
	FROM [Result]
	ORDER BY [Id]
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End ResultGetAllOnPage */

/* Start ResultInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultInsert];
GO
CREATE PROCEDURE [dbo].[ResultInsert]
	@LinkGame nvarchar(255) = null,
	@TenGame nvarchar(255) = null,
	@KetQua nvarchar(50) = null,
	@CreatedDate datetime = null
AS
BEGIN
	INSERT INTO [Result]
	(
		[LinkGame],
		[TenGame],
		[KetQua],
		[CreatedDate]
	)
	VALUES
	(
		@LinkGame,
		@TenGame,
		@KetQua,
		@CreatedDate
	)
END
GO
/* End ResultInsert */

/* Start ResultUpdate */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultUpdate]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultUpdate];
GO
CREATE PROCEDURE [dbo].[ResultUpdate]
	@Id bigint = null,
	@LinkGame nvarchar(255) = null,
	@TenGame nvarchar(255) = null,
	@KetQua nvarchar(50) = null,
	@CreatedDate datetime = null
AS
BEGIN
	UPDATE [Result] SET
		[LinkGame] = @LinkGame,
		[TenGame] = @TenGame,
		[KetQua] = @KetQua,
		[CreatedDate] = @CreatedDate
	WHERE [Id] = @Id
END
GO
/* End ResultUpdate */

/* Start ResultDelete */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultDelete]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultDelete];
GO
CREATE PROCEDURE [dbo].[ResultDelete]
	@Id bigint = null
AS
BEGIN
	DELETE [Result]
	WHERE [Id] = @Id
END
GO
/* End ResultDelete */

/* Start ResultDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[ResultDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [ResultDeleteAll];
GO
CREATE PROCEDURE [dbo].[ResultDeleteAll]
AS
BEGIN
	DELETE [Result]
END
GO
/* End ResultDeleteAll */
