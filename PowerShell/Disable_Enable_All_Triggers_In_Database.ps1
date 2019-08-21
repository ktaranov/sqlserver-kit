#requires -version 5.0
#requires -modules dbatools

<#
.SYNOPSIS
    Disable and enable again all triggers in database

.DESCRIPTION
    Disable and enable again all triggers in database
    https://jesspomfret.com/disable-all-triggers/

.PARAMETER database
    Database name
#>

$database = "AdventureWorks2017";
$svr = Connect-DbaInstance -SqlInstance server1;
$foreach ($tbl in $svr.databases[$database].Tables)
{
    foreach ($tr in $($tbl.Triggers | Where-Object Isenabled)) {
        $triggers += $tr | Select-Object @{l='SchemaName';e={$tbl.Schema}}, @{l='TableName';e={$tbl.name}}, @{l='TriggerName';e={$_.name}};
        $tr.isenabled = $FALSE;
        $tr.alter();
    }
}
