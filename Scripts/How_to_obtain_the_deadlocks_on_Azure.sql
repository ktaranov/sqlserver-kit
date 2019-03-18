/*
Author: Jose M Jurado
Created Date: 2017-01-21
Original link: https://blogs.msdn.microsoft.com/azuresqldbsupport/2017/01/21/lesson-learned-19-how-to-obtain-the-deadlocks-of-your-azure-sql-database/
Source link: https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/How_to_obtain_the_deadlocks_on_Azure.sql
Modified: 2019-03-18 by Konstantin Taranov
*/

USE master;
GO

WITH CTE AS (
       SELECT CAST(event_data AS XML) AS [target_data_XML]
       FROM sys.fn_xe_telemetry_blob_target_read_file('dl', null, null, null)
)
SELECT target_data_XML.value('(/event/@timestamp)[1]', 'DateTime2') AS [Timestamp]
     , target_data_XML.query('/event/data[@name=''xml_report'']/value/deadlock') AS deadlock_xml
     , target_data_XML.query('/event/data[@name=''database_name'']/value').value('(/value)[1]', 'nvarchar(100)') AS [db_name]
FROM CTE;
