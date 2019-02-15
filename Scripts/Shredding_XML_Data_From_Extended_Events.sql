/*
Author: Max Vernon 
Created Date: 2019-02-10
Original link: https://itsalljustelectrons.blogspot.com/2019/02/shredding-xml-data-from-extended-events.html
Source link: https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Shredding_XML_Data_From_Extended_Events.sql
Modified: 2019-02-14 by Konstantin Taranov
*/

USE master;
GO

IF OBJECT_ID('XE_TSQL_TypeXref') IS NULL
EXEC('CREATE VIEW XE_TSQL_TypeXref AS SELECT 1 AS Alias');
GO

/*
 This view attempts to map each Extended Events data type
 to a TSQL data type.
*/
ALTER VIEW dbo.XE_TSQL_TypeXref
AS
SELECT  
 o.name XE_type, o.description XE_type_description, 
 o.capabilities, o.capabilities_desc, o.type_size XE_type_size,
 CASE type_name
  --These mappings should be safe.
  --They correspond almost directly to each other.
  WHEN 'ansi_string' THEN 'VARCHAR(MAX)'
  WHEN 'binary_data' THEN 'VARBINARY(MAX)'
  WHEN 'boolean' THEN 'BIT'
  WHEN 'char' THEN 'VARCHAR(MAX)'
  WHEN 'guid' THEN 'UNIQUEIDENTIFIER'
  WHEN 'int16' THEN 'SMALLINT'
  WHEN 'int32' THEN 'INT'
  WHEN 'int64' THEN 'BIGINT'
  WHEN 'int8' THEN 'SMALLINT'
  WHEN 'uint16' THEN 'INT'
  WHEN 'uint32' THEN 'BIGINT'
  WHEN 'uint64' THEN 'BIGINT' --possible overflow?
  WHEN 'uint8' THEN 'SMALLINT'
  WHEN 'unicode_string' THEN 'NVARCHAR(MAX)'
  WHEN 'xml' THEN 'XML'

  --These mappings are based off of descriptions and type_size.
  WHEN 'cpu_cycle' THEN 'BIGINT'
  WHEN 'filetime' THEN 'BIGINT'
  WHEN 'wchar' THEN 'NVARCHAR(2)'

  --How many places of precision?
  WHEN 'float32' THEN 'NUMERIC(30, 4)'
  WHEN 'float64' THEN 'NUMERIC(30, 4)'

  --These mappings? Not sure. Default to NVARCHAR(MAX).
  WHEN 'activity_id' THEN 'NVARCHAR(MAX)'
  WHEN 'activity_id_xfer' THEN 'NVARCHAR(MAX)'
  WHEN 'ansi_string_ptr' THEN 'NVARCHAR(MAX)'
  WHEN 'callstack' THEN 'NVARCHAR(MAX)'
  WHEN 'guid_ptr' THEN 'NVARCHAR(MAX)'
  WHEN 'null' THEN 'NVARCHAR(MAX)'
  WHEN 'ptr' THEN 'NVARCHAR(MAX)'
  WHEN 'unicode_string_ptr' THEN 'NVARCHAR(MAX)'
 END AS SqlDataType
FROM sys.dm_xe_objects o
WHERE o.object_type = 'type';
GO


DECLARE @XESessionName SYSNAME = N'system_health';
DECLARE @Tsql NVARCHAR(MAX) = N'';

;WITH AllSessionEventFields AS
(
 --Unique Global Fields (Actions) across all events for the session.
 SELECT DISTINCT sa.name EventField, 'action' AS XmlNodeName, 
  CASE WHEN x.SqlDataType IS NULL THEN 'text' ELSE 'value' END AS XmlSubNodeName,
  'Global Fields (Action)' AS FieldType, o.type_name XE_type, 
  COALESCE(x.SqlDataType, 'NVARCHAR(MAX)') AS SqlDataType
 FROM sys.server_event_sessions s
 JOIN sys.server_event_session_events se
  ON se.event_session_id = s.event_session_id
 JOIN sys.server_event_session_actions sa
  ON sa.event_session_id = s.event_session_id
  AND sa.event_id = se.event_id
 JOIN sys.dm_xe_objects o ON o.name = sa.name AND o.object_type = 'action'
 LEFT JOIN master.dbo.XE_TSQL_TypeXref x ON x.XE_type = o.type_name
 WHERE s.name = @XESessionName
 UNION
 --Unique Event Fields across all events for the session.
 SELECT DISTINCT c.name EventField, 'data' AS XmlNodeName, 
  CASE WHEN x.SqlDataType IS NULL THEN 'text' ELSE 'value' END AS XmlSubNodeName,
  'Event Fields' AS FieldType, c.type_name XE_type, 
  COALESCE(x.SqlDataType, 'NVARCHAR(MAX)') AS SqlDataType
 FROM sys.server_event_sessions s
 JOIN sys.server_event_session_events se
  ON se.event_session_id = s.event_session_id
 JOIN sys.dm_xe_object_columns c
  ON c.object_name = se.name
  AND c.column_type = 'data' 
 LEFT JOIN master.dbo.XE_TSQL_TypeXref x
  ON x.XE_type = c.type_name
 WHERE s.name = @XESessionName
)
SELECT @Tsql = @Tsql + CHAR(9) + 
 CASE
  WHEN f.SqlDataType = 'XML' THEN
   'event_data.query (''(/event/' + f.XmlNodeName + '[@name=''''' + f.EventField + ''''']/' +
    f.XmlSubNodeName + ')[1]'') AS [' + f.EventField + '],' + CHAR(13) + CHAR(10)
  ELSE
   'event_data.value (''(/event/' + f.XmlNodeName + '[@name=''''' + f.EventField + ''''']/' +
    f.XmlSubNodeName + ')[1]'', ''' + f.SqlDataType + ''') AS [' + f.EventField + '],' + CHAR(13) + CHAR(10)
  END
FROM AllSessionEventFields f
ORDER BY f.EventField;

SELECT @Tsql = LEFT(@Tsql, LEN(@Tsql) - 3);
SELECT @Tsql = ';WITH XEvents AS
(
 SELECT object_name, CAST(event_data AS XML) AS event_data
 FROM sys.fn_xe_file_target_read_file ( ''' + @XESessionName + '*.xel'', NULL, NULL, NULL )  
)
SELECT TOP(100) object_name, event_data,' + CHAR(13) + CHAR(10) + @Tsql + '
FROM XEvents;';

PRINT(@Tsql);
EXEC(@Tsql);
