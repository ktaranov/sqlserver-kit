# SQL Server 2014 SP3 Security update - 12.0.6372.1 - x64 (KB4535288)
``` powershell
# SQL Server 2014 SP3 Security update - 12.0.6372.1 - x64 (KB4535288)
$outputFolder = 'c:\sqlsyms\12.0.6372.1\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/58e64a3a589647efb0962ea0b54a4f802/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.6372.01 ((SQL14_SP3_QFE-OD).191212-1438)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/4c0bcc7afda04998a4cb7e0bfdb736792/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.6372.01 ((SQL14_SP3_QFE-OD).191212-1438)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/7c6006d90ec04c61ba245a22fba604112/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.6372.01 ((SQL14_SP3_QFE-OD).191212-1438)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/34148353e4e245728f03ab52442361702/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.6372.01 ((SQL14_SP3_QFE-OD).191212-1438)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/fdbeff4d6d474008a694cd69c38acff72/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.6372.01 ((SQL14_SP3_QFE-OD).191212-1438)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/e82e0bf323c44a328f1dff97e18643ea2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.6372.01 ((SQL14_SP3_QFE-OD).191212-1438)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/ee0aebf1bb054cf7bf1a02b9967cb1941/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.6372.01 ((SQL14_SP3_QFE-OD).191212-1438)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/37659ab76c0746f59df1383528780d091/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.6372.01 ((SQL14_SP3_QFE-OD).191212-1438)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/d5b8297e63ee412bacb678e15142c6e61/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.6372.01 ((SQL14_SP3_QFE-OD).191212-1438)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/e541cd3097054c21bae4d0f56206a5d81/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.6372.01 ((SQL14_SP3_QFE-OD).191212-1438)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/9d8cfaa7d57c414eb326f3d248345f4a2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.6372.01 ((SQL14_SP3_QFE-OD).191212-1438)
```

# SQL Server 2014 SP3 Security update - 12.0.6372.1 - x86 (KB4535288)
``` powershell
# SQL Server 2014 SP3 Security update - 12.0.6372.1 - x86 (KB4535288)
$outputFolder = 'c:\sqlsyms\12.0.6372.1\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/293ea0a0c7424b899d5bcd915253d8671/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.6372.01 ((SQL14_SP3_QFE-OD).191212-1438)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/bcf38756effd4ebc810aa6e146c6a1bf1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.6372.01 ((SQL14_SP3_QFE-OD).191212-1438)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/a59d30393cae4117a8fb17f54e1b6fff1/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.6372.01 ((SQL14_SP3_QFE-OD).191212-1438)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/19fe1f9fe3c84751a09fb1916c1d1ab31/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.6372.01 ((SQL14_SP3_QFE-OD).191212-1438)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/ed1d0cdedb2247d9b67ba5b7df4247ad2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.6372.01 ((SQL14_SP3_QFE-OD).191212-1438)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/f3647da71cd84c81a409357f4e3823b01/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.6372.01 ((SQL14_SP3_QFE-OD).191212-1438)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/1e54810c09ff4222889ac0220924754a1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.6372.01 ((SQL14_SP3_QFE-OD).191212-1438)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/eb15a63849fd464484aadb058f6cceee1/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.6372.01 ((SQL14_SP3_QFE-OD).191212-1438)
```

# SQL Server 2014 SP3 CU4 - 12.0.6329.1 - x64 (KB4500181)
``` powershell
# SQL Server 2014 SP3 CU4 - 12.0.6329.1 - x64 (KB4500181)
$outputFolder = 'c:\sqlsyms\12.0.6329.1\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/d8fb694123ba4677bee6145b83b62cff2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.6329.01 ((SQL14_SP3_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/1b6e19734d074c9890f13ff5ea5d4c912/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.6329.01 ((SQL14_SP3_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/f95e3773af054cc7a3bf4b6085f6c1d12/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.6329.01 ((SQL14_SP3_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/84e90c67c25b46419a58c11eea0a9a4a2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.6329.01 ((SQL14_SP3_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/1e7f7c728a8f41049e73e89d313fcf852/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.6329.01 ((SQL14_SP3_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/4f2b4eda1143444bb7963507c9f9ea232/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.6329.01 ((SQL14_SP3_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/530c0de276fb40ceab73fb117b038d601/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.6329.01 ((SQL14_SP3_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/d6708b4bf5854985b6fa2ef0d44508a11/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.6329.01 ((SQL14_SP3_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/6c202059075a4fab90806f205caa070a1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.6329.01 ((SQL14_SP3_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/63a4742459624df0938bf06b948771ad1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.6329.01 ((SQL14_SP3_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/0f334a75cf294a6aa2be0b46f824b4902/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.6329.01 ((SQL14_SP3_QFE-CU).190720-2034)
```

# SQL Server 2014 SP3 CU4 - 12.0.6329.1 - x86 (KB4500181)
``` powershell
# SQL Server 2014 SP3 CU4 - 12.0.6329.1 - x86 (KB4500181)
$outputFolder = 'c:\sqlsyms\12.0.6329.1\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/890448d8cb7045b393f8d1e2414899681/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.6329.01 ((SQL14_SP3_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/54428dd07fed4d92a44af191b64b93931/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.6329.01 ((SQL14_SP3_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/1b72f20b65754e08a1b1afa6a1afa4111/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.6329.01 ((SQL14_SP3_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/648fb8d142124a79ba2427d7afa6e0b11/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.6329.01 ((SQL14_SP3_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/494b3def7c474707a36f396d3376c4862/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.6329.01 ((SQL14_SP3_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/1fffeae543a04025affdb7835ea77d271/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.6329.01 ((SQL14_SP3_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/f5d000569d74429ea2403fa65f7e782d1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.6329.01 ((SQL14_SP3_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/37ed1fbf4c114534bc53be649d38a4931/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.6329.01 ((SQL14_SP3_QFE-CU).190720-2034)
```

# SQL Server 2014 SP3 CU3 - 12.0.6259.0 - x64 (KB4491539)
``` powershell
# SQL Server 2014 SP3 CU3 - 12.0.6259.0 - x64 (KB4491539)
$outputFolder = 'c:\sqlsyms\12.0.6259.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/509f1673a650493eaf6e0609be36b3492/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.6259.00 ((SQL14_SP3_QFE-CU).190401-2139)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/9d0ed648ab3943148311d78972c4dcdf2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.6259.00 ((SQL14_SP3_QFE-CU).190401-2139)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/93f36eaccaf74bb49b33f830aa6225302/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.6259.00 ((SQL14_SP3_QFE-CU).190401-2139)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/59a4d543c0184372b51935541c2900152/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.6259.00 ((SQL14_SP3_QFE-CU).190401-2139)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/1836c6d5c554455c8b477142ba1c27552/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.6259.00 ((SQL14_SP3_QFE-CU).190401-2139)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/aefccb0a87ff43b6aa36c438baf6d1c42/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.6259.00 ((SQL14_SP3_QFE-CU).190401-2139)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/aa90299262cb4b118067c2df8703c9b91/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.6259.00 ((SQL14_SP3_QFE-CU).190401-2139)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/806e98d642074181978524533a9ef6531/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.6259.00 ((SQL14_SP3_QFE-CU).190401-2139)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/afbaa234358740998f706fd39e87a54e1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.6259.00 ((SQL14_SP3_QFE-CU).190401-2139)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/dd07d2aa7b2d4a528ffb3446711c9f321/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.6259.00 ((SQL14_SP3_QFE-CU).190401-2139)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/9a8dc77df3fc40f0a74375aa505eccfa2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.6259.00 ((SQL14_SP3_QFE-CU).190401-2139)
```

# SQL Server 2014 SP3 CU3 - 12.0.6259.0 - x86 (KB4491539)
``` powershell
# SQL Server 2014 SP3 CU3 - 12.0.6259.0 - x86 (KB4491539)
$outputFolder = 'c:\sqlsyms\12.0.6259.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/eb6a68e1d0a24f9a9334f21aa15921651/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.6259.00 ((SQL14_SP3_QFE-CU).190401-2139)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/e70ca276fe4043b19187d6d11dc8b8191/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.6259.00 ((SQL14_SP3_QFE-CU).190401-2139)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/6961ef7185e6403b8f45a2f02afaf21d1/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.6259.00 ((SQL14_SP3_QFE-CU).190401-2139)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/43b2f5430e244bfdbebf88fe85f6c9dc1/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.6259.00 ((SQL14_SP3_QFE-CU).190401-2139)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/549544362bc8490f9d315b111ae5b6952/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.6259.00 ((SQL14_SP3_QFE-CU).190401-2139)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/ce9855d8b6af4d45a14edb618dae86be1/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.6259.00 ((SQL14_SP3_QFE-CU).190401-2139)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/1c741bb277204482be593a294bc80dc71/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.6259.00 ((SQL14_SP3_QFE-CU).190401-2139)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/48abe955b32c43c2a8d38d8a0b706de51/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.6259.00 ((SQL14_SP3_QFE-CU).190401-2139)
```

# SQL Server 2014 SP3 CU2 - 12.0.6214.1 - x64 (KB4482960)
``` powershell
# SQL Server 2014 SP3 CU2 - 12.0.6214.1 - x64 (KB4482960)
$outputFolder = 'c:\sqlsyms\12.0.6214.1\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/10e693af20a345548cab5cc0d5bb9e5f2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.6214.01 ((SQL14_SP3_QFE-CU).190202-0024)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/277e791468d84fd3ac5134bfcb8b00292/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.6214.01 ((SQL14_SP3_QFE-CU).190202-0024)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/8c63860792c440eb997bbc9c3da54eb72/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.6214.01 ((SQL14_SP3_QFE-CU).190202-0024)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/860593c8a27d4f609d1f139775b445862/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.6214.01 ((SQL14_SP3_QFE-CU).190202-0024)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/0170e47e2ba046e0b2726300345d4dfc2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.6214.01 ((SQL14_SP3_QFE-CU).190202-0024)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/cf29ef995a5545ed8f8af7ddd180b7802/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.6214.01 ((SQL14_SP3_QFE-CU).190202-0024)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/4d1d0ae8debb488496086b48820cae8c1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.6214.01 ((SQL14_SP3_QFE-CU).190202-0024)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/a3671b7f7c5a457186f91951c24bae1c1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.6214.01 ((SQL14_SP3_QFE-CU).190202-0024)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/d7cc5f9c29834c34ac417d1237cc631c1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.6214.01 ((SQL14_SP3_QFE-CU).190202-0024)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/187d57d685f644f79c937544e990dbb81/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.6214.01 ((SQL14_SP3_QFE-CU).190202-0024)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/5c5e9a47919c4d6884d480d8f1c2d0762/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.6214.01 ((SQL14_SP3_QFE-CU).190202-0024)
```

# SQL Server 2014 SP3 CU2 - 12.0.6214.1 - x86 (KB4482960)
``` powershell
# SQL Server 2014 SP3 CU2 - 12.0.6214.1 - x86 (KB4482960)
$outputFolder = 'c:\sqlsyms\12.0.6214.1\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/754b0cc922a745aa8602712ee9aa1db11/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.6214.01 ((SQL14_SP3_QFE-CU).190202-0024)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/3841b412fc874fb99ca1f27156227aba1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.6214.01 ((SQL14_SP3_QFE-CU).190202-0024)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/ed56dba006f74b929b23cac11986d8d51/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.6214.01 ((SQL14_SP3_QFE-CU).190202-0024)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/ec53723220f14149a92352787915d8cf1/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.6214.01 ((SQL14_SP3_QFE-CU).190202-0024)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/a13d5a4be3234606bcfdbdfbf99ca8352/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.6214.01 ((SQL14_SP3_QFE-CU).190202-0024)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/f3338a3416cc4c9faa6f0f2dd08873761/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.6214.01 ((SQL14_SP3_QFE-CU).190202-0024)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/b113633a9a3f4819b125a6fd84cc4b2f1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.6214.01 ((SQL14_SP3_QFE-CU).190202-0024)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/40e7e956e6b64b3390093d7fed7996711/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.6214.01 ((SQL14_SP3_QFE-CU).190202-0024)
```

# SQL Server 2014 SP3 CU1 - 12.0.6205.1 - x64 (KB4470220)
``` powershell
# SQL Server 2014 SP3 CU1 - 12.0.6205.1 - x64 (KB4470220)
$outputFolder = 'c:\sqlsyms\12.0.6205.1\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/d81e66c5bbd8441aa42d3120f29de3942/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.6205.01 ((SQL14_SP3_QFE-CU).181130-0218)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/531883113186498cba06afb246bd12172/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.6205.01 ((SQL14_SP3_QFE-CU).181130-0218)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/093905727fd6498fac8991daed83fcde2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.6205.01 ((SQL14_SP3_QFE-CU).181130-0218)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/810559511add437f9da77ec6c227c3fb2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.6205.01 ((SQL14_SP3_QFE-CU).181130-0218)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/fff69d6bafab400fbafb9bfdd6fb52ff2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.6205.01 ((SQL14_SP3_QFE-CU).181130-0218)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/5cac176280bf4ab2af8033571dac19112/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.6205.01 ((SQL14_SP3_QFE-CU).181130-0218)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/b6bdfa6c96e74ef5ae6996e1733a432f1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.6205.01 ((SQL14_SP3_QFE-CU).181130-0218)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/8be7ae0b97464e56889d44760e5991771/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.6205.01 ((SQL14_SP3_QFE-CU).181130-0218)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/452b00505e9c4459877311b2a5296de01/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.6205.01 ((SQL14_SP3_QFE-CU).181130-0218)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/aa1470bb4a5c4687aef9d015e876685d1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.6205.01 ((SQL14_SP3_QFE-CU).181130-0218)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/2fe2b89405d644e8859b099da8827acb2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.6205.01 ((SQL14_SP3_QFE-CU).181130-0218)
```

# SQL Server 2014 SP3 CU1 - 12.0.6205.1 - x86 (KB4470220)
``` powershell
# SQL Server 2014 SP3 CU1 - 12.0.6205.1 - x86 (KB4470220)
$outputFolder = 'c:\sqlsyms\12.0.6205.1\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/cbcf0fbe53e54dacab354777d0dd5c2f1/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.6205.01 ((SQL14_SP3_QFE-CU).181130-0218)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/4f2576c7baa640d894aa0bf5d12fcf5f1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.6205.01 ((SQL14_SP3_QFE-CU).181130-0218)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/ac9f63e413d74fc5b1685806550265ae1/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.6205.01 ((SQL14_SP3_QFE-CU).181130-0218)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/fd21a26df72c47e29b96652c800806001/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.6205.01 ((SQL14_SP3_QFE-CU).181130-0218)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/75e51827bfcf435bae782ec8b7a4e3d82/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.6205.01 ((SQL14_SP3_QFE-CU).181130-0218)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/1a1dabe18df94874ba8bf28b429a8e6e1/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.6205.01 ((SQL14_SP3_QFE-CU).181130-0218)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/6cc29ac330c64c0a97461b778a1ba63d1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.6205.01 ((SQL14_SP3_QFE-CU).181130-0218)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/64addefbdce84bdd97198a54d80939e71/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.6205.01 ((SQL14_SP3_QFE-CU).181130-0218)
```

# SQL Server 2014 SP3 SP3 - 12.0.6024.0 - x64 (KB4022619)
``` powershell
# SQL Server 2014 SP3 SP3 - 12.0.6024.0 - x64 (KB4022619)
$outputFolder = 'c:\sqlsyms\12.0.6024.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/41b862dddc464a7e8fb435d80ef36d452/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.6024.00 ((SQL14_PCU_Main).180907-0056)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/8bc7a14bc8374bd0a9bcba71d608c2ef2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.6024.00 ((SQL14_PCU_Main).180907-0056)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/d1b5af4c4bcb41aebdae55654c0abc172/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.6024.00 ((SQL14_PCU_Main).180907-0056)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/a84fba616c964fdb849bb61878d368312/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.6024.00 ((SQL14_PCU_Main).180907-0056)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/cd96b0931624429a8b38b968078fad6c2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.6024.00 ((SQL14_PCU_Main).180907-0056)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/5e9cea18178c471b98c01da45892cc142/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.6024.00 ((SQL14_PCU_Main).180907-0056)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/c9163d437f9e473a91690d6a7fae07531/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.6024.00 ((SQL14_PCU_Main).180907-0056)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/f97a0a9518ea47d3ad13d09e1c6cbc8e1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.6024.00 ((SQL14_PCU_Main).180907-0056)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/1915e0ba4f764b49806e8bcefe9bdd351/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.6024.00 ((SQL14_PCU_Main).180907-0056)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/9b9535d5b46442d7a75246220c243ad91/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.6024.00 ((SQL14_PCU_Main).180907-0056)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/15291da2ad56424ab3f1a7e97809ec602/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.6024.00 ((SQL14_PCU_Main).180907-0056)
```

# SQL Server 2014 SP3 SP3 - 12.0.6024.0 - x86 (KB4022619)
``` powershell
# SQL Server 2014 SP3 SP3 - 12.0.6024.0 - x86 (KB4022619)
$outputFolder = 'c:\sqlsyms\12.0.6024.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/63c453d94e884e719f71611dd86e41f71/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.6024.00 ((SQL14_PCU_Main).180907-0056)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/6b94239f60d04638ac56d2d915054ae11/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.6024.00 ((SQL14_PCU_Main).180907-0056)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/d2bd8b4899db4627a49dcf39f275681a1/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.6024.00 ((SQL14_PCU_Main).180907-0056)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/e42c910a8207417ebfe95904c7aca3c01/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.6024.00 ((SQL14_PCU_Main).180907-0056)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/65c5722bca2e4384b8abdd8e7f57d00b2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.6024.00 ((SQL14_PCU_Main).180907-0056)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/f0ce2870ba1c4a759c01ee8c9366fa5d1/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.6024.00 ((SQL14_PCU_Main).180907-0056)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/b1c25cca32ca4d6391442eb096c2e71b1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.6024.00 ((SQL14_PCU_Main).180907-0056)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/370cc1865d654a908a912aca9de0156d1/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.6024.00 ((SQL14_PCU_Main).180907-0056)
```

# SQL Server 2014 SP2 CU18 - 12.0.5687.1 - x64 (KB4500180)
``` powershell
# SQL Server 2014 SP2 CU18 - 12.0.5687.1 - x64 (KB4500180)
$outputFolder = 'c:\sqlsyms\12.0.5687.1\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/bc12ecf9b0b543b196f0b7ed938283452/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.5687.01 ((SQL14_SP2_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/1b75aed94f92493dbba724cdc1f7c36d2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5687.01 ((SQL14_SP2_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/ff83ee2c46a7487686e8e1130887ced12/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5687.01 ((SQL14_SP2_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/b1044002158745fa8df8cce82b12f6ae2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.5687.01 ((SQL14_SP2_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/e8b1bf15c88342efbc82d32362ea64702/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5687.01 ((SQL14_SP2_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/e6d23fe6f42648418edc7c96c8619fd12/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5687.01 ((SQL14_SP2_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/abbcda6f1fb844bab401cd2ec5ec95471/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.5687.01 ((SQL14_SP2_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/f1f51c0ee2bb40dea8c9cc16917f52981/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.5687.01 ((SQL14_SP2_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/1d23807267c543f9a3fe48d69ef3d13e1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.5687.01 ((SQL14_SP2_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/801dddbf3b0849d9b0b1d15219dadad81/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5687.01 ((SQL14_SP2_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/e53cbbfca1d94580b8d4a7d511bb56e22/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5687.01 ((SQL14_SP2_QFE-CU).190720-2034)
```

