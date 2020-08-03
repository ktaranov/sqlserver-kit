# SQL Server 2016 SP2 CU13 - 13.0.5820.21 - x64 (KB4549825)
``` powershell
# SQL Server 2016 SP2 CU13 - 13.0.5820.21 - x64 (KB4549825)
$outputFolder = 'c:\sqlsyms\13.0.5820.21\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/e6a5231d69314339a622dec94dcdd7d32/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0131.5820.21 ((SQL16_SP2_QFE-CU).200522-0642)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/96c764d747bf420b9996befef7475c9a2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0131.5820.21 ((SQL16_SP2_QFE-CU).200522-0642)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/9ee1aa873d2d4b778e6a54459fd7914d2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0131.5820.21 ((SQL16_SP2_QFE-CU).200522-0642)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/e09ce83a1ee54955a5e6406176a389362/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0131.5820.21 ((SQL16_SP2_QFE-CU).200522-0642)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/62fe14b4c3604a3fb403bb7e22940c362/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0131.5820.21 ((SQL16_SP2_QFE-CU).200522-0642)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/7221bd8eef08483c81a4a857dd6587d82/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0131.5820.21 ((SQL16_SP2_QFE-CU).200522-0642)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/aa95581843cc476f8b86d487e4f708f51/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0131.5820.21 ((SQL16_SP2_QFE-CU).200522-0642)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/22bf33591a704ff09291525ac1d00d191/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0131.5820.21 ((SQL16_SP2_QFE-CU).200522-0642)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/8f4b1832517446938ef926263aab57cf1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0131.5820.21 ((SQL16_SP2_QFE-CU).200522-0642)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/f8668e661315449497cea566e51c83131/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0131.5820.21 ((SQL16_SP2_QFE-CU).200522-0642)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/2633f57463f64221a5ebeff75ed2100d2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0131.5820.21 ((SQL16_SP2_QFE-CU).200522-0642)
```

# SQL Server 2016 SP2 CU12 - 13.0.5698.0 - x64 (KB4536648)
``` powershell
# SQL Server 2016 SP2 CU12 - 13.0.5698.0 - x64 (KB4536648)
$outputFolder = 'c:\sqlsyms\13.0.5698.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/0271f8481dae4e9493e450b8dc796bc02/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0131.5698.00 ((SQL16_SP2_QFE-CU).200215-0125)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/641b2f06bbc146b38bc05e9b58e36d0f2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0131.5698.00 ((SQL16_SP2_QFE-CU).200215-0125)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/72307bde192a4c319454098c20cb912b2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0131.5698.00 ((SQL16_SP2_QFE-CU).200215-0125)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/bcd4e428d7c94039b4955ed076e7a3682/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0131.5698.00 ((SQL16_SP2_QFE-CU).200215-0125)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/92812c2e4617474db8111c7804eda4f92/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0131.5698.00 ((SQL16_SP2_QFE-CU).200215-0125)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/5a323ebb0fbc4248b605abd7c0654b2c2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0131.5698.00 ((SQL16_SP2_QFE-CU).200215-0125)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/d3cd4e59ac0046c1a6f61aafb00e2c4c1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0131.5698.00 ((SQL16_SP2_QFE-CU).200215-0125)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/20e8d53a37e1427cb93fa7cafe5f27aa1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0131.5698.00 ((SQL16_SP2_QFE-CU).200215-0125)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/d0bcad819dcc4842929e81a1e9ecb59e1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0131.5698.00 ((SQL16_SP2_QFE-CU).200215-0125)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/98ebdb42d04440ba9295070f88407f6a1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0131.5698.00 ((SQL16_SP2_QFE-CU).200215-0125)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/0148f923aea94af19053f99ba79996682/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0131.5698.00 ((SQL16_SP2_QFE-CU).200215-0125)
```

# SQL Server 2016 SP2 CU11 - 13.0.5598.27 - x64 (KB4527378)
``` powershell
# SQL Server 2016 SP2 CU11 - 13.0.5598.27 - x64 (KB4527378)
$outputFolder = 'c:\sqlsyms\13.0.5598.27\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/430ef93c7b564dc2a93647e6e1fafc8c2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0131.5598.27 ((SQL16_SP2_QFE-CU).191127-1657)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/79015e09729743128701ee4f66f24fe92/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0131.5598.27 ((SQL16_SP2_QFE-CU).191127-1657)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/c4b83e706a594c56b9f509cd06c33b762/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0131.5598.27 ((SQL16_SP2_QFE-CU).191127-1657)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/f137caf5bd854030935dcf93b62eeaeb2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0131.5598.27 ((SQL16_SP2_QFE-CU).191127-1657)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/832f21f9f07244ca8ae43ecb5f76fb9d2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0131.5598.27 ((SQL16_SP2_QFE-CU).191127-1657)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/1aefde25bf814c2197bd09f7f58513292/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0131.5598.27 ((SQL16_SP2_QFE-CU).191127-1657)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/380b9e486b1643008a409f775f7c8a411/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0131.5598.27 ((SQL16_SP2_QFE-CU).191127-1657)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/001fd9d68d3c4dae8e89c2402fa889021/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0131.5598.27 ((SQL16_SP2_QFE-CU).191127-1657)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/75ccea7cdb124f4a8ececf21620e312f1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0131.5598.27 ((SQL16_SP2_QFE-CU).191127-1657)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/8a1a47fa116541d3bf3428149ba6b3bb1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0131.5598.27 ((SQL16_SP2_QFE-CU).191127-1657)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/186252fbc0884d24b6fe231af0759a352/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0131.5598.27 ((SQL16_SP2_QFE-CU).191127-1657)
```

# SQL Server 2016 SP2 CU10 - 13.0.5492.2 - x64 (KB4524334)
``` powershell
# SQL Server 2016 SP2 CU10 - 13.0.5492.2 - x64 (KB4524334)
$outputFolder = 'c:\sqlsyms\13.0.5492.2\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/70ecf5dbd5ef45d58df538eeb5e739b42/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0131.5492.02 ((SQL16_SP2_QFE-CU).191004-1836)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/63e1be959b6b450b974b7736342adbfa2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0131.5492.02 ((SQL16_SP2_QFE-CU).191004-1836)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/bf2a1e4b8d03428aacfea5d795e2425b2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0131.5492.02 ((SQL16_SP2_QFE-CU).191004-1836)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/fd96f94072a141758a4cbea2812690a12/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0131.5492.02 ((SQL16_SP2_QFE-CU).191004-1836)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/4048059f80d943babfc3f6c28cbaea1f2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0131.5492.02 ((SQL16_SP2_QFE-CU).191004-1836)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/bb191544f6184394adf2c918affc041f2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0131.5492.02 ((SQL16_SP2_QFE-CU).191004-1836)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/d5895ca6c7dc4374b010a96739da4bc21/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0131.5492.02 ((SQL16_SP2_QFE-CU).191004-1836)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/801fb6f15a7f4965acaabfab3e987d9c1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0131.5492.02 ((SQL16_SP2_QFE-CU).191004-1836)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/c3151df89b1c457dabf76e34c04f1bb71/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0131.5492.02 ((SQL16_SP2_QFE-CU).191004-1836)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/6f298cba9ac5443cb1450d8082c0c3011/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0131.5492.02 ((SQL16_SP2_QFE-CU).191004-1836)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/006c2ae04bf045c0a9b5effd267136ad2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0131.5492.02 ((SQL16_SP2_QFE-CU).191004-1836)
```

# SQL Server 2016 SP2 CU8 - 13.0.5426.0 - x64 (KB4505830)
``` powershell
# SQL Server 2016 SP2 CU8 - 13.0.5426.0 - x64 (KB4505830)
$outputFolder = 'c:\sqlsyms\13.0.5426.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/18b397dfe9034092a48167ec1ec5ea0b2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0131.5426.00 ((SQL16_SP2_QFE-CU).190721-2038)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/132b5e0d712b4464be80ed12e1e5505e2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0131.5426.00 ((SQL16_SP2_QFE-CU).190721-2038)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/db48420d121b42899a92f0d23dc57ad22/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0131.5426.00 ((SQL16_SP2_QFE-CU).190721-2038)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/d5acd14328d4434abea6af32ef61536a2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0131.5426.00 ((SQL16_SP2_QFE-CU).190721-2038)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/32d9395ab3de4e75a7e11a1d23cb5e822/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0131.5426.00 ((SQL16_SP2_QFE-CU).190721-2038)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/c010f16083f14fab9a85dd2d21893a302/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0131.5426.00 ((SQL16_SP2_QFE-CU).190721-2038)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/9dfd9945902246ccb7d504ba4d348f461/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0131.5426.00 ((SQL16_SP2_QFE-CU).190721-2038)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/331c42cbf74a420e81faba8d2c85a3cf1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0131.5426.00 ((SQL16_SP2_QFE-CU).190721-2038)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/7acfbd3f08164c9aa7b501bf677cb43c1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0131.5426.00 ((SQL16_SP2_QFE-CU).190721-2038)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/d604a24250b64ca6a926842ec51546ad1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0131.5426.00 ((SQL16_SP2_QFE-CU).190721-2038)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/1e0e6f6d8afd403bbb31684416b9314e2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0131.5426.00 ((SQL16_SP2_QFE-CU).190721-2038)
```

