<#
.SYNOPSIS
    When SQL Server was rebooted
.DESCRIPTION
    Sets Extended Events Sessions to Auto-Start and starts it if it is not running
.EXAMPLE
    ./When-SQL-Serve-was-Rebooted.ps1
.LINK
    Script posted over:
    https://simplesqlserver.com/2016/06/01/powershell-when-were-my-servers-rebooted/
.NOTES
    Author: Steve Hood
    Created Date: 2016-06-01
#>

Import-Module ActiveDirectory

#either method works for getting a list of groups. You can type in all of your groups or make a query to find them all.
#$groups = "Test SQL Servers", "Prod SQL Servers 1", "Prod SQL Servers 2", "SQL Cluster Servers 1", "SQL Cluster Servers 2"

$groups = Get-ADGroup -Filter {name -like "*SQL *"} | where-object {$_.distinguishedname -like "*OU=SUS Group*"}

ForEach ($group in $groups) {
    $computerlist = Get-ADGroupMember $group -Recursive | SELECT name 

    #If there were any computers in the list, do this.  It skips empty groups.
    if ($computerlist) {
        $computerlistcount = $computerlist.Count

        #It returns an object instead of an array if there was only one, so count would be null
        if (!$computerlistcount) {
            $computerlistcount = 1
        }

        Write-Host ""
        Write-Host "$computerlistcount server(s) in" $group.name
    }

    ForEach ($computer in $computerlist) {
        try {
            Get-WmiObject win32_operatingsystem -ComputerName $computer.name -ErrorAction Stop | select csname, @{LABEL='LastBootUpTime';EXPRESSION={$_.ConverttoDateTime($_.lastbootuptime)}}
        }
        catch {
            #This logic is lacking.  I don't care what error you got, just say you couldn't connect and we'll move on.
            #For this script, it probably means the server is in the middle of a reboot
            Write-Host "Could not connect to" $computer.name
            Continue
        }
    }
}
