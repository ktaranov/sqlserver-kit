USE master
GO

IF OBJECT_ID('dbo.sp_IndexAnalysis') IS NOT NULL
    DROP PROCEDURE dbo.sp_IndexAnalysis
GO

/********************************************************************************************* 
Index Analysis Script v11.06
(C) 2013, Jason Strate

Feedback:
    mailto:jasonstrate@gmail.com 
    http://www.jasonstrate.com

License: 
   This query is free to download and use for personal, educational, and internal 
   corporate purposes, provided that this header is preserved. Redistribution or sale 
   of this query, in whole or in part, is prohibited without the author's express 
   written consent. 

Note: 
    Recommendations in the Index Action column are not black and white recommendations.  
    They are more light grey ideas of what may be appropriate.  Always use your experience 
    with the database in place of a blanket recommendation. 

    The information in the DMVs is gathered from when the SQL Server service last started, the
    database was brought onling, or when the index metadata was updated (such as during reindex 
    operations, which ever event is more recent. 

    The index statistics accumulated in sys.dm_db_index_operational_stats and 
    sys.dm_db_index_usage_stats are reset when the index is rebuilt. 

    The index statistics for a table that are accumulated in the DMVs 
    sys.dm_db_missing_index_* are reset whenever an index is created on the table. 

    The index name provided in the name column for indexes that do not exist is not a 
    recommended name for the index.  It’s just an informative placeholder. 
   
Parameters
    @TableName(NVARCHAR(256)): Optional parameter to add
    @IncludeMissingIndexes(BIT): Identifies whether to include missing indexes in the output
    @IncludeMissingFKIndexes(BIT): Identifies whether to include missing foreign key indexes 
        in the output
    @Output(VARCHAR(20)): Determines the output results from the stored procedure.  The
        available values are
           * DETAILED: All results from the index analysis
           * DUPLICATE: Index results for deplicate indexes
           * OVERLAPPING: Index results for overlapping indexes

Columns:
    index_action: Analysis recommendation on action to take on the index 
        CREATE: Recommend adding the index to the table. 
        DROP-DUP: Recommend dropping the index since it is a duplicate 
		DROP-COUNT: Count of indexes on tables may indicate that the index may be a candidate
			for removal.
		DROP-USAGE: Usage of the index suggests it may be a candidate for removal 
        BLEND: Review the missing index details to see if the missing index details can be 
            added to an existing index. 
        REALIGN: Bookmark lookups on the index exceed the number of seeks on the table.  
            Recommend investigating whether to move the clustered index to another index or 
            add included columns to the indexes that are part of the bookmark lookups. 
    index_pros: list of reasons that indicate the benefits provided by the index 
        FK: The index schema maps to a foreign key 
        UQ: Index is a unique constraint 
        $, $$, $$$, $$$+: Indicates the ratio of read to write uses in execution plans.  The 
            higher the ratio the more dollar signs; this should correlate to greater benefit 
            provided by the index. 
    index_cons: list of reasons that indicate some negative aspects associate with the index 
        SCN: Flag indicating that the ratio of seeks to scans on the index less than 1,000. 
        DP: Index schema is a duplicate of another index. 
        OV: Index schema overlaps another index. 
        $, $$, $$$, $$$+: Indicates the ratio of write to read uses in execution plans.  The 
            higher the ratio the more dollar signs; this should correlate to more cost  
            incurred by the index.
		DSB: Index is disabled.  These should be enabled or removed.
    filegroup: file group that the index is located.
    schema_id: Schema ID 
    schema_name: Name of the schema. 
    object_id: Object ID 
    table_name: Name of the table name 
    index_id: Index ID 
    index_name: Name of the index. 
    is_unique: Flag indicating whether an index has a unique index. 
    has_unique: Flag indicating whether the table has a unique index. 
    type_desc: Type of index; either clustered or non-clustered. 
    partition_number: Partition number. 
    fill_factor: Percentage of free space left on pages the index was created or rebuilt. 
    is_padded: Boolean value indicating whether fill factor is applied to nonleaf levels 
    reserved_page_count: Total number of pages reserved for the index. 
    size_in_mb: The amount of space in MB the index utilizes on disk. 
    buffered_page_count: Total number of pages in the buffer for the index. 
    buffer_mb: The amount of space in MB in the buffer for the index. 
    pct_in_buffer: The percentage of an index that is current in the SQL Server buffer. 
    table_buffer_mb: The amount of space in MB in the SQL Server buffer that is being 
        utilized by the table. 
    row_count: Number of rows in the index. 
    missing_index_impact: Calculation of impact of a potential index.  This is based on the seeks and 
        scans that the index could have utilized multiplied by average improvement the index 
        would have provided.  This is included only for missing indexes. 
    existing_ranking: Ranking of the existing indexes ordered by user_total descending across
        the indexes for the table. 
    user_total: Total number of seek, scan, and lookup operations for the index. 
    user_total_pct: Percentage of total number of seek, scan, and lookup operations for this 
        index compared to all seek, scan, and lookup operations for existing indexes for the 
        table. 
    estimated_user_total_pct: Percentage of total number of seek, scan, and lookup operations 
        for this index compared to all seek, scan, and lookup operations for existing and 
        potential indexes for the table.  This number is naturally skewed because a seek for 
        potential Index A resulted in another operation on an existing index and both of 
        these operations would be counted. 
    user_seeks: Number of seek operations on the index. 
    user_scans: Number of scan operations on the index. 
    user_lookups: Number of lookup operations on the index. 
    user_updates: Number of update operations on the index. 
    read_to_update_ratio: Ratio of user_seeks, user_scans, and user_lookups to user_updates. 
    read_to_update: Division of user_seeks, user_scans, and user_lookups by user_updates. 
    update_to_read: Division of user_updates to user_seeks, user_scans by user_lookups. 
    row_lock_count: Cumulative number of row locks requested. 
    row_lock_wait_count: Cumulative number of times the Database Engine waited on a row lock. 
    row_lock_wait_in_ms: Total number of milliseconds the Database Engine waited on a row 
        lock. 
    row_block_pct: Percentage of row locks that encounter waits on a row lock. 
    avg_row_lock_waits_ms: Average number of milliseconds the Database Engine waited on a row 
        lock. 
    page_latch_wait_count: Cumulative number of times the page latch waits occurred 
    avg_page_latch_wait_ms: Average number of milliseconds the Database Engine waited on a 
        page latch wait. 
    page_io_latch_wait_count: Cumulative number of times the page IO latch waits occurred 
    avg_page_io_latch_wait_ms: Average number of milliseconds the Database Engine waited on a 
        page IO latch wait. 
    tree_page_latch_wait_count: Cumulative number of times the tree page latch waits occurred 
    avg_tree_page_latch_wait_ms: Average number of milliseconds the Database Engine waited on 
        a tree page latch wait. 
    tree_page_io_latch_wait_count: Cumulative number of times the tree page IO latch waits 
        occurred 
    avg_tree_page_io_latch_wait_ms: Average number of milliseconds the Database Engine waited 
        on a tree page IO latch wait. 
    read_operations: Cumulative count of range_scan_count and singleton_lookup_count 
        operations 
    leaf_writes: Cumulative count of leaf_insert_count, leaf_update_count, leaf_delete_count 
        and leaf_ghost_count operations 
    leaf_page_allocations: Cumulative count of leaf-level page allocations in the index or 
        heap.  For an index, a page allocation corresponds to a page split. 
    leaf_page_merges: Cumulative count of page merges at the leaf level. 
    nonleaf_writes: Cumulative count of leaf_insert_count, leaf_update_count and 
        leaf_delete_count operations 
    nonleaf_page_allocations: Cumulative count of page allocations caused by page splits 
        above the leaf level. 
    nonleaf_page_merges: Cumulative count of page merges above the leaf level. 
    indexed_columns: Columns that are part of the index, missing index or foreign key. 
    included_columns: Columns that are included in the index or missing index. 
    indexed_columns_ids: Column IDs that are part of the index, missing index or foreign 
        key 
    included_column_ids: Column IDs that are included in the index or missing index. 
    duplicate_indexes: List of Indexes that exist on the table that are identical to the 
        index on this row. 
    overlapping_indexes: List of Indexes that exist on the table that overlap the index on 
        this row. 
    related_foreign_keys: List of foreign keys that are related to the index either as an 
        exact match or covering index. 
    related_foreign_keys_xml: XML document listing foreign keys that are related to the index 
        either as an exact match or covering index. 

Revision History
Date			Version		DESCRIPTION
----------------------------------------------------------------------------------------------
2012-12-10		11.01	    Rewrote information collection to reduce dynamic SQL
                            * Fixed issue with Object_ID
                            * Added unique check and filter definition to duplication and 
                              overlapping indexes
                            * Fixed errors with documentation section.
                            * Added parameters @IncludeMissingIndexes, @IncludeMissingFKIndexes,
                              and @Output
                            * Removed DDL create and drop columns for indexes, too much risk in
                              automatic index building
2012-12-28      11.02       * Fixed new issues WITH Object_ID
                            * change missing foreign key logic to include basic details but not
                            suggest missing indexes with @IncludeMissingFKIndexes flag 
                            * Fixed issues with missing foreign keys that was not displaying them
                            * Improved default sort for DETAILED output
                            * Updated case for case-sensitive collations
2013-01-08      11.03       * Fixed issue with overlapping indexes and duplicate indexes related
                            filtered indexes
                            * Improved error handling to solve issue with truncation MESSAGE
2013-03-07		11.04		* Fixed duplicate index logic to match that from 
							http://www.jasonstrate.com/2013/03/thats-actually-a-duplicate-index/
							* Added check for disabled indexes to checks
							* Expanded drop reasons with explanations and descriptions for 
							dropping because of duplication, usage, and count of indexes
							* Increased size of foreign key name to accommodate larger names
							* Fixed issue causing DROP recommmendation on missing indexes
2013-03-20		11.05		* Fixed data type on missing_index_impact (Credit: Dick Baker)
2013-05-22      11.06       * Fixed bug causing mismatch with foreign key analysis
                            * Adjusted overlapping index logic which was broke with new duplicate
                                index logic
*********************************************************************************************/ 
CREATE PROCEDURE dbo.sp_IndexAnalysis
(
@TableName NVARCHAR(256) = NULL 
,@IncludeMissingIndexes BIT = 1 
,@IncludeMissingFKIndexes BIT = 1
,@Output VARCHAR(20) = 'DETAILED'
)
WITH RECOMPILE
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON

