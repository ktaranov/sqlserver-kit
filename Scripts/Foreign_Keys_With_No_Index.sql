/*
Author: Drupal
Original link: http://sqlworldwide.com/tsql-to-find-status-of-sql-server-statistics/
*/


WITH fk_cte AS (
    SELECT OBJECT_NAME(fk.referenced_object_id) pk_table
         , c2.name pk_column
         , kc.name pk_index_name
         , OBJECT_NAME(fk.parent_object_id) fk_table
         , c.name fk_column
         , fk.name fk_name
         , CASE WHEN i.object_id IS NOT NULL THEN 1 ELSE 0 END does_fk_has_index
         , i.is_primary_key is_fk_a_pk_also
         , i.is_unique is_index_on_fk_unique
         , fk.*
     FROM  sys.foreign_keys AS fk
           INNER JOIN sys.foreign_key_columns fkc ON fkc.constraint_object_id = fk.object_id
           INNER JOIN sys.columns AS c ON c.object_id = fk.parent_object_id AND c.column_id = fkc.parent_column_id
           LEFT JOIN  sys.columns AS c2 ON c2.object_id = fk.referenced_object_id AND c2.column_id = fkc.referenced_column_id
           LEFT JOIN  sys.key_constraints AS kc ON kc.parent_object_id = fk.referenced_object_id AND kc.type = 'PK'
           LEFT JOIN  sys.index_columns AS ic ON ic.object_id = c.object_id AND ic.column_id = c.column_id
           LEFT JOIN  sys.indexes AS i ON i.object_id = ic.object_id AND i.index_id = ic.index_id
   )
SELECT  * FROM    fk_cte
   LEFT JOIN sys.dm_db_partition_stats ps on ps.object_id = fk_cte.parent_object_id and ps.index_id <= 1
WHERE   does_fk_has_index = 0 -- and fk_table = 'LineItems'
ORDER BY used_page_count DESC;
