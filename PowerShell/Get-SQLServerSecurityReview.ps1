<#
.SYNOPSIS
 The Script retrives the Security Best Practises for SQL Server and put's all that info in a html document.
.DESCRIPTION
 The Following information collectors can be found in the report.
1. Server Information
2. Database owners
3. Windows Authenticated Logins
4. SQL Authenticated Logins
5. Server Level Permissions
6. Server Role Members
7. Database Level Permissions
8. Database Role Members
9. Job Owners
10. Login Account for SQL Services
11. SQL Server Network Protocols
12. SQL Server TCP Port
13. SQL Server Login Auditing Property Setting
14. SQL Server Global Configuration Parameter (Secrity Affecting One's)
.PARAMETER Computer
Specify the Computer\Machine\Sever Name here to make IO analysis for the Server. One hostname per run.
For Example: Get-SQLSecurityReview -computer ServerName ......
.PARAMETER instance
Specify the SQL instance Name to make IO analysis for the Server. One SQL instance per run.
For Example: Get-SQLSecurityReview ...... -instance ServerName\SQLInstance ......
.PARAMETER report
Specify the location for the output report
For Example: Get-SQLSecurityReview ...... C:\temp\ServerName$SQLInstance-Security_Review.html
.EXAMPLE
Get-SQLSecurityReview -computer ServerName -instance ServerName\SQLInstance -report C:\temp\ServerName$SQLInstance-Security_Review.html
This will generate a html color coded report for localhost with sql instance jupiter
and will dump the report @ location - C:\temp\ServerName$SQLInstance-Security_Review.html
.NOTES
 Author: Sandeep Arora arora@pythian.com sandeep16arora@gmail.com
 Version Info:
 1.1 - 01/15/2016 - Initial Draft
 1.2 - 06/25/2016 - Bug Fixes with SMO Objects for Collecting SQL Server Port Info and Details for Networking Protocols
 Verified on following platforms
    Powershell v2.0 and higher versions
    Microsoft SQL Server 2008 and higher versions
    Windows Server 2008 and higher versions
#>

[CmdletBinding()]
Param(
 [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
 [Alias('hostname')]
 [string]$computer,
 
 [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
 [string]$instance, 
  
 [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
 [string]$report
 )
 
Function Get-SQLServerInfo {
 [CmdletBinding()]
 Param(
 [Parameter(Mandatory=$true)]
 [Alias('instance')]
 [string]$sqlinstance
 )
 BEGIN{
 Try{
 $query = @"
 exec sp_configure 'show advanced options', 1;
 RECONFIGURE with override;
 ------------------------------------------------
 SET NOCOUNT ON
 create table #spconfig(s_name varchar(50), mini bigint, maxi bigint, config_value bigint, run_value bigint)
 insert into #spconfig(s_name, mini, maxi,config_value, run_value) execute sp_configure
 declare @testvaluec as int
 declare @testvaluer as int
 set @testvaluec = (select config_value from #spconfig where s_name like '%xp_cmdshell%' )
 set @testvaluer = (select run_value from #spconfig where s_name like '%xp_cmdshell%' )
 ---------------------------------------------------------------------------------------------------------------
 ---------------------------------------------CONDITION 1
 IF (@testvaluec =0 AND @testvaluer = 0)
 ----------------------------------------------BLOCK A
 BEGIN
 ---------------------------------------------------
 exec sp_configure 'show advanced options', 1;
 RECONFIGURE with override;
 exec sp_configure 'xp_cmdshell', 1;
 RECONFIGURE with override;
 ---------------------------------------------------------------
 declare @rootdir nvarchar(1000)
 exec master.dbo.xp_instance_regread
 N'HKEY_LOCAL_MACHINE',
 N'SOFTWARE\Microsoft\MSSQLServer\Setup',
 N'SQLPath', @rootdir OUTPUT
 IF EXISTS(SELECT 1 FROM [master].[sys].[databases] WHERE [name] = 'zzTempDBForDefaultPath') 
 BEGIN 
 DROP DATABASE zzTempDBForDefaultPath 
 END;
 CREATE DATABASE zzTempDBForDefaultPath;
 DECLARE @Default_Data_Path1 VARCHAR(512), 
 @Default_Log_Path2 VARCHAR(512);
 SELECT @Default_Data_Path1 = 
 ( SELECT LEFT(physical_name,LEN(physical_name)-CHARINDEX('\',REVERSE(physical_name))+1) 
 FROM sys.master_files mf 
 INNER JOIN sys.[databases] d 
 ON mf.[database_id] = d.[database_id] 
 WHERE d.[name] = 'zzTempDBForDefaultPath' AND type = 0);
 SELECT @Default_Log_Path2 = 
 ( SELECT LEFT(physical_name,LEN(physical_name)-CHARINDEX('\',REVERSE(physical_name))+1) 
 FROM sys.master_files mf 
 INNER JOIN sys.[databases] d 
 ON mf.[database_id] = d.[database_id] 
 WHERE d.[name] = 'zzTempDBForDefaultPath' AND type = 1);
 IF EXISTS(SELECT 1 FROM [master].[sys].[databases] WHERE [name] = 'zzTempDBForDefaultPath') 
 BEGIN 
 DROP DATABASE zzTempDBForDefaultPath 
 END
 declare @ErrLogPath1 nvarchar(500)
 exec master.dbo.xp_instance_regread
 N'HKEY_LOCAL_MACHINE',
 N'Software\Microsoft\MSSQLServer\MSSQLServer\Parameters',
 N'SqlArg1', @ErrLogPath1 OUTPUT 
 DECLARE @DBEngineLogin VARCHAR(100)
 EXECUTE master.dbo.xp_instance_regread
 @rootkey = N'HKEY_LOCAL_MACHINE',
 @key = N'SYSTEM\CurrentControlSet\Services\MSSQLServer',
 @value_name = N'ObjectName',
 @value = @DBEngineLogin OUTPUT
 DECLARE @tmpNewValue TABLE (newvalue varchar(500))
 INSERT INTO @tmpNewValue EXEC xp_cmdshell 'systeminfo | findstr /c:"System Manufacturer"'
 DECLARE @localVariable varchar(500)
 SET @localVariable = (SELECT top 1 rtrim(ltrim(newvalue)) FROM @tmpNewValue )
 --case when @localVariable like '%VMware%' OR @localVariable like '%hyper%'Then 'Virtual' else 'Physical' end as 'ServerType'
 select
 Case SERVERPROPERTY('IsClustered') when 1 then 'CLUSTERED' else 'STANDALONE' end as 'ServerType',
 case when @localVariable like '%VMware%' OR @localVariable like '%hyper%'Then 'Virtual' else 'Physical' end as 'ServerType(PhysicalorVirtual)',
 SERVERPROPERTY('MachineName') as 'MachineName',
 (SELECT TOP(1) c.local_net_address
 FROM sys.dm_exec_connections AS c
 WHERE c.local_net_address IS NOT NULL) as IPAddress,'MSSQL' as 'Technology',
 @@servername as 'InstanceName',
 (SELECT top 1 local_tcp_port
 FROM sys.dm_exec_connections 
 WHERE local_tcp_port IS NOT NULL 
 and net_transport = 'TCP' and protocol_type not like 'Database Mirroring' and endpoint_id = 4) as 'port',
 @DBEngineLogin as 'ServiceAccount',
 left(@@VERSION, CHARINDEX(' - ',@@version)-1) as 'Version',
 SERVERPROPERTY ('Edition') as 'Edition',
 SERVERPROPERTY('productversion') 'VersionNumber',
 SERVERPROPERTY ('productlevel') as 'ServicePack',
 (select stuff((SELECT ', '+ cast (ROW_NUMBER() Over(order by dbid) as varchar)+'.'+ UPPER(name)
 FROM sys.sysdatabases FOR XML PATH ('')), 1, 1, '') as 'DB') as 'Databases',
 @Default_Data_Path1 as 'data', @Default_Log_Path2 as 'log',
 (select top 1 filename from sys.sysaltfiles where name like '%tempdev%' and filename like '%.mdf') as 'tempdbdata',
 (select top 1 filename from sys.sysaltfiles where name like '%templog%' and filename like '%.ldf') as 'tempdblog',
 @rootdir as 'root',
 SUBSTRING(substring(@ErrLogPath1, 1, len(@ErrLogPath1) - charindex('\', reverse(@ErrLogPath1))),3,500) as 'ErrorLogPath'
 ---------------------------------------------------------------
 exec sp_configure 'show advanced options', 1;
 RECONFIGURE with override;
 exec sp_configure 'xp_cmdshell', 0;
 RECONFIGURE with override;
 exec sp_configure 'show advanced options', 0;
 Reconfigure with override;
 ----------------------------------------------------------------
 Drop Table #spconfig
 END
 ----------------------------------------------------------------
 ---------------------------------------------CONDITION 2
 ELSE IF (@testvaluec =1 AND @testvaluer = 1)
 ----------------------------------------------------------BLOCK B
 BEGIN
 -------------------------------------------------------------------
 declare @rootdir3 nvarchar(500)
 exec master.dbo.xp_instance_regread
 N'HKEY_LOCAL_MACHINE',
 N'SOFTWARE\Microsoft\MSSQLServer\Setup',
 N'SQLPath', @rootdir3 OUTPUT
  
 IF EXISTS(SELECT 1 FROM [master].[sys].[databases] WHERE [name] = 'zzTempDBForDefaultPath') 
  
 BEGIN 
 DROP DATABASE zzTempDBForDefaultPath 
 END;
  
 CREATE DATABASE zzTempDBForDefaultPath;
  
 DECLARE @Default_Data_Path3 VARCHAR(512), 
 @Default_Log_Path4 VARCHAR(512);
  
 SELECT @Default_Data_Path3 = 
 ( SELECT LEFT(physical_name,LEN(physical_name)-CHARINDEX('\',REVERSE(physical_name))+1) 
 FROM sys.master_files mf 
 INNER JOIN sys.[databases] d 
 ON mf.[database_id] = d.[database_id] 
 WHERE d.[name] = 'zzTempDBForDefaultPath' AND type = 0);
  
 SELECT @Default_Log_Path4 = 
 ( SELECT LEFT(physical_name,LEN(physical_name)-CHARINDEX('\',REVERSE(physical_name))+1) 
 FROM sys.master_files mf 
 INNER JOIN sys.[databases] d 
 ON mf.[database_id] = d.[database_id] 
 WHERE d.[name] = 'zzTempDBForDefaultPath' AND type = 1);
  
 IF EXISTS(SELECT 1 FROM [master].[sys].[databases] WHERE [name] = 'zzTempDBForDefaultPath') 
 BEGIN 
 DROP DATABASE zzTempDBForDefaultPath 
 END
 DECLARE @DBEngineLogin1 VARCHAR(100)
 EXECUTE master.dbo.xp_instance_regread
 @rootkey = N'HKEY_LOCAL_MACHINE',
 @key = N'SYSTEM\CurrentControlSet\Services\MSSQLServer',
 @value_name = N'ObjectName',
 @value = @DBEngineLogin1 OUTPUT
  
 declare @ErrLogPath nvarchar(500)
 exec master.dbo.xp_instance_regread
 N'HKEY_LOCAL_MACHINE',
 N'Software\Microsoft\MSSQLServer\MSSQLServer\Parameters',
 N'SqlArg1', @ErrLogPath OUTPUT
  
 DECLARE @tmpNewValue1 TABLE (newvalue varchar(500))
 INSERT INTO @tmpNewValue1 EXEC xp_cmdshell 'systeminfo | findstr /c:"System Manufacturer"'
 DECLARE @localVariable1 varchar(500)
 SET @localVariable1 = (SELECT top 1 rtrim(ltrim(newvalue)) FROM @tmpNewValue1 )
 --case when @localVariable like '%VMware%' OR @localVariable like '%hyper%'Then 'Virtual' else 'Physical' end as 'ServerType'
 select
 Case SERVERPROPERTY('IsClustered') when 1 then 'CLUSTERED' else 'STANDALONE' end as 'ServerType',
 case when @localVariable like '%VMware%' OR @localVariable like '%hyper%'Then 'Virtual' else 'Physical' end as 'ServerType(PhysicalorVirtual)',
 SERVERPROPERTY('MachineName') as 'MachineName',
 (SELECT TOP(1) c.local_net_address FROM sys.dm_exec_connections AS c
 WHERE c.local_net_address IS NOT NULL) as IPAddress,'MSSQL' as 'Technology',
 @@servername as 'InstanceName',
 (SELECT top 1 local_tcp_port
 FROM sys.dm_exec_connections 
 WHERE local_tcp_port IS NOT NULL 
 and net_transport = 'TCP' and protocol_type not like 'Database Mirroring' and endpoint_id = 4) as 'port',
 @DBEngineLogin1 as 'ServiceAccount',
 left(@@VERSION, CHARINDEX(' - ',@@version)-1) as 'Version',
 SERVERPROPERTY ('Edition') as 'Edition',
 SERVERPROPERTY('productversion') 'VersionNumber',
 SERVERPROPERTY ('productlevel') as 'ServicePack',
 (select stuff((SELECT ', '+ cast (ROW_NUMBER() Over(order by dbid) as varchar)+'.'+ UPPER(name)
 FROM sys.sysdatabases FOR XML PATH ('')), 1, 1, '') as 'DB') as 'Databases',
 @Default_Data_Path3 as 'data', @Default_Log_Path4 as 'log',
 (select top 1 filename from sys.sysaltfiles where name like '%tempdev%' and filename like '%.mdf') as 'tempdbdata',
 (select top 1 filename from sys.sysaltfiles where name like '%templog%' and filename like '%.ldf') as 'tempdblog',
 @rootdir3 as 'root',
 SUBSTRING(substring(@ErrLogPath, 1, len(@ErrLogPath) - charindex('\', reverse(@ErrLogPath))),3,500) as 'ErrorLogPath'
 -------------------------------------------------------------------
 exec sp_configure 'show advanced options', 0;
 Reconfigure with override;
 ---------------------------------------------------------
 drop table #spconfig
 END
 ----------------------------------------------------------
"@
 $ErrorActionPreference = "Stop"
 $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
 $SqlConnection.ConnectionString = "Data Source = $sqlinstance; Initial Catalog = Master; Integrated Security=true; Connection Timeout=300;"
 
 $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
 $SqlCmd.CommandText = $query
 $SqlCmd.CommandTimeout = 0; 
 $SqlCmd.Connection = $SqlConnection
 
 $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
 $SqlAdapter.SelectCommand = $SqlCmd
 
 $DataSet = New-Object System.Data.DataSet
 $SqlAdapter.Fill($DataSet) | Out-Null
 $ErrorActionPreference = "Continue"
 }
 Catch{
 Write-Host "Unable to connect to the SQL Instance [$sqlinstance] in specified time-out period of 300s. Please Check the Instance availability and try again." -ForegroundColor "Red"
 }
 }
 Process{
 return $DataSet.Tables[0] 
 }
 END{
 $SqlConnection.Close()
 }
}
 
Function Get-DBOwners {
 [CmdletBinding()]
 Param(
 [Parameter(Mandatory=$true)]
 [Alias('instance')]
 [string]$sqlinstance
 )
 BEGIN{
 Try{
 $query = @"
 select d.name [Database], d.owner_sid [Owner SID], p.name [Owner], p.type_desc [Owner Type] 
 from sys.databases d left outer join sys.server_principals p on (d.owner_sid = p.sid)
 where d.database_id > 4 order by 1
"@
 $ErrorActionPreference = "Stop"
 $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
 $SqlConnection.ConnectionString = "Data Source = $sqlinstance; Initial Catalog = Master; Integrated Security=true; Connection Timeout=60;"
 
 $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
 $SqlCmd.CommandText = $query
 $SqlCmd.Connection = $SqlConnection
 
 $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
 $SqlAdapter.SelectCommand = $SqlCmd
 
 $DataSet = New-Object System.Data.DataSet
 $SqlAdapter.Fill($DataSet) | Out-Null
 $ErrorActionPreference = "Continue"
 }
 Catch{
 Write-Host "Unable to connect to the SQL Instance [$sqlinstance] in specified time-out period of 60s. Please Check the Instance availability and try again." -ForegroundColor "Red"
 }
 }
 Process{
 return $DataSet.Tables[0] 
 }
 END{
 $SqlConnection.Close()
 }
}
 
Function Get-WindowAuthLogins {
 [CmdletBinding()]
 Param(
 [Parameter(Mandatory=$true)]
 [Alias('instance')]
 [string]$sqlinstance
 )
 BEGIN{
 Try{
 $query = @"
 select name [Login], type_desc [Type], 
 case when is_disabled = 0 then 'N' 
 else 'Y'
 end as [Disabled?],
 create_date [Create Date],
 default_database_name [Default Database] 
 from sys.server_principals
 where type in ('U', 'G')
"@
 $ErrorActionPreference = "Stop"
 $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
 $SqlConnection.ConnectionString = "Data Source = $sqlinstance; Initial Catalog = Master; Integrated Security=true; Connection Timeout=60;"
 
 $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
 $SqlCmd.CommandText = $query
 $SqlCmd.Connection = $SqlConnection
 
 $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
 $SqlAdapter.SelectCommand = $SqlCmd
 
 $DataSet = New-Object System.Data.DataSet
 $SqlAdapter.Fill($DataSet) | Out-Null
 $ErrorActionPreference = "Continue"
 }
 Catch{
 Write-Host "Unable to connect to the SQL Instance [$sqlinstance] in specified time-out period of 60s. Please Check the Instance availability and try again." -ForegroundColor "Red"
 }
 }
 Process{
 return $DataSet.Tables[0] 
 }
 END{
 $SqlConnection.Close()
 }
}
 
Function Get-SQLAuthLogins {
 [CmdletBinding()]
 Param(
 [Parameter(Mandatory=$true)]
 [Alias('instance')]
 [string]$sqlinstance
 )
 BEGIN{
 Try{
 $query = @"
 select name [Login], type_desc [Type], 
 case when is_disabled = 0 then 'N' 
 else 'Y'
 end as [Disabled?],
 create_date [Create Date],
 default_database_name [Default Database], 
 case when is_policy_checked = 0 then 'N'
 else 'Y'
 end as [Enforce Password Policy],
 case when is_expiration_checked = 0 then 'N' 
 else 'Y'
 end as [Enforce Password Expiration]
 from sys.sql_logins
 order by 1
"@
 $ErrorActionPreference = "Stop"
 $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
 $SqlConnection.ConnectionString = "Data Source = $sqlinstance; Initial Catalog = Master; Integrated Security=true; Connection Timeout=30;"
 
 $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
 $SqlCmd.CommandText = $query
 $SqlCmd.Connection = $SqlConnection
 
 $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
 $SqlAdapter.SelectCommand = $SqlCmd
 
 $DataSet = New-Object System.Data.DataSet
 $SqlAdapter.Fill($DataSet) | Out-Null
 $ErrorActionPreference = "Continue"
 }
 Catch{
 Write-Host "Unable to connect to the SQL Instance [$sqlinstance] in specified time-out period of 30s. Please Check the Instance availability and try again." -ForegroundColor "Red"
 }
 }
 Process{
 return $DataSet.Tables[0] 
 }
 END{
 $SqlConnection.Close()
 }
}
 
Function Get-ServerLevelPermissions {
 [CmdletBinding()]
 Param(
 [Parameter(Mandatory=$true)]
 [Alias('instance')]
 [string]$sqlinstance
 )
 BEGIN{
 Try{
 $query = @"
 select pa.name [Grantee Login], pa.type_desc [Type], pb.name [Grantor Login],
 permission_name [Permission], state_desc [State]
 from sys.server_permissions s 
 inner join sys.server_principals pa on (s.grantee_principal_id = pa.principal_id)
 inner join sys.server_principals pb on (s.grantor_principal_id = pb.principal_id)
 where pa.type in ('S', 'U', 'G', 'R')
 order by 1,4
"@
 $ErrorActionPreference = "Stop"
 $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
 $SqlConnection.ConnectionString = "Data Source = $sqlinstance; Initial Catalog = Master; Integrated Security=true; Connection Timeout=30;"
 
 $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
 $SqlCmd.CommandText = $query
 $SqlCmd.Connection = $SqlConnection
 
 $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
 $SqlAdapter.SelectCommand = $SqlCmd
 
 $DataSet = New-Object System.Data.DataSet
 $SqlAdapter.Fill($DataSet) | Out-Null
 $ErrorActionPreference = "Continue"
 }
 Catch{
 Write-Host "Unable to connect to the SQL Instance [$sqlinstance] in specified time-out period of 30s. Please Check the Instance availability and try again." -ForegroundColor "Red"
 }
 }
 Process{
 return $DataSet.Tables[0] 
 }
 END{
 $SqlConnection.Close()
 }
}
 
Function Get-ServerRoleMembers {
 [CmdletBinding()]
 Param(
 [Parameter(Mandatory=$true)]
 [Alias('instance')]
 [string]$sqlinstance
 )
 BEGIN{
 Try{
 $query = @"
 select pa.name [Role], pb.name [Login]
 from sys.server_role_members r
 inner join sys.server_principals pa on (r.role_principal_id = pa.principal_id)
 inner join sys.server_principals pb on (r.member_principal_id = pb.principal_id)
 order by 1,2
"@
 $ErrorActionPreference = "Stop"
 $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
 $SqlConnection.ConnectionString = "Data Source = $sqlinstance; Initial Catalog = Master; Integrated Security=true; Connection Timeout=60;"
 
 $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
 $SqlCmd.CommandText = $query
 $SqlCmd.Connection = $SqlConnection
 
 $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
 $SqlAdapter.SelectCommand = $SqlCmd
 
 $DataSet = New-Object System.Data.DataSet
 $SqlAdapter.Fill($DataSet) | Out-Null
 $ErrorActionPreference = "Continue"
 }
 Catch{
 Write-Host "Unable to connect to the SQL Instance [$sqlinstance] in specified time-out period of 60s. Please Check the Instance availability and try again." -ForegroundColor "Red"
 }
 }
 Process{
 return $DataSet.Tables[0] 
 }
 END{
 $SqlConnection.Close()
 }
}
 
Function Get-DBLevelPermissions {
 [CmdletBinding()]
 Param(
 [Parameter(Mandatory=$true)]
 [Alias('instance')]
 [string]$sqlinstance
 )
 BEGIN{
 Try{
 $query = @"
 if exists (select [id] from tempdb..sysobjects where [id] = OBJECT_ID ('tempdb..#tmpTable')) 
 drop table #tmpTable
 create table #tmpTable ( 
 [Database] sysname NOT NULL, 
 [Grantee Login] sysname NOT NULL, 
 [Type] sysname NOT NULL, 
 [Grantor Login] sysname NOT NULL, 
 [Permission] sysname NOT NULL, 
 [Applies To] sysname NOT NULL, 
 [State] sysname NOT NULL)
 exec sp_msforeachdb 
 'use [?]; 
 insert into #tmpTable
 select distinct db_name() [Database], pa.name [Grantee Login], pa.type_desc [Type], pb.name [Grantor Login],
 permission_name [Permission], class_desc [Applies To], state_desc [State]
 from sys.database_permissions d 
 inner join sys.database_principals pa on (d.grantee_principal_id = pa.principal_id)
 inner join sys.database_principals pb on (d.grantor_principal_id = pb.principal_id)
 where pa.type in (''S'', ''U'', ''G'', ''A'', ''R'')'
 select * from #tmpTable order by 1,2,5,6
 drop table #tmpTable
"@
 $ErrorActionPreference = "Stop"
 $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
 $SqlConnection.ConnectionString = "Data Source = $sqlinstance; Initial Catalog = Master; Integrated Security=true; Connection Timeout=60;"
 
 $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
 $SqlCmd.CommandText = $query
 $SqlCmd.Connection = $SqlConnection
 
 $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
 $SqlAdapter.SelectCommand = $SqlCmd
 
 $DataSet = New-Object System.Data.DataSet
 $SqlAdapter.Fill($DataSet) | Out-Null
 $ErrorActionPreference = "Continue"
 }
 Catch{
 Write-Host "Unable to connect to the SQL Instance [$sqlinstance] in specified time-out period of 60s. Please Check the Instance availability and try again." -ForegroundColor "Red"
 }
 }
 Process{
 return $DataSet.Tables[0] 
 }
 END{
 $SqlConnection.Close()
 }
}
 
Function Get-DBRoleMembers {
 [CmdletBinding()]
 Param(
 [Parameter(Mandatory=$true)]
 [Alias('instance')]
 [string]$sqlinstance
 )
 BEGIN{
 Try{
 $query = @"
 if exists (select [id] from tempdb..sysobjects where [id] = OBJECT_ID ('tempdb..#tmpTable')) 
 drop table #tmpTable
 create table #tmpTable ( 
 [Database] sysname NOT NULL, 
 [Role] sysname NOT NULL, 
 [Login] sysname NOT NULL)
 exec sp_msforeachdb 
 'use [?]; 
 insert into #tmpTable
 select db_name() [Database], pa.name [Role], pb.name [Login]
 from sys.database_role_members r
 inner join sys.database_principals pa on (r.role_principal_id = pa.principal_id)
 inner join sys.database_principals pb on (r.member_principal_id = pb.principal_id)'
 select [Database], Role, Login from #tmpTable 
 order by 1,2,3
 drop table #tmpTable
"@
 $ErrorActionPreference = "Stop"
 $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
 $SqlConnection.ConnectionString = "Data Source = $sqlinstance; Initial Catalog = Master; Integrated Security=true; Connection Timeout=30;"
 
 $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
 $SqlCmd.CommandText = $query
 $SqlCmd.Connection = $SqlConnection
 
 $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
 $SqlAdapter.SelectCommand = $SqlCmd
 
 $DataSet = New-Object System.Data.DataSet
 $SqlAdapter.Fill($DataSet) | Out-Null
 $ErrorActionPreference = "Continue"
 }
 Catch{
 Write-Host "Unable to connect to the SQL Instance [$sqlinstance] in specified time-out period of 30s. Please Check the Instance availability and try again." -ForegroundColor "Red"
 }
 }
 Process{
 return $DataSet.Tables[0] 
 }
 END{
 $SqlConnection.Close()
 }
}
 
Function Get-SQLJobOwner {
 [CmdletBinding()]
 Param(
 [Parameter(Mandatory=$true)]
 [Alias('instance')]
 [string]$sqlinstance
 )
 BEGIN{
 Try{
 $query = @"
 select j.name [Job], p.name [Owner], 
 case 
 when p.type like 'S' then 'SQL Login'
 when p.type like 'U' then 'Windows Login'
 end as 'Login Type'
 from msdb..sysjobs j inner join sys.server_principals p on (j.owner_sid = p.sid)
"@
 $ErrorActionPreference = "Stop"
 $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
 $SqlConnection.ConnectionString = "Data Source = $sqlinstance; Initial Catalog = Master; Integrated Security=true; Connection Timeout=30;"
 
 $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
 $SqlCmd.CommandText = $query
 $SqlCmd.Connection = $SqlConnection
 
 $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
 $SqlAdapter.SelectCommand = $SqlCmd
 
 $DataSet = New-Object System.Data.DataSet
 $SqlAdapter.Fill($DataSet) | Out-Null
 $ErrorActionPreference = "Continue"
 }
 Catch{
 Write-Host "Unable to connect to the SQL Instance [$sqlinstance] in specified time-out period of 30s. Please Check the Instance availability and try again." -ForegroundColor "Red"
 }
 }
 Process{
 return $DataSet.Tables[0] 
 }
 END{
 $SqlConnection.Close()
 }
}
 
Function Get-SQLServiceAccount {
 [CmdletBinding()]
 Param(
 [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
 [Alias('hostname')]
 [string[]]$ComputerName
 )
 BEGIN{}
 PROCESS{
 if (Test-Connection $Computer -Quiet -Count 2) {
 return Get-WmiObject -Class Win32_Service | Select Caption, startname, StartMode, Started | Where-Object {$_.Caption -like '*SQL*'}
 }
 else {
 Write-Host "Could not connect to $Computer." -ForegroundColor "Red"
 }
 }
 END{}
}
 
Function Get-SQLNetworkingProtocols {
 [CmdletBinding()]
 Param(
 [Parameter(Mandatory=$true)]
 [Alias('hostname')]
 [string]$ComputerName
 ,
 [Parameter(Mandatory=$true)]
 [Alias('instance')]
 [string]$sqlinstance
 )
 BEGIN{
 if (Get-Module -ListAvailable | ?{$_.Name -eq 'SQLPS'}){Push-location; Import-Module SQLPS -DisableNameChecking -WarningAction SilentlyContinue; Pop-Location;} else {Add-PSSnapin SQL* -WarningAction SilentlyContinue -ErrorAction SilentlyContinue;}
 try {add-type -AssemblyName "Microsoft.SqlServer.SqlWmiManagement, Version=10.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" -EA Stop}
 catch {add-type -AssemblyName "Microsoft.SqlServer.SqlWmiManagement"}
 $wmi = new-object "Microsoft.SqlServer.Management.Smo.Wmi.ManagedComputer"
 if ($sqlinstance -like '*\*') {$sqlinstance = $sqlinstance.Split("\")[1].Split(' ')} else {$sqlinstance = 'MSSQLSERVER'}
 $ComputerName = $ComputerName.ToUpper();
 try{
 $uri = "ManagedComputer[@Name='" + $ComputerName + "']/ ServerInstance[@Name='" + $sqlinstance + "']/ServerProtocol[@Name='Tcp']"
 $Tcp = $wmi.GetSmoObject($uri)
 $uri = "ManagedComputer[@Name='" + $ComputerName + "']/ ServerInstance[@Name='" + $sqlinstance + "']/ServerProtocol[@Name='np']"
 $np = $wmi.GetSmoObject($uri)
 $uri = "ManagedComputer[@Name='" + $ComputerName + "']/ ServerInstance[@Name='" + $sqlinstance + "']/ServerProtocol[@Name='sm']"
 $sm = $wmi.GetSmoObject($uri)
 try{
 $uri = "ManagedComputer[@Name='" + $ComputerName + "']/ ServerInstance[@Name='" + $sqlinstance + "']/ServerProtocol[@Name='via']"
 $via = $wmi.GetSmoObject($uri)
 }
 catch{
 Write-Host "VIA Protocol is discontinued"
 }
 }
 catch{
 Write-Host "Unable to connect to the SQL Instance [$sqlinstance] in specified time-out period of 30s. Please Check the Instance availability and try again." -ForegroundColor "Red"
 }
 }
 PROCESS{
 $sm | select @{n="Protocol Name";e={if($_.Name -like 'sm'){"Shared Memory"}}}, IsEnabled
 $np | select @{n="Protocol Name";e={if($_.Name -like 'np'){"Named Pipes"}}}, IsEnabled
 $Tcp | select @{n="Protocol Name";e={if($_.Name -like 'Tcp'){"TCP\IP"}}}, IsEnabled
 $via | select @{n="Protocol Name";e={if($_.Name -like 'via'){"Via"}}}, IsEnabled
 }
 END{}
}
 
Function Get-SQLTCPPort {
 [CmdletBinding()]
 Param(
 [string]$ComputerName,
 [string]$sqlinstance
 )
 BEGIN{
 if (Get-Module -ListAvailable | ?{$_.Name -eq 'SQLPS'}){Push-location; Import-Module SQLPS -DisableNameChecking -WarningAction SilentlyContinue; Pop-location;} else {Add-PSSnapin SQL* -WarningAction SilentlyContinue -ErrorAction SilentlyContinue;}
 try {add-type -AssemblyName "Microsoft.SqlServer.SqlWmiManagement, Version=10.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" -EA Stop}
 catch {add-type -AssemblyName "Microsoft.SqlServer.SqlWmiManagement"}
 $wmi = new-object "Microsoft.SqlServer.Management.Smo.Wmi.ManagedComputer"
 if ($sqlinstance -like '*\*') {$sqlinstance = $sqlinstance.Split("\")[1].Split(' ')} else {$sqlinstance = 'MSSQLSERVER'}
 Try {
 $ComputerName = $ComputerName.ToUpper();
 $uri = "ManagedComputer[@Name='$ComputerName']/ ServerInstance[@Name='$sqlinstance']/ServerProtocol[@Name='Tcp']"
 $Tcp = $wmi.GetSmoObject($uri);
 }
 Catch{
 Write-Host "Unable to connect to the SQL Instance [$sqlinstance] in specified time-out period of 30s. Please Check the Instance availability and try again." -ForegroundColor "Red"
 }
 }
 PROCESS{
 return $wmi.GetSmoObject($uri + "/IPAddress[@Name='IPAll']").IPAddressProperties;
 }
 END{}
}
 
Function Get-LoginAuditing {
 [CmdletBinding()]
 Param(
 [Parameter(Mandatory=$true)]
 [Alias('instance')]
 [string]$sqlinstance
 )
 BEGIN{
 Try{
 $query = @"
 declare @AuditLevel int
 exec master..xp_instance_regread 
 @rootkey='HKEY_LOCAL_MACHINE',
 @key='SOFTWARE\Microsoft\MSSQLServer\MSSQLServer',
 @value_name='AuditLevel',
 @value=@AuditLevel output
 select case 
 when @AuditLevel = 0 then 'None'
 when @AuditLevel = 1 then 'Successful Logins Only'
 when @AuditLevel = 2 then 'Failed Logins Only'
 when @AuditLevel = 3 then 'Successful Logins'
 end as 'LoginAuditing'
"@
 $ErrorActionPreference = "Stop"
 $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
 $SqlConnection.ConnectionString = "Data Source = $sqlinstance; Initial Catalog = Master; Integrated Security=true; Connection Timeout=30;"
 
 $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
 $SqlCmd.CommandText = $query
 $SqlCmd.Connection = $SqlConnection
 
 $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
 $SqlAdapter.SelectCommand = $SqlCmd
 
 $DataSet = New-Object System.Data.DataSet
 $SqlAdapter.Fill($DataSet) | Out-Null
 $ErrorActionPreference = "Continue"
 }
 Catch{
 Write-Host "Unable to connect to the SQL Instance [$sqlinstance] in specified time-out period of 30s. Please Check the Instance availability and try again." -ForegroundColor "Red"
 }
 }
 Process{
 return $DataSet.Tables[0] 
 }
 END{
 $SqlConnection.Close()
 }
}
 
Function Get-SQLGlobalSettings {
 [CmdletBinding()]
 Param(
 [Parameter(Mandatory=$true)]
 [Alias('instance')]
 [string]$sqlinstance
 )
 BEGIN{
 Try{
 $query = @"
 exec sp_configure 'show advanced options', 1;
 RECONFIGURE with override;
 SET NOCOUNT ON
 create table #spconfig(s_name varchar(50), mini bigint, maxi bigint, config_value bigint, run_value bigint)
 insert into #spconfig(s_name, mini, maxi,config_value, run_value) execute sp_configure
 select s_name, 
 case when run_value = 1 then 'Enabled'
 when run_value = 0 then 'Disbaled'
 End as 'CurrentSetting'
 from #spconfig where s_name in ('xp_cmdshell','SMO and DMO XPs','remote access','default trace enabled')
 drop table #spconfig
 exec sp_configure 'show advanced options', 0;
 RECONFIGURE with override;
"@
 $ErrorActionPreference = "Stop"
 $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
 $SqlConnection.ConnectionString = "Data Source = $sqlinstance; Initial Catalog = Master; Integrated Security=true; Connection Timeout=30;"
 
 $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
 $SqlCmd.CommandText = $query
 $SqlCmd.Connection = $SqlConnection
 
 $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
 $SqlAdapter.SelectCommand = $SqlCmd
 
 $DataSet = New-Object System.Data.DataSet
 $SqlAdapter.Fill($DataSet) | Out-Null
 $ErrorActionPreference = "Continue"
 }
 Catch{
 Write-Host "Unable to connect to the SQL Instance [$sqlinstance] in specified time-out period of 30s. Please Check the Instance availability and try again." -ForegroundColor "Red"
 }
 }
 Process{
 return $DataSet.Tables[0] 
 }
 END{
 $SqlConnection.Close()
 }
}
 
Write-Host "[$(Get-date -DisplayHint date -Format g)]Script Execution Started ....`r`n"
Write-Host "Collecting SQL Server Instance details ....`r`n"
$serverinfo = Get-SQLServerInfo -sqlinstance "$instance"
Write-Host "Checking Database Owners ....`r`n"
$dbowners = Get-DBOwners -sqlinstance "$instance"
Write-Host "Collecting details for Logins using Windows Authentication ....`r`n"
$winauth = Get-WindowAuthLogins -sqlinstance "$instance"
Write-Host "Collecting details for Logins using SQL Server Authentication ....`r`n"
$sqlauth = Get-SQLAuthLogins -sqlinstance "$instance"
Write-Host "Collecting Server Level Permissions ....`r`n"
$serlvlperm = Get-ServerLevelPermissions -sqlinstance "$instance"
Write-Host "Collecting Server Roles assigned to Logins ....`r`n"
$serrolmem = Get-ServerRoleMembers -sqlinstance "$instance"
Write-Host "Collecting Database Level Permissions ....`r`n"
$dblvlperm = Get-DBLevelPermissions -sqlinstance "$instance"
Write-Host "Collecting Database Roles Assigned to Logins ....`r`n"
$dbrolmem = Get-DBRoleMembers -sqlinstance "$instance"
Write-Host "Collecting Job Owner Details ....`r`n"
$jobowners = Get-SQLJobOwner -sqlinstance "$instance"
Write-Host "Checking SQL Server Services Logon Accounts ....`r`n"
$servaccount = Get-SQLServiceAccount -ComputerName "$computer"
Write-Host "Collecting Enabled Networking Protocols for SQL Server ...."
$sqlprotocols = Get-SQLNetworkingProtocols -computer "$computer" -sqlinstance "$instance"
Write-Host "`r`nCollecting SQL Server Port Details ....`r`n"
$tcpports = Get-SQLTCPPort -computer "$computer" -sqlinstance "$instance"
Write-Host "Checking if Login Auditing is Enabled ....`r`n"
$loginaudit = Get-LoginAuditing -sqlinstance "$instance"
Write-Host "Evaluating Configuration Parameters for Security Risks ....`r`n"
$config = Get-SQLGlobalSettings -sqlinstance "$instance"
Write-Host "[$(Get-date -DisplayHint date -Format g)]Finished Script Execution. Formatting Report ....`r`n"
 
#Final Reporting 
$css = @"
<style>
body { 
 background-color:white;
 font-family: "Times New Roman", Times, serif;
 font-size:11pt;
 color:#333;
 } 
.header {
 font-size: 40px;
 color: white;
 text-align: center;
 background: black;
 font-family: "Times New Roman", Times, serif;
 font-weight: bold;
 width: 100%;
 border: 1px black;
 margin: 0;}
h1 {font-size:40px;color: black;}
h2 {font-size:30px;color: black;}
h4 {font-size:15px;color: black;}
p {font-size:30px;color: black;}
table {margin-left:50px; table-layout: fixed;}
td {word-wrap:break-word;}
td , th { 
 border:2px solid black;
 border-collapse:collapse;
 word-wrap:break-word;
 }
th {
 font-family: "Times New Roman", Times, serif;
 font-size:14pt; color:white; 
 background-color:black;
 font-weight:bold;
 }
table, tr, td, th {padding: 2px; margin: 1px;}
</style>
"@
 
 
if($serverinfo){
 $serverinfo = $serverinfo | select ServerType, "ServerType(PhysicalorVirtual)", MachineName, Technology, InstanceName, ServiceAccount, @{n="Version";e={if($_.Version -like '*2005*'){'<td bgcolor="#FF0000">'+$_.Version} elseif($_.Version -like '*2000*'){'<td bgcolor="#FF0000">'+$_.Version} elseif($_.Version -like '*2008*'){'<td bgcolor="#FFFF00">'+$_.Version} else{'<td bgcolor="#00CC33">'+$_.Version}}}, @{n="Edition";e={if($_.Edition -like '*32*bit'){'<td bgcolor="#FF0000">'+$_.Edition} elseif($_.Edition -notlike '*Enterprise*'){'<td bgcolor="#FFFF00">'+$_."Edition"} else{'<td bgcolor="#00CC33">'+$_."Edition"}}}, Databases, @{n="Default DataFile Location";e={if($_.data -like "$log*"){'<td bgcolor="#FF0000">'+$_.data}else{'<td bgcolor="#00CC33">'+$_.data} }}, @{n="Default LogFile Path";e={if($_.log -like "$data*"){'<td bgcolor="#FF0000">'+$_.log}else{'<td bgcolor="#00CC33">'+$_.log}}}, @{n="TempDB Datafile Path";e={if($_.tempdbdata -like '$data*' -or $_.tempdbdata -like '$log*' ){'<td bgcolor="#FF0000">'+$_.tempdbdata}else{'<td bgcolor="#00CC33">'+$_.tempdbdata}}}, @{n="TempDB Logfile Path";e={if($_.tempdblog -like '$log*' -or $_.tempdblog -like '$data*'){'<td bgcolor="#FF0000">'+$_.tempdblog}else{'<td bgcolor="#00CC33">'+$_.tempdblog}}}, @{n="Root Path";e={$_.root}}, ErrorLogPath
 $htmlreport = $serverinfo | ConvertTo-HTML -PreContent "<h2><center>SQL Server Information</center></h2><br><br>" -Fragment | out-string
}
else{
 $htmlreport = ConvertTo-HTML -PreContent "<h2><center>SQL Server Information</center></h2><br>" -PostContent "<h4><center>Error Encountered in reporting the details. Check the log for details. If nothing is reported in the log then no details exist for this collector.</center></h4><br>" -Fragment | out-string
}
if($dbowners){
 $dbowners = $dbowners | select Database , Owner, @{n="Owner Type";e={if($_."Owner Type" -like '*SQL*') {'<td bgcolor="#00CC33">'+$_."Owner Type"} else {'<td bgcolor="#FF0000">'+$_."Owner Type"} }}
 $htmlreport += $dbowners | ConvertTo-HTML -PreContent "<h2><center>Database Owners</center></h2><br><br>" -Fragment | out-string
}
else{
 $htmlreport += ConvertTo-HTML -PreContent "<h2><center>Database Ownners</center></h2><br>" -PostContent "<h4><center>Error Encountered in reporting the details. Check the script log for details. If nothing is reported in the log then no details exist for this collector.</center></h4><br>" -Fragment | out-string
}
if($winauth){
 $winauth = $winauth | select Login, Type, @{n="Disabled?";e={if($_.Login -like 'NT *' -and $_."Disabled?" -like 'N') {'<td bgcolor="#FF0000">'+$_."Disabled?"} elseif($_."Disabled?" -like 'Y'){'<td bgcolor="#FF0000">'+$_."Disabled?"} else {'<td bgcolor="#00CC33">'+$_."Disabled?"}}}, "Create Date", @{n="Default Database";e={if($_."Default Database" -like 'master'){'<td bgcolor="#00CC33">'+$_."Default Database"}else{'<td bgcolor="#FF0000">'+$_."Default Database"}}}
 $htmlreport += $winauth | ConvertTo-HTML -PreContent "<h2><center>Windows Authentication Logins</center></h2><br><br>" -Fragment | out-string
}
else{
 $htmlreport += ConvertTo-HTML -PreContent "<h2><center>Windows Authentication Logins</center></h2><br>" -PostContent "<h4><center>Error Encountered in reporting the details. Check the script log for details. If nothing is reported in the log then no details exist for this collector.</center></h4><br>" -Fragment | out-string
}
if($sqlauth){
 $sqlauth = $sqlauth | select Login, Type, @{n="Disabled?";e={if($_.Login -like '##*' -and $_."Disabled?" -like 'Y') {'<td bgcolor="#00CC33">'+$_."Disabled?"} elseif($_.Login -like '##*' -and $_."Disabled?" -like 'N') {'<td bgcolor="#FF0000">'+$_."Disabled?"} elseif($_."Disabled?" -like 'Y'){'<td bgcolor="#FF0000">'+$_."Disabled?"} else {'<td bgcolor="#00CC33">'+$_."Disabled?"}}} ,"Create Date", "Default Database", "Enforce Password Policy" , "Enforce Password Expiration"
 $htmlreport += $sqlauth | ConvertTo-HTML -PreContent "<h2><center>SQL Server Authentication Logins</center></h2><br><br>" -Fragment | out-string
}
else{
 $htmlreport += ConvertTo-HTML -PreContent "<h2><center>SQL Server Authentication Logins</center></h2><br>" -PostContent "<h4><center>Error Encountered in reporting the details. Check the script log for details. If nothing is reported in the log then no details exist for this collector.</center></h4><br>" -Fragment | out-string
}
if($serlvlperm){
 $serlvlperm = $serlvlperm | select "Grantee Login", Type, "Grantor Login", Permission, State
 $htmlreport += $serlvlperm | ConvertTo-HTML -PreContent "<h2><center>Server Level Permissions</center></h2><br><br>" -Fragment | out-string
}
else{
 $htmlreport += ConvertTo-HTML -PreContent "<h2><center>Server Level Permissions</center></h2><br>" -PostContent "<h4><center>Error Encountered in reporting the details. Check the script log for details. If nothing is reported in the log then no details exist for this collector.</center></h4><br>" -Fragment | out-string
}
if($serrolmem){
 $serrolmem = $serrolmem | select Login, @{n="Role";e={if($_."Role" -like 'sysadmin'){'<td bgcolor="#FFFF00">'+$_."Role"}else{$_."Role"}}}
 $htmlreport += $serrolmem | ConvertTo-HTML -PreContent "<h2><center>Server Role Members</center></h2><br><br>" -Fragment | out-string
}
else{
 $htmlreport += ConvertTo-HTML -PreContent "<h2><center>Server Role Memebers</center></h2><br>" -PostContent "<h4><center>Error Encountered in reporting the details. Check the script log for details. If nothing is reported in the log then no details exist for this collector.</center></h4><br>" -Fragment | out-string
}
if($dblvlperm){
 $dblvlperm = $dblvlperm | select Database, "Grantee Login", Type, "Grantor Login", Permission, "Applies To", State
 $htmlreport += $dblvlperm | ConvertTo-HTML -PreContent "<h2><center>Database Level Permissions</center></h2><br><br>" -Fragment | out-string
}
else{
 $htmlreport += ConvertTo-HTML -PreContent "<h2><center>Database Level Permissions</center></h2><br>" -PostContent "<h4><center>Error Encountered in reporting the details. Check the script log for details. If nothing is reported in the log then no details exist for this collector.</center></h4><br>" -Fragment | out-string
}
if($dbrolmem){
 $dbrolmem = $dbrolmem | select Database, Login,@{n="Role";e={if($_."Role" -like 'db_owner'){'<td bgcolor="#FFFF00">'+$_."Role"}else{$_."Role"}}}
 $htmlreport += $dbrolmem | ConvertTo-HTML -PreContent "<h2><center>Database Role Members</center></h2><br><br>" -Fragment | out-string
}
else{
 $htmlreport += ConvertTo-HTML -PreContent "<h2><center>Database Role Members</center></h2><br>" -PostContent "<h4><center>Error Encountered in reporting the details. Check the script log for details. If nothing is reported in the log then no details exist for this collector.</center></h4><br>" -Fragment | out-string
} 
if($jobowners){
 $jobowners = $jobowners | select Job, @{n="Owner";e={if($_.Owner -like 'sa' ){'<td bgcolor="#00CC33">'+$_.Owner} else{'<td bgcolor="#FF0000">'+$_.Owner} }}, "Login Type"
 $htmlreport += $jobowners | ConvertTo-HTML -PreContent "<h2><center>SQL Server Job Owners</center></h2><br><br>" -Fragment | out-string
}
else{
 $htmlreport += ConvertTo-HTML -PreContent "<h2><center>SQL Server Job Owners</center></h2><br>" -PostContent "<h4><center>Error Encountered in reporting the details. Check the script log for details. If nothing is reported in the log then no details exist for this collector.</center></h4><br>" -Fragment | out-string
}
if($servaccount){
 $servaccount = $servaccount | select @{n="Service Name";e={$_.caption}}, @{n="Service Account";e={if($_.startname -like 'Local*' -or $_.startname -like 'NT*'){'<td bgcolor="#FF0000">'+$_.startname}else{'<td bgcolor="#00CC33">'+$_.startname}}}, StartMode
 $htmlreport += $servaccount | ConvertTo-HTML -PreContent "<h2><center>Login Account for SQL Services</center></h2><br><br>" -Fragment | out-string
}
else{
 $htmlreport += ConvertTo-HTML -PreContent "<h2><center>Login Account for SQL Services</center></h2><br>" -PostContent "<h4><center>Error Encountered in reporting the details. Check the script log for details. If nothing is reported in the log then no details exist for this collector.</center></h4><br>" -Fragment | out-string
}
if($sqlprotocols){
 $sqlprotocols = $sqlprotocols | select "Protocol Name", @{n="IsEnabled?";e={if($_."Protocol Name" -like 'Named*' -or $_."Protocol Name" -like 'VIA' ){if($_.IsEnabled -like 'True'){'<td bgcolor="#FF0000">'+$_.IsEnabled} else{'<td bgcolor="#00CC33">'+$_.IsEnabled}} else{'<td bgcolor="#00CC33">'+$_.IsEnabled}}}
 $htmlreport += $sqlprotocols | ConvertTo-HTML -PreContent "<h2><center>SQL Server Network Protocols</center></h2><br><br>" -Fragment | out-string
}
else{
 $htmlreport += ConvertTo-HTML -PreContent "<h2><center>SQL Server Network Protocols</center></h2><br>" -PostContent "<h4><center>Error Encountered in reporting the details. Check the script log for details. If nothing is reported in the log then no details exist for this collector.</center></h4><br>" -Fragment | out-string
}
if($tcpports){
 $statictcpports = @{}
 $dynamictcpports = @{}
 $statictcpports = $tcpports | Where-Object {$_.Name -like 'TcpPort'} | Select Value
 $dynamictcpports = $tcpports | Where-Object {$_.Name -like 'TcpDynamicPorts'} | Select Value
 $dport = $($dynamicportvalue).Value
 $sport = $($statictcpports).Value
 if ($sport) {
 $htmlreport += ConvertTo-HTML -PreContent "<h2><center>SQL TCP Port Settings</center></h2><br><br>" -PostContent "<p><mark>SQL Server Instance [$instance] is set to use Static Port # : $sport.</mark></p><br>" -Fragment | out-string
 }
 else {
 $htmlreport += ConvertTo-HTML -PreContent "<h2><center>SQL TCP Port Settings</center></h2><br><br>" -PostContent "<p><mark>SQL Server Instance [$instance] is set to use Dynamic # : $dport.</mark><p><br>" -Fragment | out-string
 }
}
else{
 $htmlreport += ConvertTo-HTML -PreContent "<h2><center>SQL TCP Port Settings</center></h2><br>" -PostContent "<h4><center>Error Encountered in reporting the details. Check the script log for details. If nothing is reported in the log then no details exist for this collector.</center></h4><br>" -Fragment | out-string
}
if($loginaudit){
 $loginaudit = $loginaudit | select @{n="Login Auditing";e={$_.LoginAuditing}}, @{n="Recommended Setting";e={if($_.LoginAuditing -like 'Failed Logins Only'){'<td bgcolor="#00CC33">'+"Y"}else{'<td bgcolor="#FF0000">'+"N"}}}
 $htmlreport += $loginaudit | ConvertTo-HTML -PreContent "<h2><center>SQL Server Login Auditing</center></h2><br><br>" -Fragment | out-string
}
else{
 $htmlreport += ConvertTo-HTML -PreContent "<h2><center>SQL Server Login Auditing</center></h2><br>" -PostContent "<h4><center>Error Encountered in reporting the details. Check the script log for details. If nothing is reported in the log then no details exist for this collector.</center></h4><br>" -Fragment | out-string
}
if($config){
 $config = $config | select @{n="Configuration Parameter";e={$_.s_name}}, @{n="IsEnabled?";e={if($_.CurrentSetting -like 'Enabled'){'<td bgcolor="#FF0000">'+$_.CurrentSetting}else{'<td bgcolor="#00CC33">'+$_.CurrentSetting} }}
 $htmlreport += $config | ConvertTo-HTML -PreContent "<h2><center>SQL Sever Global Configuration Parameters</center></h2><br><br>" -Fragment | out-string
}
else{
 $htmlreport += ConvertTo-HTML -PreContent "<h2><center>SQL Sever Global Configuration Parameters</center></h2><br>" -PostContent "<h4><center>Error Encountered in reporting the details. Check the script log for details. If nothing is reported in the log then no details exist for this collector.</center></h4><br>" -Fragment | out-string
}
 
$htmlreport = $htmlreport.Replace('<td>&lt;td bgcolor=&quot;#FFFF00&quot;&gt;','<td bgcolor="#FFFF00">')
$htmlreport = $htmlreport.Replace('<td>&lt;td bgcolor=&quot;#FF0000&quot;&gt;','<td bgcolor="#FF0000">')
$htmlreport = $htmlreport.Replace('<td>&lt;td bgcolor=&quot;#00CC33&quot;&gt;','<td bgcolor="#00CC33">')
 
$body = convertto-html -Head $css -PostContent "$htmlreport <br/><br/><h1 class = `"header`">END OF REPORT</h1>" -body "<h1 class = `"header`">SQL SERVER SECURITY REVIEW</h1><center><h4>Report Generated on $(Get-date -DisplayHint date -Format g)</h4></center>" -Title "SQL SERVER SECURITY REVIEW" | out-string
$body = $body.Replace("<table>`r`n</table>","")
$body | Out-File "$report"
  
