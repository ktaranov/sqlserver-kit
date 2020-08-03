# SQL Server 2017 RTM CU21 - 14.0.3335.7 - x64 (KB4557397)
``` powershell
# SQL Server 2017 RTM CU21 - 14.0.3335.7 - x64 (KB4557397)
$outputFolder = 'c:\sqlsyms\14.0.3335.7\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/eb5a565f1039423ab57f1b0c07f2cf062/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3335.07 ((SQL17_RTM_QFE-CU).200613-0316)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/a95c4feb63e24e859cc3ea84c66738362/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3335.07 ((SQL17_RTM_QFE-CU).200613-0316)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/15abf4bc294f43439f8d26bcc081b7852/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3335.07 ((SQL17_RTM_QFE-CU).200613-0316)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/0b714c2255d248be8e2772ed2614c3252/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3335.07 ((SQL17_RTM_QFE-CU).200613-0316)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/cfa406dc3e6f44fbaecf3bb7bfef85403/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3335.07 ((SQL17_RTM_QFE-CU).200613-0316)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/74e2955f444d4a999afc17aebfc101b62/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3335.07 ((SQL17_RTM_QFE-CU).200613-0316)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/e2a53588492542619e2df6eb2f15fbd81/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3335.07 ((SQL17_RTM_QFE-CU).200613-0316)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/0611eac031eb43e1ba9b7df173a4baaf1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3335.07 ((SQL17_RTM_QFE-CU).200613-0316)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/bee1e0c4ebf047f58848229e8e8080301/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3335.07 ((SQL17_RTM_QFE-CU).200613-0316)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/0f83d02887a64bb38055cec85d9816351/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3335.07 ((SQL17_RTM_QFE-CU).200613-0316)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/ebf1bd99202241e49994b70abd89b06c2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3335.07 ((SQL17_RTM_QFE-CU).200613-0316)
```

# SQL Server 2017 RTM CU20 - 14.0.3294.2 - x64 (KB4541283)
``` powershell
# SQL Server 2017 RTM CU20 - 14.0.3294.2 - x64 (KB4541283)
$outputFolder = 'c:\sqlsyms\14.0.3294.2\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/bee1fad8fac344258a08781c73e86ed52/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3294.02 ((SQL17_RTM_QFE-CU).200313-2113)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/2a5c5b4ca34b4406b4458d69ac3e4cae2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3294.02 ((SQL17_RTM_QFE-CU).200313-2113)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/3875b7d16696416f9301c11cef45b20d2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3294.02 ((SQL17_RTM_QFE-CU).200313-2113)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/b50d619829294819a0b07403e79e9ded2/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3294.02 ((SQL17_RTM_QFE-CU).200313-2113)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/32ca1afe76d247de8ddeb0b8bed119763/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3294.02 ((SQL17_RTM_QFE-CU).200313-2113)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/b33c89a9f1bf48dab0da20e1e1f14b372/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3294.02 ((SQL17_RTM_QFE-CU).200313-2113)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/13f6629965894b1a898d22a6075e9d321/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3294.02 ((SQL17_RTM_QFE-CU).200313-2113)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/c56991f0bbb44efd9550bdb640b930921/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3294.02 ((SQL17_RTM_QFE-CU).200313-2113)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/c57fd569df0c4b71827c8a73da6ff82f1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3294.02 ((SQL17_RTM_QFE-CU).200313-2113)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/120c44132c254546a280305c87974fd41/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3294.02 ((SQL17_RTM_QFE-CU).200313-2113)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/2187f716c3254ca882a146416b6231d92/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3294.02 ((SQL17_RTM_QFE-CU).200313-2113)
```

# SQL Server 2017 RTM CU19 - 14.0.3281.6 - x64 (KB4535007)
``` powershell
# SQL Server 2017 RTM CU19 - 14.0.3281.6 - x64 (KB4535007)
$outputFolder = 'c:\sqlsyms\14.0.3281.6\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/77d53ce9ab0d4543b6625be66af453422/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3281.06 ((SQL17_RTM_QFE-CU).200124-0352)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/e19ffa5d57f24259a2a98fdd90289e152/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3281.06 ((SQL17_RTM_QFE-CU).200124-0352)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/f421b91603c34ba99b30746fd8059d772/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3281.06 ((SQL17_RTM_QFE-CU).200124-0352)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/672558a3b8504bb0b1dd7bcd11f9c84a2/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3281.06 ((SQL17_RTM_QFE-CU).200124-0352)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/1e174cf6018a4087be3d9fb563fe1b633/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3281.06 ((SQL17_RTM_QFE-CU).200124-0352)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/971fc73e739647b8998f3a158cdeee4f2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3281.06 ((SQL17_RTM_QFE-CU).200124-0352)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/84c15d654b424537b1947ac49c2bffef1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3281.06 ((SQL17_RTM_QFE-CU).200124-0352)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/b69205eb69a8423dbec803e670916fe51/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3281.06 ((SQL17_RTM_QFE-CU).200124-0352)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/7eec0edeb9f9430c9958d3a06448b6c21/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3281.06 ((SQL17_RTM_QFE-CU).200124-0352)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/2a200d24c4da4a678c4ebe925100e6e41/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3281.06 ((SQL17_RTM_QFE-CU).200124-0352)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/e13e064b30614472be3ba2d950f0a78b2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3281.06 ((SQL17_RTM_QFE-CU).200124-0352)
```

