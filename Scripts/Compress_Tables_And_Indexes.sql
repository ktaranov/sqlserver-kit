/*
<documentation>
  <summary>Compress tables and indexes</summary>
  <returns>Temp table #estimated_results and print or exec rebuild index commands</returns>
  <author>Max Vernon</author>
  <created>2019-08-08</created>
  <modified>2019-09-12 by Konstantin Taranov</modified>
  <version>1.1</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Compress_Tables.sql</sourceLink>
  <originalLink>https://www.sqlserverscience.com/performance/compress-big-tables/</originalLink>
</documentation>
*/


/*
    Compresses tables and indexes that are consuming more than the specified amount of space.

    By:     Max Vernon, 2019-08-08

    Set the following variables before running the script!
        - @DebugOnly  - 1 will cause the script to print out the generated commands, 0 will also execute those commands
        - @OnlineOnly - 1 causes the script to use ONLINE=ON when performing the compress operation
        - @CompressionType - can be "PAGE" or "ROW"
        - @MinObjectSizeGB - the minimum current size of a table/index before it will be considered for compression
        - @MinCompressionRatio - the minimum estimated compression ratio before a table/index will be compressed,
                                 a lower number indicates a higher level of compression:
                                    0.25 - the data must compress to 1/4 its uncompressed size
                                    0.5  - the data must compress to half its uncompressed size
                                    0.1  - the data must compress to 1/10th its uncompressed size
                                    1.0  - no compression
    Notes:
        - Only Heaps, Clustered Indexes, and Non-Clustered Indexes are affected by this script.
*/

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET NOCOUNT ON;

DECLARE @DebugOnly              bit = 1; --set to zero to actually compress tables
DECLARE @MinObjectSizeGB        decimal(38,2) = 0.01;
DECLARE @OnlineOnly             bit = 1;
DECLARE @CompressionType        nvarchar(60) = N'PAGE'; --can be PAGE or ROW
DECLARE @MinCompressionRatio    decimal(38,2) = 10;

DECLARE @SchemaName             sysname;
DECLARE @ObjectName             sysname;
DECLARE @IndexID                int;
DECLARE @PartitionNumber        int;
DECLARE @MaxDOP                 int;
DECLARE @msg                    nvarchar(1000);
DECLARE @cmd                    nvarchar(max);

SET @MaxDOP = ( --set our MaxDOP to half of the configured value, or 1 if the sysadmin
                --hasn't explicity configured the value
    SELECT COALESCE(CONVERT(int, c.value), 2)
    FROM sys.configurations c
    WHERE c.name = N'max degree of parallelism'
    ) / 2;

IF OBJECT_ID(N'tempdb..#estimated_results', N'U') IS NOT NULL
DROP TABLE #estimated_results;
CREATE TABLE #estimated_results
(
      [schema_name]                                         sysname NULL
    , [object_name]                                         sysname NULL
    , [index_id]                                            int     NULL
    , [partition_number]                                    int     NULL
    , [size_with_current_compression_setting(KB)]           bigint  NULL
    , [size_with_requested_compression_setting(KB)]         bigint  NULL
    , [sample_size_with_current_compression_setting(KB)]    bigint  NULL
    , [sample_size_with_requested_compression_setting(KB)]  bigint  NULL
);

DECLARE cur CURSOR LOCAL FORWARD_ONLY STATIC READ_ONLY
FOR
SELECT SchemaName = s.name
    , ObjectName = o.name
    , i.index_id
    , p.partition_number
FROM sys.schemas s
    INNER JOIN sys.objects o ON s.schema_id = o.schema_id
    INNER JOIN sys.indexes i ON o.object_id = i.object_id
    INNER JOIN sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id
    INNER JOIN (
        SELECT v.index_type
        FROM (VALUES
              (0) --heap
            , (1) --clustered index
            , (2) --non-clustered index
            )v(index_type)
        ) index_types ON i.type = index_types.index_type
WHERE i.is_hypothetical = 0
    AND s.name <> N'sys'
    AND o.is_ms_shipped = 0
    AND p.data_compression_desc <> @CompressionType
    AND (
            (
                @OnlineOnly = 1
                AND NOT EXISTS (
                    SELECT 1
                    FROM sys.columns c
                        INNER JOIN sys.types ty ON c.system_type_id = ty.system_type_id
                    WHERE c.object_id = o.object_id
                        AND (
                                   ty.name = N'ntext' --none of these column types can be compressed online
                                OR ty.name = N'text'
                                OR ty.name = N'image'
                            )
                        )
                AND p.filestream_filegroup_id = 0 --no filestream table can be compressed online
            )
            OR @OnlineOnly = 0
        )
    AND NOT EXISTS (
        --tables with sparse columns cannot be compressed.
        --https://docs.microsoft.com/en-us/sql/relational-databases/data-compression/data-compression?view=sql-server-2017#how-compression-affects-other-sql-server-components
        SELECT 1
        FROM sys.columns c
        WHERE c.object_id = o.object_id
            AND c.is_sparse = 1
        )
