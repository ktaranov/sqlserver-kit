/*
Original link: https://sqlperformance.com/2020/04/extended-events/removing-default-trace-2
Author: Aaron Bertrand

WITH FileInfo(XEPath) AS
  (
    SELECT LEFT(BasePath,COALESCE(NULLIF(CHARINDEX(SessName,BasePath)-1,-1),0)) + SessName + N'*.xel' 
    FROM
    (
      SELECT xmlsrc.data.value(N'(@name)[1]', N'nvarchar(max)'), SessName
      FROM 
      (
        SELECT CONVERT(xml,target_data), s.[name]
          FROM sys.dm_xe_session_targets AS t
          INNER JOIN sys.dm_xe_sessions AS s
          ON s.[address] = t.event_session_address
          WHERE s.[name] = N'FileSizeChanges'
      ) AS xefile (TargetData, SessName)
      CROSS APPLY TargetData.nodes(N'//EventFileTarget/File') AS xmlsrc(data)
    ) AS InnerData(BasePath, SessName)
  ),
  SessionData([EventData]) AS 
  (
    SELECT CONVERT(xml, TargetData.event_data) FROM FileInfo CROSS APPLY 
      sys.fn_xe_file_target_read_file(FileInfo.XEPath, NULL, NULL, NULL) AS TargetData
  ), 
  src AS
  (
    SELECT 
      EndTimeUTC   = x.d.value(N'(@timestamp)[1]',                                  N'datetime2'),
      DatabaseID   = x.d.value(N'(data  [@name="database_id"]/value)[1]',           N'int'),
      [FileName]   = x.d.value(N'(data  [@name="file_name"]/value)[1]',             N'sysname'),
      Duration     = x.d.value(N'(data  [@name="duration"]/value)[1]',              N'int'),
      FileType     = x.d.value(N'(data  [@name="file_type"]/text)[1]',              N'varchar(4)'),
      Culprit      = x.d.value(N'(action[@name="sql_text"]/value)[1]',              N'nvarchar(max)'),
      IsAutomatic  = x.d.value(N'(data  [@name="is_automatic"]/value)[1]',          N'varchar(5)'),
      ChangeKB     = x.d.value(N'(data  [@name="size_change_kb"]/value)[1]',        N'bigint'),
      Principal    = x.d.value(N'(action[@name="server_principal_name"]/value)[1]', N'sysname'),
      username     = x.d.value(N'(action[@name="username"]/value)[1]',              N'sysname'),
      AppName      = x.d.value(N'(action[@name="client_app_name"]/value)[1]',       N'sysname'),
      HostName     = x.d.value(N'(action[@name="client_hostname"]/value)[1]',       N'sysname')
      --, [EventData] -- raw XML to troubleshoot specific events
    FROM SessionData CROSS APPLY EventData.nodes('/event') AS x(d)
  )
  SELECT 
    DatabaseName    = DB_NAME(DatabaseID), 
    [FileName], 
    DurationSeconds = CONVERT(decimal(18,3),Duration/1000000.0),
    StartTimeUTC    = CONVERT(datetime2(3), DATEADD(MICROSECOND, -Duration, EndTimeUTC)), 
    EndTimeUTC      = CONVERT(datetime2(3), EndTimeUTC),
    FileType, 
    Culprit = CASE WHEN Culprit IS NULL AND AppName LIKE N'Repl%' 
                   THEN AppName ELSE Culprit END, 
    IsAutomatic, 
    ChangeMB  = CONVERT(decimal(18,3), ChangeKB / 1024.0), 
    Principal = COALESCE([Principal], COALESCE(NULLIF(username,N''),N'?')),
    HostName, 
    App = CASE WHEN AppName LIKE N'%Management Studio%Query%' 
                    THEN N'SSMS - Query Window'
               WHEN AppName LIKE N'%Management Studio%'       
                    THEN N'SSMS - GUI!'
               ELSE AppName END--, [EventData] -- raw XML to troubleshoot specific events
  FROM src;
*/

/* Create trace */
DECLARE @path nvarchar(max) = (SELECT REVERSE(SUBSTRING(p, CHARINDEX(N'\', p), 4000)) 
  FROM (SELECT REVERSE((CONVERT(nvarchar(max), SERVERPROPERTY(N'ErrorLogFileName'))))) AS s(p));
 
IF EXISTS (SELECT 1 FROM sys.dm_xe_sessions WHERE name = N'FileSizeChanges')
BEGIN
  EXEC sys.sp_executesql N'DROP EVENT SESSION FileSizeChanges ON SERVER;';
END
 
DECLARE @sql nvarchar(max) = N' CREATE EVENT SESSION FileSizeChanges ON SERVER 
ADD EVENT sqlserver.database_file_size_change
(
  ACTION
  (
    sqlserver.sql_text,
    sqlserver.client_app_name,
    sqlserver.client_hostname,
    sqlserver.username,
    sqlserver.server_principal_name
  )
)
ADD TARGET package0.event_file
(
  SET filename       = ''' + @path + N'FileSizeChanges.xel'',
  MAX_FILE_SIZE      = 100, -- MB
  MAX_ROLLOVER_FILES = 100  -- 100 MB x 100 = max 10 GB
)
WITH
(
  MAX_MEMORY            = 8192 KB,
  EVENT_RETENTION_MODE  = ALLOW_SINGLE_EVENT_LOSS,
  MAX_DISPATCH_LATENCY  = 30 SECONDS,
  MAX_EVENT_SIZE        = 0 KB,
  TRACK_CAUSALITY       = OFF,
  STARTUP_STATE         = ON
);
 
ALTER EVENT SESSION FileSizeChanges ON SERVER STATE = START;';
 
EXEC sys.sp_executesql @sql;
GO
