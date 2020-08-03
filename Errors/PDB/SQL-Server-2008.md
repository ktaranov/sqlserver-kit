# SQL Server 2008 SP4 Security update January 6, 2018 - 10.0.6556.0 - x64 (4057114)
``` powershell
# SQL Server 2008 SP4 Security update January 6, 2018 - 10.0.6556.0 - x64 (4057114)
$outputFolder = 'c:\sqlsyms\10.0.6556.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/eaa1a756484a4f95bc6896b8529c11701/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2007.0100.6556.00 ((Katmai_SP4_QFE-OD).171228-1515 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/2155ad0fe0a045e38b33e3f36bdb6a211/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2007.0100.6556.00 ((Katmai_SP4_QFE-OD).171228-1515 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/48e9083d8d21441fb77939286bcc001d2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2007.0100.6556.00 ((Katmai_SP4_QFE-OD).171228-1515 )
```

# SQL Server 2008 SP4 Security update January 6, 2018 - 10.0.6556.0 - x86 (4057114)
``` powershell
# SQL Server 2008 SP4 Security update January 6, 2018 - 10.0.6556.0 - x86 (4057114)
$outputFolder = 'c:\sqlsyms\10.0.6556.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/1401bf04646b4e409d7b7a4fc0644fa81/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2007.0100.6556.00 ((Katmai_SP4_QFE-OD).171228-1515 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/dacb0afbc1334010a573e48736ba72ad1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2007.0100.6556.00 ((Katmai_SP4_QFE-OD).171228-1515 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/bd167760b8344d3f90608a2c18cf40092/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2007.0100.6556.00 ((Katmai_SP4_QFE-OD).171228-1515 )
```

# SQL Server 2008 SP4 Hotfix KB3146034 - 10.0.6547.0 - x64 (3146034)
``` powershell
# SQL Server 2008 SP4 Hotfix KB3146034 - 10.0.6547.0 - x64 (3146034)
$outputFolder = 'c:\sqlsyms\10.0.6547.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/e5191b6b180941edb5a20276f9a0384e1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2007.0100.6547.00 ((Katmai_SP4_QFE-OD).160222-1900 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/8fc01c8d34354aa088a13f9c071ebb611/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2007.0100.6547.00 ((Katmai_SP4_QFE-OD).160222-1900 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/3b1145daf61646efbfb3d93ef8948e612/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2007.0100.6547.00 ((Katmai_SP4_QFE-OD).160222-1900 )
```

# SQL Server 2008 SP4 Hotfix KB3146034 - 10.0.6547.0 - x86 (3146034)
``` powershell
# SQL Server 2008 SP4 Hotfix KB3146034 - 10.0.6547.0 - x86 (3146034)
$outputFolder = 'c:\sqlsyms\10.0.6547.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/b37439c8c52c4952845b150ffd7732af1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2007.0100.6547.00 ((Katmai_SP4_QFE-OD).160222-1901 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/d1c5577343cb4ed8bbc36832eb826afc1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2007.0100.6547.00 ((Katmai_SP4_QFE-OD).160222-1901 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/5bd7009e0fcf4b74b69a23467963dfb42/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2007.0100.6547.00 ((Katmai_SP4_QFE-OD).160222-1901 )
```

# SQL Server 2008 SP4 QFE for MS15-058 - 10.0.6535.0 - x64 (3045308)
``` powershell
# SQL Server 2008 SP4 QFE for MS15-058 - 10.0.6535.0 - x64 (3045308)
$outputFolder = 'c:\sqlsyms\10.0.6535.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/2e97b3df36eb4e7fb0ec16f0ba82bd031/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2007.0100.6535.00 ((Katmai_SP4_QFE-OD).150417-1943 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/9bea90cfba544af19a1cf11d034abc001/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2007.0100.6535.00 ((Katmai_SP4_QFE-OD).150417-1943 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/b579d44345e44607a12a9d0d448b7ab42/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2007.0100.6535.00 ((Katmai_SP4_QFE-OD).150417-1943 )
```

# SQL Server 2008 SP4 QFE for MS15-058 - 10.0.6535.0 - x86 (3045308)
``` powershell
# SQL Server 2008 SP4 QFE for MS15-058 - 10.0.6535.0 - x86 (3045308)
$outputFolder = 'c:\sqlsyms\10.0.6535.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/33fe9f06c7b944668d174d77d64fd2051/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2007.0100.6535.00 ((Katmai_SP4_QFE-OD).150417-2008 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/688c68ac33c5460894783989531e65431/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2007.0100.6535.00 ((Katmai_SP4_QFE-OD).150417-2008 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/7b8f66e87c4c4afd995254a5b2e5083a2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2007.0100.6535.00 ((Katmai_SP4_QFE-OD).150417-2008 )
```

