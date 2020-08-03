# SQL Server 2019 RTM CU5 - 15.0.4043.16 - x64 (KB4552255)
``` powershell
# SQL Server 2019 RTM CU5 - 15.0.4043.16 - x64 (KB4552255)
$outputFolder = 'c:\sqlsyms\15.0.4043.16\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/26dc3c5c64d84fbe9858e9751952614b2/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2019.0150.4043.16 ((SQLServer2019-CU5).200611-0058)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/b7ecc728f4d145db8216e57082798f7f2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2019.0150.4043.16 ((SQLServer2019-CU5).200611-0058)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/e0e08efa82cf49839524d699fcbfcdd32/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2019.0150.4043.16 ((SQLServer2019-CU5).200611-0058)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/fb3bc1d1ea3b445e8b2d8f82af2c83082/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2019.0150.4043.16 ((SQLServer2019-CU5).200611-0058)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/2250bc823b6d45d78bbb1526118d5bcd1/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2019.0150.4043.16 ((SQLServer2019-CU5).200611-0058)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/f15f1bb425e345fbbbf9052dfff3009f2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2019.0150.4043.16 ((SQLServer2019-CU5).200611-0058)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/7119961e9948486980ac4126d67f28671/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2019.0150.4043.16 ((SQLServer2019-CU5).200611-0058)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/a5e2854d1d5e4c1b9c354018f78c6ca91/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2019.0150.4043.16 ((SQLServer2019-CU5).200611-0058)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/822326dc5739477b9d02545c442b49911/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2019.0150.4043.16 ((SQLServer2019-CU5).200611-0058)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/5303b7b87c2c4e2789a75900f67989fe1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2019.0150.4043.16 ((SQLServer2019-CU5).200611-0058)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/17641aefa414415686ca0f4ad81a06a12/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2019.0150.4043.16 ((SQLServer2019-CU5).200611-0058)
```

# SQL Server 2019 RTM CU4 - 15.0.4033.1 - x64 (KB4548597)
``` powershell
# SQL Server 2019 RTM CU4 - 15.0.4033.1 - x64 (KB4548597)
$outputFolder = 'c:\sqlsyms\15.0.4033.1\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/a17ffc040bf74b9da5f1c2f8bee3b0ae2/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2019.0150.4033.01 ((SQLServer2019-CU4).200314-2237)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/007d639428594ba6b418a4031001af3c2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2019.0150.4033.01 ((SQLServer2019-CU4).200314-2237)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/a0e96c634bcf469ba8d5739a3763b31c2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2019.0150.4033.01 ((SQLServer2019-CU4).200314-2237)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/72be5cf0b1754f7990ac550066c59cf22/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2019.0150.4033.01 ((SQLServer2019-CU4).200314-2237)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/8cf1b3945a3342828669727df4b89a561/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2019.0150.4033.01 ((SQLServer2019-CU4).200314-2237)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/996fcbd6df90470fbf483f5bbc076f022/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2019.0150.4033.01 ((SQLServer2019-CU4).200314-2237)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/5e53ca24d90540b48d0c183348897c011/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2019.0150.4033.01 ((SQLServer2019-CU4).200314-2237)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/caaa30913c3f443fa2971996571662721/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2019.0150.4033.01 ((SQLServer2019-CU4).200314-2237)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/0727c20ffb694b7b966a311ba8a839ed1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2019.0150.4033.01 ((SQLServer2019-CU4).200314-2237)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/46e02f96623c4a3b980d6b915c81586c1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2019.0150.4033.01 ((SQLServer2019-CU4).200314-2237)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/f326b1ebadce4ed7b63721256723d9d12/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2019.0150.4033.01 ((SQLServer2019-CU4).200314-2237)
```

