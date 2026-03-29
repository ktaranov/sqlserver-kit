/*
=============================================================================
  SSRS Dynamic Report Generator - SQL Server CLR Assembly

  Installation Script

  This assembly provides dynamic SSRS report export capabilities directly
  from T-SQL, including:
    - Export reports to PDF, Excel, Word, CSV, XML, HTML, TIFF, MHTML, PPTX
    - Query report parameters (names, types, defaults, valid values)
    - List reports and folders on an SSRS server
    - Render with dynamic parameter binding
    - Save exports to disk or return as VARBINARY(MAX)

  Prerequisites:
    - SQL Server 2012+ with CLR integration enabled
    - Network access from SQL Server to the SSRS server
    - SSRS 2008 R2+ (ReportExecution2005 and ReportService2010 endpoints)

  Build the assembly DLL:
    C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe
      /target:library
      /reference:"C:\Program Files\Microsoft SQL Server\<ver>\SDK\Assemblies\Microsoft.SqlServer.Server.dll"
      /out:SSRSReportGenerator.dll
      SSRSReportGenerator.cs

  Alternatively, reference System.Data.dll which includes Microsoft.SqlServer.Server:
    csc /target:library /out:SSRSReportGenerator.dll SSRSReportGenerator.cs
=============================================================================
*/

USE [master];
GO

-- ============================================================================
--  Step 1: Enable CLR integration and configure security
-- ============================================================================
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
GO

EXEC sp_configure 'clr enabled', 1;
RECONFIGURE;
GO

-- Required for external HTTP calls to the SSRS server
-- Option A: Set database trustworthy (simpler, less secure)
-- Option B: Sign the assembly with a certificate (recommended for production)

-- Option A - Trustworthy approach:
-- ALTER DATABASE [YourDatabase] SET TRUSTWORTHY ON;

-- Option B is demonstrated at the bottom of this script.

-- ============================================================================
--  Step 2: Switch to target database
-- ============================================================================

-- >>> CHANGE THIS to your target database <<<
USE [YourDatabase];
GO

-- ============================================================================
--  Step 3: Create schemas if they do not exist
-- ============================================================================
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'ssrs')
    EXEC('CREATE SCHEMA ssrs');
GO

-- ============================================================================
--  Step 4: Drop existing objects if upgrading
-- ============================================================================
IF OBJECT_ID('ssrs.export_report', 'PC') IS NOT NULL
    DROP PROCEDURE ssrs.export_report;
GO
IF OBJECT_ID('ssrs.export_report_to_file', 'PC') IS NOT NULL
    DROP PROCEDURE ssrs.export_report_to_file;
GO
IF OBJECT_ID('ssrs.get_report_parameters', 'PC') IS NOT NULL
    DROP PROCEDURE ssrs.get_report_parameters;
GO
IF OBJECT_ID('ssrs.list_reports', 'PC') IS NOT NULL
    DROP PROCEDURE ssrs.list_reports;
GO
IF OBJECT_ID('ssrs.fn_export_report', 'FS') IS NOT NULL
    DROP FUNCTION ssrs.fn_export_report;
GO
IF OBJECT_ID('ssrs.fn_get_format_extension', 'FS') IS NOT NULL
    DROP FUNCTION ssrs.fn_get_format_extension;
GO
IF OBJECT_ID('ssrs.fn_is_valid_format', 'FS') IS NOT NULL
    DROP FUNCTION ssrs.fn_is_valid_format;
GO
IF OBJECT_ID('ssrs.fn_list_export_formats', 'IF') IS NOT NULL
    DROP FUNCTION ssrs.fn_list_export_formats;
GO
IF EXISTS (SELECT * FROM sys.assemblies WHERE name = 'SSRSReportGenerator')
    DROP ASSEMBLY SSRSReportGenerator;
GO

-- ============================================================================
--  Step 5: Trust and create the assembly
-- ============================================================================

-- SQL Server 2017+ requires CLR strict security. Use ONE of these approaches:
--
-- Option A: TRUSTWORTHY (simplest, less secure)
--   ALTER DATABASE [YourDatabase] SET TRUSTWORTHY ON;
--
-- Option B: sp_add_trusted_assembly (SQL Server 2017+)
--   Registers the DLL hash so SQL Server trusts it without TRUSTWORTHY ON.
--   Run this BEFORE CREATE ASSEMBLY:
DECLARE @hash VARBINARY(64);
SELECT @hash = HASHBYTES('SHA2_512', BulkColumn)
FROM OPENROWSET(BULK 'C:\CLR\SSRSReportGenerator.dll', SINGLE_BLOB) AS f;

