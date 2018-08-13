#requires -version 4
#requires -modules PSLogging
<#
.SYNOPSIS
  Export in parallel sql server tables into csv files using bcp utility
.DESCRIPTION
  Export in parallel sql server tables into csv files using bcp utility
   bcp docs: https://docs.microsoft.com/en-us/sql/tools/bcp-utility
.PARAMETER CSVPath <string>
    Specifies path to out csv file(s) and log file
.PARAMETER ServerName <string>
    Specifies a SQL Server name
.PARAMETER DatabaseName <string>
    Specifies a database name
.PARAMETER CodePage <string>
    Specifies code page
.PARAMETER SchemaName <string>
    Specifies shema name. Use this parameter with parameter TableName
.PARAMETER TableName <string>
    Specifies table name.
.PARAMETER ExcludeColumns <string>
    Specifies which columns will be excluded.
.PARAMETER OrderByColumns <string>
    Sets order by specific columns.
.PARAMETER MinRowCount <string>
    Specifies a minimum row count for table(s) which will be unloaded
.PARAMETER MaxRowCount <string>
    Specifies a maximum row count for table(s) which will be unloaded
.PARAMETER FormatFile <string>
    Specify format file
.PARAMETER FieldTerminator <string>
    Specify field terminator
.PARAMETER RowTerminator <string>
    Specify row terminator
.PARAMETER FileExtension <string>
    Determines the file extension
.PARAMETER Collation <string>
    Specifies collation. Using collation parameter not allowed without format file parameter ('xml' or 'fmt')
.PARAMETER OutputColumnHeaders <bool>
    Specifies presence of headers - true - export with headers; false - export without headers
.PARAMETER SavePhysicalOrder <bool>
    Specifies column order. False - Alphabet column order type; true - physical column order type
.PARAMETER OrderByColumns_term <string>
    Sets order by specific columns
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

