/******************************************************************************
Source link: https://blog.waynesheffield.com/wayne/archive/2017/09/registry-sql-server-startup-parameters/
Author: Wayne Sheffield

Description: Globally enable or disable the specified trace flags.
Use DBCC TRACEON/TRACEOFF to enable or disable trace flags globally,
then adjust the SQL Server instance startup parameters for these trace flags.

SQL Server startup parameters are stored in the registry at:
HKLM\Software\Microsoft\MSSQLSERVER\MSSQLServer\Parameters

To use the xp_instance_reg... XPs, use:
HKLM\Software\Microsoft\MSSQLSERVER\MSSQLServer\Parameters.

Usage:
1. Add the Trace Flags that you want modified to the @TraceFlags table variable.
2. Set the @DebugLevel variable to 1 to see what will happen on your system first.
3. When satisfied with the output, set @DebugLevel to 0 to actually execute the statements.
********************************************************************************
MODIFICATION LOG
********************************************************************************
2016-08-03 WGS Initial Creation.
*******************************************************************************/
SET NOCOUNT ON;

DECLARE @MaxValue INT,
        @SQLCMD VARCHAR(MAX),
        @RegHive VARCHAR(50) = 'HKEY_LOCAL_MACHINE',
        @RegKey VARCHAR(100) = 'Software\Microsoft\MSSQLSERVER\MSSQLServer\Parameters',
        @DebugLevel TINYINT = 1;

DECLARE @TraceFlags TABLE (
    TF INT,
    enable BIT,
    enable_on_startup BIT,
    TF2 AS '-T' + CONVERT(VARCHAR(15), TF)
);
INSERT INTO @TraceFlags (TF, enable, enable_on_startup)
VALUES (1117, 1, 1),
       (1118, 1, 1),
       (1204, 0, 0),
       (1222, 0, 0);

DECLARE @SQLArgs TABLE (
    Value VARCHAR(50),
    Data VARCHAR(500),
    ArgNum AS CONVERT(INT, REPLACE(Value, 'SQLArg', ''))
);
INSERT INTO @SQLArgs
EXEC master.sys.xp_instance_regenumvalues @RegHive, @RegKey;

SELECT @MaxValue = MAX(ArgNum) FROM @SQLArgs;
PRINT 'MaxValue: ' + CAST(@MaxValue AS VARCHAR);

SELECT @SQLCMD = 'DBCC TRACEOFF(' + 
    STUFF((SELECT ',' + CONVERT(VARCHAR(15), TF)
           FROM @TraceFlags
           WHERE enable = 0
           ORDER BY TF
           FOR XML PATH(''), TYPE).value('.','varchar(max)'), 1, 1, '') + ', -1);';
IF @DebugLevel = 0 EXEC (@SQLCMD);
PRINT 'Disable TFs Command: "' + @SQLCMD + '"';

SELECT @SQLCMD = 'DBCC TRACEON(' + 
    STUFF((SELECT ',' + CONVERT(VARCHAR(15), TF)
           FROM @TraceFlags
           WHERE enable = 1
           ORDER BY TF
           FOR XML PATH(''), TYPE).value('.','varchar(max)'), 1, 1, '') + ', -1);';
IF @DebugLevel = 0 EXEC (@SQLCMD);
PRINT 'Enable TFs Command:  "' + @SQLCMD + '"';

DECLARE cSQLParams CURSOR LOCAL FAST_FORWARD FOR
WITH cte AS (
    SELECT * ,
           ROW_NUMBER() OVER (ORDER BY ISNULL(ArgNum, 999999999), TF) - 1 AS RN
    FROM @SQLArgs arg
    FULL OUTER JOIN @TraceFlags tf ON arg.Data = tf.TF2
), cte2 AS (
    SELECT ca.Value, ca.Data,
           ROW_NUMBER() OVER (ORDER BY RN) - 1 AS RN2
    FROM cte
    CROSS APPLY (SELECT ISNULL(Value, 'SQLArg' + CONVERT(VARCHAR(15), RN)), ISNULL(Data, TF2)) ca(Value, Data)
    WHERE ISNULL(enable_on_startup, 1) = 1
)
SELECT 'SQLArg' + CONVERT(VARCHAR(15), RN2) AS Value, Data, MAX(RN2) OVER () AS MaxRN2
FROM cte2
WHERE RN2 > 2
ORDER BY RN2;

DECLARE @Value VARCHAR(50), @Data VARCHAR(500), @MaxRN2 INT;
OPEN cSQLParams;
FETCH NEXT FROM cSQLParams INTO @Value, @Data, @MaxRN2;
WHILE @@FETCH_STATUS = 0 
BEGIN
    IF @DebugLevel = 0 EXEC master.sys.xp_instance_regwrite @RegHive, @RegKey, @Value, 'REG_SZ', @Data;
    PRINT 'EXEC master.sys.xp_instance_regwrite ''' + @RegHive + ''', ''' + @RegKey + ''', ''' + @Value + ''', ''REG_SZ'', ''' + @Data + '''';
    FETCH NEXT FROM cSQLParams INTO @Value, @Data, @MaxRN2;
END;
CLOSE cSQLParams;
DEALLOCATE cSQLParams;

WHILE @MaxValue > @MaxRN2
BEGIN
    SET @Value = 'SQLArg' + CONVERT(VARCHAR(15), @MaxValue);
    IF @DebugLevel = 0 EXEC master.sys.xp_instance_regdeletevalue @RegHive, @RegKey, @Value;
    PRINT 'EXEC master.sys.xp_instance_regdeletevalue ''' + @RegHive + ''', ''' + @RegKey + ''', ''' + @Value + '''';
    SET @MaxValue = @MaxValue - 1;
END;