# SQL Server 2014 SP2 CU18 - 12.0.5687.1 - x86 (KB4500180)
``` powershell
# SQL Server 2014 SP2 CU18 - 12.0.5687.1 - x86 (KB4500180)
$outputFolder = 'c:\sqlsyms\12.0.5687.1\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/1f1ebd01257f4aa5861d1ba6bd5eef381/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.5687.01 ((SQL14_SP2_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/b7fdb65668ae43cbac516c04d7fcddfb1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5687.01 ((SQL14_SP2_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/f4b5dc917b9a4b578e83a63c98914bdb1/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5687.01 ((SQL14_SP2_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/dd4f41c29b454453b9dadd60a3cf988e1/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.5687.01 ((SQL14_SP2_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/a8c3b381308647ab9a765b681f92e08f2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5687.01 ((SQL14_SP2_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/77dc64a2c02c41c3921c183c76ca39d51/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5687.01 ((SQL14_SP2_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/afe089cbd86947c6b1fe8796ded5a75e1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5687.01 ((SQL14_SP2_QFE-CU).190720-2034)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/897c55ca4ff84510ae2c1ac75f918e771/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5687.01 ((SQL14_SP2_QFE-CU).190720-2034)
```

# SQL Server 2014 SP2 CU17 - 12.0.5632.1 - x64 (KB4491540)
``` powershell
# SQL Server 2014 SP2 CU17 - 12.0.5632.1 - x64 (KB4491540)
$outputFolder = 'c:\sqlsyms\12.0.5632.1\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/7cec2abd211d44449ec0f3e94e1a78202/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.5632.01 ((SQL14_SP2_QFE-CU).190401-2109)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/093aba20ce644768bb722dfc74216a672/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5632.01 ((SQL14_SP2_QFE-CU).190401-2109)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/429635c72df34811b063bfbdc4fd30d72/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5632.01 ((SQL14_SP2_QFE-CU).190401-2109)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/3e544ec2f85b4e27b3d23c8316125f262/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.5632.01 ((SQL14_SP2_QFE-CU).190401-2109)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/f5e5a5a404464f80b46f6449a2dfa6a02/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5632.01 ((SQL14_SP2_QFE-CU).190401-2109)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/b5f8b9ae3a364402ac1b8bab1c3732512/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5632.01 ((SQL14_SP2_QFE-CU).190401-2109)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/cf46f2edea064dae95f6a457ba1ae1ef1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.5632.01 ((SQL14_SP2_QFE-CU).190401-2109)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/8a0ea19b90b84d7799d99bb3b751399d1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.5632.01 ((SQL14_SP2_QFE-CU).190401-2109)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/fa60812c91384eaf82bd97d59a2ff4e61/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.5632.01 ((SQL14_SP2_QFE-CU).190401-2109)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/310541c655dc434c9d834d1a6a196cfd1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5632.01 ((SQL14_SP2_QFE-CU).190401-2109)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/2de8f5bc87ff4a8390a0f454faf810282/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5632.01 ((SQL14_SP2_QFE-CU).190401-2109)
```

# SQL Server 2014 SP2 CU17 - 12.0.5632.1 - x86 (KB4491540)
``` powershell
# SQL Server 2014 SP2 CU17 - 12.0.5632.1 - x86 (KB4491540)
$outputFolder = 'c:\sqlsyms\12.0.5632.1\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/748fe7f884084be6bd64e1e9448d0ffe1/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.5632.01 ((SQL14_SP2_QFE-CU).190401-2109)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/545779f8eb8547d4abdd811f28c7f3f61/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5632.01 ((SQL14_SP2_QFE-CU).190401-2109)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/36d26ada3cf949229fda088acadabd831/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5632.01 ((SQL14_SP2_QFE-CU).190401-2109)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/478b047f2f8044b7b33aeded194ebfee1/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.5632.01 ((SQL14_SP2_QFE-CU).190401-2109)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/0466eb809cbe4386b49402ad9004229d2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5632.01 ((SQL14_SP2_QFE-CU).190401-2109)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/066f353a8df34b8c8bc789d6e27c5a321/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5632.01 ((SQL14_SP2_QFE-CU).190401-2109)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/6ac1205c109b49ae850f9ded968ffecb1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5632.01 ((SQL14_SP2_QFE-CU).190401-2109)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/eed60d89729949198006ca2352abf51f1/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5632.01 ((SQL14_SP2_QFE-CU).190401-2109)
```

# SQL Server 2014 SP2 CU16 - 12.0.5626.1 - x64 (KB4482967)
``` powershell
# SQL Server 2014 SP2 CU16 - 12.0.5626.1 - x64 (KB4482967)
$outputFolder = 'c:\sqlsyms\12.0.5626.1\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/7090b9b360f644bda3ac44b853a206d82/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.5626.01 ((SQL14_SP2_QFE-CU).190208-0024)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/6c9e5d6da1dd488d89eb0ae333b1c5eb2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5626.01 ((SQL14_SP2_QFE-CU).190208-0024)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/ea9b053430534dfc8f0dce4807a484682/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5626.01 ((SQL14_SP2_QFE-CU).190208-0024)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/98a4a92f370d402188b910a7435ba3f72/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.5626.01 ((SQL14_SP2_QFE-CU).190208-0024)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/d535d53ebf624bb29f5557ffbf0a5efc2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5626.01 ((SQL14_SP2_QFE-CU).190208-0024)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/54f79487ed6d40ea86bbcc67ff82b6e82/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5626.01 ((SQL14_SP2_QFE-CU).190208-0024)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/ea86d5e8467f4f289207290bec941f7a1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.5626.01 ((SQL14_SP2_QFE-CU).190208-0024)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/1d2496b66ea54f22851739b58fcd1d371/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.5626.01 ((SQL14_SP2_QFE-CU).190208-0024)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/70eb1fd8363e42419e5e5ee4a23d7af31/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.5626.01 ((SQL14_SP2_QFE-CU).190208-0024)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/0ceb3b389ce54506b0198b62af03a7a81/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5626.01 ((SQL14_SP2_QFE-CU).190208-0024)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/44cde1fe0341418cabb84df6877e072f2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5626.01 ((SQL14_SP2_QFE-CU).190208-0024)
```

# SQL Server 2014 SP2 CU16 - 12.0.5626.1 - x86 (KB4482967)
``` powershell
# SQL Server 2014 SP2 CU16 - 12.0.5626.1 - x86 (KB4482967)
$outputFolder = 'c:\sqlsyms\12.0.5626.1\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/b78052c424754a1e9f08450f02cf15261/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.5626.01 ((SQL14_SP2_QFE-CU).190208-0024)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/273a5267830d42a7aa3f38a52bc210cb1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5626.01 ((SQL14_SP2_QFE-CU).190208-0024)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/5256c66a20844f00876972b91c7606d01/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5626.01 ((SQL14_SP2_QFE-CU).190208-0024)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/f755234510654e88b5a922721ea8f8071/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.5626.01 ((SQL14_SP2_QFE-CU).190208-0024)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/dcbe2aea271c41d08af7f2ee653651c72/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5626.01 ((SQL14_SP2_QFE-CU).190208-0024)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/2c2f8b012a19446b80ca5f21ca91700c1/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5626.01 ((SQL14_SP2_QFE-CU).190208-0024)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/e59649446ebc4f07a5aa23edc78b5af11/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5626.01 ((SQL14_SP2_QFE-CU).190208-0024)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/d0b73290904841ca94d10ec14ad456ab1/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5626.01 ((SQL14_SP2_QFE-CU).190208-0024)
```

# SQL Server 2014 SP2 CU15 - 12.0.5605.1 - x64 (KB4469137)
``` powershell
# SQL Server 2014 SP2 CU15 - 12.0.5605.1 - x64 (KB4469137)
$outputFolder = 'c:\sqlsyms\12.0.5605.1\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/117240f0c59848f8afe7069fadb2be382/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.5605.01 ((SQL14_SP2_QFE-CU).181130-0132)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/876f1d479cf34b3cbcef15246fff9b2b2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5605.01 ((SQL14_SP2_QFE-CU).181130-0132)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/3204a130bbab4542902c7a8a2d83fa512/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5605.01 ((SQL14_SP2_QFE-CU).181130-0132)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/9d04ea3232d645d88d2918112a86965b2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.5605.01 ((SQL14_SP2_QFE-CU).181130-0132)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/271f77960efa4e848183c41e045ed28b2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5605.01 ((SQL14_SP2_QFE-CU).181130-0132)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/05287b373d6848818fed57489cb723882/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5605.01 ((SQL14_SP2_QFE-CU).181130-0132)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/37871400f6ba41cb87953ea6dee1679b1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.5605.01 ((SQL14_SP2_QFE-CU).181130-0132)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/a150b67635d9449e9cb1e54dc04057091/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.5605.01 ((SQL14_SP2_QFE-CU).181130-0132)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/729bc522263b44bf9d76c05c86d60aa71/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.5605.01 ((SQL14_SP2_QFE-CU).181130-0132)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/0efb398f50ac46a095e3db1d063494b71/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5605.01 ((SQL14_SP2_QFE-CU).181130-0132)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/8c1f27f1610d4083b6cfc03d8464e9702/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5605.01 ((SQL14_SP2_QFE-CU).181130-0132)
```

# SQL Server 2014 SP2 CU15 - 12.0.5605.1 - x86 (KB4469137)
``` powershell
# SQL Server 2014 SP2 CU15 - 12.0.5605.1 - x86 (KB4469137)
$outputFolder = 'c:\sqlsyms\12.0.5605.1\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/b80aa4d26d824d51a1b2821b3bd3c9df1/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.5605.01 ((SQL14_SP2_QFE-CU).181130-0132)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/a167e470217c45f8990402872693763c1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5605.01 ((SQL14_SP2_QFE-CU).181130-0132)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/8624d05eb3114058bb16484bb5b270f41/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5605.01 ((SQL14_SP2_QFE-CU).181130-0132)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/fbacb139597e46f5b710e865a66de6401/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.5605.01 ((SQL14_SP2_QFE-CU).181130-0132)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/5de0309257254890b30958eddac74d692/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5605.01 ((SQL14_SP2_QFE-CU).181130-0132)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/7c97495f85d545ec97e160ec95e08a051/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5605.01 ((SQL14_SP2_QFE-CU).181130-0132)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/8a2c37cc83db491095f9452840c70a5e1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5605.01 ((SQL14_SP2_QFE-CU).181130-0132)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/0ed0bd2de748480cae7a6fb8c9c720eb1/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5605.01 ((SQL14_SP2_QFE-CU).181130-0132)
```

# SQL Server 2014 SP2 CU14 - 12.0.5600.1 - x64 (KB4459860)
``` powershell
# SQL Server 2014 SP2 CU14 - 12.0.5600.1 - x64 (KB4459860)
$outputFolder = 'c:\sqlsyms\12.0.5600.1\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/2438e40ce685447eac9e01d2173b146d2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.5600.01 ((SQL14_SP2_QFE-CU).180927-2111)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/93a50030edc54ab2805e7324b5c5867e2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5600.01 ((SQL14_SP2_QFE-CU).180927-2111)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/b0b41b9743964fe2874cf90433ef7c9a2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5600.01 ((SQL14_SP2_QFE-CU).180927-2111)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/5e129aa1bde341ef9cd43882060582eb2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.5600.01 ((SQL14_SP2_QFE-CU).180927-2111)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/250c631ea1f249fdabc901273e8f7c452/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5600.01 ((SQL14_SP2_QFE-CU).180927-2111)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/e6f37c85e8004bfc8c74ccba69e5ce642/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5600.01 ((SQL14_SP2_QFE-CU).180927-2111)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/73600a8dc74945059ccf2d99ca8a377b1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.5600.01 ((SQL14_SP2_QFE-CU).180927-2111)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/c357ccbf716b47e29b48073179a6a2a81/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.5600.01 ((SQL14_SP2_QFE-CU).180927-2111)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/f925b1c9695d4dd28360ceb7e2976a581/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.5600.01 ((SQL14_SP2_QFE-CU).180927-2111)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/8ae4a300b56c475095d8ec409dbc31221/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5600.01 ((SQL14_SP2_QFE-CU).180927-2111)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/1b685a50036e4af388ff9f1fab8a795f2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5600.01 ((SQL14_SP2_QFE-CU).180927-2111)
```

# SQL Server 2014 SP2 CU14 - 12.0.5600.1 - x86 (KB4459860)
``` powershell
# SQL Server 2014 SP2 CU14 - 12.0.5600.1 - x86 (KB4459860)
$outputFolder = 'c:\sqlsyms\12.0.5600.1\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/c6575e4e12d94e4ba30764806d0577061/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.5600.01 ((SQL14_SP2_QFE-CU).180927-2111)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/61c9b48dd8af443780ba4556f948816d1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5600.01 ((SQL14_SP2_QFE-CU).180927-2111)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/88e4973a9b8548909a0ab9b691936ed31/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5600.01 ((SQL14_SP2_QFE-CU).180927-2111)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/62a1d5b32fc9473daeb6a9e21b76bf101/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.5600.01 ((SQL14_SP2_QFE-CU).180927-2111)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/ceebbde0de164cf985ce91e4e28d96862/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5600.01 ((SQL14_SP2_QFE-CU).180927-2111)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/5963ceed5f9b435d853a2c11315f11521/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5600.01 ((SQL14_SP2_QFE-CU).180927-2111)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/5cc038bc384c45578d1485fb3370f81c1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5600.01 ((SQL14_SP2_QFE-CU).180927-2111)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/441a2d9da7a2414f999efcac59e8da3d1/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5600.01 ((SQL14_SP2_QFE-CU).180927-2111)
```

# SQL Server 2014 SP2 CU13 - 12.0.5590.1 - x64 (KB4456287)
``` powershell
# SQL Server 2014 SP2 CU13 - 12.0.5590.1 - x64 (KB4456287)
$outputFolder = 'c:\sqlsyms\12.0.5590.1\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/f22828ad8cd143b98690f3d5308405a72/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.5590.01 ((SQL14_SP2_QFE-CU).180801-0048)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/38f99ac2329e4ee1a630dd928660bf8c2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5590.01 ((SQL14_SP2_QFE-CU).180801-0048)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/26704fbb534d46b49653205984de35ca2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5590.01 ((SQL14_SP2_QFE-CU).180801-0048)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/b9bbf018d2d24d3088f300f40de6569f2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.5590.01 ((SQL14_SP2_QFE-CU).180801-0048)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/7760942524a04b989b969dc6db24bba12/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5590.01 ((SQL14_SP2_QFE-CU).180801-0048)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/4d0c5e89bcee412c9100b8d694214c402/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5590.01 ((SQL14_SP2_QFE-CU).180801-0048)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/17b16aabe9944c3a83febffb78cbd6811/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.5590.01 ((SQL14_SP2_QFE-CU).180801-0048)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/c9216aed6e7645d39c0825a977c5a6f31/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.5590.01 ((SQL14_SP2_QFE-CU).180801-0048)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/9d9eadc9e8f8484eb83eb557687c059f1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.5590.01 ((SQL14_SP2_QFE-CU).180801-0048)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/3d021aaa04a8473abb5965725950c4ab1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5590.01 ((SQL14_SP2_QFE-CU).180801-0048)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/407d631b6e454fd0b0c041c33c345fd22/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5590.01 ((SQL14_SP2_QFE-CU).180801-0048)
```

# SQL Server 2014 SP2 CU13 - 12.0.5590.1 - x86 (KB4456287)
``` powershell
# SQL Server 2014 SP2 CU13 - 12.0.5590.1 - x86 (KB4456287)
$outputFolder = 'c:\sqlsyms\12.0.5590.1\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/33e588094276460b8038432fad3db2661/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.5590.01 ((SQL14_SP2_QFE-CU).180801-0048)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/629dce7389c24992a825468bd5191eae1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5590.01 ((SQL14_SP2_QFE-CU).180801-0048)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/5b493a35686047f1ba71f7ce7b3a90751/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5590.01 ((SQL14_SP2_QFE-CU).180801-0048)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/f7a83574ae43421b8468a07d493246ef1/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.5590.01 ((SQL14_SP2_QFE-CU).180801-0048)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/f158728bc8404e1aa43fe38433e4e6f82/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5590.01 ((SQL14_SP2_QFE-CU).180801-0048)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/1f241b8adf9748bca47525e287ae42451/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5590.01 ((SQL14_SP2_QFE-CU).180801-0048)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/bc679557623041a48db99e6ab3c27f691/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5590.01 ((SQL14_SP2_QFE-CU).180801-0048)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/f6f9e9d0148d47d7ad3abfc75f8bb31b1/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5590.01 ((SQL14_SP2_QFE-CU).180801-0048)
```

# SQL Server 2014 SP2 CU12 - 12.0.5589.7 - x64 (KB4130489)
``` powershell
# SQL Server 2014 SP2 CU12 - 12.0.5589.7 - x64 (KB4130489)
$outputFolder = 'c:\sqlsyms\12.0.5589.7\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/9cf25aee69fe4936b6d5dbc0a2864e562/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.5589.07 ((SQL14_SP2_QFE-CU).180609-1032)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/56bc64bb80724cbe9e73e3baf373ac5e2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5589.07 ((SQL14_SP2_QFE-CU).180609-1032)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/bfd1994080f84d2b832dc738a74466d62/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5589.07 ((SQL14_SP2_QFE-CU).180609-1032)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/c4b5a5ca9822464386d76070dc0b16c52/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.5589.07 ((SQL14_SP2_QFE-CU).180609-1032)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/69363948fbbe4b37a1942a397c28ac9a2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5589.07 ((SQL14_SP2_QFE-CU).180609-1032)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/7d1172991d104f70985859b8f5c1ca122/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5589.07 ((SQL14_SP2_QFE-CU).180609-1032)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/2ba38b2b5dc84ea29ba150f79b52c9b31/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.5589.07 ((SQL14_SP2_QFE-CU).180609-1032)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/f7947a9995b34b38bffe3a086f9ed3341/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.5589.07 ((SQL14_SP2_QFE-CU).180609-1032)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/d97a5e01a698460d9641e2017990f2ba1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.5589.07 ((SQL14_SP2_QFE-CU).180609-1032)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/bf808d6229bd4fe69562c672359a61b81/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5589.07 ((SQL14_SP2_QFE-CU).180609-1032)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/5abf57238fc44199bc9b494c7391a94a2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5589.07 ((SQL14_SP2_QFE-CU).180609-1032)
```

