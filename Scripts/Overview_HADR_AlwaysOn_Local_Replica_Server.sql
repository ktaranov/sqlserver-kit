/*==================================================================
Script: HADR Local Replica Overview.sql
Description: This script will display a utilisation overview
of the local Availability Group Replica Server.
The overview will contain amount of databases as
well as total size of databases (DATA, LOG, FILESTREAM)
and is group by ...
1) ... Replica role (PRIMARY / SECONDARY)
2) ... Availability Group
Сreated вфеу: 2018-09-05
Author: Dominic Wirth
Original link: https://blog.sqlauthority.com/2018/09/11/sql-server-scripts-to-overview-hadr-alwayson-local-replica-server/
Source link: https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Overview_HADR_AlwaysOn_Local_Replica_Server.sql
Modified: 2019-01-29 by Konstantin Taranov
Script Version: 1.1
SQL Version: SQL Server 2014 or higher
====================================================================*/


-- Load size of databases which are part of an Availability Group
DECLARE @dbSizes TABLE (DatabaseId INT,
    DbTotalSizeMB INT,
    DbTotalSizeGB DECIMAL(10,2));
DECLARE @dbId INT, @stmt NVARCHAR(MAX);

SELECT @dbId = MIN(database_id)
FROM sys.databases
WHERE group_database_id IS NOT NULL;

WHILE @dbId IS NOT NULL
BEGIN
    SELECT @stmt = 'USE [' + DB_NAME(@dbId) + ']; SELECT ' + CAST(@dbId AS NVARCHAR) + ', (SUM([size]) / 128.0), (SUM([size]) / 128.0 / 1024.0) FROM sys.database_files;';
    INSERT INTO @dbSizes
        (DatabaseId, DbTotalSizeMB, DbTotalSizeGB)
    EXEC (@stmt);
    SELECT @dbId = MIN(database_id)
    FROM sys.databases
    WHERE group_database_id IS NOT NULL AND database_id > @dbId;
END;

-- Show utilisation overview grouped by replica role
SELECT AR.replica_server_name, DRS.is_primary_replica AS IsPrimaryReplica, COUNT(DB.database_id) AS [Databases]
, SUM(DBS.DbTotalSizeMB) AS SizeOfAllDatabasesMB, SUM(DBS.DbTotalSizeGB) AS SizeOfAllDatabasesGB
FROM sys.dm_hadr_database_replica_states AS DRS
    INNER JOIN sys.availability_replicas AS AR ON DRS.replica_id = AR.replica_id
    LEFT JOIN sys.databases AS DB ON DRS.group_database_id = DB.group_database_id
    LEFT JOIN @dbSizes AS DBS ON DB.database_id = DBS.DatabaseId
WHERE DRS.is_local = 1
GROUP BY DRS.is_primary_replica, AR.replica_server_name
ORDER BY AR.replica_server_name ASC, DRS.is_primary_replica DESC;

-- Show utilisation overview grouped by Availability Group
SELECT AR.replica_server_name, DRS.is_primary_replica AS IsPrimaryReplica, AG.[name] AS AvailabilityGroup, COUNT(DB.database_id) AS [Databases]
, SUM(DBS.DbTotalSizeMB) AS SizeOfAllDatabasesMB, SUM(DBS.DbTotalSizeGB) AS SizeOfAllDatabasesGB
FROM sys.dm_hadr_database_replica_states AS DRS
    INNER JOIN sys.availability_groups AS AG ON DRS.group_id = AG.group_id
    INNER JOIN sys.availability_replicas AS AR ON DRS.replica_id = AR.replica_id
    LEFT JOIN sys.databases AS DB ON DRS.group_database_id = DB.group_database_id
    LEFT JOIN @dbSizes AS DBS ON DB.database_id = DBS.DatabaseId
WHERE DRS.is_local = 1
GROUP BY AG.[name], DRS.is_primary_replica, AR.replica_server_name
ORDER BY AG.[name] ASC, AR.replica_server_name ASC;
