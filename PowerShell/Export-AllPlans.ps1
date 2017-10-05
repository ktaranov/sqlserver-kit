<#
.SYNOPSIS
    Export all SQL Server query plans in files.
.DESCRIPTION
     Export all plans from cache to a .SQLPLAN file
.PARAMETR
    Machine <String> - specify path to computer
.PARAMETR
    SqlInstance <String> - specify SQL Server instance name    
.PARAMETR
    DBname <String> - specify database name
.PARAMETR
    Output <String> - specify path for exported files
.EXAMPLE
Export-AllPlans -Machine "hostname"
.NOTES
    Requires: Powershell version 3 or higher, sqlps module
    Tested on: SQL Server 2014/2016
    Author: Grant Fritchey
    Author Modified: Alexandr Titenko
    Created date: 
    Last modified: 2017-02-22
#>

function Export-AllPlans {

    param (
        #Specify path to computer
        [Parameter(Mandatory=$false)]
        [String]$Machine = $env:COMPUTERNAME,
        #Specify SQL Server instance name
        [Parameter(Mandatory=$false)]
        [String]$SqlInstance = '',
        #Specify database name
        [Parameter(Mandatory=$false)]
        [String]$DBname = '',
        #Specify output files path
        [Parameter(Mandatory=$false)]
        [String]$Output = 'C:\plans'
    )
$Query = 'SELECT deqp.query_plan
FROM sys.dm_exec_query_stats AS deqs
CROSS APPLY sys.dm_exec_query_plan(deqs.plan_handle) AS deqp
WHERE deqp.query_plan IS NOT NULL;'
 
$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = "Server=$Machine\$SqlInstance;Database=$DBname;trusted_connection=true"
 
$PlanQuery = new-object System.Data.SqlClient.SqlCommand
$PlanQuery.CommandText = $Query
$PlanQuery.Connection = $SqlConnection
$PlanAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$PlanAdapter.SelectCommand = $PlanQuery
$PlanSet = new-object System.Data.DataSet
$PlanAdapter.Fill($PlanSet)
 
foreach($row in $PlanSet.Tables[0])
{
    $i+=1
    $row[0] | Out-File -FilePath "$Output\$i.sqlplan"
}
}

Export-AllPlans