# SQL Server 2014 SP2 CU12 - 12.0.5589.7 - x86 (KB4130489)
``` powershell
# SQL Server 2014 SP2 CU12 - 12.0.5589.7 - x86 (KB4130489)
$outputFolder = 'c:\sqlsyms\12.0.5589.7\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/a17e4ed617604e1f93cb7043a7b061af1/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.5589.07 ((SQL14_SP2_QFE-CU).180609-1032)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/f1d22c428ec941b3ab6cf84b970013d21/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5589.07 ((SQL14_SP2_QFE-CU).180609-1032)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/3df9de6f254540598dd9da4852d8797d1/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5589.07 ((SQL14_SP2_QFE-CU).180609-1032)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/8a70299c32844f529bf7af758400e1a61/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.5589.07 ((SQL14_SP2_QFE-CU).180609-1032)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/c8053d2959e24d70bc2820ef3d183c4a2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5589.07 ((SQL14_SP2_QFE-CU).180609-1032)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/a2e7016632da4d79a7ffc36ec94956c21/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5589.07 ((SQL14_SP2_QFE-CU).180609-1032)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/0dd5355ca33a4d49a27401e7bed2e4241/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5589.07 ((SQL14_SP2_QFE-CU).180609-1032)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/bb53084f1e9c448db50e72d30284890d1/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5589.07 ((SQL14_SP2_QFE-CU).180609-1032)
```

# SQL Server 2014 SP2 CU11 - 12.0.5579.0 - x64 (KB4077063)
``` powershell
# SQL Server 2014 SP2 CU11 - 12.0.5579.0 - x64 (KB4077063)
$outputFolder = 'c:\sqlsyms\12.0.5579.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/0aea57c255f340f6b268422d36c9b5462/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.5579.00 ((SQL14_SP2_QFE-CU).180221-1111)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/8f7a73cfc7ae40b69cedfb56c478c8a42/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5579.00 ((SQL14_SP2_QFE-CU).180221-1111)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/6f3a59d764d34c1c9506c1cbb799ce282/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5579.00 ((SQL14_SP2_QFE-CU).180221-1111)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/5e23ac5ca0a441cea1043b92cc7db19d2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.5579.00 ((SQL14_SP2_QFE-CU).180221-1111)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/90418b6bc2dd41469db8c20a64cd6b082/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5579.00 ((SQL14_SP2_QFE-CU).180221-1111)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/4355cf52f7e54f1abd0d6545276e31242/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5579.00 ((SQL14_SP2_QFE-CU).180221-1111)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/6eacc2b3b2b54beba5e1e47ccf312c691/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.5579.00 ((SQL14_SP2_QFE-CU).180221-1111)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/43312b84f24d461582340aa0d3706e0f1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.5579.00 ((SQL14_SP2_QFE-CU).180221-1111)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/f88d3bc891cf4a66a06ab20db6a2f4111/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.5579.00 ((SQL14_SP2_QFE-CU).180221-1111)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/1a52dc5348f24ec98371fc0191786fa31/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5579.00 ((SQL14_SP2_QFE-CU).180221-1111)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/f9963e6eb1a34e019caf757ff0bdf2762/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5579.00 ((SQL14_SP2_QFE-CU).180221-1111)
```

# SQL Server 2014 SP2 CU11 - 12.0.5579.0 - x86 (KB4077063)
``` powershell
# SQL Server 2014 SP2 CU11 - 12.0.5579.0 - x86 (KB4077063)
$outputFolder = 'c:\sqlsyms\12.0.5579.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/2a38a3f0f77b410b8ab96959ec07f43f1/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.5579.00 ((SQL14_SP2_QFE-CU).180221-1111)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/ad85bbc382b94bc4b6d28c94bea7b09f1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5579.00 ((SQL14_SP2_QFE-CU).180221-1111)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/2c9ba43db9924d71be6599ef2ddfb6fa1/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5579.00 ((SQL14_SP2_QFE-CU).180221-1111)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/8b5208e65b4d420884a73dca82dfb5c61/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.5579.00 ((SQL14_SP2_QFE-CU).180221-1111)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/fd4511ab526d47b7ae5f18fa15dcb2ee2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5579.00 ((SQL14_SP2_QFE-CU).180221-1111)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/ace3687338a64ee99b1ddad95e5b5a611/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5579.00 ((SQL14_SP2_QFE-CU).180221-1111)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/ae50d44983714260bc12cb539b3ae6481/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5579.00 ((SQL14_SP2_QFE-CU).180221-1111)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/6524dc9692f44f0a954ebc34fba6566e1/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5579.00 ((SQL14_SP2_QFE-CU).180221-1111)
```

# SQL Server 2014 SP2 CU10 - 12.0.5571.0 - x64 (KB4052725)
``` powershell
# SQL Server 2014 SP2 CU10 - 12.0.5571.0 - x64 (KB4052725)
$outputFolder = 'c:\sqlsyms\12.0.5571.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/1f838ce4d2314a679d95f581ba5cfca72/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.5571.00 ((SQL14_SP2_QFE-CU).180110-1458)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/eb5287194386470bb6ed9be5cfa913032/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5571.00 ((SQL14_SP2_QFE-CU).180110-1458)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/187bfc99dd6142ed912b9b0a16971ba92/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5571.00 ((SQL14_SP2_QFE-CU).180110-1458)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/4a0d1ac8b530440581e5ee96278215352/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.5571.00 ((SQL14_SP2_QFE-CU).180110-1458)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/2a491b79a3534daaba1fdaee3ef28d412/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5571.00 ((SQL14_SP2_QFE-CU).180110-1458)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/88fe4b4b23a64afd804553959161691a2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5571.00 ((SQL14_SP2_QFE-CU).180110-1458)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/1dd40e165b074b0784aa0fa5c7225ce11/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.5571.00 ((SQL14_SP2_QFE-CU).180110-1458)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/42629264c38e41829734aca5e2c32b851/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.5571.00 ((SQL14_SP2_QFE-CU).180110-1458)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/9ff125ff36e841719e28e54c59d81e8a1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.5571.00 ((SQL14_SP2_QFE-CU).180110-1458)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/195069bf1697410789e1c320dcff547e1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5571.00 ((SQL14_SP2_QFE-CU).180110-1458)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/4ea18a049c454b7fab49fa3af4d747652/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5571.00 ((SQL14_SP2_QFE-CU).180110-1458)
```

# SQL Server 2014 SP2 CU10 - 12.0.5571.0 - x86 (KB4052725)
``` powershell
# SQL Server 2014 SP2 CU10 - 12.0.5571.0 - x86 (KB4052725)
$outputFolder = 'c:\sqlsyms\12.0.5571.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/7388785bb378492eae7399ead30a62bd1/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.5571.00 ((SQL14_SP2_QFE-CU).180110-1458)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/9ae111fc7f1b45789253f4d3910106c81/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5571.00 ((SQL14_SP2_QFE-CU).180110-1458)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/655a1096c0074f94b7ffbbf9b233ea5a1/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5571.00 ((SQL14_SP2_QFE-CU).180110-1458)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/cf11f8ed6ff04de7b823930a8451701b1/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.5571.00 ((SQL14_SP2_QFE-CU).180110-1458)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/273a0ff6e91b4a8da2bee5298a5dd61f2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5571.00 ((SQL14_SP2_QFE-CU).180110-1458)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/fa6377a396864fb2918b6a596d4beb711/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5571.00 ((SQL14_SP2_QFE-CU).180110-1458)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/464ae4327e2f4dc3b17e8f3a771ff18c1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5571.00 ((SQL14_SP2_QFE-CU).180110-1458)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/7cb655624af24ccc85f4389fb0c901241/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5571.00 ((SQL14_SP2_QFE-CU).180110-1458)
```

# SQL Server 2014 SP2 CU9 - 12.0.5563.0 - x64 (KB4055557)
``` powershell
# SQL Server 2014 SP2 CU9 - 12.0.5563.0 - x64 (KB4055557)
$outputFolder = 'c:\sqlsyms\12.0.5563.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/b9c9830b1bcc4092bd2bb4f51bf81cf52/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.5563.00 ((SQL14_SP2_QFE-CU).171207-0002)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/7032c53e91934abdbf6bad9fac99066c2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5563.00 ((SQL14_SP2_QFE-CU).171207-0002)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/bbfb8d689ab34f56b443d662c7b9336e2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5563.00 ((SQL14_SP2_QFE-CU).171207-0002)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/1143c59b5fee4cb9a86a2fa2978285562/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.5563.00 ((SQL14_SP2_QFE-CU).171207-0002)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/a5dfb5b4a0c041539cd6312fd52d8b2c2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5563.00 ((SQL14_SP2_QFE-CU).171207-0002)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/d0d7ae41d21e404694ddef3b58b555102/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5563.00 ((SQL14_SP2_QFE-CU).171207-0002)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/03fd2ef25c1540819c499476aa797f5a1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.5563.00 ((SQL14_SP2_QFE-CU).171207-0002)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/ffa799b2d4d2478186b883fe71edf34e1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.5563.00 ((SQL14_SP2_QFE-CU).171207-0002)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/a56ee479b9024d47bde320de941d1ad81/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.5563.00 ((SQL14_SP2_QFE-CU).171207-0002)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/0917fd5803fe42e9b8fcdbac6b428edb1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5563.00 ((SQL14_SP2_QFE-CU).171207-0002)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/d194fc1a9c914898b99235221a474a522/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5563.00 ((SQL14_SP2_QFE-CU).171207-0002)
```

# SQL Server 2014 SP2 CU9 - 12.0.5563.0 - x86 (KB4055557)
``` powershell
# SQL Server 2014 SP2 CU9 - 12.0.5563.0 - x86 (KB4055557)
$outputFolder = 'c:\sqlsyms\12.0.5563.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/06301e600c9448b49312e41cc75d51401/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.5563.00 ((SQL14_SP2_QFE-CU).171207-0002)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/3d79c403b6534fa3a1850e0f8e5cb71b1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5563.00 ((SQL14_SP2_QFE-CU).171207-0002)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/13d944a09a6b4075bec01634bb3c5ba61/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5563.00 ((SQL14_SP2_QFE-CU).171207-0002)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/57fbfa47c5064fdfbaa81ce84725cfd91/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.5563.00 ((SQL14_SP2_QFE-CU).171207-0002)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/fe70fe593a974da09e5170edc376b0622/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5563.00 ((SQL14_SP2_QFE-CU).171207-0002)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/cbecde3234164a3c871dd3a45649152b1/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5563.00 ((SQL14_SP2_QFE-CU).171207-0002)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/06186cc6b2eb40dab968c484987b96c41/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5563.00 ((SQL14_SP2_QFE-CU).171207-0002)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/3fa4e4db8ea34b0a86118d3b83e1a1721/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5563.00 ((SQL14_SP2_QFE-CU).171207-0002)
```

# SQL Server 2014 SP2 CU8 - 12.0.5557.0 - x64 (KB4037356)
``` powershell
# SQL Server 2014 SP2 CU8 - 12.0.5557.0 - x64 (KB4037356)
$outputFolder = 'c:\sqlsyms\12.0.5557.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/e7152ca5bb5641cabadc516f5de4448e2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.5557.00 ((SQL14_SP2_QFE-CU).171003-1352)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/976df45212de41739cfb5401b5395f032/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5557.00 ((SQL14_SP2_QFE-CU).171003-1352)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/d5029367d82748b08723648d64ea340c2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5557.00 ((SQL14_SP2_QFE-CU).171003-1352)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/1095950d7a964eca94e27667eec14dd22/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.5557.00 ((SQL14_SP2_QFE-CU).171003-1352)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/0b310c825aca4a7abef7b902667467e62/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5557.00 ((SQL14_SP2_QFE-CU).171003-1352)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/96dbb1b774234407bbfaa17da1e2538a2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5557.00 ((SQL14_SP2_QFE-CU).171003-1352)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/6aa802a2e06f497b86358cfbef459f031/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.5557.00 ((SQL14_SP2_QFE-CU).171003-1352)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/2d7ae65a5e784e3e9c8e06a697a64b6b1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.5557.00 ((SQL14_SP2_QFE-CU).171003-1352)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/f23892f30b094ded9d4b88ca2aab338b1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.5557.00 ((SQL14_SP2_QFE-CU).171003-1352)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/e7dfaaf012694a6db4eae23dc3b319e31/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5557.00 ((SQL14_SP2_QFE-CU).171003-1352)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/0d6e87edec3d4a5bb55a6f86db91f3112/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5557.00 ((SQL14_SP2_QFE-CU).171003-1352)
```

# SQL Server 2014 SP2 CU8 - 12.0.5557.0 - x86 (KB4037356)
``` powershell
# SQL Server 2014 SP2 CU8 - 12.0.5557.0 - x86 (KB4037356)
$outputFolder = 'c:\sqlsyms\12.0.5557.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/1c82caaaa09e48eba283def9ee6a77041/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.5557.00 ((SQL14_SP2_QFE-CU).171003-1352)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/981f442e7b8a4ff4b016c222f897ec1e1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5557.00 ((SQL14_SP2_QFE-CU).171003-1352)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/bd794c7b740e447cbff73748980a6f1b1/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5557.00 ((SQL14_SP2_QFE-CU).171003-1352)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/383f44422d364daab6360a0dbd8961481/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.5557.00 ((SQL14_SP2_QFE-CU).171003-1352)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/7e546ae16c48449396f2a6c30dc8d35b2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5557.00 ((SQL14_SP2_QFE-CU).171003-1352)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/4daecbd75bfd4b6f9af8fce5ec09aa9d1/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5557.00 ((SQL14_SP2_QFE-CU).171003-1352)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/9fa6bf9d3fb54bb98a5f0124bfb3e14e1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5557.00 ((SQL14_SP2_QFE-CU).171003-1352)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/d04a9e96c37045e98b5c7b3b8b81096d1/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5557.00 ((SQL14_SP2_QFE-CU).171003-1352)
```

# SQL Server 2014 SP2 CU5 - 12.0.5546.0 - x64 (KB4013098)
``` powershell
# SQL Server 2014 SP2 CU5 - 12.0.5546.0 - x64 (KB4013098)
$outputFolder = 'c:\sqlsyms\12.0.5546.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/50741efef953472e93c9c4449641b7b12/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.5546.00 ((SQL14_SP2_QFE-CU).170403-1355)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/eba63b27a035483d8aa8328a1ae4e5032/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5546.00 ((SQL14_SP2_QFE-CU).170403-1355)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/5cf0fb086a51465eae2224c47d6929a12/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5546.00 ((SQL14_SP2_QFE-CU).170403-1355)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/e261efec946a49d8bd60ad2d2d0d4f412/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.5546.00 ((SQL14_SP2_QFE-CU).170403-1355)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/4e1c24324a24404db55cab70549295842/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5546.00 ((SQL14_SP2_QFE-CU).170403-1355)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/b4f8f667b3d14a67b4d6603088e655742/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5546.00 ((SQL14_SP2_QFE-CU).170403-1355)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/236b638fded8473898894137c7838d5c1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.5546.00 ((SQL14_SP2_QFE-CU).170403-1355)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/7ac0b64a624249d9b29869bc24c71bb91/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.5546.00 ((SQL14_SP2_QFE-CU).170403-1355)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/dab7c2d4a1d74357a7e35e4823c201241/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.5546.00 ((SQL14_SP2_QFE-CU).170403-1355)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/6ba2f0c99aac4edfb5f1154130a28aff1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5546.00 ((SQL14_SP2_QFE-CU).170403-1355)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/d4afa77c6b874237bef59d288e3502712/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5546.00 ((SQL14_SP2_QFE-CU).170403-1355)
```

# SQL Server 2014 SP2 CU5 - 12.0.5546.0 - x86 (KB4013098)
``` powershell
# SQL Server 2014 SP2 CU5 - 12.0.5546.0 - x86 (KB4013098)
$outputFolder = 'c:\sqlsyms\12.0.5546.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/7cc57429e0ec49fbbb5a7e0bde3ed2f51/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.5546.00 ((SQL14_SP2_QFE-CU).170403-1355)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/0b763c98cd3540cc87fbae90dd4d293e1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5546.00 ((SQL14_SP2_QFE-CU).170403-1355)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/faebc6f4ea6f4aa9b51dd320a99cdf6a1/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5546.00 ((SQL14_SP2_QFE-CU).170403-1355)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/df2f1f29a7ee42209c3d1083a539cdab1/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.5546.00 ((SQL14_SP2_QFE-CU).170403-1355)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/4e548597f1554021a96df9a125e321c12/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5546.00 ((SQL14_SP2_QFE-CU).170403-1355)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/1c1ab29dd2684425be41d15d14f82eda1/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5546.00 ((SQL14_SP2_QFE-CU).170403-1355)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/52aa8ba5e2dc47a3b05441a95feaaad41/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5546.00 ((SQL14_SP2_QFE-CU).170403-1355)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/41250386e94f4b749067a8bdf653fad31/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5546.00 ((SQL14_SP2_QFE-CU).170403-1355)
```

# SQL Server 2014 SP2 CU4 - 12.0.5540.0 - x64 (KB4010394)
``` powershell
# SQL Server 2014 SP2 CU4 - 12.0.5540.0 - x64 (KB4010394)
$outputFolder = 'c:\sqlsyms\12.0.5540.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/327f327fa575417cafb328a77700579b2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.5540.00 ((SQL14_SP2_QFE-CU).170126-2112)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/b33973d4b2b84e898cf5fdbcc0cbfdda2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5540.00 ((SQL14_SP2_QFE-CU).170126-2112)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/7c3b4d37cd874b8b9046197faa764b8a2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5540.00 ((SQL14_SP2_QFE-CU).170126-2112)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/5c620c62165d4d6c929c48fbf285ecee2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.5540.00 ((SQL14_SP2_QFE-CU).170126-2112)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/573e711ad5ff4306afcf4ead17f3ccd32/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5540.00 ((SQL14_SP2_QFE-CU).170126-2112)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/134dec74500e4623ac8395fd0f7b39002/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5540.00 ((SQL14_SP2_QFE-CU).170126-2112)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/efafa5fc3ed741138011d67be2e0956e1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.5540.00 ((SQL14_SP2_QFE-CU).170126-2112)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/322ab5e1bdb44d00b01fadf709cedb591/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.5540.00 ((SQL14_SP2_QFE-CU).170126-2112)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/2e34b42cd60244c18d4d932740df1fba1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.5540.00 ((SQL14_SP2_QFE-CU).170126-2112)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/5fa1d5a4f5184d8a96340d50ca49b8f91/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5540.00 ((SQL14_SP2_QFE-CU).170126-2112)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/15a01dcd6514423dabf05a79ddbc260c2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5540.00 ((SQL14_SP2_QFE-CU).170126-2112)
```

# SQL Server 2014 SP2 CU4 - 12.0.5540.0 - x86 (KB4010394)
``` powershell
# SQL Server 2014 SP2 CU4 - 12.0.5540.0 - x86 (KB4010394)
$outputFolder = 'c:\sqlsyms\12.0.5540.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/3b24410a96fc4557937d8680025104781/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.5540.00 ((SQL14_SP2_QFE-CU).170126-2112)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/de2cbe9a066b4ca683edb111b07e98fe1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5540.00 ((SQL14_SP2_QFE-CU).170126-2112)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/65d8e8258a7d425b919ff886fef2a46e1/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5540.00 ((SQL14_SP2_QFE-CU).170126-2112)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/a55b0dba79c145579d868184299943121/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.5540.00 ((SQL14_SP2_QFE-CU).170126-2112)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/a45a2e2de940478cb4da26c83ed480c02/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5540.00 ((SQL14_SP2_QFE-CU).170126-2112)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/91505e4ffbab42b0bb9fce392119d2a31/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5540.00 ((SQL14_SP2_QFE-CU).170126-2112)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/51b204af39e4418e8e436b505def119d1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5540.00 ((SQL14_SP2_QFE-CU).170126-2112)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/c8cdb62c1d024e1ebcd1167ea4e408fd1/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5540.00 ((SQL14_SP2_QFE-CU).170126-2112)
```

