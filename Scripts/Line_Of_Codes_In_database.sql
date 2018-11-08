/*
Author: Pinal Dave
Source link: https://blog.sqlauthority.com/2015/06/12/sql-server-how-many-line-of-code-do-you-have-in-database/
*/

SELECT DB_NAME(DB_ID()) AS DBName,
       ObjectType,
       COUNT(*)         AS Object_Count,
       SUM(LinesOfCode) AS LinesOfCode
FROM (SELECT s.type AS ObjectType,
             LEN(definition)- LEN(REPLACE(definition,CHAR(10),'')) AS LinesOfCode,
             OBJECT_NAME(a.object_id) AS NameOfObject
             FROM sys.all_sql_modules AS a
             INNER JOIN sysobjects AS s
             ON a.object_id = s.id
             -- AND xtype IN('TR', 'P', 'FN', 'IF', 'TF', 'V')
             WHERE OBJECTPROPERTY(a.object_id,'IsMSShipped') = 0
) SubQuery
GROUP BY ObjectType;
