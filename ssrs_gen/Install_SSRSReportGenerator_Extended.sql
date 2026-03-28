/*
=============================================================================
  SSRS Dynamic Report Generator - Extended Features Installation

  Adds to the base assembly:
    - URL Access export method
    - SharePoint integrated mode support
    - Email report as attachment (SMTP)
    - Data-driven export from configuration table
    - Report subscription listing
    - Configuration table creation for data-driven exports
=============================================================================
*/

-- >>> CHANGE THIS to your target database <<<
USE [YourDatabase];
GO

-- ============================================================================
--  Drop existing extended objects if upgrading
-- ============================================================================
IF OBJECT_ID('dbo.ssrs_ExportReportUrlAccess', 'PC') IS NOT NULL
    DROP PROCEDURE dbo.ssrs_ExportReportUrlAccess;
GO
IF OBJECT_ID('dbo.ssrs_ExportReportSharePoint', 'PC') IS NOT NULL
    DROP PROCEDURE dbo.ssrs_ExportReportSharePoint;
GO
IF OBJECT_ID('dbo.ssrs_EmailReport', 'PC') IS NOT NULL
    DROP PROCEDURE dbo.ssrs_EmailReport;
GO
IF OBJECT_ID('dbo.ssrs_DataDrivenExport', 'PC') IS NOT NULL
    DROP PROCEDURE dbo.ssrs_DataDrivenExport;
GO
IF OBJECT_ID('dbo.ssrs_ListReportSubscriptions', 'PC') IS NOT NULL
    DROP PROCEDURE dbo.ssrs_ListReportSubscriptions;
GO
IF EXISTS (SELECT * FROM sys.assemblies WHERE name = 'SSRSReportGeneratorExtended')
    DROP ASSEMBLY SSRSReportGeneratorExtended;
GO

-- ============================================================================
--  Create the extended assembly
-- ============================================================================
CREATE ASSEMBLY SSRSReportGeneratorExtended
FROM 'C:\CLR\SSRSReportGenerator_Extended.dll'
WITH PERMISSION_SET = EXTERNAL_ACCESS;
GO

-- ============================================================================
--  Create extended stored procedures
-- ============================================================================

-- URL Access export
CREATE PROCEDURE dbo.ssrs_ExportReportUrlAccess
    @serverUrl      NVARCHAR(500),
    @reportPath     NVARCHAR(1000),
    @exportFormat   NVARCHAR(50)   = N'PDF',
    @urlParameters  NVARCHAR(MAX)  = NULL,   -- 'Param1=Val1&Param2=Val2'
    @outputFilePath NVARCHAR(1000) = NULL,
    @username       NVARCHAR(256)  = NULL,
    @password       NVARCHAR(256)  = NULL,
    @domain         NVARCHAR(256)  = NULL
AS EXTERNAL NAME SSRSReportGeneratorExtended.SSRSReportGeneratorExtended.ExportReportUrlAccess;
GO

-- SharePoint integrated mode export
CREATE PROCEDURE dbo.ssrs_ExportReportSharePoint
    @sharePointUrl      NVARCHAR(500),
    @reportLibraryPath  NVARCHAR(1000),
    @exportFormat       NVARCHAR(50)   = N'PDF',
    @urlParameters      NVARCHAR(MAX)  = NULL,
    @outputFilePath     NVARCHAR(1000),
    @username           NVARCHAR(256)  = NULL,
    @password           NVARCHAR(256)  = NULL,
    @domain             NVARCHAR(256)  = NULL
AS EXTERNAL NAME SSRSReportGeneratorExtended.SSRSReportGeneratorExtended.ExportReportSharePoint;
GO

-- Email report as attachment
CREATE PROCEDURE dbo.ssrs_EmailReport
    @serverUrl      NVARCHAR(500),
    @reportPath     NVARCHAR(1000),
    @exportFormat   NVARCHAR(50)   = N'PDF',
    @parameters     NVARCHAR(MAX)  = NULL,
    @smtpServer     NVARCHAR(256),
    @smtpPort       INT            = 25,
    @smtpUseSsl     BIT            = 0,
    @smtpUsername   NVARCHAR(256)  = NULL,
    @smtpPassword   NVARCHAR(256)  = NULL,
    @fromAddress    NVARCHAR(256),
    @toAddresses    NVARCHAR(MAX),            -- semicolon-separated
    @ccAddresses    NVARCHAR(MAX)  = NULL,
    @subject        NVARCHAR(500)  = NULL,
    @body           NVARCHAR(MAX)  = NULL,
    @ssrsUsername   NVARCHAR(256)  = NULL,
    @ssrsPassword   NVARCHAR(256)  = NULL,
    @ssrsDomain     NVARCHAR(256)  = NULL
