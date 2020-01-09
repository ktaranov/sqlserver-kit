#requires -version 5.0
#requires -modules sqlserver

<#
.SYNOPSIS
    Export SQL server table to csv file with quotes (if needed) and header

.DESCRIPTION
    Piping Invoke-Sqlcmd into csv file with quotes only if needed.
    Also replace False and True on 0 and 1 for bit types columns.

.NOTES
   Original link: http://www.sqlmovers.com/removing-quotes-from-csv-created-by-powershell/
   Author: Russ Loski
   Version: 1.3
   Modified: 2020-01-09 by Konstantin Taranov
   Source link: https://github.com/ktaranov/sqlserver-kit/blob/master/Powershell/Export_Query_To_Csv.ps1
#>

$databaseName = "master";
$fileName = $tableName = "sys.objects";
$delimiter = ","; # possible values "`t", ",", ";", "|"
if ($delimiter -eq "|") {
    $delimiterReg = $delimiterBit = "\|";
    } else {
    $delimiterReg = $delimiterBit = $delimiter;
    };
$regReplace = '\G(?<start>^|' + $delimiterReg + '+)(("(?<output>[^' + $delimiterReg + '"]*?)"(?=' + $delimiterReg + '|$))|(?<output>".*?(?<!")("")*?"(?=' + $delimiterReg + '|$)))';

Invoke-Sqlcmd -Query "SELECT * FROM $tableName;" `
              -Database $databaseName `
              -Server localhost |
ConvertTo-CSV -NoTypeInformation `
               -Delimiter $delimiter |
               % {$_ -replace $regReplace, '${start}${output}'} |
               % {$_ -replace ($delimiterBit + 'False'), ($delimiter + '0')} |
               % {$_ -replace ('^False'), '0'} |
               % {$_ -replace ($delimiterBit + 'True'),  ($delimiter + '1')} |
               % {$_ -replace ('^True'), '1'} |
Out-File "$fileName.csv" -fo -en utf8; 