# SQL Server 2019 RTM CU3 - 15.0.4023.6 - x64 (KB4538853)
``` powershell
# SQL Server 2019 RTM CU3 - 15.0.4023.6 - x64 (KB4538853)
$outputFolder = 'c:\sqlsyms\15.0.4023.6\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/1f99f28740354638ab808a14641af26a2/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2019.0150.4023.06 ((SQLServer2019-CU3).200304-0805)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/7ec066594c274590ad0e4284ecbb7e7b2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2019.0150.4023.06 ((SQLServer2019-CU3).200304-0805)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/6f5ca7b595704b1a83302a33ae4bc0232/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2019.0150.4023.06 ((SQLServer2019-CU3).200304-0805)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/c5447784964c488cb3ec1370a45ce8a32/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2019.0150.4023.06 ((SQLServer2019-CU3).200304-0805)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/ac8c33e259e74a37be1fba98de2d5dea1/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2019.0150.4023.06 ((SQLServer2019-CU3).200304-0805)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/b82843359f73486ebb55be54a8258a512/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2019.0150.4023.06 ((SQLServer2019-CU3).200304-0805)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/eabcb2cbd8734147826fc8e5fed91d051/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2019.0150.4023.06 ((SQLServer2019-CU3).200304-0805)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/67e76e9883cc408ab61bef65da8566ca1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2019.0150.4023.06 ((SQLServer2019-CU3).200304-0805)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/4aa18ea029164914a8ebca601fb086f31/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2019.0150.4023.06 ((SQLServer2019-CU3).200304-0805)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/24f1b7e3408e46df88b53a0417eff0ec1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2019.0150.4023.06 ((SQLServer2019-CU3).200304-0805)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/e46cc8dbdfc540dda33b7bd994f636782/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2019.0150.4023.06 ((SQLServer2019-CU3).200304-0805)
```

# SQL Server 2019 RTM CU2 - 15.0.4013.40 - x64 (KB4536075)
``` powershell
# SQL Server 2019 RTM CU2 - 15.0.4013.40 - x64 (KB4536075)
$outputFolder = 'c:\sqlsyms\15.0.4013.40\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/db2c3b3cd98041eebe71f258bb783cf52/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2019.0150.4013.40 ((SQLServer2019-CU2).200204-0018)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/79cc12f37c694a4cb246d9ff1006f48a2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2019.0150.4013.40 ((SQLServer2019-CU2).200204-0018)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/135a7055bda8408a958cfd365c4a04342/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2019.0150.4013.40 ((SQLServer2019-CU2).200204-0018)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/8d85294d07c14151baa2c1fdcedb3d702/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2019.0150.4013.40 ((SQLServer2019-CU2).200204-0018)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/dc09a9a5bc5d41798cfd16759101bc0f1/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2019.0150.4013.40 ((SQLServer2019-CU2).200204-0018)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/f6fa22f7a94744a3836e2e336677209a2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2019.0150.4013.40 ((SQLServer2019-CU2).200204-0018)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/05c36542b2c44ac2b7e2b6718e4ee9dd1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2019.0150.4013.40 ((SQLServer2019-CU2).200204-0018)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/b2a184d9e3704c63a988ad8a142af4e81/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2019.0150.4013.40 ((SQLServer2019-CU2).200204-0018)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/2d4753074ba64ba193ab702286a752b71/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2019.0150.4013.40 ((SQLServer2019-CU2).200204-0018)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/19e519afd6a34b2ba91458cbf5378e801/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2019.0150.4013.40 ((SQLServer2019-CU2).200204-0018)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/70258a046ea44af38bf97bb73a90df412/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2019.0150.4013.40 ((SQLServer2019-CU2).200204-0018)
```

# SQL Server 2019 RTM CU1 - 15.0.4003.23 - x64 (KB4527376)
``` powershell
# SQL Server 2019 RTM CU1 - 15.0.4003.23 - x64 (KB4527376)
$outputFolder = 'c:\sqlsyms\15.0.4003.23\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/1c28d53f4ce34500a0824edf754bb3182/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2019.0150.4003.23 ((SQL19_RTM_QFE-OD).191206-2237)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/725357d7267b4fcb8bed1520f7638ae52/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2019.0150.4003.23 ((SQL19_RTM_QFE-OD).191206-2237)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/872bec978b414b4894b0007d495aff9c2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2019.0150.4003.23 ((SQL19_RTM_QFE-OD).191206-2237)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/c2f014bfeb4148e79fa69e3bdf81fc232/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2019.0150.4003.23 ((SQL19_RTM_QFE-OD).191206-2237)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/9186d8f25f3344849c0afbd8086431c71/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2019.0150.4003.23 ((SQL19_RTM_QFE-OD).191206-2237)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/86c0928cbca241508082e6ae13a7b2ad2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2019.0150.4003.23 ((SQL19_RTM_QFE-OD).191206-2237)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/ddc9bae1e79e4be38aba05b28f20ba481/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2019.0150.4003.23 ((SQL19_RTM_QFE-OD).191206-2237)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/9c7a349dca4a4f8bb2a405e2a36d7b091/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2019.0150.4003.23 ((SQL19_RTM_QFE-OD).191206-2237)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/f19350dff8c54443aee52644b816d1371/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2019.0150.4003.23 ((SQL19_RTM_QFE-OD).191206-2237)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/6c2376ab69404cf89eea336bc33242371/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2019.0150.4003.23 ((SQL19_RTM_QFE-OD).191206-2237)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/db06d320fc1a4f1492e857d7804288672/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2019.0150.4003.23 ((SQL19_RTM_QFE-OD).191206-2237)
```

