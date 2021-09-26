/*
https://jasonbrimhall.info/2021/01/02/powerful-monitoring-for-your-linked-servers-with-xevents/
by Jason Brimhall 2021-01-02
*/

/* Create the Event Session */
IF EXISTS
(
    SELECT *
    FROM sys.server_event_sessions
    WHERE name = 'LinkedServerMonitor'
)
    DROP EVENT SESSION LinkedServerMonitor ON SERVER;
GO


CREATE EVENT SESSION [LinkedServerMonitor]
ON SERVER
    ADD EVENT sqlserver.oledb_data_read
    (ACTION
     (
         package0.callstack
       , sqlserver.client_app_name
       , sqlserver.database_name
       , sqlserver.nt_username
       , sqlserver.query_hash
       , sqlserver.query_plan_hash
       , sqlserver.session_id
       , sqlserver.sql_text
       , sqlserver.client_hostname
       , sqlserver.tsql_stack
       , package0.event_sequence
       , sqlserver.context_info
       , sqlserver.client_connection_id
       , sqlserver.username
       , sqlserver.database_id
     )
    )
  , ADD EVENT sqlserver.oledb_query_interface
    (ACTION
     (
         package0.callstack
       , sqlserver.client_app_name
       , sqlserver.database_name
       , sqlserver.nt_username
       , sqlserver.query_hash
       , sqlserver.query_plan_hash
       , sqlserver.session_id
       , sqlserver.sql_text
       , sqlserver.client_hostname
       , sqlserver.tsql_stack
       , package0.event_sequence
       , sqlserver.context_info
       , sqlserver.client_connection_id
       , sqlserver.username
       , sqlserver.database_id
     )
    )
  , ADD EVENT sqlserver.oledb_error
    (ACTION
     (
         package0.callstack
       , sqlserver.client_app_name
       , sqlserver.database_name
       , sqlserver.nt_username
       , sqlserver.query_hash
       , sqlserver.query_plan_hash
       , sqlserver.session_id
       , sqlserver.sql_text
       , sqlserver.client_hostname
       , sqlserver.tsql_stack
       , package0.event_sequence
       , sqlserver.context_info
       , sqlserver.client_connection_id
       , sqlserver.username
       , sqlserver.database_id
     )
    )  
    , ADD EVENT sqlserver.oledb_provider_information
    (ACTION
     (
         package0.callstack
       , sqlserver.client_app_name
       , sqlserver.database_name
       , sqlserver.nt_username
       , sqlserver.query_hash
       , sqlserver.query_plan_hash
       , sqlserver.session_id
       , sqlserver.sql_text
       , sqlserver.client_hostname
       , sqlserver.tsql_stack
       , package0.event_sequence
       , sqlserver.context_info
       , sqlserver.client_connection_id
       , sqlserver.username
       , sqlserver.database_id
     )
    )
      , ADD EVENT sqlserver.oledb_provider_initialized
    (ACTION
     (
         package0.callstack
       , sqlserver.client_app_name
       , sqlserver.database_name
       , sqlserver.nt_username
       , sqlserver.query_hash
       , sqlserver.query_plan_hash
       , sqlserver.session_id
       , sqlserver.sql_text
       , sqlserver.client_hostname
       , sqlserver.tsql_stack
       , package0.event_sequence
       , sqlserver.context_info
       , sqlserver.client_connection_id
       , sqlserver.username
       , sqlserver.database_id
     )
    )
    ADD TARGET package0.event_file
    (SET filename = N'C:\XE\LinkedServerMonitor', max_file_size = (256), max_rollover_files = (2))
  , ADD TARGET package0.histogram
    (SET filtering_event_name = N'sqlserver.oledb_data_read'
        , slots = (10000) --modify depending on your needs
        , source = N'sqlserver.tsql_stack')
WITH
(
   MAX_DISPATCH_LATENCY = 5 SECONDS
  , TRACK_CAUSALITY = ON
  , STARTUP_STATE = ON
);
GO


ALTER EVENT SESSION LinkedServerMonitor ON SERVER STATE = START;
GO
