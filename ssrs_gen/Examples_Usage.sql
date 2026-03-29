/*
=============================================================================
  SSRS Dynamic Report Generator - Usage Examples

  All examples assume the assembly is installed and the SSRS server is at:
    http://myserver/ReportServer

  Adjust server URL, report paths, and credentials for your environment.

  Schema conventions:
    ssrs.*   - stored procedures and functions
    vSys.*   - configuration and log tables
=============================================================================
*/

-- ============================================================================
--  1. LIST AVAILABLE EXPORT FORMATS
-- ============================================================================
SELECT * FROM ssrs.fn_list_export_formats();
/*
  FormatName      | Extension | Description
  ----------------+-----------+----------------------------------------------
  PDF             | .pdf      | Adobe PDF document
  EXCELOPENXML    | .xlsx     | Microsoft Excel 2007+ workbook (Open XML)
  EXCEL           | .xls      | Microsoft Excel 97-2003 workbook
  WORDOPENXML     | .docx     | Microsoft Word 2007+ document (Open XML)
  CSV             | .csv      | Comma-separated values
  ...
*/

-- ============================================================================
--  2. QUERY REPORT PARAMETERS
--     Discover what parameters a report expects before exporting.
-- ============================================================================
EXEC ssrs.get_report_parameters
    @serverUrl  = N'http://myserver/ReportServer',
    @reportPath = N'/Sales/MonthlySalesReport';

-- With explicit credentials:
EXEC ssrs.get_report_parameters
    @serverUrl  = N'http://myserver/ReportServer',
    @reportPath = N'/Sales/MonthlySalesReport',
    @username   = N'reportuser',
    @password   = N'P@ssw0rd',
    @domain     = N'MYDOMAIN';

/*
  Returns columns:
    Name, DataType, Nullable, AllowBlank, MultiValue,
    Prompt, PromptUser, DefaultValues, ValidValues, QueryBased
*/

-- ============================================================================
--  3. EXPORT REPORT TO PDF (return as VARBINARY result set)
-- ============================================================================
EXEC ssrs.export_report
    @serverUrl    = N'http://myserver/ReportServer',
    @reportPath   = N'/Sales/MonthlySalesReport',
    @exportFormat = N'PDF',
    @parameters   = N'Year=2024;Month=12';

-- ============================================================================
--  4. EXPORT REPORT TO EXCEL FILE ON DISK
-- ============================================================================
EXEC ssrs.export_report_to_file
    @serverUrl      = N'http://myserver/ReportServer',
    @reportPath     = N'/Sales/MonthlySalesReport',
    @exportFormat   = N'EXCELOPENXML',
    @parameters     = N'Year=2024;Month=12;Region=East,West',   -- multi-value param
    @outputFilePath = N'D:\SSRS\MonthlySales_Dec2024.xlsx';

-- ============================================================================
--  5. EXPORT USING SCALAR FUNCTION (usable in SELECT / INSERT)
-- ============================================================================

-- Get report as binary data in a SELECT
SELECT
    ssrs.fn_export_report(
        N'http://myserver/ReportServer',
        N'/Sales/MonthlySalesReport',
        N'PDF',
        N'Year=2024;Month=12',
        NULL,   -- deviceInfo
        NULL,   -- username (Windows auth)
        NULL,   -- password
        NULL    -- domain
    ) AS ReportPDF;

-- Save to a table for later retrieval
INSERT INTO dbo.ReportArchive (ReportName, ExportDate, Format, ReportData)
SELECT
    N'MonthlySalesReport',
    GETDATE(),
    N'PDF',
    ssrs.fn_export_report(
        N'http://myserver/ReportServer',
        N'/Sales/MonthlySalesReport',
        N'PDF',
        N'Year=2024;Month=12',
        NULL, NULL, NULL, NULL
    );

-- ============================================================================
--  6. EXPORT REPORT WITH DEVICE INFO (custom page size, margins, etc.)
-- ============================================================================
EXEC ssrs.export_report_to_file
    @serverUrl      = N'http://myserver/ReportServer',
    @reportPath     = N'/Sales/MonthlySalesReport',
    @exportFormat   = N'PDF',
    @parameters     = N'Year=2024;Month=12',
    @outputFilePath = N'D:\SSRS\MonthlySales_A3.pdf',
    @deviceInfo     = N'<DeviceInfo><PageWidth>16.5in</PageWidth><PageHeight>11.7in</PageHeight><MarginTop>0.5in</MarginTop><MarginBottom>0.5in</MarginBottom><MarginLeft>0.5in</MarginLeft><MarginRight>0.5in</MarginRight></DeviceInfo>';

