<#
.SYNOPSIS
    Test the connection for each linked server defined in a SQL Server.
.DESCRIPTION
    This script will test the connection for each linked server defined.
    This script will accept an input of a server name. If no name is passed,
    the script will default to the current computer name.
    This script will output to a file.
.PARAMETER ServerName
    If no name is passed, the script will default to the current computer name.
.PARAMETER OutputFile
    If no name is passed, the script will default to C:\linked_server_output.txt.
.EXAMPLE
    SQL_Server_linked_server_connection_check.ps1 -ServerName "ServerName" -OutputFile "C:\linked_server_output.txt"
.NOTES
    Author: Thomas LaRock
    Original Link: http://thomaslarock.com/2016/03/sql-server-linked-server-connection-test
    Created Date: 2016-02-29
#>

<# Input a server name and output file. #>
Param(
[Parameter(Mandatory = $false, Position=1)]
[String]$ServerName,

[Parameter(Mandatory = $false, Position=2)]
[String]$OutputFile
)

<# Load the assemblies. #>
[system.reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo")|Out-Null
[system.reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.SqlWmiManagement")|Out-Null
 
<# If no server name is passed set to the current server name. #>
if ($ServerName.Length -eq 0){$ServerName = $env:COMPUTERNAME}

<# If no output file set the output file path, and initialize. #>
if ($OutputFile.Length -eq 0){$OutputFile = "C:\linked_server_output.txt"}
"$(Get-Date) Starting Linked Server connection test for server $ServerName." | Out-File $OutputFile

<# Create new objects for managed computer and SQL server instances.
   We use ServerInstances to get friendly names for installed instances,
   and we get a list of services to skip those not currentoy running. #>
$mc = new-object Microsoft.SqlServer.Management.Smo.Wmi.ManagedComputer $ServerName
$Instances = $mc.ServerInstances
$Services = $mc.Services

<# Begin outer loop for each SQL instance installed. #>
foreach($Instance in $Instances)
{
$Servername = $Instance.Parent.Name

<# Begin inner loop, for all services installed. #>
foreach ($ServiceName in $Services)
{
 <# We are filtering for services that are running. #>
 if ($ServiceName.ServiceState -eq "Running") 
 {
  <# Using wildcard search to find services that are like the instance name. #>
  if ($ServiceName.Name -like ("*" + $Instance.Name + "*"))
  {
  <# Build string for sql server name. If -ne, assume named instance. #>
   if ($Instance.Name -ne "MSSQLSERVER")
   {
   <# Build connection name. #>
   $ServerName = $ServerName + "\" + $Instance.name 
   }

   <# Build SQL Server object. #>
   $Server = New-Object Microsoft.SqlServer.Management.Smo.Server($ServerName)

   <# Attempt to connect to this instance by returning the Version property. #>
   try
   {
    $Server.Version | Out-Null
    "$(Get-Date) $ServerName connection attempt." | Out-File $OutputFile -Append

    <# If connection above is successful, get array of linked servers. #>
    $LSNames = $Server.LinkedServers
    "$(Get-Date) $ServerName connection success." | Out-File $OutputFile -Append

    <# If no linked servers defined. #>
    if ($LSNames.Count -eq 0) 
    {
    "$(Get-Date) $ServerName no linked servers found." | Out-File $OutputFile -Append
    }

    <# For each linked server test the connection. #>
    foreach ($LSname in $LSnames)
    { 
     if ($LSname -ne $null)
     {
      try
      {
       $LSname.testconnection()
       $Connectivity = $true
       "$(Get-Date) $ServerName $LSname connection success." | Out-File $OutputFile -Append
      } 
      catch 
      {    
      $Connectivity = $false
      "$(Get-Date) $ServerName $LSname connection failure." | Out-File $OutputFile -Append
      }
     }
    }
   }
   catch [System.Exception] 
   {
   "$(Get-Date) $ServerName Server connection failed." | Out-File $OutputFile -Append
   }
  }
 }
}
}
