USE master
GO
IF (OBJECT_ID('dbo.sp_ctrl3') IS NOT NULL)
	DROP PROCEDURE dbo.sp_ctrl3;
GO
/*

Copyright Daniel Hutmacher under Creative Commons 4.0 license with attribution.
http://creativecommons.org/licenses/by/4.0/

Source: http://sqlsunday.com/downloads/

DISCLAIMER: This script may not be suitable to run in a production
            environment. I cannot assume any responsibility regarding
            the accuracy of the output information, performance
            impacts on your server, or any other consequence. If
            your juristiction does not allow for this kind of
            waiver/disclaimer, or if you do not accept these terms,
            you are NOT allowed to store, distribute or use this
            code in any way.

USAGE:      EXECUTE ctrl3 {object name}

SHORTCUT:   In SQL Server Management Studio, go to Tools -> Options
            -> Environment -> Keyboard -> Query Shortcuts.
            
            On a shortcut location of your choice, enter the following
            code, with the trailing space, without the quotes:
            "EXECUTE sp_ctrl3 ". To use, highlight the name of an object
            and press that keyboard shortcut. You may have to open a new
            query for the change to take effect. Also, objects denoted by
            schema (with a dot) need to be enclosed in quotes for this
            to work.

VERSION:    2016-07-26

*/

CREATE PROCEDURE dbo.sp_ctrl3
	@objname	sysname
WITH EXECUTE AS CALLER
AS

SET NOCOUNT ON;
SET STATISTICS XML, TIME, IO OFF;
SET DEADLOCK_PRIORITY LOW;
SET STATISTICS XML OFF;
SET LOCK_TIMEOUT 500;

DECLARE @object_id              int,
        @object_id_str          varchar(10),
        @database_id            int,
        @database               sysname,
        @rowcount               bigint=0,
        @has_cols_or_params     bit,
        @has_indexes            bit,
	    @has_foreign_keys       bit,
	    @has_references         bit,
	    @has_permissions        bit,
	    @has_sql_module         bit,
	    @has_data               bit,
	    @is_tempdb              bit=0,
        @module_definition      nvarchar(max),
        @uses_ansi_nulls        bit,
	    @uses_quoted_identifier bit,
        @temp                   nvarchar(max);

--- These are special (unicode) characters, used to display the graph output:
DECLARE @inf  nchar(1)=NCHAR(8734),          --- Infinity symbol
        @hyph nchar(1)=NCHAR(8722),          --- Hyphen
        @pipe nchar(1)=NCHAR(8739),          --- Pipe
	    @zero nchar(1)=NCHAR(176),           --- Superscript "0".
	    @one  nchar(1)=NCHAR(185),           --- Superscript "1".
        @lf   nchar(1)=NCHAR(10),            --- Line feed
        @cr   nchar(1)=NCHAR(13);            --- Carriage return

SET @object_id=OBJECT_ID(@objname);
IF (@objname LIKE '#%')
    SELECT @is_tempdb=1, @object_id=OBJECT_ID('tempdb.dbo.'+@objname);

IF (@object_id IS NULL)
    SELECT @object_id=tt.type_table_object_id
    FROM sys.table_types AS tt
    WHERE tt.user_type_id=TYPE_ID(@objname);

SELECT @database_id=database_id, @database=name
FROM sys.databases
WHERE @objname LIKE '#%' AND name='tempdb' OR
      @objname LIKE '\[%\].%' ESCAPE '\' AND @objname LIKE '%.%.%' AND name=SUBSTRING(@objname, 2, NULLIF(CHARINDEX('].', @objname), 0)-2) OR
      @objname NOT LIKE '[\[#]%' ESCAPE '\' AND @objname LIKE '%.%.%' AND name=LEFT(@objname, NULLIF(CHARINDEX('.', @objname), 0)-1) OR
      @objname NOT LIKE '%.%.%' AND @objname NOT LIKE '#%' AND database_id=DB_ID();

SET @object_id_str=CAST(@object_id AS varchar(10));
/*
IF (@object_id<0) BEGIN;
    PRINT 'System objects are not supported.';
    RETURN;
END;
*/
-------------------------------------------------------------------------------
--- If database object isn't found, try a plaintext search instead.

IF (@object_id IS NULL) BEGIN;

    WITH rcte AS (
        SELECT [object_id], 0 AS line, CAST(NULL AS nvarchar(max)) AS [sql], REPLACE([definition], CHAR(13)+CHAR(10), CHAR(13)) AS remain
        FROM sys.sql_modules
        WHERE [definition] LIKE N'%'+@objname+'%'

        UNION ALL

        SELECT [object_id], line+1,
               CAST(LEFT(remain, PATINDEX(N'%['+CHAR(10)+CHAR(13)+']%', remain)-1) AS nvarchar(max)),
               CAST(SUBSTRING(remain, PATINDEX(N'%['+CHAR(10)+CHAR(13)+']%', remain)+1, LEN(remain)) AS nvarchar(max))
        FROM rcte
        WHERE remain LIKE N'%'+@objname+'%')

    SELECT o.type_desc AS [Type], s.name+N'.'+o.name AS [Object], STR(line, 5, 0) AS [Line no], [sql] AS [Definition]
    FROM rcte
    INNER JOIN sys.objects AS o ON rcte.[object_id]=o.[object_id]
    INNER JOIN sys.schemas AS s ON o.[schema_id]=s.[schema_id]
    WHERE rcte.[sql] LIKE '%'+@objname+'%'

    UNION ALL

    SELECT t.type_desc, s.name+N'.'+t.name, '', ISNULL(c.name, '')
    FROM sys.tables AS t
    INNER JOIN sys.schemas AS s ON t.[schema_id]=s.[schema_id]
    LEFT JOIN sys.columns AS c ON t.[object_id]=c.[object_id] AND c.name LIKE '%'+@objname+'%'
    WHERE t.name LIKE '%'+@objname+'%' OR c.name LIKE '%'+@objname+'%'

    ORDER BY [Object], [Line no]
    OPTION (MAXRECURSION 0);

    RETURN;
END;

