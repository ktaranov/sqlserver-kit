/*
=============================================================================
  SSRS Dynamic Report Generator - Usage Examples

  Schema conventions:
    ssrs.*   - stored procedures and functions
    vSys.*   - configuration and log tables

  NOTE: NVARCHAR(MAX) parameters on CLR procs cannot have defaults.
        You must pass NULL explicitly for optional MAX params.
=============================================================================
*/

-- ============================================================================
--  1. DISCOVER: What reports exist on the server?
-- ============================================================================

-- List everything under /Sales
EXEC ssrs.list_reports
    @serverUrl  = N'http://myserver/ReportServer',
    @folderPath = N'/Sales';

-- List ALL reports recursively from root
EXEC ssrs.list_reports
    @serverUrl  = N'http://myserver/ReportServer',
    @folderPath = N'/',
    @recursive  = 1;

-- ============================================================================
--  2. DISCOVER: What parameters does a report need?
-- ============================================================================

-- Windows auth (service account)
EXEC ssrs.get_report_parameters
    @serverUrl  = N'http://myserver/ReportServer',
    @reportPath = N'/Sales/MonthlySalesReport';

-- Explicit credentials
EXEC ssrs.get_report_parameters
    @serverUrl  = N'http://myserver/ReportServer',
    @reportPath = N'/Sales/MonthlySalesReport',
    @username   = N'reportuser',
    @password   = N'P@ssw0rd',
    @domain     = N'MYDOMAIN';

/*  Returns:
    Name          | DataType  | Nullable | AllowBlank | MultiValue | Prompt          | DefaultValues | ValidValues
    Year          | Integer   | 0        | 0          | 0          | Report Year     | 2024          | NULL
    Month         | Integer   | 0        | 0          | 0          | Report Month    | 1             | 1=Jan|2=Feb|...
    Region        | String    | 1        | 0          | 1          | Sales Region    | NULL          | East|West|North|South
*/

-- ============================================================================
--  3. EXPORT TO PDF FILE
-- ============================================================================

-- Simple: no parameters, Windows auth
EXEC ssrs.export_report_to_file
    @serverUrl      = N'http://myserver/ReportServer',
    @reportPath     = N'/Sales/MonthlySalesReport',
    @exportFormat   = N'PDF',
    @parameters     = N'Year=2024;Month=12',
    @outputFilePath = N'D:\SSRS\MonthlySales_Dec2024.pdf',
    @deviceInfo     = NULL;

-- ============================================================================
--  4. EXPORT TO EXCEL (.xlsx)
-- ============================================================================

EXEC ssrs.export_report_to_file
    @serverUrl      = N'http://myserver/ReportServer',
    @reportPath     = N'/Sales/MonthlySalesReport',
    @exportFormat   = N'EXCELOPENXML',
    @parameters     = N'Year=2024;Month=12',
    @outputFilePath = N'D:\SSRS\MonthlySales_Dec2024.xlsx',
    @deviceInfo     = NULL;

-- ============================================================================
--  5. EXPORT TO WORD (.docx)
-- ============================================================================

EXEC ssrs.export_report_to_file
    @serverUrl      = N'http://myserver/ReportServer',
    @reportPath     = N'/Finance/QuarterlyPnL',
    @exportFormat   = N'WORDOPENXML',
    @parameters     = N'Quarter=Q4;Year=2024',
    @outputFilePath = N'D:\SSRS\QuarterlyPnL_Q4_2024.docx',
    @deviceInfo     = NULL;

-- ============================================================================
--  6. EXPORT TO CSV
-- ============================================================================

EXEC ssrs.export_report_to_file
    @serverUrl      = N'http://myserver/ReportServer',
    @reportPath     = N'/HR/HeadcountReport',
    @exportFormat   = N'CSV',
    @parameters     = N'Department=Engineering;AsOfDate=2024-12-31',
    @outputFilePath = N'D:\SSRS\Headcount_Engineering.csv',
    @deviceInfo     = NULL;

-- ============================================================================
--  7. MULTI-VALUE PARAMETERS (comma-separated values)
-- ============================================================================

-- Region is a multi-value param accepting East AND West
EXEC ssrs.export_report_to_file
    @serverUrl      = N'http://myserver/ReportServer',
    @reportPath     = N'/Sales/RegionalSalesReport',
    @exportFormat   = N'PDF',
    @parameters     = N'Year=2024;Region=East,West,South',
    @outputFilePath = N'D:\SSRS\RegionalSales_MultiRegion.pdf',
    @deviceInfo     = NULL;

-- ============================================================================
--  8. EXPLICIT CREDENTIALS (SQL auth or cross-domain)
-- ============================================================================

