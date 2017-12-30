<#
.SYNOPSIS
    Generate a PowerShell HTML Report.
.PARAMETR
    computername <String>
.PARAMETR
    Path <String>
.PARAMETR
    ImagePath <String>
.EXAMPLE
Get-Item -Path $Path
.NOTES
    Author: Jeff Hicks
    Created date: 2017-08-07
    Original Link: https://www.petri.com/adding-script-to-your-powershell-html-reports
#>


[cmdletbinding()]
Param(
[string]$computername = $env:COMPUTERNAME,
#the path to the final htm report
[string]$Path = "C:\temp\systemreport.htm",
#set your own default graphic or delete default value
[string]$ImagePath = "c:\scripts\db.png"
)
 
#region helper functions
 
Function Get-SystemInfo {
[cmdletbinding()]
Param([string]$Computername = $env:COMPUTERNAME)
 
$cs = Get-CimInstance -ClassName Win32_computersystem #-ComputerName $Computername  
#this assumes a single processor
$proc = Get-CimInstance -ClassName win32_processor #-ComputerName $Computername 
 
$data = [ordered]@{
TotalPhysicalMemGB = $cs.TotalPhysicalMemory/1GB -as [int]
NumProcessors = $cs.NumberOfProcessors
NumLogicalProcessors = $cs.NumberOfLogicalProcessors
HyperVisorPresent = $cs.HypervisorPresent
DeviceID = $proc.DeviceID
Name = $proc.Name
MaxClock = $proc.MaxClockSpeed
L2size = $proc.L2CacheSize
L3Size = $proc.L3CacheSize
 
}
 
New-Object -TypeName PSObject -Property $data
 
}
 
Function Get-DiskInfo {
[cmdletbinding()]
Param([string]$Computername = $env:COMPUTERNAME)
 
Get-CimInstance -ClassName win32_logicaldisk -filter "drivetype=3" -ComputerName $Computername |
Select DeviceID,
@{Name="SizeGB";Expression = {$_.size/1gb -as [int]}},
@{Name="FreeGB";Expression={ [math]::round($_.Freespace/1gb,2)}},
@{Name="PctFree";Expression={[math]::round(($_.freespace/$_.size)*100,2)}}
 
}
 
#endregion
 
$fragments = @()
 
if (Test-Path $ImagePath) {
    #insert a graphic
    $ImageBits =  [Convert]::ToBase64String((Get-Content $ImagePath -Encoding Byte))
    $ImageFile = Get-Item $ImagePath
    $ImageType = $ImageFile.Extension.Substring(1) #strip off the leading .
    $ImageTag = "<Img src='data:image/$ImageType;base64,$($ImageBits)' Alt='$($ImageFile.Name)' style='float:left' width='120' height='120' hspace=10>"
}
else {
    Write-Warning "Could not find image file $ImagePath"
}
$top = @"
<table>
<tr>
<td class='transparent'>$ImageTag</td><td class='transparent'><H1>System Report - $Computername</H1></td>
</tr>
</table>
"@
 
$fragments+=$top
 
$fragments+="<a href='javascript:toggleAll();' title='Click to toggle all sections'>+/-</a>"
 
$Text = "Operating System"
$div = $Text.Replace(" ","_")
$fragments+= "<a href='javascript:toggleDiv(""$div"");' title='click to collapse or expand this section'><h2>$Text</h2></a><div id=""$div"">"
 
$fragments+= Get-Ciminstance -ClassName win32_operatingsystem -ComputerName $computername | 
Select @{Name="Operating System";Expression= {$_.Caption}},Version,InstallDate |
ConvertTo-Html -Fragment -As List
$fragments+="</div>"
 
$Text = "System Information"
$div = $Text.Replace(" ","_")
$fragments+= "<a href='javascript:toggleDiv(""$div"");' title='click to collapse or expand this section'><h2>$Text</h2></a><div id=""$div"">"
 
$fragments+= Get-systeminfo -Computername $computername| ConvertTo-Html -Fragment -As List
$fragments+="</div>"
 
$Text = "Disk Information"
$div = $Text.Replace(" ","_")
$fragments+= "<a href='javascript:toggleDiv(""$div"");' title='click to collapse or expand this section'><h2>$Text</h2></a><div id=""$div"">"
 
#highlight low free space in red
[xml]$html = Get-DiskInfo -Computername $computername| ConvertTo-Html -Fragment
for ($i=1;$i -le $html.table.tr.count-1;$i++) {
  if ($html.table.tr[$i].td[-1] -le 20) {
    $class = $html.CreateAttribute("class")
    $class.value = 'alert'
    $html.table.tr[$i].childnodes[3].attributes.append($class) | out-null
  }
}
 
$fragments+= $html.InnerXml
$fragments+="</div>"
 
$Text = "EventLog Info"
$div = $Text.Replace(" ","_")
$fragments+= "<a href='javascript:toggleDiv(""$div"");' title='click to collapse or expand this section'><h2>$Text</h2></a><div id=""$div"">"
 
[xml]$html  = Get-Eventlog -List -ComputerName $computername  | 
Select @{Name="Max(K)";Expression = {"{0:n0}" -f $_.MaximumKilobytes }},
@{Name="Retain";Expression = {$_.MinimumRetentionDays }},
OverFlowAction,@{Name="Entries";Expression = {"{0:n0}" -f $_.entries.count}},
@{Name="Log";Expression = {$_.LogDisplayname}} | ConvertTo-Html -Fragment
 
for ($i=1;$i -le $html.table.tr.count-1;$i++) {
  if ($html.table.tr[$i].td[3] -eq 0) {
    $class = $html.CreateAttribute("class")
    $class.value = 'alert'
    $html.table.tr[$i].attributes.append($class) | out-null
  }
}
 
$fragments+= $html.InnerXml
$fragments+="</div>"
 
$fragments+= "<p class='footer'>$(get-date)</p>"
 
 
$head = @"
<Title>System Report - $($env:computername)</Title>
<style>
body { background-color:#E5E4E2;
       font-family:Monospace;
       font-size:10pt; }
td, th { border:0px solid black; 
         border-collapse:collapse;
         white-space:pre; }
th { color:white;
     background-color:black; }
table, tr, td, th { padding: 2px; margin: 0px ;white-space:pre; }
tr:nth-child(odd) {background-color: lightgray}
table { width:95%;margin-left:5px; margin-bottom:20px;}
h2 {
 font-family:Tahoma;
 color:#6D7B8D;
}
.alert {
 color: red; 
 }
.footer 
{ color:green; 
  margin-left:10px; 
  font-family:Tahoma;
  font-size:8pt;
  font-style:italic;
}
.transparent {
background-color:#E5E4E2;
}
 
</style>
<script type='text/javascript' src='https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js'>
</script>
<script type='text/javascript'>
function toggleDiv(divId) {
   `$("#"+divId).toggle();
}
function toggleAll() {
    var divs = document.getElementsByTagName('div');
    for (var i = 0; i < divs.length; i++) {
        var div = divs[i];
        `$("#"+div.id).toggle();
    }
}
</script>
 
"@
 
 
$convertParams = @{ 
  head = $head 
  body = $fragments
}
 
convertto-html @convertParams | out-file -FilePath $Path
 
Get-Item -Path $Path