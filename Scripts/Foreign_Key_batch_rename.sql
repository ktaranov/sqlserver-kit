/*
Author: Wes Henriksen
Source: http://www.sqlservercentral.com/scripts/Foreign+Keys+%28FK%29/97811/
*/
DECLARE @SchemaName VARCHAR(50) = NULL;
DECLARE @TableName VARCHAR(250) = NULL;
DECLARE @ColumnName VARCHAR(250) = NULL;
DECLARE @SQLDrop VARCHAR(MAX) = '';
DECLARE @SQLAdd VARCHAR(MAX) = '';
DECLARE @SQLEnable VARCHAR(MAX) = '';

WITH  cte
        AS ( SELECT SQLDrop = 'IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = Object_ID(N''[' + SCHEMA_NAME(FK.schema_id) + '].[' + FK.name + ']'') AND parent_object_id =OBJECT_ID(N''[' + SCHEMA_NAME(FK.schema_id) + '].[' + OBJECT_NAME(FK.parent_object_id) + ']'') ' + ') 
BEGIN 
    ALTER TABLE [' + SCHEMA_NAME(FK.schema_id) + '].[' + OBJECT_NAME(FK.parent_object_id) + '] DROP CONSTRAINT [' + FK.name + ']' + CHAR(13) + CHAR(10) + 'END' + CHAR(13) + CHAR(10)
                  , SQLAdd = 'ALTER TABLE [' + SCHEMA_NAME(FK.schema_id) + '].[' + OBJECT_NAME(FK.parent_object_id) + '] WITH NOCHECK ADD CONSTRAINT [FK_' + OBJECT_NAME(FK.parent_object_id) + '_' + KeyOnC.name + '_' + SCHEMA_NAME(ReferencedT.schema_id) + ReferencedT.name --+ '_' + ReferencedC.name
                    + '] FOREIGN KEY(' + KeyOnC.name + ') REFERENCES ' + SCHEMA_NAME(ReferencedT.schema_id) + '.' + ReferencedT.name + '(' + ReferencedC.name + ')' 
         --+ ' ON DELETE CASCADE' 
                  , LenConstraintName = LEN('FK_' + OBJECT_NAME(FK.parent_object_id) + '_' + KeyOnC.name + '_' + SCHEMA_NAME(ReferencedT.schema_id) + ReferencedT.name)
                  , SQLEnable = 'ALTER TABLE [' + SCHEMA_NAME(FK.schema_id) + '].[' + OBJECT_NAME(FK.parent_object_id) + '] WITH CHECK CHECK CONSTRAINT [FK_' + OBJECT_NAME(FK.parent_object_id) + '_' + KeyOnC.name + '_' + SCHEMA_NAME(ReferencedT.schema_id) + ReferencedT.name + ']' --+ '_' + ReferencedC.name
                  , NumRank = ROW_NUMBER() OVER ( ORDER BY SCHEMA_NAME(FK.SCHEMA_ID), OBJECT_NAME(FK.Parent_object_id) )
             FROM   sys.foreign_keys AS FK
             INNER JOIN sys.foreign_key_columns AS FKC
                    ON FK.object_id = FKC.constraint_object_id
             INNER JOIN sys.columns AS KeyOnC
                    ON FKC.parent_object_id = KeyOnC.object_id
                       AND FKC.parent_column_id = KeyOnC.column_id
             INNER JOIN sys.columns AS ReferencedC
                    ON FKC.referenced_object_id = ReferencedC.object_id
                       AND FKC.referenced_column_id = ReferencedC.column_id
             INNER JOIN sys.objects AS KeyOnT
                    ON KeyOnC.object_id = KeyOnT.object_id
             INNER JOIN sys.objects AS ReferencedT
                    ON ReferencedC.object_id = ReferencedT.object_id
             WHERE  ( SCHEMA_NAME(KeyOnT.schema_id) = @SchemaName
                      OR @SchemaName IS NULL
                    )
                    AND ( KeyOnT.name LIKE '%' + @TableName + '%'
                          OR ReferencedT.name LIKE '%' + @TableName + '%'
                          OR @TableName IS NULL
                        )
                    AND ( KeyOnC.name = @ColumnName
                          OR ReferencedC.name = @ColumnName
                          OR @ColumnName IS NULL
                        )
                    AND NOT SCHEMA_NAME(KeyOnT.schema_id) = 'ref'
)
SELECT  SQLDrop
      , SQLAdd
      , LenConstraintName
      , SQLEnable
FROM    cte
ORDER BY NumRank;
GO