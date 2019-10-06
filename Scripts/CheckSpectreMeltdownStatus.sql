
-- Check Spectre/Meltdown Status for SQL Server
-- Glenn Berry
-- SQLskills.com 
-- Last Modified: January 23, 2018

--******************************************************************************
--*   Copyright (C) 2018 Glenn Berry, SQLskills.com
--*   All rights reserved. 
--*
--*   For more scripts and sample code, check out 
--*      https://www.sqlskills.com/blogs/glenn
--*
--*   You may alter this code for your own *non-commercial* purposes. You may
--*   republish altered code as long as you include this copyright and give due credit. 
--*
--*
--*   THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF 
--*   ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED 
--*   TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
--*   PARTICULAR PURPOSE. 
--*
--******************************************************************************

-- Determine if SQL Server has been patched against Meltdown/Spectre
-- This only checks the SQL Server patch status, not the operating system or hardware
-- This works for SQL Server 2008 through SQL Server 2017

-- You can use a Microsoft-provided PowerShell script to check your 
-- operating system and hardware patch status as decribed in this Microsoft KB 

-- Windows Client Guidance for IT Pros to protect against speculative execution side-channel vulnerabilities
-- https://support.microsoft.com/en-us/help/4073119/protect-against-speculative-execution-side-channel-vulnerabilities-in

SET NOCOUNT ON;

-- Declare variables
DECLARE @MachineIdentification varchar(128) = '';
DECLARE @ProductVersion varchar(20) = '';
DECLARE @ProductBuild int = 0;
DECLARE @PatchStatus varchar(15) = 'not patched';
DECLARE @FinalPatchMessage varchar(256) = '';

SET @MachineIdentification = 'Server Name = ' + CONVERT(varchar(50), SERVERPROPERTY ('MachineName')) + ', Instance Name = ' + ISNULL(CONVERT(varchar(50), SERVERPROPERTY('InstanceName')), 'None') + ': ';


-- Figure out major version number and then get the build number

-- SQL Server 2008
IF EXISTS (SELECT * WHERE CONVERT(varchar(20), SERVERPROPERTY('ProductVersion')) LIKE '10.0%')
	BEGIN
		SET @ProductVersion = CONVERT(varchar(20), SERVERPROPERTY('ProductVersion'));
		IF @ProductVersion = '10.0.6556.0'
			BEGIN
				SET @PatchStatus = 'patched';
			END
		SET @FinalPatchMessage = @MachineIdentification + N'SQL Server 2008, Build Number ' + @ProductVersion + '. This SQL Server instance is ' + @PatchStatus + ' against Spectre/Meltdown.';
		PRINT @FinalPatchMessage;
		SELECT @FinalPatchMessage AS [SQL Server Patch Status];
	END

-- Description of the security update for SQL Server 2008 SP4 GDR: January 6, 2018
-- https://support.microsoft.com/en-us/help/4057114
-- Build 10.0.6556.0


-- SQL Server 2008 R2
IF EXISTS (SELECT * WHERE CONVERT(varchar(20), SERVERPROPERTY('ProductVersion')) LIKE '10.5%')
	BEGIN
		SET @ProductVersion = CONVERT(varchar(20), SERVERPROPERTY('ProductVersion'));
		IF @ProductVersion = '10.50.6560.0'
			BEGIN
				SET @PatchStatus = 'patched';
			END
		SET @FinalPatchMessage = @MachineIdentification + N'SQL Server 2008 R2, Build Number ' + @ProductVersion + '. This SQL Server instance is ' + @PatchStatus + ' against Spectre/Meltdown.';
		PRINT @FinalPatchMessage;
		SELECT @FinalPatchMessage AS [SQL Server Patch Status];	
	END


-- Description of the security update for SQL Server 2008 R2 SP3 GDR: January 6, 2018
-- https://support.microsoft.com/en-us/help/4057113
-- 10.50.6560.0 


-- SQL Server 2012 
-- We have ProductBuild in SQL Server 2012 and newer
IF EXISTS (SELECT * WHERE CONVERT(varchar(20), SERVERPROPERTY('ProductVersion')) LIKE '11%')
	BEGIN
		SET @ProductVersion = CONVERT(varchar(20), SERVERPROPERTY('ProductVersion'));
		SET @ProductBuild = CONVERT(int, SERVERPROPERTY('ProductBuild'));
		IF @ProductBuild >= 7462
			BEGIN
				SET @PatchStatus = 'patched';
			END
		SET @FinalPatchMessage = @MachineIdentification + N'SQL Server 2012, Build Number ' + @ProductVersion + '. This SQL Server instance is ' + @PatchStatus + + ' against Spectre/Meltdown.';
		PRINT @FinalPatchMessage;
		SELECT @FinalPatchMessage AS [SQL Server Patch Status];	
	END

-- Description of the security update for SQL Server 2012 SP4 GDR: January 12, 2018
-- https://support.microsoft.com/en-us/help/4057116
-- Build 11.0.7462.6


-- SQL Server 2014
IF EXISTS (SELECT * WHERE CONVERT(varchar(20), SERVERPROPERTY('ProductVersion')) LIKE '12%')
	BEGIN
		SET @ProductVersion = CONVERT(varchar(20), SERVERPROPERTY('ProductVersion'));
		SET @ProductBuild = CONVERT(int, SERVERPROPERTY('ProductBuild'));
		IF @ProductBuild >= 5571 -- SP2 CU
			BEGIN
				SET @PatchStatus = 'patched';
			END
		IF @ProductBuild = 5214 -- SP2 GDR
			BEGIN
				SET @PatchStatus = 'patched';
			END
		SET @FinalPatchMessage = @MachineIdentification + N'SQL Server 2014, Build Number ' + @ProductVersion + '. This SQL Server instance is ' + @PatchStatus + + ' against Spectre/Meltdown.';
		PRINT @FinalPatchMessage;
		SELECT @FinalPatchMessage AS [SQL Server Patch Status];	
	END

