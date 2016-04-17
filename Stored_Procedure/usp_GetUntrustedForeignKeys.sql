IF OBJECT_ID('dbo.GetUntrustedForeignKeys', 'P') IS NULL
EXECUTE ('CREATE PROCEDURE dbo.GetUntrustedForeignKeys AS SELECT 1');
GO


ALTER PROCEDURE dbo.GetUntrustedForeignKeys(
    @DbName                     VARCHAR(256) = NULL,
    @_NoTempTableDropBefore     BIT = 0,
    @_NoTempTableDropAtTheEnd   BIT = 0,
    @_NoSelectOnTempTable       BIT = 0
)
AS
/*
Author: Jefferson Elias
Original link: http://www.sqlshack.com/managing-untrusted-foreign-keys/
Exapmle: exec dbo.GetUntrustedForeignKeys
*/
BEGIN

    SET NOCOUNT ON;
    
    DECLARE @tsql           nvarchar(max);            -- text to execute via dynamic SQL
    DECLARE @CurrentDb        VARCHAR(256);
    DECLARE @LineFeed       CHAR(2);

    SET @LineFeed = CHAR(13) + CHAR(10);

    IF(@_NoTempTableDropBefore = 0 AND OBJECT_ID('tempdb..##UntrustedForeignKeysData') IS NOT NULL)
    BEGIN
        EXEC sp_executesql N'DROP TABLE ##UntrustedForeignKeysData;';
    END;

    IF(OBJECT_ID('tempdb..#Databases') IS NOT NULL)
    BEGIN
        exec sp_executesql N'DROP TABLE #Databases';
    END;

    SELECT name
    INTO #Databases
    FROM sys.databases
    WHERE name = isnull(@DbName,name)
    ORDER BY name;
    
    CREATE TABLE ##UntrustedForeignKeysData (
        DbName          VARCHAR(256),
        SchemaName      VARCHAR(256),
        TableName       VARCHAR(256),
        ForeignKeyName  VARCHAR(256),
        DDL2Resolve     AS      'USE ' + QUOTENAME(DbName) +   ';'  + CHAR(13) + CHAR(10)  +  
                                'PRINT ''' + DbName + '.' + SchemaName + '.' + TableName + '(' + ForeignKeyName + ')'';' + CHAR(13) + CHAR(10)+
                                'ALTER TABLE ' + QUOTENAME(SchemaName) + '.' + QUOTENAME(TableName) + ' WITH CHECK CHECK CONSTRAINT ' + QUOTENAME(ForeignKeyName) + ';' 
    );

    SELECT @CurrentDb = MIN(name) FROM #Databases ;

    WHILE (@CurrentDb IS NOT NULL)
    BEGIN
        PRINT @CurrentDb;

        SET @tsql = 'USE ' + @CurrentDb + ';' + @LineFeed +
                    'INSERT INTO ##UntrustedForeignKeysData' + @LineFeed +
                    'SELECT  DB_NAME(), s.name , o.name,i.name' + @LineFeed + 
                    'FROM    sys.foreign_keys i' + @LineFeed +
                    'INNER JOIN sys.objects o ON i.parent_object_id = o.OBJECT_ID' + @LineFeed +
                    'INNER JOIN sys.schemas s ON o.schema_id = s.schema_id' + @LineFeed +
                    'WHERE   i.is_not_trusted = 1' + @LineFeed +
                    'AND i.is_not_for_replication = 0' + @LineFeed +
                    'AND i.is_disabled = 0' + @LineFeed +
                    'ORDER BY o.name ;';
        
        exec sp_executesql @tsql;

        SELECT @CurrentDb = MIN(name) FROM #Databases where name > @CurrentDb;
    END ;

    IF(OBJECT_ID('tempdb..#Databases') IS NOT NULL)
    BEGIN
        exec sp_executesql N'DROP TABLE #Databases';
    END;
    
    IF(@_NoSelectOnTempTable = 0)
    BEGIN 
        SELECT 
            DbName,SchemaName,TableName,ForeignKeyName,DDL2Resolve
        FROM ##UntrustedForeignKeysData;
    END;

    IF(@_NoTempTableDropAtTheEnd = 0 AND OBJECT_ID('tempdb..##UntrustedForeignKeysData') IS NOT NULL)
    BEGIN
        EXEC sp_executesql N'DROP TABLE ##UntrustedForeignKeysData;';
    END;

END
GO
