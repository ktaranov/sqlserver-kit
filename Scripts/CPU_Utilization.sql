/*
Author: Benjamin Nevarez
Original link: http://sqlblog.com/blogs/ben_nevarez/archive/2009/07/26/getting-cpu-utilization-data-from-sql-server.aspx
*/


DECLARE @ts_now BIGINT;

SELECT @ts_now = cpu_ticks / CONVERT(FLOAT, cpu_ticks)
FROM   sys.dm_os_sys_info;

SELECT record_id
     , Dateadd(ms, -1 * ( @ts_now - [timestamp])
     , Getdate()) AS EventTime
     , sqlprocessutilization
     , systemidle
     , 100 - systemidle - sqlprocessutilization AS OtherProcessUtilization
FROM   (SELECT record.value('(./Record/@id)[1]', 'int') AS record_id
             , record.value('(./Record/SchedulerMonitorEvent/SystemHealth/SystemIdle)[1]', 'int') AS SystemIdle
             , record.value('(./Record/SchedulerMonitorEvent/SystemHealth/ProcessUtilization)[1]', 'int') AS SQLProcessUtilization
             , timestamp
 FROM   (SELECT timestamp
              , CONVERT(XML, record) AS record
         FROM   sys.dm_os_ring_buffers
         WHERE  ring_buffer_type = N'RING_BUFFER_SCHEDULER_MONITOR'
            AND record LIKE '%<SystemHealth>%') AS x) AS y
ORDER BY record_id DESC;
