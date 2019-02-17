/*
Original link: https://www.scarydba.com/2018/10/15/using-extended-events-to-capture-implicit-conversions/
Author: Grant Fritchey
*/
-- If the Event Session exists DROP it
IF EXISTS (SELECT 1
FROM sys.server_event_sessions
WHERE name = N'ImplicitConversionOnly')
    DROP EVENT SESSION ImplicitConversionOnly ON SERVER;

CREATE EVENT SESSION ImplicitConversionOnly
ON SERVER
ADD EVENT sqlserver.plan_affecting_convert
(ACTION (sqlserver.sql_text)
-- WHERE (sqlserver.equal_i_sql_unicode_string(sqlserver.database_name, N'AdventureWorks2017'))
)
ADD TARGET package0.event_file
(SET filename = N'ImplicitConversionOnly');

ALTER EVENT SESSION ImplicitConversionOnly ON SERVER STATE = START;
GO
