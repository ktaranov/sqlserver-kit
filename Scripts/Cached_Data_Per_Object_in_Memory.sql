/*
<documentation>
  <summary>List Cached Data Per Object in Memory</summary>
  <returns>1 data set: list Cached Data Per Object in Memory.</returns>
  <issues>No</issues>
  <author>Pinal Dave</author>
  <created>2021-03-31</created>
  <modified>2021-03-31 by Konstantin Taranov</modified>
  <version>1.0</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Cached_Data_Per_Object_in_Memory.sql</sourceLink>
  <originalLink>https://blog.sqlauthority.com/2021/03/31/sql-server-cached-data-per-object-in-memory/</originalLink>
</documentation>
*/

SELECT COUNT (1) * 8 / 1024 AS MBUsed, 
    OBJECT_SCHEMA_NAME(object_id) SchemaName, 
    name AS TableName, index_id   
FROM sys.dm_os_buffer_descriptors AS bd   
    INNER JOIN  
    (  
        SELECT object_name(object_id) AS name  
            ,index_id ,allocation_unit_id, object_id  
        FROM sys.allocation_units AS au  
            INNER JOIN sys.partitions AS p   
                ON au.container_id = p.hobt_id   
                    AND (au.type = 1 OR au.type = 3)  
        UNION ALL 
        SELECT object_name(object_id) AS name    
            ,index_id, allocation_unit_id, object_id  
        FROM sys.allocation_units AS au  
            INNER JOIN sys.partitions AS p   
                ON au.container_id = p.partition_id   
                    AND au.type = 2  
    ) AS obj   
        ON bd.allocation_unit_id = obj.allocation_unit_id  
WHERE database_id = DB_ID()  
GROUP BY OBJECT_SCHEMA_NAME(object_id), name, index_id   
ORDER BY COUNT (*) * 8 / 1024 DESC;
GO