# SQL Server 2019 RTM Servicing Update (GDR1) - 15.0.2070.41 - x64 (KB4517790)
``` powershell
# SQL Server 2019 RTM Servicing Update (GDR1) - 15.0.2070.41 - x64 (KB4517790)
$outputFolder = 'c:\sqlsyms\15.0.2070.41\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/35fa14a3b9874a72a017fadba93e24b12/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2019.0150.2070.41 ((SQLServer).191029-0237)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/1535e7976f0a431baf2704de5f2e5fdc2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2019.0150.2070.41 ((SQLServer).191029-0237)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/9cb9edfe939f4b03b50222c9b39f196c2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2019.0150.2070.41 ((SQLServer).191029-0237)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/bdd5d0345b64423394986dc1a4a37e3d2/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2019.0150.2070.41 ((SQLServer).191029-0237)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/01955e0a0c344aa9ba96522fb1ce96671/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2019.0150.2070.41 ((SQLServer).191029-0237)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/34e92930c4454a74acadc5f504d350f92/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2019.0150.2070.41 ((SQLServer).191029-0237)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/39717e154f0746668714cce86cebc6ba1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2019.0150.2070.41 ((SQLServer).191029-0237)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/e1295a820f7d4cb08ca66421bc0e872c1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2019.0150.2070.41 ((SQLServer).191029-0237)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/30c5297c5e244754a8e799717f9dd69b1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2019.0150.2070.41 ((SQLServer).191029-0237)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/69bd28349a494ebca2c0c0be7230183c1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2019.0150.2070.41 ((SQLServer).191029-0237)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/c0ead5152bae41f69d8dbcb210237a062/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2019.0150.2070.41 ((SQLServer).191029-0237)
```

# SQL Server 2019 RTM RTM - 15.0.2000.5 - x64 (Nov 2019)
``` powershell
# SQL Server 2019 RTM RTM - 15.0.2000.5 - x64 (Nov 2019)
$outputFolder = 'c:\sqlsyms\15.0.2000.5\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/a32ecbddb336439994cc1bf8ca5612052/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2019.0150.2000.05 ((SQLServer).190924-2033)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/c451d01cb0d142afb1e497def47bd4b32/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2019.0150.2000.05 ((SQLServer).190924-2033)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/b69375ae56964976a91c384bda088abc2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2019.0150.2000.05 ((SQLServer).190924-2033)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/c111d07e3fe9461cb21655d20b2f13e82/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2019.0150.2000.05 ((SQLServer).190924-2033)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/d3cc4bb1711f45e5bdcbfdc6ce90400e1/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2019.0150.2000.05 ((SQLServer).190924-2033)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/ee3b2b5f10024545bc623c768f8e98c82/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2019.0150.2000.05 ((SQLServer).190924-2033)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/b996f74062ef41f88e762d7cde413ca81/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2019.0150.2000.05 ((SQLServer).190924-2033)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/a5b534efcad44ea4b8951a28847907031/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2019.0150.2000.05 ((SQLServer).190924-2033)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/139725cae1124fd19c7065ca5dd091c01/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2019.0150.2000.05 ((SQLServer).190924-2033)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/6e3e07ad09d6475aae40a87c8483f31e1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2019.0150.2000.05 ((SQLServer).190924-2033)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/55586008647b45f49f51934563c320cb2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2019.0150.2000.05 ((SQLServer).190924-2033)
```

