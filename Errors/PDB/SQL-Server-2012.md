# SQL Server 2012 SP4 Security update - 11.0.7493.4 - x64 (4532098)
``` powershell
# SQL Server 2012 SP4 Security update - 11.0.7493.4 - x64 (4532098)
$outputFolder = 'c:\sqlsyms\11.0.7493.4\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/480435d60ca54ce381ec0e8a0a0d76a02/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.7493.04 ((SQL11_SP4_QFE-OD).191224-1917 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/e6c9aa0810194fa6b574b7215b217af72/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.7493.04 ((SQL11_SP4_QFE-OD).191224-1917 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/7a4a97665c58401780368d29ee631ccd2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.7493.04 ((SQL11_SP4_QFE-OD).191224-1917 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/43b4e82b3c66419e8b35da8d9257b3ff2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.7493.04 ((SQL11_SP4_QFE-OD).191224-1917 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/295ba2e5d3194ca5b61b7b31d7c079c11/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.7493.04 ((SQL11_SP4_QFE-OD).191224-1917 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/ae89899ab121405083d262de6e8846961/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.7493.04 ((SQL11_SP4_QFE-OD).191224-1917 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/d20221dff4c941c087921649121052281/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.7493.04 ((SQL11_SP4_QFE-OD).191224-1917 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/b08ffbd94e4b4e17bb1e39045f524abb1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.7493.04 ((SQL11_SP4_QFE-OD).191224-1917 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/da346c631b6e46e7b56825f235d89c561/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.7493.04 ((SQL11_SP4_QFE-OD).191224-1917 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/50c405e5402b43e7a5ef91788f6ef43f2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.7493.04 ((SQL11_SP4_QFE-OD).191224-1917 )
```

# SQL Server 2012 SP4 Security update - 11.0.7493.4 - x86 (4532098)
``` powershell
# SQL Server 2012 SP4 Security update - 11.0.7493.4 - x86 (4532098)
$outputFolder = 'c:\sqlsyms\11.0.7493.4\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/ba8f818630714eb7b381ec0649b061302/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.7493.04 ((SQL11_SP4_QFE-OD).191224-2006 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/7e0415dd919840948ef712d61810daec2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.7493.04 ((SQL11_SP4_QFE-OD).191224-2006 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/68d681fcf4c64f9b883f8512ccdfd05e2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.7493.04 ((SQL11_SP4_QFE-OD).191224-2006 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/30dd863e703c4fa8b9cafd898a9495cf2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.7493.04 ((SQL11_SP4_QFE-OD).191224-2006 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/de5513fd8b1c4fb6b91efe477704b14a1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.7493.04 ((SQL11_SP4_QFE-OD).191224-2006 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/96552da4ca10465c9c33b981bde24ccb1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.7493.04 ((SQL11_SP4_QFE-OD).191224-2006 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/1b99718314a84b3fa7f5d532b463f1701/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.7493.04 ((SQL11_SP4_QFE-OD).191224-2006 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/e5470f778c574450bcdfff21a91b739f1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.7493.04 ((SQL11_SP4_QFE-OD).191224-2006 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/ade3c305ff2c46cd845c19b14deb5aff1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.7493.04 ((SQL11_SP4_QFE-OD).191224-2006 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/339831825ec24abcb2fc18813066d2e82/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.7493.04 ((SQL11_SP4_QFE-OD).191224-2006 )
```

# SQL Server 2012 SP4 Hotfix 4091266 - 11.0.7469.6 - x64 (4091266)
``` powershell
# SQL Server 2012 SP4 Hotfix 4091266 - 11.0.7469.6 - x64 (4091266)
$outputFolder = 'c:\sqlsyms\11.0.7469.6\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/0f91402cd2414afc9a2e81c7af9af9f32/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.7469.06 ((SQL11_PCU_Main).180228-1732 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/514d1b21c758466fa5812d26da1b58de2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.7469.06 ((SQL11_PCU_Main).180228-1732 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/398932bbfb424772b785fed83bae34442/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.7469.06 ((SQL11_PCU_Main).180228-1732 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/c7875e26c11e47b2809ce5aa66cbb7662/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.7469.06 ((SQL11_PCU_Main).180228-1732 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/9b08807bc3514172b8d1a18707f257ca1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.7469.06 ((SQL11_PCU_Main).180228-1732 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/57a1333981da48e5be28cd275e871d811/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.7469.06 ((SQL11_PCU_Main).180228-1732 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/2b1e43f05e0547cfb3217e369e0ed18d1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.7469.06 ((SQL11_PCU_Main).180228-1732 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/d244e857cc9e4109b38ae22f6fb04fe71/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.7469.06 ((SQL11_PCU_Main).180228-1732 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/94e0b5323ed6420ba2baef29da5dba1e1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.7469.06 ((SQL11_PCU_Main).180228-1732 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/64a2e4d6a3b64ea28cca819f9e247d7c2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.7469.06 ((SQL11_PCU_Main).180228-1732 )
```

# SQL Server 2012 SP4 Hotfix 4091266 - 11.0.7469.6 - x86 (4091266)
``` powershell
# SQL Server 2012 SP4 Hotfix 4091266 - 11.0.7469.6 - x86 (4091266)
$outputFolder = 'c:\sqlsyms\11.0.7469.6\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/a95e440af92540b7a0216cca28c2e8b62/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.7469.06 ((SQL11_PCU_Main).180228-1732 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/db6f725509df4ae384ffdca7d0b9eae32/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.7469.06 ((SQL11_PCU_Main).180228-1732 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/ef46921b8c7b447a8c115beb669e311c2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.7469.06 ((SQL11_PCU_Main).180228-1732 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/f0fe075e9ebd4c29af2de0a8e1b1158e2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.7469.06 ((SQL11_PCU_Main).180228-1732 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/d888cccc0fc440eeab4c46a2501cd7521/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.7469.06 ((SQL11_PCU_Main).180228-1732 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/0715c52891824ecb88d15cb3786666211/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.7469.06 ((SQL11_PCU_Main).180228-1732 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/2f26128d326c4a6cbb38596802231c491/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.7469.06 ((SQL11_PCU_Main).180228-1732 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/398336b2642b40a4bf1c2b5cc2a7b6bf1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.7469.06 ((SQL11_PCU_Main).180228-1732 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/10d83224d37e4629908ef64a9724085b1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.7469.06 ((SQL11_PCU_Main).180228-1732 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/b423cb4eaac6424a9c4006d044788cc82/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.7469.06 ((SQL11_PCU_Main).180228-1732 )
```

# SQL Server 2012 SP4 Security update - 11.0.7462.6 - x64 (4057116)
``` powershell
# SQL Server 2012 SP4 Security update - 11.0.7462.6 - x64 (4057116)
$outputFolder = 'c:\sqlsyms\11.0.7462.6\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/97bc282def8043728f8e03d389c56c852/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.7462.06 ((SQL11_PCU_Main).180105-2156 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/91c7c41bb798485595f5be3f1b3125e92/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.7462.06 ((SQL11_PCU_Main).180105-2156 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/c31145b788cb4a25b9afbc0907f55d722/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.7462.06 ((SQL11_PCU_Main).180105-2156 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/93e6f4ad739547b786cfddf1ead5f54f2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.7462.06 ((SQL11_PCU_Main).180105-2156 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/d33e11ce15dc404d815419cc6dcae2ec1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.7462.06 ((SQL11_PCU_Main).180105-2156 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/9bccf357c8564d61bebfd5cdaeddf9231/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.7462.06 ((SQL11_PCU_Main).180105-2156 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/a2f77318440043c2a75db65201a507911/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.7462.06 ((SQL11_PCU_Main).180105-2156 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/169fdc950daa4b918c5f998625fe01861/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.7462.06 ((SQL11_PCU_Main).180105-2156 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/73dab384b2554d8792c8540ff7a066cb1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.7462.06 ((SQL11_PCU_Main).180105-2156 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/9f5d751b247a4d8884a6c9a5e582dffa2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.7462.06 ((SQL11_PCU_Main).180105-2156 )
```

# SQL Server 2012 SP4 Security update - 11.0.7462.6 - x86 (4057116)
``` powershell
# SQL Server 2012 SP4 Security update - 11.0.7462.6 - x86 (4057116)
$outputFolder = 'c:\sqlsyms\11.0.7462.6\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/31d8d73fc89d494481d3ea3bc23d664c2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.7462.06 ((SQL11_PCU_Main).180105-2153 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/dc4b8738e9c040dca6bda5c19fa15d782/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.7462.06 ((SQL11_PCU_Main).180105-2153 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/9148265be6de4d2f9cbc17085dfd2d252/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.7462.06 ((SQL11_PCU_Main).180105-2153 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/3e0a1ca4d3c343bfbb273258041819952/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.7462.06 ((SQL11_PCU_Main).180105-2153 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/cdf3c5fdc15b43f98eb1a8da3c73c7e31/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.7462.06 ((SQL11_PCU_Main).180105-2153 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/1ebe506aeb6b47b38cc5e514fff18f821/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.7462.06 ((SQL11_PCU_Main).180105-2153 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/47e45abe752b453b833d5bed81c4ce231/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.7462.06 ((SQL11_PCU_Main).180105-2153 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/837fc489e2924037a2c108fd7bf90ffa1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.7462.06 ((SQL11_PCU_Main).180105-2153 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/f6e02bcf4295487995a04701333076431/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.7462.06 ((SQL11_PCU_Main).180105-2153 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/ede3587ca5ea4080a4bf758895d0fdb82/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.7462.06 ((SQL11_PCU_Main).180105-2153 )
```

# SQL Server 2012 SP4 SP4 - 11.0.7001.0 - x64 (4018073)
``` powershell
# SQL Server 2012 SP4 SP4 - 11.0.7001.0 - x64 (4018073)
$outputFolder = 'c:\sqlsyms\11.0.7001.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/d037a5a441e9428386cb7b6ccda51df82/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.7001.00 ((SQL11_PCU_Main).170815-1011 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/61a529bd489946bf98c89d9f471a16032/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.7001.00 ((SQL11_PCU_Main).170815-1011 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/0a1268b6e5ad41e6948f59c193c952d52/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.7001.00 ((SQL11_PCU_Main).170815-1011 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/ab769d65e88c454f9cf7bfb804bc3be12/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.7001.00 ((SQL11_PCU_Main).170815-1011 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/cc41b4cad8244f08ab3662e2572863e61/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.7001.00 ((SQL11_PCU_Main).170815-1011 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/b55075b250fe4c2190f26dd98b740c091/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.7001.00 ((SQL11_PCU_Main).170815-1011 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/f360c904a13349cab685811cc7eb5f1b1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.7001.00 ((SQL11_PCU_Main).170815-1011 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/90455f51040c4fccb89a9664c3cba4191/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.7001.00 ((SQL11_PCU_Main).170815-1011 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/c87b18fbc7da4990a51487628770c54e1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.7001.00 ((SQL11_PCU_Main).170815-1011 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/2d2b68a253924aeea6931cd5801d56b52/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.7001.00 ((SQL11_PCU_Main).170815-1011 )
```

# SQL Server 2012 SP4 SP4 - 11.0.7001.0 - x86 (4018073)
``` powershell
# SQL Server 2012 SP4 SP4 - 11.0.7001.0 - x86 (4018073)
$outputFolder = 'c:\sqlsyms\11.0.7001.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/1f36dddd3d7d43eb9626cc5adbaa603c2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.7001.00 ((SQL11_PCU_Main).170815-1005 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/f82f4ae4a2e74ae59338143499fdfd7a2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.7001.00 ((SQL11_PCU_Main).170815-1005 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/11692631f68842a3b597ba39bef3c2432/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.7001.00 ((SQL11_PCU_Main).170815-1005 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/ab9f6918064040508165482354a196de2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.7001.00 ((SQL11_PCU_Main).170815-1005 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/52059b5d64564a1b935825899d6a09511/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.7001.00 ((SQL11_PCU_Main).170815-1005 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/7fbd676ecf644930ab812a23884186861/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.7001.00 ((SQL11_PCU_Main).170815-1005 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/79bd0035ebe24240b8b71405d0e9fc3f1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.7001.00 ((SQL11_PCU_Main).170815-1005 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/82c1e0b607b547f4a81d2dfe719c4cba1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.7001.00 ((SQL11_PCU_Main).170815-1005 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/039700e384e2462d9a74eeae3864859d1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.7001.00 ((SQL11_PCU_Main).170815-1005 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/fbc3c51cbd1149ecbd8fcfb23aeee3b62/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.7001.00 ((SQL11_PCU_Main).170815-1005 )
```

