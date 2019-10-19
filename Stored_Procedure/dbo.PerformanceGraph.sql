IF OBJECT_ID('dbo.PerformanceGraph', 'P') IS NULL
BEGIN
    EXEC ('CREATE PROCEDURE dbo.PerformanceGraph AS BEGIN SELECT 1 END');
END;
GO


ALTER PROCEDURE PerformanceGraph
    @ShowCPUAsLines      BIT     = 1,
    @ShowDeadlock        BIT     = 1,
    @DeadlockBlobRadius  TINYINT = 1,
    @OutputDeadlockTable BIT     = 1,
    @ShowEndBar          BIT     = 1,
    @EndBarWidth         TINYINT = 1
AS
/*
https://thelonedba.wordpress.com/2019/09/27/wrapping-up-cpu-load-graphs-in-a-stored-procedure/

EXEC dbo.PerformanceGraph;
*/
BEGIN
    SET NOCOUNT ON;
 
    DECLARE @ts_now BIGINT =
            (
                SELECT      TOP (1)
                            cpu_ticks / (cpu_ticks / ms_ticks)
                FROM        sys.dm_os_sys_info WITH (NOLOCK)
                ORDER BY    cpu_ticks DESC
            );
    DECLARE @CPUSQLOut   AS VARCHAR(8000),
            @CPUIdleOut  AS VARCHAR(8000),
            @CPUOtherOut AS VARCHAR(8000);
    DECLARE @CPURecords AS INT;
    DECLARE @DeadlockPoints  AS VARCHAR(8000),
            @DeadlockBlobs   AS VARCHAR(8000),
            @DeadlockRecords AS INT;
 
    DECLARE @OutputGeometry TABLE (ShapeInfo GEOMETRY, Caption VARCHAR(20));
 
    WITH
    CPULoad AS
    (
        SELECT      TOP (256)
                    y.SQLProcessUtilization                              AS [SQL Server Process CPU Utilization],
                    y.SystemIdle                                         AS [System Idle Process],
                    100 - (y.SystemIdle + y.SQLProcessUtilization)       AS [Other Process CPU Utilization],
                    DATEADD(ms, -1 * (@ts_now - y.timestamp), GETDATE()) AS [Event Time]
        FROM
                    (
                        SELECT  x.record.value('(./Record/@id)[1]', 'int')                                                   AS record_id,
                                x.record.value('(./Record/SchedulerMonitorEvent/SystemHealth/SystemIdle)[1]', 'int')         AS SystemIdle,
                                x.record.value('(./Record/SchedulerMonitorEvent/SystemHealth/ProcessUtilization)[1]', 'int') AS SQLProcessUtilization,
                                x.timestamp
                        FROM
                                (
                                    SELECT  timestamp,
                                            CONVERT(XML, record) AS record
                                    FROM    sys.dm_os_ring_buffers WITH (NOLOCK)
                                    WHERE
                                            ring_buffer_type = N'RING_BUFFER_SCHEDULER_MONITOR'
                                            AND record LIKE N'%<SystemHealth>%'
                                ) AS x
                    ) AS y
        ORDER BY    y.timestamp DESC
    )
    SELECT  @CPUSQLOut
                        = STUFF(
                          (
                              SELECT        ','
                                            + CAST(ROW_NUMBER() OVER (ORDER BY CPULoad.[Event Time]) - COUNT(*) OVER (PARTITION BY 1) AS VARCHAR(10))
                                            + ' ' + CAST(CPULoad.[SQL Server Process CPU Utilization] AS VARCHAR(20))
                              FROM          CPULoad
                              ORDER BY      CPULoad.[Event Time]
                              FOR XML PATH('')
                          ),
                          1,
                          1,
                          ''
                               ),
            @CPUIdleOut
                        = STUFF(
                          (
                              SELECT    ','
                                        + CAST(ROW_NUMBER() OVER (ORDER BY CPULoad.[Event Time]) - COUNT(*) OVER (PARTITION BY 1) AS VARCHAR(10))
                                        + ' ' + CAST(CPULoad.[System Idle Process] AS VARCHAR(20))
                              FROM      CPULoad
                              ORDER BY  CPULoad.[Event Time]
                              FOR XML PATH('')
                          ),
                          1,
                          1,
                          ''
                               ),
            @CPUOtherOut
                        = STUFF(
                          (
                              SELECT    ','
                                        + CAST(ROW_NUMBER() OVER (ORDER BY CPULoad.[Event Time])
                                               - COUNT(*) OVER (PARTITION BY 1) AS VARCHAR(10)) + ' '
                                        + CAST(CPULoad.[Other Process CPU Utilization] AS VARCHAR(20))
                              FROM      CPULoad
                              ORDER BY  CPULoad.[Event Time]
                              FOR XML PATH('')
                          ),
                          1,
                          1,
                          ''
                               ),
            @CPURecords = (SELECT   COUNT(*) FROM   CPULoad);
 
    IF @ShowCPUAsLines = 1
    BEGIN
        INSERT INTO @OutputGeometry (ShapeInfo, Caption)
        VALUES
        (geometry::Parse('LINESTRING(' + @CPUSQLOut + ')'), 'CPU-SQL'),
        (geometry::Parse('LINESTRING(' + @CPUOtherOut + ')'), 'CPU-Other'),
        (geometry::Parse('LINESTRING(' + @CPUIdleOut + ')'), 'CPU-Idle');
    END;
    ELSE
    BEGIN
        INSERT INTO @OutputGeometry (ShapeInfo, Caption)
        VALUES
        (geometry::STGeomFromText(
                                     'POLYGON((' + CAST(0 - @CPURecords AS CHAR(5)) + ' 0, ' + @CPUSQLOut + ', '
                                     + '0 0, ' + CAST(0 - @CPURecords AS CHAR(5)) + ' 0 ))',
                                     0
                                 ), 'CPU-SQL'),
        (geometry::STGeomFromText(
                                     'POLYGON((' + CAST(0 - @CPURecords AS CHAR(5)) + ' 0, ' + @CPUOtherOut + ', '
                                     + '0 0, ' + CAST(0 - @CPURecords AS CHAR(5)) + ' 0 ))',
                                     0
                                 ), 'CPU-Other'),
        (geometry::STGeomFromText(
                                     'POLYGON((' + CAST(0 - @CPURecords AS CHAR(5)) + ' 0, ' + @CPUIdleOut + ', '
                                     + '0 0, ' + CAST(0 - @CPURecords AS CHAR(5)) + ' 0 ))',
                                     0
                                 ), 'CPU-Idle');
    END;
 
    DECLARE @XMLDeadlocks TABLE ([XML] XML, UTCTime DATETIME, LocalTime DATETIME, MinutesAgo INT);
 
    IF @ShowDeadlock = 1
    BEGIN;
        WITH
        xmlsource AS
        (
            SELECT  CONVERT(XML, event_data) AS deadlock_xml
            FROM    sys.fn_xe_file_target_read_file('system_health*.xel', NULL, NULL, NULL)
        ),
        xmldates AS
        (
            SELECT  xmlsource.deadlock_xml,
                    xmlsource.deadlock_xml.value('(/event/@timestamp)[1]', 'datetime') AS deadlock_UTCtime, -- this is UTC.
                    DATEADD(
                               mi,
                               DATEDIFF(mi, GETUTCDATE(), GETDATE()),
                               xmlsource.deadlock_xml.value('(/event/@timestamp)[1]', 'datetime')
                           )                                                           AS deadlock_LocalTime
            FROM    xmlsource
            WHERE   xmlsource.deadlock_xml.value('(/event/@name)[1]', 'VARCHAR(256)') = 'xml_deadlock_report'
        )
        INSERT INTO @XMLDeadlocks ([XML], UTCTime, LocalTime, MinutesAgo)
        SELECT  xmldates.deadlock_xml,
                xmldates.deadlock_UTCtime,
                xmldates.deadlock_LocalTime,
                DATEDIFF(MINUTE, xmldates.deadlock_LocalTime, GETDATE()) AS MinutesAgo
        FROM    xmldates;
 
        SELECT  @DeadlockPoints  = STUFF(
                                   (
                                       SELECT   DISTINCT
                                                ', (' + CAST((0 - xml.MinutesAgo) AS CHAR(5)) + ' 0)'
                                       FROM     @XMLDeadlocks xml
                                       WHERE    xml.MinutesAgo <= @CPURecords
                                       FOR XML PATH('')
                                   ),
                                   1,
                                   2,
                                   ''
                                        ),
                @DeadlockBlobs
                                 = STUFF(
                                   (
-- SQL Prompt formatting off
                                       SELECT       DISTINCT ', CURVEPOLYGON(CIRCULARSTRING('
                                                    + CAST((0-xml.MinutesAgo) + @DeadlockBlobRadius AS CHAR(5)) + ' 0, '
                                                    + CAST((0-xml.MinutesAgo) AS CHAR(5)) + ' ' + CAST(@DeadlockBlobRadius AS CHAR(5)) + ', '
                                                    + CAST((0-xml.MinutesAgo) - @DeadlockBlobRadius AS CHAR(5)) + ' 0, '
                                                    + CAST((0-xml.MinutesAgo) AS CHAR(5)) + ' ' + CAST((0 - @DeadlockBlobRadius) AS CHAR(5)) + ', '
                                                    + CAST((0-xml.MinutesAgo) + @DeadlockBlobRadius AS CHAR(5)) + ' 0'
                                                    + '))'
-- SQL Prompt formatting on
                                       FROM     @XMLDeadlocks xml
                                       WHERE    xml.MinutesAgo <= @CPURecords
                                       FOR XML PATH('')
                                   ),
                                   1,
                                   2,
                                   ''
                                        ),
                @DeadlockRecords =
        (
            SELECT  COUNT(*) FROM   @XMLDeadlocks xml WHERE xml.MinutesAgo <= @CPURecords
        );
 
        IF @DeadlockBlobRadius = 0
        BEGIN -- show points
            INSERT INTO @OutputGeometry (ShapeInfo, Caption)
            VALUES
            (   geometry::Parse('MULTIPOINT(' + @DeadlockPoints + ')'), -- ShapeInfo - geometry
                'Deadlocks'                                             -- Caption - varchar(20)
                );
        END;
        ELSE
        BEGIN -- show blobs
            INSERT INTO @OutputGeometry (ShapeInfo, Caption)
            VALUES
            (   geometry::Parse('GEOMETRYCOLLECTION(' + @DeadlockBlobs + ')'), -- ShapeInfo - geometry
                'Deadlocks'                                                 -- Caption - varchar(20)
                );
        END;
 
        IF @OutputDeadlockTable = 1
        BEGIN
            SELECT  UTCTime, LocalTime, MinutesAgo, XML FROM @XMLDeadlocks xd ORDER BY  xd.MinutesAgo;
        END;
    END;
 
    --End Bar
    IF @ShowEndBar = 1
    BEGIN
        IF @EndBarWidth = 0
        BEGIN
            INSERT INTO @OutputGeometry (ShapeInfo, Caption)
            VALUES
            (   geometry::Parse('LINESTRING(0 0,0 100)'), -- ShapeInfo - geometry
                'Now'                                   -- Caption - varchar(100)
                );
        END;
        ELSE
        BEGIN
            INSERT INTO @OutputGeometry (ShapeInfo, Caption)
            VALUES
            (   geometry::Parse('POLYGON((0 0,0 100, ' + CAST(@EndBarWidth AS CHAR(3)) + ' 100, '
                                + CAST(@EndBarWidth AS CHAR(3)) + ' 0, 0 0))'
                               ),   -- ShapeInfo - geometry
                'Now'               -- Caption - varchar(100)
                );
        END;
    END;
 
    -- Final Output
    SELECT  ShapeInfo, Caption FROM @OutputGeometry;
END;
GO
