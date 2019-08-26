#requires -version 5.0
#requires -modules sqlserver

<#
.SYNOPSIS
    Script for writing out data from one or more databases either in insert statements

.DESCRIPTION
   Script for writing out data from one or more databases either in insert statements
   (useful for scripting small tables of static data) or in native BCP files
   
   Other types of BCP output are easy to do by altering the BCP parameters in the 
   script slightly.
   You can specify which tables you want to script out via a regex. You can use wildcards
   to specify the databases

.PARAMETER Filepath
     Local directory to save build-scripts to.

.PARAMETER DataSource
     Server name and instance.

.PARAMETER Databases
     Databases to copy from. wildcard comparison *, ? [a-d](range) and [and](set of chars).

.PARAMETER SQLUserName
     Leave blank if Windows auth.

.PARAMETER TablesRegex
     Regex match to specify tables.

.PARAMETER UseBCP
     Use native BCP files if true and generate INSERT statments if false. Default false.

.NOTES
   Original link: https://www.red-gate.com/simple-talk/blogs/scripting-out-sql-server-data-as-insert-statements-via-powershell/
   Author: Phil Factor
   Version: 1.1
   Modified: 2019-08-26 by Konstantin Taranov
   Source link: https://github.com/ktaranov/sqlserver-kit/blob/master/Powershell/Scripting_Out_SQL_Server_Data_As_Insert_Statements.ps1
#>


$Filepath = 'C:\Temp'; # local directory to save build-scripts to
$DataSource = 'localhost'; # server name and instance
$Databases = @('maste*', 'model'); <# the databases to copy from. wildcard comparison *, ?
 [a-d](range) and [and](set of chars) #>
$SQLUserName = ''; #leave blank if Windows auth
$TablesRegex = '.*'; # Regex match to specify tables
$UseBCP =$false;
 
# set "Option Explicit" to catch subtle errors
set-psdebug -strict
$ErrorActionPreference = "stop" # you can opt to stagger on, bleeding, if an error occurs
#load the sqlserver module
$popVerbosity = $VerbosePreference
$VerbosePreference = "Silentlycontinue"
# the import process is very noisy if you are in verbose mode
Import-Module sqlserver -DisableNameChecking #load the SQLPS functionality
$VerbosePreference = $popVerbosity
# get credentials if necessary
if ($SQLUserName -ne '') #then it is using SQL Server Credentials
{
  $SqlEncryptedPasswordFile = `
  "$env:USERPROFILE\$($SqlUserName)-$($SQLInstance).txt"
  # test to see if we know about the password in a secure string stored in the user area
  if (Test-Path -path $SqlEncryptedPasswordFile -PathType leaf)
  {
    #has already got this set for this login so fetch it
    $Sqlencrypted = Get-Content $SqlEncryptedPasswordFile | ConvertTo-SecureString
    $SqlCredentials = `
    New-Object System.Management.Automation.PsCredential($SqlUserName, $Sqlencrypted)
  }
  else #then we have to ask the user for it
  {
    #hasn't got this set for this login
    $SqlCredentials = get-credential -Credential $SqlUserName
    $SqlCredentials.Password | ConvertFrom-SecureString |
    Set-Content $SqlEncryptedPasswordFile
  }
}
 
$ms = 'Microsoft.SqlServer'
$My = "$ms.Management.Smo" #
if ($SQLUserName -eq '') #dead simple if using windows security
{ $s = new-object ("$My.Server") $DataSource }
else # if using sql server security we do it via a connection object
{
  $ServerConnection = new-object "$ms.Management.Common.ServerConnection" (
    $DataSource, $SQLUsername, $SqlCredentials.Password)
  $s = new-object ("$My.Server") $ServerConnection
}
if ($s.Version -eq $null) { Throw "Can't find the instance $Datasource" }
$CreationScriptOptions = new-object ("$My.ScriptingOptions")
<# this is only needed if we are doing insert statements #>
$MyPreferences = @{
  'ScriptBatchTerminator' = $true; # this only goes to the file
  'ToFileOnly' = $true; #no need of string output as well
  'ScriptData' = $true;
  'scriptSchema' = $false;
  'Encoding' = [System.Text.Encoding]::UTF8;
}
$MyPreferences.GetEnumerator() |
  Foreach{ $Name = $_.name; $CreationScriptOptions.$name = $_.Value }
 
$possibilities = $s.Databases | select name
$DatabaseList = @()
$DatabaseList += $databases |
where { $_ -Notlike '*[*?]*' } |
where { $possibilities.Name -contains $_ }
$DatabaseList += $databases |
   where { $_ -like '*[*?]*' } |
     foreach{ $wildcard = $_; $possibilities.Name | where { $_ -like $wildcard } }
$DatabaseList | Sort-Object -Unique |
  foreach {
  write-verbose "now doing $($_)"
  $TheDatabase = $s.Databases[$_]
  
  $TheDatabase.Tables | where { $_.IsSystemObject -eq $false -and $_.name -match $tablesRegex } |
    foreach{
    <# calculate where it should be saved #>
    $directory = "$($FilePath)\$($s.Name)\$($TheDatabase.Name)\Data"
    <# check that the directory exists #>
    if (-not (Test-Path -PathType Container $directory))
    {
      <# we create the  directory if it doesn't already exist #>
      $null = New-Item -ItemType Directory -Force -Path $directory;
    }
    if ($UseBCP -eq $true) <# then we are doing a Native BCP#>
    {
      if ($SQLUserName -eq '')<# OK. Easy, a trusted connection #>
      {
        #native format -n, Trusted connection -T
        BCP "$($_.Schema).$($_.Name)"  out  "$($directory)\$($_.Schema)_$($_.Name).bcp"   `
          -n -T "-d$($TheDatabase.Name)"  "-S$($s.Name)"
      }
      else <# if not a trusted connection we need to provide a userid and password #>
      {
      $progress='';
        $Progress=BCP "$($_.Schema).$($_.Name)"  out  "$($directory)\$($_.Schema)_$($_.Name).bcp"  `
          -n "-d$($TheDatabase.Name)"  "-S$($s.Name)"  `
          "-U$($s.ConnectionContext.Login)" "-P$($s.ConnectionContext.Password)"
      }
      Write-verbose "Writing out to $($_.Schema).$($_.Name) $($directory)\$($_.Schema)_$($_.Name).bcp
      $progress"
      if (-not ($?)) # if there was an error
      {
        throw ("Error with data export of $($directory)\$($_.Schema)_$($_.Name).bcp ");
      }
      
    }
    else <# we are doing insert statements #>
    {
      $CreationScriptOptions.Filename =   `
        "$($FilePath)\$($s.Name)\$($TheDatabase.Name)\Data\$($_.Schema)_$($_.Name)_Data.sql";
      $scripter = new-object ("$My.Scripter") ($s);
      $scripter.Options = $CreationScriptOptions;
      $scripter.EnumScript($_.Urn);
    }
  }
}