# SQL Server 2012 SP3 CU9 - 11.0.6598.0 - x64 (4016762)
``` powershell
# SQL Server 2012 SP3 CU9 - 11.0.6598.0 - x64 (4016762)
$outputFolder = 'c:\sqlsyms\11.0.6598.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/109c9b322c6c41aaad2d6361ed344ad02/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.6598.00 ((SQL11_SP3_QFE-CU).170418-1648 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/e734e7142f47477eac0a02a531dffe772/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.6598.00 ((SQL11_SP3_QFE-CU).170418-1648 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/5c5a450a77764195a5f87d2aeffd8bd12/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.6598.00 ((SQL11_SP3_QFE-CU).170418-1648 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/7e4bfbdc22c1487cb147642e9d46f8c02/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.6598.00 ((SQL11_SP3_QFE-CU).170418-1648 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/bb02986cda794e5ca7cb081fc9bad8c21/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.6598.00 ((SQL11_SP3_QFE-CU).170418-1648 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/d3eeb1dd8e65453a91ac3ca57199fa231/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.6598.00 ((SQL11_SP3_QFE-CU).170418-1648 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/fd9f36440ccb405aa49a1d713b1f46431/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.6598.00 ((SQL11_SP3_QFE-CU).170418-1648 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/1e76ae5f488f4e249247bcc0a7c951c01/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.6598.00 ((SQL11_SP3_QFE-CU).170418-1648 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/c11a2afc0ae9480db528fc501f88f73a1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.6598.00 ((SQL11_SP3_QFE-CU).170418-1648 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/d82c7ee189224510a7b11cbab2acc87a2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.6598.00 ((SQL11_SP3_QFE-CU).170418-1648 )
```

# SQL Server 2012 SP3 CU9 - 11.0.6598.0 - x86 (4016762)
``` powershell
# SQL Server 2012 SP3 CU9 - 11.0.6598.0 - x86 (4016762)
$outputFolder = 'c:\sqlsyms\11.0.6598.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/708b17ec74154260be962ee64c2c9f7e2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.6598.00 ((SQL11_SP3_QFE-CU).170418-1707 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/45fca01235c64d0f91cf52c1b2c7b6682/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.6598.00 ((SQL11_SP3_QFE-CU).170418-1707 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/6e4b601d5f804d759f96a435d76a062b2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.6598.00 ((SQL11_SP3_QFE-CU).170418-1707 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/b3795d33240a4a27a70c2221f1f5b91f2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.6598.00 ((SQL11_SP3_QFE-CU).170418-1707 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/f4140814836d4d5284231a6d242860381/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.6598.00 ((SQL11_SP3_QFE-CU).170418-1707 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/b3254f3a7f6f4d548b7a2587b420fb681/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.6598.00 ((SQL11_SP3_QFE-CU).170418-1707 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/d3ec35abc942485580a9d1673071e1b31/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.6598.00 ((SQL11_SP3_QFE-CU).170418-1707 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/85152ea7467b4c35971b9799e7f030831/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.6598.00 ((SQL11_SP3_QFE-CU).170418-1707 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/347f6b20b1a5478781c229edc12b2cf41/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.6598.00 ((SQL11_SP3_QFE-CU).170418-1707 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/4b8824881bc7405588c795aa867da2472/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.6598.00 ((SQL11_SP3_QFE-CU).170418-1707 )
```

# SQL Server 2012 SP3 CU7 - 11.0.6579.0 - x64 (3205051)
``` powershell
# SQL Server 2012 SP3 CU7 - 11.0.6579.0 - x64 (3205051)
$outputFolder = 'c:\sqlsyms\11.0.6579.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/28783150f1ee4dbf92e0499225b7590c2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.6579.00 ((SQL11_SP3_QFE-CU).161222-1109 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/b35286f6930c49498baee55c30e567e12/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.6579.00 ((SQL11_SP3_QFE-CU).161222-1109 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/a4af12434c9a45f4af825680e48e5bc22/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.6579.00 ((SQL11_SP3_QFE-CU).161222-1109 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/2202396e27904e5db4fcd4d60aebdd772/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.6579.00 ((SQL11_SP3_QFE-CU).161222-1109 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/32a77bfd1d1b4845883d79c8419052921/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.6579.00 ((SQL11_SP3_QFE-CU).161222-1109 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/100c11aaf13440b680b44057155c2ef21/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.6579.00 ((SQL11_SP3_QFE-CU).161222-1109 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/cb2b6dce02bd40c996cd811ce13ea91a1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.6579.00 ((SQL11_SP3_QFE-CU).161222-1109 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/5c5db77e2d364209a0f61fda02088cf21/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.6579.00 ((SQL11_SP3_QFE-CU).161222-1109 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/fa9e7bd3ef9343f5b5fcca1334992d431/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.6579.00 ((SQL11_SP3_QFE-CU).161222-1109 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/c5b83c833f6a4c7281841b945028f8782/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.6579.00 ((SQL11_SP3_QFE-CU).161222-1109 )
```

# SQL Server 2012 SP3 CU7 - 11.0.6579.0 - x86 (3205051)
``` powershell
# SQL Server 2012 SP3 CU7 - 11.0.6579.0 - x86 (3205051)
$outputFolder = 'c:\sqlsyms\11.0.6579.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/8a904b0b2b754631a46c28eb44dd2efe2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.6579.00 ((SQL11_SP3_QFE-CU).161222-1119 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/661d636bc116485dbf546433cff31f072/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.6579.00 ((SQL11_SP3_QFE-CU).161222-1119 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/a2bbab93772a4b8b8a4000861e06f5b12/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.6579.00 ((SQL11_SP3_QFE-CU).161222-1119 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/c8e36c6acc1d4447a68859546378d0dd2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.6579.00 ((SQL11_SP3_QFE-CU).161222-1119 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/33976bc0acee45e6a5e6d085068c93f31/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.6579.00 ((SQL11_SP3_QFE-CU).161222-1119 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/18c8de6253374d52aad36a38b127f8661/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.6579.00 ((SQL11_SP3_QFE-CU).161222-1119 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/ae64e50371214599be4a3415deb52fbf1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.6579.00 ((SQL11_SP3_QFE-CU).161222-1119 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/ff1efd45c7b64eed9b641ac980799e6b1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.6579.00 ((SQL11_SP3_QFE-CU).161222-1119 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/5d6dcb597aec4881b9ee9a7a6bf96ba71/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.6579.00 ((SQL11_SP3_QFE-CU).161222-1119 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/b2a6eff3ff774b2e82486d092883df462/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.6579.00 ((SQL11_SP3_QFE-CU).161222-1119 )
```

# SQL Server 2012 SP3 CU6 - 11.0.6567.0 - x64 (3194992)
``` powershell
# SQL Server 2012 SP3 CU6 - 11.0.6567.0 - x64 (3194992)
$outputFolder = 'c:\sqlsyms\11.0.6567.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/bb6184470be14d70a6171a0abf7ff4142/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.6567.00 ((SQL11_SP3_QFE-CU).161010-1832 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/59c4ce23af154338a104308ac0cce6232/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.6567.00 ((SQL11_SP3_QFE-CU).161010-1832 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/add423f0ae3d49d195ce1edd7942d3ed2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.6567.00 ((SQL11_SP3_QFE-CU).161010-1832 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/e618e626a6594d009564091cabd9bc262/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.6567.00 ((SQL11_SP3_QFE-CU).161010-1832 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/ac3e5d1c334f413080dd816bf9d1467e1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.6567.00 ((SQL11_SP3_QFE-CU).161010-1832 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/8b09e558e267408eaeaf87a3a2ee37e71/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.6567.00 ((SQL11_SP3_QFE-CU).161010-1832 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/4f2f41869ac54e899e7ff39319663a651/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.6567.00 ((SQL11_SP3_QFE-CU).161010-1832 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/5c78860cf3644c0d89d0699bf3773bf11/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.6567.00 ((SQL11_SP3_QFE-CU).161010-1832 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/db583d5603bc474b8651922e71e401dc1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.6567.00 ((SQL11_SP3_QFE-CU).161010-1832 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/307d6d9eed7c4d5a953f485db595d2de2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.6567.00 ((SQL11_SP3_QFE-CU).161010-1832 )
```

# SQL Server 2012 SP3 CU6 - 11.0.6567.0 - x86 (3194992)
``` powershell
# SQL Server 2012 SP3 CU6 - 11.0.6567.0 - x86 (3194992)
$outputFolder = 'c:\sqlsyms\11.0.6567.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/6830ed55a6d6494b80e8f5b71fd30d8d2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.6567.00 ((SQL11_SP3_QFE-CU).161010-1959 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/913bea3e2f604ac6b5f2fb46bca63fd22/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.6567.00 ((SQL11_SP3_QFE-CU).161010-1959 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/6bedeb07e9c449cdb0018a92727ced2e2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.6567.00 ((SQL11_SP3_QFE-CU).161010-1959 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/faf3de3ef8714e8a89b7e385a57510412/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.6567.00 ((SQL11_SP3_QFE-CU).161010-1959 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/c266fee436644990b265e7e9151c488f1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.6567.00 ((SQL11_SP3_QFE-CU).161010-1959 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/55260b1f426c40c997183184a77c768e1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.6567.00 ((SQL11_SP3_QFE-CU).161010-1959 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/69f53ff9d9e14a0fbb07e0e80678e3181/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.6567.00 ((SQL11_SP3_QFE-CU).161010-1959 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/4223e10e9d3546a795480e990cc148f31/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.6567.00 ((SQL11_SP3_QFE-CU).161010-1959 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/a813fa0504b6441e81a3be6f20c0bc541/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.6567.00 ((SQL11_SP3_QFE-CU).161010-1959 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/6bef5361c8b84cdfa2cdb9731708a2cb2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.6567.00 ((SQL11_SP3_QFE-CU).161010-1959 )
```

# SQL Server 2012 SP3 CU5 - 11.0.6544.0 - x64 (3180915)
``` powershell
# SQL Server 2012 SP3 CU5 - 11.0.6544.0 - x64 (3180915)
$outputFolder = 'c:\sqlsyms\11.0.6544.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/b3a2c45b9cd04194ad768faff2dd480e1/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2011.0110.6544.00 ((SQL11_SP3_QFE-CU).160829-1346 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/e8b5df585c394779a2ff88a39458ebfa1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.6544.00 ((SQL11_SP3_QFE-CU).160829-1346 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/54542e47b335481cbedba3ad6aca9e9c1/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.6544.00 ((SQL11_SP3_QFE-CU).160829-1346 )
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/02526e38efd34a22892561485c3e93331/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2011.0110.6544.00 ((SQL11_SP3_QFE-CU).160829-1346 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/25eee25e365c452fafba7d762dcb5e211/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.6544.00 ((SQL11_SP3_QFE-CU).160829-1346 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/75c6111e1cc1449bad2112e15cd3302c1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.6544.00 ((SQL11_SP3_QFE-CU).160829-1346 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/d50d043ce4fe402e90a622a378ec8add1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.6544.00 ((SQL11_SP3_QFE-CU).160829-1346 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/7009006d3e944eaa82f52532647ce2651/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.6544.00 ((SQL11_SP3_QFE-CU).160829-1346 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/8e119547cbb34fddafba8c65733b36131/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.6544.00 ((SQL11_SP3_QFE-CU).160829-1346 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/3d8457edc2c348ee870e2df8e0ffb5591/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.6544.00 ((SQL11_SP3_QFE-CU).160829-1346 )
```

