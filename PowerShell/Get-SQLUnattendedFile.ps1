<#
.Synopsis
 The objective of the script is to make use of Input file in which it consists of list of database server instances as a source for various parts of the script.
 
 .Description
  This article is taking the sledge hammer approach and searching for mdf's and then comparing them against files which are available on the listed drive.
  Function to log Output and display the details on the console. 
 
 .Parameter InputFile
  Path to the file where the input details are saved.
  Example: c:\InputServer.txt
  
 .Parameter LogFile
  The file logs all the information about the detached files or orphan file along with its size. This also contains the source of the server. 
   
 .Example
   Write-Log  -Message "$($Server) is reachable and starting the process " -Logfile $Logfile
   
 .Example
  Write-Log  -Message "$(.Server) message " -Logfile $Logfile
 
 .Example
  Get-SQLUnattendedFile -inputfile c:\server.txt -logfile c:\DetachedFileList.txt
 
 .Link
  https://powershellsql.wordpress.com/ Jump
  https://www.sqlshack.com/multi-server-script-find-orphaned-data-files-using-powershell

#>
 
 Function Get-SQLUnattendedFile
{
    [CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact='Low')]
    Param(
        [Parameter(Mandatory=$true,
                  Position=0)]
            [String]$inputFile,
        [Parameter(Mandatory=$true,
                  Position=1)]
            [String]$logfile,
        [Parameter(Mandatory=$true,
                   Position=2)]
            [String]$extension='mdf'
    )
 
#Prepare Log file 
 
if (Test-Path $logFile) {
  Remove-Item $logFile
}
 
$ErrorActionPreference = 'Stop'
 
$sqlservers = Get-Content $inputFile
 
# Prepare headers for the log file for each execution of script
  
Add-Content $logFile "#################################################################"
Add-Content $logFile "Unattended Database File Report"
Add-Content $logFile "Generated $(get-date)"
Add-Content $logFile "Generated from $(gc env:computername)"
Add-Content $logFile "#################################################################"
 
Function Write-Log {
   [CmdletBinding()]
   Param(
   [Parameter(Mandatory=$False)]
   [ValidateSet("INFO","WARN","ERROR")]
   [String]
   $Level = "INFO",
 
   [Parameter(Mandatory=$True)]
   [string]
   $Message,
 
   [Parameter(Mandatory=$False)]
   [string]
   $logfile
   )
 
   $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
   $Line = "$Stamp $Level $Message"
   If($logfile) {
   Add-Content $logfile -Value $Line
   }
   Else {
       Write-Output $Line
   }
}
 
 
Try{
[System.Reflection.Assembly]::LoadWithPartialName(“Microsoft.SqlServer.Smo”) | Out-Null
 
#for printing found instances data uncomment next line
#$Instances
 
foreach ($instance in $sqlservers)
{
    If (!(Test-Connection $instance -count 1 -quiet)) {
     Write-host "$($instance) is not reachable" 
    }
    else
    {
        #Write the Progress to console
        write-host "$($instance) is reachable and starting the process "
        
        #Creating PowerShell custom objects
        $colAttachedMDFs = @()
        $files =@()
        
        #Connect to the given instance. Piping to Out-null to avoid showing loading echo in output
        $srv = new-Object Microsoft.SqlServer.Management.Smo.Server($instance)
        
        #get a list of all attached database file names
        foreach ($db in $srv.Databases ) 
            {
            foreach ($fg in $db.Filegroups) 
                {
                foreach ($file in $fg.Files) 
                    {
                    #Adding to list of attached DBs
                    $colAttachedMDFs += $file.Filename
                    }
                 }
            }
 
        #select local logical drives
        $drives=(get-wmiobject -class “Win32_LogicalDisk” -ComputerName $instance) | ?{$_.drivetype -eq 3 -and ($_.deviceID -eq "F:" -OR $_.deviceID -eq "G:" -OR $_.deviceID -eq "H:" -OR $_.deviceID -eq "I:" -OR $_.deviceID -eq "J:" )} | foreach-object {$_.name}
        #cycle over drives
        foreach ($drive in $drives) 
            {
            $filter = "extension='$extension' AND Drive='$drive'"
            $files +=Get-WmiObject -Class CIM_Datafile -Filter $filter -ComputerName $instance |select name,FileName,@{Name="FileSizeMB";Expression={[math]::Round($_.FileSize/1MB,2)}} 
            }
 
        #$files      
        foreach ($mdf in $files) 
            {
            if (-not ($colAttachedMDFs -contains $mdf.name)) 
                {
                #Adding to list of unattached DBs
                $colMDFsToAttach += $mdf.name + [Environment]::NewLine
                Write-Log  -Message "On $($instance) -> The filename $($mdf.FileName) in this path $($mdf.name)  with a size of $($mdf.fileSizeMB) MB is left unattended " -Logfile $Logfile 
                }
            }
 
        }
    }
}
Catch{
    #Catch error, rethrow and raise exit code
    $_
     }
$colMDFsToAttach
}
 
Get-SQLUnattendedFile -inputfile c:\server.txt -logfile c:\DetachedFileList.txt
 
Invoke-item c:\DetachedFileList.txt