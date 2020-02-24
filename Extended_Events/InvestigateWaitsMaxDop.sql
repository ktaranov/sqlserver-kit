/*
Original link: https://www.sqlskills.com/blogs/paul/who-is-overriding-maxdop-1-on-the-instance/
Author: Paul Randal

SELECT
    [data1].[value] ('(./@timestamp)[1]', 'datetime') AS [Time],
    [data1].[value] ('(./data[@name="dop"]/value)[1]', 'INT') AS [DOP],
    [data1].[value] ('(./action[@name="client_hostname"]/value)[1]', 'VARCHAR(MAX)') AS [Host],
    [data1].[value] ('(./action[@name="nt_username"]/value)[1]', 'VARCHAR(MAX)') AS [User],
    [data1].[value] ('(./action[@name="sql_text"]/value)[1]','VARCHAR(MAX)') AS [Statement]
FROM (
    SELECT CONVERT (XML, [target_data]) AS data
    FROM sys.dm_xe_session_targets [xst]
    INNER JOIN sys.dm_xe_sessions [xs]
        ON [xst].[event_session_address] = [xs].[address]
    WHERE [xs].[name] = N'InvestigateWaits') AS t
CROSS APPLY data.nodes('//event') n (data1);
GO
*/

/* Stop trace if started */
IF EXISTS (SELECT * FROM sys.dm_xe_sessions WHERE name = 'InvestigateWaitsMaxDop')
  ALTER EVENT SESSION InvestigateWaitsMaxDop ON SERVER STATE = STOP;

/* Delete trace if exists */
IF EXISTS (SELECT * FROM sys.server_event_sessions WHERE name = 'InvestigateWaitsMaxDop')
  DROP EVENT SESSION InvestigateWaitsMaxDop ON SERVER;

/* Create trace */
CREATE EVENT SESSION InvestigateWaitsMaxDop ON SERVER
ADD EVENT [sqlserver].[degree_of_parallelism]
(
    ACTION (
        sqlserver.client_hostname,
        sqlserver.nt_username,
        sqlserver.sql_text)
    WHERE [dop] > 1 /* parallel plans */
)
ADD TARGET [package0].[ring_buffer]
WITH (
    MAX_MEMORY = 50 MB,
    MAX_DISPATCH_LATENCY = 5 SECONDS
);
GO

/* Start trace
ALTER EVENT SESSION InvestigateWaitsMaxDop ON SERVER STATE = START;
*/
