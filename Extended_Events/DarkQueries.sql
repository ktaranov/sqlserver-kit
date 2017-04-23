CREATE EVENT SESSION [DarkQueries] ON SERVER
  ADD EVENT sqlserver.sql_statement_recompile(
    ACTION(sqlserver.database_id,sqlserver.sql_text)
    WHERE ([recompile_cause]=(11))) -- Option (RECOMPILE) Requested
  ADD TARGET package0.event_file(SET filename=N'DarkQueries');
  
ALTER EVENT SESSION [DarkQueries] ON SERVER STATE = START;


SELECT DarkQueryData.eventDate,
       DB_NAME(DarkQueryData.database_id) as DatabaseName,
       DarkQueryData.object_type,
       COALESCE(DarkQueryData.sql_text, 
                OBJECT_NAME(DarkQueryData.object_id, DarkQueryData.database_id)) command,
       DarkQueryData.recompile_cause
  FROM sys.fn_xe_file_target_read_file ( 'DarkQueries*xel', null, null, null) event_file_value
 CROSS APPLY ( SELECT CAST(event_file_value.[event_data] as xml) ) event_file_value_xml ([xml])
 CROSS APPLY (
         SELECT event_file_value_xml.[xml].value('(event/@timestamp)[1]', 'datetime') as eventDate,
                event_file_value_xml.[xml].value('(event/action[@name="sql_text"]/value)[1]', 'nvarchar(max)') as sql_text,
                event_file_value_xml.[xml].value('(event/data[@name="object_type"]/text)[1]', 'nvarchar(100)') as object_type,
                event_file_value_xml.[xml].value('(event/data[@name="object_id"]/value)[1]', 'bigint') as object_id,
                event_file_value_xml.[xml].value('(event/data[@name="source_database_id"]/value)[1]', 'bigint') as database_id,
                event_file_value_xml.[xml].value('(event/data[@name="recompile_cause"]/text)[1]', 'nvarchar(100)') as recompile_cause
       ) as DarkQueryData
 ORDER BY eventDate DESC;
