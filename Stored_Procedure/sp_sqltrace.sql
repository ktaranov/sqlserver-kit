/*---------------------------------------------------------------------
  $Header: /WWW/sqlutil/sqltrace.sp 7     16-02-17 21:51 Sommar $

  sp_sqltrace - Run an SQL batch or snoop another process. Trace it.
  Analyse the trace. Written by Lee Tudor.

  Copyright © 2008-2012 Lee Tudor.

  $History: sqltrace.sp $
 * 
 * *****************  Version 7  *****************
 * User: Sommar       Date: 16-02-17   Time: 21:51
 * Updated in $/WWW/sqlutil
 * Fixed overflow error when @snoop_time exceeded 2147 seconds.
 *
 * *****************  Version 6  *****************
 * User: Sommar       Date: 15-03-15   Time: 22:36
 * Updated in $/WWW/sqlutil
 *
 * *****************  Version 5  *****************
 * User: Sommar       Date: 12-10-27   Time: 22:34
 * Updated in $/WWW/sqlutil
 * Fixed error in the deployment header.
 *
 * *****************  Version 4  *****************
 * User: Sommar       Date: 12-10-27   Time: 18:53
 * Updated in $/WWW/sqlutil
 * Major overhaul:
 * * Renamed to sp_sqltrace, so you can put it in master and use it
 * anywhere.
 * * If @batch is a number => Snoop that spid.
 * * If @batch is a GUID => Reanalyse an existing file, for instance with
 * different sort order.
 * * On SQL 2008 and later waitstats information is collected by default
 * and the waits are mapped to statements.
 * * The min parameters have been renamed.
 * * Pararameters have been added to control size and directory for trace
 * files.
 * * New parameters to control how and which plans that are displayed in
 * result set.
 *
 * *****************  Version 3  *****************
 * User: Sommar       Date: 10-08-21   Time: 22:03
 * Updated in $/WWW/sqlutil
 * Behzad Sadeghi pointed out that plans were missing for dynamic SQL
 * invoked through sp_executesql, but not EXEC(). This was due to an
 * inconsistency in SQL Server, which I have reported on Connect.With help
 * Behzad I have implemented a workaround for the issue.
 *
 * *****************  Version 2  *****************
 * User: Sommar       Date: 08-11-29   Time: 23:29
 * Updated in $/WWW/sqlutil
 * First release on the web site.
---------------------------------------------------------------------*/
IF object_id('dbo.sp_sqltrace') IS NULL
      EXEC ('CREATE PROCEDURE dbo.sp_sqltrace AS RETURN')
GO


ALTER PROCEDURE dbo.sp_sqltrace
   @batch            nvarchar(max),             -- sql batch to analyse, @@SPID to snoop, GUID to replay
   @minimum_reads    bigint       = 1,          -- min reads (logical)
   @minimum_cpu      int          = 0,          -- min cpu Duration (milliseconds)
   @minimum_duration bigint       = 0,          -- min Duration (microseconds)
   @factor           varchar(50)  = 'Duration', -- % (Duration, Reads, Writes, Cpu)
   @order            varchar(50)  = '',         -- order (Duration, Reads, Writes, Cpu)
   @plans            varchar(50)  = '',         -- include query plans - intensive (Actual, Estimated)
   @group_plans      bit          = 0,          -- removes guery plan parameteters for grouping
   @plan_reads       int          = 1,          -- include only plans which do this many reads
   @rollback         bit          = 0,          -- run in a transaction and rollback
   @trace_timeout    int          = 300,        -- set a maximum trace duration (seconds)
   @snoop_time       int          = 10,         -- For how long time a spid should be snooped.
   @server_directory varchar(100) = 'c:\temp\', -- SQL server directory to write the trace files
   @file_size        bigint       = 10,         -- Size in megabytes per trace file
   @show_waits       bit          = NULL
