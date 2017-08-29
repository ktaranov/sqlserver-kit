/*
Author: SSMS
*/

exec sp_executesql N'
        CREATE TABLE #tmp_extended_remote_data_archive_tables
        (object_id int not null, remote_table_name nvarchar(128) null, filter_predicate nvarchar(max) null, migration_state tinyint null)

        IF EXISTS(SELECT 1 FROM master.sys.syscolumns WHERE Name = N''remote_data_archive_migration_state'' AND ID = Object_ID(N''sys.tables''))
          EXECUTE(N''INSERT INTO #tmp_extended_remote_data_archive_tables SELECT rdat.object_id, rdat.remote_table_name, 
            SUBSTRING(rdat.filter_predicate, 2, LEN(rdat.filter_predicate) - 2) as filter_predicate, 
            CASE
            WHEN tbl.remote_data_archive_migration_state_desc = N''''PAUSED'''' THEN 1
            WHEN tbl.remote_data_archive_migration_state_desc = N''''OUTBOUND'''' THEN 3
            WHEN tbl.remote_data_archive_migration_state_desc = N''''INBOUND'''' THEN 4
            WHEN tbl.remote_data_archive_migration_state_desc = N''''DISABLED'''' THEN 0
            ELSE 0
            END AS migration_state
            FROM sys.tables tbl LEFT JOIN sys.remote_data_archive_tables rdat ON rdat.object_id = tbl.object_id
            WHERE rdat.object_id IS NOT NULL'')
        ELSE
          EXECUTE(N''INSERT INTO #tmp_extended_remote_data_archive_tables SELECT rdat.object_id, rdat.remote_table_name, 
            SUBSTRING(rdat.filter_predicate, 2, LEN(rdat.filter_predicate) - 2) as filter_predicate, 
            CASE
            WHEN rdat.is_migration_paused = 1 AND rdat.migration_direction_desc = N''''OUTBOUND'''' THEN 1
            WHEN rdat.is_migration_paused = 1 AND rdat.migration_direction_desc = N''''INBOUND'''' THEN 2
            WHEN rdat.is_migration_paused = 0 AND rdat.migration_direction_desc = N''''OUTBOUND'''' THEN 3
            WHEN rdat.is_migration_paused = 0 AND rdat.migration_direction_desc = N''''INBOUND'''' THEN 4
            ELSE 0
            END AS migration_state
            FROM sys.tables tbl LEFT JOIN sys.remote_data_archive_tables rdat ON rdat.object_id = tbl.object_id
            WHERE rdat.object_id IS NOT NULL'')
      


