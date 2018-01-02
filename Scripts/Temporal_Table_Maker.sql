/*
Author: Bill Fellows
Original link: http://billfellows.blogspot.ru/2017/10/temporal-table-maker.html
*/

DECLARE
    @query nvarchar(4000)
,   @targetSchema sysname = 'dbo_HISTORY'
,   @tableName sysname
,   @targetFileGroup sysname = 'History';

DECLARE
    CSR CURSOR
FAST_FORWARD
FOR
SELECT ALL
    CONCAT(
    'SELECT * FROM '
    ,   S.name
    ,   '.'
    ,   T.name)
,   T.name
FROM 
    sys.schemas AS S
    INNER JOIN sys.tables AS T
    ON T.schema_id = S.schema_id
WHERE
    1=1
    AND S.name = 'dbo'
    AND T.name NOT IN
    (SELECT TI.name FROM sys.schemas AS SI INNER JOIN sys.tables AS TI ON TI.schema_id = SI.schema_id WHERE SI.name = @targetSchema);

OPEN CSR;
FETCH NEXT FROM CSR INTO @query, @tableName;
WHILE @@FETCH_STATUS = 0
BEGIN
    -- do something
    SELECT
        CONCAT
    (
        'CREATE TABLE '
    ,   @targetSchema
    ,   '.'
    ,   @tableName
    ,   '('
    ,   STUFF
        (
            (
            SELECT
                CONCAT
                (
                    ','
                ,   DEDFRS.name
                ,   ' '
                ,   DEDFRS.system_type_name
                ,   ' '
                ,   CASE DEDFRS.is_nullable
                    WHEN 1 THEN ''
                    ELSE 'NOT '
                    END
                ,   'NULL'
                )
            FROM
                sys.dm_exec_describe_first_result_set(@query, N'', 1) AS DEDFRS
            ORDER BY
                DEDFRS.column_ordinal
            FOR XML PATH('')
            )
        ,   1
        ,   1
        ,   ''
        )
        ,   ', SysStartTime datetime2(7) NOT NULL'
        ,   ', SysEndTime datetime2(7) NOT NULL'
        ,   ')'
        ,   ' ON '
        ,   @targetFileGroup
        ,   ';'
        ,   CHAR(13)
        ,   'CREATE CLUSTERED COLUMNSTORE INDEX CCI_'
        ,   @targetSchema
        ,   '_'
        ,   @tableName
        ,   ' ON '
        ,   @targetSchema
        ,   '.'
        ,   @tableName
        ,   ' ON '
        ,   @targetFileGroup
        ,   ';'
        ,   CHAR(13)
        ,   'CREATE NONCLUSTERED INDEX IX_'
        ,   @targetSchema
        ,   '_'
        ,   @tableName
        ,   '_PERIOD_COLUMNS '
        ,   ' ON '
        ,   @targetSchema
        ,   '.'
        ,   @tableName

        ,   '('
        ,   'SysEndTime'
        ,   ',SysStartTime'
        ,   (
                SELECT
                    CONCAT
                    (
                        ','
                    ,   DEDFRS.name
                    )
                FROM
                    sys.dm_exec_describe_first_result_set(@query, N'', 1) AS DEDFRS
                WHERE
                    DEDFRS.is_part_of_unique_key = 1
                ORDER BY
                    DEDFRS.column_ordinal
                FOR XML PATH('')
                )
        ,   ')'
        ,   ' ON '
        ,   @targetFileGroup
        ,   ';'
        ,   CHAR(13)
        ,   'ALTER TABLE '
        ,   'dbo'
        ,   '.'
        ,   @tableName
        ,   ' ADD '
        ,   'SysStartTime datetime2(7) GENERATED ALWAYS AS ROW START HIDDEN'
        ,   ' CONSTRAINT DF_'
        ,   'dbo_'
        ,   @tableName
        ,   '_SysStartTime DEFAULT SYSUTCDATETIME()'
        ,   ', SysEndTime datetime2(7) GENERATED ALWAYS AS ROW END HIDDEN'
        ,   ' CONSTRAINT DF_'
        ,   'dbo_'
        ,   @tableName
        ,   '_SysEndTime DEFAULT DATETIME2FROMPARTS(9999, 12, 31, 23,59, 59,9999999,7)'
        ,   ', PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);'
        ,   CHAR(13)
        ,   'ALTER TABLE '
        ,   'dbo'
        ,   '.'
        ,   @tableName
        ,   ' SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = '
        ,   @targetSchema
        ,   '.'
        ,   @tableName
        ,   '));'

    );

FETCH NEXT FROM CSR INTO @query, @tableName;
END
CLOSE CSR;
DEALLOCATE CSR;
