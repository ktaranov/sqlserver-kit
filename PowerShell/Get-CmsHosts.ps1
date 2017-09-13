<# 
.SYNOPSIS This function queries a CMS instance and returns a list of instances Written by Mark Wilkinson @m82labs on Twitter, website m82labs.com 
 
.PARAMETER cmdHost 
 
.PARAMETER searchPattern !!NOT INJECTION SAFE!! this parameter simply gets inserted into a wildcard query on the list of available instances on the CMS. This parameter accepts a pipe delimeter list of patterns, allowing you to match instance names on multiple conditions. 
 
.PARAMETER version The SQL Server version (build number) that should be running on the returned instances. !! This will query each instance to get the build version, use in conjuction with searchPattern !! 
 
.EXAMPLE This will return all instances that start with 'Pattern' and are on SQL 2016 RTM 
Get-CMSHosts -searchPattern 'Pattern' -version '13.0.1605.1' 
 
.EXAMPLE 
This can be used in a 'ForEach': ForEach ( $instance in Get-CMSHosts -searchPattern 'Pattern' -version '13.0.1605.1' ) { #Do some stuff } 
.NOTES
Original link: http://tracyboggiano.com/archive/2017/04/query-multipleservers
#>
function Get-CmsHosts() {
    param(
        [CmdletBinding()]
        [string]$cmsHost = '',
        [string]$searchPattern = '',
        [string]$instanceList,
        [string]$version
    )
    
    If ( $instanceList -and (Test-Path -Path $instanceList) ) {
        $results = Get-Content -Path $instanceList
    } Else {
        $pattern = ''
 
        For ( $pat_i = 0; $pat_i -lt ($searchPattern.Split('|')).Count; $pat_i++ ) {
            If ( $pat_i -gt 0 ) { $pattern += " OR " }
            $pattern += "server_name LIKE '$($searchPattern.Split('|')[$pat_i])%'"            
        }
 
        [string]$query_get_servers = "SELECT DISTINCT server_name FROM msdb.dbo.sysmanagement_shared_registered_servers WHERE {{searchPattern}}"
        $results = (Invoke-SqlCmd -query $query_get_servers.Replace('{{searchPattern}}',$pattern) -ServerInstance $cmsHost).server_name
    }
 
    If ( $version ) {
        ForEach ( $instance In $results ) {
            Try {
                If ( (Invoke-Sqlcmd -Query "SELECT SERVERPROPERTY('productversion') AS v" -ServerInstance $instance -ConnectionTimeout 1 -QueryTimeout 1 -ErrorAction Stop).v -ne $version) {
                    $results = $results | Where-Object { $_ -notmatch $instance }
                }
            } Catch {
                $connect_error += 1
		        Write-Host "failed: $($_.Exception.Message)" -ForegroundColor White -BackgroundColor Red
                $results = $results | Where-Object { $_ -notmatch $instance }
                continue
            }
        }
    }
 
    If ( $connect_error ) {
        Write-Host " -[$($connect_error) instance(s) skipped due to connection error]- " -ForegroundColor Red -NoNewline
    }
 
    return $results
}


Get-CmsHosts -InstanceList 'c:\temp\servers.txt' | % { New-PSSession -ComputerName $_ | out-null}
$sessions = Get-PSSession

$scriptblock = {
$query = @"
SELECT @@VERSION
"@
Invoke-Sqlcmd -Query $query
}

Invoke-Command -Session $($sessions | ? { $_.State -eq 'Opened' }) -ScriptBlock $scriptblock | Select * -ExcludeProperty RunspaceId | Out-GridView
$sessions | Remove-PSSession

