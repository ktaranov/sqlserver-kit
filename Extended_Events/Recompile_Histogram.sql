CREATE EVENT SESSION Recompile_Histogram ON SERVER 
  ADD EVENT sqlserver.sql_statement_recompile
  ADD TARGET package0.histogram (
      SET filtering_event_name=N'sqlserver.sql_statement_recompile',
          source=N'recompile_cause',
          source_type=(0) );
 
ALTER EVENT SESSION Recompile_Histogram ON SERVER STATE = START;

SELECT sv.subclass_name as recompile_cause, 
       shredded.recompile_count
  FROM sys.dm_xe_session_targets AS xet  
  JOIN sys.dm_xe_sessions AS xe  
       ON (xe.address = xet.event_session_address)  
 CROSS APPLY ( SELECT CAST(xet.target_data as xml) ) as target_data_xml ([xml])
 CROSS APPLY target_data_xml.[xml].nodes('/HistogramTarget/Slot') AS nodes (slot_data)
 CROSS APPLY (
         SELECT nodes.slot_data.value('(value)[1]', 'int') AS recompile_cause,
                nodes.slot_data.value('(@count)[1]', 'int') AS recompile_count
       ) as shredded
  JOIN sys.trace_subclass_values AS sv
       ON shredded.recompile_cause = sv.subclass_value
 WHERE xe.name = 'Recompile_Histogram' 
   AND sv.trace_event_id = 37 -- SP:Recompile;
