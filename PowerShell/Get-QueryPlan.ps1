<#
.Synopsis
    Formatting your T-SQL code 
.DESCRIPTION
    Formatting T-SQL code through RedGate Format Api (https://www.red-gate.com/products/sql-development/sql-prompt/)

    Works on PowerShell Core (aka PowerShell 6+)
.EXAMPLE
    $Script = '--(Query 16)_(AlwaysOn AG Cluster)
    SELECT cluster_name, quorum_type_desc, quorum_state_desc
    FROM sys.dm_hadr_cluster WITH (NOLOCK) OPTION (RECOMPILE);
    ------'

    Format-SQLCode -Script $Script -Style Default
.EXAMPLE
    Formatting one file

    Format-SQLCode `
        -FullName 'C:\SQL Server 2014 Diagnostic Information Queries\(Query 11)_(SQL Server Agent Alerts).sql' `
        -Style Default
.EXAMPLE
   Formatting all file on a directory
   
   Get-ChildItem 'C:\SQL Server 2014 Diagnostic Information Queries' -File | Format-SQLCode -Style Default 

.EXAMPLE
    Formatting all file on a directory and save the result to file.

    $ListFiles = Get-ChildItem 'C:\Temp\SQL Server 2014 Diagnostic Information Queries\' -File
    Foreach($File in $ListFiles) {
        $File | Format-SQLCode -Style Indented | Set-Content -PassThru -Path $File.FullName
    }

.LINK
   Author: Mateusz Nadobnik
   Link: http://mnadobnik.pl/format-sqlcode
 
   Date: 01.02.2019
   Version: 1.0.0.0
   Keywords: Formatting, T-SQL, RedGate, SQL Prompt
   Notes:
   Changelog:
#>
######################################################################################
#
#   File Name:    Get-QueryPlan.ps1
#
#   Applies to:   SQL Server 2008
#                 SQL Server 2008 R2
#                 SQL Server 2012
#
#   Purpose:      Used to retrieve an XML query plan from cache.
#
#   Prerequisite: Powershell must be installed.
#                 SQL Server components must be installed.
#
#   Parameters:   [string]$SqlInstance - SQL Server name (Ex: SERVER\INSTANCE)
#                 [string]$PlanHandle - Binary query handle
#
#   Author:       Patrick Keisler
#
#   Version:      1.0.0
#
#   Date:         08/30/2013
#
#   Help:         http://www.patrickkeisler.com/2013/09/the-case-of-null-queryplan.html
#
######################################################################################

#Define input parameters
param ( 
  [Parameter(Mandatory=$true)]
  [ValidateNotNullOrEmpty()]
  [string]
  $SqlInstance
  
  ,[Parameter(Mandatory=$true)]
  [ValidateNotNullOrEmpty()]
  [string]
  $PlanHandle
  )

Write-Host "Script starting."

#Grab the path where the Powershell script was executed from.
$path = Split-Path $MyInvocation.MyCommand.Path

#Build the SQL Server connection objects
$conn = New-Object System.Data.SqlClient.SqlConnection
$builder = New-Object System.Data.SqlClient.SqlConnectionStringBuilder
$cmd = New-Object System.Data.SqlClient.SqlCommand

#Build the TSQL statement & connection string
$SqlCommand = "SELECT query_plan FROM sys.dm_exec_text_query_plan(" + $PlanHandle + ",DEFAULT,DEFAULT);"
$builder.psBase.DataSource = $SqlInstance
$builder.psBase.InitialCatalog = "master"
$builder.psBase.IntegratedSecurity = $true
$builder.psBase.ApplicationName = "Get-QueryPlan"
$builder.psBase.Pooling = $true
$builder.psBase.ConnectTimeout = 15
$conn.ConnectionString = $builder.ConnectionString
$cmd.Connection = $conn
$cmd.CommandText = $SqlCommand

try
{
 if ($conn.State -eq "Closed")
 {
  #Open a connection to SQL Server
  $conn.Open()
 }
 
 #Execute the TSQL statement
 [string]$QueryPlanText = $cmd.ExecuteScalar()

 #Write the output to a file
 $FileName = $path + "\output.sqlplan"
 $stream = New-Object System.IO.StreamWriter($FileName)
 $stream.WriteLine($QueryPlanText)

 if ($stream.BaseStream -ne $null)
 {
  #Close the stream object
  $stream.close()
 }

 if ($conn.State -eq "Open")
 {
  #Close the SQL Server connection
  $conn.Close()
 }
 
 Write-Host "Script completed successfully."
}
catch
{
 #Capture errors if needed
 if ($_.Exception.InnerException)
 {
  $Host.UI.WriteErrorLine("ERROR: " + $_.Exception.InnerException.Message)
  if ($_.Exception.InnerException.InnerException)
  {
   $Host.UI.WriteErrorLine("ERROR: " + $_.Exception.InnerException.InnerException.Message)
  }
 }
 else
 {
  $Host.UI.WriteErrorLine("ERROR: " + $_.Exception.Message)
 }
 
 Write-Host .
 Write-Host "ERROR: Script failed."
}