# SQL Server 2014 SP2 CU3 - 12.0.5538.0 - x64 (KB3204388)
``` powershell
# SQL Server 2014 SP2 CU3 - 12.0.5538.0 - x64 (KB3204388)
$outputFolder = 'c:\sqlsyms\12.0.5538.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/3b2ec8a276c44fdc906942cd4a1f69182/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.5538.00 ((SQL14_SP2_QFE-CU).161215-1705)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/a2983d6c8beb482197eea282afd09f502/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5538.00 ((SQL14_SP2_QFE-CU).161215-1705)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/f15dfc2d86f545358f47d7963137b3772/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5538.00 ((SQL14_SP2_QFE-CU).161215-1705)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/51c7e960bc594a57948755163fc43a492/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.5538.00 ((SQL14_SP2_QFE-CU).161215-1705)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/d11bb61c53bf4b68a2c3ba2527bd73bc2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5538.00 ((SQL14_SP2_QFE-CU).161215-1705)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/bd27195567bb4bf8a03bb27ceec1b7432/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5538.00 ((SQL14_SP2_QFE-CU).161215-1705)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/e48b584befcc4a70adb8046bcf451a2e1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.5538.00 ((SQL14_SP2_QFE-CU).161215-1705)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/b580840b77684d8a8f6eda6fc85965451/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.5538.00 ((SQL14_SP2_QFE-CU).161215-1705)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/94c127c2d37e4e489484c51a03884ac11/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.5538.00 ((SQL14_SP2_QFE-CU).161215-1705)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/7ccaba5c7002409fa220d36307fc2b8b1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5538.00 ((SQL14_SP2_QFE-CU).161215-1705)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/8e5ff8ec981943338edc6cd886bd8fb82/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5538.00 ((SQL14_SP2_QFE-CU).161215-1705)
```

# SQL Server 2014 SP2 CU3 - 12.0.5538.0 - x86 (KB3204388)
``` powershell
# SQL Server 2014 SP2 CU3 - 12.0.5538.0 - x86 (KB3204388)
$outputFolder = 'c:\sqlsyms\12.0.5538.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/baa30c554cb44fa09d0bdfbed39e5a791/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.5538.00 ((SQL14_SP2_QFE-CU).161215-1705)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/3dd488b8d441453dbd8745f0a544e7a61/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5538.00 ((SQL14_SP2_QFE-CU).161215-1705)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/47108c8b37424ae8851820cfe82c9e121/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5538.00 ((SQL14_SP2_QFE-CU).161215-1705)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/b8d1890d88e746a998e86b2f3c74364c1/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.5538.00 ((SQL14_SP2_QFE-CU).161215-1705)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/848570152cb8402aa9d6fada8beb0c202/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5538.00 ((SQL14_SP2_QFE-CU).161215-1705)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/dde9b5fc95434bcdaf74b851a180a39a1/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5538.00 ((SQL14_SP2_QFE-CU).161215-1705)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/f57e00c99b1542da9050e3c79e4fc0751/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5538.00 ((SQL14_SP2_QFE-CU).161215-1705)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/ad0a17bd74a343c68885438c5a1667261/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5538.00 ((SQL14_SP2_QFE-CU).161215-1705)
```

# SQL Server 2014 SP2 CU2 - 12.0.5522.0 - x64 (KB3188778)
``` powershell
# SQL Server 2014 SP2 CU2 - 12.0.5522.0 - x64 (KB3188778)
$outputFolder = 'c:\sqlsyms\12.0.5522.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/85619806cd0c4d7f80b7d9c39ec0c55d2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.5522.00 ((SQL14_PCU_main).160921-2323)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/b7c764dde62d4501ad899b44155266f42/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5522.00 ((SQL14_PCU_main).160921-2323)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/42c45987637146d9b0b6a18b3c16b4ed2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5522.00 ((SQL14_PCU_main).160921-2323)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/a0718d2fb2484e6a9690d00a513a7ec22/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.5522.00 ((SQL14_PCU_main).160921-2323)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/925f17833290448e8a4a1981956919f72/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5522.00 ((SQL14_PCU_main).160921-2323)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/f8b1d43023e94a69ad0ebdbdef8184262/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5522.00 ((SQL14_PCU_main).160921-2323)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/cec32d3f65ae45e8a01456021c1965331/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.5522.00 ((SQL14_PCU_main).160921-2323)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/e5b418e31d1e4c7288dce466806e4a651/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.5522.00 ((SQL14_PCU_main).160921-2323)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/e0a453b334904529a2b117ea1654e0071/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.5522.00 ((SQL14_PCU_main).160921-2323)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/46ca775ce2b347cf9a0497239589b9891/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5522.00 ((SQL14_PCU_main).160921-2323)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/944350d206c94698a2d2836213aa3cd42/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5522.00 ((SQL14_PCU_main).160921-2323)
```

# SQL Server 2014 SP2 CU2 - 12.0.5522.0 - x86 (KB3188778)
``` powershell
# SQL Server 2014 SP2 CU2 - 12.0.5522.0 - x86 (KB3188778)
$outputFolder = 'c:\sqlsyms\12.0.5522.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/84f5af3698d149afa148b2a0cd3f4f581/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.5522.00 ((SQL14_PCU_main).160921-2323)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/213e8207dbe444d0909729961a287bd11/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5522.00 ((SQL14_PCU_main).160921-2323)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/4bc737f7ee4c42ddabdc2dbd286531231/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5522.00 ((SQL14_PCU_main).160921-2323)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/b288a2b59dc74ac7b41ab91de6c4fc761/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.5522.00 ((SQL14_PCU_main).160921-2323)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/ffa4bbede27e459680aa2c3492dc76de2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5522.00 ((SQL14_PCU_main).160921-2323)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/cff1f891748b4e46975bff972020c88d1/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5522.00 ((SQL14_PCU_main).160921-2323)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/68063a6d27944efc9b396708c391443a1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5522.00 ((SQL14_PCU_main).160921-2323)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/50ee2c4f4dba45cbabed0418e30529771/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5522.00 ((SQL14_PCU_main).160921-2323)
```

# SQL Server 2014 SP2 CU1 - 12.0.5511.0 - x64 (KB3178925)
``` powershell
# SQL Server 2014 SP2 CU1 - 12.0.5511.0 - x64 (KB3178925)
$outputFolder = 'c:\sqlsyms\12.0.5511.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/955297012f084a879c084982baeb90802/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.5511.00 ((SQL14_PCU_main).160819-1335)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/6c97245a05ce4bb99d73b38531d5c1fd2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5511.00 ((SQL14_PCU_main).160819-1335)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/115b0bf758864697975c5a790169856e2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5511.00 ((SQL14_PCU_main).160819-1335)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/512c482f3fb045bda66e04e34964fb3a2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.5511.00 ((SQL14_PCU_main).160819-1335)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/f769c28a891e437a9c794fc1ec7472752/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5511.00 ((SQL14_PCU_main).160819-1335)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/f143a40c5a8440bf8478537feeee5d642/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5511.00 ((SQL14_PCU_main).160819-1335)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/b17b7a8868cb42579bae8551a8c7e0591/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.5511.00 ((SQL14_PCU_main).160819-1335)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/e2182fd204d84ab99011cccd1949e9c11/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.5511.00 ((SQL14_PCU_main).160819-1335)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/27105a4614ac45c2ae4efbf8702e3afc1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.5511.00 ((SQL14_PCU_main).160819-1335)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/40b6d2eebb0d495ca7712c349427f5de1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5511.00 ((SQL14_PCU_main).160819-1335)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/5f5f15692fa448e79427eb55f742b9512/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5511.00 ((SQL14_PCU_main).160819-1335)
```

# SQL Server 2014 SP2 CU1 - 12.0.5511.0 - x86 (KB3178925)
``` powershell
# SQL Server 2014 SP2 CU1 - 12.0.5511.0 - x86 (KB3178925)
$outputFolder = 'c:\sqlsyms\12.0.5511.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/7cfba95f3823488aac2461a3e97e896f1/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.5511.00 ((SQL14_PCU_main).160819-1335)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/da9e2bc4951043bd81090ae40dede7a11/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5511.00 ((SQL14_PCU_main).160819-1335)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/aeff84391a5b452fbfcde0f4a892c5a11/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5511.00 ((SQL14_PCU_main).160819-1335)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/5939ac9c2ded4145bcf7770744fd2bce1/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.5511.00 ((SQL14_PCU_main).160819-1335)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/29a54a98b892439391394e42b0b5db512/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5511.00 ((SQL14_PCU_main).160819-1335)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/ed2df1c1d06e4545bdf23aaaaf209acc1/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5511.00 ((SQL14_PCU_main).160819-1335)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/e1cccd08ad4847b7b40a5d54d95e458e1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5511.00 ((SQL14_PCU_main).160819-1335)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/8ca704ad75a147c083468e8128a8d1c71/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5511.00 ((SQL14_PCU_main).160819-1335)
```

# SQL Server 2014 SP2 SP2 - 12.0.5000.0 - x64 (KB3171021)
``` powershell
# SQL Server 2014 SP2 SP2 - 12.0.5000.0 - x64 (KB3171021)
$outputFolder = 'c:\sqlsyms\12.0.5000.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/9b03bed67fb8409cb0790cc7b223dad92/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.5000.00 ((SQL14_PCU_main).160617-1804)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/d06bb22769e2403894634bf47dced50d2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5000.00 ((SQL14_PCU_main).160617-1804)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/4505a8d6fda14645ba80e4c411ed63512/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5000.00 ((SQL14_PCU_main).160617-1804)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/421f256c2b694c9f997cc27b691db8e82/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.5000.00 ((SQL14_PCU_main).160617-1804)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/581e38dca5b2499ea574ffc0173d6bb12/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5000.00 ((SQL14_PCU_main).160617-1804)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/ca529b22f161423c9266aa03928136612/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5000.00 ((SQL14_PCU_main).160617-1804)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/16d952f37ecc4c839f06fc3f0a8e858b1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.5000.00 ((SQL14_PCU_main).160617-1804)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/49e9ae321a004d859a4844a1881682fd1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.5000.00 ((SQL14_PCU_main).160617-1804)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/e2bbf32382d24e16a4567c49dffedc1a1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.5000.00 ((SQL14_PCU_main).160617-1804)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/bdcaa196c0824ba38ddec076b5fd89521/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5000.00 ((SQL14_PCU_main).160617-1804)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/cc3cd23e34174332ae8778d4e4b7991f2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5000.00 ((SQL14_PCU_main).160617-1804)
```

# SQL Server 2014 SP2 SP2 - 12.0.5000.0 - x86 (KB3171021)
``` powershell
# SQL Server 2014 SP2 SP2 - 12.0.5000.0 - x86 (KB3171021)
$outputFolder = 'c:\sqlsyms\12.0.5000.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/3520a09c560647b0be4af33b838bb70f1/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.5000.00 ((SQL14_PCU_main).160617-1804)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/d0a102b60e2d4138a7435f98d7305ed21/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.5000.00 ((SQL14_PCU_main).160617-1804)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/739a59d06bce47de8b1bf3d77899ba601/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.5000.00 ((SQL14_PCU_main).160617-1804)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/34d38d0ff9ad490cb7c02c96ee741a651/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.5000.00 ((SQL14_PCU_main).160617-1804)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/16e45d5242524db7a022a600e0a58bd12/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.5000.00 ((SQL14_PCU_main).160617-1804)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/3105a463134247deb442c42904dd6af61/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.5000.00 ((SQL14_PCU_main).160617-1804)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/f54482c3160047a0bffd5ee829fc930c1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.5000.00 ((SQL14_PCU_main).160617-1804)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/4ef9cb8fd3c141bcb4f1af7c26cbf7571/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.5000.00 ((SQL14_PCU_main).160617-1804)
```

# SQL Server 2014 SP1 CU12 - 12.0.4511.0 - x64 (KB4017793)
``` powershell
# SQL Server 2014 SP1 CU12 - 12.0.4511.0 - x64 (KB4017793)
$outputFolder = 'c:\sqlsyms\12.0.4511.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/5194020c2bb54e35b975fb4b822687822/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.4511.00 ((SQL14_SP1_QFE-CU).170330-2026)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/c3e92c0187324b64902b44eb0d2e42ed2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4511.00 ((SQL14_SP1_QFE-CU).170330-2026)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/828309d8e65a4661bef26612e6c66da12/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4511.00 ((SQL14_SP1_QFE-CU).170330-2026)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/d17b6b1b84b74212b072a8b5bdd573b92/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.4511.00 ((SQL14_SP1_QFE-CU).170330-2026)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/15ed0973c9214f76b84dce1924c47f2c2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4511.00 ((SQL14_SP1_QFE-CU).170330-2026)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/5347b58cfec447408dea4ef359a7fee82/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4511.00 ((SQL14_SP1_QFE-CU).170330-2026)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/63966ccc66c6484197a1c5472f9ffba61/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.4511.00 ((SQL14_SP1_QFE-CU).170330-2026)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/15bee1647bc8463e9222aae1c310334a1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.4511.00 ((SQL14_SP1_QFE-CU).170330-2026)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/b8e0b1f00b4c47c3817d8d3211bd97eb1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.4511.00 ((SQL14_SP1_QFE-CU).170330-2026)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/7f74ffbfb5634301908b7c0a815e1e811/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4511.00 ((SQL14_SP1_QFE-CU).170330-2026)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/c0bb53c9d4624637846157dcba6945322/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4511.00 ((SQL14_SP1_QFE-CU).170330-2026)
```

# SQL Server 2014 SP1 CU12 - 12.0.4511.0 - x86 (KB4017793)
``` powershell
# SQL Server 2014 SP1 CU12 - 12.0.4511.0 - x86 (KB4017793)
$outputFolder = 'c:\sqlsyms\12.0.4511.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/1716ba550f704b47be04801c46ddd2271/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.4511.00 ((SQL14_SP1_QFE-CU).170330-2026)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/b07fe01e0c1d4fafadf3b3ae1198b23c1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4511.00 ((SQL14_SP1_QFE-CU).170330-2026)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/5b2e3ff1f9ea426bb60c065573ba35851/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4511.00 ((SQL14_SP1_QFE-CU).170330-2026)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/06525a5e3eb34b839bfc1af702354c0f1/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.4511.00 ((SQL14_SP1_QFE-CU).170330-2026)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/5b0356ce9df44d3ebc3aaf4752c4dbc42/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4511.00 ((SQL14_SP1_QFE-CU).170330-2026)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/cfe4d232673d4feca1536f22af5d7da01/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4511.00 ((SQL14_SP1_QFE-CU).170330-2026)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/1638c8bafaa4484f8115dc810f65688c1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4511.00 ((SQL14_SP1_QFE-CU).170330-2026)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/0cb40d6a5aee4627a803997293d2bc9f1/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4511.00 ((SQL14_SP1_QFE-CU).170330-2026)
```

# SQL Server 2014 SP1 CU11 - 12.0.4502.0 - x64 (KB4010392)
``` powershell
# SQL Server 2014 SP1 CU11 - 12.0.4502.0 - x64 (KB4010392)
$outputFolder = 'c:\sqlsyms\12.0.4502.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/6511e1af7762429a824f8d9413f8185b2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.4502.00 ((SQL14_SP1_QFE-CU).170126-2035)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/0855528f0c094a8d9ddaa082dc6273892/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4502.00 ((SQL14_SP1_QFE-CU).170126-2035)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/2d502c894cf145449e35bb27b9e723632/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4502.00 ((SQL14_SP1_QFE-CU).170126-2035)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/4e718d4e6aaa4267a812e7a96d96e4192/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.4502.00 ((SQL14_SP1_QFE-CU).170126-2035)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/e3bc90eb56494cef8d0bb1c27630e7e82/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4502.00 ((SQL14_SP1_QFE-CU).170126-2035)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/79e86271788b4ad8a73585aca0712a572/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4502.00 ((SQL14_SP1_QFE-CU).170126-2035)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/74b685c445be4b0abc1e40a39b1ce15e1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.4502.00 ((SQL14_SP1_QFE-CU).170126-2035)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/fdad2621c0fd4be18f295ef7666f71541/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.4502.00 ((SQL14_SP1_QFE-CU).170126-2035)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/fead2b11478e4f16957015b1c716dbf51/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.4502.00 ((SQL14_SP1_QFE-CU).170126-2035)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/2fef4d7e355741078263ba0359236cb51/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4502.00 ((SQL14_SP1_QFE-CU).170126-2035)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/baa3f42ceb4441f0a0362400473a45a32/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4502.00 ((SQL14_SP1_QFE-CU).170126-2035)
```

# SQL Server 2014 SP1 CU11 - 12.0.4502.0 - x86 (KB4010392)
``` powershell
# SQL Server 2014 SP1 CU11 - 12.0.4502.0 - x86 (KB4010392)
$outputFolder = 'c:\sqlsyms\12.0.4502.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/05c3adbed7b94c678abd5818fb1df1981/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.4502.00 ((SQL14_SP1_QFE-CU).170126-2035)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/4e38ef962bd44249a4374f46e4918e491/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4502.00 ((SQL14_SP1_QFE-CU).170126-2035)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/1f790bbb27d94e7d8f76905be4ea8a8a1/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4502.00 ((SQL14_SP1_QFE-CU).170126-2035)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/118dcefd951242c2b376ce23b8ca149d1/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.4502.00 ((SQL14_SP1_QFE-CU).170126-2035)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/16bba5c457c24f71816590513599284d2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4502.00 ((SQL14_SP1_QFE-CU).170126-2035)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/1c2171f6e4c942a78d884a965ca2c2311/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4502.00 ((SQL14_SP1_QFE-CU).170126-2035)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/b2e5cdea0e254b88aec4f52ff7d81bce1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4502.00 ((SQL14_SP1_QFE-CU).170126-2035)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/22ff6b3197a54e6d8e424fb153ee85291/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4502.00 ((SQL14_SP1_QFE-CU).170126-2035)
```

