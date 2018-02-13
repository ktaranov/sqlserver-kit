/*
Original link: https://www.scarydba.com/2018/02/05/wait-statistics-query/
Author: Grant Fritchey
*/

CREATE EVENT SESSION ProcedureWaits
ON SERVER
    ADD EVENT sqlos.wait_completed
    (SET collect_wait_resource = (1)
     WHERE (sqlserver.equal_i_sql_unicode_string(sqlserver.database_name, N'AdventureWorks2017'))),
    ADD EVENT sqlserver.module_end
    (WHERE (   sqlserver.database_name = N'AdventureWorks2017'
               AND object_name = N'ProductTransactionHistoryByReference')),
    ADD EVENT sqlserver.rpc_completed
    (WHERE (sqlserver.database_name = N'AdventureWorks2017')),
    ADD EVENT sqlserver.rpc_starting
    (WHERE (sqlserver.database_name = N'AdventureWorks2017'))
WITH (TRACK_CAUSALITY = ON);
