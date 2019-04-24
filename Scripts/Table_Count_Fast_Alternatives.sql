-- source: http://www.brentozar.com/archive/2014/02/count-number-rows-table-sql-server/
DECLARE @TableName sysname = N'bigTransactionHistory';

SELECT TBL.object_id
     , TBL.name
     , SUM(PART.rows) AS NumberOfRows
FROM sys.tables           AS TBL
INNER JOIN sys.partitions AS PART ON TBL.object_id = PART.object_id
INNER JOIN sys.indexes    AS IDX ON PART.object_id = IDX.object_id
AND PART.index_id = IDX.index_id
WHERE TBL.name = @TableName
AND IDX.index_id < 2
GROUP BY TBL.object_id, TBL.name;


DECLARE @tableName sysname = N'bigTransactionHistory';

SELECT object_id
     , SCHEMA_NAME(object_id) AS SchemaName
     , OBJECT_NAME(object_id) AS TableName
     , SUM(row_count)         AS NumberOfRows
 FROM sys.dm_db_partition_stats
 WHERE object_id = OBJECT_ID(@tableName) AND index_id < 2
 GROUP BY object_id
        , SCHEMA_NAME(object_id)
        , OBJECT_NAME(object_id);
