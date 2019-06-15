/*
Author: Michael Petri
Original link: https://gist.github.com/FlogDonkey/3b9851f1c13b94f3f2d26b4ab5b49de0
*/

/*
    Snippet is nuts and bolts for creating/moving to an isolated tempdb drive.
    After you run this, SQL Server must be restarted for it to take effect
*/
DECLARE @debug BIT                 = 1;
DECLARE @DriveSizeGB int           = 40;
DECLARE @FileCount   int           = 9;
DECLARE @RowID       int;
DECLARE @FileSize    varchar(10);
DECLARE @DrivePath   nvarchar(512) = N'T:\' + @@SERVICENAME + '\';

/* Converts GB to MB */
SELECT @DriveSizeGB = @DriveSizeGB * 1000;

/* Splits size by the nine files */
SELECT @FileSize = @DriveSizeGB / @FileCount;

/* Table to house requisite SQL statements that will modify the files to the standardized name, and size */
DECLARE @Command TABLE(
    RowID    int IDENTITY(1, 1)
    ,Command nvarchar(max)
);
INSERT INTO @Command (Command)
SELECT N'ALTER DATABASE tempdb MODIFY FILE (NAME = [' + f.name + N'],' + N' FILENAME = ''' + @DrivePath + f.name
       + CASE
             WHEN f.type = 1 THEN N'.ldf'
             ELSE N'.mdf'
         END + N''', SIZE = ' + @FileSize + ');'
FROM   sys.master_files AS f
WHERE  f.database_id = DB_ID(N'tempdb');
SET @RowID = @@ROWCOUNT

/* If there are less files than indicated in @FileCount, add missing lines as ADD FILE commands */
WHILE @RowID < @FileCount
BEGIN
    INSERT INTO @Command (Command)
    SELECT  N'ALTER DATABASE tempdb ADD FILE (NAME = [temp' + CAST(@RowID AS VARCHAR) + N'],' + N' FILENAME = ''' + @DrivePath + N'temp'+ CAST(@RowID AS varchar(70)) + N'.mdf''' + N', SIZE=' + @FileSize + N');';
    SET @RowID = @RowID + 1;
END

/* Execute each line to process */
WHILE @RowID > 0
BEGIN
    DECLARE @WorkingSQL nvarchar(max);

    SELECT @WorkingSQL = Command
    FROM   @Command
    WHERE  RowID = @RowID;

    IF @debug = 1
    PRINT(@WorkingSQL)
    ELSE
    EXEC (@WorkingSQL);

    SET @RowID = @RowID - 1;
END;
