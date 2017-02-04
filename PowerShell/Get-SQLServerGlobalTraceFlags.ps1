<#
.Synopsis
   Display all active trace flags on SQL Server
.DESCRIPTION
   Display all active trace flags on SQL Server
.EXAMPLE
   The following command scripts out the permissions of login account [John] and generates the script at "c:\temp\clone.sql"
   Notice, parameters [OldLogin] and [NewLogin] uses the same value of "John"
   Clone-SQLLogin -Server Server1, Server2 -OldLogin John -NewLogin John -FilePath "c:\temp\clone.sql"
 
.EXAMPLE
  Get-SQLServerGlobalTraceFlags
.NOTES
   Original link: https://naturalselectiondba.wordpress.com/2016/04/21/sql-server-use-powershell-to-find-what-trace-flags-are-running/
   Author: Matthew Darwin
#>

function Get-SQLServerGlobalTraceFlags
{
    [cmdletbinding()]
    param([string]$Server)

    #create an smo object for the SQL Server
    $SQLServer = new-object ("Microsoft.SQLServer.Management.Smo.Server") $Server

    #get the trace flag status
    $TraceFlags = $SQLServer.EnumActiveGlobalTraceFlags()

    #loop through the trace flags and add the servername in order to create an object with all the required rows to import into a table later
    ForEach($TraceFlag in $TraceFlags)
    {
        $data = @{"ServerName" = $Server
                ; "TraceFlag" = $TraceFlag.TraceFlag
                ; "Status" = $TraceFlag.Status}

        $Output = new-object psobject -Property $data
        write-output $output
    }

}

export-modulemember -Function Get-SQLServerGlobalTraceFlags