# SQL Server 2012 SP3 CU5 - 11.0.6544.0 - x86 (3180915)
``` powershell
# SQL Server 2012 SP3 CU5 - 11.0.6544.0 - x86 (3180915)
$outputFolder = 'c:\sqlsyms\11.0.6544.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/58621a8e7f424ceaaf82b6a8621ad5ae2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.6544.00 ((SQL11_SP3_QFE-CU).160829-1356 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/b5cfcf4e10fc47c9b1c57156d868ea882/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.6544.00 ((SQL11_SP3_QFE-CU).160829-1356 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/7bacebdbc3ef47338dcba37b2d5d42012/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.6544.00 ((SQL11_SP3_QFE-CU).160829-1356 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/c5bf5f4f707a4b86bf1d9ce281f7bc142/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.6544.00 ((SQL11_SP3_QFE-CU).160829-1356 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/f662a0c9bba14a7aa62df4a06b8657271/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.6544.00 ((SQL11_SP3_QFE-CU).160829-1356 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/73b2ad756d314c55814d8d03fc8b7b6c1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.6544.00 ((SQL11_SP3_QFE-CU).160829-1356 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/c06729d83eb1457084c51e25542252781/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.6544.00 ((SQL11_SP3_QFE-CU).160829-1356 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/ee5eff6976704286b8be419395371aac1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.6544.00 ((SQL11_SP3_QFE-CU).160829-1356 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/3f5943d18bf84c9189322c1d5aca2a9a1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.6544.00 ((SQL11_SP3_QFE-CU).160829-1356 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/78d4fff0f00047728cb50cb4211c493d2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.6544.00 ((SQL11_SP3_QFE-CU).160829-1356 )
```

# SQL Server 2012 SP3 CU4 - 11.0.6540.0 - x64 (3165264)
``` powershell
# SQL Server 2012 SP3 CU4 - 11.0.6540.0 - x64 (3165264)
$outputFolder = 'c:\sqlsyms\11.0.6540.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/05130a8e03694effbf4ee0a5d93d6f022/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.6540.00 ((SQL11_SP3_QFE-CU).160623-1731 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/d91b0bd2f080497d8898ca7dc13564e12/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.6540.00 ((SQL11_SP3_QFE-CU).160623-1731 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/ee95fd17ecc14e49a85fcf6d693011042/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.6540.00 ((SQL11_SP3_QFE-CU).160623-1731 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/6b39164c29804cc6b7609f81e04c8bb62/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.6540.00 ((SQL11_SP3_QFE-CU).160623-1731 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/e81c72c3de764c97b5615f32b3d10b5f1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.6540.00 ((SQL11_SP3_QFE-CU).160623-1731 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/c363526150464be9a52a234e681f31ed1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.6540.00 ((SQL11_SP3_QFE-CU).160623-1731 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/b5b55e52e8e04520a7c81e3fd8c1aeeb1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.6540.00 ((SQL11_SP3_QFE-CU).160623-1731 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/971700e9f5c24edb979e7aa0820b71981/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.6540.00 ((SQL11_SP3_QFE-CU).160623-1731 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/13788a023dd542da9822e3eea228db7b1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.6540.00 ((SQL11_SP3_QFE-CU).160623-1731 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/031265bbe1a14ada8f4078c6705f7c4c2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.6540.00 ((SQL11_SP3_QFE-CU).160623-1731 )
```

# SQL Server 2012 SP3 CU4 - 11.0.6540.0 - x86 (3165264)
``` powershell
# SQL Server 2012 SP3 CU4 - 11.0.6540.0 - x86 (3165264)
$outputFolder = 'c:\sqlsyms\11.0.6540.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/7abb3b2c641e462d99e832cfaa77b5022/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.6540.00 ((SQL11_SP3_QFE-CU).160623-1729 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/a3440669ec5541c8a7aafd6b6a7e5c152/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.6540.00 ((SQL11_SP3_QFE-CU).160623-1729 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/b031eefe7864472ab762aa98e16b11142/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.6540.00 ((SQL11_SP3_QFE-CU).160623-1729 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/765547fd40cc4aef80ec1b3dd8f0a9292/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.6540.00 ((SQL11_SP3_QFE-CU).160623-1729 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/7651776a76644a30b6a8d7ecdd1d24d11/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.6540.00 ((SQL11_SP3_QFE-CU).160623-1729 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/1de5f51195b54e5eb12f2f56f6237a041/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.6540.00 ((SQL11_SP3_QFE-CU).160623-1729 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/2cc47be0bc3e4cf7b0c0aebac03b08a11/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.6540.00 ((SQL11_SP3_QFE-CU).160623-1729 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/2f3cb78d00b54698824e73ac44b2f9bc1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.6540.00 ((SQL11_SP3_QFE-CU).160623-1729 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/18bb1bb91f9a4ba78e00ea92bc40fe121/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.6540.00 ((SQL11_SP3_QFE-CU).160623-1729 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/b14e40ff51364430b7bed58f8b44cef72/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.6540.00 ((SQL11_SP3_QFE-CU).160623-1729 )
```

# SQL Server 2012 SP3 CU3 - 11.0.6537.0 - x64 (3152635)
``` powershell
# SQL Server 2012 SP3 CU3 - 11.0.6537.0 - x64 (3152635)
$outputFolder = 'c:\sqlsyms\11.0.6537.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/784b2d2a11f4459784a98a777a61e39e2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.6537.00 ((SQL11_SP3_QFE-CU).160428-1744 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/41074d77469a4e0e9217c8e29cb4ed772/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.6537.00 ((SQL11_SP3_QFE-CU).160428-1744 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/a01672c248514057a59d13e89ce93b0f2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.6537.00 ((SQL11_SP3_QFE-CU).160428-1744 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/d5d1a87d5e764f29b202493cbcba3d082/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.6537.00 ((SQL11_SP3_QFE-CU).160428-1744 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/cf422a9dbb8340a5b5000ab5dbd4f4e91/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.6537.00 ((SQL11_SP3_QFE-CU).160428-1744 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/a803eeca499b45fbb53081e01c86e0571/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.6537.00 ((SQL11_SP3_QFE-CU).160428-1744 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/7335b11661aa48f298d976a2448c6f6a1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.6537.00 ((SQL11_SP3_QFE-CU).160428-1744 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/b027f13eb4994ee99ecc152c282fbb581/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.6537.00 ((SQL11_SP3_QFE-CU).160428-1744 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/c99210c7d2ff447c98494bb5c241af8c1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.6537.00 ((SQL11_SP3_QFE-CU).160428-1744 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/dcdc7cc5bfba4aa38c320285a6cdcbaa2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.6537.00 ((SQL11_SP3_QFE-CU).160428-1744 )
```

# SQL Server 2012 SP3 CU3 - 11.0.6537.0 - x86 (3152635)
``` powershell
# SQL Server 2012 SP3 CU3 - 11.0.6537.0 - x86 (3152635)
$outputFolder = 'c:\sqlsyms\11.0.6537.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/87293ca873904ed2b56237e34e3e1f1a2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.6537.00 ((SQL11_SP3_QFE-CU).160428-1744 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/e43071f0910a4ea7bf86b1d5ccc3fd3a2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.6537.00 ((SQL11_SP3_QFE-CU).160428-1744 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/c8f9372146b044febc8ccce8b3c2b1c12/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.6537.00 ((SQL11_SP3_QFE-CU).160428-1744 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/0270b86f2c75487194f651d075a34e5c2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.6537.00 ((SQL11_SP3_QFE-CU).160428-1744 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/4341ceb14e534bb5924ea613956c20361/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.6537.00 ((SQL11_SP3_QFE-CU).160428-1744 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/85fe76a3ab4547f1b1cfad36f43712371/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.6537.00 ((SQL11_SP3_QFE-CU).160428-1744 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/b62e092daed64119808aa2f71fdf41051/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.6537.00 ((SQL11_SP3_QFE-CU).160428-1744 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/91e900c8fc1b4d7f81cbc2e79afbfadc1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.6537.00 ((SQL11_SP3_QFE-CU).160428-1744 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/d39bca94636a4cf0bbeffedf2073f5551/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.6537.00 ((SQL11_SP3_QFE-CU).160428-1744 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/6065f2fd7ce6477bb93ff9dd4b74897a2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.6537.00 ((SQL11_SP3_QFE-CU).160428-1744 )
```

# SQL Server 2012 SP3 CU2 - 11.0.6523.0 - x64 (3137746)
``` powershell
# SQL Server 2012 SP3 CU2 - 11.0.6523.0 - x64 (3137746)
$outputFolder = 'c:\sqlsyms\11.0.6523.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/fcafe44179a349b4b1a42e17631445382/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.6523.00 ((SQL11_SP3_QFE-CU).160302-2113 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/04ab05307b834b1e93aaa5957b68ce492/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.6523.00 ((SQL11_SP3_QFE-CU).160302-2113 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/10d09d86092f400aac076647eeca36492/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.6523.00 ((SQL11_SP3_QFE-CU).160302-2113 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/af7848b84c93447291909dd6fed24bfa2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.6523.00 ((SQL11_SP3_QFE-CU).160302-2113 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/79347e6e63ee4aa7a267ddb157777b3c1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.6523.00 ((SQL11_SP3_QFE-CU).160302-2113 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/7a3302ffc3a643eab7a0eb0a777222d01/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.6523.00 ((SQL11_SP3_QFE-CU).160302-2113 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/d12619783d1247e29e210143f65ebd4f1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.6523.00 ((SQL11_SP3_QFE-CU).160302-2113 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/74204f690ddd470aa8ba6d534f4b07441/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.6523.00 ((SQL11_SP3_QFE-CU).160302-2113 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/0045a36c9f7e4dca997063b212dc62291/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.6523.00 ((SQL11_SP3_QFE-CU).160302-2113 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/86c28146977b477e8bc99340ad0107ff2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.6523.00 ((SQL11_SP3_QFE-CU).160302-2113 )
```

# SQL Server 2012 SP3 CU2 - 11.0.6523.0 - x86 (3137746)
``` powershell
# SQL Server 2012 SP3 CU2 - 11.0.6523.0 - x86 (3137746)
$outputFolder = 'c:\sqlsyms\11.0.6523.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/68a1704d4c60484abdab611a4011ebd22/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.6523.00 ((SQL11_SP3_QFE-CU).160302-2116 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/2b713f51cb3a475c8a0ade5063d183c52/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.6523.00 ((SQL11_SP3_QFE-CU).160302-2116 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/a9139393e7d148949351243a6f2e60372/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.6523.00 ((SQL11_SP3_QFE-CU).160302-2116 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/84966d1d5e904eeda26c06b58e1d8dbb2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.6523.00 ((SQL11_SP3_QFE-CU).160302-2116 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/de7fcca82fa446358962e3106fa609be1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.6523.00 ((SQL11_SP3_QFE-CU).160302-2116 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/39a1b26dcdea427fb467b9aefff863f51/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.6523.00 ((SQL11_SP3_QFE-CU).160302-2116 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/c5f85db1be474d0dbf027a0374de6e9a1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.6523.00 ((SQL11_SP3_QFE-CU).160302-2116 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/49835c6b775c4d9db7d3415b2b59ca741/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.6523.00 ((SQL11_SP3_QFE-CU).160302-2116 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/d74fca8456884c6a9b58acd70da167251/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.6523.00 ((SQL11_SP3_QFE-CU).160302-2116 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/e1d2fd01359645a69447f78c6a39beda2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.6523.00 ((SQL11_SP3_QFE-CU).160302-2116 )
```

# SQL Server 2012 SP3 CU1 - 11.0.6518.0 - x64 (3123299)
``` powershell
# SQL Server 2012 SP3 CU1 - 11.0.6518.0 - x64 (3123299)
$outputFolder = 'c:\sqlsyms\11.0.6518.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/a311f07702a44e019573de6bc28d9a802/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.6518.00 ((SQL11_SP3_QFE-CU).160107-1429 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/122248fa6f9643ffaa1d4b98a8b852892/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.6518.00 ((SQL11_SP3_QFE-CU).160107-1429 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/9d9fff96ee2d47fb8d4a1694bf0bc01a2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.6518.00 ((SQL11_SP3_QFE-CU).160107-1429 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/007a1b4b3ac941cab55a979ce199b3cd2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.6518.00 ((SQL11_SP3_QFE-CU).160107-1429 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/8419c4bbf0b844879129f25d50eda11d1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.6518.00 ((SQL11_SP3_QFE-CU).160107-1429 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/ab53bf1c7c5b415489b8dad9527aaef71/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.6518.00 ((SQL11_SP3_QFE-CU).160107-1429 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/f6d8f219eb804aeeb61e15c17855fa351/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.6518.00 ((SQL11_SP3_QFE-CU).160107-1429 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/d6e72bc2815a411e803c12d5a757e6c21/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.6518.00 ((SQL11_SP3_QFE-CU).160107-1429 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/5f78f36cf3c64d4d8bbf5ae5b8506a5d1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.6518.00 ((SQL11_SP3_QFE-CU).160107-1429 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/466c40a06fe8457a88ac5b2ac31bb8012/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.6518.00 ((SQL11_SP3_QFE-CU).160107-1429 )
```

