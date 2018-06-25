#requires -version 4
#requires -modules PSLogging
<#
.SYNOPSIS
  Export in parallel sql server tables into csv files using bcp utility
.DESCRIPTION
  Export in parallel sql server tables into csv files using bcp utility
   bcp docs: https://docs.microsoft.com/en-us/sql/tools/bcp-utility
.PARAMETER ServerName <string>
    Specifies SQL Server
.PARAMETER DatabaseName <string>
    Specifies database name
.OUTPUTS Log File
  The script log file stored in C:\Windows\Temp\<name>.log
.NOTES
  Version:        
  Author: Konstantin Taranov k@taranov.pro
  Author Modified: Alexander Titenko aleks.titenko@gmail.com
  Creation Date:  2017-09-26
  Last modified: 2017-09-29
  Purpose/Change: Add PSLogging module
.EXAMPLE
  Export-SQLTableToCSV -CSVPath D:\12\ -ServerName NL-04 -DatabaseName NIIGAZ -MinRowCount 1 -MaxRowCount 3;
#>

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

#Set Error Action to Silently Continue
$ErrorActionPreference = 'SilentlyContinue'

#Import Modules & Snap-ins
Import-Module PSLogging

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
$sScriptVersion = '1.1'

#Log File Info
$sLogPath = 'D:\1\'
$sLogName = 'Export-SQLTableToCSV.log'
$sLogFile = Join-Path -Path $sLogPath -ChildPath $sLogName

#-----------------------------------------------------------[Functions]------------------------------------------------------------

Function Export-SQLTableToCSV {
  Param (
        [Parameter(Mandatory=$true)]
        [string]$CSVPath,
        [Parameter(Mandatory=$false)]
        [string]$ServerName,
        [Parameter(Mandatory=$false)]
        [string]$DatabaseName,
        [Parameter(Mandatory=$false)]
        [string]$CodePage = '-C65001',
        [Parameter(Mandatory=$false)]
        [string]$MinRowCount,
        [Parameter(Mandatory=$false)]
        [string]$MaxRowCount

)
  Begin {
    Write-LogInfo -LogPath $sLogFile -Message "Srart export SQL Tables from $DatabaseName in $CSVPath with bcp utility"
    if(-not(Test-Path $CSVPath)){Write-Host "Path $CSVPath doesn't exist!" -foreground:red;
    Write-LogInfo -LogPath $sLogFile -Message "Path $CSVPath doesn't exist!"
    break;}

  }
  Process {
    Try {

      $wd = $CSVPath;
      $ProcessName = "Bulk Insert txt files";
      
      $TableDependecy = Invoke-Sqlcmd -ServerInstance $ServerName -Database $DatabaseName -Verbose -Query "
      SELECT QUOTENAME(SCHEMA_NAME(t.schema_id)) AS SchemaName
           , QUOTENAME(t.name)                   AS TableName
           , SUM(ps.row_count)                   AS TableRowCount
        FROM sys.tables t
      INNER JOIN sys.dm_db_partition_stats ps
           ON ps.object_id = t.object_id
      WHERE index_id < 2
      GROUP BY t.name
             , t.schema_id
      HAVING SUM(ps.row_count) >= $MinRowCount AND SUM(ps.row_count) <= $MaxRowCount
      ORDER BY SUM(ps.row_count) ASC
      OPTION (RECOMPILE);
      ";

      $bcpStatement = 'bcp "SELECT * FROM ['+ $ServerName + '].[' + $DatabaseName +'].__SCHEMANAME__.__TABLENAME__" queryout "' + $wd + '__SCHEMANAME__.__TABLENAME__.txt" -T -S ' + $ServerName +' -c ' + $CodePage + ' -t"|" -r"\n"';

      $ScriptBlock = {
          param($bcpRunStatement)
          Invoke-Expression $bcpRunStatement
      };
      
      
      $TD = $TableDependecy; # | Where TableLevel -eq $level;
      Foreach($t in $TD){
          $bcpRunStatement = $bcpStatement.Replace("__SCHEMANAME__", $t[0]).Replace("__TABLENAME__", $t[1]);
          Write-Host $bcpRunStatement
          Start-Job -ScriptBlock $ScriptBlock -ArgumentList @($bcpRunStatement);

          while(@(Get-Job -State Running).Count -gt 6){
              Get-Job | Wait-Job -Any | Out-Null
          }
      }
    }
    Catch {
      Write-LogError -LogPath $sLogFile -Message $_.Exception -ExitGracefully
      Break
    }
  }
  End {
    If ($?) {
      Write-LogInfo -LogPath $sLogFile -Message 'Completed Successfully.'
      Write-LogInfo -LogPath $sLogFile -Message ' '
    }
  }
}

#-----------------------------------------------------------[Execution]------------------------------------------------------------

Start-Log -LogPath $sLogPath -LogName $sLogName -ScriptVersion $sScriptVersion

Export-SQLTableToCSV -CSVPath D:\1\ -ServerName NL-04 -DatabaseName NIIGAZ -MinRowCount 1 -MaxRowCount 3;

Stop-Log -LogPath $sLogFile