# SQL Server 2014 SP1 CU10 - 12.0.4491.0 - x64 (KB3204399)
``` powershell
# SQL Server 2014 SP1 CU10 - 12.0.4491.0 - x64 (KB3204399)
$outputFolder = 'c:\sqlsyms\12.0.4491.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/9d45c0ca9ff84210bd26d27a1db957b32/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.4491.00 ((SQL14_SP1_QFE-CU).161209-1421)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/fed498da893e422cac5e804b2b7a4c242/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4491.00 ((SQL14_SP1_QFE-CU).161209-1421)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/2ad37367352148f6979dfdc99264bead2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4491.00 ((SQL14_SP1_QFE-CU).161209-1421)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/9d0d6af6a3844491ba66db3b3a0e41992/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.4491.00 ((SQL14_SP1_QFE-CU).161209-1421)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/cdb4ecf4e5554b98963cfc8713f18def2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4491.00 ((SQL14_SP1_QFE-CU).161209-1421)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/f524bcc24a0a4a09aeac95cdd7ff44cc2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4491.00 ((SQL14_SP1_QFE-CU).161209-1421)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/018fb92048554db0b8ce8d938f36c1af1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.4491.00 ((SQL14_SP1_QFE-CU).161209-1421)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/6f4088e11c2141038659ad6f5d75d67e1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.4491.00 ((SQL14_SP1_QFE-CU).161209-1421)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/ef95d5619182441cba33ee5fcc0db2a11/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.4491.00 ((SQL14_SP1_QFE-CU).161209-1421)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/e6bbf5f834c248888873d9a1a9644be91/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4491.00 ((SQL14_SP1_QFE-CU).161209-1421)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/ed041be3c310451d8c409219c552e7f32/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4491.00 ((SQL14_SP1_QFE-CU).161209-1421)
```

# SQL Server 2014 SP1 CU10 - 12.0.4491.0 - x86 (KB3204399)
``` powershell
# SQL Server 2014 SP1 CU10 - 12.0.4491.0 - x86 (KB3204399)
$outputFolder = 'c:\sqlsyms\12.0.4491.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/d2366262dd7941978da45d5e683f7c101/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.4491.00 ((SQL14_SP1_QFE-CU).161209-1421)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/d800a487ae16476aad1a1d3a6000b3d81/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4491.00 ((SQL14_SP1_QFE-CU).161209-1421)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/47e138b038f94533b40e4cda75009dd11/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4491.00 ((SQL14_SP1_QFE-CU).161209-1421)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/ea65c57da53241919f6b2c099baddf6b1/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.4491.00 ((SQL14_SP1_QFE-CU).161209-1421)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/300035b8a93d4361bb955f88c14a9ec02/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4491.00 ((SQL14_SP1_QFE-CU).161209-1421)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/5d479ce08c8f4a3189fc00cb7d96396f1/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4491.00 ((SQL14_SP1_QFE-CU).161209-1421)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/8b12d29053264fc798fb8b7312f457a61/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4491.00 ((SQL14_SP1_QFE-CU).161209-1421)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/40548e898f644819908b614970e763f51/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4491.00 ((SQL14_SP1_QFE-CU).161209-1421)
```

# SQL Server 2014 SP1 CU9 - 12.0.4474.0 - x64 (KB3186964)
``` powershell
# SQL Server 2014 SP1 CU9 - 12.0.4474.0 - x64 (KB3186964)
$outputFolder = 'c:\sqlsyms\12.0.4474.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/ed3eb06f842543d287a3f4b7976a290e2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.4474.00 ((SQL14_SP1_QFE-CU).160921-2215)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/f68fd847991e45efb467567f043365c92/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4474.00 ((SQL14_SP1_QFE-CU).160921-2215)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/f39da543554a46fa9f66356d10ae25ba2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4474.00 ((SQL14_SP1_QFE-CU).160921-2215)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/4e632d1dba694b07b1420d42203131fb2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.4474.00 ((SQL14_SP1_QFE-CU).160921-2215)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/e6b6452458da4bfb90b095db670835ba2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4474.00 ((SQL14_SP1_QFE-CU).160921-2215)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/459d7854b8b442f7a7d16164e13d223e2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4474.00 ((SQL14_SP1_QFE-CU).160921-2215)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/dbbebce79710422da003b9b362db90471/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.4474.00 ((SQL14_SP1_QFE-CU).160921-2215)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/039cb07174774ae984a6c127254d699b1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.4474.00 ((SQL14_SP1_QFE-CU).160921-2215)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/cd5d4f223a81432b9a94c70f090bdbfa1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.4474.00 ((SQL14_SP1_QFE-CU).160921-2215)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/587aafcade5c4befb8a21f74a0472f991/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4474.00 ((SQL14_SP1_QFE-CU).160921-2215)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/40263aec90934578b565fd5738ab0fe82/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4474.00 ((SQL14_SP1_QFE-CU).160921-2215)
```

# SQL Server 2014 SP1 CU9 - 12.0.4474.0 - x86 (KB3186964)
``` powershell
# SQL Server 2014 SP1 CU9 - 12.0.4474.0 - x86 (KB3186964)
$outputFolder = 'c:\sqlsyms\12.0.4474.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/a2983e7c5b434d9fbc6828950649cd531/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.4474.00 ((SQL14_SP1_QFE-CU).160921-2215)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/814705e58f2a452282645ab653b330771/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4474.00 ((SQL14_SP1_QFE-CU).160921-2215)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/d29ed6114bab459499a99eb2aa5c9d901/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4474.00 ((SQL14_SP1_QFE-CU).160921-2215)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/5577ca7998974f91a2830c9130544b4b1/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.4474.00 ((SQL14_SP1_QFE-CU).160921-2215)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/f5a4f8db221443c88c6c01c2097d5f012/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4474.00 ((SQL14_SP1_QFE-CU).160921-2215)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/8addcf093cf549e5b363e7bc4c1ff3d21/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4474.00 ((SQL14_SP1_QFE-CU).160921-2215)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/7ab2c10294bc42ba84947f929ef553501/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4474.00 ((SQL14_SP1_QFE-CU).160921-2215)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/9256f9eed09947189e79d8d088a780771/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4474.00 ((SQL14_SP1_QFE-CU).160921-2215)
```

# SQL Server 2014 SP1 CU8 - 12.0.4468.0 - x64 (KB3174038)
``` powershell
# SQL Server 2014 SP1 CU8 - 12.0.4468.0 - x64 (KB3174038)
$outputFolder = 'c:\sqlsyms\12.0.4468.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/3d92fd2a73794d07b455ae4e5889a5132/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.4468.00 ((SQL14_SP1_QFE-CU).160807-1306)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/b3729fa94bef405fb2cb87260238c9f42/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4468.00 ((SQL14_SP1_QFE-CU).160807-1306)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/5ce178c1c5d64b0c87dfe545697274d42/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4468.00 ((SQL14_SP1_QFE-CU).160807-1306)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/3cad76e8bd284c3d843ddf72eebdeb6f2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.4468.00 ((SQL14_SP1_QFE-CU).160807-1306)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/690748ff94a84fe2a84415950be20d8b2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4468.00 ((SQL14_SP1_QFE-CU).160807-1306)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/c96238046bc24361b06e16837730d61a2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4468.00 ((SQL14_SP1_QFE-CU).160807-1306)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/2a89258be7de4ce9b48dbb73a55d324d1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.4468.00 ((SQL14_SP1_QFE-CU).160807-1306)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/95e6fa8b9aee433684c70867ff60a4e61/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.4468.00 ((SQL14_SP1_QFE-CU).160807-1306)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/0c553a702c974f208644a405b541f85c1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.4468.00 ((SQL14_SP1_QFE-CU).160807-1306)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/db5a292a8769461583541a15ebe202611/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4468.00 ((SQL14_SP1_QFE-CU).160807-1306)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/13c47c3e18bb421fa3249689a54a71102/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4468.00 ((SQL14_SP1_QFE-CU).160807-1306)
```

# SQL Server 2014 SP1 CU8 - 12.0.4468.0 - x86 (KB3174038)
``` powershell
# SQL Server 2014 SP1 CU8 - 12.0.4468.0 - x86 (KB3174038)
$outputFolder = 'c:\sqlsyms\12.0.4468.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/65f204610ef64b91a0fd8794150b94291/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.4468.00 ((SQL14_SP1_QFE-CU).160807-1306)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/1a01ea9849824b6c9d89022a9165081d1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4468.00 ((SQL14_SP1_QFE-CU).160807-1306)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/acfc80b3b2b14e0e8c44bb5638a59e011/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4468.00 ((SQL14_SP1_QFE-CU).160807-1306)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/a1112b3c01de49d3bf7df61d9421bb671/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.4468.00 ((SQL14_SP1_QFE-CU).160807-1306)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/d3657353614f4ee8adb22730dcb9dd0f2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4468.00 ((SQL14_SP1_QFE-CU).160807-1306)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/633bdb5f043c4d5eb8ab475398f1d6b31/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4468.00 ((SQL14_SP1_QFE-CU).160807-1306)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/8142bc3f8c344dd2a3f6a5f9b8accbc91/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4468.00 ((SQL14_SP1_QFE-CU).160807-1306)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/d5882b2e79e648a880c48dbf9aa04b751/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4468.00 ((SQL14_SP1_QFE-CU).160807-1306)
```

# SQL Server 2014 SP1 CU7 - 12.0.4459.0 - x64 (KB3162659)
``` powershell
# SQL Server 2014 SP1 CU7 - 12.0.4459.0 - x64 (KB3162659)
$outputFolder = 'c:\sqlsyms\12.0.4459.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/9e6af119e0f34e8284af02aeb6c2aed32/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.4459.00 ((SQL14_SP1_QFE-CU).160527-1445)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/2be68cda7aca40769bedc7911c47199e2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4459.00 ((SQL14_SP1_QFE-CU).160527-1445)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/51a3a33ea06c4b6fa7ba5f3a872f475b2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4459.00 ((SQL14_SP1_QFE-CU).160527-1445)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/e90c807a4c35455a820c37c0d50b4b232/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.4459.00 ((SQL14_SP1_QFE-CU).160527-1445)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/b61b9c7dcab24b45922994aca824ef672/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4459.00 ((SQL14_SP1_QFE-CU).160527-1445)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/619dd10c6677476c9b9d849815196fa32/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4459.00 ((SQL14_SP1_QFE-CU).160527-1445)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/433c6e1e9a8945498db235a0b52cde5e1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.4459.00 ((SQL14_SP1_QFE-CU).160527-1445)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/fa3d2944dc8846d3bcc61c2e7ee065281/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.4459.00 ((SQL14_SP1_QFE-CU).160527-1445)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/58c10d6cf94142c985df4771e46cb2371/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.4459.00 ((SQL14_SP1_QFE-CU).160527-1445)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/a27d505e013f4048877030aa5e518ea51/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4459.00 ((SQL14_SP1_QFE-CU).160527-1445)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/f27d6b48d60d41b685ab306cdd9a51ac2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4459.00 ((SQL14_SP1_QFE-CU).160527-1445)
```

# SQL Server 2014 SP1 CU7 - 12.0.4459.0 - x86 (KB3162659)
``` powershell
# SQL Server 2014 SP1 CU7 - 12.0.4459.0 - x86 (KB3162659)
$outputFolder = 'c:\sqlsyms\12.0.4459.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/6fff44d1682f4a9495ec0d87165558441/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.4459.00 ((SQL14_SP1_QFE-CU).160527-1445)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/92d19dff78a545049ba60ecbb778e1b81/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4459.00 ((SQL14_SP1_QFE-CU).160527-1445)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/ad454e7f63754f3f8ea5182420e1a95c1/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4459.00 ((SQL14_SP1_QFE-CU).160527-1445)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/9228212f994f44d5b53f3ab7dd3356cc1/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.4459.00 ((SQL14_SP1_QFE-CU).160527-1445)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/8578316b4f5d4354a53ec2cfd55481022/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4459.00 ((SQL14_SP1_QFE-CU).160527-1445)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/bd487adc6b904a848c1231663606b3f31/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4459.00 ((SQL14_SP1_QFE-CU).160527-1445)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/1832bee682d6478cadcc049a8e7f667c1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4459.00 ((SQL14_SP1_QFE-CU).160527-1445)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/274a8b7eca104af493f554023e54b1511/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4459.00 ((SQL14_SP1_QFE-CU).160527-1445)
```

# SQL Server 2014 SP1 CU6 - 12.0.4457.0 - x64 (KB3167392)
``` powershell
# SQL Server 2014 SP1 CU6 - 12.0.4457.0 - x64 (KB3167392)
$outputFolder = 'c:\sqlsyms\12.0.4457.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/0d205c1fa08b4e30be8d57b0b66f7aad2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.4457.00 ((SQL14_SP_QFE-OD).160526-2301)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/ca933e39df4a4a06877ec27e0ca8635c2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4457.00 ((SQL14_SP_QFE-OD).160526-2301)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/73bb9ef1b6d444949ec88857e9ad1a282/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4457.00 ((SQL14_SP_QFE-OD).160526-2301)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/8405542cc1254c03a666cb742da51ea72/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.4457.00 ((SQL14_SP_QFE-OD).160526-2301)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/95315aebcf874ef0bb34618350d666432/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4457.00 ((SQL14_SP_QFE-OD).160526-2301)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/c6bebcd7804e461f9efd30cabf8e8f8a2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4457.00 ((SQL14_SP_QFE-OD).160526-2301)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/79d2d1bdc00b4d4eba2870d71a3dd2d61/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.4457.00 ((SQL14_SP_QFE-OD).160526-2301)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/a8ccc254a9e6493295a6bca4bfaa61401/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.4457.00 ((SQL14_SP_QFE-OD).160526-2301)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/fae429df4a7f4b2fb2654331aed0ac171/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.4457.00 ((SQL14_SP_QFE-OD).160526-2301)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/b950a8b8c82d4963b5c9dd17c8d278d41/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4457.00 ((SQL14_SP_QFE-OD).160526-2301)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/f44520516b3d4f4eba97077627392c722/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4457.00 ((SQL14_SP_QFE-OD).160526-2301)
```

# SQL Server 2014 SP1 CU6 - 12.0.4457.0 - x86 (KB3167392)
``` powershell
# SQL Server 2014 SP1 CU6 - 12.0.4457.0 - x86 (KB3167392)
$outputFolder = 'c:\sqlsyms\12.0.4457.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/e20a40c355fc4e44a73ebc5e6f9aedff1/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.4457.00 ((SQL14_SP_QFE-OD).160526-2301)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/46bbfbc5d91f42e49d4787fdb099ac611/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4457.00 ((SQL14_SP_QFE-OD).160526-2301)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/4fc6d961f7114c9b99d7a889580a49451/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4457.00 ((SQL14_SP_QFE-OD).160526-2301)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/205de64132184b59aae89e227e12d54d1/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.4457.00 ((SQL14_SP_QFE-OD).160526-2301)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/10f36fe6efa44624bd46211d0d8cb4202/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4457.00 ((SQL14_SP_QFE-OD).160526-2301)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/349d89ce6e074117afa7cf153ccc510c1/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4457.00 ((SQL14_SP_QFE-OD).160526-2301)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/b0785ae48497462bac6fd725dfb8517f1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4457.00 ((SQL14_SP_QFE-OD).160526-2301)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/71d4f69079d846b192583ae1293d14c91/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4457.00 ((SQL14_SP_QFE-OD).160526-2301)
```

# SQL Server 2014 SP1 CU6 (Deprecated) - 12.0.4449.0 - x64 (KB3144524)
``` powershell
# SQL Server 2014 SP1 CU6 (Deprecated) - 12.0.4449.0 - x64 (KB3144524)
$outputFolder = 'c:\sqlsyms\12.0.4449.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/541dc558cad74e0694256b9a79761f922/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.4449.00 ((SQL14_SP1_QFE-CU).160413-1153)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/8a5052b8ff7345599f6f242cf4f3e09f2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4449.00 ((SQL14_SP1_QFE-CU).160413-1153)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/8a62d7af769a4f2c864d2b808ab81dfe2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4449.00 ((SQL14_SP1_QFE-CU).160413-1153)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/251fdfd9e8454621b19032d327a2fbbf2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.4449.00 ((SQL14_SP1_QFE-CU).160413-1153)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/6cf73332314548c29f5d02b19d98963b2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4449.00 ((SQL14_SP1_QFE-CU).160413-1153)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/55742e7e85204da4818d8a730a2f70852/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4449.00 ((SQL14_SP1_QFE-CU).160413-1153)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/1a20c516b71c4ee9a74d40cd5b3597631/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.4449.00 ((SQL14_SP1_QFE-CU).160413-1153)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/db864229a8b14fce99322d74a808b8d61/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.4449.00 ((SQL14_SP1_QFE-CU).160413-1153)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/db0d700ed8dd45349808c9c8078f7c1d1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.4449.00 ((SQL14_SP1_QFE-CU).160413-1153)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/42213ff00a944645a6752810210b9c4f1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4449.00 ((SQL14_SP1_QFE-CU).160413-1153)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/bba4a2d05f6b4a7da8cb248ae45a322a2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4449.00 ((SQL14_SP1_QFE-CU).160413-1153)
```

# SQL Server 2014 SP1 CU6 (Deprecated) - 12.0.4449.0 - x86 (KB3144524)
``` powershell
# SQL Server 2014 SP1 CU6 (Deprecated) - 12.0.4449.0 - x86 (KB3144524)
$outputFolder = 'c:\sqlsyms\12.0.4449.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/ff6fa640813246d6b61408f766f2ba301/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.4449.00 ((SQL14_SP1_QFE-CU).160413-1153)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/79a658164e2e44e482bca7933ae40daf1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4449.00 ((SQL14_SP1_QFE-CU).160413-1153)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/9871f564b21d489591a9d62997125cfe1/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4449.00 ((SQL14_SP1_QFE-CU).160413-1153)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/b12da1e6770a4cb7819bae2c4d8ab0fb1/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.4449.00 ((SQL14_SP1_QFE-CU).160413-1153)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/326123b149634674bdb729d1f67111da2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4449.00 ((SQL14_SP1_QFE-CU).160413-1153)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/dc4d9c2424574034b47f8c3f62d96cee1/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4449.00 ((SQL14_SP1_QFE-CU).160413-1153)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/011a3a3c5ee64a52bbfbb132c3c067011/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4449.00 ((SQL14_SP1_QFE-CU).160413-1153)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/5867019c5089413eb07654da21ad9eb21/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4449.00 ((SQL14_SP1_QFE-CU).160413-1153)
```

# SQL Server 2014 SP1 CU5 - 12.0.4439.1 - x64 (KB3130926)
``` powershell
# SQL Server 2014 SP1 CU5 - 12.0.4439.1 - x64 (KB3130926)
$outputFolder = 'c:\sqlsyms\12.0.4439.1\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/8c05af1cd714431692715e7c894227922/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.4439.01 ((SQL14_SP1_QFE-CU).160215-1104)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/9d7930b2b40d4a76882ff6e932d114ea2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4439.01 ((SQL14_SP1_QFE-CU).160215-1104)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/3620205f1aa146fc8fb261528826e9252/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4439.01 ((SQL14_SP1_QFE-CU).160215-1104)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/a4841e65bbea49e8b8fb034d059b1f3a2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.4439.01 ((SQL14_SP1_QFE-CU).160215-1104)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/51bd4d350e134a0788e8e5082f7b5df22/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4439.01 ((SQL14_SP1_QFE-CU).160215-1104)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/040e2fe727c3407584cf8ec849b8ec752/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4439.01 ((SQL14_SP1_QFE-CU).160215-1104)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/ee405fe12c294db58642f2aaab531b541/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.4439.01 ((SQL14_SP1_QFE-CU).160215-1104)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/19c41b55d37f49c9a1ae06318c57e8d11/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.4439.01 ((SQL14_SP1_QFE-CU).160215-1104)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/b4b47d122cc049cbb8f6781a308dda711/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.4439.01 ((SQL14_SP1_QFE-CU).160215-1104)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/a1181e9122f6449b8283138dbe7117171/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4439.01 ((SQL14_SP1_QFE-CU).160215-1104)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/748dfbd824714b7784555b943be771552/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4439.01 ((SQL14_SP1_QFE-CU).160215-1104)
```

