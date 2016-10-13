<#
.SYNOPSIS
    The SQL_Server_Test_backups script will reach out to a sql server central management server, derive a server list and database backup list.
    Then asynchronously restore them to a test server followed by integrity checks.
.EXAMPLE
    .\SQL_Server_Test_backups.ps1 -cmsname "localhost" -servergroup "Production" -testservername "localhost" -randommultiplier 0.1 -loggingdbname "BackupTest"
    .\SQL_Server_Test_backups.ps1 -cmsname "localhost" -servergroup "Production" -testservername "localhost" -randommultiplier 0.5 -loggingdbname "BackupTest" -recurse
.INPUTS
    [string]$cmsname - the central management server to connect to.
    [string]$servergroup - the root server group to parse.
    [string]$testservername - the test server to restore to.
    [string]$loggingdbname - name of the database on the test server to log results to.
    [decimal]$randommultiplier - decimal multiplier for the number of servers and databases to test at a time. e.g. 0.1=10%, 1=100%.
    [switch]$recurse - switch to determine whether the server group should be recursively searched.
.OUTPUTS
    none.
.NOTES
    Author: Derik Hammer
    Original Link: http://www.sqlshack.com/backup-testing-powershell-part-1-test/
    Created Date: 2014-10-21
#>
[CmdletBinding()]
param
(
    [Parameter(Mandatory=$true)]
    [ValidateNotNullorEmpty()]
    [string]$cmsName,
    [Parameter(Mandatory=$true)]
    [ValidateNotNullorEmpty()]
    [string]$serverGroup,
    [Parameter(Mandatory=$true)]
    [ValidateNotNullorEmpty()]
    [string]$testServerName,
    [Parameter(Mandatory=$true)]
    [ValidateNotNullorEmpty()]
    [string]$loggingDbName,
    [Parameter(Mandatory=$true)]
    [ValidateNotNullorEmpty()]
    [decimal]$randomMultiplier,
    [parameter(Mandatory=$false)]
    [switch]$recurse
)
Import-Module SQLPS -DisableNameChecking 
$ErrorActionPreference = "Continue";
Trap {
    $err = $_.Exception
    while ( $err.InnerException )
    {
    $err = $err.InnerException
    write-output $err.Message
    throw $_.Exception;
    };
    continue
    } 
