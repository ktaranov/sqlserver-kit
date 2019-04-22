/*
<documentation>
  <author>Konstantin Taranov</author>
  <summary>Create JOIN query between multiple tables dynamically.</summary>
  <returns>SELECT statement from input table with INNER JOINS for all tables having foreign consttraints with input table.</returns>
  <created>2019-04-22</created>
  <modified>2019-04-22</modified>
  <version>1.0</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Create_JOIN_Query_Between_Multiple_Tables_Dynamically.sql</sourceLink>
</documentation>
*/

DECLARE @table AS VARCHAR(100)= 'YouTableName';

WITH AllColumns
     AS (SELECT
                pObj.name AS ParentTable
               ,pCol.COLUMN_NAME AS ParentColumn
               ,fkObj.name AS ReferecedTable
               ,fkCol.COLUMN_NAME AS ReferencedColumn
         FROM sys.foreign_key_columns AS fkc
              INNER JOIN sys.objects AS pObj ON pObj.object_id = fkc.parent_object_id
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
                        tc.CONSTRAINT_NAME
                 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
                 WHERE tc.CONSTRAINT_TYPE = 'FOREIGN KEY'
                       AND tc.TABLE_NAME = @table
             )
         ))
     SELECT
            'SELECT *
        FROM ' + @table +
     (
         SELECT 
                ' INNER JOIN ' + ac.ReferecedTable + ' ON ' + ac.ParentTable + '.' + ac.ParentColumn + '=' + ac.ReferecedTable + '.' + ac.ReferencedColumn + CHAR(10)
         FROM AllColumns AS ac FOR
         XML PATH('')
     );