EXEC ssrs.export_report_to_file
    @serverUrl      = N'http://myserver/ReportServer',
    @reportPath     = N'/Sales/MonthlySalesReport',
    @exportFormat   = N'PDF',
    @parameters     = N'Year=2024;Month=12',
    @outputFilePath = N'D:\SSRS\MonthlySales_Auth.pdf',
    @deviceInfo     = NULL,
    @username       = N'reportuser',
    @password       = N'P@ssw0rd',
    @domain         = N'MYDOMAIN';

-- ============================================================================
--  9. CUSTOM PAGE SIZE / MARGINS VIA DEVICE INFO
-- ============================================================================

-- Export to A3 landscape PDF with narrow margins
EXEC ssrs.export_report_to_file
    @serverUrl      = N'http://myserver/ReportServer',
    @reportPath     = N'/Sales/MonthlySalesReport',
    @exportFormat   = N'PDF',
    @parameters     = N'Year=2024;Month=12',
    @outputFilePath = N'D:\SSRS\MonthlySales_A3.pdf',
    @deviceInfo     = N'<DeviceInfo>
                          <PageWidth>16.5in</PageWidth>
                          <PageHeight>11.7in</PageHeight>
                          <MarginTop>0.5in</MarginTop>
                          <MarginBottom>0.5in</MarginBottom>
                          <MarginLeft>0.5in</MarginLeft>
                          <MarginRight>0.5in</MarginRight>
                        </DeviceInfo>';

-- ============================================================================
--  10. RETURN REPORT AS VARBINARY (no file, result set)
-- ============================================================================

-- Returns a single row: ReportData (VARBINARY), Format, SizeBytes
EXEC ssrs.export_report
    @serverUrl    = N'http://myserver/ReportServer',
    @reportPath   = N'/Sales/MonthlySalesReport',
    @exportFormat = N'PDF',
    @parameters   = N'Year=2024;Month=12',
    @deviceInfo   = NULL;

-- ============================================================================
--  11. USE SCALAR FUNCTION IN SELECT / INSERT
-- ============================================================================

-- Inline in a SELECT
SELECT
    ssrs.fn_export_report(
        N'http://myserver/ReportServer',
        N'/Sales/MonthlySalesReport',
        N'PDF',
        N'Year=2024;Month=12',
        NULL,   -- deviceInfo
        NULL,   -- username
        NULL,   -- password
        NULL    -- domain
    ) AS ReportPDF;

-- Archive to a table
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
--  12. REPORT WITH NO PARAMETERS
-- ============================================================================

EXEC ssrs.export_report_to_file
    @serverUrl      = N'http://myserver/ReportServer',
    @reportPath     = N'/Dashboard/ServerHealth',
    @exportFormat   = N'PDF',
    @parameters     = NULL,
    @outputFilePath = N'D:\SSRS\ServerHealth.pdf',
    @deviceInfo     = NULL;

-- ============================================================================
--  13. EXPORT VIA URL ACCESS METHOD
-- ============================================================================

-- Uses URL query string format (ampersand-separated)
EXEC ssrs.export_report_url_access
    @serverUrl      = N'http://myserver/ReportServer',
    @reportPath     = N'/Sales/MonthlySalesReport',
    @exportFormat   = N'PDF',
    @urlParameters  = N'Year=2024&Month=12&Region=East',
    @outputFilePath = N'D:\SSRS\Sales_UrlAccess.pdf';

-- ============================================================================
--  14. BULK EXPORT: multiple formats in one call
-- ============================================================================

-- Generates PDF + Excel + Word + CSV all at once
EXEC ssrs.bulk_export_report
    @serverUrl    = N'http://myserver/ReportServer',
    @reportPath   = N'/Sales/MonthlySalesReport',
    @formats      = N'PDF,EXCELOPENXML,WORDOPENXML,CSV',
    @parameters   = N'Year=2024;Month=12',
    @outputFolder = N'D:\SSRS\Monthly';

-- ============================================================================
--  15. LOOP: Export every month of the year
-- ============================================================================

DECLARE @month INT = 1;
DECLARE @year INT = 2024;
DECLARE @filePath NVARCHAR(500);
DECLARE @params NVARCHAR(200);

WHILE @month <= 12
BEGIN
    SET @params = N'Year=' + CAST(@year AS NVARCHAR) + N';Month=' + CAST(@month AS NVARCHAR);
    SET @filePath = N'D:\SSRS\Sales_' + CAST(@year AS NVARCHAR)
        + N'_' + RIGHT('0' + CAST(@month AS NVARCHAR), 2) + N'.pdf';

    EXEC ssrs.export_report_to_file
        @serverUrl      = N'http://myserver/ReportServer',
        @reportPath     = N'/Sales/MonthlySalesReport',
        @exportFormat   = N'PDF',
        @parameters     = @params,
        @outputFilePath = @filePath,
        @deviceInfo     = NULL;

    SET @month = @month + 1;
END