DECLARE @ERROR_MESSAGE NVARCHAR(2048)
    ,@ERROR_SEVERITY INT
    ,@ERROR_STATE INT

	DECLARE @SQL NVARCHAR(max)
    ,@DB_ID INT
    ,@ObjectID INT
    ,@DatabaseName NVARCHAR(max)

BEGIN TRY
    IF @Output NOT IN ('DETAILED','DUPLICATE','OVERLAPPING')
        RAISERROR('The value "%s" provided for the @Output parameter is not valid',16,1,@Output)

    SELECT @DB_ID = DB_ID()
        ,@ObjectID = OBJECT_ID(QUOTENAME(DB_NAME(DB_ID()))+'.'+COALESCE(QUOTENAME(PARSENAME(@TableName,2)),'')+'.'+QUOTENAME(PARSENAME(@TableName,1)))
        ,@DatabaseName = QUOTENAME(DB_NAME(DB_ID()))

-- Obtain memory buffer information on database objects
    IF OBJECT_ID('tempdb..#MemoryBuffer') IS NOT NULL
        DROP TABLE #MemoryBuffer

    CREATE TABLE #MemoryBuffer (
        database_id INT
		,object_id INT
        ,index_id INT
        ,partition_number INT
        ,buffered_page_count INT
        ,buffered_mb DECIMAL(12, 2)
        )

    SET @SQL = 'WITH AllocationUnits
    AS (
        SELECT p.object_id
            ,p.index_id
            ,p.partition_number 
            ,au.allocation_unit_id
        FROM '+@DatabaseName+'.sys.allocation_units AS au
            INNER JOIN '+@DatabaseName+'.sys.partitions AS p ON au.container_id = p.hobt_id AND (au.type = 1 OR au.type = 3)
        UNION ALL
        SELECT p.object_id
            ,p.index_id
            ,p.partition_number 
            ,au.allocation_unit_id
        FROM '+@DatabaseName+'.sys.allocation_units AS au
            INNER JOIN '+@DatabaseName+'.sys.partitions AS p ON au.container_id = p.partition_id AND au.type = 2
    )
    SELECT DB_ID()
		,au.object_id
        ,au.index_id
        ,au.partition_number
        ,COUNT(*)AS buffered_page_count
        ,CONVERT(DECIMAL(12,2), CAST(COUNT(*) as bigint)*CAST(8 as float)/1024) as buffer_mb
    FROM '+@DatabaseName+'.sys.dm_os_buffer_descriptors AS bd 
        INNER JOIN AllocationUnits au ON bd.allocation_unit_id = au.allocation_unit_id
    WHERE bd.database_id = db_id()
    GROUP BY au.object_id, au.index_id, au.partition_number'

    BEGIN TRY
        INSERT INTO #MemoryBuffer
	    EXEC sys.sp_executesql @SQL
    END TRY
    BEGIN CATCH
        SELECT @ERROR_MESSAGE  = 'Populate #MemoryBuffer (Line '+CAST(ERROR_LINE() AS NVARCHAR(25))+'): ' + ERROR_MESSAGE()
            ,@ERROR_SEVERITY = ERROR_SEVERITY()
            ,@ERROR_STATE = ERROR_STATE()
    
        RAISERROR(@ERROR_MESSAGE, @ERROR_SEVERITY, @ERROR_STATE)
    END CATCH

