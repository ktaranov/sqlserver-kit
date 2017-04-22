<#
.SYNOPSIS
    Truncate all tables in database.
.DESCRIPTION
    Truncate all tables in database. Drop and recreate all foreign keys.
.PARAMETR
    Machine <String> - specify path to computer
.PARAMETR
    SqlInstance <String> - specify SQL Server instance name    
.PARAMETR
    DBname <String> - specify database name
.EXAMPLE
Truncate-AllTables -Machine "hostname"
.NOTES
    Requires: Powershell version 3 or higher, sqlps module
    Tested on: SQL Server 2014/2016
    Author: Jeffrey Yao
    Author Modified: Alexandr Titenko
    Created date: 2016-03-15
    Last modified: 2017-02-16
#>

function Truncate-AllTables {

    param (
        #Specify path to computer
        [Parameter(Mandatory=$false)]
        [String]$Machine = $env:COMPUTERNAME,
        #Specify SQL Server instance name
        [Parameter(Mandatory=$false)]
        [String]$SqlInstance = 'default',
        #Specify database name
        [Parameter(Mandatory=$false)]
        [String]$DBname = 'DBName'   
    )
import-module sqlps -DisableNameChecking;
set-location c:\;
Write-Host "[*] Start at $(Get-Date -Format 'HH.mm.ss')" -foreground:yellow
$sw = [Diagnostics.Stopwatch]::StartNew()

[String]$FT_index='';

[Microsoft.SqlServer.Management.Smo.Database]$db = get-item "sqlserver:\sql\$Machine\$SqlInstance\databases\$($DBname)";
$db.tables.Refresh(); 

#script out FKs and save it to variable $fk_script
$db.tables | % -begin {[string]$fk_script=''} -process {$_.foreignkeys.refresh(); $_.foreignkeys | % {$fk_script +=$_.script() +";`r`n"} }

#drop foreign keys
$db.tables | % -begin {$fks=@()} -process { $fks += $_.ForeignKeys  };
foreach ($fk in $fks) {$fk.drop();}

foreach ($t in $db.tables )
{
    $t.TruncateData(); #direct truncate
    write-host "truncate table [$($t.Schema)].[$($t.name)]" -ForegroundColor yellow
}

#resetup the FKs
$db.ExecuteNonQuery($fk_script);
$db = $null;
$svr = $null;

Write-Host "[*] Finish at $(Get-Date -Format 'HH.mm.ss')" -foreground:yellow
Write-Host "Duration:"
$sw.Stop();
$sw.Elapsed | Format-Table -Property Minutes, Seconds, Milliseconds -AutoSize;
}

Truncate-AllTables