Function Export-SQLTableToCSV
{
    Param(
          # Specifies path to out csv file(s) and log file
          [Parameter(Mandatory=$true)]
          [string]$CSVPath,
          # Specifies a SQL Server name
          [Parameter(Mandatory=$true)]
          [string]$ServerName,
          # Specifies a database name
          [Parameter(Mandatory=$true)]
          [string]$DatabaseName,
          [Parameter(Mandatory=$false)]
          [string]$CodePage = '-C65001',
          [Parameter(Mandatory=$false)]
          [string]$ExcludeColumns,
          [Parameter(Mandatory=$false)]
          [string]$SchemaName,
          [Parameter(Mandatory=$false)]
          [string]$TableName,
          [Parameter(Mandatory=$false)]
          [string]$OrderByColumns,
          [Parameter(Mandatory=$false)]
          [string]$MinRowCount,
          [Parameter(Mandatory=$false)]
          [string]$MaxRowCount,
          [Parameter(Mandatory=$false)]
          [string]$FormatFile,
          [Parameter(Mandatory=$false)]
          [string]$FieldTerminator,
          [Parameter(Mandatory=$false)]
          [string]$RowTerminator,
          [Parameter(Mandatory=$false)]
          [string]$FileExtension,
          [Parameter(Mandatory=$false)]
          [string]$Collation,
          [Parameter(Mandatory=$false)]
          [switch]$OutputColumnHeaders,
          [Parameter(Mandatory=$false)]
          [switch]$SavePhysicalOrder,
          [Parameter(Mandatory=$false)]
          [string]$OrderByColumns_term = ','
    
    )   
    Begin
    {
      Write-LogInfo -LogPath $sLogFile -Message "Srart export SQL Tables from $DatabaseName in $CSVPath with bcp utility"
      $sw = [Diagnostics.Stopwatch]::StartNew()
      Write-Host "[*] Start script at $(Get-Date -Format 'HH:mm:ss')" -foreground:yellow; 
    }
    Process
    {
        Try
        {
            if (-not(Test-Path $CSVPath))
            {
                $message = "Path $CSVPath doesn't exist!"
                Write-Host $message -ForegroundColor Red
                Write-LogInfo -LogPath $sLogFile -Message $message
                break
            }
                        
            $alllowableFormatFileTypes = @('','xml','fmt')

            if ($alllowableFormatFileTypes -notcontains $FormatFile)
            {
                $message = "Allowed values for parameter FormatFile is xml, fmt or blank value"
                Write-Host $message -ForegroundColor Red
                Write-LogInfo -LogPath $sLogFile -Message $message
                break
            }

            if (-not($FormatFile) -and $Collation)
            {
                $message = "Using collation parameter not allowed without format file parameter ('xml' or 'fmt')"
                Write-Host $message  -ForegroundColor Red
                Write-LogInfo -LogPath $sLogFile -Message
                break
            }

            if ($ExcludeColumns[0] -notcontains '[' -and $ExcludeColumns -notcontains '')
            {
                $message = "Parameter orderByColumns must be in square brackets and separated by comma"
                Write-Host $message  -ForegroundColor Red
                Write-LogInfo -LogPath $sLogFile -Message
                break
            }

            if ($ExcludeColumns[0] -contains '[' -and $FormatFile -notcontains '')
            {
                $message = "Parameter ExcludeColumns must be blank, since parameter FormatFile is present"
                Write-Host $message  -ForegroundColor Red
                Write-LogInfo -LogPath $sLogFile -Message
                break
            }

            if ($ExcludeColumns -and ($SchemaName -or $TableName))
            {
                $message = "Parameter ExcludeColumns must be blank, since parameters SchemaName or TableName are present"
                Write-Host $message  -ForegroundColor Red
                Write-LogInfo -LogPath $sLogFile -Message
                break
            }

            if ($OrderByColumns -and ($SchemaName -or $TableName))
            {
                $message = "Parameter OrderByColumns must be blank, since parameters SchemaName or TableName are present"
                Write-Host $message  -ForegroundColor Red
                Write-LogInfo -LogPath $sLogFile -Message
                break
            }

            if (-not($OutputColumnHeaders))
            {
                $message = "Headers won't output. If you want headers run with switch parameter: -OutputColumnHeaders"
                Write-Host $message -ForegroundColor Yellow
                Write-LogInfo -LogPath $sLogFile -Message $message
            }
        
            if (-not($SavePhysicalOrder))
            {
                $message = "Alphabet column order type use. If you want column physical order  run with switch parameter: -SavePhysicalOrder"
                Write-Host $message -ForegroundColor Yellow
                Write-LogInfo -LogPath $sLogFile -Message $message
            }
            else
            {
                $message = "Physical column order is used"
                Write-Host $message -ForegroundColor Yellow
                Write-LogInfo -LogPath $sLogFile -Message "Use physical column order"
            }

            if ($Collation)
            {
                $invokeCollation = Invoke-Sqlcmd -ServerInstance $ServerName -Database $DatabaseName -Verbose -Query "
                select  COUNT(*) from sys.fn_helpcollations() WHERE name = '$Collation';";
            
                if ($invokeCollation.Column1 -eq 0)
                {
                    $message = "Defined collation not found in server collations list"
                    Write-Host $message -ForegroundColor Yellow
                    Write-LogInfo -LogPath $sLogFile -Message $message
                    $Collation = ''
                }
            }

            if ($FieldTerminator)
            {
                $FieldTerminatorToHeaders = $FieldTerminator
                $FieldTerminator = '-t"' + $FieldTerminator + '"';
            }

            if ($RowTerminator)
            {
                $RowTerminator = '-r"' + $RowTerminator + '"'
            }

            if ($CodePage)
            {
                $CodePage = '-c ' + $CodePage + ''
            }

            if ($FormatFile -and $FormatFile -eq 'xml')
            {
               $FormatFileForBcp = 'xml" -x'
            }
            else
            {
                $FormatFileForBcp = 'fmt"'
            }
           
            if ($ShemaName)
            {
                $tableDependencySchemaName = "and t.schema_id = (SELECT SCHEMA_ID('$ShemaName'))"
            }
            else
            {
                $tableDependencySchemaName = ''
            }

            if ($TableName)
            {
                $tableDependencyTableName = "and t.name = '$TableName'"
            }
                   else
            {
                $tableDependencyTableName = ''
            }
                
            $tableDependecy = Invoke-Sqlcmd -ServerInstance $ServerName -Database $DatabaseName -Verbose -Query "
            SELECT QUOTENAME(SCHEMA_NAME(t.schema_id)) AS SchemaName
                 , QUOTENAME(t.name)                   AS TableName
                 , SUM(ps.row_count)                   AS TableRowCount
              FROM sys.tables t
            INNER JOIN sys.dm_db_partition_stats ps
                 ON ps.object_id = t.object_id
            WHERE index_id < 2 
            GROUP BY t.name
                   , t.schema_id
            HAVING SUM(ps.row_count) >= $MinRowCount AND SUM(ps.row_count) <= $MaxRowCount $tableDependencySchemaName $tableDependencyTableName
            ORDER BY SUM(ps.row_count) ASC
            OPTION (RECOMPILE);
            ";

            $tableDependecy

            Foreach ($t in $tableDependecy)
            {
               $tableFullName = $t[0] + '.' + $t[1]
               $ShemaName = $t[0].Split('[').Split(']')
               $TableName = $t[1].Split('[').Split(']')
               $ShemaName = ([string]$ShemaName).Trim()
               $TableName = ([string]$TableName).Trim()
               $tableFullNameAndFileExt = $TableFullName + '.' + $FileExtension
               $filePath = $CSVPath + $TableFullName + '.' + $FileExtension
               $filePathWithHeaders = $CSVPath + $TableFullName + '_headers.' + $FileExtension
               $FormatFilePath = $CSVPath + $TableFullName + '.' +  $FormatFile
               $FormatFileDelPath = $CSVPath + $TableFullName + 'del.' +  $FormatFile
               
               Write-Debug "tableFullName:$tableFullName`
                   ShemaName:$ShemaName`
                   trimmedShemaName:$trimmedShemaName`
                   TableName:$TableName`
                   trimmedTableName:$trimmedTableName`
                   tableFullNameAndFileExt:$tableFullNameAndFileExt`
                   filePath:$filePath`
                   filePathWithHeaders:$filePathWithHeaders`
                   FormatFilePath:$FormatFilePath`
                   FormatFileDelPath:$FormatFileDelPath"
               
               if ($OrderByColumns)
               {
                   $CountOrderByColumns = $OrderByColumns.split($OrderByColumns_term).Count
                   $invokeCountOrderByColumns = Invoke-Sqlcmd -ServerInstance $ServerName -Database $DatabaseName -Verbose -Query "
                   SELECT COUNT(*)
                   FROM sys.columns sac 
                   WHERE sac.object_id = (SELECT OBJECT_ID('$tableFullName')) AND Name IN ('$OrderByColumns');
                   ";
                   Write-Debug "OrderByColumns: $OrderByColumns`
                       CountOrderByColumns: $CountOrderByColumns"
               
                   if ($invokeCountOrderByColumns.Column1 -notin $CountOrderByColumns)
                   {
                       write-Host "Some columns in OrderByColumns not exists in table" -ForegroundColor Red
                       break
                   }
                   Write-Debug "invokeCountOrderByColumns.Column1: $invokeCountOrderByColumns.Column1"
               }
                      
               if ($SavePhysicalOrder)
               {
                   $columnsOrder = 'ORDER BY sac.column_id'
               }
               else 
               {
                   $columnsOrder = 'ORDER BY Name'
               }
               Write-Debug "SavePhysicalOrder: $SavePhysicalOrder`
                   columnsOrder: $columnsOrder"
               
               $invokeOrderByColumns = Invoke-Sqlcmd -ServerInstance $ServerName -Database $DatabaseName -Verbose -Query "
               SELECT Name
               FROM sys.columns sac
               WHERE sac.object_id = (SELECT OBJECT_ID('$tableFullName')) AND Name NOT IN ('$ExcludeColumns') $columnsOrder;
               ";
               Write-Debug "ExcludeColumns: $ExcludeColumns"
               
               $Columns = ''
               $ColumnsToHeaders = ''
               
               foreach ($i in $invokeOrderByColumns.Name)
               {
                   $Columns  += '[' + $i + '],'
                   $ColumnsToHeaders += $i + $FieldTerminatorToHeaders
               }
               $Columns = $Columns -replace ".$"
               $ColumnsToHeaders = "'" + ($ColumnsToHeaders -replace ".$") + "'"
               
               Write-Debug "Columns: $Columns`
                   ColumnsToHeaders: $ColumnsToHeaders"             

               $bcpStatement = 'bcp "SELECT '+ $Columns +' FROM ['+ $ServerName +'].['+ $DatabaseName +'].['+ $ShemaName +'].['+ $TableName +']' + `
               $OrdrByColumns + '" queryout "' + $CSVPath + '['+ $ShemaName +'].['+ $TableName +'].' + `
               $FileExtension + '" -T -S ' + $ServerName + ' ' + $CodePage + ' ' + $FieldTerminator + ' ' + $RowTerminator + '';

               Write-Debug "bcpStatement: $bcpStatement"
               
               Invoke-Expression $bcpStatement
               
               if ($OutputColumnHeaders)
               {
                   $bcpStatement = 'bcp "SELECT ' + $ColumnsToHeaders + '" queryout "' + $CSVPath + '['+ $ShemaName +'].['+ $TableName +']_headers.' + `
                   $FileExtension + '" -T -S ' + $ServerName + ' ' + $CodePage + ' ' + $FieldTerminator + ' ' + $RowTerminator + '';
                   
                   Write-Debug "bcpStatement: $bcpStatement"
                   
                   Invoke-Expression $bcpStatement
               }
               
               cmd /C "copy /b $filePathWithHeaders + $filePath $filePathWithHeaders"
               cmd /C "del $filePath"
               cmd /C "ren $filePathWithHeaders `"$tableFullNameAndFileExt`""
                             
               if ($FormatFile -eq ('xml' -or 'fmt') -and $SavePhysicalOrder)
               {
                   $bcpStatement = 'bcp ['+ $DatabaseName +'].'+ $tableFullName +' format nul -c -f "' + $CSVPath + `
                   '['+ $ShemaName +'].['+ $TableName +'].' + $FormatFileForBcp + ' ' + $FieldTerminator + ' -T ';
                   
                   Write-Debug "bcpStatement: $bcpStatement"
                   
                   Invoke-Expression $bcpStatement
               
               }
               
               if ($FormatFile)
               {
                   $tmpSchemaAndTableName = '['+ $ShemaName +'].[tmp' + $TableName + ']'

                   if ($SavePhysicalOrder)
                   {
                       $bcpStatement = 'bcp ['+ $DatabaseName +'].'+ $tableFullName +' format nul -c -f "' + $CSVPath + `
                       '['+ $ShemaName +'].['+ $TableName +']del.' + $FormatFileForBcp + ' ' + $FieldTerminator + ' -T  ';
                       
                       Write-Debug "bcpStatement: $bcpStatement"
               
                       Invoke-Expression $bcpStatement
                   }
                   else
                   {
                      $invokeStatement = 'IF OBJECT_ID(''['+ $DatabaseName +'].'+ $tmpSchemaAndTableName +''') IS NOT NULL DROP TABLE ' +$tmpSchemaAndTableName +';
                      SELECT ' + $Columns + ' INTO ' +$tmpSchemaAndTableName +' FROM ['+ $DatabaseName +'].'+ $tableFullName +' WHERE 1=2;'
                      
                      Write-Debug "invokeStatement: $invokeStatement"
               
                      Invoke-Sqlcmd -ServerInstance $ServerName -Database $DatabaseName -Verbose -Query $invokeStatement
                   }
               
               }

               if ($FormatFile)
               {
                   $invokeCollation = Invoke-Sqlcmd -ServerInstance $ServerName -Database $DatabaseName -Verbose -Query "
                   SELECT CONVERT(VARCHAR(128), DATABASEPROPERTYEX('$DatabaseName', 'collation'));
                   ;";
               
                   $CurrentCollation = $invokeCollation.Column1
                   Write-Debug "CurrentCollation: $CurrentCollation"
               
                   if ($FormatFile -eq 'xml')
                   {
                       $lob = 'SINGLE_NCLOB'
                   }
                   if ($FormatFile -eq 'fmt')
                   {
                       $lob = 'SINGLE_CLOB'
                   }
                   
                   if ($Collation -eq '' -and $FormatFile -eq 'fmt')
                   {
                       $Collation = '""""'
                   }
                   
                   if ($Collation -eq '' -and $FormatFile -eq 'xml')
                   {
                       $Collation = ''
                   }
                   
                   $bcpStatement = 'bcp "SELECT REPLACE(BulkColumn, '''+ $CurrentCollation +''', '''+ $Collation +''') AS BulkColumn 
                   FROM OPENROWSET(BULK '''+ $FormatFileDelPath +''', '+ $lob +') as x" queryout "'+ $FormatFilePath +'" -c -T'       
                   
                   Write-Debug "bcpStatement - $bcpStatement"
                   
                   Invoke-Expression $bcpStatement
                   
                   cmd /C "del $FormatFileDelPath"
               }
            }
        }
        Catch
        {
            Write-LogError -LogPath $sLogFile -Message $_.Exception -ExitGracefully
            Break
        }
    }
    End
    {
      If (-not $Error)
      {
          Write-Host 'Completed Successfully.' -ForegroundColor Green
          Write-Host "[*] Stop script at $(Get-Date -Format 'HH:mm:ss')" -foreground:yellow;
          $sw.Stop();
          $sw.Elapsed  | Format-Table -Property Minutes, Seconds, Milliseconds -AutoSize;
          Write-LogInfo -LogPath $sLogFile -Message 'Completed Successfully.'
          Write-LogInfo -LogPath $sLogFile -Message ' '
      }
      else
      {
          Write-Error -ErrorRecord
          Write-LogInfo -LogPath $sLogFile -Message $Error
      }
    }
}

#-----------------------------------------------------------[Execution]------------------------------------------------------------

Start-Log -LogPath $sLogPath -LogName $sLogName -ScriptVersion $sScriptVersion

Export-SQLTableToCSV -CSVPath D:\1\ -ServerName NL-04 -DatabaseName NIIGAZ  -MinRowCount 1 -MaxRowCount 2 -CodePage '-C65001' -FileExtension txt  -FieldTerminator '|' -RowTerminator '\n' -OutputColumnHeaders  -SavePhysicalOrder -Debug  -FormatFile xml
 

Stop-Log -LogPath $sLogFile
