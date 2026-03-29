/*
=============================================================================
  SSRS Dynamic Report Generator - Usage Examples

  All examples assume the assembly is installed and the SSRS server is at:
    http://myserver/ReportServer

  Adjust server URL, report paths, and credentials for your environment.
=============================================================================
*/

-- ============================================================================
--  1. LIST AVAILABLE EXPORT FORMATS
-- ============================================================================
SELECT * FROM data_driven_export.ssrs_fn_ListExportFormats();
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
EXEC data_driven_export.ssrs_GetReportParameters
    @serverUrl  = N'http://myserver/ReportServer',
    @reportPath = N'/Sales/MonthlySalesReport';

-- With explicit credentials:
EXEC data_driven_export.ssrs_GetReportParameters
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
EXEC data_driven_export.ssrs_ExportReport
    @serverUrl    = N'http://myserver/ReportServer',
    @reportPath   = N'/Sales/MonthlySalesReport',
    @exportFormat = N'PDF',
    @parameters   = N'Year=2024;Month=12';

-- ============================================================================
--  4. EXPORT REPORT TO EXCEL FILE ON DISK
-- ============================================================================
EXEC data_driven_export.ssrs_ExportReportToFile
    @serverUrl      = N'http://myserver/ReportServer',
    @reportPath     = N'/Sales/MonthlySalesReport',
    @exportFormat   = N'EXCELOPENXML',
    @parameters     = N'Year=2024;Month=12;Region=East,West',   -- multi-value param
    @outputFilePath = N'C:\Reports\MonthlySales_Dec2024.xlsx';

-- ============================================================================
--  5. EXPORT USING SCALAR FUNCTION (usable in SELECT / INSERT)
-- ============================================================================

