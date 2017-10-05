/*
Original link: http://blog.waynesheffield.com/wayne/archive/2017/04/weaning-yourself-off-sql-profiler/
Author: Wayne Sheffield
*/
IF EXISTS (SELECT 1 FROM sys.server_event_sessions WHERE name = 'Deadlocks')
    DROP EVENT SESSION [Deadlocks] ON SERVER;
GO

EXECUTE xp_create_subdir 'C:\SQL\XE_Out';
GO

CREATE EVENT SESSION [Deadlocks]
ON SERVER
ADD EVENT sqlserver.lock_deadlock(
    SET collect_database_name=(1),collect_resource_description=(1)
    ACTION 
    (
          sqlserver.client_app_name         -- ApplicationName from SQLTrace
        , sqlserver.client_pid              -- ClientProcessID from SQLTrace
        , sqlserver.nt_username             -- NTUserName from SQLTrace
        , sqlserver.server_principal_name   -- LoginName from SQLTrace
        , sqlserver.session_id              -- SPID from SQLTrace
    )
),
ADD EVENT sqlserver.lock_deadlock_chain(
    SET collect_database_name=(1),collect_resource_description=(1)
    ACTION 
    (
          sqlserver.session_id  -- SPID from SQLTrace
    )
),
ADD EVENT sqlserver.xml_deadlock_report(
    ACTION 
    (
          sqlserver.server_principal_name   -- LoginName from SQLTrace
        , sqlserver.session_id              -- SPID from SQLTrace
    )
)
ADD TARGET package0.event_file
(
    SET filename = 'C:\SQL\XE_Out\Deadlocks.xel',
        max_file_size = 250,
        max_rollover_files = 5
)
WITH (STARTUP_STATE=OFF)
;

/*
-- 1 The next step is to create a deadlock. Open up a new query window, and run the following. Leave this query window open.
USE tempdb;
GO
IF OBJECT_ID('dbo.Test1') IS NOT NULL DROP TABLE dbo.Test1;
IF OBJECT_ID('dbo.Test2') IS NOT NULL DROP TABLE dbo.Test2;
CREATE TABLE dbo.Test1 (col1 INT);
CREATE TABLE dbo.Test2 (col2 INT);
INSERT INTO dbo.Test1 VALUES (1),(2),(3),(4),(5);
INSERT INTO dbo.Test2 VALUES (1),(2),(3),(4),(5);
GO
BEGIN TRANSACTION
UPDATE dbo.Test1 SET col1 = col1*10 WHERE col1=3;

-- 2 Next, open up a second query window, and run the following code in that window:
USE tempdb;
BEGIN TRANSACTION;
UPDATE dbo.Test2 SET col2 = col2*20 WHERE col2 = 4;
UPDATE dbo.Test1 SET col1 = col1*20 WHERE col1 = 3;
COMMIT TRANSACTION;

-- 3 Finally, return to the first query window and run the following code, at which point one of the statements in one of the query windows will be deadlocked:
UPDATE dbo.Test2 SET col2 = col2*10 WHERE col2 = 4;
COMMIT TRANSACTION;

-- Msg 1205, Level 13, State 45, Line 4
-- Transaction (Process ID 57) was deadlocked on lock resources with another process and has been chosen as the deadlock victim. Rerun the transaction.

-- 4 Get extended event info
WITH cte AS
(
SELECT  t2.event_data.value('(event/@name)[1]','varchar(50)') AS event_name,
        t2.event_data.value('(event/@timestamp)[1]', 'datetime2') AS StartTime,
        t2.event_data.value('(event/data[@name="duration"]/value)[1]', 'bigint') AS duration,
        t2.event_data.value('(event/data[@name="database_name"]/value)[1]', 'sysname') AS DBName,
        t2.event_data.value('(event/action[@name="nt_username"]/value)[1]', 'varchar(500)') AS nt_username,
        t2.event_data.value('(event/data[@name="mode"]/value)[1]', 'varchar(15)')  + ' (' + 
        t2.event_data.value('(event/data[@name="mode"]/text)[1]', 'varchar(50)') + ')' AS mode,
        t2.event_data.value('(event/data[@name="object_id"]/value)[1]', 'integer') AS object_id,
        t2.event_data.value('(event/data[@name="resource_description"]/value)[1]', 'varchar(max)') AS resource_description,
        t2.event_data.value('(event/data[@name="resource_owner_type"]/text)[1]', 'varchar(max)')  AS resource_owner_type,
        t2.event_data.value('(event/data[@name="resource_type"]/text)[1]', 'varchar(max)') + ' (' +
        t2.event_data.value('(event/data[@name="resource_type"]/value)[1]', 'varchar(max)') + ')' AS resource_type,
        t2.event_data.value('(event/action[@name="server_principal_name"]/value)[1]', 'varchar(max)') AS server_principal_name,
        t2.event_data.value('(event/action[@name="session_id"]/value)[1]', 'varchar(max)') AS session_id,
        t2.event_data.value('(event/action[@name="client_pid"]/value)[1]', 'integer') AS client_pid,
        t2.event_data.value('(event/action[@name="client_app_name"]/value)[1]', 'varchar(max)') AS client_app_name,
        t2.event_data
FROM    sys.fn_xe_file_target_read_file('C:\SQL\XE_Out\Deadlocks*.xel', NULL, NULL, NULL) t1
CROSS APPLY (SELECT CONVERT(XML, t1.event_data)) t2(event_data)
)
SELECT  cte.event_name,
        cte.StartTime,
        DATEADD(MICROSECOND, duration, CONVERT(DATETIME2, [cte].StartTime)) AS EndDate,
        cte.duration,
        cte.DBName,
        cte.nt_username,
        cte.server_principal_name,
        cte.mode,
        cte.object_id,
        cte.resource_description,
        cte.resource_owner_type,
        cte.resource_type,
        cte.session_id,
        cte.client_pid,
        cte.client_app_name,
        cte.event_data 
FROM    cte;
*/