# SQL Server 2016 SP2 Hotfix for SP2 CU7 - 13.0.5343.1 - x64 (4508636)
``` powershell
# SQL Server 2016 SP2 Hotfix for SP2 CU7 - 13.0.5343.1 - x64 (4508636)
$outputFolder = 'c:\sqlsyms\13.0.5343.1\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/e4884387ee894c14b9ba32a55b1e4ed72/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0131.5343.01 ((SQL16_SP2_QFE-OD).190614-1944)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/5504c31fbc484a04960c330f5520df7a2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0131.5343.01 ((SQL16_SP2_QFE-OD).190614-1944)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/b4414980247d436abdf4cf4c43f5023f2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0131.5343.01 ((SQL16_SP2_QFE-OD).190614-1944)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/47b47fc8b89d47d5a82297cf24630ca02/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0131.5343.01 ((SQL16_SP2_QFE-OD).190614-1944)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/72d0f73f142c4d1f9c2be9ce5c5f9a7b2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0131.5343.01 ((SQL16_SP2_QFE-OD).190614-1944)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/66bd5fc8cd934353b7fa1b2db5d1e5382/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0131.5343.01 ((SQL16_SP2_QFE-OD).190614-1944)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/5e06fd5a624848ff9a02a71ddf0c11481/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0131.5343.01 ((SQL16_SP2_QFE-OD).190614-1944)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/ca29126933fd43f7bcc35106076ac2471/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0131.5343.01 ((SQL16_SP2_QFE-OD).190614-1944)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/25e8c49501a8498a86d2a13ab329b3ea1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0131.5343.01 ((SQL16_SP2_QFE-OD).190614-1944)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/ccd4f61a1ae7416b9caecb49e46c96ca1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0131.5343.01 ((SQL16_SP2_QFE-OD).190614-1944)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/9dd288e031a2402dbad6f68c468a1f662/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0131.5343.01 ((SQL16_SP2_QFE-OD).190614-1944)
```

# SQL Server 2016 SP2 CU7 - 13.0.5337.0 - x64 (KB4495256)
``` powershell
# SQL Server 2016 SP2 CU7 - 13.0.5337.0 - x64 (KB4495256)
$outputFolder = 'c:\sqlsyms\13.0.5337.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/19f0728b189a437db61f6d0a59378c2f2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0131.5337.00 ((SQL16_SP2_QFE-CU).190516-0131)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/27a0893b43494606b4da007056d14b8f2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0131.5337.00 ((SQL16_SP2_QFE-CU).190516-0131)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/53f66882dcc948a5ab43ccf35f8c62172/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0131.5337.00 ((SQL16_SP2_QFE-CU).190516-0131)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/26528819a67f4c9793cdb2c6b6d25f022/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0131.5337.00 ((SQL16_SP2_QFE-CU).190516-0131)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/f6d28fb6f5ac469a828b160544679d362/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0131.5337.00 ((SQL16_SP2_QFE-CU).190516-0131)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/956090e1037945b2928f4f605b52ded32/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0131.5337.00 ((SQL16_SP2_QFE-CU).190516-0131)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/55ab1c4583324e4181dc2d13638a270c1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0131.5337.00 ((SQL16_SP2_QFE-CU).190516-0131)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/4a5ef712546c4ea593b3919fc8e9be3c1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0131.5337.00 ((SQL16_SP2_QFE-CU).190516-0131)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/b29f002c7c8546f399a8818e0f01340f1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0131.5337.00 ((SQL16_SP2_QFE-CU).190516-0131)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/decb2afdf5ad41c48644e8ee74024d501/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0131.5337.00 ((SQL16_SP2_QFE-CU).190516-0131)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/e272bf31dd404e02800badc8605d29702/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0131.5337.00 ((SQL16_SP2_QFE-CU).190516-0131)
```

# SQL Server 2016 SP2 CU6 - 13.0.5292.0 - x64 (KB4488536)
``` powershell
# SQL Server 2016 SP2 CU6 - 13.0.5292.0 - x64 (KB4488536)
$outputFolder = 'c:\sqlsyms\13.0.5292.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/950cfd27fb154e0fa81f5171d3a9e72c2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0131.5292.00 ((SQL16_SP2_QFE-CU).190311-2257)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/f4e8c4a23f0e4300b84aff830703780e2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0131.5292.00 ((SQL16_SP2_QFE-CU).190311-2257)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/98e48204764e43beb5a7512730a309542/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0131.5292.00 ((SQL16_SP2_QFE-CU).190311-2257)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/2c6f6ddf2326442bbf1d71142d177eb12/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0131.5292.00 ((SQL16_SP2_QFE-CU).190311-2257)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/e677182deae14a179afc8d4cd0de3e682/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0131.5292.00 ((SQL16_SP2_QFE-CU).190311-2257)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/705ca25058a944e6ab3c1ab89d77de3c2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0131.5292.00 ((SQL16_SP2_QFE-CU).190311-2257)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/6b45c84e9e8e4450ac26bdc614b491da1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0131.5292.00 ((SQL16_SP2_QFE-CU).190311-2257)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/1f44e38a066b4c9aad14b90ea547e5f11/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0131.5292.00 ((SQL16_SP2_QFE-CU).190311-2257)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/bcf044a5cfc64d03be7cdf8df023bd2d1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0131.5292.00 ((SQL16_SP2_QFE-CU).190311-2257)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/dad251dee8644e4dbf61bedbcf9a06bf1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0131.5292.00 ((SQL16_SP2_QFE-CU).190311-2257)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/d6c736e277fd4baf8e88d3b6d27cff362/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0131.5292.00 ((SQL16_SP2_QFE-CU).190311-2257)
```

# SQL Server 2016 SP2 CU5 - 13.0.5264.1 - x64 (KB4475776)
``` powershell
# SQL Server 2016 SP2 CU5 - 13.0.5264.1 - x64 (KB4475776)
$outputFolder = 'c:\sqlsyms\13.0.5264.1\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/0bae10a1491645f8a97b697fe565dd332/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0131.5264.01 ((SQL16_SP2_QFE-CU).190110-1506)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/85a6f0d21b0a4d8f96d6aa8049a1c8892/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0131.5264.01 ((SQL16_SP2_QFE-CU).190110-1506)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/f5b7a81e036a4be3bc7c1858909869802/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0131.5264.01 ((SQL16_SP2_QFE-CU).190110-1506)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/e8f4359ed540405ebf50b2593e54434b2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0131.5264.01 ((SQL16_SP2_QFE-CU).190110-1506)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/73d85290046448bdbcc3ede97dfc234b2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0131.5264.01 ((SQL16_SP2_QFE-CU).190110-1506)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/81dc5887677b47be879138df0c3009b12/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0131.5264.01 ((SQL16_SP2_QFE-CU).190110-1506)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/97818e2e150f41d4a1b3882e98aee44e1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0131.5264.01 ((SQL16_SP2_QFE-CU).190110-1506)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/fcb62686788c4edab5fbbb3586fa70641/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0131.5264.01 ((SQL16_SP2_QFE-CU).190110-1506)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/e3d3a5d84aa04e1c95a508d1a2a121ca1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0131.5264.01 ((SQL16_SP2_QFE-CU).190110-1506)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/8f3f2c17b925463ab3be306a8bfbf6191/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0131.5264.01 ((SQL16_SP2_QFE-CU).190110-1506)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/21046a92c3c344459925db3348bed5402/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0131.5264.01 ((SQL16_SP2_QFE-CU).190110-1506)
```

# SQL Server 2016 SP2 CU4 - 13.0.5233.0 - x64 (KB4464106)
``` powershell
# SQL Server 2016 SP2 CU4 - 13.0.5233.0 - x64 (KB4464106)
$outputFolder = 'c:\sqlsyms\13.0.5233.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/f1595ec49d654c548b60b5b8640881562/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0131.5233.00 ((SQL16_SP2_QFE-CU).181102-1539)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/8d1e052738ed4834ac1162b8970bf0532/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0131.5233.00 ((SQL16_SP2_QFE-CU).181102-1539)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/9b29b84d1daa4cb690c91697520de38a2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0131.5233.00 ((SQL16_SP2_QFE-CU).181102-1539)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/7975964f1eb7477988fd520d142465bf2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0131.5233.00 ((SQL16_SP2_QFE-CU).181102-1539)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/1be684f3c3984a379a6438f8c36fbb4a2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0131.5233.00 ((SQL16_SP2_QFE-CU).181102-1539)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/17bc4cfd173e428fb9eae9da392a49682/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0131.5233.00 ((SQL16_SP2_QFE-CU).181102-1539)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/87146b12ed3649fa9968b622bb55394e1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0131.5233.00 ((SQL16_SP2_QFE-CU).181102-1539)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/f428b375b3ac4ef38be75a3d7affd27b1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0131.5233.00 ((SQL16_SP2_QFE-CU).181102-1539)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/624caa45728c42819a84a8a89279d3471/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0131.5233.00 ((SQL16_SP2_QFE-CU).181102-1539)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/1f8acdfa201f4b3fb8fd8b64013b32be1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0131.5233.00 ((SQL16_SP2_QFE-CU).181102-1539)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/45097423fa97421fb2c60e85d141580c2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0131.5233.00 ((SQL16_SP2_QFE-CU).181102-1539)
```

