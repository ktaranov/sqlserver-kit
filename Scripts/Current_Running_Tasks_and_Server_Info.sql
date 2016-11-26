/*

This script shows current status and activity for currently running tasks on
the SQL Server. It returns 6 recordsets, in the following order:

1: General server-wide information
2: Database files, usage, disk space
3: Connections by SPID including CPU and I/O totals
4: Running queries, memory use/grant, query plan
5: Open transactions, type, isolation level
6: Locks by object, partition, including size, wait type, blocking info.

Copyright Daniel Hutmacher under Creative Commons 4.0 license with attribution.
http://creativecommons.org/licenses/by/4.0/

Source:  http://sqlsunday.com/downloads/
Version: 2016-10-20

DISCLAIMER: This script does not make any modifications to the server, except
            for creating three temporary functions in tempdb, used to format
        values in a user-friendly manner. However, the script may not be
        suitable to run in a production environment. I cannot assume any
        responsibility regarding the accuracy of the output information,
        performance impacts on your server, or any other consequence. If
        your juristiction does not allow for this kind of waiver/disclaimer,
        or if you do not accept these terms, you are NOT allowed to store,
        distribute or use this code in any way.

*/

USE tempdb;
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
SET DEADLOCK_PRIORITY LOW;
SET STATISTICS XML OFF;
SET LOCK_TIMEOUT 500;
SET NOCOUNT ON;

DECLARE @hasPermissions bit=HAS_PERMS_BY_NAME(NULL, NULL, 'VIEW SERVER STATE');
IF (@hasPermissions=0) BEGIN;
    RAISERROR('This script requires VIEW SERVER STATE permissions.', 16, 1);
    RETURN;
END;

SET @hasPermissions=HAS_PERMS_BY_NAME(NULL, 'DATABASE', 'CREATE FUNCTION')
IF (@hasPermissions=0) BEGIN;
    RAISERROR('This script requires CREATE FUNCTION permissions in tempdb.', 16, 1);
    RETURN;
END;

-------------------------------------------------------------------------------








BEGIN TRANSACTION;
BEGIN TRY;

-------------------------------------------------------------------------------
--- Temporary functions, used to beautify numbers, bits&bytes and dates.
-------------------------------------------------------------------------------