# SQL Server 2019 RC RC1 - 15.0.1900.25 - x64 (Aug 2019)
``` powershell
# SQL Server 2019 RC RC1 - 15.0.1900.25 - x64 (Aug 2019)
$outputFolder = 'c:\sqlsyms\15.0.1900.25\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/807730dc54d8486cbb301034d5c8e8d42/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2019.0150.1900.25 ((SQLServer).190816-2101)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/df94c4b01e8b47a7aab9cc2c24b425bb2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2019.0150.1900.25 ((SQLServer).190816-2101)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/176f91f058de40ca94e15eda8da9cc382/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2019.0150.1900.25 ((SQLServer).190816-2101)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/a3397ad3fbbd424eb40829ec9875fc832/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2019.0150.1900.25 ((SQLServer).190816-2101)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/7c43dc13a0244c34a87633c0b3bdf9851/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2019.0150.1900.25 ((SQLServer).190816-2101)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/e2f9e096f96e4860b8ba44cf4cc5a0a72/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2019.0150.1900.25 ((SQLServer).190816-2101)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/ca9b35071e0143df9136f86359a5ac471/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2019.0150.1900.25 ((SQLServer).190816-2101)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/a11cc82202ff404a9241a178f6c5c5eb1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2019.0150.1900.25 ((SQLServer).190816-2101)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/bdfab5fc03914efc839596e3476487e51/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2019.0150.1900.25 ((SQLServer).190816-2101)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/ebd4a16987eb4c8198107eca6471f4af1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2019.0150.1900.25 ((SQLServer).190816-2101)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/8f08dd3bcf934ea8933e21473ded4a042/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2019.0150.1900.25 ((SQLServer).190816-2101)
```

# SQL Server 2019 CTP CTP 3.2 - 15.0.1800.32 - x64 (Jul 2019)
``` powershell
# SQL Server 2019 CTP CTP 3.2 - 15.0.1800.32 - x64 (Jul 2019)
$outputFolder = 'c:\sqlsyms\15.0.1800.32\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/9c623f4336c24e489fd8dd3998f34cc02/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2019.0150.1800.32 ((SQLServer).190718-0401)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/e705bad3292c47e4b4d6963b8e559a1d2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2019.0150.1800.32 ((SQLServer).190718-0401)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/7a2bc2e75f4f4bc4ae68bbb4952c30642/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2019.0150.1800.32 ((SQLServer).190718-0401)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/9f16df7c1680418d83a375eb42883a312/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2019.0150.1800.32 ((SQLServer).190718-0401)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/85d769fd63df4a07b0bd03e683b3ac8e1/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2019.0150.1800.32 ((SQLServer).190718-0401)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/fa2ccd5225de4ff3a33d2f28ddb69ec22/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2019.0150.1800.32 ((SQLServer).190718-0401)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/1c3a00d0fa0a41d89e8f0b5ba2713f5d1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2019.0150.1800.32 ((SQLServer).190718-0401)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/886259b54c1246ff9884f355af67f1201/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2019.0150.1800.32 ((SQLServer).190718-0401)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/87b8448051c848149b5beb098d4880841/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2019.0150.1800.32 ((SQLServer).190718-0401)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/434635bff10945e8bb07c9f25339e75e1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2019.0150.1800.32 ((SQLServer).190718-0401)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/22541fc9a9034693b17da8546301e3bb2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2019.0150.1800.32 ((SQLServer).190718-0401)
```

# SQL Server 2019 CTP CTP3.1 - 15.0.1700.37 - x64 (Jun 2019)
``` powershell
# SQL Server 2019 CTP CTP3.1 - 15.0.1700.37 - x64 (Jun 2019)
$outputFolder = 'c:\sqlsyms\15.0.1700.37\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/9e557f85f9224d708abf2f557c7456e62/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2019.0150.1700.37 ((SQLServer).190619-1757)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/9af9b26e3fea49f1bd5b5367174bd9242/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2019.0150.1700.37 ((SQLServer).190619-1757)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/a6090023473742aa8f5c2fe198274cfe2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2019.0150.1700.37 ((SQLServer).190619-1757)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/e7708ef60f1d406f8bf6b05117dd8d962/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2019.0150.1700.37 ((SQLServer).190619-1757)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/12aa7d212fb14305bb582a9d0156079c1/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2019.0150.1700.37 ((SQLServer).190619-1757)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/60706aa038aa4e84901a0eb75c660d452/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2019.0150.1700.37 ((SQLServer).190619-1757)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/6b687fb2adab4f49b13169f0f6a6b1261/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2019.0150.1700.37 ((SQLServer).190619-1757)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/b96e03193f454e32a634e57ec66cb2dc1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2019.0150.1700.37 ((SQLServer).190619-1757)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/6b65fc282cf944fa9f3facf18303fa2e1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2019.0150.1700.37 ((SQLServer).190619-1757)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/0eed3325fb7f4ee085f479e484f5bfa81/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2019.0150.1700.37 ((SQLServer).190619-1757)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/51dbb121d73f4dbaa4640507a7558ecc2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2019.0150.1700.37 ((SQLServer).190619-1757)
```

