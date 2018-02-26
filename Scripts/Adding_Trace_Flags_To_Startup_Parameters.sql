/******************************************************************************
Source link: https://blog.waynesheffield.com/wayne/archive/2017/09/registry-sql-server-startup-parameters/
Author: Wayne Sheffield

Globally enable / disable the specified trace flags.
Use DBCC TRACEON/TRACEOFF to enable disable globally trace flags, then adjust
the SQL Server instance startup parameters for these trace flags.
 
SQL Server startup parameters are stored in the registry at:
HKLM\Software\Microsoft\Microsoft SQL Server\MSSQL12.SQL2014\MSSQLServer\Parameters
 
To use the xp_instance_reg... XPs, use:
HKLM\Software\Microsoft\MSSQLSERVER\MSSQLServer\Parameters.
 
To use:
1. Add the Trace Flags that you want modified to the @TraceFlags table variable.
2. Set the @DebugLevel variable to 1 to see what will happen on your system first.
3. When satisified what will happen, set @DebugLevel to 0 to actually execute the statements.
********************************************************************************
                               MODIFICATION LOG
********************************************************************************
2016-08-03 WGS Initial Creation.
*******************************************************************************/
SET NOCOUNT ON;
-- Declare and initialize variables.
-- To use with SQL 2005, cannot set the variables in the declare statement.
DECLARE @MaxValue   INTEGER,
        @SQLCMD     VARCHAR(MAX),
        @RegHive    VARCHAR(50),
        @RegKey     VARCHAR(100),
        @DebugLevel TINYINT;
 
SET @RegHive = 'HKEY_LOCAL_MACHINE';
SET @RegKey  = 'Software\Microsoft\MSSQLSERVER\MSSQLServer\Parameters';
SET @DebugLevel = 0;  -- only makes changes if set to zero!
 
-- Add the trace flags that you want changed here.
-- If enable = 1, DBCC TRACEON will be run; if enable = 0 then DBCC TRACEOFF will be run.
-- If enable_on_startup = 1, then this TF will be added to start up on service restart; 
-- If enable_on_startup - 0, then this TF will be removed from starting up service restart
DECLARE @TraceFlags TABLE (
    TF                  INTEGER,
    enable              BIT,
    enable_on_startup   BIT,
    TF2                 AS '-T' + CONVERT(VARCHAR(15), TF)
);
INSERT INTO @TraceFlags (TF, enable, enable_on_startup)
-- To work with SQL 2005, cannot use a table value constructor.
-- So, use SELECT statements with UNION ALL for each TF to modify.
SELECT 1117, 1, 1 UNION ALL
SELECT 1118, 1, 1 UNION ALL
SELECT 1204, 0, 0 UNION ALL
SELECT 1222, 0, 0;


-- Get all of the arguments / parameters when starting up the service.
DECLARE @SQLArgs TABLE (
    Value   VARCHAR(50),
    Data    VARCHAR(500),
    ArgNum  AS CONVERT(INTEGER, REPLACE(Value, 'SQLArg', '')));
INSERT INTO @SQLArgs
    EXECUTE master.sys.xp_instance_regenumvalues @RegHive, @RegKey;


-- Get the highest argument number that is currently set
SELECT  @MaxValue = MAX(ArgNum) 
FROM    @SQLArgs;
RAISERROR('MaxValue: %i', 10, 1, @MaxValue) WITH NOWAIT;
 
-- Disable specified trace flags
SELECT  @SQLCMD = 'DBCC TRACEOFF(' + 
        STUFF((SELECT ',' + CONVERT(VARCHAR(15), TF)
               FROM   @TraceFlags
               WHERE  enable = 0
               ORDER BY TF
               FOR XML PATH(''), TYPE).value('.','varchar(max)')
              ,1,1,'') + ', -1);'

IF @DebugLevel = 0 EXECUTE (@SQLCMD);
RAISERROR('Disable TFs Command: "%s"', 10, 1, @SQLCMD) WITH NOWAIT;

