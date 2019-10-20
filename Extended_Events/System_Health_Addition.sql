/*
Original link: https://karaszi.com/looking-for-strange
Author: Tibor Karaszi's
*/

--Stop trace if started
IF EXISTS (SELECT * FROM sys.dm_xe_sessions WHERE name = 'SystemHealthAddition')
  ALTER EVENT SESSION SystemHealthAddition ON SERVER STATE = STOP;

--Delete trace if exists
IF EXISTS (SELECT * FROM sys.server_event_sessions WHERE name = 'SystemHealthAddition')
  DROP EVENT SESSION SystemHealthAddition ON SERVER;

--Create trace
CREATE EVENT SESSION [SystemHealthAddition] ON SERVER
ADD EVENT sqlserver.attention(
  WHERE (package0.greater_than_uint64(database_id,(4))
  AND package0.equal_boolean(sqlserver.is_system,(0)))) ,
ADD EVENT sqlserver.auto_stats(
  WHERE (package0.greater_than_uint64(database_id,(4))
  AND package0.equal_boolean(sqlserver.is_system,(0))
  AND package0.greater_than_equal_int64(object_id,(1000000))
  AND package0.greater_than_uint64(duration,(10)))),
ADD EVENT sqlserver.database_file_size_change,
ADD EVENT sqlserver.database_started,
ADD EVENT sqlserver.lock_deadlock,
ADD EVENT sqlserver.lock_escalation,
ADD EVENT sqlserver.lock_timeout_greater_than_0,
ADD EVENT sqlserver.long_io_detected,

--Begin performance section
ADD EVENT qds.query_store_plan_forcing_failed,
ADD EVENT sqlserver.exchange_spill,
ADD EVENT sqlserver.execution_warning,
ADD EVENT sqlserver.hash_spill_details,
ADD EVENT sqlserver.hash_warning,
ADD EVENT sqlserver.optimizer_timeout,
ADD EVENT sqlserver.query_memory_grant_blocking,
ADD EVENT sqlserver.query_memory_grants,
ADD EVENT sqlserver.sort_warning,
ADD EVENT sqlserver.window_spool_ondisk_warning
--End performance section

ADD TARGET package0.event_counter;
GO

/*
--Start trace
ALTER EVENT SESSION SystemHealthAddition ON SERVER STATE = START;
*/