-- Description of the security update for SQL Server 2014 SP2 CU10: January 16, 2018
-- https://support.microsoft.com/en-us/help/4057117
-- Build 12.0.5571.0

-- Description of the security update for SQL Server 2014 SP2 GDR: January 16, 2018
-- https://support.microsoft.com/en-us/help/4057120
-- Build 12.0.5214.6


-- SQL Server 2016
IF EXISTS (SELECT * WHERE CONVERT(varchar(20), SERVERPROPERTY('ProductVersion')) LIKE '13%')
	BEGIN
		SET @ProductVersion = CONVERT(varchar(20), SERVERPROPERTY('ProductVersion'));
		SET @ProductBuild = CONVERT(int, SERVERPROPERTY('ProductBuild'));
		IF @ProductBuild >= 4466 -- SP1 CU7
			BEGIN
				SET @PatchStatus = 'patched';
			END
		IF @ProductBuild = 4210  -- SP1 GDR
			BEGIN
				SET @PatchStatus = 'patched';
			END
		IF @ProductBuild = 2218  -- RTM CU
			BEGIN
				SET @PatchStatus = 'patched';
			END
		IF @ProductBuild = 1745  -- RTM GDR
			BEGIN
				SET @PatchStatus = 'patched';
			END
		SET @FinalPatchMessage = @MachineIdentification + N'SQL Server 2016, Build Number ' + @ProductVersion + '. This SQL Server instance is ' + @PatchStatus + + ' against Spectre/Meltdown.';
		PRINT @FinalPatchMessage;
		SELECT @FinalPatchMessage AS [SQL Server Patch Status];	
	END

-- Description of the security update for SQL Server 2016 CU7 SP1: January 3, 2018
-- https://support.microsoft.com/en-us/help/4058561
-- Build 13.0.4466.4
 
-- Description of the security update for SQL Server 2016 GDR SP1: January 3, 2018 
-- https://support.microsoft.com/en-us/help/4057118
-- Build 13.0.4210.6

-- Description of the security update for SQL Server 2016 CU: January 6, 2018
-- https://support.microsoft.com/en-us/help/4058559
-- Build 13.0.2218.0 

-- Description of the security update for SQL Server 2016 GDR: January 6, 2018
-- https://support.microsoft.com/en-us/help/4058560
-- Build 13.0.1745.2 


-- SQL Server 2017
IF EXISTS (SELECT * WHERE CONVERT(varchar(20), SERVERPROPERTY('ProductVersion')) LIKE '14%')
	BEGIN
		SET @ProductVersion = CONVERT(varchar(20), SERVERPROPERTY('ProductVersion'));
		SET @ProductBuild = CONVERT(int, SERVERPROPERTY('ProductBuild'));
		IF @ProductBuild >= 3015 -- 2017 CU3
			BEGIN
				SET @PatchStatus = 'patched';
			END
		IF @ProductBuild = 2000  -- 2017 GDR
			BEGIN
				SET @PatchStatus = 'patched';
			END
		SET @FinalPatchMessage = @MachineIdentification + N'SQL Server 2017, Build Number ' + @ProductVersion + '. This SQL Server instance is ' + @PatchStatus + + ' against Spectre/Meltdown.';
		PRINT @FinalPatchMessage;
		SELECT @FinalPatchMessage AS [SQL Server Patch Status];
	END

-- Description of the security update for SQL Server 2017 GDR: January 3, 2018
-- https://support.microsoft.com/en-us/help/4057122
-- Build 14.0.2000.63
 
-- Description of the security update for SQL Server 2017 CU3 RTM: January 3, 2018
-- https://support.microsoft.com/en-us/help/4058562
-- Build 14.0.3015.40 


-- SQL Server Guidance to protect against speculative execution side-channel vulnerabilities
-- https://support.microsoft.com/en-us/help/4073225/guidance-for-sql-server 



-- ToDo: Check for clr status, check for R Server, check for linked servers,etc.

---- Get selected instance-level configuration values that relate to SQL Server extensibility features
SELECT name AS [Configuration Name], value as [Value], 
       value_in_use AS [Value In Use], description
FROM sys.configurations
WHERE name IN (N'clr enabled', N'clr strict security', 
               N'external scripts enabled', N'Ole Automation Procedures',
			   N'xp_cmdshell')
ORDER BY name;

-- If clr enabled is 1, then strongly consider setting clr strict security to 1 (on new enough builds of SQL Server 2012, 2014, 2016, and 2017)

-- Update adds the "CLR strict security" feature to SQL Server 2016
-- https://support.microsoft.com/en-us/help/4018930/update-adds-the-clr-strict-security-feature-to-sql-server-2016


------ Check for Polybase and R Services
--SELECT SERVERPROPERTY('IsPolybaseInstalled') AS [IsPolybaseInstalled],				
--SERVERPROPERTY('IsAdvancedAnalyticsInstalled') AS [IsRServicesInstalled];

------ Linked servers
--EXEC sp_linkedservers;


--SELECT j.[name], s.step_name, s.subsystem
--FROM msdb.dbo.sysjobsteps AS s
--INNER JOIN msdb.dbo.sysjobs AS j 
--ON s.job_id = j.job_id
--WHERE s.subsystem = N'ActiveScripting'
--GO