IF NOT EXISTS (SELECT 1 FROM sys.trusted_assemblies WHERE hash = @hash)
    EXEC sys.sp_add_trusted_assembly @hash,
        N'SSRSReportGenerator, version=0.0.0.0, culture=neutral, publickeytoken=null, processorarchitecture=msil';
GO

-- Load from DLL file path (update path to match your environment)
CREATE ASSEMBLY SSRSReportGenerator
FROM 'C:\CLR\SSRSReportGenerator.dll'
WITH PERMISSION_SET = EXTERNAL_ACCESS;
GO

-- ============================================================================
--  Step 6: Create stored procedures
-- ============================================================================

-- 6a. Export a report and return as result set (VARBINARY)
CREATE PROCEDURE ssrs.export_report
    @serverUrl      NVARCHAR(500),
    @reportPath     NVARCHAR(1000),
    @exportFormat   NVARCHAR(50)   = N'PDF',
    @parameters     NVARCHAR(MAX)  = NULL,   -- 'Param1=Val1;Param2=Val2'
    @deviceInfo     NVARCHAR(MAX)  = NULL,   -- optional XML device info
    @username       NVARCHAR(256)  = NULL,
    @password       NVARCHAR(256)  = NULL,
    @domain         NVARCHAR(256)  = NULL
AS EXTERNAL NAME SSRSReportGenerator.SSRSReportGenerator.ExportReport;
GO

-- 6b. Export a report and save to file on disk
CREATE PROCEDURE ssrs.export_report_to_file
    @serverUrl      NVARCHAR(500),
    @reportPath     NVARCHAR(1000),
    @exportFormat   NVARCHAR(50)   = N'PDF',
    @parameters     NVARCHAR(MAX)  = NULL,
    @outputFilePath NVARCHAR(1000),
    @deviceInfo     NVARCHAR(MAX)  = NULL,
    @username       NVARCHAR(256)  = NULL,
    @password       NVARCHAR(256)  = NULL,
    @domain         NVARCHAR(256)  = NULL
AS EXTERNAL NAME SSRSReportGenerator.SSRSReportGenerator.ExportReportToFile;
GO

-- 6c. Get report parameters metadata
CREATE PROCEDURE ssrs.get_report_parameters
    @serverUrl      NVARCHAR(500),
    @reportPath     NVARCHAR(1000),
    @username       NVARCHAR(256)  = NULL,
    @password       NVARCHAR(256)  = NULL,
    @domain         NVARCHAR(256)  = NULL
AS EXTERNAL NAME SSRSReportGenerator.SSRSReportGenerator.GetReportParameters;
GO

-- 6d. List reports and folders on the server
CREATE PROCEDURE ssrs.list_reports
    @serverUrl      NVARCHAR(500),
    @folderPath     NVARCHAR(1000) = N'/',
    @recursive      BIT            = 0,
    @username       NVARCHAR(256)  = NULL,
    @password       NVARCHAR(256)  = NULL,
    @domain         NVARCHAR(256)  = NULL
AS EXTERNAL NAME SSRSReportGenerator.SSRSReportGenerator.ListReports;
GO

-- ============================================================================
--  Step 7: Create scalar functions
-- ============================================================================

-- 7a. Export report as VARBINARY (usable in SELECT)
CREATE FUNCTION ssrs.fn_export_report
(
    @serverUrl      NVARCHAR(500),
    @reportPath     NVARCHAR(1000),
    @exportFormat   NVARCHAR(50),
    @parameters     NVARCHAR(MAX),
    @deviceInfo     NVARCHAR(MAX),
    @username       NVARCHAR(256),
    @password       NVARCHAR(256),
    @domain         NVARCHAR(256)
)
RETURNS VARBINARY(MAX)
AS EXTERNAL NAME SSRSReportGenerator.SSRSReportGenerator.fn_ExportReport;
GO

-- 7b. Get file extension for a format
CREATE FUNCTION ssrs.fn_get_format_extension
(
    @exportFormat   NVARCHAR(50)
)
RETURNS NVARCHAR(10)
AS EXTERNAL NAME SSRSReportGenerator.SSRSReportGenerator.fn_GetFormatExtension;
GO