AS EXTERNAL NAME SSRSReportGeneratorExtended.SSRSReportGeneratorExtended.EmailReport;
GO

-- Data-driven export from config table
CREATE PROCEDURE dbo.ssrs_DataDrivenExport
    @configQuery      NVARCHAR(MAX),          -- SQL query returning job rows
    @outputFolder     NVARCHAR(1000) = NULL,
    @smtpServer       NVARCHAR(256)  = NULL,
    @smtpPort         INT            = 25,
    @smtpFrom         NVARCHAR(256)  = NULL,
    @statusTableName  NVARCHAR(256)  = NULL,  -- table to log results
    @ssrsUsername      NVARCHAR(256)  = NULL,
    @ssrsPassword      NVARCHAR(256)  = NULL,
    @ssrsDomain       NVARCHAR(256)  = NULL
AS EXTERNAL NAME SSRSReportGeneratorExtended.SSRSReportGeneratorExtended.DataDrivenExport;
GO

-- List report subscriptions
CREATE PROCEDURE dbo.ssrs_ListReportSubscriptions
    @serverUrl      NVARCHAR(500),
    @reportPath     NVARCHAR(1000),
    @username       NVARCHAR(256)  = NULL,
    @password       NVARCHAR(256)  = NULL,
    @domain         NVARCHAR(256)  = NULL
AS EXTERNAL NAME SSRSReportGeneratorExtended.SSRSReportGeneratorExtended.ListReportSubscriptions;
GO

-- ============================================================================
--  Create configuration tables for data-driven export
-- ============================================================================

-- Job configuration table
IF OBJECT_ID('dbo.ssrs_ExportJobs', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.ssrs_ExportJobs
    (
        JobId           INT IDENTITY(1,1) PRIMARY KEY,
        JobName         NVARCHAR(256)   NOT NULL,
        ServerUrl       NVARCHAR(500)   NOT NULL,
        ReportPath      NVARCHAR(1000)  NOT NULL,
        ExportFormat    NVARCHAR(50)    NOT NULL DEFAULT 'PDF',
        Parameters      NVARCHAR(MAX)   NULL,       -- 'Year=2024&Month=1'
        OutputFilePath  NVARCHAR(1000)  NULL,       -- supports tokens: {ReportName}, {Date}, {DateTime}, {Format}
        EmailTo         NVARCHAR(MAX)   NULL,       -- semicolon-separated
        EmailSubject    NVARCHAR(500)   NULL,
        IsActive        BIT             NOT NULL DEFAULT 1,
        CreatedDate     DATETIME        NOT NULL DEFAULT GETDATE(),
        ModifiedDate    DATETIME        NULL
    );

    PRINT 'Created table dbo.ssrs_ExportJobs';
END
GO

-- Export status/log table
IF OBJECT_ID('dbo.ssrs_ExportLog', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.ssrs_ExportLog
    (
        LogId       INT IDENTITY(1,1) PRIMARY KEY,
        JobId       INT             NOT NULL,
        Status      NVARCHAR(50)    NOT NULL,    -- 'Success' or 'Failed'
        Message     NVARCHAR(MAX)   NULL,
        ExportedAt  DATETIME        NOT NULL DEFAULT GETDATE()
    );

    CREATE NONCLUSTERED INDEX IX_ssrs_ExportLog_JobId
        ON dbo.ssrs_ExportLog (JobId, ExportedAt DESC);

    PRINT 'Created table dbo.ssrs_ExportLog';
END
GO

-- ============================================================================
--  Convenience wrapper: Run all active data-driven export jobs
-- ============================================================================
CREATE OR ALTER PROCEDURE dbo.ssrs_RunAllExportJobs
    @outputFolder   NVARCHAR(1000) = N'C:\Reports\Export',
    @smtpServer     NVARCHAR(256)  = NULL,
    @smtpPort       INT            = 25,
    @smtpFrom       NVARCHAR(256)  = NULL,
    @ssrsUsername    NVARCHAR(256)  = NULL,
    @ssrsPassword   NVARCHAR(256)  = NULL,
    @ssrsDomain     NVARCHAR(256)  = NULL
AS
BEGIN
    SET NOCOUNT ON;

    EXEC dbo.ssrs_DataDrivenExport
        @configQuery     = N'SELECT * FROM dbo.ssrs_ExportJobs WHERE IsActive = 1',
        @outputFolder    = @outputFolder,
        @smtpServer      = @smtpServer,
        @smtpPort        = @smtpPort,
        @smtpFrom        = @smtpFrom,
        @statusTableName = N'dbo.ssrs_ExportLog',
        @ssrsUsername     = @ssrsUsername,
        @ssrsPassword     = @ssrsPassword,
        @ssrsDomain      = @ssrsDomain;
END;
GO

PRINT '=== SSRS Report Generator Extended features installed successfully ===';
GO