# SQL Server 2014 SP1 CU5 - 12.0.4439.1 - x86 (KB3130926)
``` powershell
# SQL Server 2014 SP1 CU5 - 12.0.4439.1 - x86 (KB3130926)
$outputFolder = 'c:\sqlsyms\12.0.4439.1\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/98b4120a06c3471f972576543f15ac971/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.4439.01 ((SQL14_SP1_QFE-CU).160215-1104)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/dd78d54baaeb4fcfa8ec3adac01727ee1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4439.01 ((SQL14_SP1_QFE-CU).160215-1104)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/0e9fc78f89ab4d5297fc3ade50fa39f51/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4439.01 ((SQL14_SP1_QFE-CU).160215-1104)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/71a0972911d64d6d89202a102f4e36331/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.4439.01 ((SQL14_SP1_QFE-CU).160215-1104)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/e8f53d675d904f2ab71e74b2619f6f612/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4439.01 ((SQL14_SP1_QFE-CU).160215-1104)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/0ccdcf5f1baa43bb8fe10be379928bc21/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4439.01 ((SQL14_SP1_QFE-CU).160215-1104)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/b4cea174690147acad1b103353feaad01/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4439.01 ((SQL14_SP1_QFE-CU).160215-1104)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/da27c83c09ec4ebfb0df22b5746adc711/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4439.01 ((SQL14_SP1_QFE-CU).160215-1104)
```

# SQL Server 2014 SP1 CU4 - 12.0.4436.0 - x64 (KB3106660)
``` powershell
# SQL Server 2014 SP1 CU4 - 12.0.4436.0 - x64 (KB3106660)
$outputFolder = 'c:\sqlsyms\12.0.4436.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/362a8410d21b4d39ac0e7a02cc9c2c372/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.4436.00 ((SQL14_SP1_QFE-CU).151202-1517)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/681476d84d7d40f186d3ea82a2661c672/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4436.00 ((SQL14_SP1_QFE-CU).151202-1517)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/a31f385046b54b9cbaf08c4df972c6782/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4436.00 ((SQL14_SP1_QFE-CU).151202-1517)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/8a3fe11c189b4435bcbe953f4841d99f2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.4436.00 ((SQL14_SP1_QFE-CU).151202-1517)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/8f68c8d3545c49e8b83079bc84c6e2842/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4436.00 ((SQL14_SP1_QFE-CU).151202-1517)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/f08834e6067d4b98acb3b60090b4ba292/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4436.00 ((SQL14_SP1_QFE-CU).151202-1517)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/1d1d583c3f204024a1c6247dfce1af251/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.4436.00 ((SQL14_SP1_QFE-CU).151202-1517)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/bf369e60da5943c5ac4ecd1c83e9c1491/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.4436.00 ((SQL14_SP1_QFE-CU).151202-1517)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/6fe2ce101a564db2a580f3f85176f0681/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.4436.00 ((SQL14_SP1_QFE-CU).151202-1517)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/e1afd1f24c8a44f1a734bd1c4a10eaf51/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4436.00 ((SQL14_SP1_QFE-CU).151202-1517)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/5aa7af725caf4fe38f52515b787d4c4d2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4436.00 ((SQL14_SP1_QFE-CU).151202-1517)
```

# SQL Server 2014 SP1 CU4 - 12.0.4436.0 - x86 (KB3106660)
``` powershell
# SQL Server 2014 SP1 CU4 - 12.0.4436.0 - x86 (KB3106660)
$outputFolder = 'c:\sqlsyms\12.0.4436.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/e3278cf94d974d73a099dd3541f1430b1/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.4436.00 ((SQL14_SP1_QFE-CU).151202-1517)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/65cc2740001e4389a652c81d662ff4a31/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4436.00 ((SQL14_SP1_QFE-CU).151202-1517)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/1215ee0470bf46c1bcd1ddfa35951f911/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4436.00 ((SQL14_SP1_QFE-CU).151202-1517)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/737570a73e254326826ad1c811c340671/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.4436.00 ((SQL14_SP1_QFE-CU).151202-1517)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/50cf83342da94fbeaee4f79bd16973ab2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4436.00 ((SQL14_SP1_QFE-CU).151202-1517)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/df2f947c30e4454b9e568b53ca4dd8c51/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4436.00 ((SQL14_SP1_QFE-CU).151202-1517)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/3e240bb821c44d9d8ab1e59638d2bf351/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4436.00 ((SQL14_SP1_QFE-CU).151202-1517)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/28a61563540846d5a4c6c1b9f58e6b9c1/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4436.00 ((SQL14_SP1_QFE-CU).151202-1517)
```

# SQL Server 2014 SP1 CU3 - 12.0.4427.24 - x64 (KB3094221)
``` powershell
# SQL Server 2014 SP1 CU3 - 12.0.4427.24 - x64 (KB3094221)
$outputFolder = 'c:\sqlsyms\12.0.4427.24\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/8b612bab70d84b87bc09f27e4886aeb32/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.4427.24 ((SQL14_SP1_QFE-CU).151010-1609)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/dd15f98e38c244fc99b4ea43e149751a2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4427.24 ((SQL14_SP1_QFE-CU).151010-1609)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/cfee366445fd45cb90c9a47537129e772/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4427.24 ((SQL14_SP1_QFE-CU).151010-1609)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/da33ddc66f9843f38802e386e21a23d92/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.4427.24 ((SQL14_SP1_QFE-CU).151010-1609)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/5d78955b0a444fa8a0829509864abdcf2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4427.24 ((SQL14_SP1_QFE-CU).151010-1609)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/d625926716ac4a4ab6d395e0717eee292/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4427.24 ((SQL14_SP1_QFE-CU).151010-1609)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/f7bfed5a7b9c4b0a89c2351606f6dabd1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.4427.24 ((SQL14_SP1_QFE-CU).151010-1609)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/2829cd5018b94524a05d17c0aba940a51/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.4427.24 ((SQL14_SP1_QFE-CU).151010-1609)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/28ce7b1a2fe64c1bae7180a1ab1d4b841/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.4427.24 ((SQL14_SP1_QFE-CU).151010-1609)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/2ab9eea24838455ebedc0b4bfca780651/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4427.24 ((SQL14_SP1_QFE-CU).151010-1609)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/d1da515568304cada52f5ca07d32c56f2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4427.24 ((SQL14_SP1_QFE-CU).151010-1609)
```

# SQL Server 2014 SP1 CU3 - 12.0.4427.24 - x86 (KB3094221)
``` powershell
# SQL Server 2014 SP1 CU3 - 12.0.4427.24 - x86 (KB3094221)
$outputFolder = 'c:\sqlsyms\12.0.4427.24\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/3ef0e0f2fe2b43ac93875b3b3925fc6e1/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.4427.24 ((SQL14_SP1_QFE-CU).151010-1609)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/e630387bc0da4378a384f2f0381a70361/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4427.24 ((SQL14_SP1_QFE-CU).151010-1609)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/195f5a4a374443d7aba2b2bee84e34891/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4427.24 ((SQL14_SP1_QFE-CU).151010-1609)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/f7d1027c3648472896a7f5d88da4c9d21/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.4427.24 ((SQL14_SP1_QFE-CU).151010-1609)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/9e81862bb11447788e4a5248fb8a067e2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4427.24 ((SQL14_SP1_QFE-CU).151010-1609)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/5a5b0039a4474b42bb55ccb3ca6127721/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4427.24 ((SQL14_SP1_QFE-CU).151010-1609)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/d656086d4f4b422580baf43047ee17da1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4427.24 ((SQL14_SP1_QFE-CU).151010-1609)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/ac149317d5054708a94ca8aa8cef2fb41/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4427.24 ((SQL14_SP1_QFE-CU).151010-1609)
```

# SQL Server 2014 SP1 CU2 - 12.0.4422.0 - x64 (KB3075950)
``` powershell
# SQL Server 2014 SP1 CU2 - 12.0.4422.0 - x64 (KB3075950)
$outputFolder = 'c:\sqlsyms\12.0.4422.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/cc4b19123a7e4b00bc327dc0d8c0535a2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.4422.00 ((SQL14_SP1_QFE-CU).150727-1536)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/685f3f3dd9bf40a384bc3b34b5e0ec382/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4422.00 ((SQL14_SP1_QFE-CU).150727-1536)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/132245b6e07d4ed0b8a037f372c07a1c2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4422.00 ((SQL14_SP1_QFE-CU).150727-1536)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/f2d5c201fa064580a88c8620fcf528942/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.4422.00 ((SQL14_SP1_QFE-CU).150727-1536)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/3c213b3e4cac475c986f38788ee7ae812/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4422.00 ((SQL14_SP1_QFE-CU).150727-1536)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/9833540f5dd84c07bfa7aa07e35878c82/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4422.00 ((SQL14_SP1_QFE-CU).150727-1536)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/703a0ff035d8421093c5873ca70254021/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.4422.00 ((SQL14_SP1_QFE-CU).150727-1536)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/a70c6bd99bbb44129002fe32794a1a491/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.4422.00 ((SQL14_SP1_QFE-CU).150727-1536)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/3b2cc6000a1e46aa8ad7be339858e1871/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.4422.00 ((SQL14_SP1_QFE-CU).150727-1536)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/6e69bdfbde834092882537afb0164ee41/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4422.00 ((SQL14_SP1_QFE-CU).150727-1536)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/d6bbc455ed6d43fca5b6c541fd9840a82/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4422.00 ((SQL14_SP1_QFE-CU).150727-1536)
```

# SQL Server 2014 SP1 CU2 - 12.0.4422.0 - x86 (KB3075950)
``` powershell
# SQL Server 2014 SP1 CU2 - 12.0.4422.0 - x86 (KB3075950)
$outputFolder = 'c:\sqlsyms\12.0.4422.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/3e6e97436d7947efba0199c077de575e1/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.4422.00 ((SQL14_SP1_QFE-CU).150727-1536)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/8f1c6ef392a94f7280e4551d787bde0e1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4422.00 ((SQL14_SP1_QFE-CU).150727-1536)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/802091eeae1040b9929300673cf1e6cc1/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4422.00 ((SQL14_SP1_QFE-CU).150727-1536)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/7cf486d748c648a993d8fee09d470ed01/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.4422.00 ((SQL14_SP1_QFE-CU).150727-1536)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/77421fe01c504798bd84ff1111394ed02/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4422.00 ((SQL14_SP1_QFE-CU).150727-1536)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/bce992e7e4704168967f6b792d2c92161/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4422.00 ((SQL14_SP1_QFE-CU).150727-1536)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/10d2fbe0372a465a984499f610117b671/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4422.00 ((SQL14_SP1_QFE-CU).150727-1536)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/8132ccd977ac49b9b82d21e453c9d7db1/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4422.00 ((SQL14_SP1_QFE-CU).150727-1536)
```

# SQL Server 2014 SP1 SP1 - 12.0.4100.1 - x64 (KB3058865)
``` powershell
# SQL Server 2014 SP1 SP1 - 12.0.4100.1 - x64 (KB3058865)
$outputFolder = 'c:\sqlsyms\12.0.4100.1\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/0b3969cc9d1c42209d848cdd6619deb22/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.4100.01 ((SQL14_PCU_main).150420-1653)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/cb126849ce004b6fb8128a91ca87d5de2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4100.01 ((SQL14_PCU_main).150420-1653)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/3b28768245824b4e9dbe603fd491e2852/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4100.01 ((SQL14_PCU_main).150420-1653)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/b7ffc8fe9e2f4b15b44e40b4afd2ea012/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.4100.01 ((SQL14_PCU_main).150420-1653)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/08ffbabfdc4a4926bc16c8522c9bbc322/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4100.01 ((SQL14_PCU_main).150420-1653)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/3b87272344ce49a79745b7c63a7e20182/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4100.01 ((SQL14_PCU_main).150420-1653)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/4fedbb6d132d4ed49a566bcd7212408d1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.4100.01 ((SQL14_PCU_main).150420-1653)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/c333820aef364ad2b93a5bcc5a1c66101/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.4100.01 ((SQL14_PCU_main).150420-1653)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/1a18e036793145c8a9d1ab124a2607e41/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.4100.01 ((SQL14_PCU_main).150420-1653)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/63dadaf018f1419f8a4dbbd6bc1dc14a1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4100.01 ((SQL14_PCU_main).150420-1653)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/ab6196f20a154ace825cff70fd87b6092/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4100.01 ((SQL14_PCU_main).150420-1653)
```

# SQL Server 2014 SP1 SP1 - 12.0.4100.1 - x86 (KB3058865)
``` powershell
# SQL Server 2014 SP1 SP1 - 12.0.4100.1 - x86 (KB3058865)
$outputFolder = 'c:\sqlsyms\12.0.4100.1\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/0865f069e71245ca8bfa3d606b60c1621/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.4100.01 ((SQL14_PCU_main).150420-1653)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/e489ada097d74198927ef538fd8927a41/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.4100.01 ((SQL14_PCU_main).150420-1653)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/5bea9870e6614f7e83671000e406de331/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.4100.01 ((SQL14_PCU_main).150420-1653)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/68a3418eaba04db5b35c3ab2cc4a67681/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.4100.01 ((SQL14_PCU_main).150420-1653)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/295830323d5343efad5c418d4e6dddb72/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.4100.01 ((SQL14_PCU_main).150420-1653)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/a3aeeef5442b49b4abf8d50de9edab181/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.4100.01 ((SQL14_PCU_main).150420-1653)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/1ea104008bc644218268d19341eecd741/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.4100.01 ((SQL14_PCU_main).150420-1653)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/e36eebbe2905446fbf814c89dee44df71/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.4100.01 ((SQL14_PCU_main).150420-1653)
```

# SQL Server 2014 RTM CU14 - 12.0.2569.0 - x64 (KB3158271)
``` powershell
# SQL Server 2014 RTM CU14 - 12.0.2569.0 - x64 (KB3158271)
$outputFolder = 'c:\sqlsyms\12.0.2569.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/539b0c025c174d6698c4969ee00d608a2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.2569.00 ((SQL14_RTM_QFE-CU).160527-1418)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/da89f627ad2346c38a7e801fed26a28d2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2569.00 ((SQL14_RTM_QFE-CU).160527-1418)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/50637ed0c6714c5c99da521077e3e5c32/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2569.00 ((SQL14_RTM_QFE-CU).160527-1418)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/01a3ff5e96cd40d5a8f1ab8f127009522/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.2569.00 ((SQL14_RTM_QFE-CU).160527-1418)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/05af9fc52b03405a9cb80cbd73c60a692/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2569.00 ((SQL14_RTM_QFE-CU).160527-1418)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/a803366e7b534798ab18db7ab2f059602/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2569.00 ((SQL14_RTM_QFE-CU).160527-1418)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/bee70081bce04d9e9a4d9145f820ec5f1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.2569.00 ((SQL14_RTM_QFE-CU).160527-1418)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/097922796c7443deaaebb689165db0c81/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.2569.00 ((SQL14_RTM_QFE-CU).160527-1418)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/fc8453414c104e1992d469013988d78d1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.2569.00 ((SQL14_RTM_QFE-CU).160527-1418)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/4cc60f940e164516ba060e2ec7a9085d1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2569.00 ((SQL14_RTM_QFE-CU).160527-1418)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/167b796ce1b84bd6aab8a050c0507d842/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2569.00 ((SQL14_RTM_QFE-CU).160527-1418)
```

# SQL Server 2014 RTM CU14 - 12.0.2569.0 - x86 (KB3158271)
``` powershell
# SQL Server 2014 RTM CU14 - 12.0.2569.0 - x86 (KB3158271)
$outputFolder = 'c:\sqlsyms\12.0.2569.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/759d2b26ff5346bd861ce3f29f45bec81/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.2569.00 ((SQL14_RTM_QFE-CU).160527-1418)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/78d8fd90a81d424b9a11cff7694359be1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2569.00 ((SQL14_RTM_QFE-CU).160527-1418)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/10adc5ffc4504f70bea9ace99b83d4811/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2569.00 ((SQL14_RTM_QFE-CU).160527-1418)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/d5d8a1b7129843e992a5cc7ac48d8cdc1/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.2569.00 ((SQL14_RTM_QFE-CU).160527-1418)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/88e10155378342d28c551097e352cddc2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2569.00 ((SQL14_RTM_QFE-CU).160527-1418)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/a51778462d5b483bb0f7c56f35e1b3881/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2569.00 ((SQL14_RTM_QFE-CU).160527-1418)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/63daa87222644774b370021497f13aae1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2569.00 ((SQL14_RTM_QFE-CU).160527-1418)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/2e5c327356dd422e8df429052b8e1de21/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2569.00 ((SQL14_RTM_QFE-CU).160527-1418)
```

# SQL Server 2014 RTM CU13 - 12.0.2568.0 - x64 (KB3144517)
``` powershell
# SQL Server 2014 RTM CU13 - 12.0.2568.0 - x64 (KB3144517)
$outputFolder = 'c:\sqlsyms\12.0.2568.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/de53ea6dfde743f18cadc0b0d43042492/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.2568.00 ((SQL14_RTM_QFE-CU).160330-1726)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/dd5ba486f24344ad8405ff37e26b4e1f2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2568.00 ((SQL14_RTM_QFE-CU).160330-1726)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/93d02eddd4a34a3dbbecfeb54abf9a1d2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2568.00 ((SQL14_RTM_QFE-CU).160330-1726)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/c9fd07c3fc294f1da6e434f006522b152/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.2568.00 ((SQL14_RTM_QFE-CU).160330-1726)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/a032aa8c1f9c4768a7f44c6e724c25542/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2568.00 ((SQL14_RTM_QFE-CU).160330-1726)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/c244f112481946d78890457e4e7ee5a72/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2568.00 ((SQL14_RTM_QFE-CU).160330-1726)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/64efea4a66a242fe84610bdea54e47fd1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.2568.00 ((SQL14_RTM_QFE-CU).160330-1726)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/d1faf0f81672488e975d5cbff4f5f4c51/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.2568.00 ((SQL14_RTM_QFE-CU).160330-1726)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/d6ba17eeb5534b6c8f09b7bd7a9d87ef1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.2568.00 ((SQL14_RTM_QFE-CU).160330-1726)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/7b633a8ab9664ffaa16dff394ebc5d331/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2568.00 ((SQL14_RTM_QFE-CU).160330-1726)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/5e921cfba868494fa153b17f0d1fda992/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2568.00 ((SQL14_RTM_QFE-CU).160330-1726)
```

