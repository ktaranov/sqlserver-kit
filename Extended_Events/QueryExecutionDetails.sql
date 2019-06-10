/*
Original link: https://www.scarydba.com/2019/06/03/which-query-used-the-most-cpu-implementing-extended-events/
Source link: https://github.com/ktaranov/sqlserver-kit/blob/master/Extended_Events/DBRecoveryProgress.sql
Author: Grant Fritchey
*/

USE master;
GO

IF EXISTS
(
    SELECT
        *
    FROM sys.server_event_sessions
    WHERE name = 'QueryExecutionDetails'
)
    DROP EVENT SESSION QueryExecutionDetails ON SERVER;
GO

CREATE EVENT SESSION QueryExecutionDetails
ON SERVER
ADD EVENT sqlserver.rpc_completed
(WHERE (sqlserver.database_name = N'AdventureWorks')),
ADD EVENT sqlserver.rpc_starting
(WHERE (sqlserver.database_name = N'AdventureWorks')),
ADD EVENT sqlserver.sp_statement_completed
(WHERE (sqlserver.database_name = N'AdventureWorks')),
ADD EVENT sqlserver.sql_batch_completed
(WHERE (sqlserver.database_name = N'AdventureWorks')),
ADD EVENT sqlserver.sql_batch_starting
(WHERE (sqlserver.database_name = N'AdventureWorks')),
ADD EVENT sqlserver.sql_statement_completed
(SET collect_statement = (1)
WHERE (sqlserver.database_name = N'AdventureWorks'))
ADD TARGET package0.event_file
(SET filename = N'C:\ExEvents\QueryExecutionDetails.xel')
WITH (TRACK_CAUSALITY = ON);

ALTER EVENT SESSION QueryExecutionDetails ON SERVER STATE = START;
GO
