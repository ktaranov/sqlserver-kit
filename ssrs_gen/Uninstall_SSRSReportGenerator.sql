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
IF OBJECT_ID('ssrs.run_all_export_jobs', 'P') IS NOT NULL
    DROP PROCEDURE ssrs.run_all_export_jobs;
GO
IF OBJECT_ID('ssrs.bulk_export_report', 'P') IS NOT NULL
    DROP PROCEDURE ssrs.bulk_export_report;
GO
IF OBJECT_ID('ssrs.export_report_via_url', 'P') IS NOT NULL
    DROP PROCEDURE ssrs.export_report_via_url;
GO

-- Drop extended CLR procedures
IF OBJECT_ID('ssrs.export_report_url_access', 'PC') IS NOT NULL
    DROP PROCEDURE ssrs.export_report_url_access;
GO
IF OBJECT_ID('ssrs.export_report_sharepoint', 'PC') IS NOT NULL
    DROP PROCEDURE ssrs.export_report_sharepoint;
GO
IF OBJECT_ID('ssrs.email_report', 'PC') IS NOT NULL
    DROP PROCEDURE ssrs.email_report;
GO
IF OBJECT_ID('ssrs.data_driven_export', 'PC') IS NOT NULL
    DROP PROCEDURE ssrs.data_driven_export;
GO
IF OBJECT_ID('ssrs.list_report_subscriptions', 'PC') IS NOT NULL
    DROP PROCEDURE ssrs.list_report_subscriptions;
GO

-- Drop core CLR procedures
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

-- Drop functions
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

-- Drop assemblies
IF EXISTS (SELECT * FROM sys.assemblies WHERE name = 'SSRSReportGeneratorExtended')
    DROP ASSEMBLY SSRSReportGeneratorExtended;
GO
IF EXISTS (SELECT * FROM sys.assemblies WHERE name = 'SSRSReportGenerator')
    DROP ASSEMBLY SSRSReportGenerator;
GO

-- Optionally drop config tables (uncomment to remove)
/*
IF OBJECT_ID('vSys.ssrs_export_log', 'U') IS NOT NULL
    DROP TABLE vSys.ssrs_export_log;
IF OBJECT_ID('vSys.ssrs_export_jobs', 'U') IS NOT NULL
    DROP TABLE vSys.ssrs_export_jobs;
*/

-- Optionally drop schemas (uncomment to remove)
/*
IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'ssrs')
    DROP SCHEMA ssrs;
IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'vSys')
    DROP SCHEMA vSys;
*/

PRINT '=== SSRS Report Generator uninstalled successfully ===';
GO
