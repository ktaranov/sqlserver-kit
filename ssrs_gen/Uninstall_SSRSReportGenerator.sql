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
IF OBJECT_ID('data_driven_export.ssrs_RunAllExportJobs', 'P') IS NOT NULL
    DROP PROCEDURE data_driven_export.ssrs_RunAllExportJobs;
GO
IF OBJECT_ID('data_driven_export.ssrs_BulkExportReport', 'P') IS NOT NULL
    DROP PROCEDURE data_driven_export.ssrs_BulkExportReport;
GO
IF OBJECT_ID('data_driven_export.ssrs_ExportReportViaUrl', 'P') IS NOT NULL
    DROP PROCEDURE data_driven_export.ssrs_ExportReportViaUrl;
GO

-- Drop extended CLR procedures
IF OBJECT_ID('data_driven_export.ssrs_ExportReportUrlAccess', 'PC') IS NOT NULL
    DROP PROCEDURE data_driven_export.ssrs_ExportReportUrlAccess;
GO
IF OBJECT_ID('data_driven_export.ssrs_ExportReportSharePoint', 'PC') IS NOT NULL
    DROP PROCEDURE data_driven_export.ssrs_ExportReportSharePoint;
GO
IF OBJECT_ID('data_driven_export.ssrs_EmailReport', 'PC') IS NOT NULL
    DROP PROCEDURE data_driven_export.ssrs_EmailReport;
GO
IF OBJECT_ID('data_driven_export.ssrs_DataDrivenExport', 'PC') IS NOT NULL
    DROP PROCEDURE data_driven_export.ssrs_DataDrivenExport;
GO
IF OBJECT_ID('data_driven_export.ssrs_ListReportSubscriptions', 'PC') IS NOT NULL
    DROP PROCEDURE data_driven_export.ssrs_ListReportSubscriptions;
GO

-- Drop core CLR procedures
IF OBJECT_ID('data_driven_export.ssrs_ExportReport', 'PC') IS NOT NULL
    DROP PROCEDURE data_driven_export.ssrs_ExportReport;
GO
IF OBJECT_ID('data_driven_export.ssrs_ExportReportToFile', 'PC') IS NOT NULL
    DROP PROCEDURE data_driven_export.ssrs_ExportReportToFile;
GO
IF OBJECT_ID('data_driven_export.ssrs_GetReportParameters', 'PC') IS NOT NULL
    DROP PROCEDURE data_driven_export.ssrs_GetReportParameters;
GO
IF OBJECT_ID('data_driven_export.ssrs_ListReports', 'PC') IS NOT NULL
    DROP PROCEDURE data_driven_export.ssrs_ListReports;
GO

-- Drop functions
IF OBJECT_ID('data_driven_export.ssrs_fn_ExportReport', 'FS') IS NOT NULL
    DROP FUNCTION data_driven_export.ssrs_fn_ExportReport;
GO
IF OBJECT_ID('data_driven_export.ssrs_fn_GetFormatExtension', 'FS') IS NOT NULL
    DROP FUNCTION data_driven_export.ssrs_fn_GetFormatExtension;
GO
IF OBJECT_ID('data_driven_export.ssrs_fn_IsValidFormat', 'FS') IS NOT NULL
    DROP FUNCTION data_driven_export.ssrs_fn_IsValidFormat;
GO
IF OBJECT_ID('data_driven_export.ssrs_fn_ListExportFormats', 'IF') IS NOT NULL
    DROP FUNCTION data_driven_export.ssrs_fn_ListExportFormats;
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
IF OBJECT_ID('data_driven_export.ssrs_ExportLog', 'U') IS NOT NULL
    DROP TABLE data_driven_export.ssrs_ExportLog;
IF OBJECT_ID('data_driven_export.ssrs_ExportJobs', 'U') IS NOT NULL
    DROP TABLE data_driven_export.ssrs_ExportJobs;
*/

-- Optionally drop schema (uncomment to remove)
/*
IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'data_driven_export')
    DROP SCHEMA data_driven_export;
*/

PRINT '=== SSRS Report Generator uninstalled successfully ===';
GO
