/*
https://blogs.msdn.microsoft.com/sql_pfe_blog/2017/05/04/login-failed-for-xxx-whos-keeps-trying-to-connect-to-my-server/
*/

CREATE EVENT SESSION [LoginFailureTrace] ON SERVER 
ADD EVENT sqlserver.errorlog_written( ACTION(sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.client_pid))
ADD TARGET package0.event_file(SET filename=N'LoginFailureTrace',max_file_size=(128))
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_MULTIPLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF) 
GO