# SQL Server 2012 SP3 CU1 - 11.0.6518.0 - x86 (3123299)
``` powershell
# SQL Server 2012 SP3 CU1 - 11.0.6518.0 - x86 (3123299)
$outputFolder = 'c:\sqlsyms\11.0.6518.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/85e2f9abea704a94a052cfe9a6dee0572/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.6518.00 ((SQL11_SP3_QFE-CU).160107-1429 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/1522388b2b31493585a6e2b4f2624aa12/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.6518.00 ((SQL11_SP3_QFE-CU).160107-1429 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/2ada5d3381bf4c93aeb02541e200f17b2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.6518.00 ((SQL11_SP3_QFE-CU).160107-1429 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/70b02e6179e54640b5dcc09743e445ee2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.6518.00 ((SQL11_SP3_QFE-CU).160107-1429 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/92fe1e276d4f424988cce512111d09151/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.6518.00 ((SQL11_SP3_QFE-CU).160107-1429 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/a704e7ede8b04298b150daaa93ba4d8f1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.6518.00 ((SQL11_SP3_QFE-CU).160107-1429 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/9040b150117a4e44a073e50d38297c051/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.6518.00 ((SQL11_SP3_QFE-CU).160107-1429 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/2599461ed95c4636bf1b1b4467a5d1e21/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.6518.00 ((SQL11_SP3_QFE-CU).160107-1429 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/9b6afd69a5674b42b6876b28a79d8c161/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.6518.00 ((SQL11_SP3_QFE-CU).160107-1429 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/799ab84cc9fe4b8a9cff76c808c5669c2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.6518.00 ((SQL11_SP3_QFE-CU).160107-1429 )
```

# SQL Server 2012 SP3 SP3 - 11.0.6020.0 - x64 (3072779)
``` powershell
# SQL Server 2012 SP3 SP3 - 11.0.6020.0 - x64 (3072779)
$outputFolder = 'c:\sqlsyms\11.0.6020.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/8c2548391c41414994a23eb9e1ffbc5d2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.6020.00 ((SQL11_PCU_Main).151020-1526 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/8bcf882af198453eae955b7af05df27a2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.6020.00 ((SQL11_PCU_Main).151020-1526 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/3811dbbc84c44f0d979c674cd571926a2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.6020.00 ((SQL11_PCU_Main).151020-1526 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/eb85f8ee377f43f9afed8cd2e9c932192/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.6020.00 ((SQL11_PCU_Main).151020-1526 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/a017c07601cf4596a671f7b35a4119bd1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.6020.00 ((SQL11_PCU_Main).151020-1526 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/b287171e30de46d48bc5e4f50d321d511/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.6020.00 ((SQL11_PCU_Main).151020-1526 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/50aca007a677401f99a7ad15b4631f101/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.6020.00 ((SQL11_PCU_Main).151020-1526 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/cebe10126c694f9089577dc49f71d20e1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.6020.00 ((SQL11_PCU_Main).151020-1526 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/ae66568baac84d068167d6a4a1cd7b001/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.6020.00 ((SQL11_PCU_Main).151020-1526 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/d7c6e98402ea495fa3da17f1aecb29ba2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.6020.00 ((SQL11_PCU_Main).151020-1526 )
```

# SQL Server 2012 SP3 SP3 - 11.0.6020.0 - x86 (3072779)
``` powershell
# SQL Server 2012 SP3 SP3 - 11.0.6020.0 - x86 (3072779)
$outputFolder = 'c:\sqlsyms\11.0.6020.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/9c88c47ad634432f947247b93a4c437a2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.6020.00 ((SQL11_PCU_Main).151020-1525 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/70e38bc1d979482ab3577c81191a07892/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.6020.00 ((SQL11_PCU_Main).151020-1525 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/a71c6013ff7e4b4188afe07b47e9d5112/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.6020.00 ((SQL11_PCU_Main).151020-1525 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/fe998ea9010c43c090935a171585c9152/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.6020.00 ((SQL11_PCU_Main).151020-1525 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/1066d39f48fb4eefbd1096712687a1811/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.6020.00 ((SQL11_PCU_Main).151020-1525 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/b4529742a01b4ee88d17228b861439c21/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.6020.00 ((SQL11_PCU_Main).151020-1525 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/49a2aab10cb04420b666377d96ec5b731/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.6020.00 ((SQL11_PCU_Main).151020-1525 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/5894cb69e99141c1b730209ff772dcb81/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.6020.00 ((SQL11_PCU_Main).151020-1525 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/21ae50d9944c4af2b2868123b95b46591/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.6020.00 ((SQL11_PCU_Main).151020-1525 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/12ddb13831544b28b5f8a4c017d0efa92/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.6020.00 ((SQL11_PCU_Main).151020-1525 )
```

# SQL Server 2012 SP2 CU16 - 11.0.5678.0 - x64 (3205054)
``` powershell
# SQL Server 2012 SP2 CU16 - 11.0.5678.0 - x64 (3205054)
$outputFolder = 'c:\sqlsyms\11.0.5678.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/db25800662db4aa5abc2fe3b1dfa40892/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5678.00 ((SQL11_SP2_QFE-CU).161216-1503 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/c2962322b56545e18fdd1947d7a3f5552/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5678.00 ((SQL11_SP2_QFE-CU).161216-1503 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/26e55d51a2524f8f9c3eb14a9c0a5e7f2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5678.00 ((SQL11_SP2_QFE-CU).161216-1503 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/3f7c15db3e80428d842dc6577dbe957b2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5678.00 ((SQL11_SP2_QFE-CU).161216-1503 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/102484c88a7a454e94a5b6fd7baf00a11/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5678.00 ((SQL11_SP2_QFE-CU).161216-1503 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/6ccba8f0e4194a70a33c5969a18ee7a41/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5678.00 ((SQL11_SP2_QFE-CU).161216-1503 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/5006d5458a6049588ec4c1e0043b13a61/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5678.00 ((SQL11_SP2_QFE-CU).161216-1503 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/c30cda3d5e9f47378676888347f958991/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5678.00 ((SQL11_SP2_QFE-CU).161216-1503 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/8979dfe9d46a474a9c4ceba886d148071/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5678.00 ((SQL11_SP2_QFE-CU).161216-1503 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/a62693b04bed4018829db79c6e9014242/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5678.00 ((SQL11_SP2_QFE-CU).161216-1503 )
```

# SQL Server 2012 SP2 CU16 - 11.0.5678.0 - x86 (3205054)
``` powershell
# SQL Server 2012 SP2 CU16 - 11.0.5678.0 - x86 (3205054)
$outputFolder = 'c:\sqlsyms\11.0.5678.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/c7c7b2fbe65140d48fbfb488363088822/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5678.00 ((SQL11_SP2_QFE-CU).161216-1502 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/b4a31b7568c54b6db1e29cfd4a8c62a12/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5678.00 ((SQL11_SP2_QFE-CU).161216-1502 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/05099346226d439f95d2dc50d23f84042/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5678.00 ((SQL11_SP2_QFE-CU).161216-1502 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/b1228bc7d3284c2bb2716e659b542b5f2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5678.00 ((SQL11_SP2_QFE-CU).161216-1502 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/e3c2403ccac246f7945b28cf1636d68b1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5678.00 ((SQL11_SP2_QFE-CU).161216-1502 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/f9706bb17f8b42128c9a74895ba068091/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5678.00 ((SQL11_SP2_QFE-CU).161216-1502 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/6aad5ebf336a4352be93b0cd1283f3901/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5678.00 ((SQL11_SP2_QFE-CU).161216-1502 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/7ce1f1a9129c489e9358e13dbd8dd6d51/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5678.00 ((SQL11_SP2_QFE-CU).161216-1502 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/08ec37d9396e469a97fa1884e4f3126b1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5678.00 ((SQL11_SP2_QFE-CU).161216-1502 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/cf639729d8724367a1e99d7dce200cc82/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5678.00 ((SQL11_SP2_QFE-CU).161216-1502 )
```

# SQL Server 2012 SP2 CU15 - 11.0.5676.0 - x64 (3205416)
``` powershell
# SQL Server 2012 SP2 CU15 - 11.0.5676.0 - x64 (3205416)
$outputFolder = 'c:\sqlsyms\11.0.5676.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/dd1ba68516834e3eac8754e0c3f763a62/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5676.00 ((SQL11_SP2_QFE-CU).161010-1819 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/d4489a41a7864f41a583d818941820bb2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5676.00 ((SQL11_SP2_QFE-CU).161010-1819 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/96ba3b4dada540baae72f7ac5d372c562/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5676.00 ((SQL11_SP2_QFE-CU).161010-1819 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/58ff259b5717420199bdca05ad6475fa2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5676.00 ((SQL11_SP2_QFE-CU).161010-1819 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/243641435747432bb7cb32747fbb096e1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5676.00 ((SQL11_SP2_QFE-CU).161010-1819 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/d972cc8d2f0c47ec8f219ea7d4152cca1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5676.00 ((SQL11_SP2_QFE-CU).161010-1819 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/5b9529c4d43b4f79ae09b990a453ef2e1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5676.00 ((SQL11_SP2_QFE-CU).161010-1819 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/1e8ddd5ae37c49c98e758b3fd246d4971/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5676.00 ((SQL11_SP2_QFE-CU).161010-1819 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/06783190c3eb47438d51e209b2b15b4a1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5676.00 ((SQL11_SP2_QFE-CU).161010-1819 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/acab102088fb4de3aea8154c3d3073c22/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5676.00 ((SQL11_SP2_QFE-CU).161010-1819 )
```

# SQL Server 2012 SP2 CU15 - 11.0.5676.0 - x86 (3205416)
``` powershell
# SQL Server 2012 SP2 CU15 - 11.0.5676.0 - x86 (3205416)
$outputFolder = 'c:\sqlsyms\11.0.5676.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/c5dce76c002d40228af8b7f4334c43382/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5676.00 ((SQL11_SP2_QFE-CU).161010-1819 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/f9ca6e1c1c5a48509ef17541f440110d2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5676.00 ((SQL11_SP2_QFE-CU).161010-1819 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/a65a7dbefb534977862075b5592cbea22/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5676.00 ((SQL11_SP2_QFE-CU).161010-1819 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/2d77fbddcd3c461788cbbc876813d8672/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5676.00 ((SQL11_SP2_QFE-CU).161010-1819 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/3350d6c06cda4237b5522c0ce229d61e1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5676.00 ((SQL11_SP2_QFE-CU).161010-1819 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/08912861adab4657b566a71ce625b5df1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5676.00 ((SQL11_SP2_QFE-CU).161010-1819 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/591d683835904ed6936cc8c15d53bb271/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5676.00 ((SQL11_SP2_QFE-CU).161010-1819 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/beb991341db6464ba3e901e618e4141c1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5676.00 ((SQL11_SP2_QFE-CU).161010-1819 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/01e137606c424aaea4b7ad65fda59f4a1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5676.00 ((SQL11_SP2_QFE-CU).161010-1819 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/afaeeb6537af486eba72087380814b682/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5676.00 ((SQL11_SP2_QFE-CU).161010-1819 )
```

# SQL Server 2012 SP2 CU14 - 11.0.5657.0 - x64 (3180914)
``` powershell
# SQL Server 2012 SP2 CU14 - 11.0.5657.0 - x64 (3180914)
$outputFolder = 'c:\sqlsyms\11.0.5657.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/25d44c4a218a45e69440f64a6c2f39022/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5657.00 ((SQL11_SP2_QFE-CU).160825-1743 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/4ef82375cf4e42a8be639daea082a4c52/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5657.00 ((SQL11_SP2_QFE-CU).160825-1743 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/ca2d467f8210454ea0b0f9e80185f22a2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5657.00 ((SQL11_SP2_QFE-CU).160825-1743 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/d89b853ec00c4ef4a2ff7439eebe952c2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5657.00 ((SQL11_SP2_QFE-CU).160825-1743 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/87f21dcc1cd04ac3b90b4a6ae1e428201/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5657.00 ((SQL11_SP2_QFE-CU).160825-1743 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/e5104d3be08248348393b672b2a9bb0a1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5657.00 ((SQL11_SP2_QFE-CU).160825-1743 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/ac3edf92e6ec4a12bb6533025087bf2f1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5657.00 ((SQL11_SP2_QFE-CU).160825-1743 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/821c2909862a40bdb68783eb23929cc31/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5657.00 ((SQL11_SP2_QFE-CU).160825-1743 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/d1c8cae724694f6bb2962cdc83f4329e1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5657.00 ((SQL11_SP2_QFE-CU).160825-1743 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/a4a3c0bd71ad4f85bb1e8b97eb7b18862/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5657.00 ((SQL11_SP2_QFE-CU).160825-1743 )
```