# SQL Server 2017 RTM CU18 - 14.0.3257.3 - x64 (KB4527377)
``` powershell
# SQL Server 2017 RTM CU18 - 14.0.3257.3 - x64 (KB4527377)
$outputFolder = 'c:\sqlsyms\14.0.3257.3\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/0cf29846f3c24e78ad6c68ffc23c958b2/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3257.03 ((SQL17_RTM_QFE-CU).191116-0848)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/edc4c7b44f9842f5ba869f71b5d409d72/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3257.03 ((SQL17_RTM_QFE-CU).191116-0848)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/e9b9a716dd8a4c80a1cde404d18ca8142/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3257.03 ((SQL17_RTM_QFE-CU).191116-0848)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/ee0cc71e1a194e49bbb83839ce3b7f342/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3257.03 ((SQL17_RTM_QFE-CU).191116-0848)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/18f1fdf24e1c4a2b8a647f005476ea353/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3257.03 ((SQL17_RTM_QFE-CU).191116-0848)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/92014d8cf1724ba281afe5be39449fce2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3257.03 ((SQL17_RTM_QFE-CU).191116-0848)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/88d125cb6c734230bda07306dc5a44971/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3257.03 ((SQL17_RTM_QFE-CU).191116-0848)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/4f77a328940e448e97c9bb6e817b34c71/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3257.03 ((SQL17_RTM_QFE-CU).191116-0848)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/2572674dae244c15af96c8fb8dbc76891/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3257.03 ((SQL17_RTM_QFE-CU).191116-0848)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/ae6fdf41e3a34796a31096c15ffe09b71/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3257.03 ((SQL17_RTM_QFE-CU).191116-0848)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/46d8ae1b2f884ce8bd9bbf46c2a5a54e2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3257.03 ((SQL17_RTM_QFE-CU).191116-0848)
```

# SQL Server 2017 RTM CU17 - 14.0.3238.1 - x64 (KB4515579)
``` powershell
# SQL Server 2017 RTM CU17 - 14.0.3238.1 - x64 (KB4515579)
$outputFolder = 'c:\sqlsyms\14.0.3238.1\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/5e50e02ad0cf43da8949c7caa26c49f92/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3238.01 ((SQLServer2017-CU14).190913-2228)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/fdb5ae5d994745f5b29bd9e5a44cfbac2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3238.01 ((SQLServer2017-CU14).190913-2228)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/c4ff40dd1b834161b04985c7e21556dc2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3238.01 ((SQLServer2017-CU14).190913-2228)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/4bef8588459043f89f045f2cb9956e342/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3238.01 ((SQLServer2017-CU14).190913-2228)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/4bf28ededa384502a61929dae625e0833/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3238.01 ((SQLServer2017-CU14).190913-2228)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/ac756fec0f804ed4b6bc3fecccb7ed152/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3238.01 ((SQLServer2017-CU14).190913-2228)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/2d58e76525314e67b7158d5b971973471/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3238.01 ((SQLServer2017-CU14).190913-2228)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/41ff67e8d1d94d7782771b2ceb7d91461/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3238.01 ((SQLServer2017-CU14).190913-2228)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/3567f1e7bd304700a1315891a9bffcf21/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3238.01 ((SQLServer2017-CU14).190913-2228)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/74418625e16d46dea9c4dabf1f3c97711/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3238.01 ((SQLServer2017-CU14).190913-2228)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/c3a61d285faa4b848c2ad7e7b02c54742/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3238.01 ((SQLServer2017-CU14).190913-2228)
```

# SQL Server 2017 RTM CU16 - 14.0.3223.3 - x64 (KB4508218)
``` powershell
# SQL Server 2017 RTM CU16 - 14.0.3223.3 - x64 (KB4508218)
$outputFolder = 'c:\sqlsyms\14.0.3223.3\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/cc2cb01a74b84342bad196721c4b229a2/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3223.03 ((SQLServer2017-CU14).190712-2335)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/b6830a8a29e746f7a9e334bbc16f73cd2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3223.03 ((SQLServer2017-CU14).190712-2335)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/d4be23dadfa94b4eaedf98e747a35f7a2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3223.03 ((SQLServer2017-CU14).190712-2335)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/60134c9480e24546b6dfcfa95981db792/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3223.03 ((SQLServer2017-CU14).190712-2335)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/942175c9b9254c3a8143db7613f4720e3/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3223.03 ((SQLServer2017-CU14).190712-2335)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/3d22f9effe75470b9cb73b22e30ee0042/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3223.03 ((SQLServer2017-CU14).190712-2335)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/d172da872f4f42faa859e1e262d8f1fe1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3223.03 ((SQLServer2017-CU14).190712-2335)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/2945c675b7f4457892e17485e328b6e11/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3223.03 ((SQLServer2017-CU14).190712-2335)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/05671d5db5a04a3e87f616b6a172e64e1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3223.03 ((SQLServer2017-CU14).190712-2335)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/3ba3e96155514539bf263e91196a59591/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3223.03 ((SQLServer2017-CU14).190712-2335)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/238777599d2342ada234a90d46ae10cd2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3223.03 ((SQLServer2017-CU14).190712-2335)
```

# SQL Server 2017 RTM CU15+GDR - 14.0.3192.2 - x64 (KB4505225)
``` powershell
# SQL Server 2017 RTM CU15+GDR - 14.0.3192.2 - x64 (KB4505225)
$outputFolder = 'c:\sqlsyms\14.0.3192.2\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/122fc135abf24465ba9e6be0a6274eb32/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3192.02 ((SQLServer2017-CU14).190615-0703)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/207221dfd01a4ecda2e45a5be4afa8342/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3192.02 ((SQLServer2017-CU14).190615-0703)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/7f9c184f5b2944cc8c1bdba07670f8412/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3192.02 ((SQLServer2017-CU14).190615-0703)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/9559bc0f3b5e4cef8a84ce08601fe3df2/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3192.02 ((SQLServer2017-CU14).190615-0703)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/24b12b3f43be4a27a4139c39849ef5e33/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3192.02 ((SQLServer2017-CU14).190615-0703)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/efd30261c88042a2a49e19b21f90ef002/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3192.02 ((SQLServer2017-CU14).190615-0703)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/cb6a1cd50b654d0a8474f4ed74255e6c1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3192.02 ((SQLServer2017-CU14).190615-0703)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/139c16954bd04111a21c3d8e834e5ea41/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3192.02 ((SQLServer2017-CU14).190615-0703)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/e0243d6070c94969a2aabfc1c32fb0a61/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3192.02 ((SQLServer2017-CU14).190615-0703)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/439bff18122840658f0e9240ffda29301/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3192.02 ((SQLServer2017-CU14).190615-0703)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/107813d2dfe94332aec5cba570dfa4082/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3192.02 ((SQLServer2017-CU14).190615-0703)
```

