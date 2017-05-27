/*
Author: skreebydba
Original link: https://skreebydba.com/2016/08/09/identifying-object-name-for-create-and-alter-using-fn_dblog
*/

USE YourDatabase;
 
/* Declare local variables and drop temp table if it exists. */
 
IF CHARINDEX('2016',@@VERSION) &amp;gt; 0
BEGIN
 
    DROP TABLE IF EXISTS #logrecords;
 
END
ELSE
BEGIN
 
    IF OBJECT_ID('tempdb..#logrecords') IS NOT NULL
    BEGIN
 
        DROP TABLE #logrecords;
 
    END
END
 
/* Declare local variables */
DECLARE @tranname NVARCHAR(66);
DECLARE @tranid NVARCHAR(28);
DECLARE @loopcount INT = 1;
DECLARE @looplimit INT;
 
/* Set @tranname to the value you are looking for
   This works for CREATE/ALTER VIEW, CREATE TABLE, and ALTER TABLE
   Currently researching other possibilities */
SELECT @tranname = 'ALTER TABLE';
 
/* Get all log records associated with the transaction name specified
   The results contain a row number per transaction, so all occurrences
   of the transaction name will be found */
SELECT  ROW_NUMBER() OVER(PARTITION BY [Transaction ID] ORDER BY [Current LSN]) AS Row,
    [Current LSN], [Transaction ID], [Transaction Name], operation, Context, AllocUnitName, AllocUnitId, PartitionId, [Lock Information]
INTO #logrecords
FROM fn_dblog(NULL,NULL)
WHERE [Transaction ID] IN
    (SELECT [Transaction ID]
    FROM fn_dblog(NULL,NULL)
    WHERE [Transaction Name] = @tranname);
 
SELECT @looplimit = COUNT(*) FROM #logrecords
WHERE [Transaction Name] = @tranname;
 
/* The object id for the object affected is contained in the [Lock Information] column of the second log record of the transaction
   This WHILE loop finds the second row for each transaction and does lots of string manipulation magic to return the object id
   from a string like this:
   HoBt 0:ACQUIRE_LOCK_SCH_M OBJECT: 9:146099561:0
   Once it finds it, it returns the object name */
WHILE @loopcount &amp;lt;= @looplimit
BEGIN
 
    SELECT TOP 1 @tranid = [Transaction ID]
    FROM #logrecords
 
    DECLARE @lockinfo NVARCHAR(300);
    DECLARE @startingposition INT;
    DECLARE @endingposition INT;
    SELECT @lockinfo = REVERSE([Lock Information]), @startingposition = (CHARINDEX(':',REVERSE([Lock Information])) + 1), @endingposition = CHARINDEX(':',REVERSE([Lock Information]),(CHARINDEX(':',REVERSE([Lock Information])) + 1))
    FROM #logrecords
    WHERE Row = 2
    AND [Transaction ID] = @tranid; 
 
    SELECT OBJECT_NAME(REVERSE(SUBSTRING(@lockinfo,(@startingposition),(@endingposition - @startingposition)))) AS ObjectName;
 
    DELETE FROM #logrecords
    WHERE [Transaction ID] = @tranid;
 
    SELECT @loopcount += 1;
 
END