# SQL Server 2012 SP2 CU14 - 11.0.5657.0 - x86 (3180914)
``` powershell
# SQL Server 2012 SP2 CU14 - 11.0.5657.0 - x86 (3180914)
$outputFolder = 'c:\sqlsyms\11.0.5657.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/ce78955c784c48afa622c25baf31d45b2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5657.00 ((SQL11_SP2_QFE-CU).160825-1749 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/213855c2ec884f97896f2de644073c0e2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5657.00 ((SQL11_SP2_QFE-CU).160825-1749 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/6aba2304025c482694789dfa59caa53d2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5657.00 ((SQL11_SP2_QFE-CU).160825-1749 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/140309b667144067ab36b0dbd619c6592/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5657.00 ((SQL11_SP2_QFE-CU).160825-1749 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/c3de962144364bee8d4f28ef8a9244911/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5657.00 ((SQL11_SP2_QFE-CU).160825-1749 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/1ceb4d2de2a44439a8704ea70320c65e1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5657.00 ((SQL11_SP2_QFE-CU).160825-1749 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/73272f461ea94ba19eab4f80bad006f01/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5657.00 ((SQL11_SP2_QFE-CU).160825-1749 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/4326574b01f6436a833579f838b757e21/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5657.00 ((SQL11_SP2_QFE-CU).160825-1749 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/8b38568a4a9f49c8b3aec36e8b5a71f41/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5657.00 ((SQL11_SP2_QFE-CU).160825-1749 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/bf3d3e6661b04901834ca05fc19a44352/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5657.00 ((SQL11_SP2_QFE-CU).160825-1749 )
```

# SQL Server 2012 SP2 CU13 - 11.0.5655.0 - x64 (3165266)
``` powershell
# SQL Server 2012 SP2 CU13 - 11.0.5655.0 - x64 (3165266)
$outputFolder = 'c:\sqlsyms\11.0.5655.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/a433571fbd0c41f5ac4d33283de127002/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5655.00 ((SQL11_SP2_QFE-CU).160705-1418 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/960013cc86c5408f9808f8378e2da08a2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5655.00 ((SQL11_SP2_QFE-CU).160705-1418 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/171ddb83c0474edf824711de922e0a172/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5655.00 ((SQL11_SP2_QFE-CU).160705-1418 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/4747e8ca27484a8199bb39b14f211c302/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5655.00 ((SQL11_SP2_QFE-CU).160705-1418 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/69db5fdaa93f408890a49893da554dbb1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5655.00 ((SQL11_SP2_QFE-CU).160705-1418 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/2e74440521ea4986a0b4eb23a776f3d01/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5655.00 ((SQL11_SP2_QFE-CU).160705-1418 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/8b3231d270724bdc997c398a178833891/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5655.00 ((SQL11_SP2_QFE-CU).160705-1418 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/a730d9127fc74a9b9ab5c74334bebfe71/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5655.00 ((SQL11_SP2_QFE-CU).160705-1418 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/9c5081d580624480aab3f8894169a9581/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5655.00 ((SQL11_SP2_QFE-CU).160705-1418 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/519331463ede472796ee00b4dbd637042/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5655.00 ((SQL11_SP2_QFE-CU).160705-1418 )
```

# SQL Server 2012 SP2 CU13 - 11.0.5655.0 - x86 (3165266)
``` powershell
# SQL Server 2012 SP2 CU13 - 11.0.5655.0 - x86 (3165266)
$outputFolder = 'c:\sqlsyms\11.0.5655.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\SqlDK.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlDK.pdb/a40567d01f594052a94636f0cd569c541/SqlDK.pdb' -OutFile "$outputFolder\SqlDK.pdb" } # File version 2011.0110.5655.00 ((SQL11_SP2_QFE-CU).160705-1417 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/6f33217e9aa04118a60392866667a4dd1/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5655.00 ((SQL11_SP2_QFE-CU).160705-1417 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/a082374fd27f42d8aeb194286aa2f6051/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5655.00 ((SQL11_SP2_QFE-CU).160705-1417 )
if (-not (Test-Path "$outputFolder\SqlTsEs.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlTsEs.pdb/8877e5f396644ace9da54a50dd1d9e621/SqlTsEs.pdb' -OutFile "$outputFolder\SqlTsEs.pdb" } # File version 2011.0110.5655.00 ((SQL11_SP2_QFE-CU).160705-1417 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/28f1fa69afaf411b9febdf147cd1175a1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5655.00 ((SQL11_SP2_QFE-CU).160705-1417 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/3d0122e1b8b845c3a2e8aba23fe95f521/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5655.00 ((SQL11_SP2_QFE-CU).160705-1417 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/4ba3538fcd764fc18b0042deb7c698781/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5655.00 ((SQL11_SP2_QFE-CU).160705-1417 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/d06fc9adef414529902a650201013aa21/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5655.00 ((SQL11_SP2_QFE-CU).160705-1417 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/0f5b5abc62a743e3bbd0782075ef62371/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5655.00 ((SQL11_SP2_QFE-CU).160705-1417 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/67f36d2c92b743e5aff3dc36ae129fc41/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5655.00 ((SQL11_SP2_QFE-CU).160705-1417 )
```

# SQL Server 2012 SP2 CU12 - 11.0.5649.0 - x64 (3152637)
``` powershell
# SQL Server 2012 SP2 CU12 - 11.0.5649.0 - x64 (3152637)
$outputFolder = 'c:\sqlsyms\11.0.5649.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/3b91a33f51794e3caa45dae0a72e3c9e2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5649.00 ((SQL11_SP2_QFE-CU).160424-0952 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/8981f04bfc6b49b1bc366fdbba7ac9bc2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5649.00 ((SQL11_SP2_QFE-CU).160424-0952 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/ff6907a9682d4b2c8211be8b09ca3cb42/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5649.00 ((SQL11_SP2_QFE-CU).160424-0952 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/b7f62a1ca0024f608c64c70ab25f49e32/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5649.00 ((SQL11_SP2_QFE-CU).160424-0952 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/20533819d052436b9f11657e00a25c3e1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5649.00 ((SQL11_SP2_QFE-CU).160424-0952 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/4aad9e292bf548faae06ff8ae1d430b31/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5649.00 ((SQL11_SP2_QFE-CU).160424-0952 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/0fa56d3b36df453db62d14d6baf90bb41/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5649.00 ((SQL11_SP2_QFE-CU).160424-0952 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/454c0beb41f946d99f097261b0177c841/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5649.00 ((SQL11_SP2_QFE-CU).160424-0952 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/c8f5be043d814c118f23709c4a1ad1181/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5649.00 ((SQL11_SP2_QFE-CU).160424-0952 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/44f0c5b99ab343e28ab8711fa9bb2a272/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5649.00 ((SQL11_SP2_QFE-CU).160424-0952 )
```

# SQL Server 2012 SP2 CU12 - 11.0.5649.0 - x86 (3152637)
``` powershell
# SQL Server 2012 SP2 CU12 - 11.0.5649.0 - x86 (3152637)
$outputFolder = 'c:\sqlsyms\11.0.5649.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/0a81fe91a80c4005abc46c2263f09c4c2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5649.00 ((SQL11_SP2_QFE-CU).160424-1132 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/e3044265c315485f8812fef56a7e73b72/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5649.00 ((SQL11_SP2_QFE-CU).160424-1132 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/334ddc7a968042d58e7f62f9a365c1852/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5649.00 ((SQL11_SP2_QFE-CU).160424-1132 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/76854cf991784573858a7b60962f93232/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5649.00 ((SQL11_SP2_QFE-CU).160424-1132 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/d1dde76542a9427ebecb65f2468b91ce1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5649.00 ((SQL11_SP2_QFE-CU).160424-1132 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/29d1f01b3bb84da780dddb33213dbcf31/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5649.00 ((SQL11_SP2_QFE-CU).160424-1132 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/9de157e8d6f54db7b98a7502b94577641/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5649.00 ((SQL11_SP2_QFE-CU).160424-1132 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/e8541edbbfc0410d9b82e6ab78fc2ef01/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5649.00 ((SQL11_SP2_QFE-CU).160424-1132 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/f31f3117b463455688edb8b0f8163a401/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5649.00 ((SQL11_SP2_QFE-CU).160424-1132 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/e3318525756c429c81667cb043abadba2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5649.00 ((SQL11_SP2_QFE-CU).160424-1132 )
```

# SQL Server 2012 SP2 CU11 - 11.0.5646.0 - x64 (3137745)
``` powershell
# SQL Server 2012 SP2 CU11 - 11.0.5646.0 - x64 (3137745)
$outputFolder = 'c:\sqlsyms\11.0.5646.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/cd7a679d23ce4318ae4f9bd42021a1712/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5646.00 ((SQL11_SP2_QFE-CU).160226-1734 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/90d74a8ca29a4f30944f5fdfaba0c83c2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5646.00 ((SQL11_SP2_QFE-CU).160226-1734 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/14a616d4d2fe48f293fdb04ccae512bd2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5646.00 ((SQL11_SP2_QFE-CU).160226-1734 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/a91a9c36928443ab880573c213736a0b2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5646.00 ((SQL11_SP2_QFE-CU).160226-1734 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/40dd4867eec84f79bc2e0b16c8a88f121/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5646.00 ((SQL11_SP2_QFE-CU).160226-1734 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/3a605746326140df8f9996070fe654b11/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5646.00 ((SQL11_SP2_QFE-CU).160226-1734 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/c9718e636e7c4b4e8c0353b5a5a9deae1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5646.00 ((SQL11_SP2_QFE-CU).160226-1734 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/eb2f543f9569417e9664bdae69d903ac1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5646.00 ((SQL11_SP2_QFE-CU).160226-1734 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/f16396e855d64f2b9db73963a1f31e591/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5646.00 ((SQL11_SP2_QFE-CU).160226-1734 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/856db9275d4b49bea827cbdd41a9afe42/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5646.00 ((SQL11_SP2_QFE-CU).160226-1734 )
```

# SQL Server 2012 SP2 CU11 - 11.0.5646.0 - x86 (3137745)
``` powershell
# SQL Server 2012 SP2 CU11 - 11.0.5646.0 - x86 (3137745)
$outputFolder = 'c:\sqlsyms\11.0.5646.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/1747440228a742e590232cb45d5be3b72/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5646.00 ((SQL11_SP2_QFE-CU).160226-1735 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/95cfc60f73d24ed7b89a90a7ebbbaeef2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5646.00 ((SQL11_SP2_QFE-CU).160226-1735 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/0c6c10d175a6457d8d7c6ffad717539d2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5646.00 ((SQL11_SP2_QFE-CU).160226-1735 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/05b4ccc988ff4e5ebcc0702b5833f2db2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5646.00 ((SQL11_SP2_QFE-CU).160226-1735 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/5452aac59a3148ee8502ba3f365c7f501/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5646.00 ((SQL11_SP2_QFE-CU).160226-1735 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/018af0e7122742feb5a7332e671946771/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5646.00 ((SQL11_SP2_QFE-CU).160226-1735 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/8b0d9d31c92147c2a83d337704ddd4641/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5646.00 ((SQL11_SP2_QFE-CU).160226-1735 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/56d0425cc87a4fcbb066efb003b8f9fc1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5646.00 ((SQL11_SP2_QFE-CU).160226-1735 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/ee1d6435917a4f9885af79e50b4d37321/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5646.00 ((SQL11_SP2_QFE-CU).160226-1735 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/6fa82e53cc59482a9fa430a99730f6222/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5646.00 ((SQL11_SP2_QFE-CU).160226-1735 )
```

