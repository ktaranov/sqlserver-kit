/*
Author: Slava Murygin
Original link: http://slavasql.blogspot.ru/2016/03/sql-server-cpu-utilization-in-graphical.html
*/

DECLARE @gc VARCHAR(MAX), @gi VARCHAR(MAX);
WITH BR_Data as (
 SELECT timestamp, CONVERT(XML, record) as record
 FROM sys.dm_os_ring_buffers
 WHERE ring_buffer_type = N'RING_BUFFER_SCHEDULER_MONITOR' and record like '%<SystemHealth>%'
), Extracted_XML as (
 SELECT timestamp, record.value('(./Record/@id)[1]', 'int') as record_id,
  record.value('(./Record/SchedulerMonitorEvent/SystemHealth/SystemIdle)[1]', 'bigint') as SystemIdle,
  record.value('(./Record/SchedulerMonitorEvent/SystemHealth/ProcessUtilization)[1]', 'bigint') as SQLCPU
 FROM BR_Data
), CPU_Data as (
 SELECT record_id, ROW_NUMBER() OVER(ORDER BY record_id) as rn,
    dateadd(ms, -1 * ((SELECT ms_ticks  FROM sys.dm_os_sys_info) - [timestamp]), GETDATE()) as EventTime,
    SQLCPU, SystemIdle, 100 - SystemIdle - SQLCPU as OtherCPU
 FROM Extracted_XML )
SELECT @gc = CAST((SELECT  CAST(d1.rn as VARCHAR) + ' ' + CAST(d1.SQLCPU as VARCHAR) + ',' FROM CPU_Data as d1 ORDER BY d1.rn FOR XML PATH('')) as VARCHAR(MAX)),
@gi = CAST((SELECT  CAST(d1.rn as VARCHAR) + ' ' + CAST(d1.OtherCPU as VARCHAR) + ',' FROM CPU_Data as d1 ORDER BY d1.rn FOR XML PATH('')) as VARCHAR(MAX))
OPTION (RECOMPILE);

SELECT CAST('LINESTRING(' + LEFT(@gc,LEN(@gc)-1) + ')' as GEOMETRY), 'SQL CPU %' as Measure
UNION ALL
SELECT CAST('LINESTRING(1 100,2 100)' as GEOMETRY), ''
UNION ALL
SELECT CAST('LINESTRING(' + LEFT(@gi,LEN(@gi)-1) + ')' as GEOMETRY), 'Other CPU %';