-- ============================================================================
--  7. LIST REPORTS ON THE SERVER
-- ============================================================================

-- List all items in a folder
EXEC ssrs.list_reports
    @serverUrl  = N'http://myserver/ReportServer',
    @folderPath = N'/Sales';

-- List all reports recursively from root
EXEC ssrs.list_reports
    @serverUrl  = N'http://myserver/ReportServer',
    @folderPath = N'/',
    @recursive  = 1;

-- ============================================================================
--  8. BULK EXPORT - Multiple formats at once
-- ============================================================================
EXEC ssrs.bulk_export_report
    @serverUrl    = N'http://myserver/ReportServer',
    @reportPath   = N'/Sales/MonthlySalesReport',
    @formats      = N'PDF,EXCELOPENXML,WORDOPENXML,CSV',
    @parameters   = N'Year=2024;Month=12',
    @outputFolder = N'D:\SSRS\Monthly';

-- ============================================================================
--  9. URL ACCESS METHOD (alternative, works with SharePoint mode too)
-- ============================================================================
EXEC ssrs.export_report_url_access
    @serverUrl      = N'http://myserver/ReportServer',
    @reportPath     = N'/Sales/MonthlySalesReport',
    @exportFormat   = N'PDF',
    @urlParameters  = N'Year=2024&Month=12&Region=East',
    @outputFilePath = N'D:\SSRS\Sales_UrlAccess.pdf';

-- ============================================================================
--  10. SHAREPOINT INTEGRATED MODE
-- ============================================================================
EXEC ssrs.export_report_sharepoint
    @sharePointUrl      = N'http://sharepoint.mycompany.com/sites/reports',
    @reportLibraryPath  = N'/sites/reports/Documents/MonthlySales.rdl',
    @exportFormat       = N'EXCELOPENXML',
    @urlParameters      = N'Year=2024&Month=12',
    @outputFilePath     = N'D:\SSRS\SP_MonthlySales.xlsx',
    @username           = N'spuser',
    @password           = N'P@ssw0rd',
    @domain             = N'MYDOMAIN';

-- ============================================================================
--  11. EMAIL REPORT AS ATTACHMENT
-- ============================================================================
EXEC ssrs.email_report
    @serverUrl    = N'http://myserver/ReportServer',
    @reportPath   = N'/Sales/MonthlySalesReport',
    @exportFormat = N'PDF',
    @parameters   = N'Year=2024&Month=12',
    @smtpServer   = N'smtp.mycompany.com',
    @smtpPort     = 587,
    @smtpUseSsl   = 1,
    @smtpUsername  = N'reports@mycompany.com',
    @smtpPassword  = N'SmtpP@ss',
    @fromAddress  = N'reports@mycompany.com',
    @toAddresses  = N'manager@mycompany.com;director@mycompany.com',
    @ccAddresses  = N'analyst@mycompany.com',
    @subject      = N'Monthly Sales Report - December 2024',
    @body         = N'Please find attached the monthly sales report for December 2024.';

-- ============================================================================
--  12. DATA-DRIVEN EXPORT (batch export from config table)
-- ============================================================================

-- Step 1: Configure export jobs
INSERT INTO vSys.ssrs_export_jobs (JobName, ServerUrl, ReportPath, ExportFormat, Parameters, OutputFilePath, EmailTo, EmailSubject)
VALUES
    (N'Monthly Sales PDF',
     N'http://myserver/ReportServer',
     N'/Sales/MonthlySalesReport',
     N'PDF',
     N'Year=2024&Month=12',
     N'D:\SSRS\{ReportName}_{Date}.pdf',
     N'manager@mycompany.com',
     N'Monthly Sales Report'),

    (N'Inventory Excel',
     N'http://myserver/ReportServer',
     N'/Warehouse/InventoryStatus',
     N'EXCELOPENXML',
     N'WarehouseId=1',
     N'D:\SSRS\{ReportName}_{DateTime}.xlsx',
     NULL,    -- no email
     NULL),

    (N'HR Headcount CSV',
     N'http://myserver/ReportServer',
     N'/HR/HeadcountReport',
     N'CSV',
     N'Department=Engineering&AsOfDate=2024-12-31',
     N'D:\SSRS\HR\{ReportName}_{Date}.csv',
     N'hr@mycompany.com;cfo@mycompany.com',
     N'Headcount Report');

