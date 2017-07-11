/*
    Max Server Memory Calculator
    https://bornsql.ca/memory/
    Copyright (c) BornSQL.ca
    Written by Randolph West, released under the MIT License
    Last updated: 9 November 2016
    Based on an original algorithm by Jonathan Kehayias:
    https://www.sqlskills.com/blogs/jonathan/how-much-memory-does-my-sql-server-actually-need/
    Max Worker Thread Stack calculation based on Tiger Toolbox Maintenance Solution.
    Copyright (c) Microsoft Corporation. All rights reserved.
    https://github.com/Microsoft/tigertoolbox/tree/master/MaintenanceSolution
    SQL Server, on a standalone instance, requires the following reserved RAM for a server:
    - 1 GB of RAM for the OS
    - plus 1 GB for each 4 GB of RAM installed from 4 - 16 GB
    - plus 1 GB for every 8 GB RAM installed above 16 GB RAM
    
    Memory for the Thread Stack can also be taken into account:
    - 32-bit, reserve 512KB per thread * Max Worker Threads
    - 64-bit, reserve 2MB per thread * Max Worker Threads
    - 128-bit, reserve 4MB per thread * Max Worker Threads
    
    Thanks to @sqlEmt and @sqlstudent144 for testing.
    Thanks to the Tiger Team for version number and thread stack calculations.
v1.0 - 2016-08-19 - Initial release.
v1.1 - 2016-11-22 - Thread stack reservation; NUMA affinity; new version check.
*/

-- Set this to 1 if you want to configure NUMA Node Affinity
DECLARE @configureNumaNodeAffinity BIT = 0;

DECLARE @physicalMemorySource DECIMAL(20, 4);
DECLARE @physicalMemory DECIMAL(20, 4);
DECLARE @recommendedMemory DECIMAL(20, 4);
DECLARE @overheadMemory DECIMAL(20, 4);

DECLARE @cpuArchitecture DECIMAL(20, 4);
DECLARE @numaNodes INT;
DECLARE @numaNodesAfinned TINYINT;
DECLARE @maxWorkerThreadCount INT;
DECLARE @threadStack DECIMAL(20, 4);

SELECT @cpuArchitecture = CASE WHEN @@VERSION LIKE '%<X64>%' THEN 2 WHEN @@VERSION LIKE '%<IA64>%' THEN 4 ELSE 0.5 END FROM sys.dm_os_windows_info WITH (NOLOCK);
SELECT @numaNodes = COUNT(DISTINCT parent_node_id) FROM sys.dm_os_schedulers WHERE scheduler_id < 255 AND parent_node_id < 64;
SELECT @numaNodesAfinned = COUNT (DISTINCT parent_node_id) FROM sys.dm_os_schedulers WHERE scheduler_id < 255 AND parent_node_id < 64 AND is_online = 1;
SELECT @maxWorkerThreadCount = max_workers_count FROM sys.dm_os_sys_info;
SELECT @threadStack = @maxWorkerThreadCount * @cpuArchitecture / 1024.0;

-- Get physical RAM on server
SELECT @physicalMemorySource = CAST(total_physical_memory_kb AS DECIMAL(20, 4)) / CAST((1024.0) AS DECIMAL(20, 4))
FROM sys.dm_os_sys_memory;

-- Convert to nearest GB
SELECT @physicalMemory = CEILING(@physicalMemorySource / CAST(1024.0 AS DECIMAL(20, 4)));

IF (@physicalMemory <= 2.0)
BEGIN
	SELECT @overheadMemory = 0.5;
END;

IF (@physicalMemory > 2.0
	AND @physicalMemory < 4.0)
BEGIN
	SELECT @overheadMemory = 2.0;
END;

IF (@physicalMemory >= 4.0
	AND @physicalMemory <= 16.0)
BEGIN
	SELECT @overheadMemory = 1.0 /* Operating System minimum */
		+ (@physicalMemory / 4.0);
END;

IF (@physicalMemory > 16.0)
BEGIN
	SELECT @overheadMemory = 1.0 /* Operating System minimum */ + 4.0 /* add in reserved for <= 16GB */
		+ ((@physicalMemory - 16.0) / 8.0);
END;

-- Add in the Max Worker Threads Overhead
SELECT @overheadMemory = @overheadMemory + @threadStack;

DECLARE @editionId BIGINT = CAST(SERVERPROPERTY('EditionID') AS BIGINT);
DECLARE @enterprise BIT = 0;
DECLARE @developer BIT = 0;
DECLARE @override BIT = 0;

IF (
		@editionId IN (
			1804890536,
			1872460670,
			610778273
			)
		)
BEGIN
	SELECT @enterprise = 1;
END;

IF (@editionId = - 2117995310)
	SELECT @developer = 1;

-- Check for Standard Edition Limitations
IF (
		@enterprise = 0
		AND @developer = 0
		)
BEGIN
	DECLARE @ProductVersion INT = CONVERT(INT, (@@MICROSOFTVERSION / 0x1000000) & 0xff);

	IF (@ProductVersion >= 11)
		AND (@physicalMemory > 128)
	BEGIN
		SELECT @overheadMemory = 1.0 + 4.0 + ((128 - 16.0) / 8.0);

		-- Set the memory value to the max allowed, if there is enough headroom
		IF (@physicalMemory - @overheadMemory >= 128)
			SELECT @recommendedMemory = 128,
				@overheadMemory = 0,
				@override = 1;
	END;

	IF (@ProductVersion < 11)
		AND (@physicalMemory > 64)
	BEGIN
		SELECT @overheadMemory = 1.0 + 4.0 + ((64 - 16.0) / 8.0);

		-- Set the memory value to the max allowed, if there is enough headroom
		IF (@physicalMemory - @overheadMemory >= 64)
			SELECT @recommendedMemory = 64,
				@overheadMemory = 0,
				@override = 1;
	END;
END;

IF (@override = 0)
	SELECT @recommendedMemory = @physicalMemory - @overheadMemory;

-- Configure NUMA Affinity
IF (@configureNumaNodeAffinity = 1)
BEGIN
	SELECT @recommendedMemory = (@recommendedMemory / @numaNodes) * @numaNodesAfinned;
END;

SELECT @@VERSION AS [Version],
	CASE 
		WHEN (@enterprise = 1)
			THEN 'Enterprise Edition'
		WHEN (@developer = 1)
			THEN 'Developer Edition'
		ELSE 'Non-Enterprise Edition'
		END AS [Edition],
	CAST(@physicalMemorySource AS INT) AS [Physical RAM (MB)],
	--CAST(@physicalMemory AS INT) AS [Physical RAM (GB)],
	c.[value] AS [Configured Value (MB)],
	c.[value_in_use] AS [Running Value (MB)],
	CAST(@recommendedMemory * 1024 AS INT) AS [Recommended Value (MB)],
	N'EXEC sp_configure ''show advanced options'', 1; RECONFIGURE WITH OVERRIDE; EXEC sp_configure ''max server memory (MB)'', '
		+ CAST(CAST(@recommendedMemory * 1024 AS INT) AS NVARCHAR(20))
		+ '; EXEC sp_configure ''show advanced options'', 0; RECONFIGURE WITH OVERRIDE;' AS [Script]
FROM sys.configurations c
WHERE [c].[name] = N'max server memory (MB)'
OPTION (RECOMPILE);
GO