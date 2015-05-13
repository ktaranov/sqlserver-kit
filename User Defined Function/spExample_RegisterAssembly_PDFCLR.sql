CREATE PROCEDURE dbo.spExample_RegisterAssembly_PDFCLR
AS
BEGIN
  DECLARE @FilePath varchar(1024)
  SET @FilePath = 'c:\ServerEnvironment\'

  CREATE TABLE #References (AssemblyName sysname, FQFileName varchar(1024))
  INSERT INTO #References (AssemblyName, FQFileName) VALUES ('System.Drawing', 'C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727\System.Drawing.dll')
  INSERT INTO #References (AssemblyName, FQFileName) VALUES ('itextsharp', @FilePath + 'itextsharp.dll')

  DECLARE @DropWrapperSQL varchar(MAX)
  SET @DropWrapperSQL = '
    IF OBJECT_ID(''dbo.udfRenderPDF'') IS NOT NULL BEGIN
      DROP FUNCTION dbo.udfRenderPDF;
    END
  '

  DECLARE @CreateWrapperSQL varchar(MAX)
  SET @CreateWrapperSQL = '
    CREATE FUNCTION [dbo].[udfRenderPDF](
    @TemplatePDF varbinary(MAX),
    @FieldsXML xml
    )
    RETURNS [varbinary](max) WITH EXECUTE AS CALLER
    AS
    EXTERNAL NAME [PDFCLR].[Functions].[RenderPDF]
  '

  --C# Source Code.
  --Paste CLR source in below.  Replace all occurrences a single quote with two single quotes.
  DECLARE @SourceCode nvarchar(MAX)
  SET @SourceCode = '
  //------start of CLR Source------
  using System;
  using System.Data;
  using System.Data.SqlClient;
  using System.Data.SqlTypes;
  using Microsoft.SqlServer.Server;

  ....Rest of C# source code goes here

  //------end of CLR Source------  '


  EXEC dbo.spsysBuildCLRAssembly
    @AssemblyName = 'PDFCLR',
    @FileName = 'PDFCLR_SQLCLR.cs',
    @FilePath = @FilePath,
    @DropWrapperSQL = @DropWrapperSQL,
    @CreateWrapperSQL = @CreateWrapperSQL,
    @SourceCode = @SourceCode
END