AS
BEGIN
   SET NOCOUNT ON;
   DECLARE  @sql_version      int,
            @snooping         bit,
            @trace_id         int,
            @spid             int,
            @file_path        nvarchar(256),
            @file_name        nvarchar(100),
            @plan             int,
            @on               bit,
            @stop_time        datetime,
            @time_offset      int,
            @total            bigint,
            @compile_count    int,
            @compile_cpu      int,
            @compile_duration int,
            @eventsessname    sysname,
            @event_sql        nvarchar(MAX),
            @minnestlevel     smallint;

   CREATE TABLE #Results (
      [timestamp]        datetime      NOT NULL,
      [event_class]      smallint      NOT NULL,
      [sub_class]        smallint      NULL,
      [text_data]        nvarchar(max) COLLATE Latin1_General_BIN2 NOT NULL,
      [routine_name]     nvarchar(128) COLLATE Latin1_General_BIN2 NOT NULL,
      [nesting]          smallint      NULL,
      [line_number]      smallint      NULL,
      [duration]         bigint        NULL,
      [reads]            int           NULL,
      [cpu]              int           NULL,
      [writes]           int           NULL,
      [compile_count]    int           NULL,
      [compile_cpu]      int           NULL,
      [compile_duration] bigint        NULL,
      [xplan]            xml           NULL,
      csum               AS checksum(nesting, routine_name, line_number, text_data),
      [sequence]         bigint        NOT NULL,
      [xplan_sequence]   bigint        NULL,
      PRIMARY KEY(event_class, sequence)
   );

   CREATE TABLE #xe_file (record xml NOT NULL,
                          rowno  int NOT NULL);

   CREATE TABLE #Waits (
      [wait_type]       varchar(100)  NOT NULL,
      [duration]        bigint        NOT NULL,
      [signal_duration] bigint        NOT NULL,
      [text_data]       nvarchar(max)
           COLLATE Latin1_General_BIN2  NULL DEFAULT(''),
      [routine_name]    nvarchar(128)
           COLLATE Latin1_General_BIN2 NULL DEFAULT(''),
      [nesting]         smallint      NULL DEFAULT(0),
      [line_number]     smallint      NULL DEFAULT(0),
      [csum]            int           NOT NULL,
      [id]              int           NOT NULL
      PRIMARY KEY([csum], [wait_type], [id])
   );

   CREATE TABLE #wait_types (wait_id   varchar(20) COLLATE Latin1_General_BIN2 NOT NULL PRIMARY KEY,
                             wait_type varchar(100) NOT NULL);

   WITH version_string (version) AS (
        SELECT cast(serverproperty('ProductVersion') AS nvarchar(128))
   )
   SELECT  @sql_version = cast(substring(version, 1, charindex('.', version) - 1) AS int)
   FROM    version_string

   IF @sql_version < 10
      SET @show_waits = 0;

   IF @server_directory NOT LIKE '%\'
      SELECT @server_directory = @server_directory + '\'

   -- Are we replaying a trace guid, snooping another spid, or tracing ourselves?
   IF @batch LIKE '________[-=]____[-=]____[-=]____[-=]____________'
   BEGIN
      SELECT @file_path = @server_directory + @batch,
             @snooping = CASE WHEN @batch LIKE '%=%' THEN 1 ELSE 0 END;
   END
   ELSE IF @batch NOT LIKE '%[^0-9]%'
   BEGIN
      SELECT   @snooping = 1,
               @spid = @batch,
               @batch = 'WAITFOR DELAY ' +
                        QUOTENAME(convert(char(8),
                               dateadd(SECOND, convert(int, @snoop_time),
                                               '00:00:00'), 108), '''');
      IF @snoop_time >= @trace_timeout
         SELECT @trace_timeout = @snoop_time + 2
   END ELSE
      SELECT @snooping = 0,
         @spid = @@spid;

   IF @file_path IS NOT NULL
      GOTO do_analysis

   IF @show_waits IS NULL
      SELECT @show_waits = CASE WHEN @plans > '' THEN 0 ELSE 1 END

   SELECT @on = 1,
      @file_name = replace(cast(newid() as char(36)), '-', CASE @snooping WHEN 1 THEN '=' ELSE '-' END),
      @file_path = @server_directory + @file_name,
      @plan = CASE lower(@plans)
                    WHEN 'actual'    THEN 146
                    WHEN 'estimated' THEN 122
              END,
      @stop_time = dateadd(second, @trace_timeout, getdate()),
      @eventsessname = 'sqlTraceWaits_' + convert(varchar, @@spid);

   PRINT 'EXEC sp_sqltrace ''' + @file_name + '''' +
      CASE WHEN @server_directory = 'c:\temp\' THEN '' ELSE ', @server_directory = '+ QUOTENAME(@server_directory, '''') END +
      CASE WHEN @show_waits = 1 THEN ', @show_waits = 1' ELSE '' END +
      CASE WHEN @plans > '' THEN ', @plans = ' + QUOTENAME(@plans, '''') ELSE '' END;

   EXEC sp_trace_create @trace_id output, 2, @file_path, @file_size, @stop_time;

   IF @plan IS NOT NULL BEGIN
      EXEC sp_trace_setevent @trace_id, @plan,  1, @on;   -- XML Plan
      EXEC sp_trace_setevent @trace_id, @plan,  5, @on;   -- XML Plan / Line
      EXEC sp_trace_setevent @trace_id, @plan, 34, @on;   -- XML Plan / ObjectName
      EXEC sp_trace_setevent @trace_id, @plan, 51, @on;   -- XML Plan / EventSequence
      EXEC sp_trace_setevent @trace_id, @plan, 15, @on;   -- XML Plan / EndTime
   END

   EXEC sp_trace_setevent @trace_id, 45, 51, @on;   -- SP:StmtCompleted / EventSeq
   EXEC sp_trace_setevent @trace_id, 41, 51, @on;   -- SQL:StmtCompleted / EventSeq
   EXEC sp_trace_setevent @trace_id,166, 51, @on;   -- SQL:Stmtcompile / EventSeq
   EXEC sp_trace_setevent @trace_id,166, 21, @on;   -- SQL:Stmtcompile / Subclass
   EXEC sp_trace_setevent @trace_id,166,  1, @on;   -- SQL:StmtCompile / TextData
   EXEC sp_trace_setevent @trace_id, 45,  1, @on;   -- SP:StmtCompleted / TextData
   EXEC sp_trace_setevent @trace_id, 41,  1, @on;   -- SQL:StmtCompleted / TextData
   EXEC sp_trace_setevent @trace_id, 45, 13, @on;   -- SP:StmtCompleted / Duration
   EXEC sp_trace_setevent @trace_id, 41, 13, @on;   -- SQL:StmtCompleted / Duration
   EXEC sp_trace_setevent @trace_id, 45, 16, @on;   -- SP:StmtCompleted / Reads
   EXEC sp_trace_setevent @trace_id, 41, 16, @on;   -- SQL:StmtCompleted / Reads
   EXEC sp_trace_setevent @trace_id, 45, 17, @on;   -- SP:StmtCompleted / Writes
   EXEC sp_trace_setevent @trace_id, 41, 17, @on;   -- SQL:StmtCompleted / Writes
   EXEC sp_trace_setevent @trace_id, 45, 18, @on;   -- SP:StmtCompleted / cpu
   EXEC sp_trace_setevent @trace_id, 41, 18, @on;   -- SQL:StmtCompleted / cpu
   EXEC sp_trace_setevent @trace_id, 45,  5, @on;   -- SP:StmtCompleted / Line
   EXEC sp_trace_setevent @trace_id, 41,  5, @on;   -- SQL:StmtCompleted / Line
   EXEC sp_trace_setevent @trace_id, 45, 15, @on;   -- SP:StmtCompleted / EndTime
   EXEC sp_trace_setevent @trace_id, 41, 15, @on;   -- SQL:StmtCompleted / EndTime
   EXEC sp_trace_setevent @trace_id, 45, 34, @on;   -- SP:StmtCompleted / ObjectName
   EXEC sp_trace_setevent @trace_id, 45, 29, @on;   -- SP:StmtCompleted / NestLevel

   EXEC sp_trace_setfilter @trace_id, 12, 0, 0, @spid;             -- spid = @spid
   EXEC sp_trace_setfilter @trace_id, 13, 0, 4, @minimum_duration; -- duration >= @minimum_duration
   EXEC sp_trace_setfilter @trace_id, 16, 0, 4, @minimum_reads;    -- reads >= @minimum_reads
   EXEC sp_trace_setfilter @trace_id, 18, 0, 4, @minimum_cpu;      -- cpu >= @minimum_cpu

   -- collect wait stats via extended events
   IF @show_waits=1 BEGIN
      SET @event_sql = replace('
   IF EXISTS (SELECT * FROM sys.server_event_sessions WHERE name = ''***'')
      DROP EVENT SESSION *** ON SERVER;

   CREATE EVENT SESSION *** ON SERVER
   ADD EVENT sqlos.wait_info
    (ACTION (package0.collect_system_time)
     WHERE sqlserver.session_id=' + CAST(@spid as varchar) +
           ' AND opcode=1),
   ADD EVENT sqlos.wait_info_external
    (ACTION (package0.collect_system_time)
     WHERE sqlserver.session_id=' + CAST(@spid as varchar) +
           ' AND opcode=1)
   ADD TARGET package0.asynchronous_file_target
    (SET FILENAME = N' + QUOTENAME(@file_path + '.xel', '''') +',
      METADATAFILE = N' + QUOTENAME(@file_path + '.xem', '''') +')
   WITH (max_dispatch_latency = 1 seconds);

   ALTER EVENT SESSION *** ON SERVER STATE = START;', '***', @eventsessname);
      EXEC(@event_sql);
   END

   IF @rollback=1
      BEGIN TRAN;

   -- Run the batch, considering that it may fail.
   BEGIN TRY
      EXEC sp_trace_setstatus @trace_id, 1;
      EXEC (@batch);
      EXEC sp_trace_setstatus @trace_id, 0;
   END TRY
   BEGIN CATCH
      DECLARE @msg nvarchar(2048);
      SELECT @msg = 'Batch failed with: ' + error_message();
      RAISERROR(@msg, 16, 1) WITH NOWAIT;
      EXEC sp_trace_setstatus @trace_id, 0;
   END CATCH

   IF @@trancount > 0
      ROLLBACK;

   IF @show_waits = 1
   BEGIN
      EXEC('ALTER EVENT SESSION ' + @eventsessname + ' ON SERVER STATE = STOP;');
      EXEC('DROP EVENT SESSION ' + @eventsessname + ' ON SERVER;');
   END

   -- Stop and delete ttace and event sessions.
   EXEC sp_trace_setstatus @trace_id, 2;

do_analysis:
   RAISERROR('Batch completed. Analysis started', 0, 1) WITH NOWAIT;

   -- load trace
   INSERT   #Results (timestamp, event_class, sub_class, text_data,
                      routine_name, line_number, nesting,
                      duration, reads, cpu, writes, sequence)
   SELECT   IsNull(EndTime, ''),
            CASE EventClass WHEN 45 THEN 41 WHEN 122 THEN 146 ELSE EventClass END,
            EventSubClass,
            coalesce(TextData, ''),
            CASE WHEN ObjectName IS NOT NULL THEN ObjectName
                           WHEN TextData LIKE N'SELECT StatMan%' THEN '-- AutoStats'
                           ELSE 'Dynamic SQL'
            END,
            coalesce(LineNumber, 0) AS LineNumber, COALESCE(NestLevel - CASE @snooping
               WHEN 1 THEN 0 ELSE 2
            END, 0),
            Duration, Reads, cpu, Writes, EventSequence
   FROM     fn_trace_gettable ( @file_path + '.trc' , default )
   WHERE    EventClass < 255
   AND      (@plans > '' OR EventClass NOT IN (122, 146));

   -- sequence compiles.
   UPDATE SP SET
      compile_count = 1,
      sub_class = RC.sub_class
   FROM #Results RC
   CROSS APPLY(
      SELECT   TOP 1 *
      FROM     #Results R
      WHERE    R.event_class = 41
         AND   R.text_data = RC.text_data
         AND   R.sequence > RC.sequence
      ORDER BY R.sequence
   ) SP
   WHERE RC.event_class = 166;

   -- sequence query plans, but only if reads exceeds @plan_reads, or there is
   -- recompile.
   IF @plans > ''
   BEGIN
      BEGIN TRY
         UPDATE R SET
            xplan = CASE WHEN R.reads >= @plan_reads
                         THEN convert(xml, S.text_data)
                    END,
            xplan_sequence = S.sequence
         FROM #Results R
         CROSS APPLY (
            SELECT TOP 1 S.text_data, S.sequence, S.event_class
            FROM   #Results S
            WHERE  S.sequence < R.sequence
             AND   S.line_number = R.line_number
             AND   S.routine_name = R.routine_name
             AND   S.event_class = 146
             ORDER  BY S.sequence DESC
         ) AS S
         WHERE (R.reads >= @plan_reads OR R.compile_count = 1)
          AND  R.event_class = 41
         OPTION (RECOMPILE);
      END TRY
      -- Not plans convert to xml, so we have a fallback where we run a cursor.
      BEGIN CATCH

         DECLARE @sequence bigint
         DECLARE plancur CURSOR STATIC LOCAL FOR
            SELECT sequence
            FROM   #Results
            WHERE  (reads >= @plan_reads OR compile_count = 1)
              AND  event_class = 41;

         OPEN plancur

         WHILE 1 = 1
         BEGIN
            FETCH plancur INTO @sequence
            IF @@fetch_status <> 0
               BREAK

            BEGIN TRY
               UPDATE R SET
                  xplan = CASE WHEN R.reads >= @plan_reads
                         THEN convert(xml, S.text_data)
                    END,
                  xplan_sequence = S.sequence
               FROM #Results R
               CROSS APPLY (
                  SELECT TOP 1 S.text_data, S.sequence
                  FROM   #Results S
                  WHERE  S.sequence < R.sequence
                   AND   S.line_number = R.line_number
                   AND   S.routine_name = R.routine_name
                   AND   S.event_class = 146
                  ORDER BY S.sequence DESC
               ) AS S
               WHERE R.sequence = @sequence
                 AND R.event_class = 41;
            END TRY
            BEGIN CATCH
            END CATCH
         END

         DEALLOCATE plancur
      END CATCH;

      -- Get compile statistics
      WITH XMLNAMESPACES
         (DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/showplan')
      , X AS (
          SELECT sequence,
                 convert(xml, text_data) AS xplan
          FROM   #Results
          WHERE  event_class = 146
      )
      UPDATE R
      SET    compile_cpu = xp.c.value('@CompileCPU','int'),
             compile_duration = xp.c.value('@CompileTime','int')
      FROM   #Results R
      JOIN   X ON R.xplan_sequence = X.sequence
      CROSS  APPLY X.xplan.nodes('/ShowPlanXML/BatchSequence/Batch/Statements/StmtSimple/QueryPlan') AS xp(c)
      WHERE  R.compile_count = 1
       AND  R.event_class = 41
      OPTION (RECOMPILE);

      IF @group_plans = 1
      BEGIN;
         WITH XMLNAMESPACES
            (DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/showplan')
         UPDATE   #Results
         SET   xplan.modify('delete (/ShowPlanXML/BatchSequence/Batch/Statements/StmtSimple/QueryPlan/ParameterList)[1]')
         WHERE xplan IS NOT NULL;
      END
   END

   -- display wait stats
   IF @show_waits = 1 BEGIN
      SET @time_offset = datediff(Hour, getutcdate(), getdate());

      -- Index created with dynamic SQL, since syntax is not good on SQL 2005.
      EXEC ('CREATE UNIQUE INDEX timestamp_ix ON #Results (event_class, timestamp, sequence)
                INCLUDE (nesting) WHERE event_class = 41');

      -- Save wait ids in a temporary table to avoid the DMV in the big query below..
      INSERT #wait_types(wait_id, wait_type)
         SELECT convert(varchar(10), map_key), map_value
         FROM   sys.dm_xe_map_values
         WHERE  name = 'wait_types';

      INSERT #xe_file (record, rowno)
         SELECT cast(event_data AS xml), row_number() OVER (ORDER BY (SELECT NULL))
         FROM   sys.fn_xe_file_target_read_file (
            @file_path + '*.xel',
            @file_path + '*.xem', null, null);


      WITH extracted_data AS (
         SELECT   rowno,
                  -- We get all data from the value element, even if this is more complex. By avoiding
                  -- reading the text elements as well, we gain some performance.
                  d.data.value('@name', 'nvarchar(30)') COLLATE Latin1_General_BIN2 AS what,
                  d.data.value('(value/text())[1]', 'nvarchar(100)') COLLATE Latin1_General_BIN2 AS value_elem
         FROM #xe_file x
         CROSS APPLY x.record.nodes('/event/*') d(data)
      )

      INSERT #Waits (id, csum, wait_type, duration, signal_duration, nesting, routine_name, line_number, text_data)
      SELECT agg.id, coalesce(SP.csum, 0), agg.wait_type, agg.duration, isnull(agg.signal_duration, 0),
             SP.nesting, SP.routine_name, SP.line_number, SP.text_data
      FROM (
         SELECT MIN(rowno) id, timestamp, wait_type, Sum(duration) duration, Sum(signal_duration) signal_duration
         FROM (
            SELECT rowno,
               MIN (CASE what WHEN 'wait_type' THEN wt.wait_type END) wait_type,
               MIN (CASE what WHEN 'duration' THEN CAST(value_elem AS bigint) END) duration,
               MIN (CASE what WHEN 'signal_duration' THEN CAST(value_elem AS bigint) END) signal_duration,
               MIN (CASE what WHEN 'collect_system_time'
                              THEN  dateadd(Hour, @time_offset, CASE @sql_version
                                                                   -- In SQL 2008 the value element for collect system time is the time
                                                                   -- in number of ticks since 1601-01-01(!). This calls for some weird
                                                                   -- math.
                                                                   WHEN 10 THEN dateadd(ms, cast(value_elem as bigint) /10000 % 1000,
                                                                                  dateadd(ss,
                                                                                    cast(value_elem as bigint) /10000000 - cast(145731 AS bigint) * 86400,
                                                                                 '20000101'))
                                                                   ELSE value_elem
                                                               END)
                    END) AS timestamp
            FROM extracted_data ed
            LEFT JOIN #wait_types wt ON wt.wait_id = ed.value_elem
            WHERE what in ('wait_type','duration','signal_duration', 'collect_system_time')
            GROUP  BY rowno
         ) partialagg
         GROUP BY timestamp, wait_type
      ) agg
      OUTER APPLY (
         SELECT top 1 R.csum, R.nesting, R.routine_name, R.line_number, R.text_data
         FROM  #Results R
         WHERE R.event_class = 41
         AND   R.timestamp >= agg.timestamp
         AND   R.nesting >= 0
         ORDER BY R.timestamp, R.sequence
      ) SP
   END;

   -- total measure
   SELECT
      @total = nullif(max(
                CASE lower(@factor)
                   WHEN 'cpu' THEN cpu
                   WHEN 'reads' THEN reads
                   WHEN 'writes' THEN writes
                   ELSE duration
                END), 0),
      @compile_duration = sum(compile_duration),
      @compile_cpu = sum(compile_cpu),
      @compile_count = sum(CASE WHEN event_class=166 THEN 1 ELSE 0 END),
      @minnestlevel = min(CASE WHEN event_class IN (41, 45) THEN nesting END)
   FROM  #Results;

   IF @snooping = 1 BEGIN
      SELECT @total = nullif(SUM(
                    CASE lower(@factor)
                        WHEN 'cpu' THEN cpu
                        WHEN 'reads' THEN reads
                        WHEN 'writes' THEN writes
                        ELSE duration
                    END), 0)
      FROM    #Results
      WHERE   nesting = @minnestlevel;

      INSERT #Results (timestamp, event_class, text_data, routine_name,
                       line_number, nesting, duration, sequence)
      VALUES (getdate(), 41, 'EXEC (snoop)', 'sp_sqltrace',
               0, -1, @snoop_time*convert(bigint, 1000000), 9223372036854775807);
   END;

   UPDATE   #Results SET
      compile_duration = @compile_duration,
      compile_cpu = @compile_cpu,
      compile_count = @compile_count
   WHERE routine_name = 'sp_sqltrace'
   AND      nesting = -1;

   -- results
   SELECT CASE WHEN nesting = -1 THEN ''
      ELSE isnull(cast(nullif(floor((@total/2 + 100.0 * sum(CASE lower(@factor)
               WHEN 'cpu' THEN cpu + IsNull(compile_cpu, 0)
               WHEN 'reads' THEN reads
               WHEN 'writes' THEN writes
               ELSE duration + IsNull(compile_duration, 0)
               END)) / @total), 0) as varchar) + '%', '')
      END AS Factor,
      CASE WHEN text_data LIKE 'EXEC%' THEN '\---- ' + text_data
       WHEN text_data LIKE 'SELECT StatMan%' THEN 'Statistics -- ' + text_data
       ELSE text_data
      END AS Text,
      CASE WHEN nesting = -1 OR COUNT(*)=1 THEN ''
           ELSE cast(count(*) as varchar) END AS Calls,
      CASE WHEN nesting = -1 THEN ''
           ELSE cast(nesting as varchar) END AS Nesting,
      CASE WHEN nesting = -1 THEN ''
           ELSE routine_name + ' - ' +
                cast(line_number as varchar)
      END [Object - Line],
      cast(sum(duration) / 1000.0 as numeric(18,2)) AS Duration,
      isnull(cast(nullif(sum(cpu),0) as varchar),'') AS Cpu,
      isnull(cast(nullif(sum(reads),0) as varchar),'') AS Reads,
      isnull(cast(nullif(sum(writes),0) as varchar),'') AS Writes,
      isnull(CASE WHEN @show_waits = 0 THEN NULL
                  WHEN nesting = -1 THEN STUFF((
                       SELECT '| '+ CASE WHEN Sum(signal_duration) > 0
                                   THEN '[' + Cast(Sum(signal_duration) as varchar) + 'sig]'
                                    ELSE ''
                              END +
                              cast(sum(duration) as varchar) + 'ms=' +
                              W.wait_type + '(' + cast(count(*) as varchar) +
                              ')' AS [data()]
                     FROM  #Waits W
                     GROUP BY W.wait_type
                     ORDER BY Sum(duration) DESC, Count(*) DESC
                     FOR XML PATH('')), 1, 2, '')
                  ELSE STUFF((SELECT '| ' + CASE WHEN Sum(signal_duration) > 0
                                    THEN '[' + Cast(Sum(signal_duration) as varchar) + 'sig]'
                                    ELSE ''
                               END +
                               cast(sum(duration) as varchar) + 'ms=' +
                               W.wait_type + '(' + cast(count(*) as varchar) + ')' AS [data()]
                        FROM  #Waits W
                        WHERE W.csum = R.csum
                         AND  W.nesting = R.nesting
                         AND  W.routine_name = R.routine_name
                         AND  W.line_number = R.line_number
                         AND  W.text_data = R.text_data
                        GROUP BY W.wait_type
                        ORDER BY Sum(duration) DESC, Count(*) DESC
                        FOR XML PATH('')
               ), 1, 2, '') END, '') AS Waits,
      isnull(cast(nullif(sum(compile_count), 0) as varchar),'') AS Compiles,
      CASE MIN(sub_class)
         WHEN 1 THEN 'Local' WHEN 2 THEN 'Stats' WHEN 3 THEN 'DNR'
         WHEN 4 THEN 'SET' WHEN 5 THEN 'Temp' WHEN 6 THEN 'Remote'
         WHEN 7 THEN 'Browse' WHEN 8 THEN 'QN' WHEN 9 THEN 'MPI'
         WHEN 10 THEN 'Cursor' WHEN 11 THEN 'Manual'
         ELSE COALESCE(cast(MIN (sub_class) as varchar), '')
      END +
      CASE WHEN min(sub_class) <> max(sub_class) THEN ' +more' ELSE '' END AS Reason,
      CASE WHEN sum(compile_count) > 0
           THEN isnull(cast(sum(compile_duration) as varchar), '?')
           ELSE ''
      END AS Comp_Duration,
      CASE WHEN sum(compile_count) > 0
           THEN isnull(cast(sum(compile_cpu) as varchar), '?')
           ELSE ''
      END AS Comp_Cpu,
      cast(cast(xplan as nvarchar(max)) as xml) XPlan
   FROM  #Results R
   WHERE event_class = 41
   GROUP BY csum, nesting, routine_name, line_number, text_data,
         Cast(xplan as nvarchar(max))
   ORDER BY min(CASE WHEN @order='' THEN sequence END),
      sum(CASE lower(@order)
       WHEN 'cpu' THEN cpu + IsNull(compile_cpu, 0)
       WHEN 'reads' THEN reads
       WHEN 'writes' THEN writes
       ELSE duration + IsNull(compile_duration, 0)
      END) DESC
   OPTION (RECOMPILE)
END
GO