# SQL Server 2019 CTP CTP3.0 - 15.0.1600.8 - x64 (May 2019)
``` powershell
# SQL Server 2019 CTP CTP3.0 - 15.0.1600.8 - x64 (May 2019)
$outputFolder = 'c:\sqlsyms\15.0.1600.8\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/8be214152c184afcaa324365f9c1a3b52/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2019.0150.1600.08 ((SQLServer).190517-0718)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/6bf39a278a27415e9aabfdb240d9ca612/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2019.0150.1600.08 ((SQLServer).190517-0718)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/c3e953f7f5704ce69b8ca62fbc62656b2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2019.0150.1600.08 ((SQLServer).190517-0718)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/8e72849826824e919215135180d284d92/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2019.0150.1600.08 ((SQLServer).190517-0718)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/d0e0e82ed4be4852962c4ac90303107c1/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2019.0150.1600.08 ((SQLServer).190517-0718)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/3986538b627e42b982a5c663fa9751862/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2019.0150.1600.08 ((SQLServer).190517-0718)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/866191ebab104dd38be0a902d87762581/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2019.0150.1600.08 ((SQLServer).190517-0718)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/38304f5776fc4982a96cf4628dcc51941/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2019.0150.1600.08 ((SQLServer).190517-0718)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/3bfcef2ebbba4702af4be06c10c06f861/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2019.0150.1600.08 ((SQLServer).190517-0718)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/25b7cfed794846d8acfed97c702ba2cd1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2019.0150.1600.08 ((SQLServer).190517-0718)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/a0d82d62e01542b9962d6093d402ebf62/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2019.0150.1600.08 ((SQLServer).190517-0718)
```

# SQL Server 2019 CTP CTP2.5 - 15.0.1500.28 - x64 (April 2019)
``` powershell
# SQL Server 2019 CTP CTP2.5 - 15.0.1500.28 - x64 (April 2019)
$outputFolder = 'c:\sqlsyms\15.0.1500.28\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/de490193e66048d4b8f93980b36f5cec2/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2019.0150.1500.28 ((SQLServer).190415-2131)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/222c7b12b2d34c709a092e59249e541a2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2019.0150.1500.28 ((SQLServer).190415-2131)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/ae39c1a85f294c068a7510b8c93814432/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2019.0150.1500.28 ((SQLServer).190415-2131)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/6916c4073925451ba18162d2b39980dc2/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2019.0150.1500.28 ((SQLServer).190415-2131)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/1c80ecdf24d44affa414ab37a3a78f6f1/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2019.0150.1500.28 ((SQLServer).190415-2131)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/af19898435d34f4e9f1dcda16e34b98a2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2019.0150.1500.28 ((SQLServer).190415-2131)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/f0f4f38d477a491db3fa7360b91551531/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2019.0150.1500.28 ((SQLServer).190415-2131)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/3f3eafd827f14c60ba3709af3fa2af791/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2019.0150.1500.28 ((SQLServer).190415-2131)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/09127f33dee145fcb2b1828163d986a11/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2019.0150.1500.28 ((SQLServer).190415-2131)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/dc460c45ed50496f9eff9c3fc107f46f1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2019.0150.1500.28 ((SQLServer).190415-2131)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/2fe2f4d6593444dca6294d8694cc01442/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2019.0150.1500.28 ((SQLServer).190415-2131)
```

