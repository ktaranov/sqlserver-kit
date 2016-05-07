/*
Author: Paul S. Randal
Original link: http://www.sqlskills.com/blogs/paul/code-to-analyze-the-transaction-hierarchy-in-the-log/
*/
/*============================================================================
  File:     usp_SQLskillsAnalyzeLog.sql

  Summary:  This script cracks the transaction log and prints a hierarchy of
            transactions

  SQL Server Versions: 2012 onwards
------------------------------------------------------------------------------
  Written by Paul S. Randal, SQLskills.com

  (c) 2016, SQLskills.com. All rights reserved.

  For more scripts and sample code, check out 
    http://www.SQLskills.com

  You may alter this code for your own *non-commercial* purposes. You may
  republish altered code as long as you include this copyright and give due
  credit, but you must obtain prior permission before blogging this code.
  
  THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF 
  ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED 
  TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
  PARTICULAR PURPOSE.
============================================================================*/
IF OBJECT_ID(N'dbo.usp_SQLskillsAnalyzeLog', 'P') IS NULL
EXECUTE ('CREATE PROCEDURE dbo.usp_SQLskillsAnalyzeLog AS SELECT 1');
GO

IF OBJECT_ID(N'dbo.usp_SQLskillsAnalyzeLogInner', 'P') IS NULL
EXECUTE ('CREATE PROCEDURE dbo.usp_SQLskillsAnalyzeLogInner AS SELECT 1');
GO

ALTER PROCEDURE dbo.usp_SQLskillsAnalyzeLogInner (
    @XactID AS CHAR (13),
    @Depth AS INT)
AS
BEGIN
    DECLARE @String VARCHAR (8000);
    DECLARE @InsertString VARCHAR (8000);
    DECLARE @Name VARCHAR (256);
    DECLARE @ID INT;

    DECLARE @SubXactID CHAR (13);
    DECLARE @SubDepth INT = @Depth + 3;

    DECLARE [LogAnalysisX] CURSOR FAST_FORWARD LOCAL FOR
    SELECT [Transaction ID], [Transaction Name]
    FROM ##SQLskills_Log_Analysis
    WHERE [Parent Transaction ID] = @XactID;

    OPEN [LogAnalysisX];

    FETCH NEXT FROM [LogAnalysisX] INTO @SubXactID, @Name;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @InsertString = REPLICATE ('.', @Depth) + @Name;

        -- Select the last transaction name inserted into the table
        SELECT TOP 1
            @ID = [ID],
            @String = [XactName]
        FROM
            ##SQLskills_Log_Analysis2
        ORDER BY [ID] DESC;

        IF @String = @InsertString
            UPDATE
                ##SQLskills_Log_Analysis2
            SET
                [Times] = [Times] + 1
            WHERE
                [ID] = @ID;
        ELSE
            INSERT INTO ##SQLskills_Log_Analysis2
            VALUES (@InsertString, 1);

        -- Recurse...
        EXEC usp_SQLskillsAnalyzeLogInner @SubXactID, @SubDepth;

        FETCH NEXT FROM [LogAnalysisX] INTO @SubXactID, @Name;
    END;

    CLOSE [LogAnalysisX];
    DEALLOCATE [LogAnalysisX];
END
GO