# SQL Server 2016 SP2 CU3 - 13.0.5216.0 - x64 (KB4458871)
``` powershell
# SQL Server 2016 SP2 CU3 - 13.0.5216.0 - x64 (KB4458871)
$outputFolder = 'c:\sqlsyms\13.0.5216.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/f9c66f15cdc3472da5b316372a3cd0c62/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0131.5216.00 ((SQL16_SP2_QFE-CU).180913-2138)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/4eb925dc9f414f4293fb048931c1d1d12/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0131.5216.00 ((SQL16_SP2_QFE-CU).180913-2138)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/2aaea59f054945b1948f09a286af4aa22/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0131.5216.00 ((SQL16_SP2_QFE-CU).180913-2138)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/d9a41e1b050741a9915c9f2f68841b662/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0131.5216.00 ((SQL16_SP2_QFE-CU).180913-2138)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/127cbf6e83634f56858c143daccdf3472/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0131.5216.00 ((SQL16_SP2_QFE-CU).180913-2138)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/8cd3001646bb4bee9fa7b29c4e3c424d2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0131.5216.00 ((SQL16_SP2_QFE-CU).180913-2138)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/cef124fae1224970a283718094129ec41/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0131.5216.00 ((SQL16_SP2_QFE-CU).180913-2138)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/3428a25be3a1405bb9e935aa5e5a5f921/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0131.5216.00 ((SQL16_SP2_QFE-CU).180913-2138)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/86edaf9016ec43d49af82793f7361d011/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0131.5216.00 ((SQL16_SP2_QFE-CU).180913-2138)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/25fb6b2428844941bc633974f50616bc1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0131.5216.00 ((SQL16_SP2_QFE-CU).180913-2138)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/df83d51fbc304a579684e3c308750cba2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0131.5216.00 ((SQL16_SP2_QFE-CU).180913-2138)
```

# SQL Server 2016 SP2 CU2 + Security Update - 13.0.5201.2 - x64 (KB4458621)
``` powershell
# SQL Server 2016 SP2 CU2 + Security Update - 13.0.5201.2 - x64 (KB4458621)
$outputFolder = 'c:\sqlsyms\13.0.5201.2\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/048d5147a1fb4e80b787588ffc9fc1e62/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0131.5201.02 ((SQL16_SP2_QFE-CU).180818-0710)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/a75b883c7cf144338e088ca1afe44c472/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0131.5201.02 ((SQL16_SP2_QFE-CU).180818-0710)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/fadd356647c4454191fdf160228f57e72/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0131.5201.02 ((SQL16_SP2_QFE-CU).180818-0710)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/55d8b0e99a7446308229c50cefdd930e2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0131.5201.02 ((SQL16_SP2_QFE-CU).180818-0710)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/f7a6fc258016430597598d515e0a483f2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0131.5201.02 ((SQL16_SP2_QFE-CU).180818-0710)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/8f9e0659b5514f89b3cac5bdcfc7e3882/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0131.5201.02 ((SQL16_SP2_QFE-CU).180818-0710)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/ecb9fb39a89c4e59b3daad0b525fa9b71/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0131.5201.02 ((SQL16_SP2_QFE-CU).180818-0710)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/9ecba208484247eaa0a0e2d43c3bbb5d1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0131.5201.02 ((SQL16_SP2_QFE-CU).180818-0710)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/d05ba204ab6d4176bfa45358d8bc42121/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0131.5201.02 ((SQL16_SP2_QFE-CU).180818-0710)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/41df1265eeed4d5086844d85018088bf1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0131.5201.02 ((SQL16_SP2_QFE-CU).180818-0710)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/8360d2c4f315435cb1a449b1ebe4a68a2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0131.5201.02 ((SQL16_SP2_QFE-CU).180818-0710)
```

# SQL Server 2016 SP2 CU2 - 13.0.5153.0 - x64 (KB4340355)
``` powershell
# SQL Server 2016 SP2 CU2 - 13.0.5153.0 - x64 (KB4340355)
$outputFolder = 'c:\sqlsyms\13.0.5153.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/fddc412a5dcb40429eda4fb2f4fb09572/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0131.5153.00 ((SQL16_SP2_QFE-CU).180628-1652)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/dd1807b4810a4aee89a261e957c2d8f92/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0131.5153.00 ((SQL16_SP2_QFE-CU).180628-1652)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/0e02593224ce4b00a8ae88c15f7554822/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0131.5153.00 ((SQL16_SP2_QFE-CU).180628-1652)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/7f96e1cef4e24bd58ce1bfb0097d7bd62/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0131.5153.00 ((SQL16_SP2_QFE-CU).180628-1652)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/cbb698692191446e8e63cbb247cb4abe2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0131.5153.00 ((SQL16_SP2_QFE-CU).180628-1652)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/ce4e0c0acef54b2e889a6e92ce618f3b2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0131.5153.00 ((SQL16_SP2_QFE-CU).180628-1652)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/8b8a156300244f6d998e9518bf3655741/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0131.5153.00 ((SQL16_SP2_QFE-CU).180628-1652)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/f332d042c9ba422c8fb4dadb8ad6bd601/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0131.5153.00 ((SQL16_SP2_QFE-CU).180628-1652)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/f507bb1cdc6b4c46b06676fde5cdf8c71/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0131.5153.00 ((SQL16_SP2_QFE-CU).180628-1652)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/9689d6f86afc4da78d5cfb3bfbe5950b1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0131.5153.00 ((SQL16_SP2_QFE-CU).180628-1652)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/bb2788ca8bc24a8cac395d4371de62422/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0131.5153.00 ((SQL16_SP2_QFE-CU).180628-1652)
```

# SQL Server 2016 SP2 CU1 - 13.0.5149.0 - x64 (KB4135048)
``` powershell
# SQL Server 2016 SP2 CU1 - 13.0.5149.0 - x64 (KB4135048)
$outputFolder = 'c:\sqlsyms\13.0.5149.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/6d9698a353374e5c938b2acb7ee7ed362/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0131.5149.00 ((SQL16_SP2_QFE-CU).180519-0907)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/37faf9a6bc2b4d16a8d962d486092a302/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0131.5149.00 ((SQL16_SP2_QFE-CU).180519-0907)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/271e230238254765bcd979679d6b56982/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0131.5149.00 ((SQL16_SP2_QFE-CU).180519-0907)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/9f9dc614a58242c2a85acc563e431db62/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0131.5149.00 ((SQL16_SP2_QFE-CU).180519-0907)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/bf258f9a750546b6a8b936b4970b7eca2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0131.5149.00 ((SQL16_SP2_QFE-CU).180519-0907)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/b896f5579e09485e9d9eec87d67b676f2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0131.5149.00 ((SQL16_SP2_QFE-CU).180519-0907)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/3cd9ede70ebf4e4185992fe4fa65b2d61/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0131.5149.00 ((SQL16_SP2_QFE-CU).180519-0907)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/f31fd9f5e3ef4fe096cf59903c387f4b1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0131.5149.00 ((SQL16_SP2_QFE-CU).180519-0907)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/762df1defe62466280d87d81794865c61/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0131.5149.00 ((SQL16_SP2_QFE-CU).180519-0907)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/72d4af7f134e4cb49edcccf5f4cf383f1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0131.5149.00 ((SQL16_SP2_QFE-CU).180519-0907)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/c5ce87b693a14696b7df5cb69aee3d442/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0131.5149.00 ((SQL16_SP2_QFE-CU).180519-0907)
```

