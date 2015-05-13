-- source: http://www.brentozar.com/archive/2014/02/count-number-rows-table-sql-server/
DECLARE @TableName sysname
SET @TableName = 'bigTransactionHistory'

SELECT TBL.object_id, TBL.name, SUM(PART.rows) AS rows
FROM sys.tables TBL
INNER JOIN sys.partitions PART ON TBL.object_id = PART.object_id
INNER JOIN sys.indexes IDX ON PART.object_id = IDX.object_id
AND PART.index_id = IDX.index_id
WHERE TBL.name = @TableName
AND IDX.index_id < 2
GROUP BY TBL.object_id, TBL.name;


DECLARE @TableName sysname
SET @TableName = 'bigTransactionHistory'

SELECT OBJECT_NAME(object_id), SUM(row_count) AS rows
FROM sys.dm_db_partition_stats
WHERE object_id = OBJECT_ID(@TableName)
AND index_id < 2
GROUP BY OBJECT_NAME(object_id);