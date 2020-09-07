/*
<documentation>
  <summary>Calculate recommended MAXDOP value for your server.</summary>
  <returns>1 data set with information about current runnig jobs.</returns>
  <created>2020-02-18 by John Welch</created>
  <modified>2020-09-07 by Konstantin Taranov</modified>
  <version>1.1</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/MaxDop_2016_and_higher.sql</sourceLink>
  <originalLink>https://www.sentryone.com/blog/is-maxdop-configured-correctly</originalLink>
</documentation>
*/


DECLARE @ProductVersion NVARCHAR(50);
DECLARE @Major INT;
DECLARE @NumaNodeCount INT;
DECLARE @LogicalProcessorPerNumaNodeCount INT;
DECLARE @EffectiveMaxDop INT;
DECLARE @LogicalProcessorThreshold INT;
DECLARE @ResultMessage NVARCHAR(255);

SET @ProductVersion = CAST(SERVERPROPERTY('ProductVersion') AS NVARCHAR(50));
SET @Major = CAST(LEFT(@ProductVersion, CHARINDEX('.', @ProductVersion)-1) AS INT);

IF @Major < 13
BEGIN
    RAISERROR('This script is intended for SQL Server 2016 or higher. It will not work on version [%s].', 11, 1, @ProductVersion);
END

/* Get the MAXDOP setting */
SELECT 
    @EffectiveMaxDop = CAST(value_in_use AS INT)
FROM 
    sys.configurations
WHERE 
    [name] = N'max degree of parallelism';

IF @EffectiveMaxDop = 0
BEGIN
    SELECT 
        @EffectiveMaxDop = COUNT(*)
    FROM
        sys.dm_os_schedulers
    WHERE 
        scheduler_id <= 1048575
        AND is_online = 1;
END

-- Get the NUMA node count
-- Get the logical processors per numa node
SELECT 
    @NumaNodeCount = COUNT(*), @LogicalProcessorPerNumaNodeCount = MAX(online_scheduler_count)
FROM 
    sys.dm_os_nodes 
WHERE node_id <> 64; --Excluded DAC node

IF @NumaNodeCount < 1 OR @LogicalProcessorPerNumaNodeCount < 1
BEGIN
    RAISERROR('Could not capture NUMA node or logical processor count. Reported values - NUMA: [%d], Logical Processor: [%d]', 
        11,1, @NumaNodeCount, @LogicalProcessorPerNumaNodeCount);
END

SET @LogicalProcessorThreshold = IIF(@NumaNodeCount = 1, 8, 16);

--If NUMA = 1 and LogiProcs <= 8 THEN ASSERT(MaxDop <= LogiProcs)
--If NUMA > 1 and LogiProcs <= 16 THEN ASSERT(MaxDop <= LogiProcs)
IF @LogicalProcessorPerNumaNodeCount <= @LogicalProcessorThreshold
    AND @EffectiveMaxDop > @LogicalProcessorPerNumaNodeCount
BEGIN 
    SET @ResultMessage = N'MAXDOP should be less than or equal to the Logical Processor count per NUMA node.';
END
ELSE
BEGIN
    -- If NUMA = 1 and LogiProcs > 8 THEN ASSERT(MaxDop == 8)
    IF @NumaNodeCount = 1 
        AND @LogicalProcessorPerNumaNodeCount > @LogicalProcessorThreshold
        AND @EffectiveMaxDop <> @LogicalProcessorThreshold
    BEGIN 
        SET @ResultMessage = N'MAXDOP should be equal to 8.';
    END
    -- If NUMA > 1 and LogiProcs > 16 THEN ASSERT(MaxDop <= 16 & MaxDop <= (LogiProcs / 2))
    ELSE
    BEGIN
        IF @LogicalProcessorPerNumaNodeCount > @LogicalProcessorThreshold 
                AND @EffectiveMaxDop > @LogicalProcessorThreshold
        BEGIN 
            SET @ResultMessage = N'MAXDOP should not exceed a value of 16.';
            --RAISERROR('MAXDOP is not set based on recommendations in KB2806535. MAXDOP should not exceed a value of 16 . Reported values - NUMA: [%d], Logical Processor: [%d], MAXDOP: [%d]', 
            --	15,1, @NumaNodeCount, @LogicalProcessorPerNumaNodeCount, @EffectiveMaxDop);
        END
        ELSE IF @LogicalProcessorPerNumaNodeCount > @LogicalProcessorThreshold 
                AND (@LogicalProcessorPerNumaNodeCount / 2) <= @LogicalProcessorThreshold
                AND @EffectiveMaxDop <> (@LogicalProcessorPerNumaNodeCount / 2)
        BEGIN 
            SET @ResultMessage = N'MAXDOP should be set at half the number of logical processors per NUMA node with a MAX value of 16.';
            --RAISERROR('MAXDOP is not set based on recommendations in KB2806535. MAXDOP should be set at half the number of logical processors per NUMA node with a MAX value of 16 . Reported values - NUMA: [%d], Logical Processor: [%d], MAXDOP: [%d]', 
            --	15,1, @NumaNodeCount, @LogicalProcessorPerNumaNodeCount, @EffectiveMaxDop);
        END
    END
END
IF @EffectiveMaxDop = 1
BEGIN
    RAISERROR('MAXDOP is set to 1, which supresses parallel plan generation.', 0, 1);
END

IF @ResultMessage IS NULL
BEGIN
    RAISERROR('MAXDOP setting is in the recommended range. Reported values - NUMA: [%d], Logical Processor: [%d], MAXDOP: [%d]', 
                0, 1, @NumaNodeCount, @LogicalProcessorPerNumaNodeCount, @EffectiveMaxDop);
END
ELSE
BEGIN
    RAISERROR('MAXDOP is not set based on recommendations in KB2806535. %s Reported values - NUMA: [%d], Logical Processor: [%d], MAXDOP: [%d]', 
                11, 1, @ResultMessage, @NumaNodeCount, @LogicalProcessorPerNumaNodeCount, @EffectiveMaxDop);
END
GO