# SQL Server 2017 RTM Hotfix for CU15 - 14.0.3164.1 - x64 (4506633)
``` powershell
# SQL Server 2017 RTM Hotfix for CU15 - 14.0.3164.1 - x64 (4506633)
$outputFolder = 'c:\sqlsyms\14.0.3164.1\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/5f0e68f3162641ad8d035c501c0b697c2/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3164.01 ((SQLServer2017-CU15-OD).190529-2332)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/f90eacadd1904231a7dc6326c4ab53af2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3164.01 ((SQLServer2017-CU15-OD).190529-2332)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/7ef8fc8b0ed04a9f9dc7872b2ddb5bdb2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3164.01 ((SQLServer2017-CU15-OD).190529-2332)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/05f95c5ac74d4eb599b922c69dbc39c12/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3164.01 ((SQLServer2017-CU15-OD).190529-2332)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/6775b239a8fe440ba6bdae93bfcb524c3/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3164.01 ((SQLServer2017-CU15-OD).190529-2332)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/2be30f46dc9c414aa6ec8855811226fa2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3164.01 ((SQLServer2017-CU15-OD).190529-2332)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/6c08af17cbcc4ae6b47b9b000ba2df9f1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3164.01 ((SQLServer2017-CU15-OD).190529-2332)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/1f39d18ce9124de3a8af1fb9bf3b16b21/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3164.01 ((SQLServer2017-CU15-OD).190529-2332)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/beef7d8475d8486bb1acf9603c370d9b1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3164.01 ((SQLServer2017-CU15-OD).190529-2332)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/3c4f56edb20a4d7f903ea7985ee392551/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3164.01 ((SQLServer2017-CU15-OD).190529-2332)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/e5610121ea0b430ba050cfd7de9a55a72/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3164.01 ((SQLServer2017-CU15-OD).190529-2332)
```

# SQL Server 2017 RTM CU15 - 14.0.3162.1 - x64 (KB4498951)
``` powershell
# SQL Server 2017 RTM CU15 - 14.0.3162.1 - x64 (KB4498951)
$outputFolder = 'c:\sqlsyms\14.0.3162.1\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/1dfc724617524d0b81e6c9bfe5a3fa922/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3162.01 ((SQLServer2017-CU14).190516-0147)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/5b6770d3a2954ad38fcf61d69b2406f62/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3162.01 ((SQLServer2017-CU14).190516-0147)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/d912ea3687524101b23bc88c89be16062/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3162.01 ((SQLServer2017-CU14).190516-0147)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/7e76c3114d2445fb957c7e2f8d395b722/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3162.01 ((SQLServer2017-CU14).190516-0147)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/f5a9dd15f9e0443cbabb7b93f9d76b233/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3162.01 ((SQLServer2017-CU14).190516-0147)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/e5f4295c75c6451a885b0d60309760772/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3162.01 ((SQLServer2017-CU14).190516-0147)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/ba6e8c729b7f41a7b6863e2c11cd13561/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3162.01 ((SQLServer2017-CU14).190516-0147)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/1b3d232725c54f5dbd6e80715545efad1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3162.01 ((SQLServer2017-CU14).190516-0147)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/67e2b8702fa745f88d74d149c65524b81/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3162.01 ((SQLServer2017-CU14).190516-0147)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/1b81dfc91133481ab49da77d8e57f3c61/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3162.01 ((SQLServer2017-CU14).190516-0147)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/d7da732da1224c3dbbf571c85cdf65532/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3162.01 ((SQLServer2017-CU14).190516-0147)
```

# SQL Server 2017 RTM CU14+GDR - 14.0.3103.1 - x64 (KB4494352)
``` powershell
# SQL Server 2017 RTM CU14+GDR - 14.0.3103.1 - x64 (KB4494352)
$outputFolder = 'c:\sqlsyms\14.0.3103.1\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/3d4403b9c1644b51ae4e8518d6ce10852/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3103.01 ((SQLServer2017-CU14).190323-0508)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/dd1cd60ea219405ba26b3549a087d7cd2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3103.01 ((SQLServer2017-CU14).190323-0508)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/d8204dcd590548d0886483894461e2712/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3103.01 ((SQLServer2017-CU14).190323-0508)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/b5b369edbeb54c34929c63aaeef0c56a2/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3103.01 ((SQLServer2017-CU14).190323-0508)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/6e83a97d29fa45dcad8a1531728528103/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3103.01 ((SQLServer2017-CU14).190323-0508)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/201a31638edb45cea8fc7e3089c1b8bb2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3103.01 ((SQLServer2017-CU14).190323-0508)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/ccbb2144f26d47ecb0117313489d42d71/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3103.01 ((SQLServer2017-CU14).190323-0508)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/8e895540bc1b48b1ac1056481e757a001/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3103.01 ((SQLServer2017-CU14).190323-0508)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/02e0af9b69b241f4a9f63962d2f7b3e51/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3103.01 ((SQLServer2017-CU14).190323-0508)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/55a7586e0a684168944bc84d8b3f3a7b1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3103.01 ((SQLServer2017-CU14).190323-0508)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/13efe2857d1f407d8c3eafab072d28812/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3103.01 ((SQLServer2017-CU14).190323-0508)
```

# SQL Server 2017 RTM CU14 - 14.0.3076.1 - x64 (KB4484710)
``` powershell
# SQL Server 2017 RTM CU14 - 14.0.3076.1 - x64 (KB4484710)
$outputFolder = 'c:\sqlsyms\14.0.3076.1\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/9dc4b5b9129b4d90aca76c656a8a7cdb2/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3076.01 ((SQLServer2017-CU14).190313-0159)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/12a634d42b0a466fa8892f030ec414cf2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3076.01 ((SQLServer2017-CU14).190313-0159)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/5a0ee5562cf744fe87b6f8f0e66342a62/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3076.01 ((SQLServer2017-CU14).190313-0159)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/a9e9815a726f4f658305f67cbcb7ba432/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3076.01 ((SQLServer2017-CU14).190313-0159)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/7b7b6d8bbf4e4baba8437e4623514f163/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3076.01 ((SQLServer2017-CU14).190313-0159)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/74bda280c8e8462b879a8d1c6684d8b32/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3076.01 ((SQLServer2017-CU14).190313-0159)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/d9b0c3d63a0d48ce80d7ae4e6bd2faae1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3076.01 ((SQLServer2017-CU14).190313-0159)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/fb39d136087c4150905913a5a901dd081/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3076.01 ((SQLServer2017-CU14).190313-0159)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/4a46951e68434ecd93a667401da5c63c1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3076.01 ((SQLServer2017-CU14).190313-0159)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/ed48cfbb0bcb463b8ca48ab657da16221/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3076.01 ((SQLServer2017-CU14).190313-0159)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/8505782dfd8c4d589bb569f27dda72282/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3076.01 ((SQLServer2017-CU14).190313-0159)
```