# SQL Server 2008 SP4 Hotfix KB3034373 - 10.0.6526.0 - x64 (3034373)
``` powershell
# SQL Server 2008 SP4 Hotfix KB3034373 - 10.0.6526.0 - x64 (3034373)
$outputFolder = 'c:\sqlsyms\10.0.6526.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/85dd188f10df47c0a6b57c70ead0b5c01/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2007.0100.6526.00 ((Katmai_SP4_QFE-OD).150123-1208 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/7c4f51489d884394b902225c7f2b80891/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2007.0100.6526.00 ((Katmai_SP4_QFE-OD).150123-1208 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/422c51381bc04a7fa2b9bd7fe9b04ca32/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2007.0100.6526.00 ((Katmai_SP4_QFE-OD).150123-1208 )
```

# SQL Server 2008 SP4 Hotfix KB3034373 - 10.0.6526.0 - x86 (3034373)
``` powershell
# SQL Server 2008 SP4 Hotfix KB3034373 - 10.0.6526.0 - x86 (3034373)
$outputFolder = 'c:\sqlsyms\10.0.6526.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/913da3830d16455eadff72481f3179401/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2007.0100.6526.00 ((Katmai_SP4_QFE-OD).150123-1211 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/901456d096344ca5bd6a117025a412461/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2007.0100.6526.00 ((Katmai_SP4_QFE-OD).150123-1211 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/3b31c12ff4134cc3afb773e8a830896b2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2007.0100.6526.00 ((Katmai_SP4_QFE-OD).150123-1211 )
```

# SQL Server 2008 SP4 Security Update MS15-058 July 14, 2015 - 10.0.6241.0 - x64 (3045311)
``` powershell
# SQL Server 2008 SP4 Security Update MS15-058 July 14, 2015 - 10.0.6241.0 - x64 (3045311)
$outputFolder = 'c:\sqlsyms\10.0.6241.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/f667598776444a32942ee049bcb442241/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2007.0100.6241.00 ((Katmai_SP4_GDR).150417-1051 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/de19a5bdf857430d9c4a6650dd7667401/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2007.0100.6241.00 ((Katmai_SP4_GDR).150417-1051 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/8d79f55153d444be9a35cc7969cd4c702/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2007.0100.6241.00 ((Katmai_SP4_GDR).150417-1051 )
```

# SQL Server 2008 SP4 Security Update MS15-058 July 14, 2015 - 10.0.6241.0 - x86 (3045311)
``` powershell
# SQL Server 2008 SP4 Security Update MS15-058 July 14, 2015 - 10.0.6241.0 - x86 (3045311)
$outputFolder = 'c:\sqlsyms\10.0.6241.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/7ad87780f3a54788a6fd32f946f1e4751/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2007.0100.6241.00 ((Katmai_SP4_GDR).150417-1052 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/257c88a2ab974c1abcb621bd9f7854ad1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2007.0100.6241.00 ((Katmai_SP4_GDR).150417-1052 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/20ee497f35de471ab067178d8fcfb3572/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2007.0100.6241.00 ((Katmai_SP4_GDR).150417-1052 )
```

# SQL Server 2008 SP4 SP4 - 10.0.6000.29 - x64 (2979597)
``` powershell
# SQL Server 2008 SP4 SP4 - 10.0.6000.29 - x64 (2979597)
$outputFolder = 'c:\sqlsyms\10.0.6000.29\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/fc69079383a34f3b9338254f34b07e531/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2007.0100.6000.029 ((Katmai_SP4).140903-0405)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/116e643b4d7d48dd9c987a2570bf124b1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2007.0100.6000.029 ((Katmai_SP4).140902-2248 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/d7f4aeaf89544a098f18dbaa4405a1802/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2007.0100.6000.029 ((Katmai_SP4).140903-0405)
```

# SQL Server 2008 SP4 SP4 - 10.0.6000.29 - x86 (2979597)
``` powershell
# SQL Server 2008 SP4 SP4 - 10.0.6000.29 - x86 (2979597)
$outputFolder = 'c:\sqlsyms\10.0.6000.29\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/220547919ebf4ea4a9dc6ad770f2a97b1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2007.0100.6000.029 ((Katmai_SP4).140902-2247 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/8967aa50a6e147858de6bdf0ca51712b1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2007.0100.6000.029 ((Katmai_SP4).140902-2247 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/1c4ac2e980b444129c6512bc9c9377802/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2007.0100.6000.029 ((Katmai_SP4).140902-2247 )
```