-- ============================================================================
--  16. DATA-DRIVEN BATCH EXPORT (from config table)
-- ============================================================================

-- Step 1: Add jobs to the config table
INSERT INTO vSys.ssrs_export_jobs
    (JobName, ServerUrl, ReportPath, ExportFormat, Parameters, OutputFilePath, EmailTo, EmailSubject)
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
     NULL,
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

-- Step 3: Check the log
SELECT j.JobName, l.Status, l.Message, l.ExportedAt
FROM vSys.ssrs_export_log l
INNER JOIN vSys.ssrs_export_jobs j ON j.JobId = l.JobId
ORDER BY l.ExportedAt DESC;

-- Run only specific jobs
EXEC ssrs.data_driven_export
    @configQuery     = N'SELECT * FROM vSys.ssrs_export_jobs WHERE JobName LIKE ''%Sales%'' AND IsActive = 1',
    @outputFolder    = N'D:\SSRS\Sales',
    @statusTableName = N'vSys.ssrs_export_log';

-- ============================================================================
--  17. EMAIL REPORT AS ATTACHMENT
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
    @ccAddresses  = NULL,
    @subject      = N'Monthly Sales Report - December 2024',
    @body         = N'Please find attached the monthly sales report for December 2024.';

-- ============================================================================
--  18. HELPER FUNCTIONS
-- ============================================================================

-- List all supported formats
SELECT * FROM ssrs.fn_list_export_formats();

-- Validate a format
SELECT ssrs.fn_is_valid_format(N'PDF')  AS IsPdfValid;       -- 1
SELECT ssrs.fn_is_valid_format(N'JPEG') AS IsJpegValid;      -- 0

-- Get file extension
SELECT ssrs.fn_get_format_extension(N'EXCELOPENXML') AS Ext; -- .xlsx

-- ============================================================================
--  19. LIST REPORT SUBSCRIPTIONS
-- ============================================================================

EXEC ssrs.list_report_subscriptions
    @serverUrl  = N'http://myserver/ReportServer',
    @reportPath = N'/Sales/MonthlySalesReport';

-- ============================================================================
--  20. SHAREPOINT INTEGRATED MODE
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
--  21. SCHEDULE WITH SQL AGENT
-- ============================================================================
/*
  Create a SQL Agent Job with a T-SQL step:

  EXEC ssrs.run_all_export_jobs
      @outputFolder  = N'D:\SSRS\Scheduled',
      @smtpServer    = N'smtp.mycompany.com',
      @smtpPort      = 25,
      @smtpFrom      = N'reports@mycompany.com';

  Schedule: Daily at 6:00 AM, Weekly on Monday, etc.
*/

-- ============================================================================
--  22. DYNAMIC PATH TOKENS
--      Supported in OutputFilePath column of vSys.ssrs_export_jobs:
--        {ReportName} - extracted from report path
--        {Format}     - export format name
--        {Date}       - yyyyMMdd
--        {DateTime}   - yyyyMMdd_HHmmss
--        {Year}       - 4-digit year
--        {Month}      - 2-digit month
--        {Day}        - 2-digit day
-- ============================================================================

INSERT INTO vSys.ssrs_export_jobs
    (JobName, ServerUrl, ReportPath, ExportFormat, Parameters, OutputFilePath)
VALUES
    (N'Dynamic Path Demo',
     N'http://myserver/ReportServer',
     N'/Finance/QuarterlyPnL',
     N'PDF',
     N'Quarter=Q4&Year=2024',
     N'D:\SSRS\{Year}\{Month}\{ReportName}_{DateTime}.pdf');

-- ============================================================================
--  QUICK REFERENCE: Supported Export Formats
-- ============================================================================
/*
  Format Name     | Extension | Description
  ----------------+-----------+----------------------------------------------
  PDF             | .pdf      | Adobe PDF
  EXCELOPENXML    | .xlsx     | Excel 2007+ (Open XML)
  EXCEL           | .xls      | Excel 97-2003
  WORDOPENXML     | .docx     | Word 2007+ (Open XML)
  WORD            | .doc      | Word 97-2003
  CSV             | .csv      | Comma-separated values
  XML             | .xml      | XML data
  HTML4.0         | .html     | HTML 4.0
  HTML5           | .html     | HTML5
  MHTML           | .mhtml    | MIME HTML web archive
  IMAGE           | .tiff     | TIFF image
  PPTX            | .pptx     | PowerPoint 2007+
*/

-- ============================================================================
--  QUICK REFERENCE: Parameter String Formats
-- ============================================================================
/*
  SOAP procs (ssrs.export_report, ssrs.export_report_to_file):
    Semicolon-separated:  'Year=2024;Month=12;Region=East,West'
    Multi-value uses commas within a param

  URL Access procs (ssrs.export_report_url_access):
    Ampersand-separated:  'Year=2024&Month=12&Region=East'
*/
