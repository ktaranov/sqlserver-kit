#requires -version 2.0

<#
.SYNOPSIS
    Disable SQL Server CEIP services

.DESCRIPTION
    Author: Eric Cobb
    Create date: 2020-02-18
    http://www.sqlnuggets.com/blog/disable-telemetry-on-multiple-sql-servers-with-powershell/

.PARAMETER server
    Server list where disable SEIP services
#>

$server = 'Server01' ,'Server02','Server03','Server04';
 
# Stop all CEIP services
invoke-command -computername $server {Get-Service |? name -Like "*TELEMETRY*" | ? status -eq "running" | Stop-Service};
 
# Disable all CEIP services
invoke-command -computername $server {Get-Service |? name -Like "*TELEMETRY*" | Set-Service -StartMode Disabled};
 
# Check service status (should see "stopped" and "disabled"
invoke-command -computername $server {Get-Service |? name -Like "*TELEMETRY*" | select -property name,starttype,status};
 
# Disable "Error Reporting" and "Customer Feedback" Registry Values
invoke-command -computername $server {Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server' -Recurse | Where-Object -Property Property -eq 'EnableErrorReporting'| Set-ItemProperty -Name EnableErrorReporting -Value 0};
invoke-command -computername $server {Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server' -Recurse | Where-Object -Property Property -eq 'EnableErrorReporting'| Set-ItemProperty -Name CustomerFeedback -Value 0};
invoke-command -computername $server {Get-ChildItem 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Microsoft SQL Server' -Recurse | Where-Object -Property Property -eq 'EnableErrorReporting'| Set-ItemProperty -Name EnableErrorReporting -Value 0};
invoke-command -computername $server {Get-ChildItem 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Microsoft SQL Server' -Recurse | Where-Object -Property Property -eq 'EnableErrorReporting'| Set-ItemProperty -Name CustomerFeedback -Value 0};
 
# Check registry values (should see 0 for "EnableErrorReporting" and "CustomerFeedback")
invoke-command -computername $server {Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server' -Recurse | Where-Object -Property Property -eq 'EnableErrorReporting'};
invoke-command -computername $server {Get-ChildItem 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Microsoft SQL Server' -Recurse | Where-Object -Property Property -eq 'EnableErrorReporting'};
 