# SQL Server 2014 RTM CU13 - 12.0.2568.0 - x86 (KB3144517)
``` powershell
# SQL Server 2014 RTM CU13 - 12.0.2568.0 - x86 (KB3144517)
$outputFolder = 'c:\sqlsyms\12.0.2568.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/f4ce9bbe9cd94155a053957fc6e89a171/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.2568.00 ((SQL14_RTM_QFE-CU).160330-1726)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/e3272664d7ac4280889108adaa8fa4081/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2568.00 ((SQL14_RTM_QFE-CU).160330-1726)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/b3d91828d7c04aef9f0a597390b6e3f01/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2568.00 ((SQL14_RTM_QFE-CU).160330-1726)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/7f73aff2ab6146b59f7cba467bfe64071/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.2568.00 ((SQL14_RTM_QFE-CU).160330-1726)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/5db522686f8c42f58a7a6cb449f772d32/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2568.00 ((SQL14_RTM_QFE-CU).160330-1726)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/d5748e2f6f7043058e5bbd55bacb3b4f1/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2568.00 ((SQL14_RTM_QFE-CU).160330-1726)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/5958ca20c2cd4e2e855fe49509dd0e7c1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2568.00 ((SQL14_RTM_QFE-CU).160330-1726)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/310e33c9d39046199259897860543ef81/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2568.00 ((SQL14_RTM_QFE-CU).160330-1726)
```

# SQL Server 2014 RTM CU12 - 12.0.2564.0 - x64 (KB3130923)
``` powershell
# SQL Server 2014 RTM CU12 - 12.0.2564.0 - x64 (KB3130923)
$outputFolder = 'c:\sqlsyms\12.0.2564.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/ac2576ff05574d0895c27ddeafbe5c8c2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.2564.00 ((SQL14_RTM_QFE-CU).160204-1937)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/24cf73afb18b44e98f4ba0ac01281e232/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2564.00 ((SQL14_RTM_QFE-CU).160204-1937)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/05ca53d70a0d46c78025be9f7379f3f02/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2564.00 ((SQL14_RTM_QFE-CU).160204-1937)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/e478a5c24cc047cdaa62614b9d6bd3052/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.2564.00 ((SQL14_RTM_QFE-CU).160204-1937)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/eb2d01edd0b143d3a8cf1c8a5ebea4972/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2564.00 ((SQL14_RTM_QFE-CU).160204-1937)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/16cdbd70f47b48cf908a13007767df1a2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2564.00 ((SQL14_RTM_QFE-CU).160204-1937)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/9f3ca7a2feee48a1998590fec323b2e91/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.2564.00 ((SQL14_RTM_QFE-CU).160204-1937)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/3ebf546ee388483abdb7dab6effd82d21/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.2564.00 ((SQL14_RTM_QFE-CU).160204-1937)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/a2f68300ade4407fb71d87f30a77fc111/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.2564.00 ((SQL14_RTM_QFE-CU).160204-1937)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/cc7dd6966b7e43d99c7c23447f95542f1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2564.00 ((SQL14_RTM_QFE-CU).160204-1937)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/f0308e1404e542b2a920139701283a252/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2564.00 ((SQL14_RTM_QFE-CU).160204-1937)
```

# SQL Server 2014 RTM CU12 - 12.0.2564.0 - x86 (KB3130923)
``` powershell
# SQL Server 2014 RTM CU12 - 12.0.2564.0 - x86 (KB3130923)
$outputFolder = 'c:\sqlsyms\12.0.2564.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/17b9f26230cd4187a439851dc2b15e5a1/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.2564.00 ((SQL14_RTM_QFE-CU).160204-1937)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/df46ff7b155e49048c088afde27092b21/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2564.00 ((SQL14_RTM_QFE-CU).160204-1937)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/1849c8c7f5774787a047b5c3105a4f861/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2564.00 ((SQL14_RTM_QFE-CU).160204-1937)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/1e704748340e45ad8c1e5bc9b08a77281/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.2564.00 ((SQL14_RTM_QFE-CU).160204-1937)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/c3e4dde16a9a427ea900174c72dfb9e82/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2564.00 ((SQL14_RTM_QFE-CU).160204-1937)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/6c5d715625174c2c94d325757fa8d1e81/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2564.00 ((SQL14_RTM_QFE-CU).160204-1937)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/fa23d7c84b444dcd8b619046b60b65421/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2564.00 ((SQL14_RTM_QFE-CU).160204-1937)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/29ba1ceeca2744fe84f8d852530d27f71/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2564.00 ((SQL14_RTM_QFE-CU).160204-1937)
```

# SQL Server 2014 RTM CU11 - 12.0.2560.0 - x64 (KB3106659)
``` powershell
# SQL Server 2014 RTM CU11 - 12.0.2560.0 - x64 (KB3106659)
$outputFolder = 'c:\sqlsyms\12.0.2560.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/71ccee0526474342a5891a30d552962b2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.2560.00 ((SQL14_RTM_QFE-CU).151130-1922)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/3919239c1e00493990334a7288fcb7962/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2560.00 ((SQL14_RTM_QFE-CU).151130-1922)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/756b21da38ee46d0984b1188544092342/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2560.00 ((SQL14_RTM_QFE-CU).151130-1922)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/d028137b7daa4438bc7be686320a64fe2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.2560.00 ((SQL14_RTM_QFE-CU).151130-1922)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/781c50f9c2c44642b355a47de65574b82/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2560.00 ((SQL14_RTM_QFE-CU).151130-1922)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/a0aff51dd9904d55a4fcce650e40a9762/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2560.00 ((SQL14_RTM_QFE-CU).151130-1922)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/9293a8099c4d4f49bc6b0543846b03791/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.2560.00 ((SQL14_RTM_QFE-CU).151130-1922)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/fa5b0015e66a4fb286899631f60591021/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.2560.00 ((SQL14_RTM_QFE-CU).151130-1922)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/56f5dd0eb56e420b92dcd5f59b05ef9c1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.2560.00 ((SQL14_RTM_QFE-CU).151130-1922)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/64b1f742fbcb4e2eb3f2e1dc05b70ea61/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2560.00 ((SQL14_RTM_QFE-CU).151130-1922)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/8ec5a23b411344a6b1fb5a9dfc8d1c752/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2560.00 ((SQL14_RTM_QFE-CU).151130-1922)
```

# SQL Server 2014 RTM CU11 - 12.0.2560.0 - x86 (KB3106659)
``` powershell
# SQL Server 2014 RTM CU11 - 12.0.2560.0 - x86 (KB3106659)
$outputFolder = 'c:\sqlsyms\12.0.2560.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/a90e6d303f4345efaedba859da66d0e21/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.2560.00 ((SQL14_RTM_QFE-CU).151130-1922)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/64473f2a9c0243d08ad2cebd7e62f0ac1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2560.00 ((SQL14_RTM_QFE-CU).151130-1922)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/eb1f9c11c81140199ee680f02d407a3c1/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2560.00 ((SQL14_RTM_QFE-CU).151130-1922)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/5b6c3b54f0234bb2be975c25092ba4851/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.2560.00 ((SQL14_RTM_QFE-CU).151130-1922)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/286b5c4590a94a3bb3da0360ecd0e9c72/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2560.00 ((SQL14_RTM_QFE-CU).151130-1922)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/ce4f67214c154f52ad60711ba933ad3d1/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2560.00 ((SQL14_RTM_QFE-CU).151130-1922)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/aec11813c97e4e44bdb233dd821866191/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2560.00 ((SQL14_RTM_QFE-CU).151130-1922)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/bd25689f8fa549398c347993c1fba4851/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2560.00 ((SQL14_RTM_QFE-CU).151130-1922)
```

# SQL Server 2014 RTM CU10 - 12.0.2556.4 - x64 (KB3094220)
``` powershell
# SQL Server 2014 RTM CU10 - 12.0.2556.4 - x64 (KB3094220)
$outputFolder = 'c:\sqlsyms\12.0.2556.4\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/a06b30032d9f4505a3c8f000010f8e4a2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.2556.04 ((SQL14_RTM_QFE-CU).150925-1720)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/e48e96adf3df44b481c69001d428659f2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2556.04 ((SQL14_RTM_QFE-CU).150925-1720)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/a1d6b6fd3e564262ae281bf794e96bd72/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2556.04 ((SQL14_RTM_QFE-CU).150925-1720)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/038d25c7c8644a3395f40f40f36382c62/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.2556.04 ((SQL14_RTM_QFE-CU).150925-1720)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/cfb6dad33e5f4582bb467ca8f85d4a162/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2556.04 ((SQL14_RTM_QFE-CU).150925-1720)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/98e46a54759c4bdfbab7383aa518630a2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2556.04 ((SQL14_RTM_QFE-CU).150925-1720)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/76f05d07a3e9414f80f50c6442eea7931/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.2556.04 ((SQL14_RTM_QFE-CU).150925-1720)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/1383af48c8034eebb40e2851e1a44a1c1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.2556.04 ((SQL14_RTM_QFE-CU).150925-1720)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/f3b781e181fe41d98402118e16e3f7601/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.2556.04 ((SQL14_RTM_QFE-CU).150925-1720)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/d0f7a6c9e839447fbf537b344c12efae1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2556.04 ((SQL14_RTM_QFE-CU).150925-1720)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/6f9cb7b79b0f4b7eb215793a66b2ef942/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2556.04 ((SQL14_RTM_QFE-CU).150925-1720)
```

# SQL Server 2014 RTM CU10 - 12.0.2556.4 - x86 (KB3094220)
``` powershell
# SQL Server 2014 RTM CU10 - 12.0.2556.4 - x86 (KB3094220)
$outputFolder = 'c:\sqlsyms\12.0.2556.4\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/9c806d9ee5a84c898f8421b5380b95e31/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.2556.04 ((SQL14_RTM_QFE-CU).150925-1720)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/b69a5dcf43574aa79661d3e85b9daf3b1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2556.04 ((SQL14_RTM_QFE-CU).150925-1720)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/97d553cffeff4762b0266da68f578fba1/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2556.04 ((SQL14_RTM_QFE-CU).150925-1720)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/d79a773caeba4ac59f6882c36b1f356c1/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.2556.04 ((SQL14_RTM_QFE-CU).150925-1720)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/f646c10572b24eaaadbae323b7abd2782/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2556.04 ((SQL14_RTM_QFE-CU).150925-1720)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/38dc9d399d6b41a69f084603941b4de21/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2556.04 ((SQL14_RTM_QFE-CU).150925-1720)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/3960118c1cbe4a29af87cc01706ce2641/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2556.04 ((SQL14_RTM_QFE-CU).150925-1720)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/7e7fd36e795447998d8a574e0de7c1871/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2556.04 ((SQL14_RTM_QFE-CU).150925-1720)
```

# SQL Server 2014 RTM CU9 - 12.0.2553.0 - x64 (KB3075949)
``` powershell
# SQL Server 2014 RTM CU9 - 12.0.2553.0 - x64 (KB3075949)
$outputFolder = 'c:\sqlsyms\12.0.2553.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/4d240a39c8904928a18106632f6553402/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.2553.00 ((SQL14_RTM_QFE-CU).150727-1511)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/a7035a6ff90d479b9919516f8a75c6f92/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2553.00 ((SQL14_RTM_QFE-CU).150727-1511)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/90c16352697346c4adc344d5bcbef4ec2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2553.00 ((SQL14_RTM_QFE-CU).150727-1511)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/c4b7ea36a9ed41e28a86daf39605b1332/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.2553.00 ((SQL14_RTM_QFE-CU).150727-1511)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/afdf18a69a2247a69f8775fb26ba35842/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2553.00 ((SQL14_RTM_QFE-CU).150727-1511)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/531f254bc1634a668690bfa78ac1c9642/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2553.00 ((SQL14_RTM_QFE-CU).150727-1511)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/a0a41504488d42e0889c7aec0d470a201/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.2553.00 ((SQL14_RTM_QFE-CU).150727-1511)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/8f66e9d5591841f585146e18e861ba1e1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.2553.00 ((SQL14_RTM_QFE-CU).150727-1511)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/7b7dadea82424ddb940d8bcb1ced7a461/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.2553.00 ((SQL14_RTM_QFE-CU).150727-1511)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/19ab0699fbdf4c26b2c48e3206ac53ca1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2553.00 ((SQL14_RTM_QFE-CU).150727-1511)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/eceabbbb5b7a43e49511f7e3b3064b472/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2553.00 ((SQL14_RTM_QFE-CU).150727-1511)
```

# SQL Server 2014 RTM CU9 - 12.0.2553.0 - x86 (KB3075949)
``` powershell
# SQL Server 2014 RTM CU9 - 12.0.2553.0 - x86 (KB3075949)
$outputFolder = 'c:\sqlsyms\12.0.2553.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/d56eacfc22cb4f8ebfb7ed4457b60f311/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.2553.00 ((SQL14_RTM_QFE-CU).150727-1511)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/2dd16123a37f485dae76965defe7f15e1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2553.00 ((SQL14_RTM_QFE-CU).150727-1511)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/569970ff8be84c0b9f067365e4a00c3b1/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2553.00 ((SQL14_RTM_QFE-CU).150727-1511)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/17dd6df3096b4d0199d1035815c1d8881/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.2553.00 ((SQL14_RTM_QFE-CU).150727-1511)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/594a78c1c2204ba1a183b4127c462a3e2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2553.00 ((SQL14_RTM_QFE-CU).150727-1511)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/6446039fddc749d3a1583d2472405cf21/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2553.00 ((SQL14_RTM_QFE-CU).150727-1511)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/6f805634dddd401994ea5e31420c30281/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2553.00 ((SQL14_RTM_QFE-CU).150727-1511)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/8d3747171962416d957f2f4a2a5dc8701/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2553.00 ((SQL14_RTM_QFE-CU).150727-1511)
```

# SQL Server 2014 RTM CU8 - 12.0.2546.0 - x64 (KB3067836)
``` powershell
# SQL Server 2014 RTM CU8 - 12.0.2546.0 - x64 (KB3067836)
$outputFolder = 'c:\sqlsyms\12.0.2546.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/1869491de3c641a18e49984e36c254472/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.2546.00 ((SQL14_RTM_QFE-CU).150606-0007)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/23feec68725245cba986d45a86d87c3f2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2546.00 ((SQL14_RTM_QFE-CU).150606-0007)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/21db9cb621534d9e9be8f5c03e7091c52/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2546.00 ((SQL14_RTM_QFE-CU).150606-0007)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/8575334bb55240b5a1f44608bf3eda9b2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.2546.00 ((SQL14_RTM_QFE-CU).150606-0007)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/aeb2b040245c4f408ba6cfba7376190a2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2546.00 ((SQL14_RTM_QFE-CU).150606-0007)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/bfffb5bc7a3044ebb54ab848cdfeb7632/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2546.00 ((SQL14_RTM_QFE-CU).150606-0007)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/6e2e2a0675164fe8a3ade4ecae7ac20c1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.2546.00 ((SQL14_RTM_QFE-CU).150606-0007)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/dde786dd2d5b4cdca67f2653dafdb4d91/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.2546.00 ((SQL14_RTM_QFE-CU).150606-0007)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/20f66d85e7d54ab797a4802c4e642b431/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.2546.00 ((SQL14_RTM_QFE-CU).150606-0007)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/281a067206bb4599bf54b71128337a161/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2546.00 ((SQL14_RTM_QFE-CU).150606-0007)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/a7596bb350534cfc874c588a8c31dccc2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2546.00 ((SQL14_RTM_QFE-CU).150606-0007)
```

# SQL Server 2014 RTM CU8 - 12.0.2546.0 - x86 (KB3067836)
``` powershell
# SQL Server 2014 RTM CU8 - 12.0.2546.0 - x86 (KB3067836)
$outputFolder = 'c:\sqlsyms\12.0.2546.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/a902edbf6d6e45a5bdb96d88b3d8b9eb1/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.2546.00 ((SQL14_RTM_QFE-CU).150606-0007)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/91f4ba068591426395fba9cf46b9fe3b1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2546.00 ((SQL14_RTM_QFE-CU).150606-0007)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/a3454c90a9ec423abaab7718704766c41/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2546.00 ((SQL14_RTM_QFE-CU).150606-0007)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/6648b0c58be2467c85d16b826474f8e71/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.2546.00 ((SQL14_RTM_QFE-CU).150606-0007)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/57dad04962d6454e8ee40edafdd2a7382/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2546.00 ((SQL14_RTM_QFE-CU).150606-0007)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/9b2bcdfb948342728b8154e042fa2aab1/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2546.00 ((SQL14_RTM_QFE-CU).150606-0007)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/9291ad53019f4d93b0a31996c43797fb1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2546.00 ((SQL14_RTM_QFE-CU).150606-0007)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/6aaa6f308fc649d8b2982b6ae4cb77c71/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2546.00 ((SQL14_RTM_QFE-CU).150606-0007)
```

# SQL Server 2014 RTM CU7 - 12.0.2495.0 - x64 (KB3046038)
``` powershell
# SQL Server 2014 RTM CU7 - 12.0.2495.0 - x64 (KB3046038)
$outputFolder = 'c:\sqlsyms\12.0.2495.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/892a317818044f39a181616fc087af5d2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.2495.00 ((SQL14_RTM_QFE-CU).150331-0856)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/3f9503803aac4aaf9068cf713da94fcc2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2495.00 ((SQL14_RTM_QFE-CU).150331-0856)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/7b4cb4924f874c2c9a01962d7bebb4322/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2495.00 ((SQL14_RTM_QFE-CU).150331-0856)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/f953a26136a349b4bc7123c9b57674cb2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.2495.00 ((SQL14_RTM_QFE-CU).150331-0856)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/5b04b86cb1df4377852dcdfbaa579d6a2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2495.00 ((SQL14_RTM_QFE-CU).150331-0856)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/68b76d2800ca4d67a20176b8080792622/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2495.00 ((SQL14_RTM_QFE-CU).150331-0856)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/8ed3b76470a54f71a22fe04ec4aa07971/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.2495.00 ((SQL14_RTM_QFE-CU).150331-0856)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/ac765b05370f4dd39bc3dab2c9c5b0881/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.2495.00 ((SQL14_RTM_QFE-CU).150331-0856)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/868f36d33dea4cdd80d7ac95d51becb61/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.2495.00 ((SQL14_RTM_QFE-CU).150331-0856)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/e750975049a44a5ca167527370ef01171/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2495.00 ((SQL14_RTM_QFE-CU).150331-0856)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/76a12fa76ee2455086cf3afd914b939b2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2495.00 ((SQL14_RTM_QFE-CU).150331-0856)
```

# SQL Server 2014 RTM CU7 - 12.0.2495.0 - x86 (KB3046038)
``` powershell
# SQL Server 2014 RTM CU7 - 12.0.2495.0 - x86 (KB3046038)
$outputFolder = 'c:\sqlsyms\12.0.2495.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/b723d38841c74cb09e79d2eeadffc2ab1/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.2495.00 ((SQL14_RTM_QFE-CU).150331-0856)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/0f90d520883c490f9d0815f7a6211e701/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2495.00 ((SQL14_RTM_QFE-CU).150331-0856)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/bc6b474d28164912bd70a0e0087e35261/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2495.00 ((SQL14_RTM_QFE-CU).150331-0856)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/c32b08605905479daa5521248a294c091/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.2495.00 ((SQL14_RTM_QFE-CU).150331-0856)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/96046540101444be821ef103aa4e0f982/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2495.00 ((SQL14_RTM_QFE-CU).150331-0856)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/710e00b267c04ae1bc850a013edee5231/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2495.00 ((SQL14_RTM_QFE-CU).150331-0856)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/982821e1f1a348c4845b7a31dd0a43ce1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2495.00 ((SQL14_RTM_QFE-CU).150331-0856)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/d8c2b98f2dd94438849861c279784cfb1/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2495.00 ((SQL14_RTM_QFE-CU).150331-0856)
```