-------------------------------------------------------------------------------
--- Table variables to hold copies of system DMVs. The reason we use temp tables
--- is to be able to collect this data from the current database or from
--- tempdb (if it's a temp table)

DECLARE @sysobjects TABLE (
    [schema_id]   int NOT NULL,
    [object_id]   int NOT NULL,
    principal_id  int NULL,
    [type]        char(2) NOT NULL,
    name          sysname NOT NULL,
    PRIMARY KEY CLUSTERED ([object_id])
);

DECLARE @sysschemas TABLE (
    [schema_id]       int NOT NULL,
    principal_id      int NOT NULL,
    name              sysname NOT NULL,
    PRIMARY KEY CLUSTERED ([schema_id])
);

DECLARE @syscolumns TABLE (
    [object_id]       int NOT NULL,
    column_id         int NOT NULL,
    name              sysname NOT NULL,
    user_type_id      int NOT NULL,
    system_type_id    int NOT NULL,
    max_length        smallint NOT NULL,
    [precision]       tinyint NOT NULL,
    scale             tinyint NOT NULL,
    is_sparse         bit NULL,
    is_nullable       bit NULL,
    collation_name    sysname NULL,
    is_ansi_padded    bit NOT NULL,
    xml_collection_id int NOT NULL,
    default_object_id int NOT NULL,
    seed_value        sql_variant NULL,
    increment_value   sql_variant NULL,
    [definition]      nvarchar(max) NULL,
    is_persisted      bit NULL,
    [type_name]       sysname NOT NULL,
    default_name      sysname NULL,
    default_is_system_named bit NULL,
    current_value     sql_variant NULL,
    PRIMARY KEY CLUSTERED ([object_id], column_id)
);

DECLARE @sysparameters TABLE (
    parameter_id      int NOT NULL,
    name              sysname NOT NULL,
    user_type_id      int NOT NULL,
    system_type_id    int NOT NULL,
    max_length        smallint NOT NULL,
    [precision]       tinyint NOT NULL,
    scale             tinyint NOT NULL,
    is_nullable       bit NULL,
    xml_collection_id int NOT NULL,
    is_output         bit NOT NULL,
    is_readonly       bit NOT NULL,
    is_table_type     bit NOT NULL,
    [type_name]       sysname NOT NULL,
    tbl_type_cols     varchar(max) NULL,
    PRIMARY KEY CLUSTERED (parameter_id)
);

DECLARE @sysindexes TABLE (
    [object_id]          int NOT NULL,
    index_id             int NOT NULL,
    name                 sysname NULL,
    [type]               tinyint NOT NULL,
    [type_desc]          nvarchar(120) NULL,
    data_space_id        int NULL,
    is_primary_key       bit NULL,
    is_unique_constraint bit NULL,
    is_unique            bit NULL,
    filter_definition    nvarchar(max) NULL,
    fill_factor          tinyint NOT NULL,
    [allow_row_locks]    bit NULL,
    [allow_page_locks]	 bit NULL,
    is_padded	      	 bit NULL,
    has_filter	     	 bit NULL,
    is_system_named      bit NOT NULL,
    PRIMARY KEY CLUSTERED ([object_id], index_id)
);

DECLARE @sysindexcolumns TABLE (
    [object_id]        int NOT NULL,
    index_id           int NOT NULL,
    index_column_id    int NOT NULL,
    column_id          int NOT NULL,
    key_ordinal        tinyint NOT NULL,
    partition_ordinal  tinyint NOT NULL,
    is_descending_key  bit NULL,
    is_included_column bit NULL,
    PRIMARY KEY CLUSTERED ([object_id], index_id, key_ordinal, index_column_id)
);

DECLARE @sysforeignkeys TABLE (
    [object_id]                    int NOT NULL,
    name                           sysname NOT NULL,
    parent_object_id               int NOT NULL,
    referenced_object_id           int NOT NULL,
    delete_referential_action_desc nvarchar(120) NULL,
    update_referential_action_desc nvarchar(120) NULL,
    is_system_named                bit NOT NULL,
    is_disabled                    bit NOT NULL,
    is_not_trusted                 bit NOT NULL,
    PRIMARY KEY CLUSTERED ([object_id])
);

DECLARE @sysforeignkeycols TABLE (
    constraint_object_id  int NOT NULL,
    constraint_column_id  int NOT NULL,
    parent_object_id      int NOT NULL,
    parent_column_id      int NOT NULL,
    referenced_object_id  int NOT NULL,
    referenced_column_id  int NOT NULL,
    PRIMARY KEY CLUSTERED (constraint_object_id, constraint_column_id)
);


DECLARE @xmlschemacollections TABLE (
    xml_collection_id    int NOT NULL,
    [schema_id]          int NOT NULL,
    name                 sysname NOT NULL,
    PRIMARY KEY CLUSTERED (xml_collection_id)
);

DECLARE @sysdataspaces TABLE (
    data_space_id    int NOT NULL,
    name             sysname NOT NULL,
    [type]           char(2) NOT NULL,
    is_default       bit NOT NULL,
    PRIMARY KEY CLUSTERED (data_space_id)
);

DECLARE @sysdatabaseprincipals TABLE (
    principal_id     int NOT NULL,
    name             sysname NOT NULL
);

DECLARE @sysexprdependencies TABLE (
    referencing_id            int NOT NULL,
    referenced_id             int NOT NULL,
    is_schema_bound_reference bit NOT NULL,
    PRIMARY KEY CLUSTERED (referencing_id, referenced_id)
);

DECLARE @syspartitions TABLE (
    [partition_id]   bigint NULL,
    [object_id]      int NOT NULL,
    index_id         int NOT NULL,
    partition_number int NOT NULL,
    [rows]           bigint NULL,
    data_compression_desc nvarchar(120) NOT NULL,
    PRIMARY KEY CLUSTERED ([object_id], index_id, partition_number)
);

DECLARE @syspartitionstats TABLE (
    [partition_id]               bigint NOT NULL,
    row_count                    bigint NULL,
    in_row_used_page_count       bigint NULL,
    reserved_page_count          bigint NULL,
    row_overflow_used_page_count bigint NULL,
    lob_used_page_count          bigint NULL,
    used_page_count              bigint NULL,
    PRIMARY KEY CLUSTERED ([partition_id])
);

DECLARE @sysdatabasepermissions TABLE (
    class                tinyint NOT NULL,
    class_desc           nvarchar(120) NULL,
    major_id             int NOT NULL,
    minor_id             int NOT NULL,
    grantee_principal_id int NOT NULL,
    grantor_principal_id int NOT NULL,
    [type]               char(4) NOT NULL,
    [permission_name]    nvarchar(256) NULL,
    [state]              char(1) NOT NULL,
    state_desc           nvarchar(120) NULL,
    PRIMARY KEY CLUSTERED (class, major_id, minor_id, [type], [state], grantee_principal_id)
);

DECLARE @references TABLE (
    parent_id      int NOT NULL,         --- object_id of referencing object
    parent_name    varchar(255) NOT NULL, -- Name of referencing object
    child_id       int NOT NULL,         --- object_id of referenced object
    child_name     varchar(255) NOT NULL, -- Name of referenced object
    is_schemabound bit,                  --- Is this relation schemabound?
    is_foreign_key bit,                  --- Is this relation a foreign key constraint? (If not, it's an SQL module)
    parent_row     tinyint NOT NULL,     --- Parent ordinal (this child)
    parent_count   tinyint NOT NULL,     --- Number of parents (this child)
    child_row      tinyint NOT NULL,     --- Child ordinal (this parent)
    child_count    tinyint NOT NULL,     --- Number of children (this parent)
    is_unique      bit NOT NULL,         --- If the combination of referencing columns is unique
    is_nullable    bit NOT NULL,         --- If the referencing column allows nulls
    PRIMARY KEY CLUSTERED (parent_id, child_id),
    UNIQUE (parent_id, child_row),
    UNIQUE (child_id, parent_row)
);

DECLARE @sysindexphysicalstats TABLE (
    [object_id]             int NOT NULL,
    index_id                int NOT NULL,
    partition_number        int NOT NULL,
    alloc_unit_type_desc    nvarchar(60) NOT NULL,
    index_depth             tinyint NOT NULL,
    index_level             tinyint NOT NULL,
    avg_fragmentation_in_percent float NULL,
    min_record_size_in_bytes int NULL,
    max_record_size_in_bytes int NULL,
    avg_record_size_in_bytes int NULL,
    PRIMARY KEY CLUSTERED ([object_id], index_id, partition_number, alloc_unit_type_desc, index_level)
);

DECLARE @syssqlmodules TABLE (
    [definition]        nvarchar(max) NULL,
    uses_ansi_nulls     bit NULL,
    uses_quoted_identifier bit NULL
);

DECLARE @systriggers TABLE (
    [object_id]     int NOT NULL,
    name            sysname NOT NULL,
    is_disabled     bit NOT NULL,
    is_instead_of_trigger bit NOT NULL,
    [trigger_events]  sysname NOT NULL,
    PRIMARY KEY CLUSTERED ([object_id])
);


-------------------------------------------------------------------------------
--- Populate DMV table variables:

INSERT INTO @sysobjects
EXEC('
SELECT ISNULL(tt.[schema_id], o.[schema_id]), o.[object_id], o.principal_id, o.[type], ISNULL(tt.name, o.name)
FROM '+@database+'.sys.objects AS o
LEFT JOIN '+@database+'.sys.table_types AS tt ON tt.type_table_object_id=o.[object_id]');

INSERT INTO @sysschemas
EXEC('
SELECT [schema_id], principal_id, name
FROM '+@database+'.sys.schemas');

INSERT INTO @syscolumns
EXEC('
SELECT c.[object_id], c.column_id, c.name, c.user_type_id, c.system_type_id,
        c.max_length, c.[precision], c.scale, c.is_sparse, c.is_nullable,
        c.collation_name, c.is_ansi_padded, c.xml_collection_id, c.default_object_id,
        ic.seed_value, ic.increment_value, ISNULL(cc.[definition], d.[definition]), cc.is_persisted,
        t.name AS [type_name], d.name AS default_name,
        d.is_system_named AS default_is_system_named, NULL AS current_value
FROM '+@database+'.sys.columns AS c
LEFT JOIN '+@database+'.sys.identity_columns AS ic ON c.[object_id]=ic.[object_id] AND c.column_id=ic.column_id
LEFT JOIN '+@database+'.sys.computed_columns AS cc ON c.[object_id]=cc.[object_id] AND c.column_id=cc.column_id
LEFT JOIN '+@database+'.sys.types AS t ON c.user_type_id=t.user_type_id
LEFT JOIN '+@database+'.sys.default_constraints AS d ON d.[object_id]=c.default_object_id');

BEGIN TRY;
    INSERT INTO @syscolumns
    EXEC('
    SELECT s.[object_id], 1 AS column_id, s.name, s.user_type_id, s.system_type_id,
           8 AS max_length, s.[precision], s.scale, 0 AS is_sparse, 0 AS is_nullable,
           NULL AS collation_name, 0 AS is_ansi_padded, 0 AS xml_collection_id, 0 AS default_object_id,
           s.start_value AS seed_value, s.increment AS increment_value,
       
           ISNULL('' MINVALUE ''+CAST(NULLIF(s.minimum_value, (CASE st.name
                WHEN ''tinyint'' THEN 0
                WHEN ''smallint'' THEN -32768
                WHEN ''int'' THEN -2147483648
                WHEN ''bigint'' THEN -9223372036854775808
            END)) AS varchar(40)), '''')+
            ISNULL('' MAXVALUE ''+CAST(NULLIF(s.maximum_value, (CASE st.name
                WHEN ''tinyint'' THEN 255
                WHEN ''smallint'' THEN 32767
                WHEN ''int'' THEN 2147483647
                WHEN ''bigint'' THEN 9223372036854775807
            END)) AS varchar(40)), '''')+
            (CASE WHEN s.is_cycling=1 THEN '' CYCLE'' ELSE '''' END)+
            (CASE WHEN s.is_cached=0 THEN '' NOCACHE''
                  WHEN s.is_cached=1 THEN ISNULL(''CACHE ''+CAST(s.cache_size AS varchar(10)), '''')
                  END) AS [definition], 0 AS is_persisted,
           t.name AS [type_name], NULL AS default_name, 1 AS default_is_system_named, s.current_value
    FROM '+@database+'.sys.sequences AS s
    LEFT JOIN '+@database+'.sys.types AS t ON s.user_type_id=t.user_type_id
    LEFT JOIN '+@database+'.sys.types AS st ON s.system_type_id=st.user_type_id
    ');
END TRY
BEGIN CATCH;
    PRINT 'sys.sequences could not be loaded.';
END CATCH;


SET @temp=(CASE WHEN SERVERPROPERTY('ProductVersion')>='12' THEN 'p.is_nullable' ELSE '1' END);

INSERT INTO @sysparameters
EXEC('
SELECT p.parameter_id, p.name, p.user_type_id, p.system_type_id, p.max_length, p.[precision],
        p.scale, '+@temp+', p.xml_collection_id, p.is_output, p.is_readonly, t.is_table_type,
        ISNULL(s.name+''.'', '''')+t.name AS [type_name],
	''(''+SUBSTRING(CAST((SELECT '', ''+ttc.name
	FROM '+@database+'.sys.columns AS ttc
	WHERE ttc.[object_id]=tt.type_table_object_id
	ORDER BY ttc.column_id
	FOR XML PATH(''''), TYPE) AS varchar(max)), 3, 8000)+'')'' AS tbl_type_cols
FROM '+@database+'.sys.parameters AS p
LEFT JOIN '+@database+'.sys.types AS t ON p.user_type_id=t.user_type_id
LEFT JOIN '+@database+'.sys.table_types AS tt ON t.user_type_id=tt.user_type_id
LEFT JOIN '+@database+'.sys.schemas AS s ON t.is_table_type=1 AND t.[schema_id]=s.[schema_id]
WHERE p.[object_id]='+@object_id_str);


INSERT INTO @sysindexes
EXEC('
SELECT ix.[object_id], ix.index_id, ix.name, ix.[type], ix.type_desc, ix.data_space_id,
        ix.is_primary_key, ix.is_unique_constraint, ix.is_unique, ix.filter_definition,
        ix.fill_factor, ix.[allow_row_locks], ix.[allow_page_locks], ix.is_padded, ix.has_filter,
	ISNULL(kc.is_system_named, 0)
FROM '+@database+'.sys.indexes AS ix
LEFT JOIN '+@database+'.sys.key_constraints AS kc ON ix.[object_id]=kc.parent_object_id AND ix.name=kc.name
WHERE ix.is_hypothetical=0');

INSERT INTO @sysindexcolumns
EXEC('
SELECT [object_id], index_id, index_column_id, column_id, key_ordinal,
        partition_ordinal, is_descending_key, is_included_column
FROM '+@database+'.sys.index_columns');

INSERT INTO @sysforeignkeys
EXEC('
SELECT [object_id], name, parent_object_id, referenced_object_id,
        delete_referential_action_desc, update_referential_action_desc,
        is_system_named, is_disabled, is_not_trusted
FROM '+@database+'.sys.foreign_keys');

INSERT INTO @sysforeignkeycols
EXEC('
SELECT constraint_object_id, constraint_column_id, parent_object_id,
        parent_column_id, referenced_object_id, referenced_column_id
FROM '+@database+'.sys.foreign_key_columns');

INSERT INTO @xmlschemacollections
EXEC('
SELECT xml_collection_id, [schema_id], name
FROM '+@database+'.sys.xml_schema_collections');

INSERT INTO @sysdataspaces
EXEC('
SELECT data_space_id, name, [type], is_default
FROM '+@database+'.sys.data_spaces');

INSERT INTO @sysdatabaseprincipals
EXEC('
SELECT principal_id, name
FROM '+@database+'.sys.database_principals');

INSERT INTO @syssqlmodules
EXEC('
SELECT [definition], uses_ansi_nulls, uses_quoted_identifier
FROM '+@database+'.sys.sql_modules
WHERE [object_id]='+@object_id_str);

SELECT @module_definition=[definition],
       @uses_ansi_nulls=uses_ansi_nulls,
       @uses_quoted_identifier=uses_quoted_identifier
FROM @syssqlmodules;

INSERT INTO @sysexprdependencies
EXEC('
SELECT DISTINCT d.referencing_id,
                ISNULL(ct.type_table_object_id, d.referenced_id),
                (CASE WHEN ct.user_type_id IS NOT NULL THEN 1 ELSE d.is_schema_bound_reference END)
FROM '+@database+'.sys.sql_expression_dependencies AS d
LEFT JOIN '+@database+'.sys.table_types AS ct ON d.referenced_class=6  AND d.referenced_id =ct.user_type_id
WHERE d.referencing_class=1 AND
      d.referenced_class IN (1, 6) AND referenced_id IS NOT NULL');

INSERT INTO @syspartitions
EXEC('
SELECT [partition_id], [object_id], index_id, partition_number, [rows], data_compression_desc
FROM '+@database+'.sys.partitions');

INSERT INTO @syspartitionstats
EXEC('
SELECT ps.[partition_id], ps.row_count, ps.in_row_used_page_count, ps.reserved_page_count,
       ps.row_overflow_used_page_count, ps.lob_used_page_count, ps.used_page_count
FROM '+@database+'.sys.dm_db_partition_stats AS ps
INNER JOIN '+@database+'.sys.partitions AS p ON ps.[partition_id]=p.[partition_id]');
/*
INSERT INTO @sysindexphysicalstats ([object_id], index_id, partition_number, alloc_unit_type_desc,
    index_depth, index_level, avg_fragmentation_in_percent, min_record_size_in_bytes,
    max_record_size_in_bytes, avg_record_size_in_bytes)
SELECT [object_id], index_id, partition_number, alloc_unit_type_desc,
    index_depth, index_level, avg_fragmentation_in_percent,
    min_record_size_in_bytes, max_record_size_in_bytes, avg_record_size_in_bytes
FROM sys.dm_db_index_physical_stats(@database_id, @object_id, NULL, NULL, DEFAULT) AS ips;
*/
INSERT INTO @sysdatabasepermissions
EXEC('
SELECT class, class_desc, major_id, minor_id, grantee_principal_id,
       grantor_principal_id, [type], [permission_name], [state], state_desc
FROM '+@database+'.sys.database_permissions');

INSERT INTO @systriggers
EXEC('
SELECT t.[object_id], t.name, t.is_disabled, t.is_instead_of_trigger,
       SUBSTRING(CAST((SELECT '', ''+te.[type_desc] FROM sys.trigger_events AS te
                       WHERE te.[object_id]=t.[object_id]
                       ORDER BY te.[type] FOR XML PATH(''''), TYPE) AS sysname), 3, 256)
FROM '+@database+'.sys.triggers AS t
WHERE parent_id='+@object_id_str);






-------------------------------------------------------------------------------
--- Depending on object type and what relevant attributes an object has, we're
--- displaying as few recordsets as possible.


SELECT TOP 1 @has_cols_or_params=(CASE WHEN col.[object_id] IS NOT NULL OR par.parameter_id IS NOT NULL THEN 1 ELSE 0 END),
             @has_indexes=       (CASE WHEN ix.[object_id] IS NOT NULL THEN 1 ELSE 0 END),
             @has_foreign_keys=  (CASE WHEN fk.parent_object_id IS NOT NULL THEN 1 ELSE 0 END),
             @has_references=    (CASE WHEN fk.parent_object_id IS NOT NULL OR dep.referencing_id IS NOT NULL THEN 1 ELSE 0 END),
             @has_permissions=   (CASE WHEN per.major_id IS NOT NULL THEN 1 ELSE 0 END),
             @has_sql_module=    (CASE WHEN @module_definition IS NOT NULL THEN 1 ELSE 0 END),
             @has_data=          (CASE WHEN obj.[type] IN ('IT', 'U', 'S') OR obj.[type]='V' AND ix.index_id IS NOT NULL THEN 1 ELSE 0 END),
             @rowcount=          (SELECT SUM([rows]) FROM @syspartitions WHERE [object_id]=@object_id AND index_id IN (0, 1))
FROM @sysobjects AS obj
LEFT JOIN @syscolumns AS col ON col.[object_id]=@object_id
LEFT JOIN @sysparameters AS par ON 1=1
LEFT JOIN @sysindexes AS ix ON ix.[object_id]=@object_id AND ix.index_id!=0 -- no heaps
LEFT JOIN @sysforeignkeys AS fk ON @object_id IN (fk.parent_object_id, fk.referenced_object_id)
LEFT JOIN @sysexprdependencies AS dep ON @object_id IN (dep.referencing_id, dep.referenced_id)
LEFT JOIN @sysdatabasepermissions AS per ON per.class=1 AND per.major_id=@object_id
WHERE obj.[object_id]=@object_id;










--- Header: Name, owner, type, data space, options/schemabinding/compression
SELECT (CASE WHEN @is_tempdb=1 THEN '' ELSE sch.name END) AS [Schema],
       obj.name AS [Object],
       SUBSTRING(t.name COLLATE catalog_default, 5, LEN(t.name))+ISNULL(' ('+LOWER(ix.type_desc)+')', '') AS [Type],
       obj.[object_id],
       +(CASE WHEN obj.principal_id IS NULL THEN '('+own.name+')' ELSE own.name END) AS [Owner],
       (CASE WHEN ix.index_id IS NOT NULL THEN 'ON '+QUOTENAME(ds.name)+ISNULL('('+c.name+')', '') ELSE '' END) AS [Data space],
       ISNULL('WITH ('+NULLIF(SUBSTRING(
                ISNULL(', DATA_COMPRESSION='+NULLIF(NULLIF(p.data_compression_desc, 'NONE'), 'COLUMNSTORE'), ''),
        	3, 1000), '')+')', '') AS [Options],
       (CASE WHEN obj.[type] IN ('IT', 'U', 'S') OR obj.[type]='V' AND ix.index_id=1 THEN
           (SELECT ISNULL(CAST(NULLIF(SUM(sub.[rows]), 0) AS varchar(10))+
                          (CASE WHEN COUNT(*)>1 THEN ' rows in '+CAST(COUNT(*) AS varchar(10))+' partitions' ELSE '' END),
    		      '(empty)')
            FROM @syspartitions AS sub
            WHERE sub.[object_id]=@object_id AND sub.index_id IN (0, 1))
         ELSE ''
	 END) AS [Row count]
FROM @sysschemas AS sch
INNER JOIN @sysobjects AS obj ON sch.[schema_id]=obj.[schema_id]
LEFT JOIN @sysdatabaseprincipals AS own ON ISNULL(obj.principal_id, sch.principal_id)=own.principal_id
LEFT JOIN master.dbo.spt_values AS t ON RTRIM(LEFT(t.name, 2)) COLLATE catalog_default=obj.[type] AND t.[type]='O9T'
LEFT JOIN @sysindexes AS ix ON obj.[object_id]=ix.[object_id] AND ix.index_id IN (0, 1)
LEFT JOIN @sysdataspaces AS ds ON ix.data_space_id=ds.data_space_id
LEFT JOIN @sysindexcolumns AS pc ON ds.[type]='PS' AND ix.[object_id]=pc.[object_id] AND ix.index_id=pc.index_id AND pc.partition_ordinal>0
LEFT JOIN @syscolumns AS c ON pc.[object_id]=c.[object_id] AND pc.column_id=c.column_id
LEFT JOIN @syspartitions AS p ON ds.[type]!='PS' AND ix.[object_id]=p.[object_id] AND ix.index_id=p.index_id
WHERE obj.[object_id]=@object_id








--- Columns: Name/computed/persisted, type/length/prec/scale, identity/default, null/sparse, collation
IF (@has_cols_or_params=1) BEGIN;
	SELECT (CASE WHEN col.parameter_id IS NOT NULL AND
			  col.name='' AND
			  col.is_output=1 THEN 'RETURNS ' ELSE '' END)+
	       (CASE WHEN col.name LIKE '%[^0-9a-z\_@]%' ESCAPE '\' OR col.name IN (SELECT name FROM sys.types) THEN QUOTENAME(col.name) ELSE col.name END)+
                 (CASE WHEN obj.[type]!='SO' THEN ISNULL(' AS '+col.[definition]+
				 (CASE col.is_persisted
				  WHEN 0 THEN ''
				  WHEN 1 THEN ' PERSISTED' END), '') ELSE '' END) AS [Column],
	       (CASE WHEN obj.[type]='SO' THEN 'AS ' ELSE '' END)+
	       (CASE WHEN col.is_persisted IS NULL THEN
               col.[type_name]+(CASE
			       WHEN col.user_type_id!=col.system_type_id THEN ''
			       WHEN col.[type_name] LIKE 'n%char%' OR col.[type_name] LIKE 'n%binary%' THEN '('+ISNULL(CAST(NULLIF(col.max_length, -1)/2 AS varchar(max)), 'max')+')'
			       WHEN col.[type_name] LIKE '%char%' OR col.[type_name] LIKE '%binary%'   THEN '('+ISNULL(CAST(NULLIF(col.max_length, -1)   AS varchar(max)), 'max')+')'
			       WHEN col.[type_name] IN ('numeric', 'decimal') THEN '('+CAST(col.[precision] AS varchar(max))+', '+CAST(col.scale AS varchar(max))+')'
			       WHEN col.[type_name]='datetime2' THEN '('+CAST(col.scale AS varchar(max))+')'
			       WHEN col.[type_name]='xml' THEN ISNULL('('+xsc_sch.name+'.'+xsc.name+')', '')
			       ELSE ''
			       END) ELSE '' END) AS [Datatype],
	       (CASE WHEN obj.[type]='SO'
                 THEN 'START WITH '+CAST(col.seed_value AS varchar(40))+
                      ' INCREMENT BY '+CAST(col.increment_value AS varchar(40))
                 ELSE ISNULL('IDENTITY('+CAST(col.seed_value AS varchar(40))+', '+CAST(col.increment_value AS varchar(40))+')', '')+
	                  (CASE WHEN col.default_is_system_named=0 THEN 'CONSTRAINT '+col.default_name+' ' ELSE '' END)+
	                  (CASE WHEN col.default_name IS NOT NULL THEN ISNULL('DEFAULT '+col.[definition], '') ELSE '' END)
                 END) AS [Ident/default],
	       (CASE WHEN obj.[type]='SO' THEN ''
                 WHEN col.column_id IS NULL THEN ''
	             WHEN col.is_sparse=1 THEN 'SPARSE NULL'
		         WHEN col.is_nullable=1 THEN 'NULL'
		         ELSE 'NOT NULL' END) AS [NULL],
	       ISNULL('COLLATE '+NULLIF(col.collation_name, CAST(DATABASEPROPERTYEX(DB_NAME(),'collation') AS varchar(255))), '') AS [Collation],
	       ISNULL(NULLIF(SUBSTRING(
		   (CASE WHEN (col.[type_name] LIKE '%char%' OR col.[type_name] LIKE '%bin%') AND col.is_ansi_padded=0 THEN '  /* ANSI_PADDING OFF */' ELSE '' END)+
		   (CASE WHEN col.is_output=1 THEN ', OUTPUT' ELSE '' END)+
		   (CASE WHEN col.is_readonly=1 THEN ', READONLY' ELSE '' END)+
		   ISNULL('  /* '+col.tbl_type_cols+' */', ''),
		   3, 8000), ''), '')+
           (CASE WHEN obj.[type]='SO' THEN ISNULL(' '+[definition], '') ELSE '' END) AS [Options],
		   (CASE WHEN obj.[type]='SO' THEN 'Current value '+CAST(col.current_value AS varchar(40))
                 WHEN ROW_NUMBER() OVER (ORDER BY col.is_output, COALESCE(col.parameter_id, col.column_id+999))=COUNT(*) OVER (PARTITION BY (SELECT NULL)) THEN '' ELSE ',' END) AS [ ]
	FROM (SELECT column_id, CAST(NULL AS int) AS parameter_id, name, user_type_id, system_type_id,
		     max_length, [precision], scale, is_sparse, is_nullable, collation_name,
		     is_ansi_padded, xml_collection_id, default_object_id, CAST(NULL AS bit) AS is_output,
             CAST(NULL AS bit) AS is_readonly, CAST(NULL AS bit) AS is_table_type,
		     seed_value, increment_value, [definition], is_persisted, [type_name],
		     default_name, default_is_system_named, CAST(NULL AS varchar(max)) AS tbl_type_cols,
             current_value
	      FROM @syscolumns
	      WHERE [object_id]=@object_id
	      UNION ALL
	      SELECT CAST(NULL AS int) AS column_id, parameter_id, name, user_type_id, system_type_id,
		     max_length, [precision], scale, NULL, is_nullable, NULL,
		     NULL, xml_collection_id, NULL, is_output, is_readonly,
             is_table_type, NULL, NULL, NULL, NULL, [type_name], NULL, NULL, tbl_type_cols,
             NULL AS current_value
	      FROM @sysparameters
	      ) AS col
	LEFT JOIN @xmlschemacollections AS xsc ON col.xml_collection_id=xsc.xml_collection_id
	LEFT JOIN @sysschemas AS xsc_sch ON xsc.[schema_id]=xsc_sch.[schema_id]
    LEFT JOIN @sysobjects AS obj ON obj.[object_id]=@object_id
	ORDER BY col.is_output, COALESCE(col.parameter_id, col.column_id+999);
END;





--- Indexes: Name, constraint type, type/unique, data space, columns, included, options/compression
IF (@has_indexes=1)
	WITH ixc AS (
		SELECT ic.index_id, ic.is_included_column,
		       ROW_NUMBER() OVER (
			   PARTITION BY ic.index_id, ic.is_included_column
			   ORDER BY ic.key_ordinal) AS ordinal,
		       (CASE WHEN c.name LIKE '%[^0-9a-z\_@]%' ESCAPE '\' OR c.name IN (SELECT name FROM sys.types) THEN QUOTENAME(c.name) ELSE c.name END)+(CASE WHEN ic.is_descending_key=1 THEN ' DESC' ELSE '' END) AS name
		FROM @sysindexcolumns AS ic
		INNER JOIN @syscolumns AS c ON ic.[object_id]=c.[object_id] AND ic.column_id=c.column_id
		WHERE ic.[object_id]=@object_id),

	     rcte AS (
		SELECT index_id, is_included_column, ordinal, CAST(name AS varchar(max)) AS list
		FROM ixc
		WHERE ordinal=1
        
		UNION ALL
        
		SELECT rcte.index_id,
		       rcte.is_included_column,
		       ixc.ordinal,
		       CAST(rcte.list+', '+ixc.name AS varchar(max))
		FROM rcte
		INNER JOIN ixc ON
		    rcte.index_id=ixc.index_id AND
		    rcte.is_included_column=ixc.is_included_column AND
		    rcte.ordinal+1=ixc.ordinal)

    SELECT (CASE WHEN ix.is_primary_key=0 AND ix.is_unique_constraint=0 AND ix.is_unique=1 THEN 'UNIQUE ' ELSE '' END)+
           (CASE WHEN ix.is_primary_key=0 AND ix.is_unique_constraint=0 AND ix.[type]=1 THEN 'CLUSTERED ' ELSE '' END)+
           (CASE WHEN ix.[type]>=3 THEN ix.[type_desc]+' ' ELSE '' END)+
           (CASE WHEN 1 IN (ix.is_primary_key, ix.is_unique_constraint) THEN 'CONSTRAINT' ELSE 'INDEX' END) AS [Type],
           (CASE WHEN ix.is_system_named=0 THEN ix.name ELSE '' END) AS [Index/constraint name],
           (CASE WHEN ix.is_primary_key=1 THEN 'PRIMARY KEY '+ix.type_desc
    	     WHEN ix.is_unique_constraint=1 THEN 'UNIQUE CONSTRAINT '+ix.type_desc
    	     ELSE '' END) AS [Constraint type],
           ISNULL('('+(SELECT TOP 1 rcte.list FROM rcte WHERE rcte.index_id=ix.index_id AND rcte.is_included_column=0 ORDER BY rcte.ordinal DESC)+')', '') AS [Index columns],
           ISNULL('INCLUDE ('+(SELECT TOP 1 rcte.list FROM rcte WHERE rcte.index_id=ix.index_id AND rcte.is_included_column=1 AND ix.[type] IN (1, 2) ORDER BY rcte.ordinal DESC)+')', '') AS [Includes],
           ISNULL(' WHERE '+ix.filter_definition COLLATE database_default, '') AS [Filter],
	   (CASE WHEN ix.[type] IN (1, 2) THEN 'WITH ('+
	      'FILLFACTOR='+ISNULL(NULLIF(CAST(ix.fill_factor AS varchar(max)), '0'), '100')+
	      ', ALLOW_ROW_LOCKS='+(CASE ix.[allow_row_locks] WHEN 1 THEN 'ON' ELSE 'OFF' END)+
	      ', ALLOW_PAGE_LOCKS='+(CASE ix.[allow_page_locks] WHEN 1 THEN 'ON' ELSE 'OFF' END)+
	      ', PAD_INDEX='+(CASE ix.is_padded WHEN 1 THEN 'ON' ELSE 'OFF' END)+
	      ISNULL(', DATA_COMPRESSION='+NULLIF(NULLIF(p.data_compression_desc, 'NONE'), 'COLUMNSTORE'), '')+')' ELSE '' END) AS [Options],
	   (CASE WHEN ix.index_id IS NOT NULL AND ds.is_default=0 THEN 'ON '+QUOTENAME(ds.name)+ISNULL('('+c.name+')', '') ELSE '' END) AS [Data space],
           (SELECT ISNULL(CAST(SUM(sub.[rows]) AS varchar(10))+
	           ISNULL(' rows in '+CAST(NULLIF(COUNT(*), 1) AS varchar(10))+' partitions', ''), '')
            FROM @syspartitions AS sub
            WHERE sub.[object_id]=@object_id AND sub.index_id=ix.index_id AND ix.has_filter=1) AS [Filtered rows]
	FROM @sysindexes AS ix
	LEFT JOIN @sysdataspaces AS ds ON ix.data_space_id=ds.data_space_id
	LEFT JOIN @sysindexcolumns AS pc ON ds.[type]='PS' AND ix.[object_id]=pc.[object_id] AND ix.index_id=pc.index_id AND pc.partition_ordinal>0
	LEFT JOIN @syscolumns AS c ON pc.[object_id]=c.[object_id] AND pc.column_id=c.column_id
	LEFT JOIN @syspartitions AS p ON ds.[type]!='PS' AND ix.[object_id]=p.[object_id] AND ix.index_id=p.index_id
	WHERE ix.[object_id]=@object_id AND ix.index_id>0
	ORDER BY (CASE WHEN ix.is_primary_key=1 THEN 1
		       WHEN ix.is_unique_constraint=1 THEN 2
		       ELSE 3 END), ix.[type], ix.name;






--- Foreign keys constraints: Constraint name, columns, references, ref.columns, on update/delete, options (enabled, for replication)
IF (@has_foreign_keys=1)
	WITH cols AS (
		SELECT fkc.constraint_object_id, fkc.constraint_column_id,
		       CAST((CASE WHEN pc.name LIKE '%[^0-9a-z\_@]%' ESCAPE '\' OR pc.name IN (SELECT name FROM sys.types) THEN QUOTENAME(pc.name) ELSE pc.name END) AS varchar(max)) AS parent_cols,
		       CAST((CASE WHEN rc.name LIKE '%[^0-9a-z\_@]%' ESCAPE '\' OR rc.name IN (SELECT name FROM sys.types) THEN QUOTENAME(rc.name) ELSE rc.name END) AS varchar(max)) AS referenced_cols
		FROM @sysforeignkeycols AS fkc
		INNER JOIN @syscolumns AS pc ON fkc.parent_object_id=pc.[object_id] AND fkc.parent_column_id=pc.column_id
		INNER JOIN @syscolumns AS rc ON fkc.referenced_object_id=rc.[object_id] AND fkc.referenced_column_id=rc.column_id
		WHERE fkc.constraint_column_id=1 AND
		      @object_id IN (fkc.parent_object_id, fkc.referenced_object_id)

		UNION ALL

		SELECT fkc.constraint_object_id, fkc.constraint_column_id,
		       CAST(cols.parent_cols+', '+pc.name AS varchar(max)) AS parent_cols,
		       CAST(cols.referenced_cols+', '+rc.name AS varchar(max)) AS referenced_cols
		FROM cols
		INNER JOIN @sysforeignkeycols AS fkc ON cols.constraint_object_id=fkc.constraint_object_id AND cols.constraint_column_id+1=fkc.constraint_column_id
		INNER JOIN @syscolumns AS pc ON fkc.parent_object_id=pc.[object_id] AND fkc.parent_column_id=pc.column_id
		INNER JOIN @syscolumns AS rc ON fkc.referenced_object_id=rc.[object_id] AND fkc.referenced_column_id=rc.column_id)

	SELECT ps.name+'.'+p.name AS [Referencing object],
	       fk.name AS [Foreign key constraint],
	       'FOREIGN KEY ('+(SELECT TOP 1 parent_cols FROM cols WHERE cols.constraint_object_id=fk.[object_id] ORDER BY cols.constraint_column_id DESC)+')' AS [Referencing columns],
	       'REFERENCES '+rs.name+'.'+r.name AS [Referenced object],
	       '('+(SELECT TOP 1 referenced_cols FROM cols WHERE cols.constraint_object_id=fk.[object_id] ORDER BY cols.constraint_column_id DESC)+')' AS [Referenced columns],
	       SUBSTRING(ISNULL(' ON DELETE '+NULLIF(REPLACE(fk.delete_referential_action_desc, '_', ' '), 'NO ACTION'), '')+
			 ISNULL(' ON UPDATE '+NULLIF(REPLACE(fk.update_referential_action_desc, '_', ' '), 'NO ACTION'), ''), 2, 100)+
             (CASE WHEN 1 IN (fk.is_disabled, fk.is_not_trusted) THEN ' -- ' ELSE '' END)+
             (CASE WHEN fk.is_disabled=1 THEN ' DISABLED'
                   WHEN fk.is_not_trusted=1 THEN ' NOT TRUSTED' ELSE '' END) AS [Options]
	FROM @sysforeignkeys AS fk
	INNER JOIN @sysobjects AS p ON fk.parent_object_id=p.[object_id]
	INNER JOIN @sysschemas AS ps ON p.[schema_id]=ps.[schema_id]
	INNER JOIN @sysobjects AS r ON fk.referenced_object_id=r.[object_id]
	INNER JOIN @sysschemas AS rs ON r.[schema_id]=rs.[schema_id]
	WHERE @object_id IN (fk.parent_object_id, fk.referenced_object_id)
	ORDER BY (CASE WHEN fk.parent_object_id=@object_id THEN 1 ELSE 2 END), fk.name;





--- Triggers: name, type and actions
IF (EXISTS (SELECT NULL FROM @systriggers))
    SELECT s.name+'.'+t.name AS [Trigger],
           (CASE WHEN t.is_instead_of_trigger=1 THEN 'INSTEAD OF ' ELSE 'FOR ' END)+t.[trigger_events] AS [Trigger action(s)],
           (CASE WHEN t.is_disabled=1 THEN 'Disabled' ELSE '' END) AS [ ]
    FROM @systriggers AS t
    LEFT JOIN @sysobjects AS o ON t.[object_id]=o.[object_id]
    LEFT JOIN @sysschemas AS s ON o.[schema_id]=s.[schema_id]
    ORDER BY t.name;






--- Relations between objects (referencing or referenced) including foreign key constraints:
IF (@has_references=1) BEGIN;
	WITH refs1
	AS (--- Expression dependencies (i.e. modules that refer to other modules,
	    --- tables, functions, check constraints, etc:
	    SELECT DISTINCT dep.referencing_id,
		   dep.referenced_id,
		   dep.is_schema_bound_reference AS is_schemabound,
		   0 AS is_foreign_key,
		   CAST(NULL AS varchar(255)) AS column_list,
		   0 AS is_nullable
	    FROM @sysexprdependencies AS dep
	    WHERE dep.referencing_id!=dep.referenced_id

	    UNION

	    --- ... and foreign key constraints that define dependencies between tables:    
	    SELECT fk.parent_object_id AS referencing_id,
		   fk.referenced_object_id,
		   0 AS is_schemabound,
		   1 AS is_foreign_key,
		   CAST(c.list AS varchar(255)) AS column_list,
		   (SELECT MIN(CAST(n.is_nullable AS int))
		    FROM @sysforeignkeycols AS fkc
		    INNER JOIN @syscolumns AS n ON
			fkc.parent_object_id=n.[object_id] AND
			fkc.parent_column_id=n.column_id
		    WHERE fk.[object_id]=fkc.constraint_object_id) AS is_nullable
	    FROM @sysforeignkeys AS fk
	    CROSS APPLY (
		SELECT CAST(fkc.parent_column_id AS varchar(4))+';'
		FROM @sysforeignkeycols AS fkc
		WHERE fkc.constraint_object_id=fk.[object_id]
		ORDER BY fkc.parent_column_id
		FOR XML PATH(''), TYPE) AS c(list)
	    WHERE fk.parent_object_id!=fk.referenced_object_id),

	     uqix
	AS (--- These are all the unique column combinations in each table.
	    SELECT DISTINCT ix.[object_id], CAST(c.list AS varchar(255)) AS column_list
	    FROM @sysindexes AS ix
	    CROSS APPLY (
		SELECT CAST(ixc.column_id AS varchar(4))+';'
		FROM @sysindexcolumns AS ixc
		WHERE ixc.[object_id]=ix.[object_id] AND
		      ixc.index_id=ix.index_id AND
		      ixc.is_included_column=0
		ORDER BY ixc.column_id
		FOR XML PATH(''), TYPE) AS c(list)
	    WHERE ix.is_unique=1),

	     refs2
	AS (--- Check for matching unique indexes on the referencing table columns. Also, if
	    --- there's more than one reference between the two tables, or more than one unique
	    --- index on the referencing table, make the result set distinct using GROUP BY.
	    SELECT refs1.referencing_id AS parent_id,
		   ps.name+'.'+p.name AS parent_name,
		   refs1.referenced_id AS child_id,
		   cs.name+'.'+c.name AS child_name,
		   CAST(MAX(refs1.is_schemabound) AS bit) AS is_schemabound,
		   CAST(MAX(refs1.is_foreign_key) AS bit) AS is_foreign_key,
		   CAST(MAX((CASE WHEN uqix.[object_id] IS NOT NULL THEN 1 ELSE 0 END)) AS bit) AS is_unique,
		   CAST(MAX(refs1.is_nullable) AS bit) AS is_nullable
	    FROM refs1
	    INNER JOIN @sysobjects AS p  ON p.[object_id]=refs1.referencing_id
	    INNER JOIN @sysschemas AS ps ON p.[schema_id]=ps.[schema_id]
	    INNER JOIN @sysobjects AS c  ON c.[object_id]=refs1.referenced_id
	    INNER JOIN @sysschemas AS cs ON c.[schema_id]=cs.[schema_id]
	    LEFT JOIN uqix ON uqix.[object_id]=p.[object_id] AND refs1.column_list=uqix.column_list
	    GROUP BY refs1.referencing_id, refs1.referenced_id,
		     ps.name, p.name, cs.name, c.name),
    
	     refs3
	AS (--- Add ROW_NUMBER() and COUNT(*) OVER to count number of children
	    --- per parent and number of parents per child. This is used to
	    --- format the output properly.
	    SELECT parent_id, parent_name,
		   ROW_NUMBER() OVER (PARTITION BY child_id ORDER BY parent_name) AS parent_row,
		   COUNT(*) OVER (PARTITION BY child_id) AS parent_count,
		   child_id, child_name,
		   ROW_NUMBER() OVER (PARTITION BY parent_id ORDER BY child_name) AS child_row,
		   COUNT(*) OVER (PARTITION BY parent_id) AS child_count,
		   is_schemabound, is_foreign_key, is_unique, is_nullable
	    FROM refs2)

	--- Store everything from refs3 in a work table for performance:    
	INSERT INTO @references
	      (parent_id, parent_name, child_id, child_name, is_schemabound, is_nullable,
	       is_foreign_key, parent_row, parent_count, child_row, child_count, is_unique)
	SELECT parent_id, parent_name, child_id, child_name, is_schemabound, is_nullable,
	       is_foreign_key, parent_row, parent_count, child_row, child_count, is_unique
	FROM refs3 AS r;

	--- "parents" contains the first and second-order parent levels (r2 and r1),
	--- where "parents" are referencing objects and "children" are the referenced objects.
	WITH [rowcount] AS (
		SELECT [object_id], ' ('+CAST(SUM([rows]) AS varchar(10))+')' AS [rowcount]
		FROM @syspartitions
		WHERE index_id IN (0, 1)
		GROUP BY [object_id], index_id
		HAVING SUM([rows])!=0
		),

	     parents AS (
		SELECT --- Ordinal
		       ROW_NUMBER() OVER (ORDER BY r2.parent_name, r1.parent_name)-COUNT(*) OVER (PARTITION BY NULL)/2 AS ordinal,
        
		       --- Level -2
		       ISNULL(r1.parent_name+ISNULL(+c1.[rowcount], ''), '') AS obj2,
		       r1.is_foreign_key AS fk2,
		       r1.is_schemabound AS sb2,
		       r1.is_unique AS uq2,
		       r1.is_nullable AS n2,

		       --- Spacer
		       (CASE WHEN r1.parent_count=0 THEN ''
			     WHEN r1.parent_count=1 THEN @hyph
			     WHEN r1.parent_row=1 THEN '\'
			     WHEN r1.parent_row=r1.parent_count THEN '/'
			     WHEN r1.child_id IS NOT NULL THEN @pipe
			     ELSE '' END) AS spacer,

		       --- Level -1
		       (CASE WHEN r1.parent_row=r1.parent_count/2+1 OR r1.child_id IS NULL THEN r2.parent_name+ISNULL(+c2.[rowcount], '') ELSE '' END) AS obj1,
		       r2.is_foreign_key AS fk1,
		       r2.is_schemabound AS sb1,
		       r2.is_unique AS uq1,
		       r2.is_nullable AS n1
		FROM @references AS r1
		RIGHT JOIN @references AS r2 ON r1.child_id=r2.parent_id
		LEFT JOIN [rowcount] AS c1 ON r1.parent_id=c1.[object_id]
		LEFT JOIN [rowcount] AS c2 ON r2.parent_id=c2.[object_id]
		WHERE r2.child_id=@object_id),

	--- "children" contains the first and second-order child levels (r3 and r4):
	     children AS (
		SELECT --- Ordinal
		       ROW_NUMBER() OVER (ORDER BY r3.child_name, r4.child_name)-COUNT(*) OVER (PARTITION BY NULL)/2 AS ordinal,

		       --- Level +1
		       (CASE WHEN r4.child_row=r4.child_count/2+1 OR r4.parent_id IS NULL THEN r3.child_name+ISNULL(+c3.[rowcount], '') ELSE '' END) AS obj1,
		       r3.is_foreign_key AS fk1,
		       r3.is_schemabound AS sb1,
		       r3.is_unique AS uq1,
		       r3.is_nullable AS n1,

		       --- Spacer
		       (CASE WHEN r4.child_count=0 THEN ''
			     WHEN r4.child_count=1 THEN @hyph
			     WHEN r4.child_row=1 THEN '/'
			     WHEN r4.child_row=r4.child_count THEN '\'
			     WHEN r4.parent_id IS NULL THEN ''
			     ELSE @pipe END) AS spacer,

		       --- Level +2
		       ISNULL(r4.child_name+ISNULL(+c4.[rowcount], ''), '') AS obj2,
		       r4.is_foreign_key AS fk2,
		       r4.is_schemabound AS sb2,
		       r4.is_unique AS uq2,
		       r4.is_nullable AS n2
		FROM @references AS r3
		LEFT JOIN @references AS r4 ON r3.child_id=r4.parent_id
		LEFT JOIN [rowcount] AS c3 ON r3.child_id=c3.[object_id]
		LEFT JOIN [rowcount] AS c4 ON r4.child_id=c4.[object_id]
		WHERE r3.parent_id=@object_id)

	--- Putting it all together:
	SELECT --- Second-order parent and spacer:
	       ISNULL(p.obj2, '') AS [Referencing...],

	       (CASE WHEN p.obj2!='' AND p.fk2=1 AND p.n2=1 THEN @zero
		     WHEN p.obj2!='' AND p.fk2=1 AND p.n2=0 THEN @one ELSE N'' END)+
	       (CASE WHEN p.obj2!='' AND p.fk2=1 AND p.uq2=0 THEN @inf ELSE N'' END)+
	       (CASE WHEN p.obj2!='' AND p.fk2=1 THEN @hyph+@one
		     WHEN p.sb2=1 THEN N'*' ELSE N'' END) AS [ ],
	       ISNULL(p.spacer, '') AS [ ],

	       --- First-order parent and spacer:
	       ISNULL(p.obj1, '') AS [ ],
	       (CASE WHEN p.obj1!='' AND p.fk1=1 AND p.n1=1 THEN @zero
		     WHEN p.obj1!='' AND p.fk1=1 AND p.n1=0 THEN @one ELSE N'' END)+
	       (CASE WHEN p.obj1!='' AND p.fk1=1 AND p.uq1=0 THEN @inf ELSE N'' END)+
	       (CASE WHEN p.obj1!='' AND p.fk1=1 THEN @hyph+@one
		     WHEN p.sb1=1 THEN N'*' ELSE N'' END) AS [ ],
	       (CASE WHEN COUNT(p.ordinal) OVER(PARTITION BY NULL)=1 AND p.ordinal=MIN(p.ordinal) OVER (PARTITION BY NULL) THEN @hyph
		     WHEN p.ordinal=MIN(p.ordinal) OVER (PARTITION BY NULL) THEN '\'
		     WHEN p.ordinal=MAX(p.ordinal) OVER (PARTITION BY NULL) THEN '/'
		     WHEN p.ordinal IS NOT NULL THEN @pipe ELSE '' END) AS [ ],

	       --- The object itself:
	       (CASE WHEN n.ordinal=1 THEN sch.name+'.'+obj.name+ISNULL(rc.[rowcount], '') ELSE '' END) AS [Object],

	       --- First-order spacer and child:
	       (CASE WHEN COUNT(c.ordinal) OVER(PARTITION BY NULL)=1 AND c.ordinal=MIN(c.ordinal) OVER (PARTITION BY NULL) THEN @hyph
		     WHEN c.ordinal=MIN(c.ordinal) OVER (PARTITION BY NULL) THEN '/'
		     WHEN c.ordinal=MAX(c.ordinal) OVER (PARTITION BY NULL) THEN '\'
		     WHEN c.ordinal IS NOT NULL THEN @pipe ELSE '' END) AS [ ],
	       (CASE WHEN c.obj1!='' AND c.fk1=1 AND c.n1=1 THEN @zero
		     WHEN c.obj1!='' AND c.fk1=1 AND c.n1=0 THEN @one ELSE N'' END)+
	       (CASE WHEN c.obj1!='' AND c.fk1=1 AND c.uq1=0 THEN @inf ELSE N'' END)+
	       (CASE WHEN c.obj1!='' AND c.fk1=1 THEN @hyph+@one
		     WHEN c.sb1=1 THEN N'*' ELSE N'' END) AS [ ],

	       ISNULL(c.obj1, '') AS [ ],

	       --- Second-order spacer and child:
	       ISNULL(c.spacer, '') AS [ ],
	       (CASE WHEN c.obj2!='' AND c.fk2=1 AND c.n2=1 THEN @zero
		     WHEN c.obj2!='' AND c.fk2=1 AND c.n2=0 THEN @one ELSE N'' END)+
	       (CASE WHEN c.obj2!='' AND c.fk2=1 AND c.uq2=0 THEN @inf ELSE N'' END)+
	       (CASE WHEN c.obj2!='' AND c.fk2=1 THEN @hyph+@one
		     WHEN c.sb2=1 THEN N'*' ELSE N'' END) AS [ ],

	       ISNULL(c.obj2, '') AS [... referenced]
	FROM (--- This is a list of all ordinals, used as a "frame" for the
	      --- recordset, to which we join "parents" and "children":
	      SELECT ordinal FROM parents UNION
	      SELECT ordinal FROM children) AS n
	INNER JOIN @sysobjects AS obj ON obj.[object_id]=@object_id
	INNER JOIN @sysschemas AS sch ON obj.[schema_id]=sch.[schema_id]
	LEFT JOIN [rowcount] AS rc ON rc.[object_id]=@object_id
	LEFT JOIN parents  AS p ON p.ordinal=n.ordinal
	LEFT JOIN children AS c ON c.ordinal=n.ordinal
	--- ... and order the output:
	ORDER BY n.ordinal;
END;







--- Permissions
IF (@has_permissions=1)
	WITH list AS (
		SELECT p.class, (CASE p.class
		        WHEN 1 THEN s.name+'.'+o.name
			WHEN 3 THEN 'SCHEMA::'+s.name
			WHEN 0 THEN 'DATABASE::'+DB_NAME() END) AS securable,
		       ROW_NUMBER() OVER (
			   PARTITION BY p.class, p.major_id, p.grantee_principal_id, p.grantor_principal_id, p.[state]
			   ORDER BY p.[permission_name], p.minor_id) AS ordinal,
		       p.grantee_principal_id,
		       p.grantor_principal_id,
		       p.[state],
		       p.[permission_name] COLLATE database_default+ISNULL('('+c.name+')', '') AS [permission_name]
		FROM @sysdatabasepermissions AS p
		INNER JOIN @sysobjects AS o ON o.[object_id]=@object_id
		INNER JOIN @sysschemas AS s ON o.[schema_id]=s.[schema_id]
		LEFT JOIN @syscolumns AS c ON c.[object_id]=o.[object_id] AND p.minor_id=c.column_id
		WHERE (p.class=1 AND p.major_id=o.[object_id] OR
		       p.class=3 AND p.major_id=o.[schema_id] OR
		       p.class=0) AND
		      p.[type] IN (SELECT [type] COLLATE database_default FROM sys.fn_builtin_permissions('OBJECT'))),

	     rcte AS (
		SELECT class, securable, ordinal, grantee_principal_id, grantor_principal_id, [state], CAST([permission_name] AS varchar(max)) AS list
		FROM list
		WHERE ordinal=1

		UNION ALL

		SELECT list.class, list.securable, list.ordinal, rcte.grantee_principal_id, rcte.grantor_principal_id, rcte.[state], CAST(rcte.list+', '+list.[permission_name] AS varchar(max))
		FROM rcte
		INNER JOIN list ON
		    list.securable=rcte.securable AND
		    list.grantee_principal_id=rcte.grantee_principal_id AND
		    list.grantor_principal_id=rcte.grantor_principal_id AND
		    list.[state]=rcte.[state] AND
		    list.ordinal=rcte.ordinal+1)

	SELECT (CASE p.[state]
		WHEN 'D' THEN 'DENY'
		WHEN 'G' THEN 'GRANT'
		WHEN 'W' THEN 'GRANT' END) AS [Grant/Deny],
	       (CASE WHEN obj.[type]='FN' AND px.list='EXECUTE, REFERENCES' THEN 'ALL'
		     WHEN obj.[type] IN ('IF', 'TF', 'U', 'V') AND px.list='DELETE, INSERT, REFERENCES, SELECT, UPDATE' THEN 'ALL'
		     ELSE px.list END) AS [Permission],
	       'ON '+p.securable AS [Object],
	       'TO '+QUOTENAME(grantee.name) AS [Principal],
	       LTRIM((CASE WHEN p.[state]='W' THEN ' WITH GRANT OPTION' ELSE '' END)+
		     (CASE WHEN grantor.name!='dbo' THEN ' AS '+QUOTENAME(grantor.name) ELSE '' END)) AS [Options]
	FROM rcte AS p
	INNER JOIN @sysobjects AS obj ON obj.[object_id]=@object_id
	INNER JOIN @sysschemas AS sch ON obj.[schema_id]=sch.[schema_id]
	LEFT JOIN @sysdatabaseprincipals AS grantee ON p.grantee_principal_id=grantee.principal_id
	LEFT JOIN @sysdatabaseprincipals AS grantor ON p.grantor_principal_id=grantor.principal_id
	CROSS APPLY (SELECT TOP 1 list
		     FROM rcte
		     WHERE rcte.[state]=p.[state] AND
			   rcte.grantee_principal_id=p.grantee_principal_id AND
			   rcte.grantor_principal_id=p.grantor_principal_id
		     ORDER BY rcte.ordinal DESC) AS px
	WHERE p.ordinal=1
	ORDER BY (CASE p.class WHEN 1 THEN 1 WHEN 3 THEN 2 ELSE 3 END), p.securable, grantee.name,
	         (CASE p.[state] WHEN 'G' THEN 1 WHEN 'W' THEN 2 WHEN 'D' THEN 3 END), grantor.name;





IF (@has_data=1 AND @rowcount>0)
	SELECT ISNULL(ix.name, '') AS [Index/heap],

	       --- Partition number, if there are partitions:
	       (CASE COUNT(*) OVER (PARTITION BY p.[object_id], p.index_id)
		     WHEN 1 THEN ''
		     ELSE CAST(p.partition_number AS varchar(10))
		     END) AS [Partition],

	       --- Storage properties:
	       ISNULL(NULLIF(NULLIF(p.data_compression_desc, 'NONE'), 'COLUMNSTORE'), '') AS [Compression],
	       ds.name+ISNULL('('+pc.name+')', '') AS [Data space],
	       (CASE WHEN ix.type_desc!='HEAP' THEN STR(ISNULL(NULLIF(ix.fill_factor, 0), 100), 4, 0)+'%' ELSE '' END) AS [Fill factor],

	       --- The raw numbers:
	       ps.row_count AS [Row count],
	       ISNULL(STR(NULLIF(1.0*ps.reserved_page_count*8/1024, 0), 12, 2)+' MB', '') AS [Reserved],
	       ISNULL(STR(NULLIF(1.0*ps.in_row_used_page_count*8/1024, 0), 12, 2)+' MB', '') AS [In-row used],
	       ISNULL(STR(NULLIF(1.0*ps.row_overflow_used_page_count*8/1024, 0), 12, 2)+' MB', '') AS [Row-overflow used],
	       ISNULL(STR(NULLIF(1.0*ps.lob_used_page_count*8/1024, 0), 12, 2)+' MB', '') AS [Out-of-row used],
	       ISNULL(STR(NULLIF(1.0*ps.used_page_count*8/1024, 0), 12, 2)+' MB', '') AS [Total used],

           --- Physical index statistics
           ISNULL(STR(ips.avg_fragmentation_in_percent, 4, 1)+'%', '') AS [Avg fragm.],
           ips.index_depth AS [Index depth]

	FROM @syspartitionstats AS ps
	INNER JOIN @syspartitions AS p ON ps.[partition_id]=p.[partition_id]
	LEFT JOIN @sysindexes AS ix ON p.[object_id]=ix.[object_id] AND p.index_id=ix.index_id
	--- Data space is either a file group or a partition function:
	LEFT JOIN @sysdataspaces AS ds ON ix.data_space_id=ds.data_space_id
	--- This is the partitioning column:
	LEFT JOIN @sysindexcolumns AS ixc ON ix.[object_id]=ixc.[object_id] AND
	    ix.index_id=ixc.index_id AND ixc.partition_ordinal>0
	LEFT JOIN @syscolumns AS pc ON pc.[object_id]=@object_id AND pc.column_id=ixc.column_id
    LEFT JOIN @sysindexphysicalstats AS ips ON
        ips.[object_id]=@object_id AND
        ips.index_id=p.index_id AND
        ips.partition_number=p.partition_number
	WHERE p.[object_id]=@object_id
	ORDER BY ix.index_id, p.partition_number;




IF (@has_sql_module=1) BEGIN;
    WITH r AS (
        SELECT -3 AS [row], CAST('SET '+NULLIF(SUBSTRING(
                    (CASE WHEN @uses_ansi_nulls=1 THEN ', ANSI_NULLS' ELSE '' END)+
                    (CASE WHEN @uses_quoted_identifier=1 THEN ', QUOTED_IDENTIFIER' ELSE '' END), 3, 1000), '')+
	            ' ON;' AS nvarchar(max)) AS rowData,
            CAST(NULL AS nvarchar(max)) AS remain
        UNION ALL
        SELECT -3 AS [row], CAST('SET '+NULLIF(SUBSTRING(
                    (CASE WHEN @uses_ansi_nulls=0 THEN ', ANSI_NULLS' ELSE '' END)+
                    (CASE WHEN @uses_quoted_identifier=0 THEN ', QUOTED_IDENTIFIER' ELSE '' END), 3, 1000), '')+
	            ' OFF;' AS nvarchar(max)) AS rowData,
	        CAST(NULL AS nvarchar(max)) AS remain
        UNION ALL

        SELECT -2 AS [row], CAST('GO' AS nvarchar(max)), CAST(NULL AS nvarchar(max))
        UNION ALL
        SELECT -1 AS [row], CAST('' AS nvarchar(max)), CAST(NULL AS nvarchar(max))
        UNION ALL

        SELECT 0 AS [row], CAST(NULL AS nvarchar(max)) AS rowData, @module_definition AS remain
	    UNION ALL
	    SELECT [row]+1, LEFT(remain, CHARINDEX(@lf, remain+@lf)-1),
	           SUBSTRING(remain, CHARINDEX(@lf, remain+@lf)+1, LEN(remain))
	    FROM r
	    WHERE NULLIF(remain, '') IS NOT NULL AND [row]<32)

    SELECT (CASE WHEN [row]<0 THEN '' ELSE STR([row], 4, 0) END) AS Line,
           REPLACE(rowData, @cr, N'') AS [Source code]
    FROM r
    WHERE [row]>=(SELECT MIN([row]) FROM r WHERE [row]>0 AND REPLACE(rowData, @cr, N'')!='') AND [row]<32 OR [row]<0 AND rowData IS NOT NULL
    UNION ALL
    SELECT TOP 1 ' ...' AS [row], N''
    FROM r
    WHERE [row]>=15
    ORDER BY 1
    OPTION (MAXRECURSION 0);
END;

GO








--- This marks master.dbo.sp_ctrl3 as a "system object", which makes
--- it accessible from any database without the "master." prefix. It
--- also sets the execution context of the procedure to the database
--- where it was called.
---
--- NOTE: sp_MS_marksystemobject is an undocumented, unsupported
--- feature of SQL Server.

EXECUTE sys.sp_MS_marksystemobject @objname=N'sp_ctrl3';
GO
