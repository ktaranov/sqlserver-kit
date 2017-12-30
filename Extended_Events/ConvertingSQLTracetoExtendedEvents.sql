/*
Author: Jonathan Kehayias
Original link: https://www.sqlskills.com/blogs/jonathan/converting-sql-trace-to-extended-events-in-sql-server-2012
*/

IF EXISTS (SELECT 1 FROM sys.server_event_sessions WHERE name = 'XE_Default_Trace')
 DROP EVENT SESSION [XE_Default_Trace] ON SERVER;
GO
CREATE EVENT SESSION [XE_Default_Trace]
ON SERVER
/* Audit Login Failed is not implemented in Extended Events it may be a Server Audit Event */
/* Audit Database Scope GDR Event is not implemented in Extended Events it may be a Server Audit Event */
/* Audit Schema Object GDR Event is not implemented in Extended Events it may be a Server Audit Event */
/* Audit Addlogin Event is not implemented in Extended Events it may be a Server Audit Event */
/* Audit Login GDR Event is not implemented in Extended Events it may be a Server Audit Event */
/* Audit Login Change Property Event is not implemented in Extended Events it may be a Server Audit Event */
/* Audit Add Login to Server Role Event is not implemented in Extended Events it may be a Server Audit Event */
/* Audit Add DB User Event is not implemented in Extended Events it may be a Server Audit Event */
/* Audit Add Member to DB Role Event is not implemented in Extended Events it may be a Server Audit Event */
/* Audit Add Role Event is not implemented in Extended Events it may be a Server Audit Event */
/* Audit Backup/Restore Event is not implemented in Extended Events it may be a Server Audit Event */
/* Audit DBCC Event is not implemented in Extended Events it may be a Server Audit Event */
/* Audit Change Audit Event is not implemented in Extended Events it may be a Server Audit Event */
/* Audit Change Database Owner is not implemented in Extended Events it may be a Server Audit Event */
/* Audit Schema Object Take Ownership Event is not implemented in Extended Events it may be a Server Audit Event */
/* Audit Server Alter Trace Event is not implemented in Extended Events it may be a Server Audit Event */
ADD EVENT sqlserver.database_file_size_change(
 ACTION
 (
     sqlserver.client_app_name — ApplicationName from SQLTrace
   , sqlserver.client_hostname — HostName from SQLTrace
   , sqlserver.client_pid — ClientProcessID from SQLTrace
   , package0.event_sequence — EventSequence from SQLTrace
   , sqlserver.is_system — IsSystem from SQLTrace
   , sqlserver.nt_username — NTDomainName from SQLTrace
   , sqlserver.server_instance_name — ServerName from SQLTrace
   , sqlserver.server_principal_name — LoginName from SQLTrace
   , sqlserver.server_principal_sid — LoginSid from SQLTrace
   , sqlserver.session_id — SPID from SQLTrace
   , sqlserver.session_server_principal_name — SessionLoginName from SQLTrace
 )
),
/* Log File Auto Grow is implemented as the sqlserver.database_file_size_change event in Extended Events */
/* Data File Auto Shrink is implemented as the sqlserver.database_file_size_change event in Extended Events */
/* Log File Auto Shrink is implemented as the sqlserver.database_file_size_change event in Extended Events */
ADD EVENT sqlserver.database_mirroring_state_change(
 ACTION
 (
     package0.event_sequence — EventSequence from SQLTrace
   , sqlserver.is_system — IsSystem from SQLTrace
   , sqlserver.request_id — RequestID from SQLTrace
   , sqlserver.server_instance_name — ServerName from SQLTrace
   , sqlserver.server_principal_sid — LoginSid from SQLTrace
   , sqlserver.session_id — SPID from SQLTrace
   , sqlserver.session_server_principal_name — SessionLoginName from SQLTrace
   , sqlserver.transaction_id — TransactionID from SQLTrace
 )
),
ADD EVENT sqlserver.errorlog_written(
 ACTION
 (
     sqlserver.client_app_name — ApplicationName from SQLTrace
   , sqlserver.client_hostname — HostName from SQLTrace
   , sqlserver.client_pid — ClientProcessID from SQLTrace
   , sqlserver.database_id — DatabaseID from SQLTrace
   , sqlserver.database_name — DatabaseName from SQLTrace
   , package0.event_sequence — EventSequence from SQLTrace
   , sqlserver.is_system — IsSystem from SQLTrace
   , sqlserver.nt_username — NTUserName from SQLTrace
   , sqlserver.nt_username — NTDomainName from SQLTrace
   , sqlserver.request_id — RequestID from SQLTrace
   , sqlserver.server_instance_name — ServerName from SQLTrace
   , sqlserver.server_principal_name — LoginName from SQLTrace
   , sqlserver.server_principal_sid — LoginSid from SQLTrace
   , sqlserver.session_id — SPID from SQLTrace
   , sqlserver.session_server_principal_name — SessionLoginName from SQLTrace
   , sqlserver.transaction_id — TransactionID from SQLTrace
   — Severity not implemented in XE for this event
   — State not implemented in XE for this event
   — Error not implemented in XE for this event
 )
),
ADD EVENT sqlserver.full_text_crawl_started(
 ACTION
 (
     package0.event_sequence — EventSequence from SQLTrace
   , sqlserver.is_system — IsSystem from SQLTrace
   , sqlserver.session_id — SPID from SQLTrace
   , sqlserver.session_server_principal_name — SessionLoginName from SQLTrace
   , sqlserver.transaction_id — TransactionID from SQLTrace
   — ServerName not implemented in XE for this event
 )
),
ADD EVENT sqlserver.full_text_crawl_stopped(
 ACTION
 (
     package0.event_sequence — EventSequence from SQLTrace
   , sqlserver.is_system — IsSystem from SQLTrace
   , sqlserver.session_id — SPID from SQLTrace
   , sqlserver.session_server_principal_name — SessionLoginName from SQLTrace
   , sqlserver.transaction_id — TransactionID from SQLTrace
   — ServerName not implemented in XE for this event
 )
),
ADD EVENT sqlserver.hash_warning(
 ACTION
 (
     sqlserver.client_app_name — ApplicationName from SQLTrace
   , sqlserver.client_hostname — HostName from SQLTrace
   , sqlserver.client_pid — ClientProcessID from SQLTrace
   , sqlserver.database_id — DatabaseID from SQLTrace
   , sqlserver.database_name — DatabaseName from SQLTrace
   , package0.event_sequence — EventSequence from SQLTrace
   , sqlserver.is_system — IsSystem from SQLTrace
   , sqlserver.nt_username — NTUserName from SQLTrace
   , sqlserver.nt_username — NTDomainName from SQLTrace
   , sqlserver.request_id — RequestID from SQLTrace
   , sqlserver.server_instance_name — ServerName from SQLTrace
   , sqlserver.server_principal_name — LoginName from SQLTrace
   , sqlserver.server_principal_sid — LoginSid from SQLTrace
   , sqlserver.session_id — SPID from SQLTrace
   , sqlserver.session_resource_group_id — GroupID from SQLTrace
   , sqlserver.session_server_principal_name — SessionLoginName from SQLTrace
   , sqlserver.transaction_id — TransactionID from SQLTrace
   , sqlserver.transaction_sequence — XactSequence from SQLTrace
 )
),
ADD EVENT sqlserver.missing_column_statistics(
 ACTION
 (
     sqlserver.client_app_name — ApplicationName from SQLTrace
   , sqlserver.client_hostname — HostName from SQLTrace
   , sqlserver.client_pid — ClientProcessID from SQLTrace
   , sqlserver.database_id — DatabaseID from SQLTrace
   , sqlserver.database_name — DatabaseName from SQLTrace
   , package0.event_sequence — EventSequence from SQLTrace
   , sqlserver.is_system — IsSystem from SQLTrace
   , sqlserver.nt_username — NTUserName from SQLTrace
   , sqlserver.nt_username — NTDomainName from SQLTrace
   , sqlserver.request_id — RequestID from SQLTrace
   , sqlserver.server_instance_name — ServerName from SQLTrace
   , sqlserver.server_principal_name — LoginName from SQLTrace
   , sqlserver.server_principal_sid — LoginSid from SQLTrace
   , sqlserver.session_id — SPID from SQLTrace
   , sqlserver.session_resource_group_id — GroupID from SQLTrace
   , sqlserver.session_server_principal_name — SessionLoginName from SQLTrace
   , sqlserver.transaction_id — TransactionID from SQLTrace
   , sqlserver.transaction_sequence — XactSequence from SQLTrace
 )
),
ADD EVENT sqlserver.missing_join_predicate(
 ACTION
 (
     sqlserver.client_app_name — ApplicationName from SQLTrace
   , sqlserver.client_hostname — HostName from SQLTrace
   , sqlserver.client_pid — ClientProcessID from SQLTrace
   , sqlserver.database_id — DatabaseID from SQLTrace
   , sqlserver.database_name — DatabaseName from SQLTrace
   , package0.event_sequence — EventSequence from SQLTrace
   , sqlserver.is_system — IsSystem from SQLTrace
   , sqlserver.nt_username — NTUserName from SQLTrace
   , sqlserver.nt_username — NTDomainName from SQLTrace
   , sqlserver.request_id — RequestID from SQLTrace
   , sqlserver.server_instance_name — ServerName from SQLTrace
   , sqlserver.server_principal_name — LoginName from SQLTrace
   , sqlserver.server_principal_sid — LoginSid from SQLTrace
   , sqlserver.session_id — SPID from SQLTrace
   , sqlserver.session_resource_group_id — GroupID from SQLTrace
   , sqlserver.session_server_principal_name — SessionLoginName from SQLTrace
   , sqlserver.transaction_id — TransactionID from SQLTrace
   , sqlserver.transaction_sequence — XactSequence from SQLTrace
 )
),
ADD EVENT sqlserver.object_altered(
 ACTION
 (
     package0.attach_activity_id — IntegerData from SQLTrace
   , sqlserver.client_app_name — ApplicationName from SQLTrace
   , sqlserver.client_hostname — HostName from SQLTrace
   , sqlserver.client_pid — ClientProcessID from SQLTrace
   , package0.event_sequence — EventSequence from SQLTrace
   , sqlserver.is_system — IsSystem from SQLTrace
   , sqlserver.nt_username — NTUserName from SQLTrace
   , sqlserver.nt_username — NTDomainName from SQLTrace
   , sqlserver.request_id — RequestID from SQLTrace
   , sqlserver.server_instance_name — ServerName from SQLTrace
   , sqlserver.server_principal_name — LoginName from SQLTrace
   , sqlserver.server_principal_sid — LoginSid from SQLTrace
   , sqlserver.session_id — SPID from SQLTrace
   , sqlserver.session_resource_group_id — GroupID from SQLTrace
   , sqlserver.session_server_principal_name — SessionLoginName from SQLTrace
   , sqlserver.transaction_id — TransactionID from SQLTrace
   , sqlserver.transaction_sequence — XactSequence from SQLTrace
   — BigintData1 not implemented in XE for this event
 )
),
ADD EVENT sqlserver.object_created(
 ACTION
 (
     package0.attach_activity_id — IntegerData from SQLTrace
   , sqlserver.client_app_name — ApplicationName from SQLTrace
   , sqlserver.client_hostname — HostName from SQLTrace
   , sqlserver.client_pid — ClientProcessID from SQLTrace
   , package0.event_sequence — EventSequence from SQLTrace
   , sqlserver.is_system — IsSystem from SQLTrace
   , sqlserver.nt_username — NTUserName from SQLTrace
   , sqlserver.nt_username — NTDomainName from SQLTrace
   , sqlserver.request_id — RequestID from SQLTrace
   , sqlserver.server_instance_name — ServerName from SQLTrace
   , sqlserver.server_principal_name — LoginName from SQLTrace
   , sqlserver.server_principal_sid — LoginSid from SQLTrace
   , sqlserver.session_id — SPID from SQLTrace
   , sqlserver.session_resource_group_id — GroupID from SQLTrace
   , sqlserver.session_server_principal_name — SessionLoginName from SQLTrace
   , sqlserver.transaction_id — TransactionID from SQLTrace
   , sqlserver.transaction_sequence — XactSequence from SQLTrace
   — BigintData1 not implemented in XE for this event
 )
),
ADD EVENT sqlserver.object_deleted(
 ACTION
 (
     package0.attach_activity_id — IntegerData from SQLTrace
   , sqlserver.client_app_name — ApplicationName from SQLTrace
   , sqlserver.client_hostname — HostName from SQLTrace
   , sqlserver.client_pid — ClientProcessID from SQLTrace
   , package0.event_sequence — EventSequence from SQLTrace
   , sqlserver.is_system — IsSystem from SQLTrace
   , sqlserver.nt_username — NTUserName from SQLTrace
   , sqlserver.nt_username — NTDomainName from SQLTrace
   , sqlserver.request_id — RequestID from SQLTrace
   , sqlserver.server_instance_name — ServerName from SQLTrace
   , sqlserver.server_principal_name — LoginName from SQLTrace
   , sqlserver.server_principal_sid — LoginSid from SQLTrace
   , sqlserver.session_id — SPID from SQLTrace
   , sqlserver.session_resource_group_id — GroupID from SQLTrace
   , sqlserver.session_server_principal_name — SessionLoginName from SQLTrace
   , sqlserver.transaction_id — TransactionID from SQLTrace
   , sqlserver.transaction_sequence — XactSequence from SQLTrace
   — BigintData1 not implemented in XE for this event
 )
),
ADD EVENT sqlserver.plan_guide_unsuccessful(
 ACTION
 (
     sqlserver.client_app_name — ApplicationName from SQLTrace
   , sqlserver.client_hostname — HostName from SQLTrace
   , sqlserver.client_pid — ClientProcessID from SQLTrace
   , sqlserver.database_id — DatabaseID from SQLTrace
   , sqlserver.database_name — DatabaseName from SQLTrace
   , package0.event_sequence — EventSequence from SQLTrace
   , sqlserver.is_system — IsSystem from SQLTrace
   , sqlserver.nt_username — NTUserName from SQLTrace
   , sqlserver.nt_username — NTDomainName from SQLTrace
   , sqlserver.request_id — RequestID from SQLTrace
   , sqlserver.server_instance_name — ServerName from SQLTrace
   , sqlserver.server_principal_name — LoginName from SQLTrace
   , sqlserver.server_principal_sid — LoginSid from SQLTrace
   , sqlserver.session_id — SPID from SQLTrace
   , sqlserver.session_server_principal_name — SessionLoginName from SQLTrace
   , sqlserver.transaction_id — TransactionID from SQLTrace
   , sqlserver.transaction_sequence — XactSequence from SQLTrace
   — TextData not implemented in XE for this event
 )
),
ADD EVENT sqlserver.server_memory_change(
 ACTION
 (
     package0.event_sequence — EventSequence from SQLTrace
   , sqlserver.is_system — IsSystem from SQLTrace
   , sqlserver.request_id — RequestID from SQLTrace
   , sqlserver.server_instance_name — ServerName from SQLTrace
   , sqlserver.session_id — SPID from SQLTrace
   , sqlserver.session_server_principal_name — SessionLoginName from SQLTrace
   , sqlserver.transaction_id — TransactionID from SQLTrace
   , sqlserver.transaction_sequence — XactSequence from SQLTrace
 )
),
ADD EVENT sqlserver.server_start_stop(
 ACTION
 (
     sqlserver.client_app_name — ApplicationName from SQLTrace
   , sqlserver.client_hostname — HostName from SQLTrace
   , sqlserver.client_pid — ClientProcessID from SQLTrace
   , package0.event_sequence — EventSequence from SQLTrace
   , sqlserver.is_system — IsSystem from SQLTrace
   , sqlserver.nt_username — NTUserName from SQLTrace
   , sqlserver.nt_username — NTDomainName from SQLTrace
   , sqlserver.request_id — RequestID from SQLTrace
   , sqlserver.server_instance_name — ServerName from SQLTrace
   , sqlserver.server_principal_name — LoginName from SQLTrace
   , sqlserver.server_principal_sid — LoginSid from SQLTrace
   , sqlserver.session_id — SPID from SQLTrace
   , sqlserver.session_server_principal_name — SessionLoginName from SQLTrace
 )
),
ADD EVENT sqlserver.sort_warning(
 ACTION
 (
     sqlserver.client_app_name — ApplicationName from SQLTrace
   , sqlserver.client_hostname — HostName from SQLTrace
   , sqlserver.client_pid — ClientProcessID from SQLTrace
   , sqlserver.database_id — DatabaseID from SQLTrace
   , sqlserver.database_name — DatabaseName from SQLTrace
   , package0.event_sequence — EventSequence from SQLTrace
   , sqlserver.is_system — IsSystem from SQLTrace
   , sqlserver.nt_username — NTUserName from SQLTrace
   , sqlserver.nt_username — NTDomainName from SQLTrace
   , sqlserver.request_id — RequestID from SQLTrace
   , sqlserver.server_instance_name — ServerName from SQLTrace
   , sqlserver.server_principal_name — LoginName from SQLTrace
   , sqlserver.server_principal_sid — LoginSid from SQLTrace
   , sqlserver.session_id — SPID from SQLTrace
   , sqlserver.session_resource_group_id — GroupID from SQLTrace
   , sqlserver.session_server_principal_name — SessionLoginName from SQLTrace
   , sqlserver.transaction_id — TransactionID from SQLTrace
   , sqlserver.transaction_sequence — XactSequence from SQLTrace
 )
)
ADD TARGET package0.event_file
(
 SET filename = 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Log\XE_Default_Trace.xel',
  max_file_size = 20,
  max_rollover_files = 5
)
