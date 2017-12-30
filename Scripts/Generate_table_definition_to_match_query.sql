/*
Author: SQL Undercover
Source link: https://sqlundercover.com/2017/08/21/undercover-toolbox-generate-a-temporary-table-definition-to-match-the-resultset-of-a-query/
*/

SET NOCOUNT ON;
 
DECLARE @Query VARCHAR(MAX) = 'select * from sys.databases;';
DECLARE @TempTableName VARCHAR(128) = '#temptable';
DECLARE @ColumnList VARCHAR(MAX);
 
SELECT @ColumnList = STUFF((SELECT ',' + name + ' ' + system_type_name + ' ' +
CASE is_nullable WHEN 0 THEN 'NOT NULL' ELSE 'NULL' END
+ CHAR(10)
FROM sys.dm_exec_describe_first_result_set(@Query, NULL, 0)
FOR XML PATH('')) ,1,1,'');
 
PRINT 'CREATE TABLE ' + @TempTableName + '('
PRINT @ColumnList;
PRINT(')');