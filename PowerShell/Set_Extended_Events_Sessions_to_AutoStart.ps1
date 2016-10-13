<#
.Synopsis
    Connects to the servers in the DBA Database and for Servers above 2012 sets alwayson_health Extended Events Sessions to Auto-Start and starts it if it is not running
.DESCRIPTION
    Sets Extended Events Sessions to Auto-Start and starts it if it is not running
.EXAMPLE
    Alter the XEvent name and DBADatabase name or add own server list and run
.NOTES
    Author: Rob Sewell
    Original Link: https://sqldbawithabeard.com/2016/03/28/using-powershell-to-set-extended-events-sessions-to-autostart/#comments
    Created Date: 2016-03-20
#>
$DBADatabaseServer 
$XEName = 'AlwaysOn_health'
## Query to gather the servers required
$Query = @"

SELECT 

IL.ServerName

FROM [dbo].[InstanceList] IL

WHERE NotContactable = 0

AND Inactive = 0

"@

Try 
{
$Results = (Invoke-Sqlcmd -ServerInstance $DBADatabaseServer -Database DBADatabase -Query $query -ErrorAction Stop).ServerName
}

catch 
{
Write-Error "Unable to Connect to the DBADatabase - Please Check"
}

foreach($Server in $Results)

    {
        try
            {
            $srv = New-Object ('Microsoft.SqlServer.Management.Smo.Server') $Server
            }
        catch
            {
            Write-Output " Failed to connect to $Server"
            continue
            }
            # To ensure we have a connection to the server
            if (!( $srv.version)){
            Write-Output " Failed to Connect to $Server"
            continue
            }
        if($srv.versionmajor -ge '11')
            {
            ## NOTE this checks if there are Availability Groups - you may need to change this
            if ($srv.AvailabilityGroups.Name)
                {
                $AGNames = $srv.AvailabilityGroups.Name   
                ## Can we connect to the XEStore?                             
                if(Test-Path SQLSERVER:\XEvent\$Server)
                    {
                    $XEStore = get-childitem -path SQLSERVER:\XEvent\$Server -ErrorAction SilentlyContinue  | where {$_.DisplayName -ieq 'default'} 
                    $AutoStart = $XEStore.Sessions[$XEName].AutoStart
                    $Running = $XEStore.Sessions[$XEName].IsRunning
                    Write-Output "$server for $AGNames --- $XEName -- $AutoStart -- $Running"
                    if($AutoStart -eq $false)
                    
                        {
                        $XEStore.Sessions[$XEName].AutoStart = $true
                        $XEStore.Sessions[$XEName].Alter()
                        }
                    
                      if($Running -eq $false)
                        {
                        $XEStore.Sessions[$XEName].Start()
                        } 
                    }
                else
                    {
                    Write-Output "Failed to connect to XEvent on $Server"
                    }
                }

            else
                {
                ## Write-Output "No AGs on $Server"
                }
            }
        else
            {
            ##  Write-Output "$server not 2012 or above"
            }
}
