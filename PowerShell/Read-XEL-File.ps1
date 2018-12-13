#requires -version 3.0

<#
.Synopsis
  Read Extended Event .xel file.

.OUTPUTS
  First 50 rows of .xel file delimeted columns by ; and rows by \r\n

.NOTES
   Original link: https://sqlserverpowershell.com/2017/04/06/read-an-extended-events-file-via-powershell/
   Author: Scott Newman
#>

$xelFilePath = 'c:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Log\system_health_0_131916022434590000.xel';
$xelDDLPath = 'C:\Program Files\Microsoft SQL Server\140\Shared\';
 
Add-Type -Path ($xelDDLPath+'Microsoft.SqlServer.XE.Core.dll');
Add-Type -Path ($xelDDLPath+'Microsoft.SqlServer.XEvent.Linq.dll');
 
$events = New-Object Microsoft.SqlServer.XEvent.Linq.QueryableXEventData($xelFilePath)
$sb = New-Object System.Text.StringBuilder
 
$events | select -First 50 | %{
    $event = $_
    [void]$sb.Append("$($event.Timestamp);;");
 
    for($i=0;$i-lt($event.Fields.Count-1);$i++){  
        [void]$sb.Append("$($event.Fields[$i].Value.ToString().Replace("`r`n", ''));;");
    }
     
    $event.Actions | %{
        $action = $_
        [void]$sb.Append("$($action.value.ToString().Replace("`r`n", ''));;");
    }
    [void]$sb.Append("ServerName;;");
 
    [void]$sb.AppendLine();
}
$sb.ToString();