-- Step 2: Run all active jobs
EXEC ssrs.run_all_export_jobs
    @outputFolder  = N'D:\SSRS\Export',
    @smtpServer    = N'smtp.mycompany.com',
    @smtpPort      = 25,
    @smtpFrom      = N'reports@mycompany.com';

-- Step 3: Check export log
SELECT j.JobName, l.Status, l.Message, l.ExportedAt
FROM vSys.ssrs_export_log l
INNER JOIN vSys.ssrs_export_jobs j ON j.JobId = l.JobId
ORDER BY l.ExportedAt DESC;

-- Run with custom query (e.g., only specific jobs)
EXEC ssrs.data_driven_export
    @configQuery     = N'SELECT * FROM vSys.ssrs_export_jobs WHERE JobName LIKE ''%Sales%'' AND IsActive = 1',
    @outputFolder    = N'D:\SSRS\Sales',
    @statusTableName = N'vSys.ssrs_export_log';

-- ============================================================================
--  13. LIST REPORT SUBSCRIPTIONS
-- ============================================================================
EXEC ssrs.list_report_subscriptions
    @serverUrl  = N'http://myserver/ReportServer',
    @reportPath = N'/Sales/MonthlySalesReport';

-- ============================================================================
--  14. VALIDATE FORMAT AND GET EXTENSION (helper functions)
-- ============================================================================
SELECT
    ssrs.fn_is_valid_format(N'PDF')           AS IsPdfValid,      -- 1
    ssrs.fn_is_valid_format(N'JPEG')          AS IsJpegValid,     -- 0
    ssrs.fn_get_format_extension(N'PDF')      AS PdfExt,          -- .pdf
    ssrs.fn_get_format_extension(N'EXCELOPENXML') AS ExcelExt;    -- .xlsx

-- ============================================================================
--  15. DYNAMIC REPORT GENERATION IN A LOOP
--      Export monthly reports for the entire year
-- ============================================================================
DECLARE @month INT = 1;
DECLARE @year INT = 2024;
DECLARE @filePath NVARCHAR(500);

WHILE @month <= 12
BEGIN
    SET @filePath = N'D:\SSRS\Sales_' + CAST(@year AS NVARCHAR)
        + N'_' + RIGHT('0' + CAST(@month AS NVARCHAR), 2) + N'.pdf';

    EXEC ssrs.export_report_to_file
        @serverUrl      = N'http://myserver/ReportServer',
        @reportPath     = N'/Sales/MonthlySalesReport',
        @exportFormat   = N'PDF',
        @parameters     = N'Year=' + @year + N';Month=' + @month,
        @outputFilePath = @filePath;

    SET @month = @month + 1;
END

-- ============================================================================
--  16. SCHEDULE WITH SQL AGENT
--      Create a SQL Agent job step to run data-driven exports on a schedule
-- ============================================================================
/*
  In SQL Agent Job Step (T-SQL type):

  EXEC ssrs.run_all_export_jobs
      @outputFolder  = N'D:\SSRS\Scheduled',
      @smtpServer    = N'smtp.mycompany.com',
      @smtpPort      = 25,
      @smtpFrom      = N'reports@mycompany.com';

  Schedule: Daily at 6:00 AM, or whatever fits your needs.
*/

-- ============================================================================
--  17. PARAMETERIZED DYNAMIC PATH WITH TOKENS
--      OutputFilePath supports these tokens:
--        {ReportName} - extracted from report path
--        {Format}     - export format name
--        {Date}       - yyyyMMdd
--        {DateTime}   - yyyyMMdd_HHmmss
--        {Year}       - 4-digit year
--        {Month}      - 2-digit month
--        {Day}        - 2-digit day
-- ============================================================================
INSERT INTO vSys.ssrs_export_jobs (JobName, ServerUrl, ReportPath, ExportFormat, Parameters, OutputFilePath)
VALUES (N'Dynamic Path Demo',
        N'http://myserver/ReportServer',
        N'/Finance/QuarterlyPnL',
        N'PDF',
        N'Quarter=Q4&Year=2024',
        N'D:\SSRS\{Year}\{Month}\{ReportName}_{DateTime}.{Format}');