# SQL Server 2016 SP2 SP2 - 13.0.5026.0 - x64 (KB4052908)
``` powershell
# SQL Server 2016 SP2 SP2 - 13.0.5026.0 - x64 (KB4052908)
$outputFolder = 'c:\sqlsyms\13.0.5026.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/efc619ab5524425aa224c623beaf4a662/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0131.5026.00 ((SQL16_PCU_Main).180318-0835)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/104358b4c4b04eec8a75e36af274c29f2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0131.5026.00 ((SQL16_PCU_Main).180318-0835)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/cae1133e7ab54002a38c876e49559d222/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0131.5026.00 ((SQL16_PCU_Main).180318-0835)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/8f07285b69314e478c481af6c60aa28e2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0131.5026.00 ((SQL16_PCU_Main).180318-0835)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/c390e4f8204e4d87a76a44032594be0d2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0131.5026.00 ((SQL16_PCU_Main).180318-0835)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/4f2f9273fda643d4a2dfd31a67e93a0e2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0131.5026.00 ((SQL16_PCU_Main).180318-0835)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/7866454b831848c5b5de93b2b03fb8491/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0131.5026.00 ((SQL16_PCU_Main).180318-0835)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/445daee2af1a43f295208380348074031/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0131.5026.00 ((SQL16_PCU_Main).180318-0835)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/6c004a1c95204734b6cef4f8511617421/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0131.5026.00 ((SQL16_PCU_Main).180318-0835)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/a6047d2982024452905f1fff97fa11421/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0131.5026.00 ((SQL16_PCU_Main).180318-0835)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/ee2324e08c3e4f42acf1572a9cb62d9e2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0131.5026.00 ((SQL16_PCU_Main).180318-0835)
```

# SQL Server 2016 SP1 CU15 - 13.0.4574.0 - x64 (KB4495257)
``` powershell
# SQL Server 2016 SP1 CU15 - 13.0.4574.0 - x64 (KB4495257)
$outputFolder = 'c:\sqlsyms\13.0.4574.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/da14e7ceb24d4c2890b2bde9a03778e52/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0130.4574.00 ((SQL16_SP1_QFE-CU).190427-1658)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/d0dc0e05673549c39349963e9c6115eb2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0130.4574.00 ((SQL16_SP1_QFE-CU).190427-1658)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/003624ea1e0642a58b9040c5811ecc372/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0130.4574.00 ((SQL16_SP1_QFE-CU).190427-1658)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/c408c0723f014e5f90286bc7c822f7142/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0130.4574.00 ((SQL16_SP1_QFE-CU).190427-1658)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/205c4da00f5c4795a18730dd162b0e5c2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0130.4574.00 ((SQL16_SP1_QFE-CU).190427-1658)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/7d0210ad6c38483d82d5a673f656490b2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0130.4574.00 ((SQL16_SP1_QFE-CU).190427-1658)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/e5157d95993b4804b14b3ba28ac25a4e1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0130.4574.00 ((SQL16_SP1_QFE-CU).190427-1658)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/6c807a6e0bfe4a3d8ddbebb9c5df94b21/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0130.4574.00 ((SQL16_SP1_QFE-CU).190427-1658)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/04e55a9040ff4d5a901fb9edb3f714ba1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0130.4574.00 ((SQL16_SP1_QFE-CU).190427-1658)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/0d0627accf6849419318444c37eb8fb61/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0130.4574.00 ((SQL16_SP1_QFE-CU).190427-1658)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/16d8c4351bdc40ac9997dfc601968a8e2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0130.4574.00 ((SQL16_SP1_QFE-CU).190427-1658)
```

# SQL Server 2016 SP1 CU14 - 13.0.4560.0 - x64 (KB4488535)
``` powershell
# SQL Server 2016 SP1 CU14 - 13.0.4560.0 - x64 (KB4488535)
$outputFolder = 'c:\sqlsyms\13.0.4560.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/6a1934433512464b8b8ed905ad930ee62/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0130.4560.00 ((SQL16_SP1_QFE-CU).190312-0204)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/4d031e02b20c495c8581a9a757ae5fad2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0130.4560.00 ((SQL16_SP1_QFE-CU).190312-0204)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/fe7ef391534148c79622e391200336c42/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0130.4560.00 ((SQL16_SP1_QFE-CU).190312-0204)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/55eb1336f7f74ba48038b7c00dd46a0d2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0130.4560.00 ((SQL16_SP1_QFE-CU).190312-0204)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/cf41b9625c804b5c8cbc1a77ebc6330b2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0130.4560.00 ((SQL16_SP1_QFE-CU).190312-0204)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/9179e43956784d1ebdbffe52d6a40c5e2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0130.4560.00 ((SQL16_SP1_QFE-CU).190312-0204)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/c5be83b1f16440bc8f708236c273c2051/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0130.4560.00 ((SQL16_SP1_QFE-CU).190312-0204)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/15a13e10244142eb9d45aff1353423771/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0130.4560.00 ((SQL16_SP1_QFE-CU).190312-0204)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/a7b733870ad24fdfae1196da3201bee41/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0130.4560.00 ((SQL16_SP1_QFE-CU).190312-0204)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/33d27befeb5c4432830896ac70de90501/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0130.4560.00 ((SQL16_SP1_QFE-CU).190312-0204)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/9d0d577195464804b2e7e408f64f87d32/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0130.4560.00 ((SQL16_SP1_QFE-CU).190312-0204)
```

# SQL Server 2016 SP1 CU13 - 13.0.4550.1 - x64 (KB4475775)
``` powershell
# SQL Server 2016 SP1 CU13 - 13.0.4550.1 - x64 (KB4475775)
$outputFolder = 'c:\sqlsyms\13.0.4550.1\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/a9a4c14c343f48969f80364f590898602/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0130.4550.01 ((SQL16_SP1_QFE-CU).190110-1903)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/12140f43a3c84dc99114f1db9d63442b2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0130.4550.01 ((SQL16_SP1_QFE-CU).190110-1903)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/2485f60633124761be7e478491159c092/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0130.4550.01 ((SQL16_SP1_QFE-CU).190110-1903)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/4d617c540beb4fc59140e9f8547c57962/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0130.4550.01 ((SQL16_SP1_QFE-CU).190110-1903)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/c3061b6d621e4d1081838f523ef808d62/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0130.4550.01 ((SQL16_SP1_QFE-CU).190110-1903)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/22da8e8de40543f8aa01fb1b02a60e5c2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0130.4550.01 ((SQL16_SP1_QFE-CU).190110-1903)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/1a8accfb14c14072a4929654c400f8491/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0130.4550.01 ((SQL16_SP1_QFE-CU).190110-1903)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/c765c8f7785e4598b640f828d81fd9851/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0130.4550.01 ((SQL16_SP1_QFE-CU).190110-1903)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/30268bd8d01d40d0be47fb9ce30522021/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0130.4550.01 ((SQL16_SP1_QFE-CU).190110-1903)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/4c1f27348acd463dbe00df9477d840c51/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0130.4550.01 ((SQL16_SP1_QFE-CU).190110-1903)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/5c4f7f0fbb6a42689720fe6353a343e92/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0130.4550.01 ((SQL16_SP1_QFE-CU).190110-1903)
```

# SQL Server 2016 SP1 CU12 - 13.0.4541.0 - x64 (KB4464343)
``` powershell
# SQL Server 2016 SP1 CU12 - 13.0.4541.0 - x64 (KB4464343)
$outputFolder = 'c:\sqlsyms\13.0.4541.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/d3080f42570f4bf0a4a837a8895ca7902/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0130.4541.00 ((SQL16_SP1_QFE-CU).181026-1658)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/4dce2e3f19f74c31b5a6ac2af6a9d8262/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0130.4541.00 ((SQL16_SP1_QFE-CU).181026-1658)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/18954e55372343d5a4d6681895c263ea2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0130.4541.00 ((SQL16_SP1_QFE-CU).181026-1658)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/9aac7f2866b540b4ab2c1b9ac9e577a72/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0130.4541.00 ((SQL16_SP1_QFE-CU).181026-1658)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/8093743906d24ebbbaf34109d536867b2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0130.4541.00 ((SQL16_SP1_QFE-CU).181026-1658)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/c7333000708848b794283812c1bb4c1f2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0130.4541.00 ((SQL16_SP1_QFE-CU).181026-1658)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/c1238bf343b747f7b8b337f438942c711/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0130.4541.00 ((SQL16_SP1_QFE-CU).181026-1658)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/7f07d29b92d74e038aec8d7d0dd4b36b1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0130.4541.00 ((SQL16_SP1_QFE-CU).181026-1658)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/98c1ec14b1674f1c86ddd4ceb6ccf6fa1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0130.4541.00 ((SQL16_SP1_QFE-CU).181026-1658)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/06a0750893f44304ad32a17a180927f21/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0130.4541.00 ((SQL16_SP1_QFE-CU).181026-1658)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/7162e87a93b346bba5752ed81f9b57202/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0130.4541.00 ((SQL16_SP1_QFE-CU).181026-1658)
```

