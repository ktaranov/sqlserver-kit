/*
Author: 
Original link: https://blog.sqlauthority.com/2017/01/09/sql-server-get-historical-deadlock-information-system-health-extended-events/
http://sqlworldwide.com/sql-server-system_health-session-retention
*/
CREATE EVENT SESSION [system_health] ON SERVER 
ADD EVENT sqlclr.clr_allocation_failure(
    ACTION(package0.callstack,sqlserver.session_id)),
ADD EVENT sqlclr.clr_virtual_alloc_failure(
    ACTION(package0.callstack,sqlserver.session_id)),
ADD EVENT sqlos.memory_broker_ring_buffer_recorded,
ADD EVENT sqlos.memory_node_oom_ring_buffer_recorded(
    ACTION(package0.callstack,sqlserver.session_id,sqlserver.sql_text,sqlserver.tsql_stack)),
ADD EVENT sqlos.process_killed(
    ACTION(package0.callstack,sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.client_pid,sqlserver.query_hash,sqlserver.session_id,sqlserver.session_nt_username)),
ADD EVENT sqlos.scheduler_monitor_deadlock_ring_buffer_recorded,
ADD EVENT sqlos.scheduler_monitor_non_yielding_iocp_ring_buffer_recorded,
ADD EVENT sqlos.scheduler_monitor_non_yielding_ring_buffer_recorded,
ADD EVENT sqlos.scheduler_monitor_non_yielding_rm_ring_buffer_recorded,
ADD EVENT sqlos.scheduler_monitor_stalled_dispatcher_ring_buffer_recorded,
ADD EVENT sqlos.scheduler_monitor_system_health_ring_buffer_recorded,
ADD EVENT sqlos.wait_info(
    ACTION(package0.callstack,sqlserver.session_id,sqlserver.sql_text)
    WHERE ([duration]>(15000) AND ([wait_type]>=N'LATCH_NL' AND ([wait_type]>=N'PAGELATCH_NL' AND [wait_type]<=N'PAGELATCH_DT' OR [wait_type]<=N'LATCH_DT' OR [wait_type]>=N'PAGEIOLATCH_NL' AND [wait_type]<=N'PAGEIOLATCH_DT' OR [wait_type]>=N'IO_COMPLETION' AND [wait_type]<=N'NETWORK_IO' OR [wait_type]=N'RESOURCE_SEMAPHORE' OR [wait_type]=N'SOS_WORKER' OR [wait_type]>=N'FCB_REPLICA_WRITE' AND [wait_type]<=N'WRITELOG' OR [wait_type]=N'CMEMTHREAD' OR [wait_type]=N'TRACEWRITE' OR [wait_type]=N'RESOURCE_SEMAPHORE_MUTEX') OR [duration]>(30000) AND [wait_type]<=N'LCK_M_RX_X'))), ADD EVENT sqlos.wait_info_external( ACTION(package0.callstack,sqlserver.session_id,sqlserver.sql_text) WHERE ([duration]>(5000) AND ([wait_type]>=N'PREEMPTIVE_OS_GENERICOPS' AND [wait_type]<=N'PREEMPTIVE_OS_ENCRYPTMESSAGE' OR [wait_type]>=N'PREEMPTIVE_OS_INITIALIZESECURITYCONTEXT' AND [wait_type]<=N'PREEMPTIVE_OS_QUERYSECURITYCONTEXTTOKEN' OR [wait_type]>=N'PREEMPTIVE_OS_AUTHZGETINFORMATIONFROMCONTEXT' AND [wait_type]<=N'PREEMPTIVE_OS_REVERTTOSELF' OR [wait_type]>=N'PREEMPTIVE_OS_CRYPTACQUIRECONTEXT' AND [wait_type]<=N'PREEMPTIVE_OS_DEVICEOPS' OR [wait_type]>=N'PREEMPTIVE_OS_NETGROUPGETUSERS' AND [wait_type]<=N'PREEMPTIVE_OS_NETUSERMODALSGET' OR [wait_type]>=N'PREEMPTIVE_OS_NETVALIDATEPASSWORDPOLICYFREE' AND [wait_type]<=N'PREEMPTIVE_OS_DOMAINSERVICESOPS' OR [wait_type]=N'PREEMPTIVE_OS_VERIFYSIGNATURE' OR [duration]>(45000) AND ([wait_type]>=N'PREEMPTIVE_OS_SETNAMEDSECURITYINFO' AND [wait_type]<=N'PREEMPTIVE_CLUSAPI_CLUSTERRESOURCECONTROL' OR [wait_type]>=N'PREEMPTIVE_OS_RSFXDEVICEOPS' AND [wait_type]<=N'PREEMPTIVE_OS_DSGETDCNAME' OR [wait_type]>=N'PREEMPTIVE_OS_DTCOPS' AND [wait_type]<=N'PREEMPTIVE_DTC_ABORT' OR [wait_type]>=N'PREEMPTIVE_OS_CLOSEHANDLE' AND [wait_type]<=N'PREEMPTIVE_OS_FINDFILE' OR [wait_type]>=N'PREEMPTIVE_OS_GETCOMPRESSEDFILESIZE' AND [wait_type]<=N'PREEMPTIVE_ODBCOPS' OR [wait_type]>=N'PREEMPTIVE_OS_DISCONNECTNAMEDPIPE' AND [wait_type]<=N'PREEMPTIVE_CLOSEBACKUPMEDIA' OR [wait_type]=N'PREEMPTIVE_OS_AUTHENTICATIONOPS' OR [wait_type]=N'PREEMPTIVE_OS_FREECREDENTIALSHANDLE' OR [wait_type]=N'PREEMPTIVE_OS_AUTHORIZATIONOPS' OR [wait_type]=N'PREEMPTIVE_COM_COCREATEINSTANCE' OR [wait_type]=N'PREEMPTIVE_OS_NETVALIDATEPASSWORDPOLICY' OR [wait_type]=N'PREEMPTIVE_VSS_CREATESNAPSHOT')))), ADD EVENT sqlserver.connectivity_ring_buffer_recorded(SET collect_call_stack=(1)), ADD EVENT sqlserver.error_reported( ACTION(package0.callstack,sqlserver.database_id,sqlserver.session_id,sqlserver.sql_text,sqlserver.tsql_stack) WHERE ([severity]>=(20) OR ([error_number]=(17803) OR [error_number]=(701) OR [error_number]=(802) OR [error_number]=(8645) OR [error_number]=(8651) OR [error_number]=(8657) OR [error_number]=(8902) OR [error_number]=(41354) OR [error_number]=(41355) OR [error_number]=(41367) OR [error_number]=(41384) OR [error_number]=(41336) OR [error_number]=(41309) OR [error_number]=(41312) OR [error_number]=(41313)))),
