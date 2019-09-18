/*
https://sql-sasquatch.blogspot.com/2019/09/placeholder.html
*/

WITH tgt AS (SELECT instance_name, cntr_value
              FROM sys.dm_os_performance_counters
              WHERE counter_name = 'Target Node Memory (KB)'
     UNION ALL
     SELECT 'TOTAL', cntr_value
              FROM sys.dm_os_performance_counters
              WHERE counter_name = 'Target Server Memory (KB)'),
tot AS (SELECT instance_name, cntr_value
              FROM sys.dm_os_performance_counters
              WHERE counter_name = 'Total Node Memory (KB)'
     UNION ALL
     SELECT 'TOTAL', cntr_value
              FROM sys.dm_os_performance_counters
              WHERE counter_name = 'Total Server Memory (KB)'),
dbc AS (SELECT instance_name, cntr_value
              FROM sys.dm_os_performance_counters
              WHERE counter_name = 'Database Node Memory (KB)'
     UNION ALL
     SELECT 'TOTAL', cntr_value
              FROM sys.dm_os_performance_counters
              WHERE counter_name = 'Database Cache Memory (KB)'),
stl AS (SELECT instance_name, cntr_value
              FROM sys.dm_os_performance_counters
              WHERE counter_name = 'Stolen Node Memory (KB)'
     UNION ALL
     SELECT 'TOTAL', cntr_value
              FROM sys.dm_os_performance_counters
              WHERE counter_name = 'Stolen Server Memory (KB)'),
fre AS (SELECT instance_name, cntr_value
              FROM sys.dm_os_performance_counters
              WHERE counter_name = 'Free Node Memory (KB)'
     UNION ALL
     SELECT 'TOTAL', cntr_value
              FROM sys.dm_os_performance_counters
              WHERE counter_name = 'Free Memory (KB)'),
frn AS (SELECT instance_name, cntr_value
              FROM sys.dm_os_performance_counters
              WHERE counter_name = 'Foreign Node Memory (KB)'
     UNION ALL
     SELECT 'TOTAL', cntr_value = CONVERT(INT, NULL))
SELECT tgt.instance_name, target_kb =  tgt.cntr_value,
       total_kb = tot.cntr_value, dbCache_kb = dbc.cntr_value,
    stolen_kb = stl.cntr_value, free_kb = fre.cntr_value,
       foreign_kb = frn.cntr_value
FROM tgt 
INNER JOIN tot ON tgt.instance_name = tot.instance_name
INNER JOIN frn ON tgt.instance_name = frn.instance_name
INNER JOIN dbc ON tgt.instance_name = dbc.instance_name
INNER JOIN stl ON tgt.instance_name = stl.instance_name
INNER JOIN fre ON tgt.instance_name = fre.instance_name;
