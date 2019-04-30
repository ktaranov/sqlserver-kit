/*
Author: Konstantin Taranov
Source: https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Table_Parameters.sql
*/


DECLARE @databaseName SYSNAME = N'AdventureWorks2017';
DECLARE @schemaName   SYSNAME = N'Person';
DECLARE @tableName    SYSNAME = N'CountryRegion';
DECLARE @_msparam_0   INT     = 2;
DECLARE @TROW50000    NVARCHAR(1000) = N'Table ' + @schemaName + '.' + @tableName+ N' is not exists in database ' + QUOTENAME(@databaseName) + N'!!!';

IF OBJECT_ID(CASE WHEN @databaseName <> '' THEN QUOTENAME(@databaseName) + '.' ELSE '' END + QUOTENAME(@schemaName) + '.' + QUOTENAME(@tableName)) IS NULL
THROW 50000, @TROW50000, 1;

IF LEFT(@databaseName, 1) = N'[' OR
   LEFT(@tableName, 1)    = N'[' OR
   LEFT(@schemaName, 1)   = N'['
THROW 50001, 'Please do not use square quotes in Database, Table or Schema names! In the code it is alredy done with QUOTENAME function.', 1;


IF OBJECT_ID('tempdb..#tmp_extended_remote_data_archive_tables', 'U') IS NOT NULL DROP TABLE #tmp_extended_remote_data_archive_tables;
CREATE TABLE #tmp_extended_remote_data_archive_tables(
      object_id         INT NOT NULL
    , remote_table_name NVARCHAR(128) NULL
    , filter_predicate  NVARCHAR(max) NULL
    , migration_state   TINYINT NULL
  );

