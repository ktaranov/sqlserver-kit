/*
Original link: https://www.red-gate.com/hub/product-learning/sql-monitor/spotting-unauthorized-configuration-settings-sql-server
Source link: https://github.com/ktaranov/sqlserver-kit/blob/master/Extended_Events/ConfigurationItemsChanged.sql
Author: Phil Factor


SELECT
    CONVERT(datetime2,
            SwitchOffset(CONVERT(datetimeoffset,xed.event_data.value('(@timestamp)[1]', 'datetime2')),
            DateName(TzOffset, SYSDATETIMEOFFSET()))) AS datetime_local,
    xed.event_data.value('(data[@name="error_number"]/value)[1]', 'int') AS [Error_Number],
    xed.event_data.value('(data[@name="severity"]/value)[1]', 'int') AS Severity,
    xed.event_data.value('(data[@name="message"]/value)[1]', 'varchar(255)') AS [Message],
    xed.event_data.value('(action[@name="username"]/value)[1]', 'varchar(255)') AS UserName,
    xed.event_data.value('(action[@name="nt_username"]/value)[1]', 'varchar(255)') AS NT_Username,
    xed.event_data.value('(action[@name="sql_text"]/value)[1]', 'nvarchar(max)') AS SQL_Text,
    xed.event_data.value('(action[@name="database_name"]/value)[1]', 'varchar(255)') AS [Database_Name],
    xed.event_data.value('(action[@name="client_connection_id"]/value)[1]', 'varchar(255)') AS client_conn,
    xed.event_data.value('(action[@name="client_app_name"]/value)[1]', 'varchar(255)') AS client_app_name
FROM @Target_Data.nodes('//RingBufferTarget/event') AS xed (event_data);

EXEC sp_configure 'show advanced options',1;
RECONFIGURE;
GO
EXEC sp_configure 'CLR Enabled',1;
EXEC sp_configure 'Ad Hoc Distributed Queries',1;
EXEC sp_configure 'Cross DB Ownership Chaining',1;
EXEC sp_configure 'Database Mail XPs',1;
EXEC sp_configure 'Ole Automation Procedures',1;
EXEC sp_configure 'Remote ACCESS',1;
EXEC sp_configure 'Remote Admin Connections',1;
EXEC sp_configure 'Scan for Startup Procs',1; 
RECONFIGURE -- To update the currently configured value for advanced options.
GO

/* this code turns OFF some of the configuration items with security issues */
EXEC sp_configure 'show advanced options',1;
RECONFIGURE;
GO
EXEC sp_configure 'Ad Hoc Distributed Queries',0;
EXEC sp_configure 'CLR ENABLED',0;
EXEC sp_configure 'Cross DB Ownership Chaining',0;
EXEC sp_configure 'Database Mail XPs',0;
EXEC sp_configure 'Ole Automation Procedures',0;
EXEC sp_configure 'Remote ACCESS',0;
EXEC sp_configure 'Remote Admin Connections',0;
EXEC sp_configure 'Scan for Startup Procs',0;
EXEC sp_configure 'show advanced options',0;
RECONFIGURE; -- To update the currently configured value for advanced options.
GO
*/

USE master;
GO

IF EXISTS --if the session already exists, then delete it. We are assuming you've changed something
    (
    SELECT * FROM sys.server_event_sessions
      WHERE server_event_sessions.name = 'ConfigurationItemsChanged'
    )
    DROP EVENT SESSION ConfigurationItemsChanged ON SERVER;
GO
CREATE EVENT SESSION ConfigurationItemsChanged -- the name of the session 
ON SERVER
  ADD EVENT sqlserver.error_reported --just the one event
    (ACTION
       (
       sqlserver.client_app_name, sqlserver.client_connection_id,
       sqlserver.database_name, sqlserver.nt_username, sqlserver.sql_text,
       sqlserver.username --all these are useful for tracking an error
       )
  WHERE (([error_number]=(15457)) OR ([error_number]=(5084)))
    )
  ADD TARGET package0.ring_buffer /* we will write it to a ring buffer target only */
    (SET max_memory = (4096))
WITH
  (
  MAX_MEMORY = 4096KB, EVENT_RETENTION_MODE = ALLOW_SINGLE_EVENT_LOSS,
  MAX_DISPATCH_LATENCY = 30 SECONDS, MAX_EVENT_SIZE = 0KB,
  MEMORY_PARTITION_MODE = NONE, TRACK_CAUSALITY = OFF, STARTUP_STATE = ON
  );
GO

ALTER EVENT SESSION ConfigurationItemsChanged ON SERVER STATE = START;
GO
