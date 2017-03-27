--Get Table and Index storage size in sql server
--Link: http://stackoverflow.com/questions/15896564/get-table-and-index-storage-size-in-sql-server#15896658
/*
Author: marc_s
This query here will list the total size that a table takes up - clustered index, heap and all nonclustered indices
If you want to separate table space from index space, you need to use AND i.index_id IN (0,1) for the table space 
(index_id = 0 is the heap space, index_id = 1 is the size of the clustered index = data pages) and AND i.index_id > 1 for the index-only space
*/

SELECT 
    s.Name AS SchemaName,
    t.NAME AS TableName,
    p.rows AS RowCounts,
    SUM(a.total_pages) * 8 AS TotalSpaceKB, 
    SUM(a.used_pages) * 8 AS UsedSpaceKB, 
    (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS UnusedSpaceKB
FROM 
    sys.tables t
INNER JOIN 
    sys.schemas s ON s.schema_id = t.schema_id
INNER JOIN      
    sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN 
    sys.allocation_units a ON p.partition_id = a.container_id
WHERE 
    t.NAME NOT LIKE 'dt%'    -- filter out system tables for diagramming
    AND t.is_ms_shipped = 0
    AND i.OBJECT_ID > 255 
GROUP BY 
    t.Name, s.Name, p.Rows
ORDER BY 
    s.Name, t.Name
 
----------------------------- 
/*
Author: Muhmud
Takes into account internal tables, such as those used for XML storage.
Edit: If you divide the data_kb and index_kb values by 1024.0, you will get the numbers you see in the GUI.
*/
    
    with pages as (
    SELECT object_id, SUM (reserved_page_count) as reserved_pages, SUM (used_page_count) as used_pages,
            SUM (case 
                    when (index_id < 2) then (in_row_data_page_count + lob_used_page_count + row_overflow_used_page_count)
                    else lob_used_page_count + row_overflow_used_page_count
                 end) as pages
    FROM sys.dm_db_partition_stats
    group by object_id
), extra as (
    SELECT p.object_id, sum(reserved_page_count) as reserved_pages, sum(used_page_count) as used_pages
    FROM sys.dm_db_partition_stats p, sys.internal_tables it
    WHERE it.internal_type IN (202,204,211,212,213,214,215,216) AND p.object_id = it.object_id
    group by p.object_id
)
SELECT object_schema_name(p.object_id) + '.' + object_name(p.object_id) as TableName, (p.reserved_pages + isnull(e.reserved_pages, 0)) * 8 as reserved_kb,
        pages * 8 as data_kb,
        (CASE WHEN p.used_pages + isnull(e.used_pages, 0) > pages THEN (p.used_pages + isnull(e.used_pages, 0) - pages) ELSE 0 END) * 8 as index_kb,
        (CASE WHEN p.reserved_pages + isnull(e.reserved_pages, 0) > p.used_pages + isnull(e.used_pages, 0) THEN (p.reserved_pages + isnull(e.reserved_pages, 0) - p.used_pages + isnull(e.used_pages, 0)) else 0 end) * 8 as unused_kb
from pages p
left outer join extra e on p.object_id = e.object_id
    