# SQL Server 2014 RTM CU6 - 12.0.2480.0 - x64 (KB3031047)
``` powershell
# SQL Server 2014 RTM CU6 - 12.0.2480.0 - x64 (KB3031047)
$outputFolder = 'c:\sqlsyms\12.0.2480.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/dbacb5b0cfd24693ae42ddf04ab4b27c2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.2480.00 ((SQL14_RTM_QFE-CU).150128-1755)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/31d5b80990d64e0fb25cb5327135bf492/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2480.00 ((SQL14_RTM_QFE-CU).150128-1755)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/ff523ac683ae46a2b355c15b4ac022eb2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2480.00 ((SQL14_RTM_QFE-CU).150128-1755)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/edbd5ea4bbe04d47b93025254094b02d2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.2480.00 ((SQL14_RTM_QFE-CU).150128-1755)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/4929c9ecd1704cf8a7821dc901f6d92f2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2480.00 ((SQL14_RTM_QFE-CU).150128-1755)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/1c0f8135f2934a5ca84ebff15f88b6aa2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2480.00 ((SQL14_RTM_QFE-CU).150128-1755)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/3ab1423a6b7f48d1a942c5df2fd242b61/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.2480.00 ((SQL14_RTM_QFE-CU).150128-1755)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/c9aa7a554ed94d15b35740ffe04036c01/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.2480.00 ((SQL14_RTM_QFE-CU).150128-1755)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/95947070310e43e2accbc93c08f222241/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.2480.00 ((SQL14_RTM_QFE-CU).150128-1755)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/0d379c00cf81409587f1a4c9f95f77dd1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2480.00 ((SQL14_RTM_QFE-CU).150128-1755)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/ec96151a8358494bb84329e05aaf78e02/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2480.00 ((SQL14_RTM_QFE-CU).150128-1755)
```

# SQL Server 2014 RTM CU6 - 12.0.2480.0 - x86 (KB3031047)
``` powershell
# SQL Server 2014 RTM CU6 - 12.0.2480.0 - x86 (KB3031047)
$outputFolder = 'c:\sqlsyms\12.0.2480.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/9b22a94162d74004a82810c2c3710a3f1/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.2480.00 ((SQL14_RTM_QFE-CU).150128-1755)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/ececdbe975594116b9e388e6c9f8a80f1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2480.00 ((SQL14_RTM_QFE-CU).150128-1755)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/9f41e051cb014f8d9fec6e44e9b721131/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2480.00 ((SQL14_RTM_QFE-CU).150128-1755)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/2ffeb57130c84f8fa3d69df7de71eb681/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.2480.00 ((SQL14_RTM_QFE-CU).150128-1755)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/7d7d89e6640645beb6306cbf2444ee662/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2480.00 ((SQL14_RTM_QFE-CU).150128-1755)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/22336473e39548f99831e8d061b7831b1/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2480.00 ((SQL14_RTM_QFE-CU).150128-1755)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/b16a9fdb9f8546788b04a5d80b2bae261/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2480.00 ((SQL14_RTM_QFE-CU).150128-1755)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/2c1a8c9a1b8c44e283868f97d75481e01/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2480.00 ((SQL14_RTM_QFE-CU).150128-1755)
```

# SQL Server 2014 RTM CU5 - 12.0.2456.0 - x64 (KB3011055)
``` powershell
# SQL Server 2014 RTM CU5 - 12.0.2456.0 - x64 (KB3011055)
$outputFolder = 'c:\sqlsyms\12.0.2456.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/eb8a93e72a794e8b9f5e5319cfc523682/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.2456.00 ((SQL14_RTM_QFE-CU).141211-1636)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/53f31818f69145f48eee069d0d23fbd12/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2456.00 ((SQL14_RTM_QFE-CU).141211-1636)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/6e2939b1a6c747c79606f27572d2167d2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2456.00 ((SQL14_RTM_QFE-CU).141211-1636)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/133c13f037d542e68e5d1fb06ae6e8042/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.2456.00 ((SQL14_RTM_QFE-CU).141211-1636)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/1afa777fdd2643e8b7eaa7faa9b6b5fa2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2456.00 ((SQL14_RTM_QFE-CU).141211-1636)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/19634392d50f4dcab91217f04a415f482/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2456.00 ((SQL14_RTM_QFE-CU).141211-1636)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/8fbc290a832848ffb96d30114d63ed611/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.2456.00 ((SQL14_RTM_QFE-CU).141211-1636)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/291765ae21a741eda736cb1cbcea5de51/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.2456.00 ((SQL14_RTM_QFE-CU).141211-1636)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/7b53fe2f993e41209ea93c774deed22f1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.2456.00 ((SQL14_RTM_QFE-CU).141211-1636)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/214c250884534e1aa0185e6bef362a521/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2456.00 ((SQL14_RTM_QFE-CU).141211-1636)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/9b95a106672640318876b62eb49ce32b2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2456.00 ((SQL14_RTM_QFE-CU).141211-1636)
```

# SQL Server 2014 RTM CU5 - 12.0.2456.0 - x86 (KB3011055)
``` powershell
# SQL Server 2014 RTM CU5 - 12.0.2456.0 - x86 (KB3011055)
$outputFolder = 'c:\sqlsyms\12.0.2456.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/b845d2f2afb44859904e1c51ea2df77c1/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.2456.00 ((SQL14_RTM_QFE-CU).141211-1636)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/93ab40244d4b4108b3e1e5e507a841f81/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2456.00 ((SQL14_RTM_QFE-CU).141211-1636)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/3bd2da20bc3d42df9bda66521f4763141/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2456.00 ((SQL14_RTM_QFE-CU).141211-1636)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/301c79ece27a4a4ea90a4026b151273d1/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.2456.00 ((SQL14_RTM_QFE-CU).141211-1636)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/15d84d064320486d8f0aa9c175e73ff72/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2456.00 ((SQL14_RTM_QFE-CU).141211-1636)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/677fc25409af4e5cb079fc220a507a281/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2456.00 ((SQL14_RTM_QFE-CU).141211-1636)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/c99783448e224e5ead440e48808f3a371/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2456.00 ((SQL14_RTM_QFE-CU).141211-1636)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/3ee8df660b704120a5769fe486d912b91/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2456.00 ((SQL14_RTM_QFE-CU).141211-1636)
```

# SQL Server 2014 RTM CU4 - 12.0.2430.0 - x64 (KB2999197)
``` powershell
# SQL Server 2014 RTM CU4 - 12.0.2430.0 - x64 (KB2999197)
$outputFolder = 'c:\sqlsyms\12.0.2430.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/8ed2ab1b64c64cd6b53be5ba2940d1a42/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.2430.00 ((SQL14_RTM_QFE-CU).141015-1502)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/1d8587b3f0eb464f8da9733cc91606862/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2430.00 ((SQL14_RTM_QFE-CU).141015-1502)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/21f00ed9f1534ee39faf557af2efe0b22/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2430.00 ((SQL14_RTM_QFE-CU).141015-1502)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/0999d6303e144ea494c2befc049f4f052/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.2430.00 ((SQL14_RTM_QFE-CU).141015-1502)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/f21b42e831e3406796f8341329a2109c2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2430.00 ((SQL14_RTM_QFE-CU).141015-1502)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/6ea90b282987428e950c06ca61b48d022/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2430.00 ((SQL14_RTM_QFE-CU).141015-1502)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/72b8a33dcd5a4c199f48947510111e4f1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.2430.00 ((SQL14_RTM_QFE-CU).141015-1502)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/c3f38698f3db4272bbf911928e3a71c91/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.2430.00 ((SQL14_RTM_QFE-CU).141015-1502)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/c9e0caaa8d11431aadaff0f8fc85c2041/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.2430.00 ((SQL14_RTM_QFE-CU).141015-1502)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/f98a21da91c24cfdb165f8f2c1a4019d1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2430.00 ((SQL14_RTM_QFE-CU).141015-1502)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/3863b99a65d94c2f9aba257ddb80519c2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2430.00 ((SQL14_RTM_QFE-CU).141015-1502)
```

# SQL Server 2014 RTM CU4 - 12.0.2430.0 - x86 (KB2999197)
``` powershell
# SQL Server 2014 RTM CU4 - 12.0.2430.0 - x86 (KB2999197)
$outputFolder = 'c:\sqlsyms\12.0.2430.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/c842b82043f14b56bbdaf6f3daf8c9361/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.2430.00 ((SQL14_RTM_QFE-CU).141015-1502)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/bd6cc732c1a04a70949c746ad7c75bfc1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2430.00 ((SQL14_RTM_QFE-CU).141015-1502)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/5e255a6c840c4135afd13947b885a0bc1/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2430.00 ((SQL14_RTM_QFE-CU).141015-1502)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/bf46680cb561413d92bf308f29ed422d1/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.2430.00 ((SQL14_RTM_QFE-CU).141015-1502)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/c2a06041e7e2494889e753f9633f49ad2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2430.00 ((SQL14_RTM_QFE-CU).141015-1502)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/b6b6b351ea9b4ddc8d275499e307dc371/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2430.00 ((SQL14_RTM_QFE-CU).141015-1502)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/d44e146dd57b4e84bd689c2dc23f38a21/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2430.00 ((SQL14_RTM_QFE-CU).141015-1502)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/0bad01bb555b4a9a9fb58bba8dbdee961/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2430.00 ((SQL14_RTM_QFE-CU).141015-1502)
```

# SQL Server 2014 RTM CU3 - 12.0.2402.0 - x64 (KB2984923)
``` powershell
# SQL Server 2014 RTM CU3 - 12.0.2402.0 - x64 (KB2984923)
$outputFolder = 'c:\sqlsyms\12.0.2402.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/74853044551f42dc87b5388cb869e80e2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.2402.00 ((SQL14_RTM_QFE-CU).140813-1032)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/b95f32db724a460eb6eef6e130b837262/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2402.00 ((SQL14_RTM_QFE-CU).140813-1032)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/ea34d76c06f34b6cb7b0908f0746c0782/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2402.00 ((SQL14_RTM_QFE-CU).140813-1032)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/b0d9d6294e034a73afeeee938172760b2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.2402.00 ((SQL14_RTM_QFE-CU).140813-1032)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/bf41580581a9420fb851f76ec3afb75a2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2402.00 ((SQL14_RTM_QFE-CU).140813-1032)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/f96bf02390534634bdc1e8d623c2d33a2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2402.00 ((SQL14_RTM_QFE-CU).140813-1032)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/f822ab6d65fc431cb5ab54b0ee8e3d4e1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.2402.00 ((SQL14_RTM_QFE-CU).140813-1032)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/7b77a2193e4f4891b0f34f9cda87f7b11/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.2402.00 ((SQL14_RTM_QFE-CU).140813-1032)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/5ef94f8c3ac34e8494fe1807ea68107b1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.2402.00 ((SQL14_RTM_QFE-CU).140813-1032)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/70d73245215e4eb1968511982957b5a51/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2402.00 ((SQL14_RTM_QFE-CU).140813-1032)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/56ece3cd49754bf8b5aea9068ca1858a2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2402.00 ((SQL14_RTM_QFE-CU).140813-1032)
```

# SQL Server 2014 RTM CU3 - 12.0.2402.0 - x86 (KB2984923)
``` powershell
# SQL Server 2014 RTM CU3 - 12.0.2402.0 - x86 (KB2984923)
$outputFolder = 'c:\sqlsyms\12.0.2402.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/0232dbfdd56b459fb96c006f563d2f6c1/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.2402.00 ((SQL14_RTM_QFE-CU).140813-1032)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/0d331b541b294e44a065cae4384077da1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2402.00 ((SQL14_RTM_QFE-CU).140813-1032)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/1fdf9f2c4cd74c4c99eaf0b33fb615271/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2402.00 ((SQL14_RTM_QFE-CU).140813-1032)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/1f461bef6f764833badbfb63717c6ca21/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.2402.00 ((SQL14_RTM_QFE-CU).140813-1032)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/8dde3944f69a481aa12e39b50dc1387e2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2402.00 ((SQL14_RTM_QFE-CU).140813-1032)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/fc462491d53f4437bbf3b53c21a2d19b1/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2402.00 ((SQL14_RTM_QFE-CU).140813-1032)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/3abaa853cdfd43538b656cf6b8ed08f41/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2402.00 ((SQL14_RTM_QFE-CU).140813-1032)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/c1fcff98a6144ea89585dbf7506c49c31/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2402.00 ((SQL14_RTM_QFE-CU).140813-1032)
```

# SQL Server 2014 RTM CU2 - 12.0.2370.0 - x64 (KB2967546)
``` powershell
# SQL Server 2014 RTM CU2 - 12.0.2370.0 - x64 (KB2967546)
$outputFolder = 'c:\sqlsyms\12.0.2370.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/00fe9a5483574e96ba85d4e14743c8cf2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.2370.00 ((SQL14_RTM_QFE-CU).140621-1135)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/c0cd8d60c1ac4687a1f529cca07230152/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2370.00 ((SQL14_RTM_QFE-CU).140621-1135)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/a3e0e381d1dc4ba2abefa830fb5908072/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2370.00 ((SQL14_RTM_QFE-CU).140621-1135)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/abf0ec3c6c1f49efb5ad08dbf408ef8e2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.2370.00 ((SQL14_RTM_QFE-CU).140621-1135)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/2709a8f9d5804dc695ad1b95124e3c732/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2370.00 ((SQL14_RTM_QFE-CU).140621-1135)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/27958e94f9a14900b53db20d28600db82/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2370.00 ((SQL14_RTM_QFE-CU).140621-1135)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/af790770d88f4c40a2b39623e71a4dab1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.2370.00 ((SQL14_RTM_QFE-CU).140621-1135)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/d4ac25f2460744f992933ca2b332429e1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.2370.00 ((SQL14_RTM_QFE-CU).140621-1135)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/21a099f1ea704e979734421be237b3751/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.2370.00 ((SQL14_RTM_QFE-CU).140621-1135)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/28d76d0753dc4ed1b8a26d6a8820df5e1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2370.00 ((SQL14_RTM_QFE-CU).140621-1135)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/021ad6b05b234d8484546842381e7d652/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2370.00 ((SQL14_RTM_QFE-CU).140621-1135)
```

# SQL Server 2014 RTM CU2 - 12.0.2370.0 - x86 (KB2967546)
``` powershell
# SQL Server 2014 RTM CU2 - 12.0.2370.0 - x86 (KB2967546)
$outputFolder = 'c:\sqlsyms\12.0.2370.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/efa900c9c1eb4134a444a4adf16505551/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.2370.00 ((SQL14_RTM_QFE-CU).140621-1135)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/7e9bd6b6dc8f41448ceaad495e2da09a1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2370.00 ((SQL14_RTM_QFE-CU).140621-1135)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/1866d12aa39c485397ac98c9edfb88101/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2370.00 ((SQL14_RTM_QFE-CU).140621-1135)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/3cd6a9cb42774008ad553c1ff1b647d91/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.2370.00 ((SQL14_RTM_QFE-CU).140621-1135)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/9c6ed829937f4036b7fabcff7173cdab2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2370.00 ((SQL14_RTM_QFE-CU).140621-1135)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/6f14e9defc694da98c58fd58d3a358481/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2370.00 ((SQL14_RTM_QFE-CU).140621-1135)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/54dbf7bb6af447298c7637a9ada989ac1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2370.00 ((SQL14_RTM_QFE-CU).140621-1135)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/1e3ffb2e704744d6a73cfb79cb38619f1/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2370.00 ((SQL14_RTM_QFE-CU).140621-1135)
```

# SQL Server 2014 RTM CU1 - 12.0.2342.0 - x64 (KB2931693)
``` powershell
# SQL Server 2014 RTM CU1 - 12.0.2342.0 - x64 (KB2931693)
$outputFolder = 'c:\sqlsyms\12.0.2342.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/57c252c885d8450b93688037679d5db22/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2014.0120.2342.00 ((SQL14_RTM_QFE-CU).140404-1739)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/a35c73537ad64f2ab17ad8ef76ceeb4c2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2342.00 ((SQL14_RTM_QFE-CU).140404-1739)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/550f9e5b95f44c42a77d2f32154b77eb2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2342.00 ((SQL14_RTM_QFE-CU).140404-1739)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/b97e3ca52a8e4182992f891a812e911d2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2014.0120.2342.00 ((SQL14_RTM_QFE-CU).140404-1739)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/65b8869fb0b44abfaf9f3635bb4c694f2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2342.00 ((SQL14_RTM_QFE-CU).140404-1739)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/9e454a85cdba496dbb47c8aeb1d5c66b2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2342.00 ((SQL14_RTM_QFE-CU).140404-1739)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/ba6cba69141549d4b828b2e3a8e69b981/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2014.0120.2342.00 ((SQL14_RTM_QFE-CU).140404-1739)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/fe5ab059d8de48b6b74bd26c7c0015ca1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2014.0120.2342.00 ((SQL14_RTM_QFE-CU).140404-1739)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/318b9d34af1d4e1780ef5277e5a5a8741/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2014.0120.2342.00 ((SQL14_RTM_QFE-CU).140404-1739)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/8f42604977cd4be4a8c3d12f390048cf1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2342.00 ((SQL14_RTM_QFE-CU).140404-1739)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/5460fb87c3d54751906607c8a455f81a2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2342.00 ((SQL14_RTM_QFE-CU).140404-1739)
```

# SQL Server 2014 RTM CU1 - 12.0.2342.0 - x86 (KB2931693)
``` powershell
# SQL Server 2014 RTM CU1 - 12.0.2342.0 - x86 (KB2931693)
$outputFolder = 'c:\sqlsyms\12.0.2342.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/74815ec15b4c4e5db8b41b9f77197a431/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2014.0120.2342.00 ((SQL14_RTM_QFE-CU).140404-1739)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/33e87393cabf44a381d3b0d5f7d36efe1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2014.0120.2342.00 ((SQL14_RTM_QFE-CU).140404-1739)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/e84e6950792046a9ad837c8451c0bab41/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2014.0120.2342.00 ((SQL14_RTM_QFE-CU).140404-1739)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/2369cc5ed5334d2587d538a1075230d01/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2014.0120.2342.00 ((SQL14_RTM_QFE-CU).140404-1739)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/6982bb0a3859490eae0d8885cc0dd1322/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2014.0120.2342.00 ((SQL14_RTM_QFE-CU).140404-1739)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/5d24211092fb49aaa62c76ee12da579f1/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2014.0120.2342.00 ((SQL14_RTM_QFE-CU).140404-1739)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/c98e147056fd4ad9bc50de8c6705590a1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2014.0120.2342.00 ((SQL14_RTM_QFE-CU).140404-1739)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/76992783851b4654be2bd359dc53bc831/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2014.0120.2342.00 ((SQL14_RTM_QFE-CU).140404-1739)
```