# SQL Server 2017 RTM CU13 - 14.0.3048.4 - x64 (KB4466404)
``` powershell
# SQL Server 2017 RTM CU13 - 14.0.3048.4 - x64 (KB4466404)
$outputFolder = 'c:\sqlsyms\14.0.3048.4\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/db7d37e644684c76aca6244566f04ddb2/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3048.04 ((SQLServer2017-CU13).181130-2004)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/deb451448a184a019d15fbecb4b3dbd42/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3048.04 ((SQLServer2017-CU13).181130-2004)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/154b616962204fc98ab8ba2ac0944fd62/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3048.04 ((SQLServer2017-CU13).181130-2004)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/a8ea1f9fa4a8417b901a2e9c1108cd532/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3048.04 ((SQLServer2017-CU13).181130-2004)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/162006a3c04048a5b3c3bd6db4d37d5c3/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3048.04 ((SQLServer2017-CU13).181130-2004)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/254e81f1cf6d407188805d66c3fc8a002/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3048.04 ((SQLServer2017-CU13).181130-2004)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/6ad53123fe984297bf11178b0f6833b61/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3048.04 ((SQLServer2017-CU13).181130-2004)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/64e83552a4324544b14f7ad910d6dbd31/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3048.04 ((SQLServer2017-CU13).181130-2004)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/2750700543774a219883ff4fd8f9b1c71/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3048.04 ((SQLServer2017-CU13).181130-2004)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/045b89b9000c427aa2d7eb19476ead711/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3048.04 ((SQLServer2017-CU13).181130-2004)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/bb0704a30a134cc8a0436285de13449b2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3048.04 ((SQLServer2017-CU13).181130-2004)
```

# SQL Server 2017 RTM CU12 - 14.0.3045.24 - x64 (KB4464082)
``` powershell
# SQL Server 2017 RTM CU12 - 14.0.3045.24 - x64 (KB4464082)
$outputFolder = 'c:\sqlsyms\14.0.3045.24\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/e1a278df9008417880471554645ffe0e2/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3045.24 ((SQLServer2017-CU12).181019-0539)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/0f960e0b699d427db586034ed7b0fdef2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3045.24 ((SQLServer2017-CU12).181019-0539)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/3901620f11594833aa71280f8375f0be2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3045.24 ((SQLServer2017-CU12).181019-0539)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/9cfe911d498646b8ae4f2f50a9d067a42/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3045.24 ((SQLServer2017-CU12).181019-0539)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/27ed7bd2e8a7400e886335247c98a3073/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3045.24 ((SQLServer2017-CU12).181019-0539)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/9ab679cc975b4b1ba1d15706afd6450a2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3045.24 ((SQLServer2017-CU12).181019-0539)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/d2812bf323f14d81a9b099908c9ffff61/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3045.24 ((SQLServer2017-CU12).181019-0539)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/6615c4c7be0c407697ca045825239c131/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3045.24 ((SQLServer2017-CU12).181019-0539)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/196df91bf910437c9fd9acfa2117826f1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3045.24 ((SQLServer2017-CU12).181019-0539)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/6cc447fe65eb4c59aa455ccbf9b251a91/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3045.24 ((SQLServer2017-CU12).181019-0539)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/5cc64f878ee841aab5448338015a5c952/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3045.24 ((SQLServer2017-CU12).181019-0539)
```

# SQL Server 2017 RTM CU11 - 14.0.3038.14 - x64 (KB4462262)
``` powershell
# SQL Server 2017 RTM CU11 - 14.0.3038.14 - x64 (KB4462262)
$outputFolder = 'c:\sqlsyms\14.0.3038.14\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/33fb5fb0d73a441090eb718412270dbd2/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3038.14 ((SQLServer2017-CU11).180914-1944)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/c9ed01ded3264172a6a840a1510a9e082/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3038.14 ((SQLServer2017-CU11).180914-1944)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/58093a59f19b4a3398ce13fe13ed92ab2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3038.14 ((SQLServer2017-CU11).180914-1944)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/93188b40fdeb4d9b84f1b0825df6e5402/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3038.14 ((SQLServer2017-CU11).180914-1944)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/652be97b165947e18523339f10380c3e3/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3038.14 ((SQLServer2017-CU11).180914-1944)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/056712b91a6b43a98b8ddb86e19d07832/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3038.14 ((SQLServer2017-CU11).180914-1944)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/767d4249b3b342ccb953f3ff28a3477b1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3038.14 ((SQLServer2017-CU11).180914-1944)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/eec4e581cc1e4e9289b0ff1027f761c21/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3038.14 ((SQLServer2017-CU11).180914-1944)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/95f766b77d5340cf91e4237c1b5cb1d11/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3038.14 ((SQLServer2017-CU11).180914-1944)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/3da659532f314c3d971b21293e4fbf911/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3038.14 ((SQLServer2017-CU11).180914-1944)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/4ecd8c32a3744a72b86f59e40106e58f2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3038.14 ((SQLServer2017-CU11).180914-1944)
```

# SQL Server 2017 RTM CU10 - 14.0.3037.1 - x64 (KB4342123)
``` powershell
# SQL Server 2017 RTM CU10 - 14.0.3037.1 - x64 (KB4342123)
$outputFolder = 'c:\sqlsyms\14.0.3037.1\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/bd9f49c63360495684146dfce60449ca2/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3037.01 ((SQLServer2017-CU10).180727-1609)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/a7ac68d2a55042d4b014d983ca4dc5652/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3037.01 ((SQLServer2017-CU10).180727-1609)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/89f5a5f6f6cb46308ee263616e47a1e52/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3037.01 ((SQLServer2017-CU10).180727-1609)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/73b2fdabd985459abcf4b906d49acabe2/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3037.01 ((SQLServer2017-CU10).180727-1609)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/1914abc38f5c4d259a75f0d60f99fb503/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3037.01 ((SQLServer2017-CU10).180727-1609)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/c440983f340f41279499f51c06f0796a2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3037.01 ((SQLServer2017-CU10).180727-1609)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/e67f311e495e452cba574599785f478f1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3037.01 ((SQLServer2017-CU10).180727-1609)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/007f32ffc751482cab8cce28fae4eaae1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3037.01 ((SQLServer2017-CU10).180727-1609)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/d1e4131926fb4197a56f62d1aec4b0891/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3037.01 ((SQLServer2017-CU10).180727-1609)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/04067943d1b14ed58777d6bc6307223c1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3037.01 ((SQLServer2017-CU10).180727-1609)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/7726181ee6a44f1bb557e413279dd4ab2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3037.01 ((SQLServer2017-CU10).180727-1609)
```

