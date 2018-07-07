<#
.Synopsis
  Search for any parameter that does not match the column name.

.OUTPUTS
  Any parameter that does not match the column name

.NOTES
   Original link: https://nocolumnname.blog/2018/05/25/finding-parameters-that-do-not-match-column-names/
   Author: Shane O'Neill
#>

$PatternMatch = '(?<ColumnName>\w+)\s*=\s*@(?<ParameterName>\w+)'

$FindStoredProcedureParameters = @{
    SqlInstance            = 'localhost'
    Database               = 'master'
    Pattern                = $PatternMatch
    IncludeSystemDatabases = $true
}

Find-DbaStoredProcedure @FindStoredProcedureParameters |
    ForEach-Object -Process {
    $ParentRow = $_

    $_ | ForEach-Object StoredProcedureTextFound | Select-String -Pattern $PatternMatch -AllMatches | ForEach-Object Matches | ForEach-Object -Process {
        [PSCustomObject]@{
            ServerName    = $ParentRow.SqlInstance
            DatabaseName  = $ParentRow.Database 
            SchemaName    = $ParentRow.Schema
            ProcedureName = $ParentRow.Name
            TextFound     = ($_.Groups | Where-Object Name -eq '0').Value
            ColumnName    = ($_.Groups | Where-Object Name -eq 'ColumnName').Value
            ParameterName = ($_.Groups | Where-Object Name -eq 'ParameterName').Value
        }
    }
} | Where-Object { ($_.ColumnName -ne $_.ParameterName) } |
    Select-Object -Property * -Unique
