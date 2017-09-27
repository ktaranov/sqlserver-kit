/*
Author: Svetlana Golovko
Source link: https://www.mssqltips.com/sqlservertip/4876/finding-sql-server-object-dependencies-for-synonyms/
*/

SET NOCOUNT ON;

-- check if a database has synonyms to the objects in another database
IF EXISTS (SELECT base_object_name 
  FROM sys.synonyms
  WHERE base_object_name LIKE '%.%.%'
   AND     LEFT (REPLACE(REPLACE(base_object_name ,'[',''),']',''),
     CHARINDEX('.', REPLACE(REPLACE(base_object_name ,'[',''),']',''))-1) <> DB_NAME()
    )
BEGIN

 DECLARE @sql  NVARCHAR(MAX), 
 @syn_name  NVARCHAR(255), 
 @db  NVARCHAR(255), 
 @dbid  NVARCHAR(20),
 @objname  NVARCHAR(255)

 CREATE TABLE #tempTbl  ( syn_name   NVARCHAR(255),  
   syn_base_object  NVARCHAR(255), 
   syn_base_object_db  NVARCHAR(255),  
   nest_level  SMALLINT
       );

 DECLARE SYN_DB CURSOR FOR  

 -- get list of synonyms to the objects in another database
 SELECT DISTINCT [name] AS SYN_NAME,
  LEFT (REPLACE(REPLACE(base_object_name ,'[',''),']',''),
    CHARINDEX('.', REPLACE(REPLACE(base_object_name ,'[',''),']',''))-1) AS DBNM,
  DB_ID(LEFT (REPLACE(REPLACE(base_object_name ,'[',''),']',''),
    CHARINDEX('.', REPLACE(REPLACE(base_object_name ,'[',''),']',''))-1)) AS DBID,
  RIGHT (REPLACE(REPLACE(base_object_name ,'[',''),']',''),
    CHARINDEX('.', reverse(REPLACE(REPLACE(base_object_name ,'[',''),']','')))-1) AS objectname
FROM sys.synonyms
WHERE base_object_name LIKE '%.%.%'
  AND    LEFT (REPLACE(REPLACE(base_object_name ,'[',''),']',''),
   CHARINDEX('.', REPLACE(REPLACE(base_object_name ,'[',''),']',''))-1)  <> DB_NAME()

 OPEN SYN_DB;  
  
 FETCH NEXT FROM SYN_DB 
 INTO @syn_name, @db, @dbid, @objname;

 WHILE @@FETCH_STATUS = 0
 BEGIN  

 SET @sql = '
  WITH DepTree 
  AS 
 (
  SELECT ''' + @db + ''' AS DBNAME,  
   o.[name], 
   o.[object_id] AS referenced_id , 
   o.[name] AS referenced_name, 
   o.[object_id] AS referencing_id, 
   o.[name] AS referencing_name,  
   0 AS NestLevel
    FROM  [' + @db + '].sys.objects o 
  WHERE o.is_ms_shipped = 0 

  UNION ALL
    
  SELECT ''' + @db + ''' AS DBNAME, 
   r.[name], 
   d1.referenced_id,  
   OBJECT_NAME( d1.referenced_id,' + @dbid + ') , 
   d1.referencing_id, 
   OBJECT_NAME( d1.referencing_id,' + @dbid + ') , 
   NestLevel + 1
  FROM  [' + @db + '].sys.sql_expression_dependencies d1  JOIN DepTree r 
   ON d1.referenced_id =  r.referencing_id
 )

  INSERT INTO #tempTbl
   SELECT ''' + @syn_name + ''' AS syn_name, 
   ''' + @objname + ''' AS syn_base_object, 
   ''' + @db + ''' AS syn_base_object_db,  
   MAX(NestLevel) AS nest_level
   FROM DepTree 
   WHERE referencing_name = ''' + @objname + '''
   GROUP BY  referenced_name, DBNAME, referencing_name
   ORDER BY MAX(NestLevel) DESC'

  EXECUTE  (@sql);

   FETCH NEXT FROM SYN_DB
   INTO @syn_name, @db, @dbid, @objname;
 END

 CLOSE SYN_DB;
 DEALLOCATE SYN_DB;

END;

SELECT syn_name
     , syn_base_object
     , syn_base_object_db
     , MAX(nest_level) AS nest_level
FROM #tempTbl
GROUP BY syn_name, syn_base_object, syn_base_object_db
-- comment out next line if you want to see all synonyms' dependent objects regardless the nest level
HAVING MAX(nest_level) > 2;

DROP TABLE #tempTbl;

GO