# SQL Server 2017 RTM CU9 + GDR - 14.0.3035.2 - x64 (KB4293805)
``` powershell
# SQL Server 2017 RTM CU9 + GDR - 14.0.3035.2 - x64 (KB4293805)
$outputFolder = 'c:\sqlsyms\14.0.3035.2\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/2cd60104c58545f8930beb63ebc961542/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3035.02 ((SQLServer2017-CU9-GDR).180707-0051)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/0960eef2f5f74555a6bc0201f30b2dd32/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3035.02 ((SQLServer2017-CU9-GDR).180707-0051)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/c48a041fc73742acb92a2483901e3e232/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3035.02 ((SQLServer2017-CU9-GDR).180707-0051)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/97b1e169ef954a2fa0624d2da36be4712/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3035.02 ((SQLServer2017-CU9-GDR).180707-0051)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/04a742d9881d40f69a5b7d65befc114c3/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3035.02 ((SQLServer2017-CU9-GDR).180707-0051)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/a91a2cb72c0b4147ac810d5c0fb0b1822/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3035.02 ((SQLServer2017-CU9-GDR).180707-0051)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/17e84ac011b740de94a0e096713ed7061/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3035.02 ((SQLServer2017-CU9-GDR).180707-0051)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/89f68be128904de1aa86fcb9815538161/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3035.02 ((SQLServer2017-CU9-GDR).180707-0051)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/f2c0eb19ab6b47609637f59efac0a5c71/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3035.02 ((SQLServer2017-CU9-GDR).180707-0051)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/0f67bd671bda40e7b9498d504d67d9c71/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3035.02 ((SQLServer2017-CU9-GDR).180707-0051)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/2fed6d1f4fc74711a8088b94f98d10062/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3035.02 ((SQLServer2017-CU9-GDR).180707-0051)
```

# SQL Server 2017 RTM CU9 - 14.0.3030.27 - x64 (KB4341265)
``` powershell
# SQL Server 2017 RTM CU9 - 14.0.3030.27 - x64 (KB4341265)
$outputFolder = 'c:\sqlsyms\14.0.3030.27\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/66034bb7692f47b68d91508392748a702/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3030.27 ((SQLServer2017-CU9).180630-0026)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/cd0f72d319dd45b48226d59a0a4d1b942/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3030.27 ((SQLServer2017-CU9).180630-0026)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/d62f64ac53a647e4a5be66a50a609f542/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3030.27 ((SQLServer2017-CU9).180630-0026)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/cd65ee0c97594540ac37cf1346fd46072/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3030.27 ((SQLServer2017-CU9).180630-0026)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/20879ea42b6046c6ac042fd5917732433/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3030.27 ((SQLServer2017-CU9).180630-0026)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/ffcd6d3fd4724d65b7f0c3c1dcd3bbbc2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3030.27 ((SQLServer2017-CU9).180630-0026)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/9af640605b0941d9b7934ab9eea3acdd1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3030.27 ((SQLServer2017-CU9).180630-0026)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/31ea27e79fc14bb991e62f4060d7c3a81/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3030.27 ((SQLServer2017-CU9).180630-0026)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/7805edcb819f4e70ab4d14520165787f1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3030.27 ((SQLServer2017-CU9).180630-0026)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/097b87a6547a4e8d87b2f63f8b514e0b1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3030.27 ((SQLServer2017-CU9).180630-0026)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/764a2e690ea84ab3943f336482774e932/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3030.27 ((SQLServer2017-CU9).180630-0026)
```

# SQL Server 2017 RTM CU8 - 14.0.3029.16 - x64 (KB4338363)
``` powershell
# SQL Server 2017 RTM CU8 - 14.0.3029.16 - x64 (KB4338363)
$outputFolder = 'c:\sqlsyms\14.0.3029.16\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/5525b238911a499ca15f316ab6c962822/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3029.16 ((SQLServer2017-CU8).180613-1911)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/1399d2afb4264c55b70e45f70f798bf22/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3029.16 ((SQLServer2017-CU8).180613-1911)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/c50bc63f8aee470a99e4662f43e0d0522/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3029.16 ((SQLServer2017-CU8).180613-1911)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/35d0d8eb3c1c437ba654cb78cd4fa1e62/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3029.16 ((SQLServer2017-CU8).180613-1911)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/e2ba4bb806624faa8bbacdae707e61163/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3029.16 ((SQLServer2017-CU8).180613-1911)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/404b3fcd8cc841ccbe0003b3dfb189f02/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3029.16 ((SQLServer2017-CU8).180613-1911)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/281f91e3d7d14f3faaa9992d00ba32991/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3029.16 ((SQLServer2017-CU8).180613-1911)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/28abba31fdde432389c3beb6641c86b61/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3029.16 ((SQLServer2017-CU8).180613-1911)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/10393de02ddd42ae80046a075942ed4b1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3029.16 ((SQLServer2017-CU8).180613-1911)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/3ed5a913bd7f49e4b00d13e1e0d96bd01/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3029.16 ((SQLServer2017-CU8).180613-1911)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/78fd9b633d9d4f15b3fa6cef32db99d72/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3029.16 ((SQLServer2017-CU8).180613-1911)
```