# SQL Server 2012 SP2 CU10 - 11.0.5644.2 - x64 (3120313)
``` powershell
# SQL Server 2012 SP2 CU10 - 11.0.5644.2 - x64 (3120313)
$outputFolder = 'c:\sqlsyms\11.0.5644.2\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/d8768549cb5345399f4fe1cea88794752/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5644.02 ((SQL11_SP2_QFE-CU).160107-2337 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/2cfeaeeffde843899bf0085a1fe229fc2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5644.02 ((SQL11_SP2_QFE-CU).160107-2337 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/9255e9211d0f41edb184f4c128e449062/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5644.02 ((SQL11_SP2_QFE-CU).160107-2337 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/1f9672b7fd7e4c04a13e4623c116288c2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5644.02 ((SQL11_SP2_QFE-CU).160107-2337 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/65527fa7b46a4ba48843ac5ca4f6c91a1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5644.02 ((SQL11_SP2_QFE-CU).160107-2337 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/aec37a7322154ab0a71d747d9318ad461/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5644.02 ((SQL11_SP2_QFE-CU).160107-2337 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/3c1d262015bf4d089e3dd11a7735ce971/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5644.02 ((SQL11_SP2_QFE-CU).160107-2337 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/998be39e1a234448be37b1e13fe86d7e1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5644.02 ((SQL11_SP2_QFE-CU).160107-2337 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/9ce5afd549134784a502ca2c56a422ea1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5644.02 ((SQL11_SP2_QFE-CU).160107-2337 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/e3a30191df804683ace74857f09b14582/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5644.02 ((SQL11_SP2_QFE-CU).160107-2337 )
```

# SQL Server 2012 SP2 CU10 - 11.0.5644.2 - x86 (3120313)
``` powershell
# SQL Server 2012 SP2 CU10 - 11.0.5644.2 - x86 (3120313)
$outputFolder = 'c:\sqlsyms\11.0.5644.2\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/7826cfcc93bd484fabcb123fb93136b72/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5644.02 ((SQL11_SP2_QFE-CU).160107-2309 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/030e8e2257cc4ca6a2e48a05ce239b412/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5644.02 ((SQL11_SP2_QFE-CU).160107-2309 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/94778bf7d845444cb650904ec51e75442/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5644.02 ((SQL11_SP2_QFE-CU).160107-2309 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/7b2d129b95e040ebbb027cef893c7f332/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5644.02 ((SQL11_SP2_QFE-CU).160107-2309 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/d7c79fd24b5e456dad7ec1547ddc46821/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5644.02 ((SQL11_SP2_QFE-CU).160107-2309 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/ba92ea50bd6a44f28a8fd9559f5394d81/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5644.02 ((SQL11_SP2_QFE-CU).160107-2309 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/c0db7d5acd534245b1bd9c10c425335f1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5644.02 ((SQL11_SP2_QFE-CU).160107-2309 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/d7942859fe6849968b3b484e5c17a03b1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5644.02 ((SQL11_SP2_QFE-CU).160107-2309 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/7f570e9d52e1447ab60d9b9fa8354e761/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5644.02 ((SQL11_SP2_QFE-CU).160107-2309 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/dbd7a81924634685b9cffd5c3cb533a62/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5644.02 ((SQL11_SP2_QFE-CU).160107-2309 )
```

# SQL Server 2012 SP2 CU9 - 11.0.5641.0 - x64 (3098512)
``` powershell
# SQL Server 2012 SP2 CU9 - 11.0.5641.0 - x64 (3098512)
$outputFolder = 'c:\sqlsyms\11.0.5641.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/a521723dc40a41ae90e5d3f588fa0ccf2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5641.00 ((SQL11_SP2_QFE-CU).151020-1624 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/8321e31318604a69993a346d0006baa02/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5641.00 ((SQL11_SP2_QFE-CU).151020-1624 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/9d8402c7dd2a49b0b16ed33e0a4beb322/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5641.00 ((SQL11_SP2_QFE-CU).151020-1624 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/00ebaef66b3e4232a2e59b4cb1b0f0de2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5641.00 ((SQL11_SP2_QFE-CU).151020-1624 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/b1d05b1c84dd431a8f41ffb65bb657021/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5641.00 ((SQL11_SP2_QFE-CU).151020-1624 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/22bc0604c1d54b8c8d826ee74708cc431/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5641.00 ((SQL11_SP2_QFE-CU).151020-1624 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/6aa02f4cf90e431e96f5ed3610a5c8561/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5641.00 ((SQL11_SP2_QFE-CU).151020-1624 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/19b09216c02f4f79954d0bc4dd86deb31/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5641.00 ((SQL11_SP2_QFE-CU).151020-1624 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/63f7a395d7c345f182d3cb93ce1065f61/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5641.00 ((SQL11_SP2_QFE-CU).151020-1624 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/33a6114f99434ff0b67b421c6ba8bf872/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5641.00 ((SQL11_SP2_QFE-CU).151020-1624 )
```

# SQL Server 2012 SP2 CU9 - 11.0.5641.0 - x86 (3098512)
``` powershell
# SQL Server 2012 SP2 CU9 - 11.0.5641.0 - x86 (3098512)
$outputFolder = 'c:\sqlsyms\11.0.5641.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/90707b52346e4f2081ee4b57991465f02/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5641.00 ((SQL11_SP2_QFE-CU).151020-1623 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/dadbef50fe024e9fa2ab29facd23364e2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5641.00 ((SQL11_SP2_QFE-CU).151020-1623 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/848be43da62b4654962c76ac0817f4d52/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5641.00 ((SQL11_SP2_QFE-CU).151020-1623 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/d3ead1ac747046bf95ce1fb24d26414b2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5641.00 ((SQL11_SP2_QFE-CU).151020-1623 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/6d4960a06b9e449189135a1f8cfe486d1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5641.00 ((SQL11_SP2_QFE-CU).151020-1623 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/fc7864bea8ae4450af4c100b03106cbc1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5641.00 ((SQL11_SP2_QFE-CU).151020-1623 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/ab2ca7efbd604bc2a98d334a6e8e85051/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5641.00 ((SQL11_SP2_QFE-CU).151020-1623 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/1aaa39cfe07242669c6f1fd909a40e141/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5641.00 ((SQL11_SP2_QFE-CU).151020-1623 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/8987ad9ed15145209fc028ceae4267041/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5641.00 ((SQL11_SP2_QFE-CU).151020-1623 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/9166856bbe0d4752b138d4aef51afa7f2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5641.00 ((SQL11_SP2_QFE-CU).151020-1623 )
```

# SQL Server 2012 SP2 CU8 - 11.0.5634.1 - x64 (3082561)
``` powershell
# SQL Server 2012 SP2 CU8 - 11.0.5634.1 - x64 (3082561)
$outputFolder = 'c:\sqlsyms\11.0.5634.1\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/61ef98bf0c944d27bdcdcbe956a71f532/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5634.01 ((SQL11_SP2_QFE-CU).150903-1845 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/e32a770828b441ea83876963f8915c642/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5634.01 ((SQL11_SP2_QFE-CU).150903-1845 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/82d71733ddda4f63b0c0c587bea3e5b52/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5634.01 ((SQL11_SP2_QFE-CU).150903-1845 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/3d8d115280c343e79ffda9d5e13914ca2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5634.01 ((SQL11_SP2_QFE-CU).150903-1845 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/df6d6664b8b343b5822f404ca1c71e961/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5634.01 ((SQL11_SP2_QFE-CU).150903-1845 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/afdf9896ee5f454da131c41d186ed2381/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5634.01 ((SQL11_SP2_QFE-CU).150903-1845 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/d24c170faa1d4b66a72dee2f6905bda41/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5634.01 ((SQL11_SP2_QFE-CU).150903-1845 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/6be320158f64485fb39edc54657cc9691/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5634.01 ((SQL11_SP2_QFE-CU).150903-1845 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/4a7653322ccd491db5e3319fe11fd1e11/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5634.01 ((SQL11_SP2_QFE-CU).150903-1845 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/ff7b48cc7d4845009f4219b2ea8ed7af2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5634.01 ((SQL11_SP2_QFE-CU).150903-1845 )
```

# SQL Server 2012 SP2 CU8 - 11.0.5634.1 - x86 (3082561)
``` powershell
# SQL Server 2012 SP2 CU8 - 11.0.5634.1 - x86 (3082561)
$outputFolder = 'c:\sqlsyms\11.0.5634.1\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/eaf68945f2a744b49102874620c553442/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5634.01 ((SQL11_SP2_QFE-CU).150903-1831 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/62d91f546d724970a297824753b247a62/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5634.01 ((SQL11_SP2_QFE-CU).150903-1831 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/0cee6b19c69a45a79cc9ba2576d203802/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5634.01 ((SQL11_SP2_QFE-CU).150903-1831 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/3595e13882f2488dad33b5b42b6de7022/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5634.01 ((SQL11_SP2_QFE-CU).150903-1831 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/5d1ce58362004146a03b9a203f716bcc1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5634.01 ((SQL11_SP2_QFE-CU).150903-1831 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/7ec8ca29f61b41c99ebc77df6f3641dc1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5634.01 ((SQL11_SP2_QFE-CU).150903-1831 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/32f2862ef89d49b29bfa4935a8cb5da81/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5634.01 ((SQL11_SP2_QFE-CU).150903-1831 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/64249ed7e3394edfa60825e07327feab1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5634.01 ((SQL11_SP2_QFE-CU).150903-1831 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/41763cddfdd84bdeae6a9d2f7f93a23a1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5634.01 ((SQL11_SP2_QFE-CU).150903-1831 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/839d3b40fcbb4c94b8bc3b9e91581f962/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5634.01 ((SQL11_SP2_QFE-CU).150903-1831 )
```

# SQL Server 2012 SP2 CU7 - 11.0.5623.0 - x64 (3072100)
``` powershell
# SQL Server 2012 SP2 CU7 - 11.0.5623.0 - x64 (3072100)
$outputFolder = 'c:\sqlsyms\11.0.5623.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/ae8dca071dd14b8588f8c1e8355750c42/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5623.00 ((SQL11_SP2_QFE-CU).150709-1152 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/e7c57dfa80174541b048819804823b642/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5623.00 ((SQL11_SP2_QFE-CU).150709-1152 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/ff4277e6a21e48fb9e04cc4e2c80ba0f2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5623.00 ((SQL11_SP2_QFE-CU).150709-1152 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/88abae217a834ae18b5754feecda13012/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5623.00 ((SQL11_SP2_QFE-CU).150709-1152 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/7d92e63eb71a45809ce78c14ffaf09d81/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5623.00 ((SQL11_SP2_QFE-CU).150709-1152 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/b5fb3509642c4690a5c45749035333051/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5623.00 ((SQL11_SP2_QFE-CU).150709-1152 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/8072e1fb97424fdc98269196785f7fbe1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5623.00 ((SQL11_SP2_QFE-CU).150709-1152 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/fca6c8e72e5e42ecb99207f194bef9191/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5623.00 ((SQL11_SP2_QFE-CU).150709-1152 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/31bac03868374db896288d1c1a856bf91/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5623.00 ((SQL11_SP2_QFE-CU).150709-1152 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/48708388ca2f4e6c9c9a286887fc6bda2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5623.00 ((SQL11_SP2_QFE-CU).150709-1152 )
```

# SQL Server 2012 SP2 CU7 - 11.0.5623.0 - x86 (3072100)
``` powershell
# SQL Server 2012 SP2 CU7 - 11.0.5623.0 - x86 (3072100)
$outputFolder = 'c:\sqlsyms\11.0.5623.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/473e800d9eeb4e4097e87652ab5aaa052/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5623.00 ((SQL11_SP2_QFE-CU).150709-1156 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/19adc0aa5e1249238e244b5ba9e0f2492/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5623.00 ((SQL11_SP2_QFE-CU).150709-1156 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/58fc60e3bbd5448bb466dc8f753683b62/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5623.00 ((SQL11_SP2_QFE-CU).150709-1156 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/49c28e17e982469bb1092e77901d168b2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5623.00 ((SQL11_SP2_QFE-CU).150709-1156 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/cc65b11dda20409a8879339d384bd9491/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5623.00 ((SQL11_SP2_QFE-CU).150709-1156 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/1a58faf830674e18a3aeb22c4f0818211/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5623.00 ((SQL11_SP2_QFE-CU).150709-1156 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/49fd8984505e468590ca91dda1dc99d41/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5623.00 ((SQL11_SP2_QFE-CU).150709-1156 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/3ba93675da7c476c979fd0b7cecbbdab1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5623.00 ((SQL11_SP2_QFE-CU).150709-1156 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/3d6472408ed74f41bb58f30027ba9e421/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5623.00 ((SQL11_SP2_QFE-CU).150709-1156 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/ee5bb2170a2347978420200f22fb85592/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5623.00 ((SQL11_SP2_QFE-CU).150709-1156 )
```

