/*
<documentation>
  <summary>Get memory for all objects in all databases</summary>
  <returns>Temp table #obd with memory consumption by objects</returns>
  <author>Max Vernon</author>
  <created>2019-08-02</created>
  <modified>2019-09-19 by Konstantin Taranov</modified>
  <version>1.0</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Memory_Consumption_By_Object.sql</sourceLink>
  <originalLink>https://www.sqlserverscience.com/performance/memory-consumption-by-object/</originalLink>
</documentation>
*/


IF OBJECT_ID(N'tempdb..#obd', N'U') IS NOT NULL
BEGIN
    DROP TABLE #obd;
END
CREATE TABLE #obd
(
      database_id         int          NULL
    , file_id             int          NULL
    , page_id             int          NULL
    , page_level          int          NULL
    , allocation_unit_id  bigint       NULL
    , page_type           nvarchar(60) NULL
    , row_count           int          NULL
    , free_space_in_bytes int          NULL
    , is_modified         bit          NULL
    , numa_node           int          NULL
    , read_microsec       bigint       NULL
);


INSERT INTO #obd
(
      database_id        
    , file_id            
    , page_id            
    , page_level         
    , allocation_unit_id 
    , page_type          
    , row_count          
    , free_space_in_bytes
    , is_modified        
    , numa_node          
    , read_microsec      
)
SELECT 
      obd.database_id        
    , obd.file_id            
    , obd.page_id            
    , obd.page_level         
    , obd.allocation_unit_id 
    , obd.page_type          
    , obd.row_count          
    , obd.free_space_in_bytes
    , obd.is_modified        
    , obd.numa_node          
    , obd.read_microsec      
FROM sys.dm_os_buffer_descriptors obd;

SELECT DatabaseName = d.name
    , obd.page_type
    , MB_in_memory = (COUNT(1) * 8192 / 1048576.0)
FROM #obd obd
    INNER JOIN sys.databases d ON obd.database_id = d.database_id
WHERE d.state_desc = N'ONLINE'
GROUP BY d.name
    , obd.page_type
ORDER BY d.name
    , obd.page_type;


IF OBJECT_ID(N'tempdb..#allocunits', N'U') IS NOT NULL
BEGIN
    DROP TABLE #allocunits;
END
CREATE TABLE #allocunits
(
      allocation_unit_id bigint        NOT NULL
    , ObjectName         nvarchar(128) NOT NULL
    , database_id        smallint      NULL
);

DECLARE @cmd nvarchar(max);
SET @cmd = N'';
DECLARE @serverCollation nvarchar(200) = CAST(SERVERPROPERTY('Collation') AS nvarchar(100));

SELECT @cmd = @cmd + CASE WHEN @cmd = N'' THEN N'' ELSE N'
UNION ALL
' END + N'SELECT au.allocation_unit_id
    , ObjectName = o.name
    , database_id = ' + CONVERT(nvarchar(10), d.database_id) + N'
FROM ' + QUOTENAME(d.name) + N'.sys.allocation_units au
    INNER JOIN ' + QUOTENAME(d.name) + N'.sys.partitions p ON ((au.type = 1 OR au.type = 3) AND (au.container_id = p.hobt_id))
        OR (au.type = 2 AND au.container_id = p.partition_id)
    INNER JOIN ' + QUOTENAME(d.name) + N'.sys.objects o ON p.object_id = o.object_id
WHERE o.is_ms_shipped = 0'   
FROM sys.databases d
WHERE d.state_desc = N'ONLINE';

PRINT(@cmd);

INSERT INTO #allocunits (allocation_unit_id, ObjectName, database_id)
EXEC sys.sp_executesql @cmd;


SELECT DatabaseName = d.name
    , ObjectName = au.ObjectName
    , obd.page_type
    , MB_in_memory = (COUNT_BIG(1) * 8192 / 1048576.0)
FROM #obd obd
    INNER JOIN sys.databases d ON obd.database_id = d.database_id
    INNER JOIN #allocunits au ON obd.database_id = au.database_id 
        AND obd.allocation_unit_id = au.allocation_unit_id
GROUP BY d.name
    , au.ObjectName
    , obd.page_type
ORDER BY (COUNT_BIG(1)) DESC
    , d.name
    , au.ObjectName
    , obd.page_type;