-- 7c. Validate export format string
CREATE FUNCTION ssrs.fn_is_valid_format
(
    @exportFormat   NVARCHAR(50)
)
RETURNS BIT
AS EXTERNAL NAME SSRSReportGenerator.SSRSReportGenerator.fn_IsValidFormat;
GO

-- ============================================================================
--  Step 8: Create table-valued function
-- ============================================================================

CREATE FUNCTION ssrs.fn_list_export_formats()
RETURNS TABLE
(
    FormatName  NVARCHAR(50),
    Extension   NVARCHAR(10),
    Description NVARCHAR(200)
)
AS EXTERNAL NAME SSRSReportGenerator.SSRSReportGenerator.fn_ListExportFormats;
GO

-- ============================================================================
--  Step 9: Create helper wrapper procedures for common scenarios
-- ============================================================================

-- 9a. Bulk export: export a report in multiple formats at once
CREATE PROCEDURE ssrs.bulk_export_report
    @serverUrl      NVARCHAR(500),
    @reportPath     NVARCHAR(1000),
    @formats        NVARCHAR(500)  = N'PDF,EXCELOPENXML,WORDOPENXML',
    @parameters     NVARCHAR(MAX)  = NULL,
    @outputFolder   NVARCHAR(1000),
    @filePrefix     NVARCHAR(256)  = NULL,
    @username       NVARCHAR(256)  = NULL,
    @password       NVARCHAR(256)  = NULL,
    @domain         NVARCHAR(256)  = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @fmt NVARCHAR(50);
    DECLARE @ext NVARCHAR(10);
    DECLARE @outPath NVARCHAR(1000);
    DECLARE @prefix NVARCHAR(256);
    DECLARE @pos INT;
    DECLARE @remaining NVARCHAR(500);
    DECLARE @timestamp NVARCHAR(20) = REPLACE(REPLACE(REPLACE(
        CONVERT(NVARCHAR(19), GETDATE(), 120), '-', ''), ':', ''), ' ', '_');

    -- Default prefix from report name
    SET @prefix = COALESCE(@filePrefix,
        REVERSE(LEFT(REVERSE(@reportPath),
            CHARINDEX('/', REVERSE(@reportPath)) - 1)));

    -- Ensure output folder ends with backslash
    IF RIGHT(@outputFolder, 1) <> '\'
        SET @outputFolder = @outputFolder + '\';

    SET @remaining = @formats;

    WHILE LEN(@remaining) > 0
    BEGIN
        SET @pos = CHARINDEX(',', @remaining);
        IF @pos = 0
        BEGIN
            SET @fmt = LTRIM(RTRIM(@remaining));
            SET @remaining = '';
        END
        ELSE
        BEGIN
            SET @fmt = LTRIM(RTRIM(LEFT(@remaining, @pos - 1)));
            SET @remaining = SUBSTRING(@remaining, @pos + 1, LEN(@remaining));
        END

        IF LEN(@fmt) > 0 AND ssrs.fn_is_valid_format(@fmt) = 1
        BEGIN
            SET @ext = ssrs.fn_get_format_extension(@fmt);
            SET @outPath = @outputFolder + @prefix + '_' + @timestamp + @ext;

            BEGIN TRY
                EXEC ssrs.export_report_to_file
                    @serverUrl      = @serverUrl,
                    @reportPath     = @reportPath,
                    @exportFormat   = @fmt,
                    @parameters     = @parameters,
                    @outputFilePath = @outPath,
                    @deviceInfo     = NULL,
                    @username       = @username,
                    @password       = @password,
                    @domain         = @domain;
            END TRY
            BEGIN CATCH
                PRINT 'ERROR exporting format ' + @fmt + ': ' + ERROR_MESSAGE();
            END CATCH
        END
        ELSE IF LEN(@fmt) > 0
        BEGIN
            PRINT 'WARNING: Skipping invalid format: ' + @fmt;
        END
    END
END;
GO

