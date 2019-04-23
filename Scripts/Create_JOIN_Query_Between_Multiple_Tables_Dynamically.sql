/*
<documentation>
  <summary>Create JOIN query between multiple tables dynamically.</summary>
  <returns>SELECT statement from input table with INNER JOINS for all tables having foreign consttraints with input table.</returns>
  <issues>Does not properly generate alias for case with multiply foreign keys for one table</issues>
  <author>Konstantin Taranov</author>
  <created>2019-04-22</created>
  <modified>2019-04-23 by Konstantin Taranov</modified>
  <version>1.1</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Create_JOIN_Query_Between_Multiple_Tables_Dynamically.sql</sourceLink>
</documentation>
*/

DECLARE @schemaName    AS sysname       = N'dbo';
DECLARE @tableName     AS sysname       = N'TableName';
DECLARE @tableFullName AS nvarchar(256) = QUOTENAME(@schemaName) + N'.' + QUOTENAME(@tableName)
DECLARE @crlf          AS varchar(10)   = CHAR(10);
DECLARE @tsql          AS nvarchar(max);

IF LEFT(@tableName, 1) = N'[' OR LEFT(@schemaName, 1) = N'['
THROW 50001, 'Please do not use quotes in Table or Schema names! In the script it is alredy done with QUOTENAME function.', 1;

IF OBJECT_ID(@tableFullName) IS NULL
THROW 50002, 'Table is not exist in database. Please check @schemaName and @tableName variables.', 1;


WITH AllColumns
     AS (SELECT
                pObj.name                    AS ParentTable
               ,pCol.COLUMN_NAME             AS ParentColumn
               ,SCHEMA_NAME(fkObj.schema_id) AS ReferecedTableSchema
               ,fkObj.name                   AS ReferecedTable
               ,fkCol.COLUMN_NAME            AS ReferencedColumn
         FROM sys.foreign_key_columns AS fkc
              INNER JOIN sys.objects  AS pObj ON pObj.object_id = fkc.parent_object_id
              INNER JOIN INFORMATION_SCHEMA.COLUMNS AS pCol ON pCol.TABLE_NAME = pObj.name
                                                               AND pCol.ORDINAL_POSITION = fkc.parent_column_id
              INNER JOIN sys.objects AS fkObj ON fkObj.object_id = fkc.referenced_object_id
              INNER JOIN INFORMATION_SCHEMA.COLUMNS AS fkCol ON fkCol.TABLE_NAME = fkObj.name
                                                                AND fkCol.ORDINAL_POSITION = fkc.referenced_column_id
         WHERE fkc.constraint_object_id IN
         (
             SELECT
                    object_id
             FROM sys.objects AS o
             WHERE o.name IN
             (
                 SELECT
                        tc.CONSTRAINT_NAME AS CONSTRAINT_NAME
                 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
                 WHERE tc.CONSTRAINT_TYPE = 'FOREIGN KEY'
                   AND tc.TABLE_NAME   = @tableName
                   AND tc.TABLE_SCHEMA = @schemaName
             )
         ))
     SELECT 
            @tsql = 
           N'SELECT TOP(100) ' + QUOTENAME(@tableName) + N'.*' + @crlf +
           N'FROM ' + @tableFullName +
     ISNULL(
     (
         SELECT
                @crlf +  N'INNER JOIN ' + QUOTENAME(ac.ReferecedTableSchema) + N'.' + QUOTENAME(ac.ReferecedTable) + N' ON' + @crlf +
                N'           ' + QUOTENAME(ac.ParentTable) + N'.' + QUOTENAME(ac.ParentColumn) + ' = ' +
                QUOTENAME(ac.ReferecedTable) + '.' + QUOTENAME(ac.ReferencedColumn)
         FROM AllColumns AS ac FOR
         XML PATH('')
     ), N'') + N';';

IF @tsql IS NULL
PRINT('@tsql is NULL - something went wrong!');
ELSE
PRINT(@tsql);