SELECT
tbl.name AS [Name],
tbl.object_id AS [ID],
tbl.create_date AS [CreateDate],
tbl.modify_date AS [DateLastModified],
ISNULL(stbl.name, N'''') AS [Owner],
CAST(case when tbl.principal_id is null then 1 else 0 end AS bit) AS [IsSchemaOwned],
SCHEMA_NAME(tbl.schema_id) AS [Schema],
CAST(
 case 
    when tbl.is_ms_shipped = 1 then 1
    when (
        select 
            major_id 
        from 
            sys.extended_properties 
        where 
            major_id = tbl.object_id and 
            minor_id = 0 and 
            class = 1 and 
            name = N''microsoft_database_tools_support'') 
        is not null then 1
    else 0
end          
             AS bit) AS [IsSystemObject],
CAST(OBJECTPROPERTY(tbl.object_id, N''HasAfterTrigger'') AS bit) AS [HasAfterTrigger],
CAST(OBJECTPROPERTY(tbl.object_id, N''HasInsertTrigger'') AS bit) AS [HasInsertTrigger],
CAST(OBJECTPROPERTY(tbl.object_id, N''HasDeleteTrigger'') AS bit) AS [HasDeleteTrigger],
CAST(OBJECTPROPERTY(tbl.object_id, N''HasInsteadOfTrigger'') AS bit) AS [HasInsteadOfTrigger],
CAST(OBJECTPROPERTY(tbl.object_id, N''HasUpdateTrigger'') AS bit) AS [HasUpdateTrigger],
CAST(OBJECTPROPERTY(tbl.object_id, N''IsIndexed'') AS bit) AS [HasIndex],
CAST(OBJECTPROPERTY(tbl.object_id, N''IsIndexable'') AS bit) AS [IsIndexable],
CAST(CASE idx.index_id WHEN 1 THEN 1 ELSE 0 END AS bit) AS [HasClusteredIndex],
CAST(CASE idx.type WHEN 0 THEN 1 ELSE 0 END AS bit) AS [HasHeapIndex],
tbl.uses_ansi_nulls AS [AnsiNullsStatus],
CAST(ISNULL(OBJECTPROPERTY(tbl.object_id,N''IsQuotedIdentOn''),0) AS bit) AS [QuotedIdentifierStatus],
CAST(0 AS bit) AS [FakeSystemTable],
ISNULL(dstext.name,N'''') AS [TextFileGroup],
CAST(tbl.is_memory_optimized AS bit) AS [IsMemoryOptimized],
case when (tbl.durability=1) then 0 else 1 end AS [Durability],
tbl.is_replicated AS [Replicated],
tbl.lock_escalation AS [LockEscalation],
CAST(case when ctt.object_id is null then 0 else 1  end AS bit) AS [ChangeTrackingEnabled],
CAST(ISNULL(ctt.is_track_columns_updated_on,0) AS bit) AS [TrackColumnsUpdatedEnabled],
tbl.is_filetable AS [IsFileTable],
ISNULL(ft.directory_name,N'''') AS [FileTableDirectoryName],
ISNULL(ft.filename_collation_name,N'''') AS [FileTableNameColumnCollation],
CAST(ISNULL(ft.is_enabled,0) AS bit) AS [FileTableNamespaceEnabled],
CASE WHEN ''PS''=dsidx.type THEN dsidx.name ELSE N'''' END AS [PartitionScheme],
CAST(CASE WHEN ''PS''=dsidx.type THEN 1 ELSE 0 END AS bit) AS [IsPartitioned],
CASE WHEN ''FD''=dstbl.type THEN dstbl.name ELSE N'''' END AS [FileStreamFileGroup],
CASE WHEN ''PS''=dstbl.type THEN dstbl.name ELSE N'''' END AS [FileStreamPartitionScheme],
CAST(CASE idx.type WHEN 5 THEN 1 ELSE 0 END AS bit) AS [HasClusteredColumnStoreIndex],
CAST(CASE tbl.temporal_type WHEN 2 THEN 1 ELSE 0 END AS bit) AS [IsSystemVersioned],
CAST(ISNULL(historyTable.name, N'''') AS sysname) AS [HistoryTableName],
CAST(ISNULL(SCHEMA_NAME(historyTable.schema_id), N'''') AS sysname) AS [HistoryTableSchema],
CAST(ISNULL(historyTable.object_id, 0) AS int) AS [HistoryTableID],
CAST(CASE WHEN periods.start_column_id IS NULL THEN 0 ELSE 1 END AS bit) AS [HasSystemTimePeriod],
CAST(
      ISNULL((SELECT cols.name
      FROM sys.columns cols
      WHERE periods.object_id = tbl.object_id
      AND cols.object_id = tbl.object_id
      AND cols.column_id = periods.start_column_id), N'''')
     AS sysname) AS [SystemTimePeriodStartColumn],
CAST(
      ISNULL((SELECT cols.name
      FROM sys.columns cols
      WHERE periods.object_id = tbl.object_id
      AND cols.object_id = tbl.object_id
      AND cols.column_id = periods.end_column_id), N'''')
     AS sysname) AS [SystemTimePeriodEndColumn],
tbl.temporal_type AS [TemporalType],
CAST(tbl.is_remote_data_archive_enabled AS bit) AS [RemoteDataArchiveEnabled],
CAST(
      ISNULL(rdat.migration_state, 0)
     AS tinyint) AS [RemoteDataArchiveDataMigrationState],
CAST(rdat.filter_predicate AS varchar(4000)) AS [RemoteDataArchiveFilterPredicate],
CAST(rdat.remote_table_name AS sysname) AS [RemoteTableName],
CAST(CASE WHEN rdat.remote_table_name IS NULL THEN 0 ELSE 1 END AS bit) AS [RemoteTableProvisioned],
CAST(tbl.is_external AS bit) AS [IsExternal],
eds.name AS [DataSourceName],
ISNULL(eff.name,N'''') AS [FileFormatName],
ISNULL(et.location,N'''') AS [Location],

      CASE et.reject_type
      WHEN ''VALUE''      THEN 0
      WHEN ''PERCENTAGE'' THEN 1
      ELSE -1
      END
     AS [RejectType],
ISNULL(et.reject_value,0) AS [RejectValue],
ISNULL(et.reject_sample_value,-1) AS [RejectSampleValue]
FROM
sys.tables AS tbl
LEFT OUTER JOIN sys.periods as periods ON periods.object_id = tbl.object_id
LEFT OUTER JOIN sys.tables as historyTable ON historyTable.object_id = tbl.history_table_id
LEFT OUTER JOIN sys.database_principals AS stbl ON stbl.principal_id = ISNULL(tbl.principal_id, (OBJECTPROPERTY(tbl.object_id, ''OwnerId'')))
INNER JOIN sys.indexes AS idx ON 
        idx.object_id = tbl.object_id and (idx.index_id < @_msparam_0  or (tbl.is_memory_optimized = 1 and idx.index_id = (select min(index_id) from sys.indexes where object_id = tbl.object_id)))
      
LEFT OUTER JOIN sys.data_spaces AS dstext  ON tbl.lob_data_space_id = dstext.data_space_id
LEFT OUTER JOIN sys.change_tracking_tables AS ctt ON ctt.object_id = tbl.object_id 
LEFT OUTER JOIN sys.filetables AS ft ON ft.object_id = tbl.object_id 
LEFT OUTER JOIN sys.data_spaces AS dsidx ON dsidx.data_space_id = idx.data_space_id
LEFT OUTER JOIN sys.tables AS t ON t.object_id = idx.object_id
LEFT OUTER JOIN sys.data_spaces AS dstbl ON dstbl.data_space_id = t.Filestream_data_space_id and (idx.index_id < 2 or (idx.type = 7 and idx.index_id < 3))
LEFT OUTER JOIN #tmp_extended_remote_data_archive_tables AS rdat ON rdat.object_id = tbl.object_id
LEFT OUTER JOIN sys.external_tables AS et ON et.object_id = tbl.object_id
LEFT OUTER JOIN sys.external_data_sources AS eds ON eds.data_source_id = et.data_source_id
LEFT OUTER JOIN sys.external_file_formats AS eff ON eff.file_format_id = et.file_format_id
WHERE
(tbl.name=@_msparam_1 and SCHEMA_NAME(tbl.schema_id)=@_msparam_2)

        DROP TABLE #tmp_extended_remote_data_archive_tables
      
',N'@_msparam_0 nvarchar(4000),@_msparam_1 nvarchar(4000),@_msparam_2 nvarchar(4000)',@_msparam_0=N'2',@_msparam_1=N'Node',@_msparam_2=N'dictionary';