-- Enable specified trace flags
SELECT  @SQLCMD = 'DBCC TRACEON(' + 
        STUFF((SELECT ',' + CONVERT(VARCHAR(15), TF)
               FROM   @TraceFlags
               WHERE  enable = 1
               ORDER BY TF
               FOR XML PATH(''), TYPE).value('.','varchar(max)')
              ,1,1,'') + ', -1);'
 
IF @DebugLevel = 0 EXECUTE (@SQLCMD);
RAISERROR('Enable TFs Command:  "%s"', 10, 1, @SQLCMD) WITH NOWAIT;

DECLARE cSQLParams CURSOR LOCAL FAST_FORWARD FOR
WITH cte AS
(
    -- Current arguments, with new TFs added at the end. Get a row number to sort by.
    SELECT  *,
            ROW_NUMBER() OVER (ORDER BY ISNULL(ArgNum, 999999999), TF) - 1 AS RN
    FROM    @SQLArgs arg
    FULL OUTER JOIN @TraceFlags tf ON arg.Data = tf.TF2
), cte2 AS
(
    -- Use the row number to calc the SQLArg# for new TFs. 
    -- Use the original Value (SQLArg#) and Data for all rows if possible, 
    -- Otherwise use the calculated SQLArg# and the calculated TF2 column.
    -- Only get the original non-TF-matched parameters, and the TFs set to be enabled
    -- (existing startup TFs not in @TraceFlags are left alone).
    SELECT  ca.Value,
            ca.Data
            -- in case any TFs are removed, calculate new row numbers in order 
            -- to renumber the SQLArg values
            , ROW_NUMBER() OVER (ORDER BY RN) - 1 AS RN2
    FROM    cte
            -- Again, for SQL 2005, use SELECT statement instead of VALUES.
            CROSS APPLY (SELECT ISNULL(Value, 'SQLArg' + CONVERT(VARCHAR(15), RN)), 
                                ISNULL(Data, TF2) ) ca(Value, Data)
    WHERE   ISNULL(enable_on_startup, 1) = 1  -- ISNULL handles non-TF parameters
)
-- The first three parameters are the location of the errorlog directory,
-- and the master database file locations. Ignore these.
-- This returns the remaining parameters that should be set.
-- Also return the highest number of parameters, so can determine if any need to be deleted.
SELECT  'SQLArg' + CONVERT(VARCHAR(15), RN2) AS Value,
        Data,
        MAX(RN2) OVER () AS MaxRN2
FROM    cte2
WHERE   RN2 > 2
ORDER BY RN2;
 
DECLARE @Value VARCHAR(50),
        @Data  VARCHAR(500),
        @MaxRN2 INTEGER;
OPEN cSQLParams;
FETCH NEXT FROM cSQLParams INTO @Value, @Data, @MaxRN2;
WHILE @@FETCH_STATUS = 0 
BEGIN
    IF @DebugLevel = 0 EXECUTE master.sys.xp_instance_regwrite @RegHive, @RegKey, @Value, 'REG_SZ', @Data;
    RAISERROR('EXECUTE master.sys.xp_instance_regwrite ''%s'', ''%s'', ''%s'', ''REG_SZ'', ''%s''', 10, 1, @RegHive, @RegKey, @Value, @Data) WITH NOWAIT;
    FETCH NEXT FROM cSQLParams INTO @Value, @Data, @MaxRN2;
END;
CLOSE cSQLParams;
DEALLOCATE cSQLParams;

-- In case deleting more TFs than added, there may be extra SQLArg values left behind. 
-- Need to delete the extras now.
WHILE @MaxValue > @MaxRN2
BEGIN
  SET @Value = 'SQLArg' + CONVERT(VARCHAR(15), @MaxValue);
  IF @DebugLevel = 0 EXECUTE master.sys.xp_instance_regdeletevalue @RegHive, @RegKey, @Value;
    RAISERROR('EXECUTE master.sys.xp_instance_regdeletevalue ''%s'', ''%s'', ''%s''', 10, 1, @RegHive, @RegKey, @Value) WITH NOWAIT;
  SET @MaxValue = @MaxValue - 1;
END;