-- 9b. Dynamic export using URL Access method (alternative to SOAP)
CREATE PROCEDURE ssrs.export_report_via_url
    @serverUrl      NVARCHAR(500),
    @reportPath     NVARCHAR(1000),
    @exportFormat   NVARCHAR(50)   = N'PDF',
    @parameters     NVARCHAR(MAX)  = NULL,   -- 'Param1=Val1&Param2=Val2' (URL format)
    @outputFilePath NVARCHAR(1000),
    @username       NVARCHAR(256)  = NULL,
    @password       NVARCHAR(256)  = NULL,
    @domain         NVARCHAR(256)  = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Build the URL access string
    -- Format: http://server/ReportServer?/Path/To/Report&rs:Format=PDF&Param1=Val1
    DECLARE @url NVARCHAR(4000);
    DECLARE @formatMap NVARCHAR(50);

    -- Map our format names to rs:Format values
    SET @formatMap = CASE @exportFormat
        WHEN 'EXCELOPENXML' THEN 'EXCELOPENXML'
        WHEN 'EXCEL' THEN 'EXCEL'
        WHEN 'PDF' THEN 'PDF'
        WHEN 'WORDOPENXML' THEN 'WORDOPENXML'
        WHEN 'WORD' THEN 'WORD'
        WHEN 'CSV' THEN 'CSV'
        WHEN 'XML' THEN 'XML'
        WHEN 'HTML4.0' THEN 'HTML4.0'
        WHEN 'HTML5' THEN 'HTML5'
        WHEN 'MHTML' THEN 'MHTML'
        WHEN 'IMAGE' THEN 'IMAGE'
        WHEN 'PPTX' THEN 'PPTX'
        ELSE @exportFormat
    END;

    SET @url = RTRIM(@serverUrl) + '?' + @reportPath
        + '&rs:Format=' + @formatMap
        + '&rs:Command=Render';

    IF @parameters IS NOT NULL AND LEN(@parameters) > 0
        SET @url = @url + '&' + @parameters;

    -- Use the CLR export (SOAP method is more reliable for large reports)
    -- This proc documents the URL access pattern for reference
    PRINT 'URL Access equivalent: ' + @url;

    -- Fall back to SOAP-based export
    -- Convert URL-style params to our semicolon format
    DECLARE @soapParams NVARCHAR(MAX) = REPLACE(@parameters, '&', ';');

    EXEC ssrs.export_report_to_file
        @serverUrl      = @serverUrl,
        @reportPath     = @reportPath,
        @exportFormat   = @exportFormat,
        @parameters     = @soapParams,
        @outputFilePath = @outputFilePath,
        @username       = @username,
        @password       = @password,
        @domain         = @domain;
END;
GO

-- ============================================================================
--  Step 10: Grant permissions (adjust as needed)
-- ============================================================================
/*
GRANT EXECUTE ON ssrs.export_report TO [YourRole];
GRANT EXECUTE ON ssrs.export_report_to_file TO [YourRole];
GRANT EXECUTE ON ssrs.get_report_parameters TO [YourRole];
GRANT EXECUTE ON ssrs.list_reports TO [YourRole];
GRANT EXECUTE ON ssrs.fn_export_report TO [YourRole];
GRANT EXECUTE ON ssrs.fn_get_format_extension TO [YourRole];
GRANT EXECUTE ON ssrs.fn_is_valid_format TO [YourRole];
GRANT SELECT ON ssrs.fn_list_export_formats TO [YourRole];
GRANT EXECUTE ON ssrs.bulk_export_report TO [YourRole];
GRANT EXECUTE ON ssrs.export_report_via_url TO [YourRole];
*/

-- ============================================================================
--  (Optional) Assembly signing for production - avoids TRUSTWORTHY ON
-- ============================================================================
/*
-- Step 1: Create a certificate in master
USE [master];
CREATE CERTIFICATE SSRSReportGeneratorCert
    FROM EXECUTABLE FILE = 'C:\CLR\SSRSReportGenerator.dll'
    WITH SUBJECT = 'SSRS Report Generator CLR Assembly';

-- Step 2: Create a login from the certificate
CREATE LOGIN SSRSReportGeneratorLogin FROM CERTIFICATE SSRSReportGeneratorCert;

-- Step 3: Grant EXTERNAL ACCESS to the login
GRANT EXTERNAL ACCESS ASSEMBLY TO SSRSReportGeneratorLogin;

-- Step 4: In the target database, create a user
USE [YourDatabase];
CREATE USER SSRSReportGeneratorUser FROM LOGIN SSRSReportGeneratorLogin;
*/

PRINT '=== SSRS Report Generator CLR Assembly installed successfully ===';
GO