-- Obtain index meta data information
    IF OBJECT_ID('tempdb..#IndexMeta') IS NOT NULL
        DROP TABLE #IndexMeta

	CREATE TABLE #IndexMeta (
		 database_id SMALLINT
		,filegroup_name NVARCHAR(128)
		,schema_id INT
		,schema_name NVARCHAR(128)
		,object_id INT
		,table_name NVARCHAR(128)
		,index_id INT
		,index_name NVARCHAR(128)
		,is_primary_key BIT
		,is_unique BIT
        ,is_disabled BIT
		,type_desc NVARCHAR(128)
		,partition_number INT
		,fill_factor TINYINT
		,is_padded BIT
		,reserved_page_count BIGINT
		,size_in_mb DECIMAL(12, 2)
		,row_count BIGINT
        ,filter_definition NVARCHAR(MAX)
		,indexed_columns NVARCHAR(MAX)
		,included_columns NVARCHAR(MAX)
        ,key_columns NVARCHAR(MAX)
		,data_columns NVARCHAR(MAX)
		,indexed_columns_ids NVARCHAR(1024)
		,included_column_ids NVARCHAR(1024)
		)

     SET @SQL = N'SELECT
	    database_id = DB_ID()
	    , filegroup = ds.name
	    , s.schema_id
	    , schema_name = s.name
	    , object_id = t.object_id
	    , table_name = t.name
	    , i.index_id
	    , index_name = COALESCE(i.name, ''N/A'')
	    , ps.partition_number
	    , i.is_primary_key
	    , i.is_unique
        , i.is_disabled
	    , type_desc = CASE WHEN i.is_unique = 1 THEN ''UNIQUE '' ELSE '''' END + i.type_desc
	    , i.fill_factor
	    , i.is_padded
	    , ps.reserved_page_count
	    , size_in_mb = CAST(reserved_page_count * CAST(8 as float) / 1024 as DECIMAL(12,2)) 
	    , row_count
        , i.filter_definition
	    , indexed_columns = STUFF((
			    SELECT '', '' + QUOTENAME(c.name)
			    FROM '+@DatabaseName+'.sys.index_columns ic
				    INNER JOIN '+@DatabaseName+'.sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
			    WHERE i.object_id = ic.object_id
			    AND i.index_id = ic.index_id
			    AND is_included_column = 0
			    ORDER BY key_ordinal ASC
			    FOR XML PATH('''')), 1, 2, '''')
	    , included_columns = STUFF((
			    SELECT '', '' + QUOTENAME(c.name)
			    FROM '+@DatabaseName+'.sys.index_columns ic
				    INNER JOIN '+@DatabaseName+'.sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
			    WHERE i.object_id = ic.object_id
			    AND i.index_id = ic.index_id
			    AND is_included_column = 1
			    ORDER BY key_ordinal ASC
			    FOR XML PATH('''')), 1, 2, '''') 
	    , key_columns = STUFF((
			    SELECT '', '' + QUOTENAME(c.name)
			    FROM '+@DatabaseName+'.sys.index_columns ic
				    INNER JOIN '+@DatabaseName+'.sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
			    WHERE i.object_id = ic.object_id
			    AND i.index_id = ic.index_id
			    AND is_included_column = 0
			    ORDER BY key_ordinal ASC
			    FOR XML PATH(''''))
                + COALESCE((SELECT '', '' + QUOTENAME(c.name)
			    FROM '+@DatabaseName+'.sys.index_columns ic
				    INNER JOIN '+@DatabaseName+'.sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
                    LEFT OUTER JOIN '+@DatabaseName+'.sys.index_columns ic_key ON c.object_id = ic_key.object_id 
                        AND c.column_id = ic_key.column_id 
                        AND i.index_id = ic_key.index_id
                        AND ic_key.is_included_column = 0
			    WHERE i.object_id = ic.object_id
			    AND ic.index_id = 1
			    AND ic.is_included_column = 0
                AND ic_key.index_id IS NULL
			    ORDER BY ic.key_ordinal ASC
			    FOR XML PATH('''')),''''), 1, 2, '''')
	    , data_columns = CASE WHEN i.index_id IN (0,1) THEN ''ALL-COLUMNS'' ELSE STUFF((
			    SELECT '', '' + QUOTENAME(c.name)
			    FROM '+@DatabaseName+'.sys.index_columns ic
				    INNER JOIN '+@DatabaseName+'.sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
                    LEFT OUTER JOIN '+@DatabaseName+'.sys.index_columns ic_key ON c.object_id = ic_key.object_id AND c.column_id = ic_key.column_id AND ic_key.index_id = 1
			    WHERE i.object_id = ic.object_id
			    AND i.index_id = ic.index_id
			    AND ic.is_included_column = 1
                AND ic_key.index_id IS NULL
			    ORDER BY ic.key_ordinal ASC
			    FOR XML PATH('''')), 1, 2, '''') END
	    , indexed_column_ids = (SELECT QUOTENAME(CAST(ic.column_id AS VARCHAR(10)) 
                    + CASE WHEN ic.is_descending_key = 0 THEN ''+'' ELSE ''-'' END, ''('')
			    FROM '+@DatabaseName+'.sys.index_columns ic
				    INNER JOIN '+@DatabaseName+'.sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
			    WHERE i.object_id = ic.object_id
			    AND i.index_id = ic.index_id
			    AND is_included_column = 0
			    ORDER BY key_ordinal ASC
			    FOR XML PATH(''''))
                + ''|'' + COALESCE((SELECT QUOTENAME(CAST(ic.column_id AS VARCHAR(10)) 
                    + CASE WHEN ic.is_descending_key = 0 THEN ''+'' ELSE ''-'' END, ''('')
			    FROM '+@DatabaseName+'.sys.index_columns ic
				    INNER JOIN '+@DatabaseName+'.sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
                    LEFT OUTER JOIN '+@DatabaseName+'.sys.index_columns ic_key ON c.object_id = ic_key.object_id 
                        AND c.column_id = ic_key.column_id 
                        AND i.index_id = ic_key.index_id
                        AND ic_key.is_included_column = 0
			    WHERE i.object_id = ic.object_id
			    AND ic.index_id = 1
			    AND ic.is_included_column = 0
                AND ic_key.index_id IS NULL
			    ORDER BY ic.key_ordinal ASC
			    FOR XML PATH('''')),'''')
            + CASE WHEN i.is_unique = 1 THEN ''U'' ELSE '''' END
	    , included_column_ids = CASE WHEN i.index_id IN (0,1) THEN ''ALL-COLUMNS'' ELSE
                COALESCE((SELECT QUOTENAME(ic.column_id,''('')
			    FROM '+@DatabaseName+'.sys.index_columns ic
				    INNER JOIN '+@DatabaseName+'.sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
                    LEFT OUTER JOIN '+@DatabaseName+'.sys.index_columns ic_key ON c.object_id = ic_key.object_id AND c.column_id = ic_key.column_id AND ic_key.index_id = 1
			    WHERE i.object_id = ic.object_id
			    AND i.index_id = ic.index_id
			    AND ic.is_included_column = 1
                AND ic_key.index_id IS NULL
			    ORDER BY ic.key_ordinal ASC
			    FOR XML PATH('''')), SPACE(0)) END
    FROM '+@DatabaseName+'.sys.tables t
	    INNER JOIN '+@DatabaseName+'.sys.schemas s ON t.schema_id = s.schema_id
	    INNER JOIN '+@DatabaseName+'.sys.indexes i ON t.object_id = i.object_id
	    INNER JOIN '+@DatabaseName+'.sys.data_spaces ds ON i.data_space_id = ds.data_space_id
	    INNER JOIN '+@DatabaseName+'.sys.dm_db_partition_stats ps ON i.object_id = ps.object_id AND i.index_id = ps.index_id'

	IF @ObjectID IS NOT NULL
        SET @SQL = @SQL + CHAR(13) + 'WHERE t.object_id = @ObjectID '

    BEGIN TRY
	    INSERT INTO #IndexMeta (
		    database_id
		    ,filegroup_name
		    ,schema_id
		    ,schema_name
		    ,object_id
		    ,table_name
		    ,index_id
		    ,index_name
		    ,partition_number
		    ,is_primary_key
		    ,is_unique
            ,is_disabled
		    ,type_desc
		    ,fill_factor
		    ,is_padded
		    ,reserved_page_count
		    ,size_in_mb
		    ,row_count
            ,filter_definition
		    ,indexed_columns
		    ,included_columns
            ,key_columns
		    ,data_columns
		    ,indexed_columns_ids
		    ,included_column_ids)
	    EXEC sys.sp_executesql @SQL, N'@DB_ID INT, @ObjectID INT', @DB_ID = @DB_ID, @ObjectID = @ObjectID
    END TRY
    BEGIN CATCH
        SELECT @ERROR_MESSAGE  = 'Populate #IndexMeta (Line '+CAST(ERROR_LINE() AS NVARCHAR(25))+'): ' + ERROR_MESSAGE()
            ,@ERROR_SEVERITY = ERROR_SEVERITY()
            ,@ERROR_STATE = ERROR_STATE()
    
        RAISERROR(@ERROR_MESSAGE, @ERROR_SEVERITY, @ERROR_STATE)
    END CATCH 
      
    IF OBJECT_ID('tempdb..#IndexStatistics') IS NOT NULL
        DROP TABLE #IndexStatistics
        
	SELECT IDENTITY(INT,1,1) AS row_id
        ,CAST('' AS VARCHAR(10)) AS index_action
        ,CAST('' AS VARCHAR(25)) AS index_pros
        ,CAST('' AS VARCHAR(25)) AS index_cons
        ,im.database_id
        ,im.filegroup_name
        ,im.schema_id
        ,im.schema_name
        ,im.object_id
        ,im.table_name
        ,im.index_id
        ,im.index_name
        ,im.is_primary_key
        ,im.is_unique
        ,im.is_disabled
        ,CAST(0 AS BIT) AS has_unique
        ,im.type_desc
        ,im.partition_number
        ,im.fill_factor
        ,im.is_padded
        ,im.reserved_page_count
        ,im.size_in_mb
        ,mb.buffered_page_count
        ,mb.buffered_mb
        ,CAST(0 AS INT) AS table_buffered_mb
        ,CAST(100.*mb.buffered_page_count/NULLIF(im.reserved_page_count,0) AS DECIMAL(12,2)) AS buffered_percent
        ,im.row_count
        ,ROW_NUMBER() OVER (PARTITION BY im.object_id ORDER BY im.is_primary_key desc,ius.user_seeks + ius.user_scans + ius.user_lookups DESC) AS index_rank
        , ius.user_seeks + ius.user_scans + ius.user_lookups AS user_total
        , COALESCE(CAST(100 * (ius.user_seeks + ius.user_scans + ius.user_lookups)
            /(NULLIF(SUM(ius.user_seeks + ius.user_scans + ius.user_lookups) 
            OVER(PARTITION BY im.object_id), 0) * 1.) as DECIMAL(6,2)),0) AS user_total_pct
        ,CAST(0 AS DECIMAL(6,2)) AS estimated_user_total_pct
        ,CAST(0 AS FLOAT) AS missing_index_impact -- Dick Baker 201303 (INT range not big enough and is f.p. anyway)
        ,ius.user_seeks
        ,ius.user_scans
        ,ius.user_lookups
        ,ius.user_updates
        ,(1.*(ius.user_seeks + ius.user_scans + ius.user_lookups))/NULLIF(ius.user_updates,0) AS read_to_update_ratio
        ,CASE WHEN ius.user_seeks + ius.user_scans + ius.user_lookups >= ius.user_updates
            THEN CEILING(1.*(ius.user_seeks + ius.user_scans + ius.user_lookups)/COALESCE(NULLIF(ius.user_seeks,0),1)) 
            ELSE 0 END AS read_to_update
        ,CASE WHEN ius.user_seeks + ius.user_scans + ius.user_lookups <= ius.user_updates
            THEN CEILING(1.*(ius.user_updates)/COALESCE(NULLIF(ius.user_seeks + ius.user_scans + ius.user_lookups,0),1))
            ELSE 0 END AS update_to_read
        ,ios.row_lock_count
        ,ios.row_lock_wait_count
        ,ios.row_lock_wait_in_ms
        ,CAST(100.0 * ios.row_lock_wait_count/NULLIF(ios.row_lock_count,0) AS DECIMAL(12,2)) AS row_block_pct 
        ,CAST(1. * ios.row_lock_wait_in_ms /NULLIF(ios.row_lock_wait_count,0) AS DECIMAL(12,2)) AS avg_row_lock_waits_ms
        ,ios.page_latch_wait_count
        ,CAST(1. * page_latch_wait_in_ms / NULLIF(ios.page_io_latch_wait_count,0) AS DECIMAL(12,2)) AS avg_page_latch_wait_ms
        ,ios.page_io_latch_wait_count
        ,CAST(1. * ios.page_io_latch_wait_in_ms / NULLIF(ios.page_io_latch_wait_count,0) AS DECIMAL(12,2)) AS avg_page_io_latch_wait_ms 
        ,ios.tree_page_latch_wait_count AS tree_page_latch_wait_count
        ,CAST(1. * tree_page_latch_wait_in_ms / NULLIF(ios.tree_page_io_latch_wait_count,0) AS DECIMAL(12,2)) AS avg_tree_page_latch_wait_ms 
        ,ios.tree_page_io_latch_wait_count
        ,CAST(1. * ios.tree_page_io_latch_wait_in_ms / NULLIF(ios.tree_page_io_latch_wait_count,0) AS DECIMAL(12,2)) AS avg_tree_page_io_latch_wait_ms
        ,range_scan_count + singleton_lookup_count AS read_operations
        ,ios.leaf_insert_count + ios.leaf_update_count + ios.leaf_delete_count + ios.leaf_ghost_count AS leaf_writes
        ,leaf_allocation_count As leaf_page_allocations
        ,ios.leaf_page_merge_count AS leaf_page_merges 
        ,ios.nonleaf_insert_count + ios.nonleaf_update_count + ios.nonleaf_delete_count AS nonleaf_writes
        ,ios.nonleaf_allocation_count AS nonleaf_page_allocations
        ,ios.nonleaf_page_merge_count AS nonleaf_page_merges
        ,im.indexed_columns
        ,im.included_columns
        ,im.filter_definition
        ,key_columns
		,data_columns
        ,im.indexed_columns_ids
        ,im.included_column_ids
        ,CAST('' AS VARCHAR(MAX)) AS duplicate_indexes
        ,CAST('' AS SMALLINT) AS first_dup_index_id
        ,CAST('' AS VARCHAR(MAX)) AS overlapping_indexes
        ,CAST('' AS VARCHAR(MAX)) AS related_foreign_keys
        ,CAST('' AS XML) AS related_foreign_keys_xml
    INTO #IndexStatistics
	FROM #IndexMeta im
		LEFT OUTER JOIN sys.dm_db_index_usage_stats ius ON im.object_id = ius.object_id AND im.index_id = ius.index_id AND im.database_id = ius.database_id
		LEFT OUTER JOIN sys.dm_db_index_operational_stats(@DB_ID, NULL, NULL, NULL) ios ON im.object_id = ios.object_id AND im.index_id = ios.index_id AND im.partition_number = ios.partition_number
		LEFT OUTER JOIN #MemoryBuffer mb ON im.object_id = mb.object_id AND im.index_id = mb.index_id AND im.partition_number = mb.partition_number

    IF @IncludeMissingIndexes = 1
    BEGIN
        INSERT INTO #IndexStatistics
            (filegroup_name, schema_id, schema_name, object_id, table_name, index_name, type_desc, missing_index_impact, index_rank, user_total, user_seeks, user_scans, user_lookups, indexed_columns, included_columns)
        SELECT 
            '' AS filegroup_name
            ,SCHEMA_ID(OBJECT_SCHEMA_NAME(mid.object_id)) AS schema_id
            ,OBJECT_SCHEMA_NAME(mid.object_id) AS schema_name
            ,mid.object_id
            ,OBJECT_NAME(mid.object_id) AS table_name
            ,'--MISSING INDEX--' AS index_name
            ,'NONCLUSTERED' AS type_desc
            ,(migs.user_seeks + migs.user_scans) * migs.avg_user_impact as impact
            ,0 AS index_rank
            ,migs.user_seeks + migs.user_scans as user_total
            ,migs.user_seeks 
            ,migs.user_scans
            ,0 as user_lookups
            ,COALESCE(equality_columns + CASE WHEN inequality_columns IS NOT NULL THEN ', ' ELSE SPACE(0) END, SPACE(0)) + COALESCE(inequality_columns, SPACE(0)) as indexed_columns
            ,included_columns
        FROM sys.dm_db_missing_index_details mid
            INNER JOIN sys.dm_db_missing_index_groups mig ON mid.index_handle = mig.index_handle
            INNER JOIN sys.dm_db_missing_index_group_stats migs ON mig.index_group_handle = migs.group_handle
        WHERE mid.database_id = @DB_ID
    END

    -- Collect foreign key information.
    IF OBJECT_ID('tempdb..#ForeignKeys') IS NOT NULL
        DROP TABLE #ForeignKeys

    CREATE TABLE #ForeignKeys
        (
        foreign_key_name NVARCHAR(256)
        ,object_id INT
        ,fk_columns NVARCHAR(max)
        ,fk_columns_ids NVARCHAR(1024)
        )
		
     SET @SQL = N'SELECT fk.name + ''|PARENT'' AS foreign_key_name
        ,fkc.parent_object_id AS object_id
        ,STUFF((SELECT '', '' + QUOTENAME(c.name)
            FROM '+@DatabaseName+'.sys.foreign_key_columns ifkc
                INNER JOIN '+@DatabaseName+'.sys.columns c ON ifkc.parent_object_id = c.object_id AND ifkc.parent_column_id = c.column_id
            WHERE fk.object_id = ifkc.constraint_object_id
            ORDER BY ifkc.constraint_column_id
            FOR XML PATH('''')), 1, 2, '''') AS fk_columns
        ,(SELECT QUOTENAME(CAST(ifkc.parent_column_id AS VARCHAR(10))+''+'',''('')
            FROM '+@DatabaseName+'.sys.foreign_key_columns ifkc
            WHERE fk.object_id = ifkc.constraint_object_id
            ORDER BY ifkc.constraint_column_id
            FOR XML PATH('''')) AS fk_columns_compare
    FROM '+@DatabaseName+'.sys.foreign_keys fk
        INNER JOIN '+@DatabaseName+'.sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
    WHERE fkc.constraint_column_id = 1
    AND (fkc.parent_object_id = @ObjectID OR @ObjectID IS NULL)
    UNION ALL
    SELECT fk.name + ''|REFERENCED'' as foreign_key_name
        ,fkc.referenced_object_id AS object_id
        ,STUFF((SELECT '', '' + QUOTENAME(c.name)
            FROM '+@DatabaseName+'.sys.foreign_key_columns ifkc
                INNER JOIN '+@DatabaseName+'.sys.columns c ON ifkc.referenced_object_id = c.object_id AND ifkc.referenced_column_id = c.column_id
            WHERE fk.object_id = ifkc.constraint_object_id
            ORDER BY ifkc.constraint_column_id
            FOR XML PATH('''')), 1, 2, '''') AS fk_columns
        ,(SELECT QUOTENAME(CAST(ifkc.referenced_column_id AS VARCHAR(10))+''+'',''('')
            FROM '+@DatabaseName+'.sys.foreign_key_columns ifkc
            WHERE fk.object_id = ifkc.constraint_object_id
            ORDER BY ifkc.constraint_column_id
            FOR XML PATH('''')) AS fk_columns_compare
    FROM '+@DatabaseName+'.sys.foreign_keys fk
        INNER JOIN '+@DatabaseName+'.sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
    WHERE fkc.constraint_column_id = 1
    AND (fkc.referenced_object_id = @ObjectID OR @ObjectID IS NULL)'

    BEGIN TRY
        INSERT INTO #ForeignKeys
            (foreign_key_name, object_id, fk_columns, fk_columns_ids)
        EXEC sp_executesql @SQL, N'@DB_ID INT, @ObjectID INT', @DB_ID = @DB_ID, @ObjectID = @ObjectID
    END TRY
    BEGIN CATCH
        SELECT @ERROR_MESSAGE  = 'Populate #ForeignKeys (Line '+CAST(ERROR_LINE() AS NVARCHAR(25))+'): ' + ERROR_MESSAGE()
            ,@ERROR_SEVERITY = ERROR_SEVERITY()
            ,@ERROR_STATE = ERROR_STATE()
    
        RAISERROR(@ERROR_MESSAGE, @ERROR_SEVERITY, @ERROR_STATE)
    END CATCH 

    -- Determine duplicate, overlapping, and foreign key index information
    UPDATE i
    SET duplicate_indexes = STUFF((SELECT ', ' + index_name AS [data()]
            FROM #IndexStatistics iibl
            WHERE i.object_id = iibl.object_id
            AND i.is_primary_key = iibl.is_primary_key
            AND i.is_unique = iibl.is_unique
            AND ISNULL(i.filter_definition,'') = ISNULL(iibl.filter_definition,'')
            AND i.index_id <> iibl.index_id
            AND REPLACE(i.indexed_columns_ids,'|','')  = REPLACE(iibl.indexed_columns_ids,'|','') 
            AND i.included_column_ids = iibl.included_column_ids
            FOR XML PATH('')), 1, 2, '')
        ,first_dup_index_id = (SELECT MIN(index_id)
            FROM #IndexStatistics iibl
            WHERE i.object_id = iibl.object_id
            AND i.is_primary_key = iibl.is_primary_key
            AND i.is_unique = iibl.is_unique
            AND ISNULL(i.filter_definition,'') = ISNULL(iibl.filter_definition,'')
            AND i.index_id > iibl.index_id
            AND REPLACE(i.indexed_columns_ids,'|','') = REPLACE(iibl.indexed_columns_ids,'|','')
            AND i.included_column_ids = iibl.included_column_ids)
        ,overlapping_indexes = STUFF((SELECT ', ' + index_name AS [data()]
            FROM #IndexStatistics iibl
            WHERE i.object_id = iibl.object_id
            AND i.is_primary_key = iibl.is_primary_key
            AND i.is_unique = iibl.is_unique
            AND ISNULL(i.filter_definition,'') = ISNULL(iibl.filter_definition,'')
            AND i.index_id <> iibl.index_id
            AND LEFT(i.indexed_columns_ids, CHARINDEX('|',iibl.indexed_columns_ids,1)-1) 
                LIKE LEFT(iibl.indexed_columns_ids, CHARINDEX('|',i.indexed_columns_ids,1)-1) + '%'
            AND Replace(i.indexed_columns_ids,'|','') <> Replace(iibl.indexed_columns_ids,'|','')
            FOR XML PATH('')), 1, 2, '')
        ,related_foreign_keys = STUFF((SELECT ', ' + foreign_key_name AS [data()]
            FROM #ForeignKeys ifk
            WHERE ifk.object_id = i.object_id
            AND i.indexed_columns_ids LIKE ifk.fk_columns_ids + '%'
            FOR XML PATH('')), 1, 2, '')
        ,related_foreign_keys_xml = CAST((SELECT foreign_key_name
            FROM #ForeignKeys fk
            WHERE fk.object_id = i.object_id
            AND i.indexed_columns_ids LIKE fk.fk_columns_ids + '%'
            FOR XML AUTO) as xml)  
    FROM #IndexStatistics i
    
    IF @IncludeMissingFKIndexes = 1
    BEGIN
        INSERT INTO #IndexStatistics
            (filegroup_name, schema_id, schema_name, object_id, table_name, index_name, type_desc, index_rank, indexed_columns, related_foreign_keys)
        SELECT '' AS filegroup_name
            ,SCHEMA_ID(OBJECT_SCHEMA_NAME(fk.object_id)) AS schema_id
            ,OBJECT_SCHEMA_NAME(fk.object_id) AS schema_name
            ,fk.object_id
            ,OBJECT_NAME(fk.object_id) AS table_name
            ,'--MISSING FOREIGN KEY--' AS index_name
            ,'NONCLUSTERED' AS type_desc
            ,9999
            ,fk.fk_columns
            ,fk.foreign_key_name
        FROM #ForeignKeys fk 
            LEFT OUTER JOIN #IndexStatistics i ON fk.object_id = i.object_id AND i.indexed_columns_ids LIKE fk.fk_columns_ids + '%'
        WHERE i.index_name IS NULL
    END
	
	-- Determine whether tables have unique indexes
    UPDATE i
    SET has_unique = 1
    FROM #IndexStatistics i
    WHERE EXISTS (SELECT * FROM #IndexStatistics ii WHERE i.object_id = ii.object_id AND ii.is_unique = 1)

    -- Calculate estimated user total for each index.
    ;WITH Aggregation
    AS (
        SELECT row_id
            ,CAST(100. * (user_seeks + user_scans + user_lookups)
                /(NULLIF(SUM(user_seeks + user_scans + user_lookups) 
                OVER(PARTITION BY schema_name, table_name), 0) * 1.) as DECIMAL(12,2)) AS estimated_user_total_pct
            ,SUM(buffered_mb) OVER(PARTITION BY schema_name, table_name) as table_buffered_mb
        FROM #IndexStatistics 
    )
    UPDATE ibl
    SET estimated_user_total_pct = COALESCE(a.estimated_user_total_pct, 0)
        ,table_buffered_mb = a.table_buffered_mb
    FROM #IndexStatistics ibl
        INNER JOIN Aggregation a ON ibl.row_id = a.row_id

    -- Update Index Action information
    ;WITH IndexAction
    AS (
        SELECT row_id
            ,CASE WHEN user_lookups > user_seeks AND type_desc IN ('CLUSTERED', 'HEAP', 'UNIQUE CLUSTERED') THEN 'REALIGN'
                WHEN is_disabled = 1 THEN 'ENABLE'
                WHEN duplicate_indexes IS NOT NULL AND first_dup_index_id IS NOT NULL AND index_id IS NOT NULL THEN 'DROP-DUP' 
                WHEN type_desc = '--MISSING FOREIGN KEY--' THEN 'CREATE'
                WHEN type_desc = 'XML' THEN '---'
                WHEN is_unique = 1 THEN '---'
                WHEN related_foreign_keys IS NOT NULL THEN '---'
                WHEN type_desc = '--NONCLUSTERED--' AND ROW_NUMBER() OVER (PARTITION BY table_name ORDER BY user_total desc) <= 10 AND estimated_user_total_pct > 1 THEN 'CREATE'
                WHEN type_desc = '--NONCLUSTERED--' THEN 'BLEND'
                WHEN ROW_NUMBER() OVER (PARTITION BY table_name ORDER BY user_total desc, index_rank) > 10 AND index_id IS NOT NULL THEN 'DROP-COUNT'
                WHEN index_id NOT IN (0,1) AND duplicate_indexes IS NULL AND user_total = 0 AND index_id IS NOT NULL  
                    THEN 'DROP-USAGE' 
                ELSE '---' END AS index_action
        FROM #IndexStatistics
    )
    UPDATE ibl
    SET index_action = ia.index_action
    FROM #IndexStatistics ibl INNER JOIN IndexAction ia
    ON ibl.row_id = ia.row_id

    -- Update Pro/Con statuses
    UPDATE #IndexStatistics
    SET index_pros = COALESCE(STUFF(CASE WHEN related_foreign_keys IS NOT NULL THEN ', FK' ELSE '' END
            + CASE WHEN is_unique = 1 THEN ', UQ' ELSE '' END
            + COALESCE(', ' + CASE WHEN read_to_update BETWEEN 1 AND 9 THEN '$'
                WHEN read_to_update BETWEEN 10 AND 99 THEN '$$'
                WHEN read_to_update BETWEEN 100 AND 999 THEN '$$$'
                WHEN read_to_update > 999 THEN '$$$+' END, '')
            ,1,2,''),'')
        ,index_cons = COALESCE(STUFF(CASE WHEN user_seeks / NULLIF(user_scans,0) < 1000 THEN ', SCN' ELSE '' END
            + CASE WHEN duplicate_indexes IS NOT NULL THEN ', DP' ELSE '' END
            + CASE WHEN overlapping_indexes IS NOT NULL THEN ', OV' ELSE '' END
            + COALESCE(', ' + CASE WHEN update_to_read BETWEEN 1 AND 9 THEN '$'
                WHEN update_to_read BETWEEN 10 AND 99 THEN '$$'
                WHEN update_to_read BETWEEN 100 AND 999 THEN '$$$'
                WHEN update_to_read > 999 THEN '$$$+' END, '')
            + CASE WHEN is_disabled = 1 THEN ', DSB' ELSE '' END
            ,1,2,''),'')

IF @Output = 'DETAILED'
BEGIN
    SELECT
        index_action
        , index_pros
        , index_cons
        , QUOTENAME(schema_name) + '.' + QUOTENAME(table_name) as object_name
        , index_name
        , type_desc
        , indexed_columns
        , included_columns
        , filter_definition
        , is_primary_key
        , is_unique
        , is_disabled
        , has_unique
        , partition_number
        , fill_factor
        , is_padded
        , size_in_mb
        , buffered_mb
        , table_buffered_mb
        , buffered_percent
        , row_count
        , user_total_pct
        , estimated_user_total_pct
        , missing_index_impact
        , user_total
        , user_seeks
        , user_scans
        , user_lookups
        , user_updates
        , read_to_update_ratio
        , read_to_update
        , update_to_read
        , row_lock_count
        , row_lock_wait_count
        , row_lock_wait_in_ms
        , row_block_pct
        , avg_row_lock_waits_ms
        , page_latch_wait_count
        , avg_page_latch_wait_ms
        , page_io_latch_wait_count
        , avg_page_io_latch_wait_ms
        , tree_page_latch_wait_count
        , avg_tree_page_latch_wait_ms
        , tree_page_io_latch_wait_count
        , avg_tree_page_io_latch_wait_ms
        , read_operations
        , leaf_writes
        , leaf_page_allocations
        , leaf_page_merges
        , nonleaf_writes
        , nonleaf_page_allocations
        , nonleaf_page_merges
        , duplicate_indexes
        , overlapping_indexes
        , related_foreign_keys
        , related_foreign_keys_xml
        , key_columns
		, data_columns
    FROM #IndexStatistics
    WHERE (estimated_user_total_pct > 0.01 AND index_id IS NULL)
    OR related_foreign_keys IS NOT NULL
    OR index_id IS NOT NULL
    ORDER BY table_buffered_mb DESC, object_id, COALESCE(user_total,-1) DESC, COALESCE(user_updates,-1) DESC, COALESCE(index_id,999)
END
ELSE IF @Output = 'DUPLICATE'
BEGIN
    SELECT
		DENSE_RANK() OVER (ORDER BY key_columns, data_columns) AS duplicate_group
        , index_action
        , index_pros
        , index_cons
        , QUOTENAME(schema_name) + '.' + QUOTENAME(table_name) as object_name
        , index_name
        , type_desc
        , indexed_columns
        , included_columns
        , is_primary_key
        , is_unique
        , duplicate_indexes
        , size_in_mb
        , buffered_mb
        , table_buffered_mb
        , buffered_percent
        , row_count
        , user_total_pct
        , user_total
        , user_seeks
        , user_scans
        , user_lookups
        , user_updates
        , read_operations
    FROM #IndexStatistics
    WHERE duplicate_indexes IS NOT NULL
    ORDER BY table_buffered_mb DESC, object_id, RANK() OVER (ORDER BY key_columns, data_columns)
END
ELSE IF @Output = 'OVERLAPPING'
BEGIN
    SELECT 
        index_action
        , index_pros
        , index_cons
        , QUOTENAME(schema_name) + '.' + QUOTENAME(table_name) as object_name
        , overlapping_indexes      
        , index_name
        , type_desc
        , indexed_columns
        , included_columns
        , is_primary_key
        , is_unique
        , size_in_mb
        , buffered_mb
        , table_buffered_mb
        , buffered_percent
        , row_count
        , user_total_pct
        , user_total
        , user_seeks
        , user_scans
        , user_lookups
        , user_updates
        , read_operations
    FROM #IndexStatistics
    WHERE overlapping_indexes IS NOT NULL
    ORDER BY table_buffered_mb DESC, object_id, user_total DESC
END

END TRY
BEGIN CATCH
    SELECT @ERROR_MESSAGE  = 'Procedure Error (Line '+CAST(ERROR_LINE() AS NVARCHAR(25))+'): ' + ERROR_MESSAGE()
        ,@ERROR_SEVERITY = ERROR_SEVERITY()
        ,@ERROR_STATE = ERROR_STATE()
    
    RAISERROR(@ERROR_MESSAGE, @ERROR_SEVERITY, @ERROR_STATE)
END CATCH
GO

USE AdventureWorks2012
GO

EXEC dbo.sp_IndexAnalysis @Output = 'DETAILED'
,@TableName = '[Production].[ProductDescription]'
,@IncludeMissingIndexes = 1
,@IncludeMissingFKIndexes = 1

EXEC dbo.sp_IndexAnalysis @Output = 'OVERLAPPING'
,@TableName = '[Production].[ProductDescription]'
,@IncludeMissingIndexes = 1
,@IncludeMissingFKIndexes = 1