ADD EVENT sqlserver.security_error_ring_buffer_recorded(SET collect_call_stack=(1)),
ADD EVENT sqlserver.sp_server_diagnostics_component_result(SET collect_data=(1)
    WHERE ([sqlserver].[is_system]=(1) AND [component]<>(4))),
ADD EVENT sqlserver.sql_exit_invoked(
    ACTION(package0.callstack,sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.client_pid,sqlserver.query_hash,sqlserver.session_id,sqlserver.session_nt_username)),
ADD EVENT sqlserver.xml_deadlock_report
ADD TARGET package0.event_file(SET filename=N'system_health.xel',max_file_size=(5),max_rollover_files=(4)),
ADD TARGET package0.ring_buffer(SET max_events_limit=(5000),max_memory=(4096))
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=120 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=ON)
GO

ALTER EVENT SESSION [system_health] 
ON SERVER STATE = STOP
GO
ALTER EVENT SESSION [system_health] 
ON SERVER DROP TARGET package0.event_file 
ALTER EVENT SESSION [system_health] 
ON SERVER ADD TARGET package0.event_file 
	(SET FILENAME=N'system_health.xel',--name of the session
	max_file_size=(25), --size of each file in MB
	max_rollover_files=(40)) --how many files you want to keep
GO

ALTER EVENT SESSION [system_health] 
ON SERVER STATE = START;
GO