# SQL Server 2017 RTM CU7 - 14.0.3026.27 - x64 (KB4229789)
``` powershell
# SQL Server 2017 RTM CU7 - 14.0.3026.27 - x64 (KB4229789)
$outputFolder = 'c:\sqlsyms\14.0.3026.27\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/10da85787e1149a58e60e6c0b2c7a1552/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3026.27 ((SQLServer2017-CU7).180510-1901)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/65dcd0640108491a9e0de5ed8058f1fb2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3026.27 ((SQLServer2017-CU7).180510-1901)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/293ecb04af0f483b898462dba64e945a2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3026.27 ((SQLServer2017-CU7).180510-1901)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/3799cfd261564e5ba73053afe3e0b60c2/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3026.27 ((SQLServer2017-CU7).180510-1901)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/c236c6b5eced44c3a22b1b7779f989d33/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3026.27 ((SQLServer2017-CU7).180510-1901)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/8d9a1bacfae04c508cd2852cfc3d4e912/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3026.27 ((SQLServer2017-CU7).180510-1901)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/6fc5beab5b2b42d9b0575f3e384038f51/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3026.27 ((SQLServer2017-CU7).180510-1901)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/946a419bcbcc44d08c05275adfb3dbc01/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3026.27 ((SQLServer2017-CU7).180510-1901)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/ed1e63b89e7743619a7f541d831943f01/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3026.27 ((SQLServer2017-CU7).180510-1901)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/2747080059f64f4ba2a97a69287d05e51/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3026.27 ((SQLServer2017-CU7).180510-1901)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/37b0126ce3264429b7a3070d9c7ca29d2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3026.27 ((SQLServer2017-CU7).180510-1901)
```

# SQL Server 2017 RTM CU6 - 14.0.3025.34 - x64 (KB4101464)
``` powershell
# SQL Server 2017 RTM CU6 - 14.0.3025.34 - x64 (KB4101464)
$outputFolder = 'c:\sqlsyms\14.0.3025.34\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/a98a782c58784e29bbaa2c211b0f5c682/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3025.34 ((SQLServer2017-CU6).180410-0033)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/f24aacbfad9e414285f7046d1d48d2be2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3025.34 ((SQLServer2017-CU6).180410-0033)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/42522ba8c70843a89dd2cbe8af1bb4b32/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3025.34 ((SQLServer2017-CU6).180410-0033)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/b4e8225ee505470da1c3ae7cd8b872e12/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3025.34 ((SQLServer2017-CU6).180410-0033)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/02573056bbd745149600abc3fda59b873/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3025.34 ((SQLServer2017-CU6).180410-0033)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/75e13c8cab1140ff95e0a8be1561e5f52/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3025.34 ((SQLServer2017-CU6).180410-0033)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/e9265ab70bc24f7892140a0c56c8fff71/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3025.34 ((SQLServer2017-CU6).180410-0033)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/0b7a9ff5214245c7935cedb57471d2b71/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3025.34 ((SQLServer2017-CU6).180410-0033)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/99e106f3dc9d4485910ca051be7c7ead1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3025.34 ((SQLServer2017-CU6).180410-0033)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/ebfd29864c4549c48179f4a037ac91271/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3025.34 ((SQLServer2017-CU6).180410-0033)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/ae60023494ff4dd7a992cde1dbedd2d52/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3025.34 ((SQLServer2017-CU6).180410-0033)
```

# SQL Server 2017 RTM CU5 - 14.0.3023.8 - x64 (KB4092643)
``` powershell
# SQL Server 2017 RTM CU5 - 14.0.3023.8 - x64 (KB4092643)
$outputFolder = 'c:\sqlsyms\14.0.3023.8\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/109e36e55c01403497cc5d50c579d8532/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3023.08 ((SQLServer2017-CU5).180302-2330)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/bddaac25fb1f426da61e50a94d7fc9ab2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3023.08 ((SQLServer2017-CU5).180302-2330)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/b1507220d6954a02a8b70fc6a55ef15a2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3023.08 ((SQLServer2017-CU5).180302-2330)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/3741e4701fc3405b96394985517ff8a02/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3023.08 ((SQLServer2017-CU5).180302-2330)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/ac8d8709958847f8a0acfc7d842689343/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3023.08 ((SQLServer2017-CU5).180302-2330)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/b32f21bc37674e1b935d03ad80b368f42/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3023.08 ((SQLServer2017-CU5).180302-2330)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/457d193fc3f44383aceee37f22beb4ee1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3023.08 ((SQLServer2017-CU5).180302-2330)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/6051c5232f1b45d7add16da0ffbd40561/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3023.08 ((SQLServer2017-CU5).180302-2330)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/ae5d32ddd37e4201b4deb372cd8eeace1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3023.08 ((SQLServer2017-CU5).180302-2330)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/ab8e5af83878473e9872fa70607103c91/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3023.08 ((SQLServer2017-CU5).180302-2330)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/691d47cd1fe84e27beecb625888885242/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3023.08 ((SQLServer2017-CU5).180302-2330)
```

# SQL Server 2017 RTM CU4 - 14.0.3022.28 - x64 (KB4056498)
``` powershell
# SQL Server 2017 RTM CU4 - 14.0.3022.28 - x64 (KB4056498)
$outputFolder = 'c:\sqlsyms\14.0.3022.28\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/57d7c3c8a5d0448e80136b24d0fff1c32/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3022.28 ((SQLServer2017-CU1).180209-2025)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/d579a66e0be244f4933f70d895ea0ca72/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3022.28 ((SQLServer2017-CU1).180209-2025)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/3b96d064c2a7446b8bf27f889a05c5f82/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3022.28 ((SQLServer2017-CU1).180209-2025)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/c0a46b4eda834af696bc62f1f25d2ed12/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3022.28 ((SQLServer2017-CU1).180209-2025)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/98358edb8975452a950cf30afd43dacb3/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3022.28 ((SQLServer2017-CU1).180209-2025)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/d2356ed3f2a54cd39d5b0d6c67c270b02/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3022.28 ((SQLServer2017-CU1).180209-2025)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/374a04e072bc477297ac9c32d1cec4761/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3022.28 ((SQLServer2017-CU1).180209-2025)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/ae215b6a707a4db08bc6442bd43ac11c1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3022.28 ((SQLServer2017-CU1).180209-2025)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/076f3b18167d41edbd98e8898113cad41/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3022.28 ((SQLServer2017-CU1).180209-2025)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/69e152bad2594a2cb66eaeeaa412f1611/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3022.28 ((SQLServer2017-CU1).180209-2025)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/6061b66f34624106bafd4ee77d938d8f2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3022.28 ((SQLServer2017-CU1).180209-2025)
```

