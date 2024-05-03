
/* Start BaseGameExcelGetAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[BaseGameExcelGetAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [BaseGameExcelGetAll];
GO
CREATE PROCEDURE [dbo].[BaseGameExcelGetAll]
AS
BEGIN
	SELECT
		[BaseGame]
	FROM [BaseGameExcel]
END
GO
/* End BaseGameExcelGetAll */

/* Start BaseGameExcelGetAllOnPage */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[BaseGameExcelGetAllOnPage]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [BaseGameExcelGetAllOnPage];
GO
CREATE PROCEDURE [dbo].[BaseGameExcelGetAllOnPage]
	@PageSize int = null,
	@PageIndex int = null
AS
BEGIN
	SELECT
		COUNT(*) OVER ( ORDER BY (SELECT NULL)) as RowNumber,
		[BaseGame]
	FROM [BaseGameExcel]
	ORDER BY BaseGame
	OFFSET (@PageIndex-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END
GO
/* End BaseGameExcelGetAllOnPage */

/* Start BaseGameExcelInsert */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[BaseGameExcelInsert]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [BaseGameExcelInsert];
GO
CREATE PROCEDURE [dbo].[BaseGameExcelInsert]
	@BaseGame nvarchar(255) = null
AS
BEGIN
	INSERT INTO [BaseGameExcel]
	(
		[BaseGame]
	)
	VALUES
	(
		@BaseGame
	)
END
GO
/* End BaseGameExcelInsert */

/* Start BaseGameExcelDeleteAll */
IF EXISTS
(
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[BaseGameExcelDeleteAll]') AND type IN ( N'P', N'PC' )
)
DROP PROCEDURE [BaseGameExcelDeleteAll];
GO
CREATE PROCEDURE [dbo].[BaseGameExcelDeleteAll]
AS
BEGIN
	DELETE [BaseGameExcel]
END
GO
/* End BaseGameExcelDeleteAll */