ALTER PROCEDURE dbo.usp_SQLskillsAnalyzeLog (
    -- The name of a database, default of master
    @DBName AS sysname = N'master',

    -- Detailed = 0 means just the transaction name
    -- Detailed = 1 means time and user
    @Detailed AS INT = 0,

    -- Deep = 0 means only the top-level transactions
    -- Deep = 1 means sub-transaction hierarchy (slow!)
    @Deep AS INT = 0,

    -- PrintOption = 0 means SELECT as a resultset
    -- PrintOption = 1 means PRINT as text
    @PrintOption VARCHAR (25) = 0)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM [tempdb].[sys].[objects]
        WHERE [name] = N'##SQLskills_Log_Analysis')
        DROP TABLE [##SQLskills_Log_Analysis];

    IF EXISTS (SELECT * FROM [tempdb].[sys].[objects]
        WHERE [name] = N'##SQLskills_Log_Analysis2')
        DROP TABLE [##SQLskills_Log_Analysis2];

    -- Only get the detailed info if we need it
    IF @Detailed = 1
        EXEC ('USE ' + @DBName + ';' +
            'SELECT [Transaction ID], [Transaction Name], [Parent Transaction ID],' +
            '[Begin Time], SUSER_SNAME ([Transaction SID]) AS [Who] ' +
            'INTO ##SQLskills_Log_Analysis FROM fn_dblog (null,null) ' +
            'WHERE [Operation] = ''LOP_BEGIN_XACT'';');
    ELSE
        EXEC ('USE ' + @DBName + ';' +
            'SELECT [Transaction ID], [Transaction Name], [Parent Transaction ID],' +
            'NULL AS [Begin Time], NULL AS [Who]' +
            'INTO ##SQLskills_Log_Analysis FROM fn_dblog (null,null) ' +
            'WHERE [Operation] = ''LOP_BEGIN_XACT'';');
    

    CREATE TABLE ##SQLskills_Log_Analysis2 (
        [ID]        INT IDENTITY,
        [XactName]    VARCHAR (8000),
        [Times]        INT);

    CREATE CLUSTERED INDEX [ID_CL]
    ON ##SQLskills_Log_Analysis2 ([ID]);

    -- Insert a dummy row to make the loop logic simpler
    INSERT INTO ##SQLskills_Log_Analysis2
    VALUES ('PSRDummy', 1);

    -- Calculate the transaction hierarchy
    DECLARE @XactID        CHAR (13);
    DECLARE @Name        VARCHAR (256);
    DECLARE @Begin        VARCHAR (100);
    DECLARE @Who        VARCHAR (100);
    DECLARE @String        VARCHAR (8000);
    DECLARE @ID            INT;
    DECLARE @Counter    INT;

    DECLARE [LogAnalysis] CURSOR FAST_FORWARD FOR
    SELECT
        [Transaction ID], [Transaction Name], [Begin Time], [Who]
    FROM
        ##SQLskills_Log_Analysis
    WHERE
        [Parent Transaction ID] IS NULL;

    OPEN [LogAnalysis];

    FETCH NEXT FROM [LogAnalysis] INTO @XactID, @Name, @Begin, @Who;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Select the last transaction name inserted into the table
        SELECT TOP 1
            @ID = [ID],
            @String = [XactName]
        FROM
            ##SQLskills_Log_Analysis2
        ORDER BY ID DESC;

        -- If it's the same as we're about to insert, update the counter,
        -- otherwise insert the new transaction name
        IF @String = @Name
            UPDATE
                ##SQLskills_Log_Analysis2
            SET
                [Times] = [Times] + 1
            WHERE
                [ID] = @ID;
        ELSE
        BEGIN
            SELECT @String = @Name;

            -- Add detail if necessary
            IF @Detailed = 1
            BEGIN
                -- Do this separately in case CONCAT_NULL_YIELDS_NULL is set
                IF @WHO IS NOT NULL
                     SELECT @String = @String + ' by ' + @Who;

                SELECT @String = @String + ' @ ' + @Begin;
            END

            INSERT INTO ##SQLskills_Log_Analysis2 VALUES (@String, 1);
        END

        -- Look for subtransactions of this one
        IF @Deep = 1
            EXEC usp_SQLskillsAnalyzeLogInner @XactID, 3;

        FETCH NEXT FROM [LogAnalysis] INTO @XactID, @Name, @Begin, @Who;
    END;

    CLOSE [LogAnalysis];
    DEALLOCATE [LogAnalysis];

    -- Discard the dummy row
    DELETE
    FROM
        ##SQLskills_Log_Analysis2
    WHERE
        [ID] = 1;

    -- Print the hierachy
    DECLARE [LogAnalysis2] CURSOR FOR
    SELECT
        [ID],
        [XactName],
        [Times]
    FROM
        ##SQLskills_Log_Analysis2;

    OPEN [LogAnalysis2];

    -- Fetch the first transaction name, if any
    FETCH NEXT FROM [LogAnalysis2] INTO @ID, @String, @Counter;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @Counter > 1
        BEGIN
            SELECT @String = @String + ' ' +
                CONVERT (VARCHAR, @Counter) + ' times';
        END
        
        -- If we're going to SELECT the output, update the row
        IF @PrintOption = 0
            UPDATE
                ##SQLskills_Log_Analysis2
            SET
                [XactName] = @String
            WHERE
                [ID] = @ID;
        ELSE
            PRINT @String;

        FETCH NEXT FROM [LogAnalysis2] INTO @ID, @String, @Counter;
    END;

    CLOSE [LogAnalysis2];
    DEALLOCATE [LogAnalysis2];

    IF @PrintOption = 0
    BEGIN
        SELECT
            [XactName]
        FROM
            ##SQLskills_Log_Analysis2;
    END

    DROP TABLE ##SQLskills_Log_Analysis;
    DROP TABLE ##SQLskills_Log_Analysis2;
END
GO
