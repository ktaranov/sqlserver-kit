<#============================================================================
  File:     Get-MachineInformationExcel.ps
 
  Summary:  Get machine information like memory, CPU and disk configuration
            and output it to Excel
 
------------------------------------------------------------------------------
  Written by Sander Stad, SQLStad.nl
 
  (c) 2015, SQLStad.nl. All rights reserved.
 
  For more scripts and sample code, check out http://www.SQLStad.nl
 
  You may alter this code for your own *non-commercial* purposes (e.g. in a
  for-sale commercial tool). Use in your own environment is encouraged.
  You may republish altered code as long as you include this copyright and
  give due credit, but you must obtain prior permission before blogging
  this code.
 
  THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF
  ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED
  TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
  PARTICULAR PURPOSE.
============================================================================#>

# Import the Excel library
Import-Module ExcelPSLib -Force
Import-Module PSSQLLib -Force

CLS

function Generate-Documentation()
{
    param(
        [Parameter(Mandatory=$true, Position=1)]
        [ValidateNotNullOrEmpty()]
        [string]$server,
        [Parameter(Mandatory=$true, Position=2)]
        [string]$instance = '',
        [Parameter(Mandatory=$true, Position=3)]
        [ValidateNotNullOrEmpty()]
        [string]$destination
    )

    # Make up the target in case we have a default instance
    if(($instance -eq '') -or (($instance).ToUpper() -eq 'MSSQLSERVER'))
    {
        $target = $server
    } 
    else
    {
        $target = "$server\$instance"
    }

    Write-Host "Setting up components for $target" -ForegroundColor Green

    # Create timestamp
    $timestamp = Get-Date -f yyyyddMMHHmmss

    # Set the destination
    $outputFile = $destination + '\MachineInformation_' + ($server).ToUpper() + '_' + ($instance).ToUpper() + '_' + $timestamp + '.xlsx'

    # Set the position of the first row
    $rowPosition = 1

    # Set the number of the tab
    $tabPosition = 1

    # Create a new Excel package
    [OfficeOpenXml.ExcelPackage]$excel = New-OOXMLPackage -author "Sander Stad" -title "Machine Information $target"

    # Create a new workbook
    [OfficeOpenXml.ExcelWorkbook]$book = $excel | Get-OOXMLWorkbook

    # Set the different styles
    $styleGreen = New-OOXMLStyleSheet -WorkBook $book -Name "GirlStyle" -Bold -ForeGroundColor Black -FillType Solid -BackGroundColor Green -borderStyle Thin -BorderColor Black -NFormat "#,##0.00"
    $styleRed = New-OOXMLStyleSheet -WorkBook $book -Name "BoyStyle" -Bold -ForeGroundColor Black -FillType Solid -BackGroundColor Red -borderStyle Thin -BorderColor Black -NFormat "#,##0.00"
    $styleHeader = New-OOXMLStyleSheet -WorkBook $book -Name "HeaderStyle" -Bold -ForeGroundColor White -BackGroundColor Black -Size 12 -HAlign Center -VAlign Center -FillType Solid
    $styleHeader2 = New-OOXMLStyleSheet -WorkBook $book -Name "HeaderStyle2" -Bold -ForeGroundColor White -BackGroundColor Black -Size 11 -HAlign Left -VAlign Center -FillType Solid
    $styleNormal = New-OOXMLStyleSheet -WorkBook $book -Name "NormalStyle" -borderStyle Thin -BorderColor Black
    $styleNumber = New-OOXMLStyleSheet -WorkBook $book -Name "Float" -NFormat "#,##0.00"
    $styleConditionalFormatting = New-OOXMLStyleSheet -WorkBook $book -Name "ConditionalF" -Bold -ForeGroundColor Black -FillType Solid -BackGroundColor Orange -borderStyle Double -BorderColor Blue -NFormat "#,##0.0000" -Italic

    Write-Host "Start retrieving data for $target" -ForegroundColor Green

    #######################################################################################################
	# SYSTEM INFORMATION
    #######################################################################################################

    # Add a worksheet
    $excel | Add-OOXMLWorksheet -WorkSheetName "System Information"
    # Set the worksheet as the first sheet
    $sheet = $book | Select-OOXMLWorkSheet -WorkSheetNumber $tabPosition

    Write-Host " - Retrieving data for System Information" -ForegroundColor Green

    # Get the data from the function
    $data = $null
    $data = Get-HostSystemInformation -hst $server

    if($data.Name.Length -ge 1)
    {

        # Fill the sheet with data from the system function
        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value "Server Name" -StyleSheet $styleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $data.Name -StyleSheet $styleNormal | Out-Null

        $sheet.Column(1).Width = 30
        $sheet.Column(2).Width = 40
        $rowPosition++

        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value "Domain" -StyleSheet $styleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $data.Domain -StyleSheet $styleNormal | Out-Null
    
        $rowPosition++

        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value "Manufacturer" -StyleSheet $styleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $data.Manufacturer -StyleSheet $styleNormal | Out-Null
    
        $rowPosition++

        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value "Model" -StyleSheet $styleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $data.Model -StyleSheet $styleNormal | Out-Null
    
        $rowPosition++

        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value "Number of logical processors" -StyleSheet $styleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $data.NumberOfLogicalProcessors -StyleSheet $styleNormal | Out-Null
    
        $rowPosition++

        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value "Number of processors" -StyleSheet $styleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $data.NumberOfProcessors -StyleSheet $styleNormal | Out-Null

        $rowPosition++

        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value "Last load info" -StyleSheet $styleHeader2 | Out-Null
        if([string]::IsNullOrEmpty($data.LastLoadInfo))
        {
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value '' -StyleSheet $styleNormal | Out-Null
        }
        else
        {
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $data.LastLoadInfo -StyleSheet $styleNormal | Out-Null
        }
    
        $rowPosition++

        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value "Total physical memory MB" -StyleSheet $styleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $data.TotalPhysicalMemoryMB -StyleSheet $styleNormal | Out-Null
    }
    else
    {
        Write-Host "No records fount for System Information" -ForegroundColor Red
    }

    #######################################################################################################
    #######################################################################################################


    #######################################################################################################
	# OPERATING SYSTEM INFORMATION
    #######################################################################################################
    
    # Reset row positions
    $rowPosition = 1

    # Set the tabposition
    $tabPosition++

    # Add a worksheet
    $excel | Add-OOXMLWorksheet -WorkSheetName "Operating System"
    # Set the worksheet as the first sheet
    $sheet = $book | Select-OOXMLWorkSheet -WorkSheetNumber $tabPosition

    Write-Host " - Retrieving data for Operating System" -ForegroundColor Green

    # Get the data from the function
    $data = $null
    $data = Get-HostOperatingSystem -hst $server
	
    if($data.OSArchitecture.Length -ge 1)
    {

	    # Fill the sheet with data from the hardware function
        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value "OS Architecture" -StyleSheet $styleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $data.OSArchitecture -StyleSheet $styleNormal | Out-Null

        $sheet.Column(1).Width = 30
        $sheet.Column(2).Width = 40
        $rowPosition++

        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value "OS Language" -StyleSheet $styleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $data.OSLanguage -StyleSheet $styleNormal | Out-Null
    
        $rowPosition++

        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value "OS ProductSuite" -StyleSheet $styleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $data.OSProductSuite -StyleSheet $styleNormal | Out-Null
    
        $rowPosition++

        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value "OS Type" -StyleSheet $styleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $data.OSType -StyleSheet $styleNormal | Out-Null
    
        $rowPosition++

        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value "BuildType" -StyleSheet $styleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $data.BuildType -StyleSheet $styleNormal | Out-Null

        $rowPosition++

        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value "Version" -StyleSheet $styleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $data.Version -StyleSheet $styleNormal | Out-Null
	
	    $rowPosition++

        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value "Windows Directory" -StyleSheet $styleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $data.WindowsDirectory -StyleSheet $styleNormal | Out-Null
	
	    $rowPosition++

        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value "Free Physical Memory MB" -StyleSheet $styleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $data.FreePhysicalMemoryMB -StyleSheet $styleNormal | Out-Null

        $rowPosition++

        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value "Free Space In Paging Files MB" -StyleSheet $styleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $data.FreeSpaceInPagingFilesMB -StyleSheet $styleNormal | Out-Null

        $rowPosition++

        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value "Free Virtua lMemory MB" -StyleSheet $styleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $data.FreeVirtualMemoryMB -StyleSheet $styleNormal | Out-Null

        $rowPosition++

        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value "Service Pack Major Version" -StyleSheet $styleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $data.ServicePackMajorVersion -StyleSheet $styleNormal | Out-Null

        $rowPosition++

        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value "Service Pack Minor Version" -StyleSheet $styleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $data.ServicePackMinorVersion -StyleSheet $styleNormal | Out-Null
    }
    else
    {
        Write-Host "No records fount for Operating System" -ForegroundColor Red
    }

    #######################################################################################################
    #######################################################################################################


    #######################################################################################################
    # SQL SERVER SERVICES
    #######################################################################################################

    # Reset row positions
    $rowPosition = 1

    # Set the tabposition
    $tabPosition++

    # Add a worksheet
    $excel | Add-OOXMLWorksheet -WorkSheetName "SQL Services" #-AutofilterRange "A2:G2"
    # Set the worksheet as the first sheet
    $sheet = $book | Select-OOXMLWorkSheet -WorkSheetNumber $tabPosition

    Write-Host " - Retrieving data for SQL Server Services" -ForegroundColor Green

    # Get the data from the function
    $services = Get-HostSQLServerServices -hst $server

    if($services.Count -ge 1)
    {

        # Create the header
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 1 -value "System Name" -StyleSheet $StyleHeader2 | Out-Null
        $sheet.Column(1).Width = 22
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 2 -value "Display Name" -StyleSheet $StyleHeader2 | Out-Null
        $sheet.Column(2).Width = 32
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 3 -value "Service Name" -StyleSheet $StyleHeader2 | Out-Null
        $sheet.Column(3).Width = 22
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 4 -value "State" -StyleSheet $StyleHeader2 | Out-Null
        $sheet.Column(4).Width = 22
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 5 -value "Status" -StyleSheet $StyleHeader2 | Out-Null
        $sheet.Column(5).Width = 22
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 6 -value "Start Mode" -StyleSheet $StyleHeader2 | Out-Null
        $sheet.Column(6).Width = 22
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 7 -value "Start Name" -StyleSheet $StyleHeader2 | Out-Null
        $sheet.Column(7).Width = 32

        $rowPosition++

        foreach($service in $services)
        {
        
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value $service.SystemName -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $service.DisplayName -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 3 -value $service.Name -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 4 -value $service.State -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 5 -value $service.Status -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 6 -value $service.StartMode -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 7 -value $service.StartName -StyleSheet $styleNormal | Out-Null

            $rowPosition++
        }
    }
    else
    {
        Write-Host "No records fount for SQL Services" -ForegroundColor Red
    }

    #######################################################################################################
    #######################################################################################################

    #######################################################################################################
    # DISK INFORMATION
    #######################################################################################################

    # Reset row positions
    $rowPosition = 1

    # Set the tabposition
    $tabPosition++

    # Add a worksheet
    $excel | Add-OOXMLWorksheet -WorkSheetName "Disk Information" #-AutofilterRange "A2:G2"
    # Set the worksheet as the first sheet
    $sheet = $book | Select-OOXMLWorkSheet -WorkSheetNumber $tabPosition

    Write-Host " - Retrieving data for Disk Information" -ForegroundColor Green

    $disks = Get-HostHarddisk -hst $server

    if($disks.Count -ge 1)
    {

        # Create the header
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 1 -value "Disk" -StyleSheet $StyleHeader2 | Out-Null
        $sheet.Column(1).Width = 22
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 2 -value "Volume Name" -StyleSheet $StyleHeader2 | Out-Null
        $sheet.Column(2).Width = 32
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 3 -value "Free Space MB" -StyleSheet $StyleHeader2 | Out-Null
        $sheet.Column(3).Width = 22
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 4 -value "Size MB" -StyleSheet $StyleHeader2 | Out-Null
        $sheet.Column(4).Width = 22
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 5 -value "Percentage Used" -StyleSheet $StyleHeader2 | Out-Null
        $sheet.Column(5).Width = 22

        $rowPosition++

        foreach($disk in $disks)
        {
        
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value $disk.Disk -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $disk.VolumeName -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 3 -value $disk.FreeSpaceMB -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 4 -value $disk.SizeMB -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 5 -value $disk.PercentageUsed -StyleSheet $styleNormal | Out-Null

            $rowPosition++
        }
    }
    else
    {
        Write-Host "No records fount for Disk Information" -ForegroundColor Red
    }

    #######################################################################################################
    #######################################################################################################

    #######################################################################################################
    # SQL CONFIGURATION
    #######################################################################################################

    # Reset row positions
    $rowPosition = 1

    # Set the tabposition
    $tabPosition++

    # Add a worksheet
    $excel | Add-OOXMLWorksheet -WorkSheetName "Instance Configuration" #-AutofilterRange "A2:G2"
    # Set the worksheet as the first sheet
    $sheet = $book | Select-OOXMLWorkSheet -WorkSheetNumber $tabPosition

    Write-Host " - Retrieving data for SQL Configuration" -ForegroundColor Green

    $configurations = Get-SQLConfiguration -inst $target | Sort DisplayName

    if($configurations.Count -ge 1)
    {

        # Create the header
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 1 -value "Display Name" -StyleSheet $StyleHeader2 | Out-Null
        $sheet.Column(1).Width = 40
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 2 -value "Number" -StyleSheet $StyleHeader2 | Out-Null
        $sheet.Column(2).Width = 32
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 3 -value "Minimum" -StyleSheet $StyleHeader2 | Out-Null
        $sheet.Column(3).Width = 22
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 4 -value "Maximum" -StyleSheet $StyleHeader2 | Out-Null
        $sheet.Column(4).Width = 22
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 5 -value "Is Dynamic" -StyleSheet $StyleHeader2 | Out-Null
        $sheet.Column(5).Width = 22
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 6 -value "Is Advanced" -StyleSheet $StyleHeader2 | Out-Null
        $sheet.Column(6).Width = 22
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 7 -value "Description" -StyleSheet $StyleHeader2 | Out-Null
        $sheet.Column(7).Width = 50
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 8 -value "Run Value" -StyleSheet $StyleHeader2 | Out-Null
        $sheet.Column(8).Width = 22
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 9 -value "Config Value" -StyleSheet $StyleHeader2 | Out-Null
        $sheet.Column(9).Width = 22

        $rowPosition++

        foreach($config in $configurations)
        {
        
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value $config.DisplayName -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $config.Number -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 3 -value $config.Minimum -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 4 -value $config.Maximum -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 5 -value $config.IsDynamic -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 6 -value $config.IsAdvanced -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 7 -value $config.Description -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 8 -value $config.RunValue -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 9 -value $config.ConfigValue -StyleSheet $styleNormal | Out-Null

            $rowPosition++
        }
    }
    else
    {
        Write-Host "No records fount for Instance Configuration" -ForegroundColor Red
    }

    #######################################################################################################
    #######################################################################################################

    #######################################################################################################
    # DATABASES
    #######################################################################################################

    # Reset row positions
    $rowPosition = 1

    # Set the tabposition
    $tabPosition++

    # Add a worksheet
    $excel | Add-OOXMLWorksheet -WorkSheetName "Databases" #-AutofilterRange "A2:G2"
    # Set the worksheet as the first sheet
    $sheet = $book | Select-OOXMLWorkSheet -WorkSheetNumber $tabPosition

    Write-Host " - Retrieving data for Databases" -ForegroundColor Green

    $databases = Get-SQLDatabases -inst $target | Sort Name

    if($databases.Count -ge 1)
    {

        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 1 -value "Name" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 2 -value "ID" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 3 -value "AutoClose" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 4 -value "AutoCreateStatisticsEnabled" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 5 -value "AutoShrink" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 6 -value "AutoUpdateStatisticsAsync" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 7 -value "AutoUpdateStatisticsEnabled" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 8 -value "AvailabilityGroupName" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 9 -value "CloseCursorsOnCommitEnabled" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 10 -value "Collation" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 11 -value "CompatibilityLevel" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 12 -value "CreateDate" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 13 -value "DataSpaceUsage" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 14 -value "EncryptionEnabled" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 15 -value "IndexSpaceUsage" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 16 -value "IsDbSecurityAdmin" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 17 -value "IsFullTextEnabled" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 18 -value "IsManagementDataWarehouse" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 19 -value "IsMirroringEnabled" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 20 -value "LastBackupDate" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 21 -value "LastDifferentialBackupDate" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 22 -value "LastLogBackupDate" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 23 -value "Owner" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 24 -value "PageVerify" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 25 -value "PrimaryFilePath" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 26 -value "ReadOnly" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 27 -value "RecoveryModel" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 28 -value "RecursiveTriggersEnabled" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 29 -value "Size" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 30 -value "SnapshotIsolationState" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 31 -value "SpaceAvailable" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 32 -value "Status" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 33 -value "TargetRecoveryTime" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 34 -value "Trustworthy" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 35 -value "UserAccess" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 36 -value "UserName" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 37 -value "Version" -StyleSheet $StyleHeader2 | Out-Null

        $rowPosition++

        foreach($db in $databases)
        {
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value $db.Name -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $db.ID -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 3 -value $db.AutoClose -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 4 -value $db.AutoCreateStatisticsEnabled -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 5 -value $db.AutoShrink -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 6 -value $db.AutoUpdateStatisticsAsync -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 7 -value $db.AutoUpdateStatisticsEnabled -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 8 -value $db.AvailabilityGroupName -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 9 -value $db.CloseCursorsOnCommitEnabled -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 10 -value $db.Collation -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 11 -value $db.CompatibilityLevel -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 12 -value $db.CreateDate -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 13 -value $db.DataSpaceUsage -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 14 -value $db.EncryptionEnabled -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 15 -value $db.IndexSpaceUsage -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 16 -value $db.IsDbSecurityAdmin -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 17 -value $db.IsFullTextEnabled -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 18 -value $db.IsManagementDataWarehouse -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 19 -value $db.IsMirroringEnabled -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 20 -value $db.LastBackupDate -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 21 -value $db.LastDifferentialBackupDate -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 22 -value $db.LastLogBackupDate -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 23 -value $db.Owner -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 24 -value $db.PageVerify -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 25 -value $db.PrimaryFilePath -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 26 -value $db.ReadOnly -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 27 -value $db.RecoveryModel -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 28 -value $db.RecursiveTriggersEnabled -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 29 -value $db.Size -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 30 -value $db.SnapshotIsolationState -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 31 -value $db.SpaceAvailable -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 32 -value $db.Status -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 33 -value $db.TargetRecoveryTime -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 34 -value $db.Trustworthy -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 35 -value $db.UserAccess -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 36 -value $db.UserName -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 7 -value $db.Version -StyleSheet $styleNormal | Out-Null

            $rowPosition++
        }
    }
    else
    {
        Write-Host "No records fount for Databases" -ForegroundColor Red
    }

    #######################################################################################################
    #######################################################################################################

    #######################################################################################################
    # DATABASE FILES
    #######################################################################################################

    # Reset row positions
    $rowPosition = 1

    # Set the tabposition
    $tabPosition++

    # Add a worksheet
    $excel | Add-OOXMLWorksheet -WorkSheetName "Database Files" #-AutofilterRange "A2:G2"
    # Set the worksheet as the first sheet
    $sheet = $book | Select-OOXMLWorkSheet -WorkSheetNumber $tabPosition

    Write-Host " - Retrieving data for Database Files" -ForegroundColor Green

    $databaseFiles = Get-SQLDatabaseFiles -inst $target | Sort DatabaseName, FileType

    if($databaseFiles.Count -ge 1)
    {

        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 1 -value "Database Name" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 2 -value "Name" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 3 -value "File Type" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 4 -value "Directory" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 5 -value "File Name" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 6 -value "Growth" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 7 -value "Growth Type" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 8 -value "Size" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 9 -value "Used Space" -StyleSheet $StyleHeader2 | Out-Null

        $rowPosition++

        foreach($dbFile in $databaseFiles)
        {
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value $dbFile.DatabaseName -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $dbFile.Name -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 3 -value $dbFile.FileType -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 4 -value $dbFile.Directory -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 5 -value $dbFile.FileName -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 6 -value $dbFile.Growth -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 7 -value $dbFile.GrowthType -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 8 -value $dbFile.Size -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 9 -value $dbFile.UsedSpace -StyleSheet $styleNormal | Out-Null

            $rowPosition++
        }
    }
    else
    {
        Write-Host "No records fount for Database Files" -ForegroundColor Red
    }

    #######################################################################################################
    #######################################################################################################

    #######################################################################################################
    # DATABASE USERS
    #######################################################################################################

    # Reset row positions
    $rowPosition = 1

    # Set the tabposition
    $tabPosition++

    # Add a worksheet
    $excel | Add-OOXMLWorksheet -WorkSheetName "Database Users" #-AutofilterRange "A2:G2"
    # Set the worksheet as the first sheet
    $sheet = $book | Select-OOXMLWorkSheet -WorkSheetNumber $tabPosition

    Write-Host " - Retrieving data for Database Users" -ForegroundColor Green

    $users = Get-SQLDatabaseUsers -inst $target | Sort Parent,Name

    if($users.Count -ge 1)
    {

        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 1 -value "Parent" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 2 -value "Name" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 3 -value "AsymmetricKey" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 4 -value "AuthenticationType" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 5 -value "Certificate" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 6 -value "CreateDate" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 7 -value "DateLastModified" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 8 -value "DefaultSchema" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 9 -value "HasDBAccess" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 10 -value "ID" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 11 -value "IsSystemObject" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 12 -value "Login" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 13 -value "LoginType" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 14 -value "UserType" -StyleSheet $StyleHeader2 | Out-Null

        $rowPosition++

        foreach($user in $users)
        {

            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value $user.Parent -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $user.Name -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 3 -value $user.AsymmetricKey -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 4 -value $user.AuthenticationType -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 5 -value $user.Certificate -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 6 -value $user.CreateDate -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 7 -value $user.DateLastModified -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 8 -value $user.DefaultSchema -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 9 -value $user.HasDBAccess -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 10 -value $user.ID -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 11 -value $user.IsSystemObject -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 12 -value $user.Login -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 13 -value $user.LoginType -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 14 -value $user.UserType -StyleSheet $styleNormal | Out-Null

            $rowPosition++
    
        }
    }
    else
    {
        Write-Host "No records fount for Database Users" -ForegroundColor Red
    }

    #######################################################################################################
    #######################################################################################################

    #######################################################################################################
    # DATABASE PRIVILEGES
    #######################################################################################################

    # Reset row positions
    $rowPosition = 1

    # Set the tabposition
    $tabPosition++

    # Add a worksheet
    $excel | Add-OOXMLWorksheet -WorkSheetName "Database Privileges" #-AutofilterRange "A2:G2"
    # Set the worksheet as the first sheet
    $sheet = $book | Select-OOXMLWorkSheet -WorkSheetNumber $tabPosition

    Write-Host " - Retrieving data for Database Privileges" -ForegroundColor Green

    $data = Get-SQLDatabasePrivileges -inst $target | Sort DatabaseName, LoginName

    if($data.Count -ge 1)
    {

        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 1 -value "Database Name" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 2 -value "User Name" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 3 -value "User Type" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 4 -value "Database Roles" -StyleSheet $StyleHeader2 | Out-Null

        $rowPosition++

        foreach($dbPriv in $data)
        {
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value $dbPriv.DatabaseName -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $dbPriv.UserName -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 3 -value $dbPriv.UserType -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 4 -value $dbPriv.DatabaseRoles -StyleSheet $styleNormal | Out-Null

            $rowPosition++
        }
    }
    else
    {
        Write-Host "No records fount for Database Privileges" -ForegroundColor Red
    }

    #######################################################################################################
    #######################################################################################################

    #######################################################################################################
    # SERVER PRIVILEGES
    #######################################################################################################

    # Reset row positions
    $rowPosition = 1

    # Set the tabposition
    $tabPosition++

    # Add a worksheet
    $excel | Add-OOXMLWorksheet -WorkSheetName "Login Privileges" #-AutofilterRange "A2:G2"
    # Set the worksheet as the first sheet
    $sheet = $book | Select-OOXMLWorkSheet -WorkSheetNumber $tabPosition

    Write-Host " - Retrieving data for SQL Server Privileges" -ForegroundColor Green

    $privileges = Get-SQLServerPrivileges -inst $target | Sort Name

    if($privileges.Count -ge 1)
    {
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 1 -value "Name" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 2 -value "Login Type" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 3 -value "Create Date" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 4 -value "Date Last Modified" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 5 -value "Is Disabled" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 6 -value "Serve rRoles" -StyleSheet $StyleHeader2 | Out-Null

        $rowPosition++

        foreach($priv in $privileges)
        {
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value $priv.Name -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $priv.LoginType -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 3 -value $priv.CreateDate -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 4 -value $priv.DateLastModified -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 5 -value $priv.IsDisabled -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 6 -value $priv.ServerRoles -StyleSheet $styleNormal | Out-Null

            $rowPosition++    
        }
    }
    else
    {
        Write-Host "No records fount for SQL Server Privileges" -ForegroundColor Red
    }

    #######################################################################################################
    #######################################################################################################

    #######################################################################################################
    # AGENT JOBS
    #######################################################################################################

    # Reset row positions
    $rowPosition = 1

    # Set the tabposition
    $tabPosition++

    # Add a worksheet
    $excel | Add-OOXMLWorksheet -WorkSheetName "Agent Jobs" #-AutofilterRange "A2:G2"
    # Set the worksheet as the first sheet
    $sheet = $book | Select-OOXMLWorkSheet -WorkSheetNumber $tabPosition

    Write-Host " - Retrieving data for Agent Jobs" -ForegroundColor Green

    $jobs = Get-SQLAgentJobs -inst $target | Sort Name

    if($jobs.Count -ge 1)
    {
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 1 -value "Name" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 2 -value "Description" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 3 -value "Parent" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 4 -value "Category" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 5 -value "CategoryType" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 6 -value "DateCreated" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 7 -value "DateLastModified" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 8 -value "DeleteLevel" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 9 -value "EmailLevel" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 10 -value "EventLogLevel" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 11 -value "HasSchedule" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 12 -value "HasServer" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 13 -value "HasStep" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 14 -value "IsEnabled" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 15 -value "JobID" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 16 -value "JobType" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 17 -value "LastRunDate" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 18 -value "LastRunOutcome" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 19 -value "NetSendLevel" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 20 -value "NextRunDate" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 21 -value "NextRunScheduleID" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 22 -value "OperatorToEmail" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 23 -value "OperatorToNetSend" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 24 -value "OperatorToPage" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 25 -value "OriginatingServer" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 26 -value "OwnerLoginName" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 27 -value "PageLevel" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 28 -value "StartStepID" -StyleSheet $StyleHeader2 | Out-Null
        $sheet | Set-OOXMLRangeValue -row $RowPosition -col 29 -value "VersionNumber" -StyleSheet $StyleHeader2 | Out-Null
        
        $rowPosition++

        foreach($job in $jobs)
        {
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 1 -value $job.Name -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 2 -value $job.Description -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 3 -value $job.Parent -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 4 -value $job.Category -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 5 -value $job.CategoryType -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 6 -value $job.DateCreated -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 7 -value $job.DateLastModified -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 8 -value $job.DeleteLevel -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 9 -value $job.EmailLevel -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 10 -value $job.EventLogLevel -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 11 -value $job.HasSchedule -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 12 -value $job.HasServer -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 13 -value $job.HasStep -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 14 -value $job.IsEnabled -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 15 -value $job.JobID -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 16 -value $job.JobType -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 17 -value $job.LastRunDate -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 18 -value $job.LastRunOutcome -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 19 -value $job.NetSendLevel -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 20 -value $job.NextRunDate -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 21 -value $job.NextRunScheduleID -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 22 -value $job.OperatorToEmail -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 23 -value $job.OperatorToNetSend -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 24 -value $job.OperatorToPage -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 25 -value $job.OriginatingServer -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 26 -value $job.OwnerLoginName -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 27 -value $job.PageLevel -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 28 -value $job.StartStepID -StyleSheet $styleNormal | Out-Null
            $sheet | Set-OOXMLRangeValue -row $rowPosition -col 29 -value $job.VersionNumber -StyleSheet $styleNormal | Out-Null

            $rowPosition++    
        }
    }
    else
    {
        Write-Host "No records fount for Agent Jobs" -ForegroundColor Red
    }

    #######################################################################################################
    #######################################################################################################

    $excel | Save-OOXMLPackage -FileFullPath $outputFile -Dispose
}

$items = Import-Csv "c:\sqlserverinstances.csv" -Delimiter ";"

foreach($item in $items)
{
    if(Test-Connection $item.ComputerName)
    {
        Generate-Documentation -server $item.ComputerName -instance $item.SQLServerInstanceName -destination 'H:\Mijn documenten\_Overdracht\Databasebeheer\SQL Server Inventarisatie'
    }
}