# SQL Server 2019 CTP CTP2.4 - 15.0.1400.75 - x64 (March 2019)
``` powershell
# SQL Server 2019 CTP CTP2.4 - 15.0.1400.75 - x64 (March 2019)
$outputFolder = 'c:\sqlsyms\15.0.1400.75\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/19d870c6afaa43c9b925ace5a6c841d92/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2019.0150.1400.75 ((SQLServer).190316-1802)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/a3a47799b1b64d928b721a14d2caa7252/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2019.0150.1400.75 ((SQLServer).190316-1802)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/14270b62941a4b98bd6c0f4e640ce7182/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2019.0150.1400.75 ((SQLServer).190316-1802)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/7348cf1b0b4a4fe6bd0a8091df4b602a2/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2019.0150.1400.75 ((SQLServer).190316-1802)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/ad38a740f1a54a93b5ad507dcdd9d4d01/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2019.0150.1400.75 ((SQLServer).190316-1802)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/32664240697e4a6a99c56bbaa4b286a32/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2019.0150.1400.75 ((SQLServer).190316-1802)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/a6fad09bf4054c9697c38eb84eae5a801/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2019.0150.1400.75 ((SQLServer).190316-1802)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/70da4b6f6a574d47bba5cc811ec1046a1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2019.0150.1400.75 ((SQLServer).190316-1802)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/dbd7a18fab2946f8a58c35c6bcdfa13d1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2019.0150.1400.75 ((SQLServer).190316-1802)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/1b74c0360a0e4338a7d92cd8c00cd9d31/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2019.0150.1400.75 ((SQLServer).190316-1802)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/dde99a1492e84ef0926504cfe6afebec2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2019.0150.1400.75 ((SQLServer).190316-1802)
```

# SQL Server 2019 CTP CTP2.3 - 15.0.1300.359 - x64 (Feb 2019)
``` powershell
# SQL Server 2019 CTP CTP2.3 - 15.0.1300.359 - x64 (Feb 2019)
$outputFolder = 'c:\sqlsyms\15.0.1300.359\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/8d76a19c14344ec387a897611b8b8b882/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2019.0150.1300.359 ((SQLServer).190216-0730)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/a3f62ef419b64a8c973a24150ba095b22/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2019.0150.1300.359 ((SQLServer).190216-0730)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/66abfc4397dd480f8873349e5edbfd142/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2019.0150.1300.359 ((SQLServer).190216-0730)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/c7ce4847496848b2ae3f24a282f479b12/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2019.0150.1300.359 ((SQLServer).190216-0730)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/a0f649ac82df495ba6a2a8fd818fb1dd1/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2019.0150.1300.359 ((SQLServer).190216-0730)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/33dbea5fbe0143d58286fe47f21605702/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2019.0150.1300.359 ((SQLServer).190216-0730)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/b1b0c9de60a14ec5a04f8f1cd80a75301/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2019.0150.1300.359 ((SQLServer).190216-0730)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/4293b10217714217a630622cb51ca0861/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2019.0150.1300.359 ((SQLServer).190216-0730)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/68bda83b7e99449987e9bdaa25a3abd31/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2019.0150.1300.359 ((SQLServer).190216-0730)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/aff6d1fc049e46028094cb26ee5fb9101/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2019.0150.1300.359 ((SQLServer).190216-0730)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/377253089c3e42168bbd7d13bedb1da52/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2019.0150.1300.359 ((SQLServer).190216-0730)
```

# SQL Server 2019 CTP CTP2.2 - 15.0.1200.24 - x64 (Dec 2018)
``` powershell
# SQL Server 2019 CTP CTP2.2 - 15.0.1200.24 - x64 (Dec 2018)
$outputFolder = 'c:\sqlsyms\15.0.1200.24\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/2c606b4367a4429c992d5ca42512c7282/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2018.0150.1200.24 ((SQLServer).181205-2233)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/a67be7179bab4e30bc9e9b2bf0a0259a2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2018.0150.1200.24 ((SQLServer).181205-2233)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/9a0e2aabffc94c52a0c130ba253fe9712/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2018.0150.1200.24 ((SQLServer).181205-2233)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/d58e802ce7984e098a7cec464a001bee2/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2018.0150.1200.24 ((SQLServer).181205-2233)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/15d57320c04b444bb34709c58a93d1691/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2018.0150.1200.24 ((SQLServer).181205-2233)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/8eb24ab8cb084224b18cdb3aaa075be02/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2018.0150.1200.24 ((SQLServer).181205-2233)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/40669c7f8e7f4d33949b7c590b78ae581/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2018.0150.1200.24 ((SQLServer).181205-2233)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/48d913073c2c404cac8f449c33020ba31/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2018.0150.1200.24 ((SQLServer).181205-2233)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/71c0383ff3d64837baa474cb8fd46d341/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2018.0150.1200.24 ((SQLServer).181205-2233)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/25ac40a4dfb04d8d9e943259156c6eff1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2018.0150.1200.24 ((SQLServer).181205-2233)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/eef4684b29ec49ada134bf2e5d266c7b2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2018.0150.1200.24 ((SQLServer).181205-2233)
```

