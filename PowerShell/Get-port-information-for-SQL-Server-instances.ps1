<#
.SYNOPSIS
    Automated way to get all port information for SQL Server instances
.DESCRIPTION
    Automated way to get all port information for SQL Server instances via powershell script
.EXAMPLE
    ./Get-port-information-for-SQL-Server-instances.ps1
.LINK
    Script posted over:
    https://www.mssqltips.com/sqlservertip/3542/automated-way-to-get-all-port-information-for-sql-server-instances/
.NOTES
    Author: K. Brian Kelley
    Created Date: 2015-09-03
#>

# Store Current Location to return to it when we're done
Push-Location;

# Let's get all the possible hives in the registry on a given system
# We'll use Where-Object to filter down to only those hives which begin with MSSQL
# This gets rid SSAS, SSIS, and SSRS for versions of SQL Server 2008 and up. It also
# gets rid of any hives that are under "Microsoft SQL Server" that aren't for instance
# configuration (or at least not what we're looking for)
Get-ChildItem -Path 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server' | Where-Object {$_.Name -like '*MSSQL*'} | foreach {

    # Get Instance Name
    $props = Get-ItemProperty -path $_.PSPath;

    # If there is no default value, this isn't an instance. We need to trap in case the
    # property doesn't exist
    try {
        $InstanceName = $props.psobject.Properties["(default)"].value;
    }
    catch {
        $InstanceName = "";
    }

    # If there is a valid instance name, proceed farther
    if ($InstanceName.length -gt 0) {

        # Navigate the child keys
        foreach ($key in Get-ChildItem -path $_.pspath){

            # Find entries belonging to actual database engine instances
            if ($key.name -like "*MSSQLServer*")
            {

                # Navigate to the key where the TCP settings are stored
                Set-Location -path $key.pspath;
                cd .\SuperSocketNetLib\tcp -ErrorAction SilentlyContinue;

                # Ensure we're only reporting against the right keys

                $TCPKey = Get-Location;

                if ($TCPKey -like '*SuperSocketNetLib*') {

                    $TCPProps = Get-ItemProperty $TCPKey;

                    # Find out if TCP is enabled
                    $Enabled = $TCPProps.psobject.Properties["enabled"].value;

                    # Begin the reporting
                    Write-Host "Instance Name: $InstanceName";
                    Write-Host "------------------------------------------------------------------------------";

                    # If TCP is not enabled, there's point finding all the ports. Therefore, we check.
                    if ($Enabled -eq 1)
                    {
                        foreach ($Key in gci $TCPKey)
                        {
                            $IPprops = Get-ItemProperty $Key.pspath;
                            $IPAddress = $IPProps.psobject.Properties["IpAddress"].Value;

                            # For the Key IPAll, there is no IPAddress value. therefore, we trap for it.
                            if ($IPAddress -eq $null)
                            {
                                $IPAddress = "All"
                            }

                            Write-Host "  IP Address: $IPAddress";
                            Write-Host "    Dyn. Ports: ", $IPProps.psobject.Properties["TcpDynamicPorts"].Value;
                            Write-Host "    Sta. Ports: ", $IPProps.psobject.Properties["TcpPort"].Value;

                        }
                    } else {
                        Write-Host "  TCP not enabled."
                    }

                    Write-Host "------------------------------------------------------------------------------";
                    Write-Host "";
                }
            }
        }
    }
}

# Return to original location
Pop-Location;
