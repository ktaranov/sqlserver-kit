IF OBJECT_ID('dbo.sp_Depends', 'P') IS NULL
EXECUTE ('CREATE PROCEDURE dbo.sp_Depends AS SELECT 1');
GO

ALTER PROCEDURE dbo.sp_Depends(
      @objectName  SYSNAME      = N''
    , @objectClass NVARCHAR(60) = N'OBJECT'
    , @debug       BIT          = 0
)
AS
/*
    Program: dbo.sp_depends_v2
    Developer: Manjuke Fernando
    Date: 06.07.2018
*/
BEGIN
    SET NOCOUNT ON;

    DECLARE @Sql AS NVARCHAR(MAX) = N'';

    IF OBJECT_ID(@objectName) IS NULL
    THROW 50001, 'Object with @objectName is not exists in current database!', 1
    ELSE
    IF @debug = 1 PRINT('-- OBJECT_ID = ' + CAST(OBJECT_ID(@objectName) AS NVARCHAR(50)));

    BEGIN TRY
        IF @debug = 1 
        SET @Sql = N'DECLARE @RefObjectName SYSNAME       = N''' + @objectName  + ''';' + CHAR(13) +
                   N'DECLARE @objectClass   NVARCHAR(60) = N''' + @objectClass + ''';'  + CHAR(13);

        SET @Sql = @Sql + 
        N'SELECT CONCAT(sch.[name], ''.'', Obj.[name]) AS [name]
            ,(CASE Obj.type
                WHEN ''C''  THEN ''CHECK constraint''
                WHEN ''D''  THEN ''DEFAULT (constraint or stand-alone)''
                WHEN ''F''  THEN ''FOREIGN KEY constraint''
                WHEN ''PK'' THEN ''PRIMARY KEY constraint''
                WHEN ''R''  THEN ''Rule (old-style, stand-alone)''
                WHEN ''TA'' THEN ''Assembly (CLR-integration) trigger''
                WHEN ''TR'' THEN ''SQL trigger''
                WHEN ''UQ'' THEN ''UNIQUE constraint''
                WHEN ''AF'' THEN ''Aggregate function (CLR)''
                WHEN ''C''  THEN ''CHECK constraint''
                WHEN ''D''  THEN ''DEFAULT (constraint or stand-alone)''
                WHEN ''F''  THEN ''FOREIGN KEY constraint''
                WHEN ''FN'' THEN ''SQL scalar function''
                WHEN ''FS'' THEN ''Assembly (CLR) scalar-function''
                WHEN ''FT'' THEN ''Assembly (CLR) table-valued function''
                WHEN ''IF'' THEN ''SQL inline table-valued function''
                WHEN ''IT'' THEN ''Internal table''
                WHEN ''P''  THEN ''SQL Stored Procedure''
                WHEN ''PC'' THEN ''Assembly (CLR) stored-procedure''
                WHEN ''PG'' THEN ''Plan guide''
                WHEN ''PK'' THEN ''PRIMARY KEY constraint''
                WHEN ''R''  THEN ''Rule (old-style, stand-alone)''
                WHEN ''RF'' THEN ''Replication-filter-procedure''
                WHEN ''S''  THEN ''System base TABLE''
                WHEN ''SN'' THEN ''Synonym''
                WHEN ''SO'' THEN ''Sequence OBJECT''
                WHEN ''U''  THEN ''Table (user-defined)''
                WHEN ''V''  THEN ''VIEW''
                WHEN ''SQ'' THEN ''Service queue''
                WHEN ''TA'' THEN ''Assembly (CLR) DML trigger''
                WHEN ''TF'' THEN ''SQL table-valued-function''
                WHEN ''TR'' THEN ''SQL DML trigger''
                WHEN ''TT'' THEN ''Table type''
                WHEN ''UQ'' THEN ''UNIQUE CONSTRAINT''
                WHEN ''X''  THEN ''Extended stored procedure''
                ELSE ''Undefined''
            END) AS [type]
            , Obj.create_date
            , Obj.modify_date
            , src.referenced_minor_name AS [column]
            , IIF(src.is_selected   = 1, ''yes'', ''no'') AS is_selected
            , IIF(src.is_updated    = 1, ''yes'', ''no'') AS is_updated
            , IIF(src.is_select_all = 1, ''yes'', ''no'') AS is_select_all
            --, IIF(src.is_insert_all = 1, ''yes'', ''no'') AS is_insert_all
        FROM 
            sys.dm_sql_referenced_entities (@RefObjectName, @objectClass) AS src
            JOIN sys.objects AS Obj ON src.referenced_id = Obj.[object_id]
            JOIN sys.schemas AS sch ON sch.[schema_id]   = Obj.[schema_id]
        -- WHERE 1=1
        -- AND src.referenced_minor_name IS NOT NULL
        ;

        SELECT CONCAT(Src.referencing_schema_name, ''.'', Src.referencing_entity_name) AS [name]
            , (CASE Obj.type
                WHEN ''C''  THEN ''CHECK constraint''
                WHEN ''D''  THEN ''DEFAULT (constraint or stand-alone)''
                WHEN ''F''  THEN ''FOREIGN KEY constraint''
                WHEN ''PK'' THEN ''PRIMARY KEY constraint''
                WHEN ''R''  THEN ''Rule (old-style, stand-alone)''
                WHEN ''TA'' THEN ''Assembly (CLR-integration) trigger''
                WHEN ''TR'' THEN ''SQL trigger''
                WHEN ''UQ'' THEN ''UNIQUE constraint''
                WHEN ''AF'' THEN ''Aggregate function (CLR)''
                WHEN ''C'' THEN ''CHECK constraint''
                WHEN ''D'' THEN ''DEFAULT (constraint or stand-alone)''
                WHEN ''F'' THEN ''FOREIGN KEY constraint''
                WHEN ''FN'' THEN ''SQL scalar function''
                WHEN ''FS'' THEN ''Assembly (CLR) scalar-function''
                WHEN ''FT'' THEN ''Assembly (CLR) table-valued function''
                WHEN ''IF'' THEN ''SQL inline table-valued function''
                WHEN ''IT'' THEN ''Internal table''
                WHEN ''P'' THEN ''SQL Stored Procedure''
                WHEN ''PC'' THEN ''Assembly (CLR) stored-procedure''
                WHEN ''PG'' THEN ''Plan guide''
                WHEN ''PK'' THEN ''PRIMARY KEY constraint''
                WHEN ''R'' THEN ''Rule (old-style, stand-alone)''
                WHEN ''RF'' THEN ''Replication-filter-procedure''
                WHEN ''S'' THEN ''System base TABLE''
                WHEN ''SN'' THEN ''Synonym''
                WHEN ''SO'' THEN ''Sequence OBJECT''
                WHEN ''U'' THEN ''Table (user-defined)''
                WHEN ''V'' THEN ''VIEW''
                WHEN ''SQ'' THEN ''Service queue''
                WHEN ''TA'' THEN ''Assembly (CLR) DML trigger''
                WHEN ''TF'' THEN ''SQL table-valued-function''
                WHEN ''TR'' THEN ''SQL DML trigger''
                WHEN ''TT'' THEN ''Table type''
                WHEN ''UQ'' THEN ''UNIQUE CONSTRAINT''
                WHEN ''X''  THEN ''Extended stored procedure''
                ELSE ''Undefined''
            END) AS [type]
            , Obj.create_date
            , Obj.modify_date
        FROM sys.dm_sql_referencing_entities (@RefObjectName, @objectClass) AS Src
        INNER JOIN sys.objects AS Obj ON Obj.[object_id] = Src.referencing_id;';

        IF @debug = 1 
        BEGIN
            PRINT(SUBSTRING(@Sql, 1, 4000));
            PRINT(SUBSTRING(@Sql, 4001, 8000));
        END
        ELSE
        EXEC sp_executesql @Sql
            , N'@RefObjectName AS SYSNAME, @objectClass AS NVARCHAR(60)'
            , @RefObjectName = @objectName
            , @objectClass   = @objectClass;
        
    END TRY

    BEGIN CATCH
        PRINT 'Error: '       + CONVERT(varchar(50), ERROR_NUMBER()) +
              ', Severity: '  + CONVERT(varchar(5), ERROR_SEVERITY()) +
              ', State: '     + CONVERT(varchar(5), ERROR_STATE()) +
              ', Procedure: ' + ISNULL(ERROR_PROCEDURE(), '-') +
              ', Line: '      + CONVERT(varchar(5), ERROR_LINE()) +
              ', User name: ' + CONVERT(sysname, CURRENT_USER);
    END CATCH

END;
GO
