/*
=============================================================================
  SSRS Dynamic Report Generator - Uninstall Script

  Removes all CLR objects, assemblies, and optionally the config tables.
=============================================================================
*/

-- >>> CHANGE THIS to your target database <<<
USE [YourDatabase];
GO

-- Drop wrapper procedures
IF OBJECT_ID('dbo.ssrs_RunAllExportJobs', 'P') IS NOT NULL
    DROP PROCEDURE dbo.ssrs_RunAllExportJobs;
GO
IF OBJECT_ID('dbo.ssrs_BulkExportReport', 'P') IS NOT NULL
    DROP PROCEDURE dbo.ssrs_BulkExportReport;
GO
IF OBJECT_ID('dbo.ssrs_ExportReportViaUrl', 'P') IS NOT NULL
    DROP PROCEDURE dbo.ssrs_ExportReportViaUrl;
GO

-- Drop extended CLR procedures
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

-- Drop core CLR procedures
IF OBJECT_ID('dbo.ssrs_ExportReport', 'PC') IS NOT NULL
    DROP PROCEDURE dbo.ssrs_ExportReport;
GO
IF OBJECT_ID('dbo.ssrs_ExportReportToFile', 'PC') IS NOT NULL
    DROP PROCEDURE dbo.ssrs_ExportReportToFile;
GO
IF OBJECT_ID('dbo.ssrs_GetReportParameters', 'PC') IS NOT NULL
    DROP PROCEDURE dbo.ssrs_GetReportParameters;
GO
IF OBJECT_ID('dbo.ssrs_ListReports', 'PC') IS NOT NULL
    DROP PROCEDURE dbo.ssrs_ListReports;
GO

-- Drop functions
IF OBJECT_ID('dbo.ssrs_fn_ExportReport', 'FS') IS NOT NULL
    DROP FUNCTION dbo.ssrs_fn_ExportReport;
GO
IF OBJECT_ID('dbo.ssrs_fn_GetFormatExtension', 'FS') IS NOT NULL
    DROP FUNCTION dbo.ssrs_fn_GetFormatExtension;
GO
IF OBJECT_ID('dbo.ssrs_fn_IsValidFormat', 'FS') IS NOT NULL
    DROP FUNCTION dbo.ssrs_fn_IsValidFormat;
GO
IF OBJECT_ID('dbo.ssrs_fn_ListExportFormats', 'IF') IS NOT NULL
    DROP FUNCTION dbo.ssrs_fn_ListExportFormats;
GO

-- Drop assemblies
IF EXISTS (SELECT * FROM sys.assemblies WHERE name = 'SSRSReportGeneratorExtended')
    DROP ASSEMBLY SSRSReportGeneratorExtended;
GO
IF EXISTS (SELECT * FROM sys.assemblies WHERE name = 'SSRSReportGenerator')
    DROP ASSEMBLY SSRSReportGenerator;
GO

-- Optionally drop config tables (uncomment to remove)
/*
IF OBJECT_ID('dbo.ssrs_ExportLog', 'U') IS NOT NULL
    DROP TABLE dbo.ssrs_ExportLog;
IF OBJECT_ID('dbo.ssrs_ExportJobs', 'U') IS NOT NULL
    DROP TABLE dbo.ssrs_ExportJobs;
*/

PRINT '=== SSRS Report Generator uninstalled successfully ===';
GO