# SQL Server 2012 SP2 CU6 - 11.0.5592.0 - x64 (3052468)
``` powershell
# SQL Server 2012 SP2 CU6 - 11.0.5592.0 - x64 (3052468)
$outputFolder = 'c:\sqlsyms\11.0.5592.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/a9e46f8055ae4cb5aa344fb96e73ca7e2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5592.00 ((SQL11_SP2_QFE-CU).150417-1509 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/cf97aed844944105b2d8ed9a933dc1522/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5592.00 ((SQL11_SP2_QFE-CU).150417-1509 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/d3bcd6c8911b48a491bcf8e18841ba3b2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5592.00 ((SQL11_SP2_QFE-CU).150417-1509 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/92ea2d549256436c83154e05e769d26f2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5592.00 ((SQL11_SP2_QFE-CU).150417-1509 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/0ddbf5e6c62c483eab519b300e41aa131/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5592.00 ((SQL11_SP2_QFE-CU).150417-1509 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/253e36a0d02942189ed1205210163d8a1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5592.00 ((SQL11_SP2_QFE-CU).150417-1509 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/ae5a1adb5bf94b38b3ebb35270da6bb71/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5592.00 ((SQL11_SP2_QFE-CU).150417-1509 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/11acb1f2f7cf4498a3a8594014e4a5491/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5592.00 ((SQL11_SP2_QFE-CU).150417-1509 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/7ff78655e62d42d3862242c04816400d1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5592.00 ((SQL11_SP2_QFE-CU).150417-1509 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/c68000bb1ce7439ca573a54d17c73ab52/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5592.00 ((SQL11_SP2_QFE-CU).150417-1509 )
```

# SQL Server 2012 SP2 CU6 - 11.0.5592.0 - x86 (3052468)
``` powershell
# SQL Server 2012 SP2 CU6 - 11.0.5592.0 - x86 (3052468)
$outputFolder = 'c:\sqlsyms\11.0.5592.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/90b88bf18b2b483bbb76862b88cce4032/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5592.00 ((SQL11_SP2_QFE-CU).150417-1510 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/ade94be306d74bdea416c6d4efd8d8482/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5592.00 ((SQL11_SP2_QFE-CU).150417-1510 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/fc93e429e1454118b9be2831ac8539602/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5592.00 ((SQL11_SP2_QFE-CU).150417-1510 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/27a72ca6e4604cc8bdd4b0362751e82e2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5592.00 ((SQL11_SP2_QFE-CU).150417-1510 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/7aa7de50535a41d4b28f1437981bb3401/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5592.00 ((SQL11_SP2_QFE-CU).150417-1510 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/73f81b7d9c4240de8339ad241becf98f1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5592.00 ((SQL11_SP2_QFE-CU).150417-1510 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/4b749317568942e383ee42a9eb2cf1f41/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5592.00 ((SQL11_SP2_QFE-CU).150417-1510 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/3c59c6073f7d48df91b7abd1828db0c51/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5592.00 ((SQL11_SP2_QFE-CU).150417-1510 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/7f22862851fc4bdca72990a66edb51991/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5592.00 ((SQL11_SP2_QFE-CU).150417-1510 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/e36a38ed3a6146fbaf6216025b206d802/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5592.00 ((SQL11_SP2_QFE-CU).150417-1510 )
```

# SQL Server 2012 SP2 CU5 - 11.0.5582.0 - x64 (3037255)
``` powershell
# SQL Server 2012 SP2 CU5 - 11.0.5582.0 - x64 (3037255)
$outputFolder = 'c:\sqlsyms\11.0.5582.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/8badafbcc6334b139d67b83c61e1ad632/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5582.00 ((SQL11_SP2_QFE-CU).150227-1800 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/c736d839f6f54501a94ccd22ec14d3552/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5582.00 ((SQL11_SP2_QFE-CU).150227-1800 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/d4ed0467cc1944e19589685f554793482/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5582.00 ((SQL11_SP2_QFE-CU).150227-1800 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/4534514aec274addb9f4bacefda3799e2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5582.00 ((SQL11_SP2_QFE-CU).150227-1800 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/556a0a2b1d5d4757aac0242c56f798551/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5582.00 ((SQL11_SP2_QFE-CU).150227-1800 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/3cceaa5cf5684811a0386e715a6aecca1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5582.00 ((SQL11_SP2_QFE-CU).150227-1800 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/b1bc02bf82844ba886d35e2f3dadd38d1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5582.00 ((SQL11_SP2_QFE-CU).150227-1800 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/f4538786cdca4eb789acedeb918639401/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5582.00 ((SQL11_SP2_QFE-CU).150227-1800 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/8358c5a13ecf438890f62b23d94a30f51/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5582.00 ((SQL11_SP2_QFE-CU).150227-1800 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/ae3adbf271aa479fb5256880e575fed22/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5582.00 ((SQL11_SP2_QFE-CU).150227-1800 )
```

# SQL Server 2012 SP2 CU5 - 11.0.5582.0 - x86 (3037255)
``` powershell
# SQL Server 2012 SP2 CU5 - 11.0.5582.0 - x86 (3037255)
$outputFolder = 'c:\sqlsyms\11.0.5582.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/3a47214af54f43b494f0ea53b36d1a3a2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5582.00 ((SQL11_SP2_QFE-CU).150227-1813 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/8b32b6454ee742eb98916880e92325292/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5582.00 ((SQL11_SP2_QFE-CU).150227-1813 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/9bd5f790568b408fa093d1ac93ad5dd92/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5582.00 ((SQL11_SP2_QFE-CU).150227-1813 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/9920c94073c94b9b9334cfac3233e2e92/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5582.00 ((SQL11_SP2_QFE-CU).150227-1813 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/7bd272d1179e4fbd92b9c5863a0133791/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5582.00 ((SQL11_SP2_QFE-CU).150227-1813 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/0ddb45c56e3b41d99a71af72332e241f1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5582.00 ((SQL11_SP2_QFE-CU).150227-1813 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/c3ba2ddbe9f143788b703f9d2d8c7a2c1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5582.00 ((SQL11_SP2_QFE-CU).150227-1813 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/ecce36e5bb034047998a2bd085889c841/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5582.00 ((SQL11_SP2_QFE-CU).150227-1813 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/cb343262158a462f92b23f68d2ae7ac21/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5582.00 ((SQL11_SP2_QFE-CU).150227-1813 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/5a1bf2e1647e44f0815b022eb13ff9232/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5582.00 ((SQL11_SP2_QFE-CU).150227-1813 )
```

# SQL Server 2012 SP2 CU4 - 11.0.5569.0 - x64 (3007556)
``` powershell
# SQL Server 2012 SP2 CU4 - 11.0.5569.0 - x64 (3007556)
$outputFolder = 'c:\sqlsyms\11.0.5569.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/362c792ee0e84038a70ca60e9d73670d2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5569.00 ((SQL11_SP2_QFE-CU).150109-1123 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/a0ca918076554d4c933045287d5096ed2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5569.00 ((SQL11_SP2_QFE-CU).150109-1123 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/77c344284abe4a1886d727f7552e9c952/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5569.00 ((SQL11_SP2_QFE-CU).150109-1123 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/a30fa17e3c414464afa91913f0833c122/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5569.00 ((SQL11_SP2_QFE-CU).150109-1123 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/7fc8dd4807bb420fbc055771e64b95321/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5569.00 ((SQL11_SP2_QFE-CU).150109-1123 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/183074ed7e6a4bb9a13c48ad2a00c3411/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5569.00 ((SQL11_SP2_QFE-CU).150109-1123 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/3984af0d59e8459d83be5e3215e151b91/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5569.00 ((SQL11_SP2_QFE-CU).150109-1123 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/79ebc6f96e85467090f16ccd6efa5f6a1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5569.00 ((SQL11_SP2_QFE-CU).150109-1123 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/384a0f1d64a749e9bac4a0b0d8d203d91/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5569.00 ((SQL11_SP2_QFE-CU).150109-1123 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/99ebd3f774364d7cbd4679ed474886ae2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5569.00 ((SQL11_SP2_QFE-CU).150109-1123 )
```

# SQL Server 2012 SP2 CU4 - 11.0.5569.0 - x86 (3007556)
``` powershell
# SQL Server 2012 SP2 CU4 - 11.0.5569.0 - x86 (3007556)
$outputFolder = 'c:\sqlsyms\11.0.5569.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/0f05bf5e3ab14d13a90d394d10fb3ee32/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5569.00 ((SQL11_SP2_QFE-CU).150109-1126 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/0467323f452c4c889bb8c03eb9245e482/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5569.00 ((SQL11_SP2_QFE-CU).150109-1126 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/8d05289fe8d740979420b0fd5a7676e92/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5569.00 ((SQL11_SP2_QFE-CU).150109-1126 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/29ae6e87132b46b4b78e7965ea7ada3c2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5569.00 ((SQL11_SP2_QFE-CU).150109-1126 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/9fa2ee33584d4ed78ec81f31b1b600481/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5569.00 ((SQL11_SP2_QFE-CU).150109-1126 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/405d1f73f6c94e88a32c71a53ecd1e8e1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5569.00 ((SQL11_SP2_QFE-CU).150109-1126 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/0db139cf45c246d3913b3c3605ec2f651/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5569.00 ((SQL11_SP2_QFE-CU).150109-1126 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/50b739fdeaea477589c02536e8cab5cf1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5569.00 ((SQL11_SP2_QFE-CU).150109-1126 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/ccb38bba52fa4568bc85256b6039d9531/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5569.00 ((SQL11_SP2_QFE-CU).150109-1126 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/3f9b337dac5a40559d2c1d53f33b4dd62/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5569.00 ((SQL11_SP2_QFE-CU).150109-1126 )
```

# SQL Server 2012 SP2 CU3 - 11.0.5556.0 - x64 (3002049)
``` powershell
# SQL Server 2012 SP2 CU3 - 11.0.5556.0 - x64 (3002049)
$outputFolder = 'c:\sqlsyms\11.0.5556.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/d1a00b8b404a457b9d366e7db692612c2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5556.00 ((SQL11_SP2_QFE-CU).141031-1640 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/caa84e0b43e5423dabd502cf51fcef3a2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5556.00 ((SQL11_SP2_QFE-CU).141031-1640 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/692932d983ac4d0cb8b4c5280484f7ee2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5556.00 ((SQL11_SP2_QFE-CU).141031-1640 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/eb5aa259e39446cd8eaf7e75c20ccad22/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5556.00 ((SQL11_SP2_QFE-CU).141031-1640 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/0d5bd32496a14c1db5d2bf51ac4c1e0a1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5556.00 ((SQL11_SP2_QFE-CU).141031-1640 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/c25697387b484c97b22b5f447bb3ac1f1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5556.00 ((SQL11_SP2_QFE-CU).141031-1640 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/ad1f8b1a883a4339a75f54c8dc57fdb31/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5556.00 ((SQL11_SP2_QFE-CU).141031-1640 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/22376adfcdfb44f5af969adecba164911/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5556.00 ((SQL11_SP2_QFE-CU).141031-1640 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/931ba4aa04ce4f42a0fc4d464091f18a1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5556.00 ((SQL11_SP2_QFE-CU).141031-1640 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/ce308e7fe1024a62ac491cf474cec82c2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5556.00 ((SQL11_SP2_QFE-CU).141031-1640 )
```

# SQL Server 2012 SP2 CU3 - 11.0.5556.0 - x86 (3002049)
``` powershell
# SQL Server 2012 SP2 CU3 - 11.0.5556.0 - x86 (3002049)
$outputFolder = 'c:\sqlsyms\11.0.5556.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/5918d9b7678849c49bbb3f5da4e3a0282/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5556.00 ((SQL11_SP2_QFE-CU).141031-1639 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/00b4161353c44d8e8a3f856e666b09162/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5556.00 ((SQL11_SP2_QFE-CU).141031-1639 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/dd70fb9e4d4e45d2b05ab68c33586bdf2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5556.00 ((SQL11_SP2_QFE-CU).141031-1639 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/8a3d1406ad4b4d81a996bc92df9ebcfe2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5556.00 ((SQL11_SP2_QFE-CU).141031-1639 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/de2557533cb84d6c8fb44bd721bc09ca1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5556.00 ((SQL11_SP2_QFE-CU).141031-1639 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/99a6e3ff0cb84daa83b2c919ac45bf3f1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5556.00 ((SQL11_SP2_QFE-CU).141031-1639 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/d8c9218704ce483ea64cb50ae2bc08f11/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5556.00 ((SQL11_SP2_QFE-CU).141031-1639 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/5ffe4b28d77f4236b72eba2f4c36c4901/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5556.00 ((SQL11_SP2_QFE-CU).141031-1639 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/87cd133d6de14b83a0fc51fd0c6731731/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5556.00 ((SQL11_SP2_QFE-CU).141031-1639 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/750a2c62762c42a5bd832b7334954b822/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5556.00 ((SQL11_SP2_QFE-CU).141031-1639 )
```