# SQL Server 2017 RTM CU3 - 14.0.3015.40 - x64 (KB4052987)
``` powershell
# SQL Server 2017 RTM CU3 - 14.0.3015.40 - x64 (KB4052987)
$outputFolder = 'c:\sqlsyms\14.0.3015.40\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/fd63f54995484f9cada261048b448e362/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3015.40 ((SQLServer2017-CU1).171222-2334)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/8e5e48eb780a41c496ec3aff3e0470dd2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3015.40 ((SQLServer2017-CU1).171222-2334)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/b882d062f0ae4f3a826bdae177e2f6ae2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3015.40 ((SQLServer2017-CU1).171222-2334)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/a56fa639b1be44b791f33e70221a74d42/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3015.40 ((SQLServer2017-CU1).171222-2334)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/35e6d755c08b44dea0288b8f4c8be7e33/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3015.40 ((SQLServer2017-CU1).171222-2334)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/a90c29baa7a945e79a5f316c1c016de92/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3015.40 ((SQLServer2017-CU1).171222-2334)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/a1723bbc5db04c588a7c8090f24732931/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3015.40 ((SQLServer2017-CU1).171222-2334)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/84fb90a5783b4d3da9f829e36dd5e4f11/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3015.40 ((SQLServer2017-CU1).171222-2334)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/72cc987076974daead0760fbfc9e06dc1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3015.40 ((SQLServer2017-CU1).171222-2334)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/8041f1f6e7894ae08d6acdd1ed3988d91/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3015.40 ((SQLServer2017-CU1).171222-2334)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/422ffe74342b4124ac700e11127116952/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3015.40 ((SQLServer2017-CU1).171222-2334)
```

# SQL Server 2017 RTM CU2 - 14.0.3008.27 - x64 (KB4052574)
``` powershell
# SQL Server 2017 RTM CU2 - 14.0.3008.27 - x64 (KB4052574)
$outputFolder = 'c:\sqlsyms\14.0.3008.27\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/3138403f1ce44cc1969afc40973749f12/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3008.27 ((SQLServer2017-CU1).171116-1722)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/f1a833a2d2c34202b7302121de112bd32/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3008.27 ((SQLServer2017-CU1).171116-1722)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/40d5a1efad844abfa5a689f2e49153e12/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3008.27 ((SQLServer2017-CU1).171116-1722)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/a1dfaae5bf0f4d5691487e1d7ca137fe2/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3008.27 ((SQLServer2017-CU1).171116-1722)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/abc003696f9c4269b13c4e246bd6d10e2/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3008.27 ((SQLServer2017-CU1).171116-1722)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/8d19325e37f34ec5b6f4ebe1ea29978e2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3008.27 ((SQLServer2017-CU1).171116-1722)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/9496aab8e37448c5ad97fde8635a3d201/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3008.27 ((SQLServer2017-CU1).171116-1722)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/d984365873cb4a10a728e6f95b206aef1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3008.27 ((SQLServer2017-CU1).171116-1722)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/5c90a79531e94e37ba58d8993b04e1201/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3008.27 ((SQLServer2017-CU1).171116-1722)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/edcf09de5c5a482991e58e26301562341/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3008.27 ((SQLServer2017-CU1).171116-1722)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/11a2d383108e4e49bac7214a5c4e7c2e2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3008.27 ((SQLServer2017-CU1).171116-1722)
```

# SQL Server 2017 RTM CU1 - 14.0.3006.16 - x64 (KB4038634)
``` powershell
# SQL Server 2017 RTM CU1 - 14.0.3006.16 - x64 (KB4038634)
$outputFolder = 'c:\sqlsyms\14.0.3006.16\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/87eba05ec89242d9927509fa7cd4df222/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.3006.16 ((SQLServer2017-CU1).171019-0548)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/e801003d9d0e480aaf2a9961f14722be2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.3006.16 ((SQLServer2017-CU1).171019-0548)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/5eb2d9b1ed7647099675595f5c1af9542/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.3006.16 ((SQLServer2017-CU1).171019-0548)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/dfeb0841aebc48fc92d2ebce8243d6b02/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.3006.16 ((SQLServer2017-CU1).171019-0548)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/133d9c8bada14ea89a11c0c505f8c2412/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.3006.16 ((SQLServer2017-CU1).171019-0548)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/c7ef60b6dc0c4068a48974e6dcf589e42/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.3006.16 ((SQLServer2017-CU1).171019-0548)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/e1feb096228e45b4ad3fd948d10b06f21/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.3006.16 ((SQLServer2017-CU1).171019-0548)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/fc74cd37bd3c40f1a63232f24b9861621/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.3006.16 ((SQLServer2017-CU1).171019-0548)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/88d42585c0844b0493b3383459c778cb1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.3006.16 ((SQLServer2017-CU1).171019-0548)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/85149cd8bce34a5d80e738205084b92a1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.3006.16 ((SQLServer2017-CU1).171019-0548)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/641d7dfd397d4232a6cf7ccc61db3ec32/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.3006.16 ((SQLServer2017-CU1).171019-0548)
```

# SQL Server 2017 RTM GDR - 14.0.2014.14 - x64 (KB4494351)
``` powershell
# SQL Server 2017 RTM GDR - 14.0.2014.14 - x64 (KB4494351)
$outputFolder = 'c:\sqlsyms\14.0.2014.14\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/3b83b1a537f04ab3a16e88432d682bcb2/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.2014.14 ((SQL17_RTM_GDR).190405-1545)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/d72fae04d4364d2f9fddc737646f1baa2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.2014.14 ((SQL17_RTM_GDR).190405-1545)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/51b6292d90284698b26fd5785f1470cd2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.2014.14 ((SQL17_RTM_GDR).190405-1545)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/74cac1ac260d4f90b5c2e3d16bd2e1fa2/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.2014.14 ((SQL17_RTM_GDR).190405-1545)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/bf2dc2594f0045b287cf32f04ea6dc033/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.2014.14 ((SQL17_RTM_GDR).190405-1545)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/1f4bea33f4a44fcbbb2ed8b1b636dc442/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.2014.14 ((SQL17_RTM_GDR).190405-1545)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/962db9f1c6a34d7bb306a6b5a9eb43821/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.2014.14 ((SQL17_RTM_GDR).190405-1545)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/20bb3d988bee43fa8b73251c97892d9b1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.2014.14 ((SQL17_RTM_GDR).190405-1545)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/1cab94f0f12f4c0dafd50eaf20df7ae51/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.2014.14 ((SQL17_RTM_GDR).190405-1545)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/a54634c716264671ad9b42292c6d6c751/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.2014.14 ((SQL17_RTM_GDR).190405-1545)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/408c96c6da754a7f9ea16fd4e961910c2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.2014.14 ((SQL17_RTM_GDR).190405-1545)
```

