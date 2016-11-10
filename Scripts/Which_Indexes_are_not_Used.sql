/*
Author: Greg Larsen
Original links: http://www.databasejournal.com/features/mssql/which-indexes-are-not-used.html
*/

SELECT o.name Object_Name,
       SCHEMA_NAME(o.schema_id) Schema_name,
       i.name Index_name,
       i.Type_Desc,
       CASE WHEN (s.user_seeks > 0
               OR s.user_scans > 0
               OR s.user_lookups > 0)
              AND s.user_updates > 0
            THEN 'USED AND UPDATED'
            WHEN (s.user_seeks > 0
               OR s.user_scans > 0
               OR s.user_lookups > 0)
              AND s.user_updates = 0
            THEN 'USED AND NOT UPDATED'
            WHEN  s.user_seeks IS NULL
              AND s.user_scans IS NULL
              AND s.user_lookups IS NULL
              AND s.user_updates IS NULL
            THEN 'NOT USED AND NOT UPDATED'
            WHEN (s.user_seeks = 0
              AND s.user_scans = 0
              AND s.user_lookups = 0)
              AND s.user_updates > 0
            THEN 'NOT USED AND UPDATED'
            ELSE 'NONE OF THE ABOVE'
            END AS Usage_Info,
       COALESCE(s.user_seeks,0) AS user_seeks,
       COALESCE(s.user_scans,0) AS user_scans,
       COALESCE(s.user_lookups,0) AS user_lookups,
       COALESCE(s.user_updates,0) AS user_updates  
 FROM sys.objects AS o
     JOIN sys.indexes AS i
 ON o.object_id = i.object_id
     LEFT OUTER JOIN
  sys.dm_db_index_usage_stats AS s   
 ON i.object_id = s.object_id  
  AND i.index_id = s.index_id
 WHERE o.type = 'U'
 -- Clustered and Non-Clustered indexes
  AND i.type IN (1, 2)
ORDER BY user_seeks, user_scans, user_lookups, user_updates ASC;