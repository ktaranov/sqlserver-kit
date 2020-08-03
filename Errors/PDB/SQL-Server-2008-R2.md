# SQL Server 2008 R2 SP3 Security update January 6, 2018 - 10.50.6560.0 - x64 (4057113)
``` powershell
# SQL Server 2008 R2 SP3 Security update January 6, 2018 - 10.50.6560.0 - x64 (4057113)
$outputFolder = 'c:\sqlsyms\10.50.6560.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/b981ac9f18d144989cdc934947f492811/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2009.0100.6560.00 ((KJ_SP3_QFE-OD).171228-1456 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/9e7a839d91dd474a8631dfef6abca4501/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2009.0100.6560.00 ((KJ_SP3_QFE-OD).171228-1456 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/cc4bfc0743fc46b392fa0fdb7c7826452/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2009.0100.6560.00 ((KJ_SP3_QFE-OD).171228-1456 )
```

# SQL Server 2008 R2 SP3 Security update January 6, 2018 - 10.50.6560.0 - x86 (4057113)
``` powershell
# SQL Server 2008 R2 SP3 Security update January 6, 2018 - 10.50.6560.0 - x86 (4057113)
$outputFolder = 'c:\sqlsyms\10.50.6560.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/ef09e694a6c54677a0e350aa61328a851/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2009.0100.6560.00 ((KJ_SP3_QFE-OD).171228-1537 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/a0dd581a069a4f46892922b421e679d41/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2009.0100.6560.00 ((KJ_SP3_QFE-OD).171228-1537 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/31933e3ce06745e1a57659e51088a0082/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2009.0100.6560.00 ((KJ_SP3_QFE-OD).171228-1537 )
```

# SQL Server 2008 R2 SP3 Hotfix KB 3146034 - 10.50.6542.0 - x64 (3146034)
``` powershell
# SQL Server 2008 R2 SP3 Hotfix KB 3146034 - 10.50.6542.0 - x64 (3146034)
$outputFolder = 'c:\sqlsyms\10.50.6542.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/4f088282518843b79e0478994de908221/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2009.0100.6542.00 ((KJ_SP3_QFE-OD).160222-1803 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/ded28d8ceae641748aec32fb45cb2b451/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2009.0100.6542.00 ((KJ_SP3_QFE-OD).160222-1803 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/1efb80e5273747c397f6185ab6670c9d2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2009.0100.6542.00 ((KJ_SP3_QFE-OD).160222-1803 )
```

# SQL Server 2008 R2 SP3 Hotfix KB 3146034 - 10.50.6542.0 - x86 (3146034)
``` powershell
# SQL Server 2008 R2 SP3 Hotfix KB 3146034 - 10.50.6542.0 - x86 (3146034)
$outputFolder = 'c:\sqlsyms\10.50.6542.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/989ad268055f459aa1fd4d1eea34c6ae1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2009.0100.6542.00 ((KJ_SP3_QFE-OD).160222-1804 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/569d9d76538b4106a8c414bf7dcdbe511/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2009.0100.6542.00 ((KJ_SP3_QFE-OD).160222-1804 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/33f28fb385a04fd5afdc44264428efcb2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2009.0100.6542.00 ((KJ_SP3_QFE-OD).160222-1804 )
```

# SQL Server 2008 R2 SP3 MS15-058: Security update QFE: July 14, 2015 - 10.50.6529.0 - x64 (3045314)
``` powershell
# SQL Server 2008 R2 SP3 MS15-058: Security update QFE: July 14, 2015 - 10.50.6529.0 - x64 (3045314)
$outputFolder = 'c:\sqlsyms\10.50.6529.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/6fd8bc7e6da241f9acfef95aa7529e671/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2009.0100.6529.00 ((KJ_SP3_QFE-OD).150319-1313 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/afa19b0c44e54bef8028f5aae687c1751/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2009.0100.6529.00 ((KJ_SP3_QFE-OD).150319-1313 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/282885315f3e4925a0753fdd1e2eae612/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2009.0100.6529.00 ((KJ_SP3_QFE-OD).150319-1313 )
```

