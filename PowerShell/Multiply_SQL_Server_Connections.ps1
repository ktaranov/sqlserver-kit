<#
.SYNOPSIS
    Creates multiply connections to a SQL Server
.DESCRIPTION
    This script creates a number of connections ($MaxConnections)
    to a SQL Server instance ($Server) that connect to a random database and exist/run for
    a certain amount of time ($WaitType/$WaitTime)
    Driver variables
.PARAMETER MaxConnections
    Number of parallel connections
.PARAMETER Server
    Server to connect to
.PARAMETER WaitType
    Type of wait.  DELAY or TIME
    If DELAY then wait for the amount of time.
    If TIME then wait until the time specified.
    Note: Connections are only exist until the wait is over.
    They are active the whole time.
.PARAMETER WaitLength
    Length of wait. Format is HH:MM:SS
.EXAMPLE
    C:\PS>Multiply_SQL_Server_Connections.ps1
.NOTES
    Author: Kenneth Fisher
    Original Link: http://sqlstudies.com/2016/02/24/powershell-script-to-create-multiple-sql-server-connections/
    Created Date: 2016-02-24
#>
$MaxConnections = 2;          # Number of parallel connections
$Server= "(local)\sql2014cs"; # Server to connect to
$WaitType="DELAY";            # Type of wait: DELAY or TIME
$WaitLength="00:00:10";       # Length of wait. Format is HH:MM:SS
                              #  If DELAY then wait for the amount of time.
                              #  If TIME then wait until the time specified.
                              # Note: Connections are only exist until the wait is over.
                              #       They are active the whole time.

#Set Initial collections and objects
$SqlInstance = New-Object Microsoft.SqlServer.Management.Smo.Server $Server;
$DbConnections = @();
$dbs = $SqlInstance.Databases | Where-Object {$_.IsSystemObject -eq 0};

#Build DB connection array
for($i=0;$i -le $MaxConnections-1;$i++){
  $randdb = Get-Random -Minimum 1 -Maximum $dbs.Count
  $DbConnections += $dbs[$randdb].Name
}

#Loop through DB Connection array, create script block for establishing SMO connection/query
#Start-Job for each script block
foreach ($DBName in $DbConnections ) {

# All of that extra information after "Smo" tells it to load just v12 (for when you have multiple
#   versions of SQL installed.)  Note: V12 is 2014.
 $cmdstr =@"
`Add-Type -AssemblyName "Microsoft.SqlServer.Smo,Version=$(12).0.0.0,Culture=neutral,PublicKeyToken=89845dcd8080cc91"
`[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo")
`$SqlConn = New-Object Microsoft.SqlServer.Management.Smo.Server ("$Server")
`$SqlConn.Databases['$DBName'].ExecuteNonQuery("WAITFOR $WaitType '$WaitLength'")
"@

#Uncomment the next like to print the command string for debugging
# $cmdstr
#Execute script block in jobs to run the command asyncronously
$cmd = [ScriptBlock]::Create($cmdstr)
Start-Job -ScriptBlock $cmd
}
