#requires -version 2.0

<#
.SYNOPSIS
    Changes the version information in the header of a SQL Server trace

.DESCRIPTION
    Author: Gianluca Sartori - @spaghettidba
    Create date: 2012-11-07
    https://spaghettidba.com/2012/11/08/more-on-converting-trace-files/

.PARAMETER fileName
    Trace file name
#>

## =============================================
## Author:      Gianluca Sartori - @spaghettidba
## Create date: 2012-11-07
## Description: Changes the version information
##              in the header of a SQL Server trace
## =============================================
$fileName = "somefile.trc"
 
# The version information we want to write: 0x0A = 10 = SQLServer 2008
[Byte[]] $versionData = 0x0A
# The offset of the version information in the file
$offset = 390
 
[System.IO.FileMode] $open = [System.IO.FileMode]::OpenOrCreate
$stream = New-Object System.IO.FileStream -ArgumentList $fileName, $open
$stream.Seek($offset, [System.IO.SeekOrigin]::Begin);
$stream.Write($versionData, 0, $versionData.Length);
$stream.Close()