IF (NOT EXISTS (SELECT [object_id] FROM sys.objects WHERE [name]='fn_friendly_age'))
    EXEC('
CREATE FUNCTION dbo.fn_friendly_age (
    @from	datetime,
    @to	datetime)
RETURNS varchar(20)
WITH SCHEMABINDING
AS

BEGIN
    DECLARE @age varchar(20)

    IF (@from IS NOT NULL AND @to IS NOT NULL)
        SET @age=(CASE
            WHEN DATEDIFF(ss, @from, @to)<1
            THEN ''       ''+STR(DATEDIFF(ms, @from, @to), 10, 0)+'' ms.''

            WHEN DATEDIFF(ss, @from, @to)<180
            THEN ''        ''+STR(0.001*DATEDIFF(ms, @from, @to), 10, 1)+'' s.''

            WHEN DATEDIFF(ss, @from, @to)<24*3600
            THEN ''     ''+SUBSTRING(CONVERT(varchar(20), DATEADD(ss, DATEDIFF(ss, @from, @to), 0), 120), 12, 8)

            WHEN DATEDIFF(dd, @from, @to)<3
            THEN STR(FLOOR(1.0*DATEDIFF(ss, @from, @to)/(3600*24)), 3, 0)+''d+''+
                SUBSTRING(CONVERT(varchar(20), DATEADD(ss, DATEDIFF(ss, @from, @to), 0), 120), 12, 5)+''  ''

            ELSE STR(FLOOR(1.0*DATEDIFF(ss, @from, @to)/(3600*24)), 3, 0)+''d ''+
                REPLICATE('' '', 5)+''  ''
            END)

    RETURN @age
END');

IF (NOT EXISTS (SELECT [object_id] FROM sys.objects WHERE [name]='fn_format_number'))
    EXEC('
CREATE FUNCTION dbo.fn_format_number(
    @number		numeric(28, 8),
    @prec		tinyint)
RETURNS varchar(100)
WITH SCHEMABINDING
AS

BEGIN
    DECLARE @out varchar(100), @offset int=(CASE WHEN @prec=0 THEN 0 ELSE @prec+1 END)

    SET @out=REVERSE(LTRIM(ISNULL(STR(@number, 20, @prec), '''')))
    WHILE (@offset<LEN(@out)) BEGIN
        IF (SUBSTRING(@out, @offset, 1)!=''.'') BEGIN
            SET @out=LEFT(@out, @offset)+'' ''+SUBSTRING(@out, @offset+1, LEN(@out))
            SET @offset=@offset+1
        END
        SET @offset=@offset+3
    END
    SET @out=LTRIM(REVERSE(@out))
    IF (LEN(@out)<15)
        SET @out=NULLIF(RIGHT(REPLICATE('' '', 15+@prec)+@out, 15+@prec), '''')

    RETURN @out
END');

IF (NOT EXISTS (SELECT [object_id] FROM sys.objects WHERE [name]='fn_friendly_size'))
    EXEC('
CREATE FUNCTION dbo.fn_friendly_size (
    @bytes	bigint)
RETURNS varchar(20)
WITH SCHEMABINDING
AS

BEGIN;
    DECLARE @size varchar(20), @k bigint=1024;

    IF (@bytes IS NOT NULL)
        SET @size=(CASE
            --WHEN @bytes<4*@k
            --THEN dbo.fn_format_number(1.0*@bytes, 0)+'' B''

            WHEN @bytes<4*@k*@k
            THEN dbo.fn_format_number(1.0*@bytes/@k, 1)+'' kB''

            WHEN @bytes<4*@k*@k*@k
            THEN dbo.fn_format_number(1.0*@bytes/@k/@k, 2)+'' MB''

            WHEN @bytes<4*@k*@k*@k*@k
            THEN dbo.fn_format_number(1.0*@bytes/@k/@k/@k, 2)+'' GB''

            ELSE dbo.fn_format_number(1.0*@bytes/@k/@k/@k/@k, 2)+'' TB''
            END);

    RETURN @size;
END;');



-------------------------------------------------------------------------------
--- Gather information on database files and objects/indexes
-------------------------------------------------------------------------------

DECLARE @sql varchar(max), @sql2 varchar(max), @sql3 varchar(max),
    @sql4 varchar(max), @name sysname, @virtual_machine_type int,
    @version varchar(4), @physical_memory bigint, @virtual_memory bigint,
    @gb bigint=1024*1024*1024, @mb bigint=1024*1024,
    @max_server_memory bigint, @min_server_memory bigint, @max_degree_of_parallelism tinyint;

SET @version=LEFT(CAST(SERVERPROPERTY('ProductVersion') AS varchar(10)), 4);
IF (@version LIKE '9%') SET @version=LEFT('0'+@version, 4);

SELECT @max_server_memory=CAST([value] AS bigint)*1024*1024 FROM sys.configurations WHERE [name]='max server memory (MB)';
SELECT @min_server_memory=CAST([value] AS bigint)*1024*1024 FROM sys.configurations WHERE [name]='min server memory (MB)';
SELECT @max_degree_of_parallelism=CAST([value] AS tinyint)  FROM sys.configurations WHERE [name]='max degree of parallelism';

IF (@version<'11.0')
    EXECUTE sp_executesql N'
        SELECT @physical_memory=physical_memory_in_bytes,
            @virtual_memory=virtual_memory_in_bytes
        FROM sys.dm_os_sys_info',
        N'@physical_memory bigint OUTPUT, @virtual_memory bigint OUTPUT',
        @physical_memory=@physical_memory OUTPUT,
        @virtual_memory=@virtual_memory OUTPUT;

IF (@version>='11.0')
    EXECUTE sp_executesql N'
        SELECT @physical_memory=physical_memory_kb*1024,
            @virtual_memory=virtual_memory_kb*1024
        FROM sys.dm_os_sys_info',
        N'@physical_memory bigint OUTPUT, @virtual_memory bigint OUTPUT',
        @physical_memory=@physical_memory OUTPUT,
        @virtual_memory=@virtual_memory OUTPUT;

BEGIN TRY;
    EXECUTE sp_executesql N'
        SELECT @virtual_machine_type=virtual_machine_type
        FROM sys.dm_os_sys_info',
        N'@virtual_machine_type int OUTPUT',
        @virtual_machine_type=@virtual_machine_type OUTPUT;
END TRY
BEGIN CATCH;
    PRINT 'This version of SQL Server does not provide virtual_machine_type.';
END CATCH;

-------------------------------------------------------------------------------

DECLARE @block_chain TABLE (
    spid				int NOT NULL,
    blocked_by			varchar(max) NOT NULL,
    PRIMARY KEY CLUSTERED (spid)
);

DECLARE @blocking TABLE (
    spid				int NOT NULL,
    blocking			varchar(max) NOT NULL,
    PRIMARY KEY CLUSTERED (spid)
);

DECLARE @locks TABLE (
    spid				int NOT NULL,
    tran_id				bigint NOT NULL,
    lock_ord			int NOT NULL,
    mode				varchar(255) NOT NULL,
    [database]			varchar(255) NOT NULL,
    [object_id]			int NOT NULL,
    [object_name]		varchar(255) NULL,
    index_id			int NOT NULL,
    index_type			tinyint NULL,
    index_name			varchar(255) NULL,
    index_filter		varchar(max) NULL,
    object_notes		varchar(255) NULL,
    obj_rows			bigint NULL,
    partition_number	 int NOT NULL,
    partition_count		int NULL,
    partition_boundary	varchar(max) NULL,
    request_owner_type	varchar(50) NOT NULL,
    wait_type			varchar(120) NULL,
    wait_time			varchar(100) NULL,
    blkd_by_spid		int NULL,
    [count]				int NULL,
    isWaiting			bit NULL,
    isBlocking			bit NULL,
    ident				int IDENTITY(1, 1) NOT NULL,
    PRIMARY KEY CLUSTERED (spid, tran_id, [object_id], index_id, partition_number, lock_ord, ident)
);

DECLARE @tran_locks TABLE (
    resource_database_id int NOT NULL,
    request_session_id	int NOT NULL,
    request_owner_id	bigint NULL,
    request_mode		nvarchar(120) NOT NULL,
    request_status		nvarchar(120) NOT NULL,
    resource_type		nvarchar(120) NOT NULL,
    request_owner_type	nvarchar(120) NULL,
    lock_owner_address	varbinary(8) NOT NULL,
    resource_associated_entity_id bigint NULL,
    ord					int NOT NULL,
    PRIMARY KEY CLUSTERED (request_session_id, ord)
);

INSERT INTO @tran_locks
SELECT resource_database_id, request_session_id, request_owner_id, request_mode, request_status,
    resource_type, request_owner_type, lock_owner_address, resource_associated_entity_id,
    ROW_NUMBER() OVER (PARTITION BY request_session_id ORDER BY lock_owner_address) AS ord
FROM sys.dm_tran_locks WITH (NOLOCK);

DECLARE @tran_session_transactions TABLE (
    transaction_id		bigint NOT NULL,
    session_id			int NOT NULL,
    is_local			bit NOT NULL,
    PRIMARY KEY CLUSTERED (transaction_id)
);

INSERT INTO @tran_session_transactions
SELECT transaction_id, session_id, is_local
FROM sys.dm_tran_session_transactions WITH (NOLOCK);

DECLARE @exec_sessions TABLE (
    session_id			int NOT NULL,
    [program_name]		nvarchar(256) NULL,
    login_name			nvarchar(256) NOT NULL,
    [status]			nvarchar(60) NOT NULL,
    last_request_start_time datetime NOT NULL,
    cpu_time			int NOT NULL,
    memory_usage		int NOT NULL,
    reads				bigint NOT NULL,
    writes				bigint NOT NULL,
    logical_reads		bigint NOT NULL,
    flags				varchar(200) NOT NULL,
    client_interface_name nvarchar(64) NULL,
    PRIMARY KEY CLUSTERED (session_id)
);

INSERT INTO @exec_sessions
SELECT session_id, [program_name], login_name, [status], last_request_start_time, cpu_time,
    memory_usage, reads, writes, logical_reads,
      'arithabort '+(CASE [arithabort] WHEN 1 THEN 'ON' ELSE 'OFF' END)+
    ', quot.id '+(CASE [quoted_identifier] WHEN 1 THEN 'ON' ELSE 'OFF' END)+
    (CASE [ansi_warnings] WHEN 0 THEN ', ansi warn OFF' ELSE '' END)+
    (CASE [ansi_padding] WHEN 0 THEN ', ansi pad OFF' ELSE '' END)+
    (CASE [ansi_nulls] WHEN 0 THEN ', nulls OFF' ELSE '' END)+
    (CASE [concat_null_yields_null] WHEN 0 THEN ', conc.null OFF' ELSE '' END) AS flags,
    LEFT(client_interface_name, CHARINDEX(' ', client_interface_name+' ')-1)
FROM sys.dm_exec_sessions WITH (NOLOCK);

DECLARE @jobs TABLE (
    job_id				uniqueidentifier NOT NULL,
    job_name			sysname NOT NULL,
    step_id				int NOT NULL,
    step_name			sysname NOT NULL,
    search_name			varchar(max) NOT NULL,
    PRIMARY KEY CLUSTERED (job_id, step_id)
);

INSERT INTO @jobs
SELECT j.job_id, j.name AS job_name, js.step_id, js.step_name, ' 0x'+
    SUBSTRING(CAST(j.job_id AS varchar(max)),  7,  2)+
    SUBSTRING(CAST(j.job_id AS varchar(max)),  5,  2)+
    SUBSTRING(CAST(j.job_id AS varchar(max)),  3,  2)+
    SUBSTRING(CAST(j.job_id AS varchar(max)),  1,  2)+
    SUBSTRING(CAST(j.job_id AS varchar(max)), 12,  2)+
    SUBSTRING(CAST(j.job_id AS varchar(max)), 10,  2)+
    SUBSTRING(CAST(j.job_id AS varchar(max)), 17,  2)+
    SUBSTRING(CAST(j.job_id AS varchar(max)), 15,  2)+
    SUBSTRING(CAST(j.job_id AS varchar(max)), 20,  4)+
    SUBSTRING(CAST(j.job_id AS varchar(max)), 25, 12)+'%:% '+
    CAST(js.step_id AS varchar(max))+')' AS search_name
FROM msdb.dbo.sysjobs AS j WITH (NOLOCK)
INNER JOIN msdb.dbo.sysjobsteps AS js WITH (NOLOCK) ON j.job_id=js.job_id;

DECLARE @exec_requests TABLE (
    session_id			int NOT NULL,
    request_id			int NOT NULL,
    database_id			smallint NOT NULL,
    transaction_isolation_level smallint NOT NULL,
    percent_complete	real NOT NULL,
    total_elapsed_time	int NOT NULL,
    command				varchar(32) NOT NULL,
    statement_start_offset int NULL,
    statement_end_offset int NULL,
    plan_handle			varbinary(64) NULL,
    _id                 int IDENTITY(1, 1) NOT NULL,
    PRIMARY KEY CLUSTERED (session_id, request_id, _id)
);

INSERT INTO @exec_requests (session_id, request_id, database_id, transaction_isolation_level, percent_complete,
    total_elapsed_time, command, statement_start_offset, statement_end_offset, plan_handle)
SELECT session_id, request_id, database_id, transaction_isolation_level, percent_complete,
    total_elapsed_time, command, statement_start_offset, statement_end_offset, plan_handle
FROM sys.dm_exec_requests WITH (NOLOCK);

DECLARE @exec_connections TABLE (
    session_id			int NOT NULL,
    client_net_address	varchar(48) NULL,
    client_tcp_port		int NULL,
    local_net_address	varchar(48) NULL,
    auth_scheme			nvarchar(80) NOT NULL,
    connect_time		datetime NOT NULL,
    num_reads			int NULL,
    num_writes			int NULL,
    most_recent_sql_handle varbinary(64),
    PRIMARY KEY CLUSTERED (session_id)
);

INSERT INTO @exec_connections
SELECT session_id, client_net_address, client_tcp_port, local_net_address, auth_scheme,
    connect_time, num_reads, num_writes, most_recent_sql_handle
FROM sys.dm_exec_connections WITH (NOLOCK)
WHERE endpoint_id!=0 AND session_id IS NOT NULL;

DECLARE @os_tasks TABLE (
    session_id          int NOT NULL,
    scheduler_id        int NOT NULL,
    PRIMARY KEY CLUSTERED (session_id, scheduler_id)
);

INSERT INTO @os_tasks
SELECT DISTINCT session_id, scheduler_id
FROM sys.dm_os_tasks
WHERE session_id IS NOT NULL AND
      scheduler_id IS NOT NULL;

DECLARE @tran_active_transactions TABLE (
    transaction_id		bigint NOT NULL,
    transaction_begin_time	datetime NOT NULL,
    transaction_type	int NOT NULL,
    transaction_state	int NOT NULL,
    PRIMARY KEY CLUSTERED (transaction_id)
);

INSERT INTO @tran_active_transactions
SELECT transaction_id, transaction_begin_time, transaction_type, transaction_state
FROM sys.dm_tran_active_transactions WITH (NOLOCK);

DECLARE @os_waiting_tasks TABLE (
    session_id			int NULL,
    blocking_session_id	int NULL,
    waiting_task_address varbinary(8) NOT NULL,
    wait_type			nvarchar(120) NULL,
    wait_duration_ms	bigint NULL,
    resource_address	varbinary(8) NULL,
    exec_context_id		int NULL,
    dupl				int NOT NULL,
    PRIMARY KEY CLUSTERED (waiting_task_address, dupl)
);

INSERT INTO @os_waiting_tasks
SELECT session_id, blocking_session_id, waiting_task_address,
    wait_type, wait_duration_ms, resource_address, exec_context_id,
    ROW_NUMBER() OVER (
        PARTITION BY waiting_task_address
        ORDER BY wait_duration_ms, resource_address) AS dupl
FROM sys.dm_os_waiting_tasks WITH (NOLOCK);

DECLARE @exec_query_memory_grants TABLE (
    session_id			int NOT NULL,
    request_id			int NOT NULL,
    requested_mb		numeric(16, 3) NOT NULL,
    granted_mb			numeric(16, 3) NULL,
    minimum_required_mb	numeric(16, 3) NOT NULL,
    used_mb				numeric(16, 3) NOT NULL,
    max_used_mb			numeric(16, 3) NOT NULL,
    ideal_mb			numeric(16, 3) NOT NULL,
    est_query_cost		numeric(16, 1) NOT NULL,
    PRIMARY KEY CLUSTERED (session_id, request_id)
);

INSERT INTO @exec_query_memory_grants
SELECT session_id, request_id,
    1.0*requested_memory_kb/1024 AS requested_mb,
    1.0*granted_memory_kb/1024 AS granted_mb,
    1.0*required_memory_kb/1024 AS minimum_required_mb,
    ISNULL(1.0*used_memory_kb/1024, 0.0) AS used_mb,
    ISNULL(1.0*max_used_memory_kb/1024, 0.0) AS max_used_mb,
    1.0*ideal_memory_kb/1024 AS ideal_mb,
    query_cost AS est_query_cost
FROM sys.dm_exec_query_memory_grants WITH (NOLOCK);

DECLARE @dm_server_services TABLE (
    _id                 tinyint IDENTITY(1, 1) NOT NULL,
    servicename         nvarchar(512) NOT NULL,
    startup_type_desc   nvarchar(512) NOT NULL,
    status_desc         nvarchar(512) NOT NULL,
    service_account     nvarchar(512) NOT NULL,
    cluster_nodename    nvarchar(512) NULL,
    PRIMARY KEY CLUSTERED (_id)
);

BEGIN TRY;
    INSERT INTO @dm_server_services
    SELECT servicename, startup_type_desc, status_desc, service_account, cluster_nodename
    FROM sys.dm_server_services;
END TRY
BEGIN CATCH;
    PRINT 'sys.dm_server_services is not supported on this version of SQL Server.';
END CATCH;

DECLARE @database_procedures TABLE (
    database_id			int NOT NULL,
    [object_id]			int NOT NULL,
    [name]				varchar(255) NOT NULL,
    PRIMARY KEY CLUSTERED (database_id, [object_id])
);

DECLARE @database_objects TABLE (
    database_id			int NOT NULL,
    [object_id]			int NOT NULL,
    index_id			int NOT NULL,
    hobt_id				bigint NOT NULL,
    [name]				varchar(255) NOT NULL,
    index_type			tinyint NULL,
    index_name			varchar(255) NULL,
    partition_number	int NOT NULL,
    [rows]				bigint NULL,
    [type_desc]			varchar(255) NOT NULL,
    is_clustered		bit NULL,
    index_filter		varchar(max) NULL,
    PRIMARY KEY CLUSTERED (database_id, [object_id], hobt_id)
);

DECLARE @files TABLE (
    database_id			int NOT NULL,
    [file_id]			int NOT NULL,
    filetype			varchar(20) NOT NULL,
    [name]				varchar(255) NOT NULL,
    drive				char(3) NOT NULL,
    [filegroup]			varchar(255) NULL,
    size_mb				numeric(18, 2) NOT NULL,
    autogrow			numeric(18, 2) NULL,
    is_percent_growth	bit NOT NULL,
    max_size_mb			numeric(18, 2) NULL,
    used_size_mb		numeric(18, 2) NULL,
    total_bytes			bigint NULL,
    available_bytes		bigint NULL,
    file_system_type	varchar(100) NULL,
    primary_replica     sysname NULL,
    [availability_mode] tinyint NULL,
    suspend_state       varchar(255) NULL,
    queue_kb            bigint NULL,
    rpo                 bigint NULL,
    PRIMARY KEY CLUSTERED (database_id, [name])
);

DECLARE @parts TABLE (
    database_id			int NOT NULL,
    [object_id]			int NOT NULL,
    index_id			int NOT NULL,
    hobt_id				bigint NULL,
    boundary_id			int NOT NULL,
    boundary			varchar(max) NULL,
    [rows]				int NULL,
    PRIMARY KEY CLUSTERED (database_id, [object_id], index_id, boundary_id)
);

DECLARE #cur CURSOR FOR
    SELECT name,
        --- Databases, schemas, tables, number of rows
        'SELECT '+CAST(database_id AS varchar(max))+', o.[object_id], ISNULL(ix.index_id, 0), p.hobt_id,
            s.name+''.''+o.name, ix.[type] AS index_type, ix.name AS index_name, p.partition_number, p.[rows], o.type_desc,
            (CASE WHEN cix.[object_id] IS NULL THEN 0 ELSE 1 END) AS is_clustered,
            ix.filter_definition
         FROM ['+[name]+'].sys.objects AS o WITH (NOLOCK)
         INNER JOIN ['+[name]+'].sys.partitions AS p WITH (NOLOCK) ON o.[object_id]=p.[object_id]
         INNER JOIN ['+[name]+'].sys.schemas AS s WITH (NOLOCK) ON o.[schema_id]=s.[schema_id]
         LEFT JOIN ['+[name]+'].sys.indexes AS ix WITH (NOLOCK) ON p.[object_id]=ix.[object_id] AND p.index_id=ix.index_id
         LEFT JOIN ['+[name]+'].sys.indexes AS cix WITH (NOLOCK) ON p.[object_id]=cix.[object_id] AND cix.[type]=1
        ' AS [sql],

        --- Database files
        'USE ['+[name]+'];
         SELECT '+CAST(database_id AS varchar(max))+', f.[file_id], f.type_desc AS filetype,
            f.name, UPPER(LEFT(f.physical_name, 3)) AS drive,
            ds.name AS [filegroup], 1.0*f.size*8/1024 AS size_mb,
            (CASE WHEN f.is_percent_growth=1 THEN 1.0*f.growth
                ELSE 1.0*f.growth*8/1024 END) AS autogrow,
            f.is_percent_growth, ROUND(1.0*NULLIF(f.max_size, -1)*8/1024, 1) AS max_size_mb,
            1.0*FILEPROPERTY(f.name, ''SpaceUsed'')*8/1024 AS used_size_mb, '+
            (CASE WHEN @version>'10.5' OR
                @version='10.5' AND CAST(SERVERPROPERTY('ProductLevel') AS varchar(10))>='SP1' THEN '
            v.total_bytes, v.available_bytes, v.file_system_type' ELSE '
            NULL AS total_bytes, NULL AS available_bytes, NULL AS file_system_type' END)+', NULL, NULL, NULL, NULL, NULL
         FROM ['+name+'].sys.database_files AS f WITH (NOLOCK)
         LEFT JOIN sys.data_spaces AS ds WITH (NOLOCK) ON f.data_space_id=ds.data_space_id'+
            (CASE WHEN @version>'10.5' OR
                   @version='10.5' AND CAST(SERVERPROPERTY('ProductLevel') AS varchar(10))>='SP1' THEN '
         CROSS APPLY sys.dm_os_volume_stats('+CAST(database_id AS varchar(max))+', f.[file_id]) AS v' ELSE '' END)+
                --- In-memory OLTP tables:
                (CASE WHEN @version>='12.0' THEN '
                 UNION ALL
         SELECT '+CAST(database_id AS varchar(max))+', -1 AS [file_id], ''IN-MEMORY'' AS filetype,
            '''' AS [name], ''RAM'' AS drive,
            '''' AS [filegroup], 1.0*SUM(xtp.allocated_bytes)/(1024*1024) AS size_mb,
            NULL AS autogrow,
            0 AS is_percent_growth, NULL AS max_size_mb,
            1.0*SUM(xtp.used_bytes)/(1024*1024) AS used_size_mb,
            NULL AS total_bytes, NULL AS available_bytes, NULL AS file_system_type, NULL, NULL, NULL, NULL, NULL
         FROM sys.dm_db_xtp_memory_consumers AS xtp
         HAVING COUNT(*)>0' ELSE '' END) AS sql2,

        --- Partitioning schemes, functions, boundaries
        'WITH spc (data_space_id, function_id, pf_name, boundary_id, boundary_value_on_right, [value])
         AS (	SELECT ps.data_space_id, pf.function_id, pf.name AS pf_name, val.boundary_id, pf.boundary_value_on_right,
                (CASE SQL_VARIANT_PROPERTY(val.[value], ''BaseType'')
                    WHEN ''date'' THEN LEFT(CONVERT(varchar(max), val.[value], 120), 10)
                    WHEN ''datetime'' THEN CONVERT(varchar(max), val.[value], 120)
                    ELSE CAST(val.[value] AS varchar(max))
                END) AS [value]
            FROM ['+[name]+'].sys.partition_range_values AS val WITH (NOLOCK)
            INNER JOIN ['+[name]+'].sys.partition_functions AS pf WITH (NOLOCK) ON val.function_id = pf.function_id
            INNER JOIN ['+[name]+'].sys.partition_schemes AS ps WITH (NOLOCK) ON pf.function_Id=ps.function_id),

             rng (pf_name, data_space_id, boundary_id, lower_rng, upper_rng)
         AS (	SELECT	ISNULL(a.pf_name, b.pf_name),
                ISNULL(a.data_space_id, b.data_space_id),
                ISNULL(a.boundary_id+1, b.boundary_id),
                a.[value]+(CASE
                    WHEN a.boundary_value_on_right=1 THEN ''<=''
                    WHEN a.boundary_value_on_right=0 THEN ''<'' END),
                (CASE	WHEN b.boundary_value_on_right=1 THEN ''<''+b.[value]
                    WHEN b.boundary_value_on_right=0 THEN ''<=''+b.[value] END)
            FROM spc AS a
            FULL JOIN spc AS b ON
                a.function_id=b.function_id AND
                a.boundary_id+1=b.boundary_id)
        SELECT '+CAST(database_id AS varchar(max))+', ix.[object_id], ix.index_id, p.hobt_id, ISNULL(rng.boundary_id, 0),
            ISNULL(rng.lower_rng, '''')+c.name+ISNULL(rng.upper_rng, '''') AS boundary, p.[rows]
        FROM rng
        INNER JOIN ['+[name]+'].sys.indexes AS ix WITH (NOLOCK) ON ix.data_space_id=rng.data_space_id
        INNER JOIN ['+[name]+'].sys.index_columns AS ic WITH (NOLOCK) ON ix.[object_id]=ic.[object_id] AND ix.index_id=ic.index_id AND ic.partition_ordinal>0
        INNER JOIN ['+[name]+'].sys.columns AS c WITH (NOLOCK) ON ic.[object_id]=c.[object_id] AND ic.column_id=c.column_id
        LEFT  JOIN ['+[name]+'].sys.partitions AS p WITH (NOLOCK) ON ix.[object_id]=p.[object_id] AND ix.index_id=p.index_id AND rng.boundary_id=p.partition_number
        ' AS sql3,

        --- Databases, schemas, tables
        'SELECT '+CAST(database_id AS varchar(max))+', o.[object_id], s.name+''.''+o.name
         FROM ['+[name]+'].sys.objects AS o WITH (NOLOCK)
         INNER JOIN ['+[name]+'].sys.schemas AS s WITH (NOLOCK) ON o.[schema_id]=s.[schema_id]
         WHERE o.[type] NOT IN (''U'', ''S'')
        ' AS sql4

    FROM sys.databases WITH (NOLOCK)
    WHERE state_desc='ONLINE' AND database_id IN (
        SELECT resource_database_id
        FROM @tran_locks);
OPEN #cur;

FETCH NEXT FROM #cur INTO @name, @sql, @sql2, @sql3, @sql4;
WHILE (@@FETCH_STATUS=0) BEGIN;
    BEGIN TRY;
        INSERT INTO @database_objects EXEC(@sql);
    END TRY
    BEGIN CATCH;
        PRINT @name+'/schema: '+ERROR_MESSAGE();
    END CATCH;

    BEGIN TRY;
        INSERT INTO @files EXEC(@sql2);
    END TRY
    BEGIN CATCH;
        PRINT @name+'/database files: '+ERROR_MESSAGE();
    END CATCH;

    BEGIN TRY;
        INSERT INTO @parts EXEC(@sql3);
    END TRY
    BEGIN CATCH;
        PRINT @name+'/partitions: '+ERROR_MESSAGE();
    END CATCH;

    BEGIN TRY;
        INSERT INTO @database_procedures EXEC(@sql4);
    END TRY
    BEGIN CATCH;
        PRINT @name+'/tables: '+ERROR_MESSAGE();
    END CATCH;

    FETCH NEXT FROM #cur INTO @name, @sql, @sql2, @sql3, @sql4;
END;

CLOSE #cur;
DEALLOCATE #cur;


-------------------------------------------------------------------------------
--- Availability groups stuff:

UPDATE f SET f.primary_replica=ags.primary_replica, f.[availability_mode]=ar.[availability_mode], f.suspend_state=x.suspend_state, f.queue_kb=x.queue_kb, f.rpo=x.rpo
FROM @files AS f
INNER JOIN sys.databases AS db ON f.database_id=db.database_id
INNER JOIN sys.availability_replicas AS ar ON db.replica_id=ar.replica_id
--INNER JOIN sys.availability_groups AS ag ON ar.group_id=ag.group_id
INNER JOIN sys.dm_hadr_availability_group_states AS ags ON ar.group_id=ags.group_id
LEFT JOIN (
    SELECT database_id, group_id, (CASE MAX(suspend_reason_desc)
                WHEN 'SUSPEND_FROM_USER' THEN 'A user manually suspended data movement'
                WHEN 'SUSPEND_FROM_PARTNER' THEN 'The database replica is suspended after a forced failover'
                WHEN 'SUSPEND_FROM_REDO' THEN 'An error occurred during the redo phase'
                WHEN 'SUSPEND_FROM_APPLY' THEN 'An error occurred when writing the log to file (see error log)'
                WHEN 'SUSPEND_FROM_CAPTURE' THEN 'An error occurred while capturing log on the primary replica'
                WHEN 'SUSPEND_FROM_RESTART' THEN 'The database replica was suspended before the database was restarted (see error log)'
                WHEN 'SUSPEND_FROM_UNDO' THEN 'An error occurred during the undo phase (see error log)'
                WHEN 'SUSPEND_FROM_REVALIDATION' THEN 'Log change mismatch is detected on reconnection (see error log)'
                WHEN 'SUSPEND_FROM_XRF_UPDATE' THEN 'Unable to find the common log point (see error log)'
                ELSE MAX(suspend_reason_desc)
                END) AS suspend_state, MAX(log_send_queue_size) AS queue_kb, DATEDIFF(second, MIN(last_commit_time), MAX(last_commit_time)) AS rpo
    FROM sys.dm_hadr_database_replica_states
    GROUP BY database_id, group_id) AS x ON f.database_id=x.database_id AND ar.group_id=x.group_id;

-------------------------------------------------------------------------------
--- Beautify names of temp tables:
UPDATE @database_objects
SET [name]=SUBSTRING(LEFT([name], CHARINDEX(REPLICATE('_', 8), [name]+REPLICATE('_', 8))-1), 5, LEN([name]))
WHERE database_id=(SELECT database_id FROM sys.databases WITH (NOLOCK) WHERE [name]='tempdb') AND
    REPLACE([name], '_', '.') LIKE 'dbo.#%'+REPLICATE('.', 8)+'[0-9A-F][0-9A-F]%[0-9A-F][0-9A-F]';

--- Beautify names of temp table indexes:
UPDATE @database_objects
SET index_name='Primary key'
WHERE database_id=(SELECT database_id FROM sys.databases WITH (NOLOCK) WHERE [name]='tempdb') AND
    LEFT(index_name, 12) LIKE 'PK__'+LEFT([name], 8);

UPDATE @database_objects
SET index_name=REPLACE(RTRIM(REPLACE(LEFT(index_name, LEN(index_name)-16), '_', ' ')), ' ', '_')
WHERE database_id=(SELECT database_id FROM sys.databases WITH (NOLOCK) WHERE [name]='tempdb') AND
    REPLACE(index_name, '_', '.') LIKE '%#%'+REPLICATE('[0-9A-F]', 16);



-------------------------------------------------------------------------------
--- Chains of spids that are being blocked, per spid:
WITH blocks (spid, blocked_by, ord)
AS (
    SELECT DISTINCT session_id AS spid, blocking_session_id AS blocked_by,
        DENSE_RANK() OVER (PARTITION BY blocking_session_id ORDER BY session_id) AS ord
    FROM @os_waiting_tasks
    WHERE blocking_session_id IS NOT NULL AND session_id!=blocking_session_id),

     list (spid, blocking, list, ord)
AS (
    SELECT blocked_by AS spid, spid AS blocking, CAST(spid AS varchar(max)) AS list, ord
    FROM blocks
    WHERE ord=1
    UNION ALL
    SELECT c.spid, c.blocking, CAST(c.list+', '+CAST(b.spid AS varchar(max)) AS varchar(max)) AS list, b.ord
    FROM list AS c
    INNER JOIN blocks AS b ON
        c.spid=b.blocked_by AND
        c.ord+1=b.ord)

INSERT INTO @blocking (spid, blocking)
SELECT spid, list AS blocking
FROM list AS l
WHERE ord=(SELECT MAX(ord) FROM list WHERE spid=l.spid);



--- Spids that are blocking other spids (reverse-lookup)
WITH blocks (spid, blocked_by)
AS (
    SELECT DISTINCT session_id AS spid, blocking_session_id AS blocked_by
    FROM @os_waiting_tasks
    WHERE blocking_session_id IS NOT NULL AND session_id!=blocking_session_id),

     chain (spid, blocked_by, chain, lvl)
AS (
    SELECT spid, blocked_by, CAST(blocked_by AS varchar(max)) AS chain, 1 AS lvl
    FROM blocks
    UNION ALL
    SELECT c.spid, b.blocked_by, CAST(c.chain+' <- '+CAST(b.blocked_by AS varchar(max)) AS varchar(max)) AS chain, lvl+1
    FROM chain AS c
    INNER JOIN blocks AS b ON b.spid=c.blocked_by)

INSERT INTO @block_chain (spid, blocked_by)
SELECT spid, MAX('<- '+chain)
FROM chain AS c
WHERE lvl=(SELECT MAX(lvl) FROM chain WHERE spid=c.spid)
GROUP BY spid;



--- Compile locks
INSERT INTO @locks
SELECT
    tl.request_session_id AS spid,
    NULLIF(tl.request_owner_id, 0) AS tran_id,
    DENSE_RANK() OVER (
        PARTITION BY tl.request_session_id, tl.request_owner_id, obj.[object_id], obj.index_id, obj.partition_number
        ORDER BY (CASE WHEN tl.request_mode='GRANT' THEN 1 ELSE 2 END), tl.request_mode
        ) AS lock_ord,
    ISNULL(NULLIF(tl.request_status, 'GRANT')+' ', '')+tl.request_mode+' '+(CASE tl.resource_type
        WHEN 'DATABASE' THEN 'db'
        WHEN 'FILE' THEN 'file'
        WHEN 'OBJECT' THEN ISNULL(LOWER(REPLACE(REPLACE(REPLACE(obj.type_desc, '_', ' '), 'SQL ', ''), 'USER ', '')), 'obj')
        WHEN 'PAGE' THEN 'page'
        WHEN 'KEY' THEN 'key'
        WHEN 'EXTENT' THEN 'extent'
        WHEN 'RID' THEN 'RID'
        WHEN 'APPLICATION' THEN 'app'
        WHEN 'METADATA' THEN 'metadata'
        WHEN 'HOBT' THEN 'HoBT'
        WHEN 'ALLOCATION_UNIT' THEN 'alloc unit'
        END) AS mode,
    db.name AS [database], ISNULL(obj.[object_id], 0), obj.name AS [object_name],
    ISNULL(obj.index_id, 0), obj.index_type, obj.index_name, obj.index_filter,
    (CASE	WHEN obj.type_desc='USER_TABLE' AND obj.is_clustered=1 THEN 'Clustered'
        WHEN obj.type_desc='USER_TABLE' THEN 'Heap'
        WHEN obj.type_desc='VIEW' AND obj.is_clustered=1 THEN 'Indexed view'
        ELSE '' END) AS object_notes,
    obj.[rows] AS obj_rows,
    ISNULL(obj.partition_number, 0), (SELECT MAX(partition_number)
            FROM @database_objects AS sub
            WHERE sub.database_id=obj.database_id AND
                sub.[object_id]=obj.[object_id] AND
                index_id=obj.index_id
            ) AS partition_count,
    parts.boundary AS partition_boundary,
    (CASE tl.request_owner_type
        WHEN 'TRANSACTION' THEN 'Trans'			    --- The request is owned by a transaction.
        WHEN 'CURSOR' THEN 'Cursor'			        --- The request is owned by a cursor.
        WHEN 'SESSION' THEN 'Session'			    --- The request is owned by a user session.
        WHEN 'SHARED_TRANSACTION_WORKSPACE' THEN 'Tran ws (shared)' --- The request is owned by the shared part of the transaction workspace.
        WHEN 'EXCLUSIVE_TRANSACTION_WORKSPACE' THEN 'Tran ws (excl)' --- The request is owned by the exclusive part of the transaction workspace.
        WHEN 'NOTIFICATION_OBJECT' THEN 'Internal'	--- The request is owned by an internal SQL Server component. This component has requested the lock manager to notify it when another component is waiting to take the lock. The FileTable feature is a component that uses this value.
        END) AS request_owner_type,
    wt.wait_type,
    dbo.fn_friendly_age(DATEADD(ms, 0-wt.wait_duration_ms, GETDATE()), GETDATE()) AS wait_time,
    wt.blocking_session_id AS blkd_by_spid,
    COUNT(*) AS [count],
    (CASE WHEN tl.request_status='WAIT' THEN 1 ELSE 0 END) AS isWaiting,
    0 AS isBlocking
FROM @tran_locks AS tl
INNER HASH JOIN sys.databases AS db WITH (NOLOCK) ON tl.resource_database_id=db.database_id
INNER HASH JOIN @tran_session_transactions AS st ON tl.request_owner_id=st.transaction_id
LEFT HASH JOIN @os_waiting_tasks AS wt ON tl.lock_owner_address=wt.resource_address
LEFT HASH JOIN @database_objects AS obj ON tl.resource_database_id=obj.database_id AND tl.resource_associated_entity_id IN (obj.[object_id], obj.hobt_id)
LEFT HASH JOIN @parts AS parts ON obj.database_id=parts.database_id AND parts.hobt_id=obj.hobt_id
WHERE tl.request_session_id!=@@SPID
GROUP BY tl.request_session_id, tl.request_owner_id, tl.request_status, tl.request_mode, tl.resource_type, db.name, obj.[object_id], obj.index_id, obj.index_type,
    obj.index_name, obj.index_filter, obj.type_desc, obj.[object_id], obj.database_id, obj.is_clustered, obj.name, obj.[rows],
    obj.partition_number, parts.boundary, tl.request_owner_type, wt.wait_type, wt.wait_duration_ms, wt.blocking_session_id;


--- Update @locks.isBlocking column.
UPDATE blocking
SET blocking.isBlocking=1
FROM @locks AS blocked
INNER JOIN @locks AS blocking ON
    blocked.[database]=blocking.[database] AND
    ISNULL(blocked.[object_id], -1)=ISNULL(blocking.[object_id], -1) AND
    ISNULL(blocked.index_id, -1)=ISNULL(blocking.index_id, -1) AND
    ISNULL(blocked.partition_number, -1)=ISNULL(blocking.partition_number, -1) AND
    blocked.tran_id!=blocking.tran_id AND
    blocked.spid!=blocking.spid AND
    blocked.isWaiting=1;



SET LOCK_TIMEOUT -1;

-------------------------------------------------------------------------------
--- 1. Server properties:
-------------------------------------------------------------------------------

SELECT
    CAST(SERVERPROPERTY('ComputerNamePhysicalNetBIOS') AS varchar(128)) AS [Physical name],
    CAST(SERVERPROPERTY('ServerName') AS varchar(128)) AS [Instance name],
    (CASE CAST(SERVERPROPERTY('IsClustered') AS bit) WHEN 1 THEN ISNULL('Cluster node '+sqlsrv.cluster_nodename, 'Clustered') ELSE 'Stand-alone' END)+
    (CASE WHEN SERVERPROPERTY('IsHadrEnabled')=1 THEN ' with Availability Groups' ELSE '' END)+
    (CASE @virtual_machine_type
        WHEN 1 THEN ' on Hypervisor'
        WHEN 2 THEN ' on virtual machine'
        ELSE '' END) AS [Configuration],
    'SQL Server '+(CASE @version
        WHEN '09.0' THEN '2005'
        WHEN '10.0' THEN '2008'
        WHEN '10.5' THEN '2008 R2'
        WHEN '11.0' THEN '2012'
        WHEN '12.0' THEN '2014'
        WHEN '13.0' THEN '2016' ELSE @version END)+' '+
        REPLACE(REPLACE(REPLACE(
            CAST(SERVERPROPERTY('Edition') AS varchar(128)), ' Edition', ''),
            'Standard', 'Std'), 'Enterprise', 'Ent') AS [Product, edition],
    CAST(SERVERPROPERTY('ProductLevel') AS varchar(128))+ISNULL(', '+
        CAST(SERVERPROPERTY('ProductUpdateLevel') AS varchar(128)), '')+' ('+
        CAST(SERVERPROPERTY('ProductVersion') AS varchar(128))+')' AS [Level, CU],
    (CASE WHEN @max_server_memory/(1024*1024)>2000000 THEN ''
          ELSE
            (CASE WHEN @min_server_memory<@max_server_memory AND @min_server_memory>0
                THEN LTRIM(dbo.fn_friendly_size(@min_server_memory))+' - '
                ELSE '' END)+
            LTRIM(dbo.fn_friendly_size(@max_server_memory))+
            (CASE WHEN @max_server_memory!=@physical_memory THEN ' / ' ELSE '' END) END)+
        LTRIM(dbo.fn_friendly_size(@physical_memory)) AS [Min - max / physical mem],
--	dbo.fn_friendly_size(@virtual_memory) AS [Virtual mem],
    CAST(sysinfo.cpu_count/sysinfo.hyperthread_ratio AS varchar(10))+
        ISNULL('x'+CAST(NULLIF(sysinfo.hyperthread_ratio, 1) AS varchar(10)), '')+
        ISNULL(' ('+CAST((SELECT NULLIF(MAX(memory_node_id), 0)+1
                          FROM sys.dm_os_memory_clerks
                          WHERE memory_node_id<64) AS varchar(10))+' NUMA)', '') AS [Core count],
    ISNULL(CAST(NULLIF(@max_degree_of_parallelism, 0) AS varchar(10)), '-') AS [MaxDOP],
    dbo.fn_friendly_age(sysinfo.sqlserver_start_time, GETDATE()) AS Uptime,
    CAST(SERVERPROPERTY('Collation') AS varchar(128)) AS [Server collation],
    sqlsrv.service_account AS [Service acct],
--  sqlagt.service_account AS [Agent svc acct],
    sqlagt.status_desc+' ('+sqlagt.startup_type_desc+')' AS [SQL Server Agent]
FROM sys.dm_os_sys_info AS sysinfo WITH (NOLOCK)
LEFT JOIN @dm_server_services AS sqlsrv ON sqlsrv.servicename LIKE 'SQL Server (%'
LEFT JOIN @dm_server_services AS sqlagt ON sqlagt.servicename LIKE 'SQL Server Agent (%';



-------------------------------------------------------------------------------
--- 2. Display database file usages:
-------------------------------------------------------------------------------

SELECT
    db.name AS [Database],
    UPPER(LEFT(f.filetype, 1))+LOWER(SUBSTRING(f.filetype, 2, 100)) AS [Type],
    COALESCE(
        (CASE WHEN f.primary_replica=@@SERVERNAME THEN 'Primary AG replica' WHEN f.primary_replica IS NOT NULL THEN (CASE f.[availability_mode] WHEN 1 THEN 'Synchronous AG replica' WHEN 0 THEN 'Async AG replica' ELSE '?' END) END),
        LEFT(m.mirroring_role_desc, 1)+LOWER(SUBSTRING(m.mirroring_role_desc, 2, 100)+
        ', '+REPLACE(m.mirroring_state_desc, '_', ' '))+
        (CASE m.mirroring_safety_level WHEN 1 THEN ' (async)' WHEN 2 THEN '(sync)' ELSE '(unknown)' END), '') AS [Mirror/AG],
    SUBSTRING(
        ISNULL(', '+f.suspend_state, '')+
        ISNULL(', '+LTRIM(dbo.fn_friendly_size(NULLIF(f.queue_kb, 0)*1024))+' queue', '')+
        ISNULL(', '+LTRIM(dbo.fn_friendly_age('00:00:00', DATEADD(second, NULLIF(f.rpo, 0), '00:00:00')))+' RPO', ''),
        3, 1000) [AG state],
    (CASE WHEN f.filetype='LOG' AND db.log_reuse_wait_desc!='NOTHING' THEN LEFT(db.log_reuse_wait_desc, 1)+LOWER(SUBSTRING(REPLACE(db.log_reuse_wait_desc, '_', ' '), 2, 1000)) ELSE '' END) AS [Log wait],
    UPPER(LEFT(db.recovery_model_desc, 1))+LOWER(SUBSTRING(db.recovery_model_desc, 2, 100)) AS [Recovery model],
    f.name AS [File name],
    dbo.fn_friendly_size(f.size_mb*@mb) AS [Allocated size], ISNULL((CASE
                WHEN f.filetype='IN-MEMORY' THEN 'n/a'
                WHEN f.is_percent_growth=1 THEN dbo.fn_format_number(NULLIF(f.autogrow, 0), 1)+'%'
        ELSE dbo.fn_friendly_size(NULLIF(f.autogrow, 0)*1.0*@mb) END), 'None') AS [Autogrow],
    (CASE WHEN f.max_size_mb=0 THEN ''
        WHEN f.max_size_mb IS NULL AND f.filetype='Rows' AND CAST(SERVERPROPERTY('Edition') AS varchar(128)) LIKE '%Express edition%' AND @version>='10.50' THEN dbo.fn_friendly_size(10*@gb)+' (Express ed.)'
        WHEN f.max_size_mb IS NULL AND f.filetype='Rows' AND CAST(SERVERPROPERTY('Edition') AS varchar(128)) LIKE '%Express edition%' THEN dbo.fn_friendly_size(4*@gb)+' (Express ed.)'
        WHEN f.max_size_mb IS NULL AND f.filetype='IN-MEMORY' THEN 'n/a'
                WHEN f.max_size_mb IS NULL THEN '('+ISNULL(f.file_system_type, 'OS')+' max)'
        WHEN f.max_size_mb=268435456/128 THEN '(Log max, 2 TB)'
        ELSE ISNULL(dbo.fn_friendly_size(f.max_size_mb*@mb), '') END) AS [Max file size],
    ISNULL(dbo.fn_friendly_size(f.used_size_mb*@mb), '') AS [File usage],
    ISNULL(dbo.fn_format_number(100.0*f.used_size_mb/f.size_mb, 2)+'%', '') AS [File usage %],
    f.drive AS [Drive],
    ISNULL(LTRIM(dbo.fn_friendly_size(1.0*f.available_bytes))+' of '+
           LTRIM(dbo.fn_friendly_size(1.0*f.total_bytes)), '') AS [Free disk space]
FROM @files AS f
INNER JOIN master.sys.databases AS db WITH (NOLOCK) ON db.database_id=f.database_id
INNER JOIN master.sys.database_mirroring AS m WITH (NOLOCK) ON db.database_id=m.database_id
WHERE f.database_id IN (
    SELECT database_id
    FROM @exec_requests
    UNION
    SELECT DISTINCT resource_database_id
    FROM @tran_locks
    WHERE request_session_id IN (
        SELECT session_id
        FROM @exec_sessions
        WHERE login_name=SUSER_SNAME()))
ORDER BY db.name, (CASE f.filetype
    WHEN 'ROWS' THEN 0
    WHEN 'LOG' THEN 1
    WHEN 'FILESTREAM' THEN 2
    WHEN 'IN-MEMORY' THEN 3 ELSE 0 END), f.name;



-------------------------------------------------------------------------------
--- 3. Display all sessions:
-------------------------------------------------------------------------------

SELECT
    xc.session_id AS SPID,
    ISNULL('"'+job.job_name+'", step '+CAST(job.step_id AS varchar(max))+' "'+job.step_name+'"',
        (CASE xs.[program_name]
            WHEN 'Microsoft SQL Server Management Studio - Query' THEN 'SSMS Query'
            WHEN 'Microsoft SQL Server Management Studio' THEN 'SSMS'
            ELSE xs.[program_name]
            END)) AS [Application],
--	xs.client_interface_name AS [Interface],
--	ISNULL(NULLIF(xc.client_net_address, xc.local_net_address), 'local')+ISNULL(':'+CAST(xc.client_tcp_port AS varchar(max)), '') AS [Client addr],
    xs.login_name+ISNULL(' ('+xc.auth_scheme+')', '') AS [Login name (auth)],
    dbo.fn_friendly_age(xc.connect_time, GETDATE()) AS [Conn. age],
    ISNULL(dbo.fn_friendly_size(NULLIF(xs.logical_reads*8192, 0)), '') AS [Logical reads],
    ISNULL(dbo.fn_friendly_size(NULLIF(xs.reads*8192, 0)), '') AS [Reads],
    ISNULL(dbo.fn_friendly_size(NULLIF(xs.writes*8192, 0)), '') AS [Writes],
    ISNULL(dbo.fn_friendly_age(0, DATEADD(ms, NULLIF(xs.cpu_time, 0), 0)), '') AS [CPU time],
    ISNULL(NULLIF(xs.[status], 'sleeping'), '') AS [State],
    ISNULL(CAST(NULLIF(trn.[count], 0) AS varchar(10)), '') AS [Tran count],
    ISNULL(blocking.blocking, '') AS [Blocking],
    ISNULL(chain.blocked_by, '') AS [Blocked by],
    ISNULL(SUBSTRING(cur.x.value('.', 'varchar(1000)'), 3, 1000), '') AS [Cursors],
    ISNULL(CAST(NULLIF((SELECT COUNT(*)
        FROM @os_tasks AS t
        WHERE t.session_id=xc.session_id), 0) AS varchar(10)), '') AS [Schedulers (DOP)],
    (CASE WHEN ISNULL(trn.[count], 0)>0 AND xs.[status]='sleeping' THEN dbo.fn_friendly_age(xs.last_request_start_time, GETDATE()) ELSE '' END) AS [Abandoned?],
    xs.flags AS [Connection/ANSI flags]
FROM @exec_connections AS xc
LEFT JOIN @exec_sessions AS xs ON xc.session_id=xs.session_id
LEFT JOIN @jobs AS job ON xs.[program_name] LIKE '%'+job.search_name+'%'
LEFT JOIN @block_chain AS chain ON chain.spid=xc.session_id
LEFT JOIN @blocking AS blocking ON blocking.spid=xc.session_id
LEFT JOIN (
    SELECT session_id, COUNT(*) AS [count]
    FROM @tran_session_transactions
    GROUP BY session_id) AS trn ON xc.session_id=trn.session_id
CROSS APPLY (
    SELECT ', '+[name]
    FROM sys.dm_exec_cursors(xc.session_id)
    FOR XML PATH(''), TYPE) AS cur(x)
WHERE xc.session_id!=@@SPID
ORDER BY (CASE
    WHEN xs.[status] NOT IN ('sleeping', 'dormant') OR ISNULL(trn.[count], 0)>0 THEN 1
    ELSE 2 END), xc.session_id;



-------------------------------------------------------------------------------
--- 4. Running queries:
-------------------------------------------------------------------------------

SELECT
    xc.session_id AS SPID,
    ISNULL('"'+job.job_name+'", step '+CAST(job.step_id AS varchar(max))+' "'+job.step_name+'"',
        (CASE xs.[program_name]
            WHEN 'Microsoft SQL Server Management Studio - Query' THEN 'SSMS Query'
            WHEN 'Microsoft SQL Server Management Studio' THEN 'SSMS'
            ELSE xs.[program_name]
            END)) AS [Application],
    ISNULL(dbobj.name, '') AS [Proc],
    (CASE WHEN xs.[status] NOT IN ('sleeping', 'dormant') THEN (CASE WHEN cmd.[encrypted]=1
        THEN xr.command+' (encrypted)'
        ELSE COALESCE(
            SUBSTRING(cmd.[text], xr.statement_start_offset/2, NULLIF(xr.statement_end_offset, -1)/2-xr.statement_start_offset/2),
            cmd.[text],
            xr.command COLLATE database_default,
            '') END) ELSE '('+xs.[status]+')' END) AS [Command/T-SQL],
    (CASE WHEN xs.[status]!='sleeping' THEN dbo.fn_friendly_age(xs.last_request_start_time, GETDATE()) ELSE '' END) AS [Stmt age],
    ISNULL(dbo.fn_friendly_size(mem.max_used_mb)+(CASE WHEN mem.max_used_mb<mem.granted_mb
        THEN ' of '+LTRIM(dbo.fn_friendly_size(mem.granted_mb*@mb))
        ELSE '' END)+(CASE WHEN mem.granted_mb<mem.requested_mb
        THEN ' ('+LTRIM(dbo.fn_friendly_size(mem.requested_mb*@mb))+' requested)'
        ELSE '' END), '') AS [Max used/granted memory],
    ISNULL(dbo.fn_friendly_size(mem.used_mb), '') AS [Used mem],
    ISNULL(dbo.fn_friendly_size(NULLIF(mem.ideal_mb, mem.granted_mb)), '') AS [Ideal mem],
    ISNULL(dbo.fn_format_number(mem.est_query_cost, 2), '') AS [Est. cost],
    ISNULL(dbo.fn_format_number(NULLIF(xr.percent_complete, 0.0), 1)+'%', '') AS [Progress],
    ISNULL(dbo.fn_friendly_age(GETDATE(), DATEADD(ms, 100.0*xr.total_elapsed_time/NULLIF(xr.percent_complete, 0.0), xs.last_request_start_time)), '') AS [Est remaining],
    [plan].query_plan AS [Query plan]
FROM @exec_connections AS xc
CROSS APPLY sys.dm_exec_sql_text(xc.most_recent_sql_handle) AS cmd
LEFT JOIN @exec_sessions AS xs ON xc.session_id=xs.session_id
LEFT JOIN @jobs AS job ON xs.[program_name] LIKE '%'+job.search_name+'%'
LEFT JOIN @exec_requests AS xr ON xc.session_id=xr.session_id
OUTER APPLY sys.dm_exec_query_plan(xr.plan_handle) AS [plan]
LEFT JOIN @block_chain AS chain ON chain.spid=xc.session_id
LEFT JOIN @blocking AS blocking ON blocking.spid=xc.session_id
LEFT JOIN @exec_query_memory_grants AS mem ON xc.session_id=mem.session_id
LEFT JOIN @database_procedures AS dbobj ON dbobj.database_id=cmd.dbid AND dbobj.[object_id]=cmd.objectid
WHERE xc.session_id!=@@SPID AND (
    xs.[status]!='sleeping' OR
    xc.session_id IN (SELECT session_id FROM @tran_session_transactions))
ORDER BY xc.session_id



-------------------------------------------------------------------------------
--- 5. Display open transactions:
-------------------------------------------------------------------------------

SELECT
    st.session_id AS SPID,
    act.transaction_id AS [Transaction],
    dbo.fn_friendly_age(act.transaction_begin_time, GETDATE()) AS [Transaction age],
    REPLACE((CASE st.is_local
            WHEN 0 THEN 'Distr '
            WHEN 1 THEN 'Local ' END)+
        (CASE act.transaction_type
            WHEN 1 THEN 'r/w'
            WHEN 2 THEN 'read'
            WHEN 3 THEN 'sys'
            WHEN 4 THEN 'distr'
            END), 'Distr distr', 'Distr') AS [Transaction type],
    (CASE act.transaction_state
        WHEN 0 THEN 'None'	        --- The transaction has not been completely initialized yet.
        WHEN 1 THEN 'Init'	        --- The transaction has been initialized but has not started.
        WHEN 2 THEN 'Active'	    --- The transaction is active.
        WHEN 3 THEN 'Ended'	        --- The transaction has ended. This is used for read-only transactions.
        WHEN 4 THEN 'Distr commit'  --- The commit process has been initiated on the distributed transaction. This is for distributed transactions only. The distributed transaction is still active but further processing cannot take place.
        WHEN 5 THEN 'Prepared'	    --- The transaction is in a prepared state and waiting resolution.
        WHEN 6 THEN 'Committed'	    --- The transaction has been committed.
        WHEN 7 THEN 'Rolling back'  --- The transaction is being rolled back.
        WHEN 8 THEN 'Rolled back'   --- The transaction has been rolled back.
        END) AS [State],
    (CASE xr.transaction_isolation_level
        WHEN 0 THEN '?'
        WHEN 1 THEN 'Read uncommitted'
        WHEN 2 THEN 'Read committed'
        WHEN 3 THEN 'Repeatable read'
        WHEN 4 THEN 'Serializable'
        WHEN 5 THEN 'Snapshot'
        ELSE ISNULL(CAST(xr.transaction_isolation_level AS varchar(10)), '')
        END) AS [Isolation level],
    ISNULL(CAST(dbo.fn_friendly_age(0, DATEADD(ms, (
        SELECT AVG(wt.wait_duration_ms)
        FROM @os_waiting_tasks AS wt
        WHERE wt.session_id=wt.blocking_session_id AND
            wt.session_id=st.session_id AND
            wt.wait_type='CXPACKET'), 0)) AS varchar(20)), 'None') AS [Avg cxPkt wait]
FROM @tran_session_transactions AS st
INNER JOIN @tran_active_transactions AS act ON st.transaction_id=act.transaction_id
LEFT JOIN @exec_requests AS xr ON st.session_id=xr.session_id
WHERE st.session_id!=@@SPID
ORDER BY st.session_id, act.transaction_id;



-------------------------------------------------------------------------------
--- 6. Display all locks in all sessions and databases:
-------------------------------------------------------------------------------

WITH rcte (spid, tran_id, lock_ord, mode, [count], [database], [object_id], [object_name], index_id, index_type, index_name, index_filter,
       partition_number, partition_count, partition_boundary, obj_rows, request_owner_type, wait_type, wait_time, isBlocking, isWaiting, lock_descr)
AS (
    SELECT spid, tran_id, lock_ord, mode, [count], [database], [object_id], [object_name], index_id, index_type, index_name, index_filter,
        partition_number, partition_count, partition_boundary, obj_rows, request_owner_type, wait_type, wait_time, isBlocking, isWaiting,
        CAST((CASE WHEN mode LIKE '%table' THEN '' ELSE LTRIM(ISNULL(dbo.fn_format_number(NULLIF([count], 1), 0)+' ', '')) END)+mode AS varchar(max))
    FROM @locks
    WHERE lock_ord=1
    UNION ALL
    SELECT rcte.spid, rcte.tran_id, lck.lock_ord, lck.mode, lck.[count], rcte.[database], rcte.[object_id], rcte.[object_name], rcte.index_id, rcte.index_type, rcte.index_name, rcte.index_filter,
        rcte.partition_number, rcte.partition_count, rcte.partition_boundary, rcte.obj_rows, rcte.request_owner_type, rcte.wait_type, rcte.wait_time,
        CAST((CASE WHEN 1 IN (rcte.isBlocking, lck.isBlocking) THEN 1 ELSE 0 END) AS bit),
        CAST((CASE WHEN 1 IN (rcte.isWaiting, lck.isWaiting) THEN 1 ELSE 0 END) AS bit),
        CAST(rcte.lock_descr+', '+(CASE WHEN lck.mode LIKE '%table' THEN '' ELSE LTRIM(ISNULL(dbo.fn_format_number(NULLIF(lck.[count], 1), 0)+' ', '')) END)+lck.mode AS varchar(max))
    FROM @locks AS lck
    INNER JOIN rcte ON
        rcte.lock_ord+1=lck.lock_ord AND
        rcte.spid=lck.spid AND
        rcte.tran_id=lck.tran_id AND
        rcte.[database]=lck.[database] AND
        rcte.[object_id]=lck.[object_id] AND
        ISNULL(rcte.index_id, -1)=ISNULL(lck.index_id, -1) AND
        rcte.partition_number=lck.partition_number)

SELECT spid AS SPID, tran_id AS [Transaction], lock_descr AS [Lock types],
    [database] AS [Database],
    ISNULL([object_name], '') AS [Object],
    ISNULL((CASE
        WHEN index_name='Primary key' AND index_id=1 THEN 'Primary key, clustered'
        WHEN index_type=5 THEN index_name+' (clustered colstore)'
        WHEN index_type=6 THEN index_name+' (colstore)'
        WHEN index_type=7 THEN index_name+' (hash)'
        WHEN index_id=1 THEN index_name+' (clustered)'
        WHEN index_id=0 OR index_id IS NULL THEN index_name+' (heap)' ELSE index_name END)+ISNULL(' '+index_filter, ''), '') AS [Index],
    ISNULL(STR(NULLIF(partition_number, 0), 4, 0)+'/'+CAST(NULLIF(partition_count, 1) AS varchar(10)), '') AS [Part'n],
    ISNULL(partition_boundary, '') AS [..bounds],
    ISNULL(dbo.fn_format_number(obj_rows, 0), '') AS [Est. object rows],
    request_owner_type AS [Req/trans owned by],
    ISNULL((CASE wait_type
        WHEN 'LCK_M_SCH_S' THEN 'Schema stability'
        WHEN 'LCK_M_SCH_M' THEN 'Schema modification'
        WHEN 'LCK_M_S' THEN	    'Share'
        WHEN 'LCK_M_U' THEN	    'Update'
        WHEN 'LCK_M_X' THEN	    'Exclusive'
        WHEN 'LCK_M_IS' THEN    'Intent-Share'
        WHEN 'LCK_M_IU' THEN    'Intent-Update'
        WHEN 'LCK_M_IX' THEN    'Intent-Exclusive'
        WHEN 'LCK_M_SIU' THEN   'Shared intent to update'
        WHEN 'LCK_M_SIX' THEN   'Share-Intent-Exclusive'
        WHEN 'LCK_M_UIX' THEN   'Update-Intent-Exclusive'
        WHEN 'LCK_M_BU' THEN    'Bulk Update'
        WHEN 'LCK_M_RS_S' THEN  'Range-share-share'
        WHEN 'LCK_M_RS_U' THEN  'Range-share-Update'
        WHEN 'LCK_M_RI_NL' THEN 'Range-Insert-NULL'
        WHEN 'LCK_M_RI_S' THEN  'Range-Insert-Shared'
        WHEN 'LCK_M_RI_U' THEN  'Range-Insert-Update'
        WHEN 'LCK_M_RI_X' THEN  'Range-Insert-Exclusive'
        WHEN 'LCK_M_RX_S' THEN  'Range-exclusive-Shared'
        WHEN 'LCK_M_RX_U' THEN  'Range-exclusive-update'
        WHEN 'LCK_M_RX_X' THEN  'Range-exclusive-exclusive'
        ELSE wait_type END), '') AS [Wait type],
    ISNULL(wait_time, '') AS [Wait time],
    (CASE WHEN isBlocking=1 THEN 'Blocking' ELSE '' END)+
    (CASE WHEN isBlocking=1 AND isWaiting=1 THEN ', ' ELSE '' END)+
    (CASE WHEN isWaiting=1 THEN 'Blocked' ELSE '' END) AS [Blocking/blocked]
FROM rcte
WHERE lock_ord=(SELECT MAX(lock_ord) FROM rcte AS x
        WHERE x.spid=rcte.spid AND x.tran_id=rcte.tran_id AND
            x.[database]=rcte.[database] AND
            ISNULL(x.[object_id], -1)=ISNULL(rcte.[object_id], -1) AND
            ISNULL(x.index_id, -1)=ISNULL(rcte.index_id, -1) AND
            ISNULL(x.partition_number, -1)=ISNULL(rcte.partition_number, -1))
ORDER BY spid, tran_id, [database], [object_name], index_id, partition_number, mode;



-------------------------------------------------------------------------------
--- Clean up:
-------------------------------------------------------------------------------

IF (XACT_STATE()!=-1 AND EXISTS (SELECT [object_id] FROM sys.objects WHERE [name]='fn_friendly_size'))
    DROP FUNCTION dbo.fn_friendly_size;

IF (XACT_STATE()!=-1 AND EXISTS (SELECT [object_id] FROM sys.objects WHERE [name]='fn_format_number'))
    DROP FUNCTION dbo.fn_format_number;

IF (XACT_STATE()!=-1 AND EXISTS (SELECT [object_id] FROM sys.objects WHERE [name]='fn_friendly_age'))
    DROP FUNCTION dbo.fn_friendly_age;




-------------------------------------------------------------------------------
--- CATCH
-------------------------------------------------------------------------------

END TRY
BEGIN CATCH;

    IF (EXISTS (SELECT session_id FROM sys.dm_exec_cursors(@@SPID))) BEGIN;
        CLOSE #cur;
        DEALLOCATE #cur;
    END;

    THROW;

    IF (@@TRANCOUNT!=0)
        ROLLBACK TRANSACTION;
    RETURN;

END CATCH;

ROLLBACK TRANSACTION;
