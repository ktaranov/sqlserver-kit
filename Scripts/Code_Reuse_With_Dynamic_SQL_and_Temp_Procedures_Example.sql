/*
<documentation>
  <author>Konstantin Taranov</author>
  <summary>List All Unicode Code Points.</summary>
  <returns>PRINT variables values getted from temporary stored procedures.</returns>
  <created>2019-04-18</created>
  <modified>2019-04-18</modified>
  <version>1.0</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Code_Reuse_With_Dynamic_SQL_and_Temp_Procedures_Example.sql</sourceLink>
</documentation>
*/


BEGIN /* CREATE temporary procedures for reusing TSQL code */
    EXEC sp_executesql N'IF OBJECT_ID(''tempdb..#usp_GetTime'', ''P'') IS NOT NULL DROP PROCEDURE #usp_GetTime;'
    EXEC sp_executesql N'
    CREATE PROCEDURE #usp_GetTime(
        @i VARCHAR(16)
      , @o DATETIME2(7) OUTPUT
    )
    AS
    BEGIN
        SET @o = CASE WHEN @i = ''SYSDATETIME''    THEN SYSDATETIME()
                      WHEN @i = ''SYSUTCDATETIME'' THEN SYSUTCDATETIME()
                 END;
    END;';
    
    EXEC sp_executesql N'IF OBJECT_ID(''tempdb..#usp_GetDuration'', ''P'') IS NOT NULL DROP PROCEDURE #usp_GetDuration;'
    EXEC sp_executesql N'
    CREATE PROCEDURE #usp_GetDuration(
        @datepart  VARCHAR(5)
      , @startdate DATETIME2(7)
      , @enddate   DATETIME2(7)
      , @o INT OUTPUT
    )
    AS
    BEGIN TRY
        SET @o = CASE WHEN @datepart = ''ns''  THEN DATEDIFF(ns,  @startdate, @enddate)
                      WHEN @datepart = ''mcs'' THEN DATEDIFF(mcs, @startdate, @enddate)
                      WHEN @datepart = ''ms''  THEN DATEDIFF(ms,  @startdate, @enddate)
                      WHEN @datepart = ''ss''  THEN DATEDIFF(ss,  @startdate, @enddate)
                      WHEN @datepart = ''mi''  THEN DATEDIFF(mi,  @startdate, @enddate)
                      WHEN @datepart = ''hh''  THEN DATEDIFF(hh,  @startdate, @enddate)
                      WHEN @datepart = ''dd''  THEN DATEDIFF(dd,  @startdate, @enddate)
                      WHEN @datepart = ''wk''  THEN DATEDIFF(wk,  @startdate, @enddate)
                      ELSE 0
                END;
    END TRY

    BEGIN CATCH
    PRINT ''Error: ''       + CONVERT(varchar(50), ERROR_NUMBER())  +
          '', Severity: ''  + CONVERT(varchar(5), ERROR_SEVERITY()) +
          '', State: ''     + CONVERT(varchar(5), ERROR_STATE())    +
          '', Procedure: '' + ISNULL(ERROR_PROCEDURE(), ''-'')        +
          '', Line: ''      + CONVERT(varchar(5), ERROR_LINE())     +
          '', User name: '' + CONVERT(sysname, ORIGINAL_LOGIN())
    PRINT(ERROR_MESSAGE());
    END CATCH;
    ';
END;

DECLARE @startTime        datetime2(7);
DECLARE @dateTimeFunction varchar(16) = 'SYSDATETIME';
EXEC #usp_GetTime @i = @dateTimeFunction, @o = @startTime OUTPUT;

DECLARE @runTimeStamp     datetime2(7) = SYSDATETIME();
DECLARE @finishTime       datetime2(7) = DATEADD(hour, -1, @runTimeStamp);
DECLARE @duration         int;
DECLARE @durationAccuracy varchar(5) = 'ss';

EXEC #usp_GetDuration @datepart = @durationAccuracy, @startdate = @runTimeStamp, @enddate = @finishTime, @o = @duration OUTPUT;

PRINT('@startTime = ' + ISNULL(CAST(@startTime AS varchar(27)), 'IS NULL'));
PRINT('@duration = '  + ISNULL(CAST(@duration  AS varchar(27)), 'IS NULL'));