# SQL Server 2019 CTP CTP2.1 - 15.0.1100.94 - x64 (Nov 2018)
``` powershell
# SQL Server 2019 CTP CTP2.1 - 15.0.1100.94 - x64 (Nov 2018)
$outputFolder = 'c:\sqlsyms\15.0.1100.94\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/2396a09ad02847069a2932edada5013f2/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2018.0150.1100.94 ((SQLServer).181101-2034)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/2a859b14f55a49b18757dae8a9d431b02/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2018.0150.1100.94 ((SQLServer).181101-2034)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/84f83087a0914973a9378f1bd7391f0a2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2018.0150.1100.94 ((SQLServer).181101-2034)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/4a0764a16a9f4862a294c68fa70d9e362/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2018.0150.1100.94 ((SQLServer).181101-2034)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/15a322a3311b4663b97cd77c55312efc3/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2018.0150.1100.94 ((SQLServer).181101-2034)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/2c7c552e20814e7cafd031b4a5f55ff82/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2018.0150.1100.94 ((SQLServer).181101-2034)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/1861f31229a24d098ba62005e71ec1ed1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2018.0150.1100.94 ((SQLServer).181101-2034)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/0eefeca4685943f0b57d87091fda67e41/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2018.0150.1100.94 ((SQLServer).181101-2034)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/c9379eab5bab492cbbff0cec75549d6f1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2018.0150.1100.94 ((SQLServer).181101-2034)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/c8e790ff4bdf41bc976393b733fae5521/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2018.0150.1100.94 ((SQLServer).181101-2034)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/28856cd400a64ae8bdd78eee5d1969a12/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2018.0150.1100.94 ((SQLServer).181101-2034)
```

# SQL Server 2019 CTP CTP2.0 - 15.0.1000.34 - x64 (Oct 2018)
``` powershell
# SQL Server 2019 CTP CTP2.0 - 15.0.1000.34 - x64 (Oct 2018)
$outputFolder = 'c:\sqlsyms\15.0.1000.34\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/1fb52db46791403f80a736a3a2892d872/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2018.0150.1000.34 ((SQLServer).180918-0824)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/dbb1be06cf8f47fab0354ab426dc85b82/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2018.0150.1000.34 ((SQLServer).180918-0824)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/e0c87c8653a14fce8988a727a0c113742/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2018.0150.1000.34 ((SQLServer).180918-0824)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/95328c1d4b7e4c0991b1e3b23d7599132/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2018.0150.1000.34 ((SQLServer).180918-0824)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/d51850bf713a4cd0bd080a52bdbda48d3/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2018.0150.1000.34 ((SQLServer).180918-0824)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/b7b40f4370474643b66a0b4f458bfa1e2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2018.0150.1000.34 ((SQLServer).180918-0824)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/6b48ecaa4c254d3fb8415b7b48b1addf1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2018.0150.1000.34 ((SQLServer).180918-0824)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/98e6ce276a384a459c3902090bb411e01/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2018.0150.1000.34 ((SQLServer).180918-0824)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/b3123f07e8a24ff99677f0c0a39ab3461/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2018.0150.1000.34 ((SQLServer).180918-0824)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/1c74d1e91078452f9facb3317fdf7b851/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2018.0150.1000.34 ((SQLServer).180918-0824)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/b3c1eb7ab1d2455aac81b7eb7fb43a162/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2018.0150.1000.34 ((SQLServer).180918-0824)
```

