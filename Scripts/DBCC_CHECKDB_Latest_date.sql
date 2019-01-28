/*
Author: Max Vernon
Original link: https://www.sqlserverscience.com/maintenance/check-dbcc-checkdb/
Source link: https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/DBCC_CHECKDB_Latest_date.sql
Modified: 2018-01-26 18:20 by Konstantin Taranov
*/


SET NOCOUNT ON;

DECLARE @MaxDaysWithoutCheckDB int = 1;

IF OBJECT_ID(N'tempdb..#Results') IS NOT NULL
BEGIN
    DROP TABLE #Results;
END;

CREATE TABLE #Results(
      DatabaseName SYSNAME NULL
    , IsOnline BIT NULL
    , ParentObject varchar(100) NULL
    , [Object] varchar(100) NULL
    , [Field] varchar(100) NULL
    , [Value] varchar(100) NULL
);

DECLARE @cmd NVARCHAR(4000);
DECLARE @dbName SYSNAME;
DECLARE @IsOnline BIT;

DECLARE cur CURSOR LOCAL FORWARD_ONLY STATIC READ_ONLY
FOR
SELECT DBCCCommand = CAST(N'DBCC DBINFO(N''' + d.name + N''') WITH TABLERESULTS;' AS NVARCHAR(500))
    , DatabaseName = d.name
    , IsOnline = CONVERT(BIT, CASE WHEN d.state_desc = 'ONLINE' THEN 1 ELSE 0 END)
FROM sys.databases d
ORDER BY d.name;

OPEN cur;
FETCH NEXT FROM cur INTO @cmd, @dbName, @IsOnline;

WHILE @@FETCH_STATUS = 0
BEGIN
    RAISERROR (@dbName, 0, 1) WITH NOWAIT;
    IF @IsOnline = 1
    BEGIN
        INSERT INTO #Results
            (ParentObject, [Object], [Field], [Value])
        EXEC sp_executesql @cmd;

        UPDATE #Results 
        SET DatabaseName = @dbName
            , IsOnline = @IsOnline
        WHERE DatabaseName IS NULL;
    END
    ELSE
    BEGIN
        INSERT INTO #Results
            (DatabaseName, IsOnline)
        VALUES
            (@dbName, @IsOnline)
    END

    FETCH NEXT FROM cur INTO @cmd, @dbName, @IsOnline;
END

CLOSE cur;
DEALLOCATE cur;

SELECT ServerName = @@SERVERNAME
    , DatabaseName = r.DatabaseName
    , LastKnownGoodDate = CONVERT(DATETIME, r.Value, 120)
    , AtRisk = CASE WHEN DATEDIFF(day, CONVERT(DATETIME, r.Value, 120), GETDATE()) > @MaxDaysWithoutCheckDB THEN 'X' ELSE '' END
    , IsDBOnline = r.IsOnline
FROM #Results r
WHERE r.Field = 'dbi_dbccLastKnownGood'
    OR r.Field IS NULL;
