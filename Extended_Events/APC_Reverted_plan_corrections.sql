/*
Original link: https://blogs.msdn.microsoft.com/sqlserverstorageengine/2017/07/18/monitoring-automatic-tuning-actions-using-xevents/
Author: Jovan Popovic
*/

IF SERVERPROPERTY('ProductMajorVersion') < 14
RAISERROR ('Your version of SQL Server is not supported! This extended event works only for version >= 2017 RC1', 20, 1) WITH LOG;

IF EXISTS (SELECT 1 FROM sys.server_event_sessions WHERE name = 'APC_Reverted_plan_corrections')
    DROP EVENT SESSION [APC_Reverted_plan_corrections] ON SERVER;
GO

CREATE EVENT SESSION [APC_Reverted_plan_corrections] ON SERVER
ADD EVENT qds.automatic_tuning_plan_regression_verification_check_completed(
    WHERE ((([is_regression_detected]=(1))
      AND ([is_regression_corrected]=(1)))
      AND ([option_id]=(1))))
ADD TARGET package0.event_file(SET filename=N'reverted_plan_corrections')
WITH (STARTUP_STATE=ON);
GO

ALTER EVENT SESSION [APC_Reverted_plan_corrections] ON SERVER STATE = start;
GO
