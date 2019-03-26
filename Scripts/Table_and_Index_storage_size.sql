/*
Created by: Muhmud
Modified: 2019-03-26 by Konstantin Taranov
Source link: https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Table_and_Index_storage_size.sql
Note: Takes into account internal tables, such as those used for XML storage.
If you divide the data_kb and index_kb values by 1024.0, you will get the numbers you see in the GUI.
*/
WITH TablePages AS (
    SELECT [object_id]
         , SUM(reserved_page_count) as reserved_pages
         , SUM(used_page_count) as used_pages,
            SUM(CASE WHEN index_id < 2 THEN in_row_data_page_count + lob_used_page_count + row_overflow_used_page_count
                      ELSE lob_used_page_count + row_overflow_used_page_count
                 END) AS pages
    FROM sys.dm_db_partition_stats
    GROUP BY [object_id]
)
, ExtraData as (
    SELECT p.[object_id]
         , SUM(reserved_page_count) AS reserved_pages
         , SUM(used_page_count) as used_pages
    FROM sys.dm_db_partition_stats p, sys.internal_tables it
    WHERE it.internal_type IN (202,204,211,212,213,214,215,216) AND p.[object_id] = it.[object_id]
    group by p.[object_id]
)
SELECT OBJECT_SCHEMA_NAME(p.[object_id]) AS ShemaName
     , OBJECT_NAME(p.[object_id])        AS TableName
     , (p.reserved_pages + ISNULL(e.reserved_pages, 0)) * 8 AS ReservedKb
     , p.pages * 8 AS DataKb
     , (CASE WHEN p.used_pages + ISNULL(e.used_pages, 0) > pages
             THEN p.used_pages + ISNULL(e.used_pages, 0) - pages
             ELSE 0
        END) * 8 AS IndexAllKb
     , (CASE WHEN p.reserved_pages + ISNULL(e.reserved_pages, 0) > p.used_pages + ISNULL(e.used_pages, 0)
             THEN p.reserved_pages + ISNULL(e.reserved_pages, 0) - p.used_pages + ISNULL(e.used_pages, 0)
             ELSE 0
        END) * 8 AS UnusedKb
FROM TablePages AS p
LEFT JOIN ExtraData AS e ON p.[object_id] = e.[object_id];
                                  
