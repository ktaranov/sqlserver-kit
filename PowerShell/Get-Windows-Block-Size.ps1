<#
.SYNOPSIS
    Get disk block size
.DESCRIPTION
    Get disk block size
.PARAMETR
    serverList <String> - specify path to server list or live empty
.EXAMPLE
    Just run script
.NOTES
    Requires: Powershell version 3 or higher
    Tested on: Windows 10, 7
    Author: Naveen Kumar
    Author Modified: Konstantin Tranov kast218@gmail.com
    Created date: 2017-09-11
    Last modified: 2017-09-11
#>

$serverList = "C:\ServerList.txt";

if(Test-Path $serverList){ 
$ServerList = Get-Content $serverList;
Get-WmiObject -Class Win32_volume -Filter "FileSystem='NTFS'" -ComputerName $serverList | Select-Object PSComputerName, Name, Lable, BlockSize | Format-Table -AutoSize;
}
else{
Get-CimInstance -ClassName Win32_Volume -Filter "FileSystem='NTFS'" | Select-Object Name, Label, BlockSize | Format-Table -AutoSize;
}