# SQL Server 2016 SP1 CU11 - 13.0.4528.0 - x64 (KB4459676)
``` powershell
# SQL Server 2016 SP1 CU11 - 13.0.4528.0 - x64 (KB4459676)
$outputFolder = 'c:\sqlsyms\13.0.4528.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/49f484665e944b7b955f47ac457f6f132/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0130.4528.00 ((SQL16_SP1_QFE-CU).180830-2114)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/db189aef1bba4446a2162ff54266b4ce2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0130.4528.00 ((SQL16_SP1_QFE-CU).180830-2114)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/e1bc1af368224105abe4120dbdb73f832/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0130.4528.00 ((SQL16_SP1_QFE-CU).180830-2114)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/33537b3dbc714ad39948f5a027e02e042/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0130.4528.00 ((SQL16_SP1_QFE-CU).180830-2114)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/d4a5c566de5f4e8cbc0724155e6897252/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0130.4528.00 ((SQL16_SP1_QFE-CU).180830-2114)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/6abb1e2ee2324531a59ef3e3532c7a012/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0130.4528.00 ((SQL16_SP1_QFE-CU).180830-2114)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/af8f4fe9f42b47208ffae42cd1cd846d1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0130.4528.00 ((SQL16_SP1_QFE-CU).180830-2114)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/2da374ada649478aa35648edc58188811/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0130.4528.00 ((SQL16_SP1_QFE-CU).180830-2114)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/f073ed383da5472da181faca36520b1e1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0130.4528.00 ((SQL16_SP1_QFE-CU).180830-2114)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/9f53ea00e8104275af6dbf64e1b6a3591/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0130.4528.00 ((SQL16_SP1_QFE-CU).180830-2114)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/2dc4533ebfec420a88bcb188833b50db2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0130.4528.00 ((SQL16_SP1_QFE-CU).180830-2114)
```

# SQL Server 2016 SP1 CU10 + Security Update - 13.0.4522.0 - x64 (KB4293808)
``` powershell
# SQL Server 2016 SP1 CU10 + Security Update - 13.0.4522.0 - x64 (KB4293808)
$outputFolder = 'c:\sqlsyms\13.0.4522.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/2c80618f9f82487ba2385a9cc3ddf88f2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0130.4522.00 ((SQL16_SP1_QFE-CU).180717-2208)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/0fae990bea634884b2bb03ef48ae0f9c2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0130.4522.00 ((SQL16_SP1_QFE-CU).180717-2208)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/744610eb2fed4fe28992cb1051af89f52/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0130.4522.00 ((SQL16_SP1_QFE-CU).180717-2208)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/231b6d23fea44f0e9978b2903e55f98c2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0130.4522.00 ((SQL16_SP1_QFE-CU).180717-2208)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/9ebc1faac19940a2913209dedfe0a8fb2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0130.4522.00 ((SQL16_SP1_QFE-CU).180717-2208)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/920fc8ef2b144b92b9e500f34c7a71292/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0130.4522.00 ((SQL16_SP1_QFE-CU).180717-2208)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/0f4ea0db1e374ab5aa9c527249a56a5b1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0130.4522.00 ((SQL16_SP1_QFE-CU).180717-2208)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/48c8d8e079b5402da40b9db2b50d98381/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0130.4522.00 ((SQL16_SP1_QFE-CU).180717-2208)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/332f649e9f7a4444b0e7f810cfe46daf1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0130.4522.00 ((SQL16_SP1_QFE-CU).180717-2208)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/306b24badfce478b88e7cc9bf4f158ba1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0130.4522.00 ((SQL16_SP1_QFE-CU).180717-2208)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/1900f69e405d454783d12534bc3e62232/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0130.4522.00 ((SQL16_SP1_QFE-CU).180717-2208)
```

# SQL Server 2016 SP1 CU10 - 13.0.4514.0 - x64 (KB4341569)
``` powershell
# SQL Server 2016 SP1 CU10 - 13.0.4514.0 - x64 (KB4341569)
$outputFolder = 'c:\sqlsyms\13.0.4514.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/eba3127f55a6490b925ac53a6af5ef262/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0130.4514.00 ((SQL16_SP1_QFE-CU).180622-1535)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/c36664a87ee44edc82989935ce8fa1ad2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0130.4514.00 ((SQL16_SP1_QFE-CU).180622-1535)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/7b867a51f536452a95636acf588d0cef2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0130.4514.00 ((SQL16_SP1_QFE-CU).180622-1535)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/4f050afd2b5b4cacb6ff7c302f5ce5c72/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0130.4514.00 ((SQL16_SP1_QFE-CU).180622-1535)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/e4ce24f005df4299b285c9da1050c01e2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0130.4514.00 ((SQL16_SP1_QFE-CU).180622-1535)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/ad7c0ab9750744a9985d59afa1474dda2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0130.4514.00 ((SQL16_SP1_QFE-CU).180622-1535)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/6a522b1480b54288a132ac67e8da49e51/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0130.4514.00 ((SQL16_SP1_QFE-CU).180622-1535)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/e63e19d43fb24d81b84c1208c96984ac1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0130.4514.00 ((SQL16_SP1_QFE-CU).180622-1535)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/7f5068607ec14c409d9d04c56ac9e1731/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0130.4514.00 ((SQL16_SP1_QFE-CU).180622-1535)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/0e87037690c64c06ac41a9db319a970f1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0130.4514.00 ((SQL16_SP1_QFE-CU).180622-1535)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/0840ef6023a7422f90acbfc2bfe60dfe2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0130.4514.00 ((SQL16_SP1_QFE-CU).180622-1535)
```

# SQL Server 2016 SP1 CU9 - 13.0.4502.0 - x64 (KB4100997)
``` powershell
# SQL Server 2016 SP1 CU9 - 13.0.4502.0 - x64 (KB4100997)
$outputFolder = 'c:\sqlsyms\13.0.4502.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/ee6e6cc4172f49ca87933514afe4929b2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0130.4502.00 ((SQL16_SP1_QFE-CU).180514-1334)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/2676f65ef4f14e1c9a6b62a9d1522fe82/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0130.4502.00 ((SQL16_SP1_QFE-CU).180514-1334)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/7dfceb96c58c453ba4e3d8a1ca78615d2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0130.4502.00 ((SQL16_SP1_QFE-CU).180514-1334)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/7f8a037059454eba99b698a776696daa2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0130.4502.00 ((SQL16_SP1_QFE-CU).180514-1334)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/334ffbfb732c4fc79e4e3513e5027a3d2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0130.4502.00 ((SQL16_SP1_QFE-CU).180514-1334)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/b561f4e3c38e4562b7972ea695cffc4c2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0130.4502.00 ((SQL16_SP1_QFE-CU).180514-1334)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/cf91d9718d41483bb4606f54896f9c3e1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0130.4502.00 ((SQL16_SP1_QFE-CU).180514-1334)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/fca548701ad64b9eb0f58be2ab0dccf11/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0130.4502.00 ((SQL16_SP1_QFE-CU).180514-1334)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/5cc13763d5064b6d97d9f1cc1ecaa20c1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0130.4502.00 ((SQL16_SP1_QFE-CU).180514-1334)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/beda030e12954da6a9eba8922683f73e1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0130.4502.00 ((SQL16_SP1_QFE-CU).180514-1334)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/2a17dec666134d14a64d767ef4aebe202/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0130.4502.00 ((SQL16_SP1_QFE-CU).180514-1334)
```

# SQL Server 2016 SP1 CU8 - 13.0.4474.0 - x64 (KB4077064)
``` powershell
# SQL Server 2016 SP1 CU8 - 13.0.4474.0 - x64 (KB4077064)
$outputFolder = 'c:\sqlsyms\13.0.4474.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/bad09995ed274e949232badd3f3d7aa82/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0130.4474.00 ((SQL16_SP1_QFE-CU).180224-1012)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/ddf784b88c44464fbbef4a3c309436392/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0130.4474.00 ((SQL16_SP1_QFE-CU).180224-1012)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/04aab3b7206c46a9b777313cc33d57402/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0130.4474.00 ((SQL16_SP1_QFE-CU).180224-1012)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/ef2f100c08554e4398658ca191205f162/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0130.4474.00 ((SQL16_SP1_QFE-CU).180224-1012)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/4b20376587754240a8157ec3f5c827102/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0130.4474.00 ((SQL16_SP1_QFE-CU).180224-1012)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/61506f0f9d5240c18416dae8f808755e2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0130.4474.00 ((SQL16_SP1_QFE-CU).180224-1012)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/7e93929a70af49a98c0d3a9d10d24d841/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0130.4474.00 ((SQL16_SP1_QFE-CU).180224-1012)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/e66b4e3643c94f26862bcdbcae4df7901/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0130.4474.00 ((SQL16_SP1_QFE-CU).180224-1012)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/48c28f25191a4ee0b7a4810e6c0f29f71/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0130.4474.00 ((SQL16_SP1_QFE-CU).180224-1012)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/ea990dbdb39247fbbd083d2de5f867d71/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0130.4474.00 ((SQL16_SP1_QFE-CU).180224-1012)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/0d79a37d6dda4c28aa9dea14724f12f52/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0130.4474.00 ((SQL16_SP1_QFE-CU).180224-1012)
```