# SQL Server 2017 RTM GDR - 14.0.2002.14 - x64 (KB4293803)
``` powershell
# SQL Server 2017 RTM GDR - 14.0.2002.14 - x64 (KB4293803)
$outputFolder = 'c:\sqlsyms\14.0.2002.14\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/eede151a1fe14c888e12bd2cd18499342/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.2002.14 ((SQL17_RTM_GDR).180721-1410)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/1365eb638bb547fb8dda02460ccb1db32/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.2002.14 ((SQL17_RTM_GDR).180721-1410)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/3d765ec46087444a99857a8850ed91612/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.2002.14 ((SQL17_RTM_GDR).180721-1410)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/59c28b768a1a468d9a1d7c9e3e86c8792/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.2002.14 ((SQL17_RTM_GDR).180721-1410)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/c51ed42364994190bde46cadad32bfcc3/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.2002.14 ((SQL17_RTM_GDR).180721-1410)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/67fa8e005f9e4dd5aa0f1eecd911e9fd2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.2002.14 ((SQL17_RTM_GDR).180721-1410)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/0f1a7721cd8e47319fec23bdc5ec7b911/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.2002.14 ((SQL17_RTM_GDR).180721-1410)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/3ae9ebe14179453fa16c7790e4468c0a1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.2002.14 ((SQL17_RTM_GDR).180721-1410)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/1986c63f87fd4b93aecba08c176afb911/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.2002.14 ((SQL17_RTM_GDR).180721-1410)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/5b3e2b01fca64473b86112687e9633b51/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.2002.14 ((SQL17_RTM_GDR).180721-1410)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/c11351f7ec7643bfa04d930c29d6d4872/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.2002.14 ((SQL17_RTM_GDR).180721-1410)
```

# SQL Server 2017 RTM GDR - 14.0.2000.63 - x64 (KB4057122)
``` powershell
# SQL Server 2017 RTM GDR - 14.0.2000.63 - x64 (KB4057122)
$outputFolder = 'c:\sqlsyms\14.0.2000.63\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/48cf4690e5f34376afb5a53a8f8ab45d2/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.2000.63 ((SQL17_RTM_GDR).171222-2325)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/efc35e061a2a4daf97ee2bac1f6a96302/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.2000.63 ((SQL17_RTM_GDR).171222-2325)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/59f051256d4743af8f758d0645475b962/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.2000.63 ((SQL17_RTM_GDR).171222-2325)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/5e35faefffe6499b9489c56f061d804e2/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.2000.63 ((SQL17_RTM_GDR).171222-2325)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/989ba51ed4984d1e8df0b1653ecaf3fc3/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.2000.63 ((SQL17_RTM_GDR).171222-2325)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/20e66bce4c7f42f5837a7e65b84e7a742/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.2000.63 ((SQL17_RTM_GDR).171222-2325)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/db011824808740f7b2bdc935fde6ea301/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.2000.63 ((SQL17_RTM_GDR).171222-2325)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/77a3acda141547c1a6c80fdd4417d3651/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.2000.63 ((SQL17_RTM_GDR).171222-2325)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/177b8b95f7254a86a9eb266863bccfb01/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.2000.63 ((SQL17_RTM_GDR).171222-2325)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/77e3bb72b6cb4714aafd8f36cfceccfe1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.2000.63 ((SQL17_RTM_GDR).171222-2325)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/4b38c81bae244806938fe19e14dfbf2e2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.2000.63 ((SQL17_RTM_GDR).171222-2325)
```

# SQL Server 2017 RTM RTM - 14.0.1000.169 - x64 (NA)
``` powershell
# SQL Server 2017 RTM RTM - 14.0.1000.169 - x64 (NA)
$outputFolder = 'c:\sqlsyms\14.0.1000.169\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/3cbcf6039e774ef7b3216ad46ed66e162/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2017.0140.1000.169 ((SQLServer).170822-2340)
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/f188529c1026441ea07ad838452c34832/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2017.0140.1000.169 ((SQLServer).170822-2340)
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/a93a74f3276b4f14a8a57d6b42bf8ae22/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2017.0140.1000.169 ((SQLServer).170822-2340)
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/e0a351d14abe45afbaef64d1f88cc9fa2/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2017.0140.1000.169 ((SQLServer).170822-2340)
if (-not (Test-Path "$outputFolder\sqlaccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlaccess.pdb/7db97580232143a99f64077925f11a9d3/sqlaccess.pdb' -OutFile "$outputFolder\sqlaccess.pdb" } # File version 2017.0140.1000.169 ((SQLServer).170822-2340)
if (-not (Test-Path "$outputFolder\qds.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/qds.pdb/7be72e22126e41a0ba4a1589d22db4ef2/qds.pdb' -OutFile "$outputFolder\qds.pdb" } # File version 2017.0140.1000.169 ((SQLServer).170822-2340)
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/a042792795f74ae093210433b2ef4f5c1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2017.0140.1000.169 ((SQLServer).170822-2340)
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/79032174ef0b4f9eac01826df8f5334f1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2017.0140.1000.169 ((SQLServer).170822-2340)
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/2cf7210d69f34a5484c0aa7010921c501/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2017.0140.1000.169 ((SQLServer).170822-2340)
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/e1b7563a29b445e6aec1dc8739824fa61/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2017.0140.1000.169 ((SQLServer).170822-2340)
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/2270ab48523147ce8c3aa44993fb31bb2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2017.0140.1000.169 ((SQLServer).170822-2340)
```

