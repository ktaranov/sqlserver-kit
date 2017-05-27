/*
Original link: http://www.sqlservercentral.com/blogs/john-morehouse-sqlruscom/2017/04/25/quick-script-finding-specific-columns
*/

/***************************************************************
  Author: John Morehouse
  Summary: interrogate each database looking for a specific column name
 
  You may alter this code for your own purposes. You may republish altered code as long as you give due credit. 
 
  THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
***************************************************************/
DECLARE @dbs AS TABLE ( name sysname, processed BIT)
DECLARE @x INT = 1
DECLARE @sql VARCHAR (2000)
DECLARE @dbName VARCHAR (50)

IF object_id ('tempdb..#results') IS NOT NULL
BEGIN
DROP TABLE #results
END

CREATE TABLE #results ( dbName sysname
, tableName VARCHAR (100)
, columnName VARCHAR (100)
, DataType VARCHAR (100)
, MaxDataLength INT
, theRowCount INT )

INSERT INTO @dbs ( name, processed )
SELECT name, 0 FROM sys.databases
WHERE database_id > 6
AND [state] = 0 --online

WHILE @x <= (SELECT COUNT( 1) FROM @dbs WHERE processed = 0 )
BEGIN
SELECT TOP 1 @dbName = name FROM @dbs WHERE processed = 0

SET @sql =
'INSERT #results (dbName, tableName, columnName, DataType, MaxDataLength, theRowCount)
SELECT ''' + @dbName + ''',t.name,c.name,st.name, c.max_length,p.rows
FROM [' + @dbName + '].sys.columns c
INNER JOIN [' + @dbName + '].sys.tables t ON c.object_id = t.object_id
INNER JOIN [' + @dbName + '].sys.systypes st ON c.user_type_ID = st.xusertype
INNER JOIN [' + @dbName + '].sys.partitions p ON t.object_id = p.object_ID
INNER JOIN [' + @dbName + '].sys.allocation_units au ON au.container_ID =
CASE
WHEN au.TYPE IN (1,3) THEN p.hobt_id
WHEN au.type IN (2) THEN p.partition_id
END
WHERE (c.name LIKE ''TIN%''
OR c.name LIKE ''TIN_TX%''
OR c.name LIKE ''%SSN%'') -- looking for specific column name
AND c.OBJECT_ID > 100 -- exluded system objects
AND st.name IN (''varchar'', ''nvarchar'') -- due to leading zeros, should be n/varchar data type
AND p.index_id IN (0,1) -- Heap or Clustered Index
AND au.type = 1 --IN_ROW_DATA only'

--PRINT @sql
BEGIN TRY
EXEC (@sql)
END TRY
BEGIN CATCH
SELECT ERROR_LINE () AS 'Error Line'
, ERROR_MESSAGE () AS 'Error Message'
, ERROR_NUMBER () AS 'Error Number'
, @dbName AS 'Database'
END CATCH

UPDATE @dbs
SET processed = 1
WHERE name = @dbName
END

SELECT * FROM #results
GO