-- Get report as binary data in a SELECT
SELECT
    data_driven_export.ssrs_fn_ExportReport(
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
INSERT INTO data_driven_export.ReportArchive (ReportName, ExportDate, Format, ReportData)
SELECT
    N'MonthlySalesReport',
    GETDATE(),
    N'PDF',
    data_driven_export.ssrs_fn_ExportReport(
        N'http://myserver/ReportServer',
        N'/Sales/MonthlySalesReport',
        N'PDF',
        N'Year=2024;Month=12',
        NULL, NULL, NULL, NULL
    );

-- ============================================================================
--  6. EXPORT REPORT WITH DEVICE INFO (custom page size, margins, etc.)
-- ============================================================================
EXEC data_driven_export.ssrs_ExportReportToFile
    @serverUrl      = N'http://myserver/ReportServer',
    @reportPath     = N'/Sales/MonthlySalesReport',
    @exportFormat   = N'PDF',
    @parameters     = N'Year=2024;Month=12',
    @outputFilePath = N'C:\Reports\MonthlySales_A3.pdf',
    @deviceInfo     = N'<DeviceInfo><PageWidth>16.5in</PageWidth><PageHeight>11.7in</PageHeight><MarginTop>0.5in</MarginTop><MarginBottom>0.5in</MarginBottom><MarginLeft>0.5in</MarginLeft><MarginRight>0.5in</MarginRight></DeviceInfo>';

-- ============================================================================
--  7. LIST REPORTS ON THE SERVER
-- ============================================================================

-- List all items in a folder
EXEC data_driven_export.ssrs_ListReports
    @serverUrl  = N'http://myserver/ReportServer',
    @folderPath = N'/Sales';

-- List all reports recursively from root
EXEC data_driven_export.ssrs_ListReports
    @serverUrl  = N'http://myserver/ReportServer',
    @folderPath = N'/',
    @recursive  = 1;

-- ============================================================================
--  8. BULK EXPORT - Multiple formats at once
-- ============================================================================
EXEC data_driven_export.ssrs_BulkExportReport
    @serverUrl    = N'http://myserver/ReportServer',
    @reportPath   = N'/Sales/MonthlySalesReport',
    @formats      = N'PDF,EXCELOPENXML,WORDOPENXML,CSV',
    @parameters   = N'Year=2024;Month=12',
    @outputFolder = N'C:\Reports\Monthly';

-- ============================================================================
--  9. URL ACCESS METHOD (alternative, works with SharePoint mode too)
-- ============================================================================
EXEC data_driven_export.ssrs_ExportReportUrlAccess
    @serverUrl      = N'http://myserver/ReportServer',
    @reportPath     = N'/Sales/MonthlySalesReport',
    @exportFormat   = N'PDF',
    @urlParameters  = N'Year=2024&Month=12&Region=East',
    @outputFilePath = N'C:\Reports\Sales_UrlAccess.pdf';

-- ============================================================================
--  10. SHAREPOINT INTEGRATED MODE
-- ============================================================================
EXEC data_driven_export.ssrs_ExportReportSharePoint
    @sharePointUrl      = N'http://sharepoint.mycompany.com/sites/reports',
    @reportLibraryPath  = N'/sites/reports/Documents/MonthlySales.rdl',
    @exportFormat       = N'EXCELOPENXML',
    @urlParameters      = N'Year=2024&Month=12',
    @outputFilePath     = N'C:\Reports\SP_MonthlySales.xlsx',
    @username           = N'spuser',
    @password           = N'P@ssw0rd',
    @domain             = N'MYDOMAIN';

-- ============================================================================
--  11. EMAIL REPORT AS ATTACHMENT
-- ============================================================================
EXEC data_driven_export.ssrs_EmailReport
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
INSERT INTO data_driven_export.ssrs_ExportJobs (JobName, ServerUrl, ReportPath, ExportFormat, Parameters, OutputFilePath, EmailTo, EmailSubject)
VALUES
    (N'Monthly Sales PDF',
     N'http://myserver/ReportServer',
     N'/Sales/MonthlySalesReport',
     N'PDF',
     N'Year=2024&Month=12',
     N'C:\Reports\{ReportName}_{Date}.pdf',
     N'manager@mycompany.com',
     N'Monthly Sales Report'),

    (N'Inventory Excel',
     N'http://myserver/ReportServer',
     N'/Warehouse/InventoryStatus',
     N'EXCELOPENXML',
     N'WarehouseId=1',
     N'C:\Reports\{ReportName}_{DateTime}.xlsx',
     NULL,    -- no email
     NULL),

    (N'HR Headcount CSV',
     N'http://myserver/ReportServer',
     N'/HR/HeadcountReport',
     N'CSV',
     N'Department=Engineering&AsOfDate=2024-12-31',
     N'C:\Reports\HR\{ReportName}_{Date}.csv',
     N'hr@mycompany.com;cfo@mycompany.com',
     N'Headcount Report');

-- Step 2: Run all active jobs
EXEC data_driven_export.ssrs_RunAllExportJobs
    @outputFolder  = N'C:\Reports\Export',
    @smtpServer    = N'smtp.mycompany.com',
    @smtpPort      = 25,
    @smtpFrom      = N'reports@mycompany.com';

-- Step 3: Check export log
SELECT j.JobName, l.Status, l.Message, l.ExportedAt
FROM data_driven_export.ssrs_ExportLog l
INNER JOIN data_driven_export.ssrs_ExportJobs j ON j.JobId = l.JobId
ORDER BY l.ExportedAt DESC;

-- Run with custom query (e.g., only specific jobs)
EXEC data_driven_export.ssrs_DataDrivenExport
    @configQuery     = N'SELECT * FROM data_driven_export.ssrs_ExportJobs WHERE JobName LIKE ''%Sales%'' AND IsActive = 1',
    @outputFolder    = N'C:\Reports\Sales',
    @statusTableName = N'data_driven_export.ssrs_ExportLog';

-- ============================================================================
--  13. LIST REPORT SUBSCRIPTIONS
-- ============================================================================
EXEC data_driven_export.ssrs_ListReportSubscriptions
    @serverUrl  = N'http://myserver/ReportServer',
    @reportPath = N'/Sales/MonthlySalesReport';

-- ============================================================================
--  14. VALIDATE FORMAT AND GET EXTENSION (helper functions)
-- ============================================================================
SELECT
    data_driven_export.ssrs_fn_IsValidFormat(N'PDF')           AS IsPdfValid,      -- 1
    data_driven_export.ssrs_fn_IsValidFormat(N'JPEG')          AS IsJpegValid,     -- 0
    data_driven_export.ssrs_fn_GetFormatExtension(N'PDF')      AS PdfExt,          -- .pdf
    data_driven_export.ssrs_fn_GetFormatExtension(N'EXCELOPENXML') AS ExcelExt;    -- .xlsx

-- ============================================================================
--  15. DYNAMIC REPORT GENERATION IN A LOOP
--      Export monthly reports for the entire year
-- ============================================================================
DECLARE @month INT = 1;
DECLARE @year INT = 2024;
DECLARE @filePath NVARCHAR(500);

WHILE @month <= 12
BEGIN
    SET @filePath = N'C:\Reports\Sales_' + CAST(@year AS NVARCHAR)
        + N'_' + RIGHT('0' + CAST(@month AS NVARCHAR), 2) + N'.pdf';

    EXEC data_driven_export.ssrs_ExportReportToFile
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

  EXEC data_driven_export.ssrs_RunAllExportJobs
      @outputFolder  = N'C:\Reports\Scheduled',
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
INSERT INTO data_driven_export.ssrs_ExportJobs (JobName, ServerUrl, ReportPath, ExportFormat, Parameters, OutputFilePath)
VALUES (N'Dynamic Path Demo',
        N'http://myserver/ReportServer',
        N'/Finance/QuarterlyPnL',
        N'PDF',
        N'Quarter=Q4&Year=2024',
        N'C:\Reports\{Year}\{Month}\{ReportName}_{DateTime}.{Format}');
