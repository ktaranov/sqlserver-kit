@echo off
REM =============================================================================
REM  SSRS Report Generator CLR Assembly - Build Script
REM
REM  Compiles the C# source files into SQL Server CLR assembly DLLs.
REM  Requires .NET Framework 4.x SDK (csc.exe).
REM =============================================================================

setlocal

REM --- Configuration ---
SET CSC=C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe
SET OUTDIR=C:\CLR
SET SRC_MAIN=SSRSReportGenerator.cs
SET SRC_EXT=SSRSReportGenerator_Extended.cs
SET DLL_MAIN=SSRSReportGenerator.dll
SET DLL_EXT=SSRSReportGenerator_Extended.dll

REM --- Verify compiler exists ---
if not exist "%CSC%" (
    echo ERROR: C# compiler not found at %CSC%
    echo Please update the CSC variable to point to your csc.exe
    exit /b 1
)

REM --- Create output directory ---
if not exist "%OUTDIR%" mkdir "%OUTDIR%"

REM --- Build main assembly ---
echo Building %DLL_MAIN%...
"%CSC%" /target:library /out:"%OUTDIR%\%DLL_MAIN%" /optimize+ /warn:4 "%SRC_MAIN%"
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to compile %SRC_MAIN%
    exit /b 1
)
echo   OK: %OUTDIR%\%DLL_MAIN%

REM --- Build extended assembly ---
echo Building %DLL_EXT%...
"%CSC%" /target:library /out:"%OUTDIR%\%DLL_EXT%" /optimize+ /warn:4 "%SRC_EXT%"
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to compile %SRC_EXT%
    exit /b 1
)
echo   OK: %OUTDIR%\%DLL_EXT%

echo.
echo =============================================================================
echo  Build complete. DLLs are in %OUTDIR%
echo.
echo  Next steps:
echo    1. Run Install_SSRSReportGenerator.sql against your SQL Server
echo    2. Run Install_SSRSReportGenerator_Extended.sql for extended features
echo    3. See Examples_Usage.sql for usage examples
echo =============================================================================

endlocal
