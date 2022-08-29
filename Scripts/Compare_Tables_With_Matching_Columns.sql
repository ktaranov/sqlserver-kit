/*
<documentation>
  <summary>Find all matching column names between tables. Useful for exploring databases with implied relationships but no foreign keys.</summary>
  <returns>1 data set: temp table #results.</returns>
  <issues>No</issues>
  <author>Tom Barrett</author>
  <created>2022-08-27</created>
  <modified>2022-08-27 by Tom Barrett</modified>
  <version>1.0</version>
</documentation>
*/

SET NOCOUNT ON;

/* create staging objects */
IF object_id('tempdb..#tablesToQuery') IS NOT NULL
BEGIN
	DROP TABLE #tablesToQuery
END

CREATE TABLE #tablesToQuery (
	DatabaseName NVARCHAR(1000)
	, SchemaName NVARCHAR(1000)
	, TableName NVARCHAR(1000)
	, IsProcessed BIT DEFAULT 0
	)
GO

IF object_id('tempdb..#results') IS NOT NULL
BEGIN
	DROP TABLE #results
END

CREATE TABLE #results (
	DatabaseName NVARCHAR(1000)
	, ColumnName NVARCHAR(1000)
	, Table1 NVARCHAR(1000)
	, Table2 NVARCHAR(1000)
	)
GO

/* get list of tables */
INSERT INTO #tablesToQuery (
	DatabaseName
	, SchemaName
	, TableName
	)
SELECT TABLE_CATALOG
	, TABLE_SCHEMA
	, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
ORDER BY TABLE_CATALOG
	, TABLE_SCHEMA
	, TABLE_NAME
GO

/* loop through tables and get matching columns by name */
DECLARE @x INT = 1;
DECLARE @table NVARCHAR(1000);

WHILE @x <= (
		SELECT count('dracula')
		FROM #tablesToQuery
		WHERE IsProcessed = 0
		)
BEGIN
	/* get next table*/
	SELECT TOP 1 @table = TableName
	FROM #tablesToQuery
	WHERE IsProcessed = 0;

	/* insert into #results any tables + columns that match */
	WITH cte
	AS (
		SELECT TABLE_CATALOG
			, TABLE_SCHEMA
			, TABLE_NAME
			, COLUMN_NAME
		FROM INFORMATION_SCHEMA.COLUMNS
		)
	INSERT INTO #results
	SELECT cte1.TABLE_CATALOG
		, cte1.COLUMN_NAME
		, CONCAT (
			cte1.TABLE_SCHEMA
			, '.'
			, cte1.TABLE_NAME
			)
		, CONCAT (
			cte2.TABLE_SCHEMA
			, '.'
			, cte2.TABLE_NAME
			)
	FROM cte AS cte1
	JOIN cte AS cte2 ON cte1.TABLE_CATALOG = cte2.TABLE_CATALOG
		AND cte1.TABLE_SCHEMA collate Latin1_general_CI_AI = cte2.TABLE_SCHEMA collate Latin1_general_CI_AI /* remove this line to search different schemas*/
		AND cte1.TABLE_NAME collate Latin1_general_CI_AI <> cte2.TABLE_NAME collate Latin1_general_CI_AI
		AND cte1.COLUMN_NAME collate Latin1_general_CI_AI = cte2.COLUMN_NAME collate Latin1_general_CI_AI
	WHERE cte1.TABLE_NAME = @table
		/* add any other irrelevant or metadata columns to exclude */
		AND cte1.COLUMN_NAME collate Latin1_general_CI_AI NOT IN (
			'ID'
			, 'ACTIVE'
			, 'CREATEDBY'
			, 'ETC.'
			) 

	UPDATE #tablesToQuery
	SET IsProcessed = 1
	WHERE TableName = @table;
END

/* return results */
SELECT *
FROM #results
/* uncomment this line to search results for a specific table */
/* WHERE Table1 = 'Schema.Table' */
ORDER BY ColumnName
	, Table1
	, Table2
GO

/* clean up */
DROP TABLE #results
GO

DROP TABLE #tablesToQuery
GO

