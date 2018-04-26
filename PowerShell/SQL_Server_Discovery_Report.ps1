 <#
    .SYNOPSIS
        SQL Server discovery report.

    .DESCRIPTION
        Runs the SQL Server discovery report (opens in default browser). Run as Administrator!!!

    .INPUTS
        None

    .OUTPUTS
        None

    .NOTES
        Version:        1.1

        Author:         Dave Mason
            https://twitter.com/BeginTry
            https://itsalljustelectrons.blogspot.com/

        Creation Date:  2018/04/18

        Assumptions:
            1. The sub-folder "Microsoft SQL Server" exists in %PROGRAMFILES%, 
                even if SQL was installed to a non-default path. This has been 
                verified on SQL 2008R2 and SQL 2012. Further verification may be needed.
            2. The numbered sub-folders in "%PROGRAMFILES%\Microsoft SQL Server" correlate to 
                installed versions of SQL Server. The numbers sync with database compatibility 
                levels. For example:
                        140     "%PROGRAMFILES%\Microsoft SQL Server\140"   SQL Server 2017
                        130     "%PROGRAMFILES%\Microsoft SQL Server\130"   SQL Server 2016
                        120     "%PROGRAMFILES%\Microsoft SQL Server\120"   SQL Server 2014
                        110     "%PROGRAMFILES%\Microsoft SQL Server\110"   SQL Server 2012
                        100     "%PROGRAMFILES%\Microsoft SQL Server\100"   SQL Server 2008 R2
                If this version/folder/naming convention remains intact for future versions, 
                this script should continue to work with no enhancements.
            3. The discovery report displays installed components for the version of SQL 
                Server associated with setup.exe, along with installed components of all 
                lesser versions of SQL Server that are installed.

        History:
     2018/04/23     DMason
            Output a message if no installed SQL Server features are found.
     Enhancements for older versions of SQL Server (2008, 2005).
            Thanks to Wayne Sheffield for verifying the Setup.exe Bootstrap path for 
                SQL Server 2008 R2 and for providing paths for SQL Server 2008 and 2005.
                https://twitter.com/DBAWayne
                https://blog.waynesheffield.com/wayne/

#>

#Locate the "%PROGRAMFILES%\Microsoft SQL Server" folder.
$MSSQLpath = [System.IO.Path]::Combine($env:ProgramFiles, "Microsoft SQL Server")
$lstCompatLevelDirs = New-Object "System.Collections.Generic.List[Int32]"

<#
    Iterate through the "Microsoft SQL Server" sub-folders.
    Sub-folder names that are numeric are added to List of type Int32.
#>
Get-ChildItem -Directory $MSSQLpath | 
    ForEach-Object {
        [Int32]$DirNum = 0

        if ([Int32]::TryParse($_.Name, [ref]$DirNum))
        {
            $lstCompatLevelDirs.Add($DirNum)
        }
    }

#Sort() the List, then Reverse() it so there is DESCENDING order.
$lstCompatLevelDirs.Sort()
$lstCompatLevelDirs.Reverse()

[bool] $setupExeFound = $false

<#
    Find the Setup Bootstrap Setup.exe file in the "highest" sub-folder.
    Here are a few examples:
        "%PROGRAMFILES%\Microsoft SQL Server\140\Setup Bootstrap\SQL2017\setup.exe"
        "%PROGRAMFILES%\Microsoft SQL Server\130\Setup Bootstrap\SQLServer2016\setup.exe"
        "%PROGRAMFILES%\Microsoft SQL Server\120\Setup Bootstrap\SQLServer2014\setup.exe"
        "%PROGRAMFILES%\Microsoft SQL Server\110\Setup Bootstrap\SQLServer2012\setup.exe"
        "%PROGRAMFILES%\Microsoft SQL Server\100\Setup Bootstrap\SQLServer2008R2\Setup.exe"
#>
ForEach($int in $lstCompatLevelDirs)
{
    #The "Setup Bootstrap" path. For example: "%PROGRAMFILES%\Microsoft SQL Server\140\Setup Bootstrap
    [string]$SetupBootstrap = [System.IO.Path]::Combine(
        [System.IO.Path]::Combine($MSSQLpath, $int.ToString()),
        "Setup Bootstrap")

    if ([System.IO.Directory]::Exists($SetupBootstrap))
    {
        <#
            Iterate through the list of sub-folders with names that match the pattern "SQL*"
        #>
        ForEach($sqlSubDir in [System.IO.Directory]::GetDirectories($SetupBootstrap, "SQL*"))
        {
            <#
                Search for "setup.exe". 
                If found:
                    Run the exe with the appropriate parameters to run the discovery report.
                    Break out of the loops.
            #>
            [string]$setupExe = [System.IO.Path]::Combine($sqlSubDir, "setup.exe")

            if ([System.IO.File]::Exists($setupExe))
            {
                $setupExeFound = $true
                Start-Process -FilePath $setupExe -ArgumentList "/Action=RunDiscovery"
                break
            }
        }
    }

    if($setupExeFound)
    {
        break
    }
}

<#
    If the Setup.exe is still not found, search for it in hard-coded paths that correspond
    to older versions that didn't use the current version/folder/naming convention.

    2008: "%PROGRAMFILES%\Microsoft SQL Server\100\Setup Bootstrap\Release\Setup.exe"
    2005: "%PROGRAMFILES%\Microsoft SQL Server\90\Setup Bootstrap\Setup.exe"
#>
if(-Not $setupExeFound)
{
    $lstOldSqlVersionSetupExePaths = New-Object "System.Collections.Generic.List[string]"

    #SQL 2008
    $lstOldSqlVersionSetupExePaths.Add([System.IO.Path]::Combine($MSSQLpath, "100\Setup Bootstrap\Release\Setup.exe"))

    #SQL 2005
    $lstOldSqlVersionSetupExePaths.Add([System.IO.Path]::Combine($MSSQLpath, "90\Setup Bootstrap\Setup.exe"))

    #TODO: add strings to the array for even older versions of SQL (gulp).

    
    ForEach($setupExe in $lstOldSqlVersionSetupExePaths)
    {
        if ([System.IO.File]::Exists($setupExe))
        {
            $setupExeFound = $true
            Start-Process -FilePath $setupExe -ArgumentList "/Action=RunDiscovery"
            break
        }
    }
}

if(-Not $setupExeFound)
{
    Write-Host "No installed SQL Server features found." -ForegroundColor Yellow 
}
