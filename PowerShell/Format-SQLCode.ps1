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
function Format-SQLCode {
    [OutputType([String])]
    [cmdletbinding()]
    param(
        #Style for format script t-sql
        [ValidateSet('Collapsed', 'Commas before', 'Default', 'Indented', 'Right aligned')]
        [string]$Style,
        #Path to file
        [Parameter(Mandatory, ParameterSetName = 'File', ValueFromPipelineByPropertyName = $true)]
        [Alias('FilePath', 'FullNamePath')]
        [string]$FullName,
        #Script 
        [Parameter(Mandatory, ParameterSetName = 'Script')]
        [string]$Script
    )
    begin {
        $ErrorActionPreference = 'Continue';
        $FnName = '[Format-RedGateScriptSQL]';
        if ((Invoke-WebRequest -UseBasicParsing 'https://promptformatapi.red-gate.com/').StatusCode -ne 200) {
            Write-Warning "$FnName Check your connection with the Internet";
            return;
        }
    }
    process {
        $Uri = "https://promptformatapi.red-gate.com/api/format/$Style";
        try {
            if ($FullName) {
                # preparing body for request
                Write-Verbose "$FnName Get content from file: $FullName";
                $FileContent = Get-Content $FullName -Encoding UTF8 -Raw;
                $Body = "`"$FileContent`"";
                Write-Verbose "$Body";
            }
            elseif ($Script) {
                Write-Verbose "$Body";
                $Body = "`"$Script`"";
            }

            Write-Verbose "$FnName $paramInvokeWebRequest";

            Write-Verbose "$FnName Invoke-WebRequest";
            $Response = Invoke-WebRequest `
                -Uri $Uri `
                -Method "POST" `
                -Headers @{"path" = "/api/format/Collapsed"; "origin" = "https://www.red-gate.com"; "accept-encoding" = "gzip, deflate, br"; "accept-language" = "pl-PL,pl;q=0.9,en-US;q=0.8,en;q=0.7"; "user-agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"; "accept" = "*/*"; "referer" = "https://www.red-gate.com/products/sql-development/sql-prompt/?utm_source=format-sql&utm_medium=redirect&utm_campaign=sqlprompt"; "authority" = "promptformatapi.red-gate.com"; "scheme" = "https"; "dnt" = "1"; "method" = "POST"} `
                -ContentType "application/json" `
                -Body $Body `

            if ($Response.StatusCode -eq 200) {
                [string]$FormattedScript = ($Response.Content).replace('\r\n', '`r`n');
                return Invoke-Expression -Command $FormattedScript;
            }
        }
        catch [Microsoft.PowerShell.Commands.HttpResponseException] {
            Write-Warning "$(($_.ErrorDetails.Message | ConvertFrom-Json).Details) - $FullName";
        }
        catch {
            Write-Warning "$($_.ErrorDetails.Message) - $FullName";
        }
    }
    end { };
}
