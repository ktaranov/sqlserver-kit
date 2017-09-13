<#
.SYNOPSIS
    Load Extended Events via Powershell.
.PARAMETR
    fileWithPath <String>
.PARAMETR
    serverName <String>
.PARAMETR
    fileName <String>
.EXAMPLE
    Shred-XElogs -fileWithPath $XEFilePath -serverName $server -fileName $XEFile
.NOTES
    Author: Aakash Patel
    Created date: 2017-08-22
    Original Link: http://www.sqlservercentral.com/articles/PowerShell/160582

#>

  Function Shred-XElogs{
  param(
  [Parameter(Position=0, Mandatory=$true)] [string] $fileWithPath,
  [Parameter(Position=1, Mandatory=$true)] [string] $serverName,
  [Parameter(Position=2, Mandatory=$true)] [string] $fileName
  )
  Try
  {
  #Load the required assemblies
  $dllpath = "C:\Program Files\Microsoft SQL Server\110\Shared\Microsoft.SqlServer.XEvent.Linq.dll"
  if(([appdomain]::currentdomain.getassemblies() | Where {$_.Location -match "Microsoft.SqlServer.XEvent.Linq.dll"}) -eq $null)
       {
         Write-Host "Assembly not found. Loading it from $dllpath" `r`n
         [System.Reflection.Assembly]::LoadFrom($dllpath)
       }
  else
       {
        write-host "Assembly is already loaded." `r`n
       }
  [System.Reflection.Assembly]::LoadFrom($dllpath)
  #create data table
  $dt = New-Object System.Data.Datatable
  #Define Columns
  $server_name = New-Object system.Data.DataColumn 'server_name',([string])
  $xe_load_date = New-Object system.Data.DataColumn 'xe_load_date',([DateTime])
  $start_date = New-Object system.Data.DataColumn 'start_date',([DateTime])
  $end_time = New-Object system.Data.DataColumn 'end_time',([datetime])
  $text_data = New-Object system.Data.DataColumn 'text_data',([string])
  $duration = New-Object system.Data.DataColumn 'duration',([int64])
  $logicalreads = New-Object system.Data.DataColumn 'logicalreads',([int64])
  $physicalreads = New-Object system.Data.DataColumn 'physicalreads',([int])
  $EndResult = New-Object system.Data.DataColumn 'EndResult',([int])
  $RowCount = New-Object system.Data.DataColumn 'RowCount',([int])
  $ObjectName = New-Object system.Data.DataColumn 'ObjectName',([string])
  $writes = New-Object system.Data.DataColumn 'writes',([int])
  $CPU = New-Object system.Data.DataColumn 'CPU',([int64])
  $event_name = New-Object system.Data.DataColumn 'event_name',([string])
  $database_id = New-Object system.Data.DataColumn 'database_id',([int])
  $hostname = New-Object system.Data.DataColumn 'hostname',([string])
  $application_name = New-Object system.Data.DataColumn 'application_name',([string])
  $login_name = New-Object system.Data.DataColumn 'login_name',([string])
  $hostname = New-Object system.Data.DataColumn 'hostname',([string])
  $spid = New-Object system.Data.DataColumn 'spid',([int])
  $xe_log_file = New-Object system.Data.DataColumn 'xe_log_file',([string])
  # create columns
  [void]$dt.Columns.Add($server_name)
  [void]$dt.Columns.Add($xe_load_date)
  [void]$dt.Columns.Add($start_date)
  [void]$dt.Columns.Add($end_time)
  [void]$dt.Columns.Add($text_data)
  [void]$dt.Columns.Add($duration)
  [void]$dt.Columns.Add($logicalreads)
  [void]$dt.Columns.Add($physicalreads)
  [void]$dt.Columns.Add($EndResult)
  [void]$dt.Columns.Add($RowCount)
  [void]$dt.Columns.Add($ObjectName)
  [void]$dt.Columns.Add($writes)
  [void]$dt.Columns.Add($CPU)
  [void]$dt.Columns.Add($event_name)
  [void]$dt.Columns.Add($database_id)
  [void]$dt.Columns.Add($hostname)
  [void]$dt.Columns.Add($application_name)b
  [void]$dt.Columns.Add($login_name)
  [void]$dt.Columns.Add($spid)
  [void]$dt.Columns.Add($xe_log_file)
  $events = New-Object Microsoft.SqlServer.XEvent.Linq.QueryableXEventData($fileWithPath)
  $events | % {
      $currentEvent = $_
  $row = $dt.NewRow()
  $audittime = Get-Date
  $row.server_name = $serverName
  $row.xe_load_date = [DateTime] $audittime
  $row.end_time = $currentEvent.Timestamp.LocalDateTime
  $row.duration = $currentEvent.Fields["duration"].Value
  $row.logicalreads = $currentEvent.Fields["logical_reads"].Value
  $row.physicalreads = $currentEvent.Fields["physical_reads"].Value
  $row.EndResult = $currentEvent.Fields["result"].Value.Key
  $row.RowCount = $currentEvent.Fields["row_count"].Value
  $row.ObjectName = $currentEvent.Fields["object_name"].Value
  $row.writes = $currentEvent.Fields["writes"].Value
  $row.CPU = $currentEvent.Fields["cpu_time"].Value
  $row.event_name = $currentEvent.name
  $row.database_id = $currentEvent.Actions["database_id"].Value
  $row.hostname = $currentEvent.Actions["client_hostname"].Value
  $row.application_name = $currentEvent.Actions["client_app_name"].Value
  $row.login_name = $currentEvent.Actions["server_principal_name"].Value
  $row.spid = $currentEvent.Actions["session_id"].Value
  $row.xe_log_file = $fileName
  if($currentEvent.name -eq 'sql_batch_completed') {$row.text_data = $currentEvent.Fields["batch_text"].Value}
  else {$row.text_data = $currentEvent.Fields["statement"].Value}
  $dt.Rows.Add($row)
  }
  $cn = new-object System.Data.SqlClient.SqlConnection("Data Source=MyDevServer.domainname;Integrated Security=SSPI;Initial Catalog=AdventureWorks");
  $cn.Open()
  $bc = new-object ("System.Data.SqlClient.SqlBulkCopy") $cn
  $bc.BulkCopyTimeout = 1200 #you can increase if required
  $bc.DestinationTableName = "dbo.xe_audit_collection"
  [void]$bc.ColumnMappings.Add("server_name",$dt.Columns.ColumnName[0])
  [void]$bc.ColumnMappings.Add("xe_load_date",$dt.Columns.ColumnName[1])
  [void]$bc.ColumnMappings.Add("end_time",$dt.Columns.ColumnName[3])
  [void]$bc.ColumnMappings.Add("text_data",$dt.Columns.ColumnName[4])
  [void]$bc.ColumnMappings.Add("duration", $dt.Columns.ColumnName[5])
  [void]$bc.ColumnMappings.Add("logicalreads",$dt.Columns.ColumnName[6])
  [void]$bc.ColumnMappings.Add("physicalreads",$dt.Columns.ColumnName[7])
  [void]$bc.ColumnMappings.Add("EndResult",$dt.Columns.ColumnName[8])
  [void]$bc.ColumnMappings.Add("RowCount",$dt.Columns.ColumnName[9])
  [void]$bc.ColumnMappings.Add("ObjectName",$dt.Columns.ColumnName[10] )
  [void]$bc.ColumnMappings.Add("writes",$dt.Columns.ColumnName[11])
  [void]$bc.ColumnMappings.Add("CPU",$dt.Columns.ColumnName[12])
  [void]$bc.ColumnMappings.Add("event_name",$dt.Columns.ColumnName[13] )
  [void]$bc.ColumnMappings.Add("database_id",$dt.Columns.ColumnName[14])
  [void]$bc.ColumnMappings.Add("hostname",$dt.Columns.ColumnName[15] )
  [void]$bc.ColumnMappings.Add("application_name", $dt.Columns.ColumnName[16])
  [void]$bc.ColumnMappings.Add("login_name",$dt.Columns.ColumnName[17])
  [void]$bc.ColumnMappings.Add("spid",$dt.Columns.ColumnName[18)
  [void]$bc.ColumnMappings.Add("xe_log_file",$dt.Columns.ColumnName[19] )
  $bc.WriteToServer($dt)
  write-host " $($dt.rows.count) Rows have been transferred to SQL Server destination"`r`n
  $cn.Close()
  $events.Dispose() 
  $result = "`n Loading of file $XEFilePath complete! `n"
  }
  Catch
  {
      $result = $_.Exception
      $FailedItem = $_.Exception.ItemName
    
  }
  return $result
  }
  #### Load your First File #####
  $XEFilePath = "Z:\xe_log\OLTPServer\xe_troubleshoot_log_01.xel"  ## file location
  $server = "OLTPServer"   ## server name, you are collecting XE data
  $XEFile = "xe_troubleshoot_log_01.xel"  ## XE File Name
  Shred-XElogs -fileWithPath $XEFilePath -serverName $server -fileName $XEFile
  
  <#
--------------------Destination Table Definition ---------------
  CREATE TABLE [dbo].[xe_audit_collection](
         [xe_id] [bigint] IDENTITY(1,1) NOT NULL,
         [server_name] [sysname] NOT NULL,
         [xe_load_date] [datetime2](7) NULL,
         [end_time] [datetime2](7) NULL,
         [text_data] [varchar](max) NULL,
         [duration] [bigint] NULL,
         [logicalreads] [bigint] NULL,
         [physicalreads] [bigint] NULL,
         [EndResult] [int] NULL,
         [RowCount] [bigint] NULL,
         [ObjectName] [varchar](250) NULL,
         [writes] [bigint] NULL,
         [CPU] [bigint] NULL,
         [event_name] [varchar](100) NULL,
         [database_id] [int] NULL,
         [hostname] [sysname] NOT NULL,
         [application_name] [sysname] NULL,
         [login_name] [sysname] NULL,
         [spid] [int] NULL,
         [xe_log_file] [varchar](250) NULL,
         [start_time]  AS (dateadd(millisecond, -CONVERT([int],[duration]/(1000)),[end_time])) PERSISTED
  )
  GO
-----------------------------------------------------------------
#>
  