DECLARE @productMajorVersion INT = CAST(SERVERPROPERTY('ProductMajorVersion') AS INT);
IF @productMajorVersion > 12
BEGIN
    IF EXISTS(SELECT 1 FROM master.sys.syscolumns WHERE [name] = N'remote_data_archive_migration_state' AND [id]= Object_ID(N'sys.tables'))
      EXECUTE(N'
        INSERT INTO #tmp_extended_remote_data_archive_tables
        SELECT rdat.object_id, rdat.remote_table_name,
        SUBSTRING(rdat.filter_predicate, 2, LEN(rdat.filter_predicate) - 2) AS filter_predicate,
        CASE WHEN tbl.remote_data_archive_migration_state_desc = N''PAUSED''   THEN 1
             WHEN tbl.remote_data_archive_migration_state_desc = N''OUTBOUND'' THEN 3
             WHEN tbl.remote_data_archive_migration_state_desc = N''INBOUND''  THEN 4
             WHEN tbl.remote_data_archive_migration_state_desc = N''DISABLED'' THEN 0
             ELSE 0
        END AS migration_state
        FROM sys.tables tbl LEFT JOIN sys.remote_data_archive_tables rdat ON rdat.object_id = tbl.object_id
        WHERE rdat.object_id IS NOT NULL;
        ')
    ELSE
      EXECUTE(N'
        INSERT INTO #tmp_extended_remote_data_archive_tables
        SELECT rdat.object_id, rdat.remote_table_name, 
        SUBSTRING(rdat.filter_predicate, 2, LEN(rdat.filter_predicate) - 2) AS filter_predicate,
        CASE WHEN rdat.is_migration_paused = 1 AND rdat.migration_direction_desc = N''OUTBOUND'' THEN 1
             WHEN rdat.is_migration_paused = 1 AND rdat.migration_direction_desc = N''INBOUND''  THEN 2
             WHEN rdat.is_migration_paused = 0 AND rdat.migration_direction_desc = N''OUTBOUND'' THEN 3
             WHEN rdat.is_migration_paused = 0 AND rdat.migration_direction_desc = N''INBOUND''  THEN 4
             ELSE 0
        END AS migration_state
        FROM sys.tables tbl LEFT JOIN sys.remote_data_archive_tables rdat ON rdat.object_id = tbl.object_id
        WHERE rdat.object_id IS NOT NULL
        ');
END;

SELECT tbl.name AS [Name]
       ,SCHEMA_NAME(tbl.schema_id) AS [Schema]
       ,tbl.object_id
       ,tbl.create_date AS [CreateDate]
       ,tbl.modify_date AS [DateLastModified]
       ,ISNULL(stbl.name, N'') AS [Owner]
       ,CAST(CASE WHEN tbl.principal_id IS NULL THEN 1 ELSE 0 END AS BIT) AS [IsSchemaOwned]
       ,CAST(CASE
               WHEN tbl.is_ms_shipped = 1 THEN 1
               WHEN (SELECT major_id
                     FROM   sys.extended_properties
                     WHERE  major_id = tbl.object_id
                            AND minor_id = 0
                            AND class = 1
                            AND name = N'microsoft_database_tools_support') IS
                    NOT NULL
               THEN 1
               ELSE 0
             END AS BIT) AS [IsSystemObject]
       ,CAST(Objectproperty(tbl.object_id, N'HasAfterTrigger')            AS BIT) AS [HasAfterTrigger]
       ,CAST(Objectproperty(tbl.object_id, N'HasInsertTrigger')           AS BIT) AS [HasInsertTrigger]
       ,CAST(Objectproperty(tbl.object_id, N'HasDeleteTrigger')           AS BIT) AS [HasDeleteTrigger]
       ,CAST(Objectproperty(tbl.object_id, N'HasInsteadOfTrigger')        AS BIT) AS [HasInsteadOfTrigger]
       ,CAST(Objectproperty(tbl.object_id, N'HasUpdateTrigger')           AS BIT) AS [HasUpdateTrigger]
       ,CAST(Objectproperty(tbl.object_id, N'IsIndexed')                  AS BIT) AS [HasIndex]
       ,CAST(Objectproperty(tbl.object_id, N'IsIndexable')                AS BIT) AS [IsIndexable]
       ,CAST(CASE idx.index_id WHEN 1 THEN 1 ELSE 0 END                   AS BIT) AS [HasClusteredIndex]
       ,CAST(CASE idx.type     WHEN 0 THEN 1 ELSE 0 END                   AS BIT) AS [HasHeapIndex]
       ,tbl.uses_ansi_nulls                                                       AS [AnsiNullsStatus]
       ,CAST(ISNULL(Objectproperty(tbl.object_id, N'IsQuotedIdentOn'), 0) AS BIT) AS [QuotedIdentifierStatus]
       ,CAST(0 AS BIT) AS [FakeSystemTable]
       ,ISNULL(dstext.name, N'') AS [TextFileGroup]
       ,CAST(tbl.is_memory_optimized AS BIT) AS [IsMemoryOptimized]
       ,CASE WHEN ( tbl.durability = 1 ) THEN 0 ELSE 1 END AS [Durability]
       ,tbl.is_replicated AS [Replicated]
       ,tbl.lock_escalation AS [LockEscalation]
       ,CAST(CASE
               WHEN ctt.object_id IS NULL THEN 0
               ELSE 1
             END AS BIT)
        AS [ChangeTrackingEnabled]
       ,CAST(ISNULL(ctt.is_track_columns_updated_on, 0) AS BIT) AS [TrackColumnsUpdatedEnabled]
       ,tbl.is_filetable AS [IsFileTable]
       ,ISNULL(ft.directory_name, N'') AS [FileTableDirectoryName]
       ,ISNULL(ft.filename_collation_name, N'')
        AS [FileTableNameColumnCollation]
       ,CAST(ISNULL(ft.is_enabled, 0) AS BIT)
        AS [FileTableNamespaceEnabled]
       ,CASE
          WHEN 'PS' = dsidx.type THEN dsidx.name
          ELSE N''
        END
        AS [PartitionScheme]
       ,CAST(CASE
               WHEN 'PS' = dsidx.type THEN 1
               ELSE 0
             END AS BIT)
        AS [IsPartitioned]
       ,CASE
          WHEN 'FD' = dstbl.type THEN dstbl.name
          ELSE N''
        END
        AS [FileStreamFileGroup]
       ,CASE
          WHEN 'PS' = dstbl.type THEN dstbl.name
          ELSE N''
        END
        AS [FileStreamPartitionScheme]
       ,CAST(CASE idx.type 
               WHEN 5 THEN 1
               ELSE 0
             END AS BIT)
        AS [HasClusteredColumnStoreIndex]
       --,CAST(CASE tbl.temporal_type
       --        WHEN 2 THEN 1
       --        ELSE 0
       --      END AS BIT)
        --AS [IsSystemVersioned]
       --,CAST(ISNULL(historyTable.name, N'') AS SYSNAME) AS [HistoryTableName]
       --,CAST(ISNULL(SCHEMA_NAME(historyTable.schema_id), N'') AS SYSNAME) AS [HistoryTableSchema]
       --,CAST(ISNULL(historyTable.object_id, 0) AS INT) AS [HistoryTableID]
       --,CAST(CASE WHEN periods.start_column_id IS NULL THEN 0
       --           ELSE 1
       --      END AS BIT) AS [HasSystemTimePeriod]
       --,CAST(ISNULL((SELECT cols.NAME
       --              FROM   sys.columns cols
       --              WHERE  periods.object_id = tbl.object_id
       --                     AND cols.object_id = tbl.object_id
       --                     AND cols.column_id = periods.start_column_id), N'')
       --      AS
       --       SYSNAME)
       -- AS [SystemTimePeriodStartColumn]
       --,CAST(ISNULL((SELECT cols.NAME
       --              FROM   sys.columns cols
       --              WHERE  periods.object_id = tbl.object_id
       --                     AND cols.object_id = tbl.object_id
       --                     AND cols.column_id = periods.end_column_id), N'') AS
       --      SYSNAME
       -- )
       -- AS [SystemTimePeriodEndColumn]
       --,tbl.temporal_type AS [TemporalType]
       --,CAST(tbl.is_remote_data_archive_enabled AS BIT)  AS [RemoteDataArchiveEnabled]
       ,CAST(ISNULL(rdat.migration_state, 0) AS TINYINT) AS [RemoteDataArchiveDataMigrationState]
       ,CAST(rdat.filter_predicate AS VARCHAR(4000))     AS [RemoteDataArchiveFilterPredicate]
       ,CAST(rdat.remote_table_name AS SYSNAME)          AS [RemoteTableName]
       ,CAST(CASE
               WHEN rdat.remote_table_name IS NULL THEN 0
               ELSE 1
             END AS BIT)
        AS [RemoteTableProvisioned]
       --,CAST(tbl.is_external AS BIT) AS [IsExternal]
       ,eds.name                     AS [DataSourceName]
       ,ISNULL(eff.name, N'')        AS [FileFormatName]
       ,ISNULL(et.location, N'')     AS [Location]
       ,CASE et.reject_type
          WHEN 'VALUE' THEN 0
          WHEN 'PERCENTAGE' THEN 1
          ELSE -1
        END
        AS [RejectType]
       ,ISNULL(et.reject_value, 0)
        AS [RejectValue]
       ,ISNULL(et.reject_sample_value, -1)
        AS [RejectSampleValue]
FROM   sys.tables AS tbl
       --LEFT OUTER JOIN sys.periods AS periods ON periods.object_id = tbl.object_id
       --LEFT OUTER JOIN sys.tables AS historyTable ON historyTable.object_id = tbl.history_table_id
       LEFT OUTER JOIN sys.database_principals AS stbl
                    ON stbl.principal_id = ISNULL(tbl.principal_id, (
                                           Objectproperty(tbl.object_id,
                                           'OwnerId') ))
       INNER JOIN sys.indexes AS idx
               ON idx.object_id = tbl.object_id
                  AND ( idx.index_id < @_msparam_0
                         OR ( tbl.is_memory_optimized = 1
                              AND idx.index_id = (SELECT Min(index_id)
                                                  FROM   sys.indexes
                                                  WHERE
                                  object_id = tbl.object_id) ) )
       LEFT OUTER JOIN sys.data_spaces AS dstext
                    ON tbl.lob_data_space_id = dstext.data_space_id
       LEFT OUTER JOIN sys.change_tracking_tables AS ctt
                    ON ctt.object_id = tbl.object_id
       LEFT OUTER JOIN sys.filetables AS ft
                    ON ft.object_id = tbl.object_id
       LEFT OUTER JOIN sys.data_spaces AS dsidx
                    ON dsidx.data_space_id = idx.data_space_id
       LEFT OUTER JOIN sys.tables AS t
                    ON t.object_id = idx.object_id
       LEFT OUTER JOIN sys.data_spaces AS dstbl
                    ON dstbl.data_space_id = t.filestream_data_space_id
                       AND ( idx.index_id < 2
                              OR ( idx.type = 7
                                   AND idx.index_id < 3 ) )
       LEFT OUTER JOIN #tmp_extended_remote_data_archive_tables AS rdat
                    ON rdat.object_id = tbl.object_id
       LEFT OUTER JOIN sys.external_tables AS et
                    ON et.object_id = tbl.object_id
       LEFT OUTER JOIN sys.external_data_sources AS eds
                    ON eds.data_source_id = et.data_source_id
       LEFT OUTER JOIN sys.external_file_formats AS eff
                    ON eff.file_format_id = et.file_format_id
--WHERE tbl.name = @tableName
--  AND SCHEMA_NAME(tbl.schema_id) = @schemaName;
