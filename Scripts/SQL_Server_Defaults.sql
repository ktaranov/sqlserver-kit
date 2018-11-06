WITH CTE_Defaults (ObjectName, AppliesToObjectType, SettingTypeName, SettingName, ConfiguredValue) AS (
      SELECT 'Global', 'Analysis Services', 'Analysis Services', 'Collect Memory by Category Data', 'No' UNION
      SELECT 'Global', 'Analysis Services', 'Analysis Services', 'Maintenance Window Enabled', 'No' UNION
      SELECT 'Global', 'Analysis Services', 'Analysis Services', 'Maintenance Window Name', 'None' UNION
      SELECT 'Global', 'Analysis Services', 'Analysis Services', 'Synchronization Threshold', '0.00:30:00' UNION
      SELECT 'Global', 'Analysis Services', 'Analysis Services', 'Synchronization Type', 'Don''t synchronize automatically.' UNION
      SELECT 'Global', 'Analysis Services', 'Top Commands Source', 'Auto-Watch New Objects', 'Yes' UNION
      SELECT 'Global', 'Analysis Services', 'Top Commands Source', 'Collect MDX/DMX/XMLA Events', 'Yes' UNION
      SELECT 'Global', 'Analysis Services', 'Top Commands Source', 'Maximum Rows To Synchronize', '5000' UNION
      SELECT 'Global', 'Analysis Services', 'Top Commands Source', 'Minimum Duration', '0.00:00:01' UNION
      SELECT 'Global', 'Analysis Services', 'Top Commands Source', 'Missed Run Wait Time', '0.00:05:00' UNION
      SELECT 'Global', 'Analytics Platform System', 'Analytics Platform System', 'Maintenance Window Enabled', 'No' UNION
      SELECT 'Global', 'Analytics Platform System', 'Analytics Platform System', 'Maintenance Window Name', 'None' UNION
      SELECT 'Global', 'APS', 'APS Distributed Queries Source', 'Auto-Watch New Objects', 'Yes' UNION
      SELECT 'Global', 'APS', 'APS Distributed Queries Source', 'Maximum Rows To Synchronize', '5000' UNION
      SELECT 'Global', 'APS', 'APS Distributed Queries Source', 'Missed Run Wait Time', '0.00:05:00' UNION
      SELECT 'Global', 'APS', 'APS Health Alerts Source', 'Auto-Watch New Objects', 'Yes' UNION
      SELECT 'Global', 'APS', 'APS Health Alerts Source', 'Maximum Rows To Synchronize', '5000' UNION
      SELECT 'Global', 'APS', 'APS Health Alerts Source', 'Missed Run Wait Time', '0.00:05:00' UNION
      SELECT 'Global', 'APS', 'APS Loader Backup Runs Source', 'Auto-Watch New Objects', 'Yes' UNION
      SELECT 'Global', 'APS', 'APS Loader Backup Runs Source', 'Maximum Rows To Synchronize', '5000' UNION
      SELECT 'Global', 'APS', 'APS Loader Backup Runs Source', 'Missed Run Wait Time', '0.00:05:00' UNION
      SELECT 'Global', 'APS Distributed Queries', 'APS Distributed Queries', 'Maximum Runtime Threshold', '0.00:00:00' UNION
      SELECT 'Global', 'APS Distributed Queries', 'APS Distributed Queries', 'Maximum Runtime Threshold Percent', '250%' UNION
      SELECT 'Global', 'APS Distributed Queries', 'APS Distributed Queries', 'Minimum Runtime Threshold', '0.00:00:00' UNION
      SELECT 'Global', 'APS Distributed Queries', 'APS Distributed Queries', 'Minimum Runtime Threshold Percent', '10%' UNION
      SELECT 'Global', 'APS Loader Backup Run', 'APS Loader Backup Run', 'Maximum Runtime Threshold', '0.00:00:00' UNION
      SELECT 'Global', 'APS Loader Backup Run', 'APS Loader Backup Run', 'Maximum Runtime Threshold Percent', '250%' UNION
      SELECT 'Global', 'APS Loader Backup Run', 'APS Loader Backup Run', 'Minimum Runtime Threshold', '0.00:00:00' UNION
      SELECT 'Global', 'APS Loader Backup Run', 'APS Loader Backup Run', 'Minimum Runtime Threshold Percent', '10%' UNION
      SELECT 'Global', 'Azure SQL Data Warehouse', 'Azure SQL Data Warehouse', 'Maintenance Window Enabled', 'No' UNION
      SELECT 'Global', 'Azure SQL Data Warehouse', 'Azure SQL Data Warehouse', 'Maintenance Window Name', 'None' UNION
      SELECT 'Global', 'Azure SQL Data Warehouse', 'Azure SQL Data Warehouse Distributed Queries Source', 'Auto-Watch New Objects', 'Yes' UNION
      SELECT 'Global', 'Azure SQL Data Warehouse', 'Azure SQL Data Warehouse Distributed Queries Source', 'Maximum Rows To Synchronize', '5000' UNION
      SELECT 'Global', 'Azure SQL Data Warehouse', 'Azure SQL Data Warehouse Distributed Queries Source', 'Missed Run Wait Time', '0.00:05:00' UNION
      SELECT 'Global', 'Azure SQL Data Warehouse', 'Azure SQL Data Warehouse Loader Backup Runs Source', 'Auto-Watch New Objects', 'Yes' UNION
      SELECT 'Global', 'Azure SQL Data Warehouse', 'Azure SQL Data Warehouse Loader Backup Runs Source', 'Maximum Rows To Synchronize', '5000' UNION
      SELECT 'Global', 'Azure SQL Data Warehouse', 'Azure SQL Data Warehouse Loader Backup Runs Source', 'Missed Run Wait Time', '0.00:05:00' UNION
      SELECT 'Global', 'Azure SQL Data Warehouse Distributed Queries', 'Azure SQL Data Warehouse Distributed Queries', 'Maximum Runtime Threshold', '0.00:00:00' UNION
      SELECT 'Global', 'Azure SQL Data Warehouse Distributed Queries', 'Azure SQL Data Warehouse Distributed Queries', 'Maximum Runtime Threshold Percent', '250%' UNION
      SELECT 'Global', 'Azure SQL Data Warehouse Distributed Queries', 'Azure SQL Data Warehouse Distributed Queries', 'Minimum Runtime Threshold', '0.00:00:00' UNION
      SELECT 'Global', 'Azure SQL Data Warehouse Distributed Queries', 'Azure SQL Data Warehouse Distributed Queries', 'Minimum Runtime Threshold Percent', '10%' UNION
      SELECT 'Global', 'Azure SQL Data Warehouse Loader Backup Run', 'Azure SQL Data Warehouse Loader Backup Run', 'Maximum Runtime Threshold', '0.00:00:00' UNION
      SELECT 'Global', 'Azure SQL Data Warehouse Loader Backup Run', 'Azure SQL Data Warehouse Loader Backup Run', 'Maximum Runtime Threshold Percent', '250%' UNION
      SELECT 'Global', 'Azure SQL Data Warehouse Loader Backup Run', 'Azure SQL Data Warehouse Loader Backup Run', 'Minimum Runtime Threshold', '0.00:00:00' UNION
      SELECT 'Global', 'Azure SQL Data Warehouse Loader Backup Run', 'Azure SQL Data Warehouse Loader Backup Run', 'Minimum Runtime Threshold Percent', '10%' UNION
      SELECT 'Global', 'Azure SQL Database', 'Azure SQL Database', 'Maintenance Window Enabled', 'No' UNION
      SELECT 'Global', 'Azure SQL Database', 'Azure SQL Database', 'Maintenance Window Name', 'None' UNION
      SELECT 'Global', 'Azure SQL Database', 'Top SQL Source', 'Auto-Watch New Objects', 'Yes' UNION
      SELECT 'Global', 'Azure SQL Database', 'Top SQL Source', 'Collect Batch and RPC Events', 'No' UNION
      SELECT 'Global', 'Azure SQL Database', 'Top SQL Source', 'Collect Statement Events', 'No' UNION
      SELECT 'Global', 'Azure SQL Database', 'Top SQL Source', 'Maximum Rows To Synchronize', '5000' UNION
      SELECT 'Global', 'Azure SQL Database', 'Top SQL Source', 'Minimum CPU', '0' UNION
      SELECT 'Global', 'Azure SQL Database', 'Top SQL Source', 'Minimum Duration', '0.00:00:05' UNION
      SELECT 'Global', 'Azure SQL Database', 'Top SQL Source', 'Minimum Reads', '0' UNION
      SELECT 'Global', 'Azure SQL Database', 'Top SQL Source', 'Minimum Writes', '0' UNION
      SELECT 'Global', 'Azure SQL Database', 'Top SQL Source', 'Missed Run Wait Time', '0.00:05:00' UNION
      SELECT 'Global', 'Blocking SQL', 'Blocking SQL', 'Maximum Runtime Threshold', '0.00:00:00' UNION
      SELECT 'Global', 'Blocking SQL', 'Blocking SQL', 'Maximum Runtime Threshold Percent', '250%' UNION
      SELECT 'Global', 'Blocking SQL', 'Blocking SQL', 'Minimum Runtime Threshold', '0.00:00:00' UNION
      SELECT 'Global', 'Blocking SQL', 'Blocking SQL', 'Minimum Runtime Threshold Percent', '10%' UNION
      SELECT 'Global', 'Database', 'Databases Source', 'Auto-Watch New Objects', 'Yes' UNION
      SELECT 'Global', 'Database', 'Databases Source', 'Collect Buffer Data when Buffer > 8GB', 'False' UNION
      SELECT 'Global', 'Database', 'Databases Source', 'Max Index Size (MB) to Collect Fragmentation Data', '50000' UNION
      SELECT 'Global', 'Database', 'Databases Source', 'Max Partitions to Collect per Database', '500' UNION
      SELECT 'Global', 'Database', 'Databases Source', 'Maximum Rows To Synchronize', '5000' UNION
      SELECT 'Global', 'Database', 'Databases Source', 'Min Index Size (MB) to Collect Fragmentation Data', '10' UNION
      SELECT 'Global', 'Database', 'Databases Source', 'Missed Run Wait Time', '0.00:05:00' UNION
      SELECT 'Global', 'Index', 'Index Defragmentation', 'Enable Index Defragmentation', 'False' UNION
      SELECT 'Global', 'Index', 'Index Defragmentation', 'Fragmentation Scan Mode', 'Limited' UNION
      SELECT 'Global', 'Index', 'Index Defragmentation', 'MAXDOP', '0' UNION
      SELECT 'Global', 'Index', 'Index Defragmentation', 'Maximum Concurrent Defrag Operations', '1' UNION
      SELECT 'Global', 'Index', 'Index Defragmentation', 'Maximum Duration', '0.02:00:00' UNION
      SELECT 'Global', 'Index', 'Index Defragmentation', 'Maximum Runtime Threshold', '0.00:00:00' UNION
      SELECT 'Global', 'Index', 'Index Defragmentation', 'Maximum Runtime Threshold Percent', '250%' UNION
      SELECT 'Global', 'Index', 'Index Defragmentation', 'Minimum Runtime Threshold', '0.00:00:00' UNION
      SELECT 'Global', 'Index', 'Index Defragmentation', 'Minimum Runtime Threshold Percent', '10%' UNION
      SELECT 'Global', 'Index', 'Index Defragmentation', 'Partitions', 'All' UNION
      SELECT 'Global', 'Index', 'Index Defragmentation', 'Rebuild Threshold %', '30' UNION
      SELECT 'Global', 'Index', 'Index Defragmentation', 'Reorg Threshold %', '10' UNION
      SELECT 'Global', 'Index', 'Index Defragmentation', 'Run Post-defrag Analysis', 'True' UNION
      SELECT 'Global', 'Index', 'Index Defragmentation', 'Schedule', '<not specified>' UNION
      SELECT 'Global', 'Index', 'Index Defragmentation', 'Sort in tempdb', 'False' UNION
      SELECT 'Global', 'Index', 'Index Defragmentation', 'Use Online Rebuild', 'True' UNION
      SELECT 'Global', 'Reporting Services Report', 'Reporting Services Report', 'Maximum Runtime Threshold', '0.00:00:00' UNION
      SELECT 'Global', 'Reporting Services Report', 'Reporting Services Report', 'Maximum Runtime Threshold Percent', '250%' UNION
      SELECT 'Global', 'Reporting Services Report', 'Reporting Services Report', 'Minimum Runtime Threshold', '0.00:00:00' UNION
      SELECT 'Global', 'Reporting Services Report', 'Reporting Services Report', 'Minimum Runtime Threshold Percent', '10%' UNION
      SELECT 'Global', 'SQL Server', 'Blocking SQL Source', 'Auto-Watch New Objects', 'Yes' UNION
      SELECT 'Global', 'SQL Server', 'Blocking SQL Source', 'Maximum Rows To Synchronize', '5000' UNION
      SELECT 'Global', 'SQL Server', 'Blocking SQL Source', 'Minimum Block Duration', '0.00:00:15' UNION
      SELECT 'Global', 'SQL Server', 'Blocking SQL Source', 'Missed Run Wait Time', '0.00:05:00' UNION
      SELECT 'Global', 'SQL Server', 'Deadlocks Source', 'Auto-Watch New Objects', 'Yes' UNION
      SELECT 'Global', 'SQL Server', 'Deadlocks Source', 'Collect Deadlock Events', 'Yes' UNION
      SELECT 'Global', 'SQL Server', 'Deadlocks Source', 'Maximum Rows To Synchronize', '5000' UNION
      SELECT 'Global', 'SQL Server', 'Deadlocks Source', 'Missed Run Wait Time', '0.00:05:00' UNION
      SELECT 'Global', 'SQL Server', 'Maintenance Plans Source', 'Auto-Watch New Objects', 'Yes' UNION
      SELECT 'Global', 'SQL Server', 'Maintenance Plans Source', 'Maximum Rows To Synchronize', '5000' UNION
      SELECT 'Global', 'SQL Server', 'Maintenance Plans Source', 'Missed Run Wait Time', '0.00:05:00' UNION
      SELECT 'Global', 'SQL Server', 'Reporting Services Reports Source', 'Auto-Watch New Objects', 'Yes' UNION
      SELECT 'Global', 'SQL Server', 'Reporting Services Reports Source', 'Maximum Rows To Synchronize', '5000' UNION
      SELECT 'Global', 'SQL Server', 'Reporting Services Reports Source', 'Missed Run Wait Time', '0.00:05:00' UNION
      SELECT 'Global', 'SQL Server', 'SQL Server', 'Auto-enable SQL Server Agent Tokens', 'Yes' UNION
      SELECT 'Global', 'SQL Server', 'SQL Server', 'Auto-recycle Large SQL Server Agent Logs', 'No' UNION
      SELECT 'Global', 'SQL Server', 'SQL Server', 'Maintenance Window Enabled', 'No' UNION
      SELECT 'Global', 'SQL Server', 'SQL Server', 'Maintenance Window Name', 'None' UNION
      SELECT 'Global', 'SQL Server', 'SQL Server', 'Max Databases to Synchronize (largest first)', '100' UNION
      SELECT 'Global', 'SQL Server', 'SQL Server', 'Maximum Queue Length', '5' UNION
      SELECT 'Global', 'SQL Server', 'SQL Server', 'Synchronization Threshold', '0.00:30:00' UNION
      SELECT 'Global', 'SQL Server', 'SQL Server', 'Synchronization Type', 'Don''t synchronize automatically.' UNION
      SELECT 'Global', 'SQL Server', 'SQL Server Agent Alerts Source', 'Auto-Watch New Objects', 'Yes' UNION
      SELECT 'Global', 'SQL Server', 'SQL Server Agent Alerts Source', 'Maximum Rows To Synchronize', '5000' UNION
      SELECT 'Global', 'SQL Server', 'SQL Server Agent Alerts Source', 'Missed Run Wait Time', '0.00:05:00' UNION
      SELECT 'Global', 'SQL Server', 'SQL Server Agent Jobs Source', 'Auto-Watch New Objects', 'Yes' UNION
      SELECT 'Global', 'SQL Server', 'SQL Server Agent Jobs Source', 'Maximum Rows To Synchronize', '5000' UNION
      SELECT 'Global', 'SQL Server', 'SQL Server Agent Jobs Source', 'Missed Run Wait Time', '0.00:05:00' UNION
      SELECT 'Global', 'SQL Server', 'SQL Server Agent Log Source', 'Auto-Watch New Objects', 'Yes' UNION
      SELECT 'Global', 'SQL Server', 'SQL Server Agent Log Source', 'Maximum Rows To Synchronize', '5000' UNION
      SELECT 'Global', 'SQL Server', 'SQL Server Agent Log Source', 'Missed Run Wait Time', '0.00:05:00' UNION
      SELECT 'Global', 'SQL Server', 'Top SQL Source', 'Auto-Watch New Objects', 'Yes' UNION
      SELECT 'Global', 'SQL Server', 'Top SQL Source', 'Collect Batch and RPC Events', 'Yes' UNION
      SELECT 'Global', 'SQL Server', 'Top SQL Source', 'Collect Statement Events', 'Yes' UNION
      SELECT 'Global', 'SQL Server', 'Top SQL Source', 'Maximum Rows To Synchronize', '5000' UNION
      SELECT 'Global', 'SQL Server', 'Top SQL Source', 'Minimum CPU', '0' UNION
      SELECT 'Global', 'SQL Server', 'Top SQL Source', 'Minimum Duration', '0.00:00:05' UNION
      SELECT 'Global', 'SQL Server', 'Top SQL Source', 'Minimum Reads', '0' UNION
      SELECT 'Global', 'SQL Server', 'Top SQL Source', 'Minimum Writes', '0' UNION
      SELECT 'Global', 'SQL Server', 'Top SQL Source', 'Missed Run Wait Time', '0.00:05:00' UNION
      SELECT 'Global', 'SQL Server Agent Job', 'SQL Server Agent Job', 'Auto-start Threshold', '0.04:00:00' UNION
      SELECT 'Global', 'SQL Server Agent Job', 'SQL Server Agent Job', 'Auto-start Threshold Enabled', 'No' UNION
      SELECT 'Global', 'SQL Server Agent Job', 'SQL Server Agent Job', 'Auto-start Type', 'Use default setting.' UNION
      SELECT 'Global', 'SQL Server Agent Job', 'SQL Server Agent Job', 'Behavior When Queued', 'Never Queue.' UNION
      SELECT 'Global', 'SQL Server Agent Job', 'SQL Server Agent Job', 'Behavior When Queuing', 'Never Queue.' UNION
      SELECT 'Global', 'SQL Server Agent Job', 'SQL Server Agent Job', 'Maximum Runtime Threshold', '0.00:00:00' UNION
      SELECT 'Global', 'SQL Server Agent Job', 'SQL Server Agent Job', 'Maximum Runtime Threshold Percent', '250%' UNION
      SELECT 'Global', 'SQL Server Agent Job', 'SQL Server Agent Job', 'Minimum Runtime Threshold', '0.00:00:00' UNION
      SELECT 'Global', 'SQL Server Agent Job', 'SQL Server Agent Job', 'Minimum Runtime Threshold Percent', '10%' UNION
      SELECT 'Global', 'SQL Server Agent Job', 'SQL Server Agent Job', 'Queue For', '0.00:30:00' UNION
      SELECT 'Global', 'SQL Server Agent Job', 'SQL Server Agent Job', 'Queue Others For', '0.00:30:00' UNION
      SELECT 'Global', 'Top Commands', 'Top Commands', 'Maximum Runtime Threshold', '0.01:00:00' UNION
      SELECT 'Global', 'Top Commands', 'Top Commands', 'Maximum Runtime Threshold Percent', '250%' UNION
      SELECT 'Global', 'Top Commands', 'Top Commands', 'Minimum Runtime Threshold', '0.00:00:00' UNION
      SELECT 'Global', 'Top Commands', 'Top Commands', 'Minimum Runtime Threshold Percent', '10%' UNION
      SELECT 'Global', 'Top SQL', 'Top SQL', 'Maximum Runtime Threshold', '0.01:00:00' UNION
      SELECT 'Global', 'Top SQL', 'Top SQL', 'Maximum Runtime Threshold Percent', '250%' UNION
      SELECT 'Global', 'Top SQL', 'Top SQL', 'Minimum Runtime Threshold', '0.00:00:00' UNION
      SELECT 'Global', 'Top SQL', 'Top SQL', 'Minimum Runtime Threshold Percent', '10%' UNION
      SELECT 'Global', 'Windows', 'Windows Event Logs Source', 'Auto-Watch New Objects', 'Yes' UNION
      SELECT 'Global', 'Windows', 'Windows Event Logs Source', 'Maximum Rows To Synchronize', '5000' UNION
      SELECT 'Global', 'Windows', 'Windows Event Logs Source', 'Missed Run Wait Time', '0.00:05:00' UNION
      SELECT 'Global', 'Windows', 'Windows Tasks Source', 'Auto-Watch New Objects', 'Yes' UNION
      SELECT 'Global', 'Windows', 'Windows Tasks Source', 'Maximum Rows To Synchronize', '5000' UNION
      SELECT 'Global', 'Windows', 'Windows Tasks Source', 'Missed Run Wait Time', '0.00:05:00' UNION
      SELECT 'Global', 'Windows Computer', 'Windows Computer', 'Maintenance Window Enabled', 'No' UNION
      SELECT 'Global', 'Windows Computer', 'Windows Computer', 'Maintenance Window Name', 'None' UNION
      SELECT 'Global', 'Windows Task', 'Windows Task', 'Maximum Runtime Threshold', '0.00:00:00' UNION
      SELECT 'Global', 'Windows Task', 'Windows Task', 'Maximum Runtime Threshold Percent', '250%' UNION
      SELECT 'Global', 'Windows Task', 'Windows Task', 'Minimum Runtime Threshold', '0.00:00:00' UNION
      SELECT 'Global', 'Windows Task', 'Windows Task', 'Minimum Runtime Threshold Percent', '10%'
)
SELECT * FROM CTE_Defaults;