# SQL Server 2012 SP2 CU2 - 11.0.5548.0 - x64 (2983175)
``` powershell
# SQL Server 2012 SP2 CU2 - 11.0.5548.0 - x64 (2983175)
$outputFolder = 'c:\sqlsyms\11.0.5548.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/99205f110e104780bcd50b13b8b2ef602/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5548.00 ((SQL11_SP2_QFE-CU).140906-1703 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/cae73ab941a5449bb04d577b8ac0ee2e2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5548.00 ((SQL11_SP2_QFE-CU).140906-1703 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/5b7ccbfa58b54a8d80d9fe76d86eead32/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5548.00 ((SQL11_SP2_QFE-CU).140906-1703 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/35f5dd06512c4dae8339badc7b32f1a02/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5548.00 ((SQL11_SP2_QFE-CU).140906-1703 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/07c56b468964456996e7fffcc033ba561/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5548.00 ((SQL11_SP2_QFE-CU).140906-1703 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/f8b575102d5e4845bb73a4713fbd27281/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5548.00 ((SQL11_SP2_QFE-CU).140906-1703 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/f48d51269e1a44bf917c04e47fd3497f1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5548.00 ((SQL11_SP2_QFE-CU).140906-1703 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/380cdbf633f94b8e9f7a15c4a0f05e9c1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5548.00 ((SQL11_SP2_QFE-CU).140906-1703 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/a10eeceb16684e2f97e7bf5b048556ae1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5548.00 ((SQL11_SP2_QFE-CU).140906-1703 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/c7371ee128084547b8cc44cf23daf6322/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5548.00 ((SQL11_SP2_QFE-CU).140906-1703 )
```

# SQL Server 2012 SP2 CU2 - 11.0.5548.0 - x86 (2983175)
``` powershell
# SQL Server 2012 SP2 CU2 - 11.0.5548.0 - x86 (2983175)
$outputFolder = 'c:\sqlsyms\11.0.5548.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/3e037ba29b3e4225ae410c337d79bd8c2/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5548.00 ((SQL11_SP2_QFE-CU).140906-1802 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/b45cf018f0f54771a95e71eaaa28a88e2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5548.00 ((SQL11_SP2_QFE-CU).140906-1802 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/a76a804ec0ba4b76ba58f380668012da2/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5548.00 ((SQL11_SP2_QFE-CU).140906-1802 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/54c5a385aba743edb15be3e62a137c832/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5548.00 ((SQL11_SP2_QFE-CU).140906-1802 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/3165959521524b8eaed9ece7ff68571d1/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5548.00 ((SQL11_SP2_QFE-CU).140906-1802 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/1a52c14e68fa418188349ed428ed814a1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5548.00 ((SQL11_SP2_QFE-CU).140906-1802 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/c4534dd553ae4e1da2fdbb4df151981c1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5548.00 ((SQL11_SP2_QFE-CU).140906-1802 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/a6e6cca281ff419291ad2ce6e8c536881/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5548.00 ((SQL11_SP2_QFE-CU).140906-1802 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/01e271d3affe4c5197beedb3189b46541/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5548.00 ((SQL11_SP2_QFE-CU).140906-1802 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/9d08d936dc3f4b259d73b86191fcd0d32/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5548.00 ((SQL11_SP2_QFE-CU).140906-1802 )
```

# SQL Server 2012 SP2 CU1 - 11.0.5532.0 - x64 (2976982)
``` powershell
# SQL Server 2012 SP2 CU1 - 11.0.5532.0 - x64 (2976982)
$outputFolder = 'c:\sqlsyms\11.0.5532.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/cbf110ac14d94a8cb27f29d7def6e2832/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5532.00 ((SQL11_SP2_QFE-CU).140714-1446 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/5ef74be1c5314aa38320fa24e34e51c72/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5532.00 ((SQL11_SP2_QFE-CU).140714-1446 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/ffb5d83cafba46faa6816b8e6491c4b12/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5532.00 ((SQL11_SP2_QFE-CU).140714-1446 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/5078a04f329147b7978220b06bb870192/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5532.00 ((SQL11_SP2_QFE-CU).140714-1446 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/d7952e1acc294862bda55dd7e4d3e8211/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5532.00 ((SQL11_SP2_QFE-CU).140714-1446 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/5a95d568bac94867b8e0840fd91e50c51/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5532.00 ((SQL11_SP2_QFE-CU).140714-1446 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/6639b1da0ba34639811d5bec9aff80371/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5532.00 ((SQL11_SP2_QFE-CU).140714-1446 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/a8c29cbda99e41fe8e103298736b6a4b1/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5532.00 ((SQL11_SP2_QFE-CU).140714-1446 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/da3edb6b439f4e028581352ace87953f1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5532.00 ((SQL11_SP2_QFE-CU).140714-1446 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/427d00997e8b428bbb7a3e5258acb0f72/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5532.00 ((SQL11_SP2_QFE-CU).140714-1446 )
```

# SQL Server 2012 SP2 CU1 - 11.0.5532.0 - x86 (2976982)
``` powershell
# SQL Server 2012 SP2 CU1 - 11.0.5532.0 - x86 (2976982)
$outputFolder = 'c:\sqlsyms\11.0.5532.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/35685e9861dd48aaae7cc5b16bd328122/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5532.00 ((SQL11_SP2_QFE-CU).140714-1449 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/894411a3cde84440964e7d15e54a42f22/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5532.00 ((SQL11_SP2_QFE-CU).140714-1449 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/b8e311cfe83844efbfa836d7edd0a4c92/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5532.00 ((SQL11_SP2_QFE-CU).140714-1449 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/4dde9c04fa9e48aa8dd99f6253ddde802/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5532.00 ((SQL11_SP2_QFE-CU).140714-1449 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/bc9c1b0188ad4c4694e3fc2b2cc003f51/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5532.00 ((SQL11_SP2_QFE-CU).140714-1449 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/f4e0f97f61954596a55a9127841a84ad1/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5532.00 ((SQL11_SP2_QFE-CU).140714-1449 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/27494563474d41a9b38acc20ae538cae1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5532.00 ((SQL11_SP2_QFE-CU).140714-1449 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/3c69ca79dab742ffa5fd044f1300bbe11/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5532.00 ((SQL11_SP2_QFE-CU).140714-1449 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/4081f3e32c334fb8b9164529b87ccf601/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5532.00 ((SQL11_SP2_QFE-CU).140714-1449 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/4b32834628184e4fa4f9848fa401a19c2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5532.00 ((SQL11_SP2_QFE-CU).140714-1449 )
```

# SQL Server 2012 SP2 SP2 - 11.0.5058.0 - x64 (2958429)
``` powershell
# SQL Server 2012 SP2 SP2 - 11.0.5058.0 - x64 (2958429)
$outputFolder = 'c:\sqlsyms\11.0.5058.0\x64' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/ee0459385983426284e7a607384e4bf62/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5058.00 ((SQL11_PCU_Main).140514-1820 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/fbafcdb326434a41a09d549fbf6e8f062/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5058.00 ((SQL11_PCU_Main).140514-1820 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/587ed8597e30437a8028d1ee025c75d12/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5058.00 ((SQL11_PCU_Main).140514-1820 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/d7a22e5762bd4c94bc2c0af2fc63a1372/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5058.00 ((SQL11_PCU_Main).140514-1820 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/017fa06efaf641d4bba760a5258be5741/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5058.00 ((SQL11_PCU_Main).140514-1820 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/32a91c0b60204fffa1374cf3492a88a01/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5058.00 ((SQL11_PCU_Main).140514-1820 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/0452878b0b30401f814aab0fa4ac74661/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5058.00 ((SQL11_PCU_Main).140514-1820 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/389e963e00f040079eff7b8e2ccc3c911/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5058.00 ((SQL11_PCU_Main).140514-1820 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/0ef93093d4ea4f9d90a21e79f602919d1/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5058.00 ((SQL11_PCU_Main).140514-1820 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/12ec0b5836ca41429c5bce95a1653eaf2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5058.00 ((SQL11_PCU_Main).140514-1820 )
```

# SQL Server 2012 SP2 SP2 - 11.0.5058.0 - x86 (2958429)
``` powershell
# SQL Server 2012 SP2 SP2 - 11.0.5058.0 - x86 (2958429)
$outputFolder = 'c:\sqlsyms\11.0.5058.0\x86' # <<change this output folder if needed>>'
mkdir -f $outputFolder
if (-not (Test-Path "$outputFolder\sqldk.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqldk.pdb/9a6c2fb9f9ad46b7b240b1cd3f7782312/sqldk.pdb' -OutFile "$outputFolder\sqldk.pdb" } # File version 2011.0110.5058.00 ((SQL11_PCU_Main).140514-1623 )
if (-not (Test-Path "$outputFolder\sqlmin.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlmin.pdb/1c6fd82d91f84e9b9ebca1a6a1bfb80d2/sqlmin.pdb' -OutFile "$outputFolder\sqlmin.pdb" } # File version 2011.0110.5058.00 ((SQL11_PCU_Main).140514-1623 )
if (-not (Test-Path "$outputFolder\sqllang.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqllang.pdb/c7c06ee472184be7a264d1450b683ef52/sqllang.pdb' -OutFile "$outputFolder\sqllang.pdb" } # File version 2011.0110.5058.00 ((SQL11_PCU_Main).140514-1623 )
if (-not (Test-Path "$outputFolder\sqltses.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqltses.pdb/004a42376b6e41af95b7280c65021add2/sqltses.pdb' -OutFile "$outputFolder\sqltses.pdb" } # File version 2011.0110.5058.00 ((SQL11_PCU_Main).140514-1623 )
if (-not (Test-Path "$outputFolder\SqlAccess.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SqlAccess.pdb/15004f64c18c48e1b5b1573836f2a7931/SqlAccess.pdb' -OutFile "$outputFolder\SqlAccess.pdb" } # File version 2011.0110.5058.00 ((SQL11_PCU_Main).140514-1623 )
if (-not (Test-Path "$outputFolder\hkruntime.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkruntime.pdb/d5064f709c6f4124a7423ab6fa0ed7f71/hkruntime.pdb' -OutFile "$outputFolder\hkruntime.pdb" } # File version 2011.0110.5058.00 ((SQL11_PCU_Main).140514-1623 )
if (-not (Test-Path "$outputFolder\hkengine.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkengine.pdb/74570a2c5655462e859fe5f6358603ef1/hkengine.pdb' -OutFile "$outputFolder\hkengine.pdb" } # File version 2011.0110.5058.00 ((SQL11_PCU_Main).140514-1623 )
if (-not (Test-Path "$outputFolder\hkcompile.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/hkcompile.pdb/895b174b37d9498496b464b2600219a31/hkcompile.pdb' -OutFile "$outputFolder\hkcompile.pdb" } # File version 2011.0110.5058.00 ((SQL11_PCU_Main).140514-1623 )
if (-not (Test-Path "$outputFolder\SQLOS.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/SQLOS.pdb/366970ac611340e4bd1e6c244d2b30e71/SQLOS.pdb' -OutFile "$outputFolder\SQLOS.pdb" } # File version 2011.0110.5058.00 ((SQL11_PCU_Main).140514-1623 )
if (-not (Test-Path "$outputFolder\sqlservr.pdb")) { Invoke-WebRequest -uri 'https://msdl.microsoft.com/download/symbols/sqlservr.pdb/a4ca976e0f84491eafe73b3195b39c6a2/sqlservr.pdb' -OutFile "$outputFolder\sqlservr.pdb" } # File version 2011.0110.5058.00 ((SQL11_PCU_Main).140514-1623 )
```