Function Parse-ServerGroup($serverGroup)
{
    $results = $serverGroup.RegisteredServers;
    foreach($group in $serverGroup.ServerGroups)
    {
        $results += Parse-ServerGroup -serverGroup $group;
    }
    return $results;
}
Function Get-ServerList ([string]$cmsName, [string]$serverGroup, [switch]$recurse)
{
    $connectionString = "data source=$cmsName;initial catalog=master;integrated security=sspi;"
    $sqlConnection = New-Object ("System.Data.SqlClient.SqlConnection") $connectionstring
    $conn = New-Object ("Microsoft.SQLServer.Management.common.serverconnection") $sqlconnection
    $cmsStore = New-Object ("Microsoft.SqlServer.Management.RegisteredServers.RegisteredServersStore") $conn 
    $cmsRootGroup = $cmsStore.ServerGroups["DatabaseEngineServerGroup"].ServerGroups[$serverGroup]
    
    if($recurse)
    {
        return Parse-ServerGroup -serverGroup $cmsRootGroup | select ServerName
    }
    else
    {
        return $cmsRootGroup.RegisteredServers | select ServerName
    }
}
[scriptblock]$restoreDatabaseFunction = 
{
    Function Restore-Database
    {
    <# .synopsis
       restores a full database backup to target server. it will move the database files to the default data and log directories on the target server.
       .example
       restore-database -servername "localhost" -newdbname "testdb" -backupfilepath "D:\Backup\testdb.bak"
       restore-database -servername "localhost" -newdbname "testdb" -backupfilepath "\\KINGFERGUS\Shared\Backup\testdb.bak" -dropdbbeforerestore -conductintegritychecks
       .inputs
       [string]$servername - the server to restore to.
       [string]$newdbname - the database name that you'd like to use for the restore.
       [string]$backupfilepath - local or unc path for the *.bak file (.bak extension is required).
       [string]$origservername - name of the server where the backup originated. used for logging purposes.
       [string]$loggingdbname - name of the logging database.
       [switch]$dropdbbeforerestore - set if you would like the database matching $newdbname to be dropped before restored.
       the intent of this would be to ensure exclusive access to the database can be had during restore.
       [switch]$conductintegritychecks - set if you would like dbcc checktables to be run on the entire database after restore.
       .outputs
       none.
       #>
        [CmdletBinding()]
        param
        (
            [Parameter(Mandatory=$true)]
            [ValidateNotNullorEmpty()]
            [string]$serverName,
            [Parameter(Mandatory=$true)]
            [ValidateNotNullorEmpty()]
            [string]$newDBName,
            [parameter(Mandatory=$true)]
            [ValidateNotNullorEmpty()]
            [string]$backupFilePath,
            [parameter(Mandatory=$true)]
            [ValidateNotNullorEmpty()]
            [string]$origServerName,
            [parameter(Mandatory=$true)]
            [ValidateNotNullorEmpty()]
            [string]$loggingDbName,
            [parameter(Mandatory=$false)]
            [switch]$dropDbBeforeRestore,
            [parameter(Mandatory=$false)]
            [switch]$conductIntegrityChecks
        )
        Import-Module SQLPS -DisableNameChecking 

        ## BEGIN input validation ## 
        $ErrorActionPreference = "Stop";
        Trap {
          $err = $_.Exception
          while ( $err.InnerException )
            {
            $err = $err.InnerException
            write-output $err.Message
            throw $_.Exception;
            };
            continue
          } 
        if($backupFilePath -notlike "*.bak")
        {
            throw "the file extension should be .bak."
        }

        if(!(test-path -Path $backupFilePath))
        {
            throw "Could not find the backup file."
        }
        # Test connection
        $server = New-Object ("Microsoft.SqlServer.Management.Smo.Server") $serverName
        if($server.Version.Major -eq $null)
        {
            throw "Could not establish connection to $serverName."
        }
        ## END input validation ##

        # Create restore object and specify its settings
        $smoRestore = new-object("Microsoft.SqlServer.Management.Smo.Restore")
        $smoRestore.Database = $newDBName
        $smoRestore.NoRecovery = $false;
        $smoRestore.ReplaceDatabase = $true;
        $smoRestore.Action = "Database"

        # Create location to restore from
        $backupDevice = New-Object("Microsoft.SqlServer.Management.Smo.BackupDeviceItem") ($backupFilePath, "File")
        $smoRestore.Devices.Add($backupDevice)

        # Get the file list from backup file
        $dbFileList = $smoRestore.ReadFileList($server)
        # Specify new data file (mdf)
        $smoRestoreDataFile = New-Object("Microsoft.SqlServer.Management.Smo.RelocateFile")
        $defaultData = $server.DefaultFile
        if (($defaultData -eq $null) -or ($defaultData -eq ""))
        {
            $defaultData = $server.MasterDBPath
        }
        $smoRestoreDataFile.PhysicalFileName = "$defaultData$newDBName" + ".mdf";
        $smoRestoreDataFile.LogicalFileName = $dbFileList.Select("FileId = 1").LogicalName
        $smoRestore.RelocateFiles.Add($smoRestoreDataFile) | Out-Null

        # Specify new log file (ldf)
        $smoRestoreLogFile = New-Object("Microsoft.SqlServer.Management.Smo.RelocateFile")
        $defaultLog = $server.DefaultLog
        if (($defaultLog -eq $null) -or ($defaultLog -eq ""))
        {
            $defaultLog = $server.MasterDBLogPath
        }
        $smoRestoreLogFile.PhysicalFileName = "$defaultData$newDBName" + "_Log.ldf";
        $smoRestoreLogFile.LogicalFileName = $dbFileList.Select("FileId = 2").LogicalName
        $smoRestore.RelocateFiles.Add($smoRestoreLogFile) | Out-Null
        # Loop through remaining files to generate relocation file paths.
        $smoRestoreFile = New-Object("Microsoft.SqlServer.Management.Smo.RelocateFile")
        foreach($file in $dbFileList.Select("FileId > 2"))
        {
            $smoRestoreFile = New-Object("Microsoft.SqlServer.Management.Smo.RelocateFile")
            $smoLogicalName = $file.LogicalName;
            $smoRestoreFile.LogicalFileName = $smoLogicalName
            $smoRestoreFile.PhysicalFileName = "$defaultData$smoLogicalName" + ".ndf";
            $smoRestore.RelocateFiles.Add($smoRestoreFile) | Out-Null
        }
             
        # Ensure exclusive access
        if($dropDbBeforeRestore -and $server.Databases[$newDBName] -ne $null)
        {
            $server.KillAllProcesses($newDBName);
            $server.KillDatabase($newDBName);
        }
        #Log restore process - start
        [string]$restoreResultId = [System.Guid]::NewGuid().ToString();
        [string]$sql = "INSERT INTO [dbo].[RestoreResult]
                                ([restoreResultId]
                                ,[originatingServerName]
                                ,[databaseName]
                                ,[backupFilePath])
                            VALUES
                                ('$restoreResultId'
                                ,'$origServerName'
                                ,'$newDBName'
                                ,'$backupFilePath');"
        Invoke-Sqlcmd -ServerInstance $serverName -Database $loggingDbName -Query $sql -QueryTimeout 30;
        # Restore the database
        $errList = @();
        try
        {
            $smoRestore.SqlRestore($server)
        }
        catch
        {
            [System.Exception]
            $err = $_.Exception
            $errList += $err;
            while ( $err.InnerException )
            {
                $err = $err.InnerException
                $errList += $err;
                write-output $err.Message
            };
        }
        #Log restore process - end
        $restoreEndUtc = Get-Date;
        [string]$restoreEnd = $restoreEndUtc.ToUniversalTime();
        [string]$errMsg;
        foreach($msg in $errList)
        {
            $errMsg += $msg + "'r'n";
        }
        $sql = "UPDATE [dbo].[RestoreResult]
                    SET [endDateTime] = '$restoreEnd' ";
        if($errMsg -ne $null)
        {
            $sql += ",[errorMessage] = '$errMsg' ";
        }
        $sql += "WHERE restoreResultId = '$restoreResultId';";
        Invoke-Sqlcmd -ServerInstance $serverName -Database $loggingDbName -Query $sql -QueryTimeout 30;
        if($conductIntegrityChecks)
        {
            #Log integrity checks - start
            [string]$checkDbResultId = [System.Guid]::NewGuid().ToString();
            [string]$sql = "INSERT INTO [dbo].[CheckDbResult]
                                    ([checkDbResultId]
                                    ,[restoreResultId])
                                VALUES
                                    ('$checkDbResultId'
                                    ,'$restoreResultId');"
            Invoke-Sqlcmd -ServerInstance $serverName -Database $loggingDbName -Query $sql -QueryTimeout 30;
            #Integrity checks
            $errList = @();
            try
            {
                $server.Databases[$newDBName].CheckTables("None");
            }
            catch
            {
                [System.Exception]
                $err = $_.Exception
                $errList += $err;
                while ( $err.InnerException )
                {
                    $err = $err.InnerException
                    $errList += $err;
                    write-output $err.Message
                };
            }
            #Log integrity checks - end
            $checkDbEndUtc = Get-Date;
            [string]$checkDbEnd = $restoreEndUtc.ToUniversalTime();
            [string]$errMsg;
            foreach($msg in $errList)
            {
                $errMsg += $msg + "'r'n";
            }
            $sql = "UPDATE [dbo].[CheckDbResult]
                        SET [endDateTime] = '$checkDbEnd' ";
            if($errMsg -ne $null)
            {
                $sql += ",[errorMessage] = '$errMsg' ";
            }
            $sql += "WHERE checkDbResultId = '$checkDbResultId';";
            Invoke-Sqlcmd -ServerInstance $serverName -Database $loggingDbName -Query $sql -QueryTimeout 30;
        }
        # clean up databases
        $server.KillAllProcesses($newDBName);
        $server.KillDatabase($newDBName);

        Write-Host -Object "Restore-Database has completed processing."
    } 
}
if($recurse)
{
    $serverList = Get-ServerList -cmsName $cmsName -serverGroup $serverGroup -recurse
}
else
{
    $serverList = Get-ServerList -cmsName $cmsName -serverGroup $serverGroup
}
$servers = $serverList | Get-Random -Count ([Math]::Ceiling([decimal]$serverList.Count * $randomMultiplier)) 
$jobs = @() 
foreach($svr in $servers)
{
    $server = New-Object ("Microsoft.SqlServer.Management.Smo.Server") $svr.ServerName;
    $databaseList = $server.Databases | Where-Object { $_.IsSystemObject -eq $false };
    $databaseList = $databaseList | Get-Random -Count ([Math]::Ceiling([decimal]$databaseList.Count * $randomMultiplier)) | select Name;
    $backupSetQuery = "SELECT TOP 1 BMF.physical_device_name
                        FROM msdb.dbo.backupmediafamily BMF
                        INNER JOIN msdb.dbo.backupset BS ON BS.media_set_id = BMF.media_set_id
                        WHERE BS.database_name = '`$(databaseName)'
                                AND BS.type = 'D' 
                                AND BS.is_copy_only = 0
                                AND BMF.physical_device_name NOT LIKE '{%'
                        ORDER BY BS.backup_finish_date DESC";
    foreach($database in $databaseList)
    {
        $params = "databaseName = " + $database.Name; 
        $results = @();
        $results += Invoke-Sqlcmd -ServerInstance $server.Name -Query $backupSetQuery -Variable $params -QueryTimeout 30; 
        if($results.Count -eq 0 -or $results -eq $null)
        {
            continue;
        } 
        [string]$backupPath = $results[0].physical_device_name;
        
        # set arguments
        $arguments = @()
        $arguments += $testServerName;
        $arguments += $database.Name;
        $arguments += $backupPath;
        $arguments += $loggingDbName;
        $arguments += $svr.ServerName;
        # start job
        $jobs += Start-job -ScriptBlock {Restore-Database -serverName $args[0] -newDBName $args[1] -backupFilePath $args[2] -loggingDbName $args[3] -origServerName $args[4] –dropDbBeforeRestore -conductIntegrityChecks} `
            -InitializationScript $restoreDatabaseFunction -ArgumentList($arguments) -Name $database.Name;  

    } 
}
$jobs | Wait-Job | Receive-Job
$jobs | Remove-Job