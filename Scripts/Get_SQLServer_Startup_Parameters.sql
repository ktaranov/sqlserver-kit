DECLARE @RegHive    VARCHAR(50),
        @RegKey     VARCHAR(100);
 
SET @RegHive = 'HKEY_LOCAL_MACHINE';
SET @RegKey  = 'Software\Microsoft\MSSQLSERVER\MSSQLServer\Parameters';
 
-- Get all of the arguments / parameters when starting up the service.
DECLARE @SQLArgs TABLE (
    Value   VARCHAR(50),
    Data    VARCHAR(500),
    ArgNum  AS CONVERT(INTEGER, REPLACE(Value, 'SQLArg', '')));
 
INSERT INTO @SQLArgs
    EXECUTE master.sys.xp_instance_regenumvalues @RegHive, @RegKey;
 
SELECT * FROM @SQLArgs;