# SQL Server 2008 R2 SP3 MS15-058: Security update QFE: July 14, 2015 - 10.50.6529.0 - x86 (3045314)
``` powershell
# SQL Server 2008 R2 SP3 MS15-058: Security update QFE: July 14, 2015 - 10.50.6529.0 - x86 (3045314)
$outputFolder = 'c:\sqlsyms\10.50.6529.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/57832ff449b14214bfbb5b3976147d2c1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2009.0100.6529.00 ((KJ_SP3_QFE-OD).150319-1314 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/bb45c06675b04636aeaa71423c08c0bd1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2009.0100.6529.00 ((KJ_SP3_QFE-OD).150319-1314 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/37b52eaf08284c23bdfda05c7b5bd0f52/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2009.0100.6529.00 ((KJ_SP3_QFE-OD).150319-1314 )
```

# SQL Server 2008 R2 SP3 Hotfix KB3033860 - 10.50.6525.0 - x64 (3033860)
``` powershell
# SQL Server 2008 R2 SP3 Hotfix KB3033860 - 10.50.6525.0 - x64 (3033860)
$outputFolder = 'c:\sqlsyms\10.50.6525.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/fd1e350610034849822cdb74a90e3f4a1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2009.0100.6525.00 ((KJ_SP3_QFE-OD).150123-1315 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/8e5d923c1e744b2395d0faebb7b27aed1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2009.0100.6525.00 ((KJ_SP3_QFE-OD).150123-1315 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/a80a08b5910a4b7c81bca4f7ea5737cb2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2009.0100.6525.00 ((KJ_SP3_QFE-OD).150123-1315 )
```

# SQL Server 2008 R2 SP3 Hotfix KB3033860 - 10.50.6525.0 - x86 (3033860)
``` powershell
# SQL Server 2008 R2 SP3 Hotfix KB3033860 - 10.50.6525.0 - x86 (3033860)
$outputFolder = 'c:\sqlsyms\10.50.6525.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/5705adbab9074c1a8aa3f8086b0b9e351/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2009.0100.6525.00 ((KJ_SP3_QFE-OD).150123-1339 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/24b6b9fb3e3248459032337981a515701/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2009.0100.6525.00 ((KJ_SP3_QFE-OD).150123-1339 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/41239188b6494cedb627d7bb0a7bd2a12/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2009.0100.6525.00 ((KJ_SP3_QFE-OD).150123-1339 )
```

# SQL Server 2008 R2 SP3 SP3 - 10.50.6000.34 - x64 (2979597)
``` powershell
# SQL Server 2008 R2 SP3 SP3 - 10.50.6000.34 - x64 (2979597)
$outputFolder = 'c:\sqlsyms\10.50.6000.34\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/bf37a41b8a974a9a90ac6aaef464011a1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2009.0100.6000.034 ((KJ_SP3).140819-1214 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/21cf8932b0184570858de406b79475031/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2009.0100.6000.034 ((KJ_SP3).140819-1214 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/293c90c8918b4aaaa39ea16237b39eff2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2009.0100.6000.034 ((KJ_SP3).140819-1214 )
```

# SQL Server 2008 R2 SP3 SP3 - 10.50.6000.34 - x86 (2979597)
``` powershell
# SQL Server 2008 R2 SP3 SP3 - 10.50.6000.34 - x86 (2979597)
$outputFolder = 'c:\sqlsyms\10.50.6000.34\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/2a05437dc1204cff970a2275d6335ada1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2009.0100.6000.034 ((KJ_SP3).140819-1213 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/682d729f9e6e43f3a47a9c158e905e171/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2009.0100.6000.034 ((KJ_SP3).140819-1213 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/5b7a3d00503e4924bd365f20b6ea87642/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2009.0100.6000.034 ((KJ_SP3).140819-1213 )
```