# SQL Server 2016 SP1 CU7 - 13.0.4466.4 - x64 (KB4057119)
``` powershell
# SQL Server 2016 SP1 CU7 - 13.0.4466.4 - x64 (KB4057119)
$outputFolder = 'c:\sqlsyms\13.0.4466.4\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/4fb77886edcf4e9d89fac79ebf7d1fea2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0130.4466.04 ((SQL16_SP1_QFE-CU).171222-1041)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/04bc3e5a0e4f471e9b96d67c5e3f36df2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0130.4466.04 ((SQL16_SP1_QFE-CU).171222-1041)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/75cbabc14dbe4b78b399b0e5f88a97092/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0130.4466.04 ((SQL16_SP1_QFE-CU).171222-1041)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/c68cc2cb6c074e39881a844eec9778f82/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0130.4466.04 ((SQL16_SP1_QFE-CU).171222-1041)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/bf98529869b64e518f5afd9c0c5079c82/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0130.4466.04 ((SQL16_SP1_QFE-CU).171222-1041)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/9215ec6a12bf4d20a9e6798034e2036e2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0130.4466.04 ((SQL16_SP1_QFE-CU).171222-1041)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/33d2f4d2ce9c4e3ebb58b76dd1c289a81/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0130.4466.04 ((SQL16_SP1_QFE-CU).171222-1041)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/7aa9d469ad5e42b8b414338158cf15b41/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0130.4466.04 ((SQL16_SP1_QFE-CU).171222-1041)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/f86b9c579a474a3fac7812d34b52bf221/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0130.4466.04 ((SQL16_SP1_QFE-CU).171222-1041)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/893d1525c26945cf827a45f9b043e5eb1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0130.4466.04 ((SQL16_SP1_QFE-CU).171222-1041)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/c583e52b9d604d4da427ceb43ab482252/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0130.4466.04 ((SQL16_SP1_QFE-CU).171222-1041)
```

# SQL Server 2016 SP1 CU6 - 13.0.4457.0 - x64 (KB4037354)
``` powershell
# SQL Server 2016 SP1 CU6 - 13.0.4457.0 - x64 (KB4037354)
$outputFolder = 'c:\sqlsyms\13.0.4457.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/db2fe36302c64a1a86813d0549b22b012/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0130.4457.00 ((SQL16_SP1_QFE-CU).171108-1347)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/9cdf1937cd024f1e82060b74e9e60e512/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0130.4457.00 ((SQL16_SP1_QFE-CU).171108-1347)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/046a40a60ddc486086561319f5387e142/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0130.4457.00 ((SQL16_SP1_QFE-CU).171108-1347)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/2547dc27f1324d3fbb7daad4793c6cf12/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0130.4457.00 ((SQL16_SP1_QFE-CU).171108-1347)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/1a145eacaf05435abe69b319f8277b9c2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0130.4457.00 ((SQL16_SP1_QFE-CU).171108-1347)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/90a48bebb7f84ca9884ca115fa7ed9c32/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0130.4457.00 ((SQL16_SP1_QFE-CU).171108-1347)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/3daff9d0abe941b08003e61197ce4ede1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0130.4457.00 ((SQL16_SP1_QFE-CU).171108-1347)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/9bb39bd5bd404d9b8693d476a4976c381/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0130.4457.00 ((SQL16_SP1_QFE-CU).171108-1347)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/b76a518cfcad45f5bc36600f200d8df51/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0130.4457.00 ((SQL16_SP1_QFE-CU).171108-1347)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/5028c6a5a3bf40fb893b7034820c6ea81/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0130.4457.00 ((SQL16_SP1_QFE-CU).171108-1347)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/853cc6b85b6049bb8e28d35007644cf22/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0130.4457.00 ((SQL16_SP1_QFE-CU).171108-1347)
```

# SQL Server 2016 SP1 CU5 - 13.0.4451.0 - x64 (KB4040714)
``` powershell
# SQL Server 2016 SP1 CU5 - 13.0.4451.0 - x64 (KB4040714)
$outputFolder = 'c:\sqlsyms\13.0.4451.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/0adf0efaa0674d52b42ede2653b2bc792/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0130.4451.00 ((SQL16_SP1_QFE-CU).170905-1437)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/9c9bc2d7227d4a44826cc162dc9364782/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0130.4451.00 ((SQL16_SP1_QFE-CU).170905-1437)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/00a5c9de969c45918756df4cfd8c6f682/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0130.4451.00 ((SQL16_SP1_QFE-CU).170905-1437)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/01e048da3e0c4ca4bdf473066c7cf6c62/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0130.4451.00 ((SQL16_SP1_QFE-CU).170905-1437)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/bc8c89cf69be4fd3a3364dcb0a72dca52/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0130.4451.00 ((SQL16_SP1_QFE-CU).170905-1437)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/360009d4947e4ac08be932e3f16b2ccb2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0130.4451.00 ((SQL16_SP1_QFE-CU).170905-1437)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/8a5bedd54909459eb41b76521723683b1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0130.4451.00 ((SQL16_SP1_QFE-CU).170905-1437)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/57c8fa0d82c643d290ab9530b788e4d42/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0130.4451.00 ((SQL16_SP1_QFE-CU).170905-1437)
```

# SQL Server 2016 SP1 CU4 - 13.0.4446.0 - x64 (KB4024305)
``` powershell
# SQL Server 2016 SP1 CU4 - 13.0.4446.0 - x64 (KB4024305)
$outputFolder = 'c:\sqlsyms\13.0.4446.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/c880090278d9483faab63d7472a628ba2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0130.4446.00 ((SQL16_SP1_QFE-CU).170716-1734)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/ea6d107876b848c990276c5164f78e222/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0130.4446.00 ((SQL16_SP1_QFE-CU).170716-1734)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/d41f27d7505149d2a9d14483961593b92/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0130.4446.00 ((SQL16_SP1_QFE-CU).170716-1734)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/92e8bee376394dcb8a2a52800b39f5092/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0130.4446.00 ((SQL16_SP1_QFE-CU).170716-1734)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/149150e4cdbf4baf80620e32ef97fc012/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0130.4446.00 ((SQL16_SP1_QFE-CU).170716-1734)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/6cd22e703a544fac840bae7b3ab83c132/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0130.4446.00 ((SQL16_SP1_QFE-CU).170716-1734)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/76b434a7b537413da49b849be7bbd2b91/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0130.4446.00 ((SQL16_SP1_QFE-CU).170716-1734)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/eaaa9a9973f6411495bf3d00bb06f8f11/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0130.4446.00 ((SQL16_SP1_QFE-CU).170716-1734)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/b8813f5978cf4a3dba90881436bb77f71/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0130.4446.00 ((SQL16_SP1_QFE-CU).170716-1734)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/0a7f20ebf1024eaf8a1ffd2b239bfa4e1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0130.4446.00 ((SQL16_SP1_QFE-CU).170716-1734)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/eab3cf5200994d3eb10eaa1a884a3ef12/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0130.4446.00 ((SQL16_SP1_QFE-CU).170716-1734)
```

# SQL Server 2016 SP1 CU3 - 13.0.4435.0 - x64 (KB4019916)
``` powershell
# SQL Server 2016 SP1 CU3 - 13.0.4435.0 - x64 (KB4019916)
$outputFolder = 'c:\sqlsyms\13.0.4435.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/8fe09624812049058da82aa8f1dd66f22/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0130.4435.00 ((SQL16_SP1_QFE-CU).170427-1707)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/558322e65c7e4b328939747b49d560902/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0130.4435.00 ((SQL16_SP1_QFE-CU).170427-1707)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/470aff4a91ac4921b55a2172551f7bf12/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0130.4435.00 ((SQL16_SP1_QFE-CU).170427-1707)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/3149ea1cf3e144a595628fffafeb88fd2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0130.4435.00 ((SQL16_SP1_QFE-CU).170427-1707)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/0d9fe1a60fe342c1a1ce09de7ccdbd2a2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0130.4435.00 ((SQL16_SP1_QFE-CU).170427-1707)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/225b08e74e474943bc4e1122946cbf532/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0130.4435.00 ((SQL16_SP1_QFE-CU).170427-1707)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/de75b23f05c440f9a563565af615e1391/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0130.4435.00 ((SQL16_SP1_QFE-CU).170427-1707)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/08b0902123f545b6bbbcd419f6f8cb5b1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0130.4435.00 ((SQL16_SP1_QFE-CU).170427-1707)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/cc9c2fb0544943e48eb8e300255313191/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0130.4435.00 ((SQL16_SP1_QFE-CU).170427-1707)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/320d5955652048e78f2fc910d1eef2d51/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0130.4435.00 ((SQL16_SP1_QFE-CU).170427-1707)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/ded87b2c33dd49fd93d4daed66d9092f2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0130.4435.00 ((SQL16_SP1_QFE-CU).170427-1707)
```

