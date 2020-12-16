/*
https://littlekendra.com/2017/04/03/which-locks-count-toward-lock-escalation/
by Kendra Little Melton 2017-04-03
*/

DROP EVENT SESSION LockEscalation ON SERVER;
GO

CREATE EVENT SESSION LockEscalation ON SERVER
ADD EVENT sqlserver.lock_escalation(SET collect_database_name=(1),collect_statement=(1)
    ACTION(sqlserver.session_id))
ADD TARGET package0.event_file(SET filename=N'C:\XE\Lock_Escalation.xel')
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=NO_EVENT_LOSS,MAX_DISPATCH_LATENCY=5 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
GO
