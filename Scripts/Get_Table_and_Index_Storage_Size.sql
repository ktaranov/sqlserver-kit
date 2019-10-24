/*
<documentation>
  <summary>Count tables and indexes sizes in database.</summary>
  <returns>1 query set with table and index sizes/returns>
  <author>Muhmud</author>
  <created>2019-03-26</created>
  <modified>2019-10-24 by Konstantin Taranov</modified>
  <version>1.2</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Get_Table_and_Index_Storage_Size.sql</sourceLink>
  <originalLink></originalLink>
  <note>If you divide the DataKb and IndexAllKb values by 1024.0, you will get the numbers you see in the SSMS. Takes into account internal tables, such as those used for XML storage.</note>
</documentation>
*/


WITH TablePages AS (
    SELECT s.[object_id]
         , SUM(s.reserved_page_count) AS reserved_pages
         , SUM(s.used_page_count)     AS used_pages
         , SUM(CASE WHEN index_id < 2 THEN in_row_data_page_count + lob_used_page_count + row_overflow_used_page_count
                    ELSE lob_used_page_count + row_overflow_used_page_count
               END)                   AS pages
         , (SELECT COUNT(i.[object_id]) FROM sys.indexes AS i WHERE s.[object_id] = i.[object_id] AND i.[type] <> 0) AS IndexCount
         , SUM(row_count)           AS NumberOfRows
    FROM sys.dm_db_partition_stats AS s
    GROUP BY [object_id]
)
, ExtraData AS (
    SELECT p.[object_id]
         , COUNT(*)                 AS IndexCount
         , SUM(reserved_page_count) AS reserved_pages
         , SUM(used_page_count)     AS used_pages
    FROM sys.dm_db_partition_stats  AS p
    LEFT JOIN sys.internal_tables   AS it ON p.[object_id] = it.[object_id]
    WHERE it.internal_type IN (202, 204, 211, 212, 213, 214, 215, 216)
    GROUP BY p.[object_id]
)
SELECT p.[object_id]
     , OBJECT_SCHEMA_NAME(p.[object_id]) AS ShemaName
     , OBJECT_NAME(p.[object_id])        AS TableName
     , p.NumberOfRows
     , (p.reserved_pages + ISNULL(e.reserved_pages, 0)) * 8 AS ReservedKb
     , p.pages * 8 AS DataKb
     , p.IndexCount
     , CASE WHEN p.IndexCount <> 0 AND p.used_pages + ISNULL(e.used_pages, 0) >= p.pages
            THEN p.used_pages + ISNULL(e.used_pages, 0) - p.pages
            ELSE 0
       END * 8 AS IndexAllKb
     , CASE WHEN p.reserved_pages + ISNULL(e.reserved_pages, 0) > p.used_pages + ISNULL(e.used_pages, 0)
            THEN p.reserved_pages + ISNULL(e.reserved_pages, 0) - p.used_pages + ISNULL(e.used_pages, 0)
            ELSE 0
       END * 8 AS UnusedKb
FROM TablePages     AS p
LEFT JOIN ExtraData AS e ON p.[object_id] = e.[object_id]
WHERE OBJECT_SCHEMA_NAME(p.[object_id]) <> 'sys' AND p.pages > 0
ORDER BY DataKb ASC;