# SQL Server 2016 SP1 CU2 - 13.0.4422.0 - x64 (KB4013106)
``` powershell
# SQL Server 2016 SP1 CU2 - 13.0.4422.0 - x64 (KB4013106)
$outputFolder = 'c:\sqlsyms\13.0.4422.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/cb638c12b4674d87ac7357f16e8ad0c32/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0130.4422.00 ((SQL16_SP1_QFE-CU).170306-1319)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/6cf52c50743545e3b6a49ff43d1379152/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0130.4422.00 ((SQL16_SP1_QFE-CU).170306-1319)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/bc808d257868486f8231cded7542228e2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0130.4422.00 ((SQL16_SP1_QFE-CU).170306-1319)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/be2f8736bbab4e6d9dddd5e2ee23c5ce2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0130.4422.00 ((SQL16_SP1_QFE-CU).170306-1319)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/7a42c58c49904f169a5aff489be7369b2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0130.4422.00 ((SQL16_SP1_QFE-CU).170306-1319)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/997d7a6a523843b08a2ae10c5d75534d2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0130.4422.00 ((SQL16_SP1_QFE-CU).170306-1319)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/c2b0f4c16c5a4e509441c8338aa5ec1c1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0130.4422.00 ((SQL16_SP1_QFE-CU).170306-1319)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/28f240977ff44072aa8e8b2a7d60ba641/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0130.4422.00 ((SQL16_SP1_QFE-CU).170306-1319)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/270d0aa365954e83ae7d1df1408d6d9a1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0130.4422.00 ((SQL16_SP1_QFE-CU).170306-1319)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/3b16a7b538974a81bf76596ef78cb3381/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0130.4422.00 ((SQL16_SP1_QFE-CU).170306-1319)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/65b28e59df5346238c2bb00123ee4d2b2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0130.4422.00 ((SQL16_SP1_QFE-CU).170306-1319)
```

# SQL Server 2016 SP1 CU1 - 13.0.4411.0 - x64 (KB3208177)
``` powershell
# SQL Server 2016 SP1 CU1 - 13.0.4411.0 - x64 (KB3208177)
$outputFolder = 'c:\sqlsyms\13.0.4411.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/268a89d9ed10413ba41fe54bf2d75b1e2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0130.4411.00 ((SQL16_SP1_QFE-CU).170106-1315)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/c9ead68f28c24061a124762b8351b6f82/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0130.4411.00 ((SQL16_SP1_QFE-CU).170106-1315)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/74b5f464baac4a9484c931946ae5b68f2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0130.4411.00 ((SQL16_SP1_QFE-CU).170106-1315)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/3c313be76f2444939a67caf043f53d7f2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0130.4411.00 ((SQL16_SP1_QFE-CU).170106-1315)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/84c8f12c82c44a1392d6f65ef1a318b52/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0130.4411.00 ((SQL16_SP1_QFE-CU).170106-1315)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/549f12f6d342442cb72a078cabc0b0362/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0130.4411.00 ((SQL16_SP1_QFE-CU).170106-1315)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/e2fa7e5dba454b9b88a2a1d96b467fd01/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0130.4411.00 ((SQL16_SP1_QFE-CU).170106-1315)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/751d83a8390f4faba2ebd6aafac7f1d51/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0130.4411.00 ((SQL16_SP1_QFE-CU).170106-1315)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/1b95571d967d4731b5e72ed855f469111/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0130.4411.00 ((SQL16_SP1_QFE-CU).170106-1315)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/2821e0a9f1074075bdda62de3e7008c61/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0130.4411.00 ((SQL16_SP1_QFE-CU).170106-1315)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/826a7546f2db4f3089d413578a2cdf882/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0130.4411.00 ((SQL16_SP1_QFE-CU).170106-1315)
```

# SQL Server 2016 SP1 SP1 - 13.0.4001.0 - x64 (KB3182545)
``` powershell
# SQL Server 2016 SP1 SP1 - 13.0.4001.0 - x64 (KB3182545)
$outputFolder = 'c:\sqlsyms\13.0.4001.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/1d3fa75eb35540e287b2e012d69785df2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0130.4001.00 ((SQL16_PCU_Main).161028-1734)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/d38058f49e7c4d62970677e4315f1f1c2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0130.4001.00 ((SQL16_PCU_Main).161028-1734)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/cb9e5b8e0483423cb122da4ad87534d52/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0130.4001.00 ((SQL16_PCU_Main).161028-1734)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/13cb00e6ed4d46789fadceb55abddfe92/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0130.4001.00 ((SQL16_PCU_Main).161028-1734)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/c6d08b108b154f8b8431f090dbaab1c92/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0130.4001.00 ((SQL16_PCU_Main).161028-1734)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/c1220065fb9e4e61919175ac9792a2bc2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0130.4001.00 ((SQL16_PCU_Main).161028-1734)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/f0fd3061c4be4486b3308828ea99276e1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0130.4001.00 ((SQL16_PCU_Main).161028-1734)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/f53682311a4e427ba43cc7908850cf9d1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0130.4001.00 ((SQL16_PCU_Main).161028-1734)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/f42433ff7c4b4c52b53875da10d4684e1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0130.4001.00 ((SQL16_PCU_Main).161028-1734)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/961e76a609b04a7c935cd8ad827f23381/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0130.4001.00 ((SQL16_PCU_Main).161028-1734)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/e6e24f9a081b42e3b9e22e1f6414b9b22/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0130.4001.00 ((SQL16_PCU_Main).161028-1734)
```

# SQL Server 2016 RTM CU9 - 13.0.2216.0 - x64 (KB4037357)
``` powershell
# SQL Server 2016 RTM CU9 - 13.0.2216.0 - x64 (KB4037357)
$outputFolder = 'c:\sqlsyms\13.0.2216.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/2c007938542145638d786ebdc67c1c9b2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0130.2216.00 ((SQL16_RTM_QFE-CU).171109-1343)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/b6c9ba6727b14530bf871a406d0724802/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0130.2216.00 ((SQL16_RTM_QFE-CU).171109-1343)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/477e9070b1e642a9b166ef3b07e1687b2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0130.2216.00 ((SQL16_RTM_QFE-CU).171109-1343)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/8946accd7bb14ec18499ee4c4e5e53812/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0130.2216.00 ((SQL16_RTM_QFE-CU).171109-1343)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/57cbeb8f33464fb69f691482ce8de8d42/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0130.2216.00 ((SQL16_RTM_QFE-CU).171109-1343)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/abd45d29f555480fadf1990a92e34b252/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0130.2216.00 ((SQL16_RTM_QFE-CU).171109-1343)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/ff1fa69bac4f4a6ea28eea880c69588e1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0130.2216.00 ((SQL16_RTM_QFE-CU).171109-1343)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/f56e5624d87b4a708ca9f6667aba68a71/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0130.2216.00 ((SQL16_RTM_QFE-CU).171109-1343)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/1ca1e6c22cb548b296414dc80c64f4ef1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0130.2216.00 ((SQL16_RTM_QFE-CU).171109-1343)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/0842b22e9ff84f00bfb066e5a557d3051/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0130.2216.00 ((SQL16_RTM_QFE-CU).171109-1343)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/e7ba978114ac4b5b9c032b8f1e1be2222/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0130.2216.00 ((SQL16_RTM_QFE-CU).171109-1343)
```

# SQL Server 2016 RTM CU8 - 13.0.2213.0 - x64 (KB4040713)
``` powershell
# SQL Server 2016 RTM CU8 - 13.0.2213.0 - x64 (KB4040713)
$outputFolder = 'c:\sqlsyms\13.0.2213.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/7a0af19f84774e599332cd0db1f1278a2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0130.2213.00 ((SQL16_RTM_QFE-CU).170905-1430)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/f70df0f1cf3d45b5988d87fa813fe74b2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0130.2213.00 ((SQL16_RTM_QFE-CU).170905-1430)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/f3809f64b9a8419ea5fa8f35a32197452/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0130.2213.00 ((SQL16_RTM_QFE-CU).170905-1430)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/7faa03153e474bcc9d8205a253de66df2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0130.2213.00 ((SQL16_RTM_QFE-CU).170905-1430)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/96aa656777b0457e9b21ebda6ec38f1e2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0130.2213.00 ((SQL16_RTM_QFE-CU).170905-1430)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/64c55c4c8b894ec191c9a512d64d05932/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0130.2213.00 ((SQL16_RTM_QFE-CU).170905-1430)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/2610adf0ecd04828af0815caf79e19351/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0130.2213.00 ((SQL16_RTM_QFE-CU).170905-1430)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/901b0c2906cb48e99fb09e1e8cbe9e751/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0130.2213.00 ((SQL16_RTM_QFE-CU).170905-1430)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/e47bab9e66704c33be9edb1c3468aee41/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0130.2213.00 ((SQL16_RTM_QFE-CU).170905-1430)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/07f0e5afd4634724b92cd6d5ac50fbcc1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0130.2213.00 ((SQL16_RTM_QFE-CU).170905-1430)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/e8186d9274b8415c90bea6dbee62765d2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0130.2213.00 ((SQL16_RTM_QFE-CU).170905-1430)
```

