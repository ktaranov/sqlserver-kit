#Requires -module dbatools

<# 
.SYNOPSIS
    Compare settings for production and development SQL Server instance
 
.PARAMETER $productionName
    Production server name

.PARAMETER $productionName
    Production server name

.NOTE
Original link: https://therestisjustcode.wordpress.com/2017/09/12/t-sql-tuesday-94-automating-configuration-comparison/
Author: Andy Levy
Modified: Konstantin Taranov 2017-09-20
#>

$productionName  = 'localhost';
$developmentName = 'localhost';

$ProductionConfiguration  = Get-DbaSpConfigure -ServerInstance $productionName;
# -SqlCredential (Get-Credential -Message "Production Credentials" -UserName MySQLLogin);
$DevelopmentConfiguration = Get-DbaSpConfigure -ServerInstance $developmentName;
Compare-Object -ReferenceObject $DevelopmentConfiguration -DifferenceObject $ProductionConfiguration -property ConfigName, RunningValue | Sort-Object ConfigName;
