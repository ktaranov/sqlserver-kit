/*
Author: Frank Gill
Original link: https://skreebydba.com/2016/07/18/identifying-in-memory-objects-when-querying-the-transaction-log/
*/


SELECT 
f.[Current LSN],
f.Operation,
f.Context,
f.[Transaction ID],
f.operation_desc,
f.tx_end_timestamp,
f.total_size,
OBJECT_NAME(m.object_id) AS ObjectName,
f.newrow_identity,
f.newrow_data,
f.newrow_datasize,
f.oldrow_begin_timestamp,
f.oldrow_identity,
f.oldrow_key_data,
f.oldrow_key_datasize,
f.xtp_description,
f.[Log Record Fixed Length],
f.[Log Record Length],
f.[Flag Bits],
f.[Log Reserve],
f.[Log Record]
FROM fn_dblog_xtp(NULL,NULL) AS f
INNER JOIN sys.memory_optimized_tables_internal_attributes m
ON (f.xtp_object_id - 2147483648) = (m.xtp_object_id + 2147483648) 
WHERE Operation LIKE '%HK%';
GO