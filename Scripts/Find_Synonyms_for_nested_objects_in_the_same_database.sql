/*
Author: Svetlana Golovko
Source link: https://www.mssqltips.com/sqlservertip/4876/finding-sql-server-object-dependencies-for-synonyms/
*/

DECLARE @schema SYSNAME;

-- find default user's schema for the one-part base objects names (no schema name)
SELECT @schema = default_schema_name
  FROM sys.database_principals
 WHERE name = user_name();

-- find all views with their dependencies
WITH DepTree 
 AS 
(
   SELECT o.[name], 
 s.[name]  AS oSchema, 
 o.[object_id] AS referenced_id , 
 o.[name] AS referenced_name, 
 o.[object_id] AS referencing_id, 
 o.[name] AS referencing_name,  
 0 AS NestLevel
  FROM  sys.objects o JOIN sys.schemas s 
 ON o.[schema_id] = s.[schema_id]
  WHERE o.is_ms_shipped = 0
  -- comment out next line if you need to check all object types, not only views 
 AND o.[type] = 'V' 
 
  UNION ALL
    
  SELECT r.[name], 
 r.oSchema, 
 d1.referenced_id,  
 OBJECT_NAME( d1.referenced_id) , 
 d1.referencing_id, 
 OBJECT_NAME( d1.referencing_id) , 
 NestLevel + 1
  FROM  sys.sql_expression_dependencies d1 JOIN DepTree r 
 ON d1.referenced_id =  r.referencing_id
)
,
-- find all synonyms in CURRENT database
Syn
 AS
(
    SELECT [name], 
 base_object_name,
 LTRIM(RTRIM( REPLACE(REPLACE(REPLACE(REPLACE(base_object_name ,'[',''),']',''), DB_NAME()+'..',''), DB_NAME()+'.',''))) as objectname
    FROM sys.synonyms s
    WHERE (base_object_name like '%.%.%'
  AND  LEFT (REPLACE(REPLACE(base_object_name ,'[',''),']',''), 
   CHARINDEX('.', REPLACE(REPLACE(base_object_name ,'[',''),']',''))-1)  = DB_NAME())
 OR base_object_name NOT LIKE '%.%.%' 
)

SELECT s.[name] AS syn_name, 
 base_object_name AS syn_base_object, 
 MAX(NestLevel) AS nest_level
FROM DepTree t JOIN Syn s
 ON oSchema + '.' + t.referencing_name  = 
   CASE WHEN s.objectname NOT LIKE '%.%' THEN @schema + '.' + s.objectname 
    ELSE s.objectname END
GROUP BY base_object_name, s.[name]
-- comment out next line if you want to see all synonyms' dependent objects regardless nest level
HAVING MAX(NestLevel) > 2 
ORDER BY MAX(NestLevel) DESC;
GO
