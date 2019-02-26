$path = 'd:\system_health_0_131914905113690000.xel'
 
#Add-Type -Path 'C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\ManagementStudio\Extensions\Application\Microsoft.SqlServer.XE.Core.dll'
#Add-Type -Path 'C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\ManagementStudio\Extensions\Application\Microsoft.SqlServer.XEvent.Linq.dll'
  
Add-Type -Path 'C:\Program Files\Microsoft SQL Server\120\Shared\Microsoft.SqlServer.XE.Core.dll'
Add-Type -Path 'C:\Program Files\Microsoft SQL Server\120\Shared\Microsoft.SqlServer.XEvent.Linq.dll'
 
$events = New-Object Microsoft.SqlServer.XEvent.Linq.QueryableXEventData($path)
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