ORDER BY s.name
    , o.name
    , i.index_id
    , p.partition_number;

OPEN cur;
FETCH NEXT FROM cur INTO @SchemaName, @ObjectName, @IndexID, @PartitionNumber;
WHILE @@FETCH_STATUS = 0
BEGIN
    SET @msg = N'EXEC sys.sp_estimate_data_compression_savings @schema_name = N''' + @SchemaName + N'''
        , @object_name = N''' + @ObjectName + N'''
        , @index_id = ' + CONVERT(nvarchar(1000), @IndexID) + N'
        , @partition_number = ' + CONVERT(nvarchar(1000), @PartitionNumber) + N'
        , @data_compression = ' + @CompressionType + N';';
    --RAISERROR (@msg, 0, 1) WITH NOWAIT;

    INSERT INTO #estimated_results (
          object_name
        , schema_name
        , index_id
        , partition_number
        , [size_with_current_compression_setting(KB)]
        , [size_with_requested_compression_setting(KB)]
        , [sample_size_with_current_compression_setting(KB)]
        , [sample_size_with_requested_compression_setting(KB)]
        )
    EXEC sys.sp_estimate_data_compression_savings @schema_name = @SchemaName
        , @object_name = @ObjectName
        , @index_id = @IndexID
        , @partition_number = @PartitionNumber
        , @data_compression = @CompressionType;
    FETCH NEXT FROM cur INTO @SchemaName, @ObjectName, @IndexID, @PartitionNumber;
END
CLOSE cur;
DEALLOCATE cur;

DECLARE cur CURSOR LOCAL FORWARD_ONLY STATIC READ_ONLY
FOR
SELECT CASE WHEN er.index_id = 0 THEN
    N'ALTER TABLE ' + QUOTENAME(er.schema_name) + N'.' + QUOTENAME(er.object_name) + N'
REBUILD WITH (
      DATA_COMPRESSION = ' + @CompressionType + N'
    , ONLINE = ' + CASE WHEN @OnlineOnly = 1 THEN N'ON' ELSE N'OFF' END + N'
    , SORT_IN_TEMPDB = OFF
    , MAXDOP = ' + CONVERT(nvarchar(10), @MaxDOP) + N'
    );
'
ELSE
    N'ALTER INDEX ' + QUOTENAME(i.name) + N' ON ' + QUOTENAME(er.schema_name) + N'.' + QUOTENAME(er.object_name) + N'
REBUILD WITH (
      DATA_COMPRESSION = ' + @CompressionType + N'
    , ONLINE = ' + CASE WHEN @OnlineOnly = 1 THEN N'ON' ELSE N'OFF' END + N'
    , SORT_IN_TEMPDB = OFF
    , MAXDOP = ' + CONVERT(nvarchar(10), @MaxDOP) + N'
    );
'
END
FROM #estimated_results er
    LEFT JOIN sys.schemas s ON er.schema_name = s.name
    LEFT JOIN sys.objects o ON s.schema_id = o.schema_id AND er.object_name = o.name
    LEFT JOIN sys.indexes i ON o.object_id = i.object_id AND er.index_id = i.index_id
WHERE er.[size_with_current_compression_setting(KB)] >= (@MinObjectSizeGB * 1048576) --sizes are reported in KB
    AND (CONVERT(decimal(38, 2), er.[size_with_requested_compression_setting(KB)]) / er.[size_with_current_compression_setting(KB)]) <= @MinCompressionRatio
OPEN cur;
FETCH NEXT FROM cur INTO @cmd;
WHILE @@FETCH_STATUS = 0
BEGIN
    if @DebugOnly = 0
    BEGIN
        BEGIN TRANSACTION
        RAISERROR (@cmd, 0, 1) WITH NOWAIT;
        EXEC sys.sp_executesql @cmd;
        COMMIT TRANSACTION
        CHECKPOINT
    END
    ELSE
    BEGIN
        RAISERROR (@cmd, 0, 1) WITH NOWAIT;
    END
    FETCH NEXT FROM cur INTO @cmd;
END
CLOSE cur;
DEALLOCATE cur;

SELECT * FROM  #estimated_results;