# SQL Server 2016 RTM CU6 - 13.0.2204.0 - x64 (KB4019914)
``` powershell
# SQL Server 2016 RTM CU6 - 13.0.2204.0 - x64 (KB4019914)
$outputFolder = 'c:\sqlsyms\13.0.2204.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/cfb9f1f67ed94f2ca6ce13a87b281a912/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0130.2204.00 ((SQL16_RTM_QFE-CU).170420-2326)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/e319d277318a43f7bdbfaf7c09e8ea0d2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0130.2204.00 ((SQL16_RTM_QFE-CU).170420-2326)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/f85c7c7fbcfe4fe2bfde5a9d3faaede92/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0130.2204.00 ((SQL16_RTM_QFE-CU).170420-2326)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/0bbbf57d7cc6413fbdade7dd8e806f682/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0130.2204.00 ((SQL16_RTM_QFE-CU).170420-2326)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/10777de046a746f1b118cfcc17d06c2b2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0130.2204.00 ((SQL16_RTM_QFE-CU).170420-2326)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/0152302a8c624ace9201fe5842e87e012/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0130.2204.00 ((SQL16_RTM_QFE-CU).170420-2326)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/3b988c8fe7f04e3f974a275a0eeeeb0b1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0130.2204.00 ((SQL16_RTM_QFE-CU).170420-2326)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/b7d84e7993fb4451b2cd97adae2171001/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0130.2204.00 ((SQL16_RTM_QFE-CU).170420-2326)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/c6b1fbc9d12d414b906f7be297838d8a1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0130.2204.00 ((SQL16_RTM_QFE-CU).170420-2326)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/788729ffd2354809b96f60469725732e1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0130.2204.00 ((SQL16_RTM_QFE-CU).170420-2326)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/0e8610c36c354d36986910b6ef9f99f12/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0130.2204.00 ((SQL16_RTM_QFE-CU).170420-2326)
```

# SQL Server 2016 RTM CU4 - 13.0.2193.0 - x64 (KB3205052)
``` powershell
# SQL Server 2016 RTM CU4 - 13.0.2193.0 - x64 (KB3205052)
$outputFolder = 'c:\sqlsyms\13.0.2193.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/29fff1570c614d079dd399bb465245ba2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0130.2193.00 ((SQL16_RTM_QFE-CU).170106-1104)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/51387eb8f90f4726aa9df7dd8a937c432/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0130.2193.00 ((SQL16_RTM_QFE-CU).170106-1104)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/bf13531c7d694d729c441c09b114ba5a2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0130.2193.00 ((SQL16_RTM_QFE-CU).170106-1104)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/37c497fe00574995b2275c82bd5448222/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0130.2193.00 ((SQL16_RTM_QFE-CU).170106-1104)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/db92e29b6d7a40a8b447c044382186f52/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0130.2193.00 ((SQL16_RTM_QFE-CU).170106-1104)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/c564d1d1af464ec4b23625bc349021e82/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0130.2193.00 ((SQL16_RTM_QFE-CU).170106-1104)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/d83d9a08a6304475973f8c1527e9a18b1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0130.2193.00 ((SQL16_RTM_QFE-CU).170106-1104)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/c9179764a88745b6b27d0340adfe00da1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0130.2193.00 ((SQL16_RTM_QFE-CU).170106-1104)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/0a6f9df489884c5aae89b04a707f77991/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0130.2193.00 ((SQL16_RTM_QFE-CU).170106-1104)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/db44013b2c72466ea3f22c14bdedc55f1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0130.2193.00 ((SQL16_RTM_QFE-CU).170106-1104)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/0e65448c6e524b05b5e23432481867792/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0130.2193.00 ((SQL16_RTM_QFE-CU).170106-1104)
```

# SQL Server 2016 RTM CU3 - 13.0.2186.6 - x64 (KB3205413)
``` powershell
# SQL Server 2016 RTM CU3 - 13.0.2186.6 - x64 (KB3205413)
$outputFolder = 'c:\sqlsyms\13.0.2186.6\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/2ff2ffcd1aec4430a320031a5b39932a2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0130.2186.06 ((SQL16_RTM_QFE-CU).161031-1738)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/7a54654444b3498ea417d266f13be4852/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0130.2186.06 ((SQL16_RTM_QFE-CU).161031-1738)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/9554edfa9c98497691f273323bcb95cc2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0130.2186.06 ((SQL16_RTM_QFE-CU).161031-1738)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/c8625b8816e14ab5b1ff2831407f971f2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0130.2186.06 ((SQL16_RTM_QFE-CU).161031-1738)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/3293fd4acafd48539b54f36145afa5a62/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0130.2186.06 ((SQL16_RTM_QFE-CU).161031-1738)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/2581ec9c9a2d477fb3e3b1d87b7a7db42/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0130.2186.06 ((SQL16_RTM_QFE-CU).161031-1738)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/dcb6d2efe1284ce697e4291b198fccce1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0130.2186.06 ((SQL16_RTM_QFE-CU).161031-1738)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/38d5d0c4e3e94a128f0e8e61535485481/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0130.2186.06 ((SQL16_RTM_QFE-CU).161031-1738)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/f198f8dfc2304e189df71ef4b47851fb1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0130.2186.06 ((SQL16_RTM_QFE-CU).161031-1738)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/9535038ce47847eca6d1a33db6a7497b1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0130.2186.06 ((SQL16_RTM_QFE-CU).161031-1738)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/f4a805d2b05c4cf0ac5538e5c9d3ef122/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0130.2186.06 ((SQL16_RTM_QFE-CU).161031-1738)
```

# SQL Server 2016 RTM CU2 - 13.0.2164.0 - x64 (KB3182270)
``` powershell
# SQL Server 2016 RTM CU2 - 13.0.2164.0 - x64 (KB3182270)
$outputFolder = 'c:\sqlsyms\13.0.2164.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/940eac419c934059b710be37641e39112/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0130.2164.00 ((SQL16_RTM_QFE-CU).160909-1949)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/61e79d07815549199699608cf3ebd8a22/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0130.2164.00 ((SQL16_RTM_QFE-CU).160909-1949)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/0b0fe3a447d74fec8396a46cbcf4ade42/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0130.2164.00 ((SQL16_RTM_QFE-CU).160909-1949)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/7aee76c9772241c4abab13ba1d825bc02/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0130.2164.00 ((SQL16_RTM_QFE-CU).160909-1949)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/fc8265399db44d05bb66cf0c53d3a9132/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0130.2164.00 ((SQL16_RTM_QFE-CU).160909-1949)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/43431b47b3c242f2a76e2d5ca301d0372/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0130.2164.00 ((SQL16_RTM_QFE-CU).160909-1949)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/956fcfce5bc348a9abe7db682dc7a85e1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0130.2164.00 ((SQL16_RTM_QFE-CU).160909-1949)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/6dc828b4ac564e199c26106da4394a591/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0130.2164.00 ((SQL16_RTM_QFE-CU).160909-1949)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/6e06587843f44870abfb873c263bdd581/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0130.2164.00 ((SQL16_RTM_QFE-CU).160909-1949)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/3717f27071594c5e976040c9e18032df1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0130.2164.00 ((SQL16_RTM_QFE-CU).160909-1949)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/8c33d4ecd80a4de683073c4e36fe87242/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0130.2164.00 ((SQL16_RTM_QFE-CU).160909-1949)
```

# SQL Server 2016 RTM CU1 - 13.0.2149.0 - x64 (KB3164674)
``` powershell
# SQL Server 2016 RTM CU1 - 13.0.2149.0 - x64 (KB3164674)
$outputFolder = 'c:\sqlsyms\13.0.2149.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/175d1d9f3e3f4aa5b25e8defb354e9282/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2015.0130.2149.00 ((SQL16_RTM_QFE-CU).160711-2134)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/c887519f85984f93a45d804fbd9efa7c2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2015.0130.2149.00 ((SQL16_RTM_QFE-CU).160711-2134)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/52a90f506b934a63bee7f9acb3ecbd592/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2015.0130.2149.00 ((SQL16_RTM_QFE-CU).160711-2134)
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/9285360a585b4659a9178b94d54195e52/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2015.0130.2149.00 ((SQL16_RTM_QFE-CU).160711-2134)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/431d7cd65d56492084619a4f2be7de342/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2015.0130.2149.00 ((SQL16_RTM_QFE-CU).160711-2134)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/a4c480d343034344a88ac1b39f672b152/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2015.0130.2149.00 ((SQL16_RTM_QFE-CU).160711-2134)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/501ffaaba03a405c942a3636f744d86f1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2015.0130.2149.00 ((SQL16_RTM_QFE-CU).160711-2134)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/df614cefd0a64503b3f9a8b8e28d62ab1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2015.0130.2149.00 ((SQL16_RTM_QFE-CU).160711-2134)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/7f75cde05cd84c74b27b97fde6200cf21/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2015.0130.2149.00 ((SQL16_RTM_QFE-CU).160711-2134)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/986ce3d6b4334bacb5c924134d2883971/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2015.0130.2149.00 ((SQL16_RTM_QFE-CU).160711-2134)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/d67b0283c81c4a93b4d4ede2af0cec522/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2015.0130.2149.00 ((SQL16_RTM_QFE-CU).160711-2134)
```

