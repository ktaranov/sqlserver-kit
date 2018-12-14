#requires -version 5.0
#requires -modules dbatools,pester

<#
.Synopsis
  Ensure that some SQL Scripts in a directory would parse so there was some guarantee that they were valid T-SQL.

.OUTPUTS
  Any invalid TSQL

.NOTES
   Original link: https://sqldbawithabeard.com/2018/07/25/a-powershell-pester-check-for-parsing-sql-scripts/
   Author: Rob Sewell
#>

Describe "Testing SQL" {
    Context "Running Parser" {
        ## Load assembly
        $dbatoolsPath = 'C:\Program Files\WindowsPowerShell\Modules\dbatools';

        $Parserdll = (Get-ChildItem $dbatoolsPath -Include Microsoft.SqlServer.Management.SqlParser.dll -Recurse)[0].FullName;
        [System.Reflection.Assembly]::LoadFile($Parserdll) | Out-Null;
        
        $TraceDll = (Get-ChildItem $dbatoolsPath -Include Microsoft.SqlServer.Diagnostics.Strace.dll -Recurse)[0].FullName;
        [System.Reflection.Assembly]::LoadFile($TraceDll) | Out-Null;
        
        $ParseOptions = New-Object Microsoft.SqlServer.Management.SqlParser.Parser.ParseOptions;
        $ParseOptions.BatchSeparator = 'GO';
        $files = Get-ChildItem -Path $Env:Directory -Include *.sql -Recurse; ## This variable is set as a Build Process Variable or put your path here
        $files.ForEach{
            It "$($Psitem.FullName) Should Parse SQL correctly" {
                $filename = $Psitem.FullName;
                $sql = Get-Content -LiteralPath "$fileName";
                $Script = [Microsoft.SqlServer.Management.SqlParser.Parser.Parser]::Parse($SQL, $ParseOptions);
                $Script.Errors | Should -BeNullOrEmpty;
            }
        }
    }
}
