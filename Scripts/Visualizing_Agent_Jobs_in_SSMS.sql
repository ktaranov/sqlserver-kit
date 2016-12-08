/*
Author: Daniel Hutmacher
Original link: https://sqlsunday.com/downloads/
*/


/*
Copyright Daniel Hutmacher under Creative Commons 4.0 license with attribution.
http://creativecommons.org/licenses/by/4.0/

Source: http://sqlsunday.com/downloads/

DISCLAIMER: This script may not be suitable to run in a production
            environment. I cannot assume any responsibility regarding
            the accuracy of the output information, performance
            impacts on your server, or any other consequence. If
            your juristiction does not allow for this kind of
            waiver/disclaimer, or if you do not accept these terms,
            you are NOT allowed to store, distribute or use this
            code in any way.

VERSION:    2016-11-17
*/

--- Parameters:
DECLARE
        --- Starting date, time for the graph:
        @from datetime2(0)=DATEADD(day, -7, SYSDATETIME()),

        --- Ending date, time for the graph:
        @to   datetime2(0)=SYSDATETIME(),

        --- Spacing of vertical grid lines.
        @grid datetime2(0)=DATEADD(hour, 24, 0),

        --- Filter on job execution outcome
        --- (0=fail, 1=ok, 2=retry, 3=cancel, NULL=all executions)
        @status int=NULL;


--- Other variables:
DECLARE @jobcount int=(SELECT COUNT(*) FROM msdb.dbo.sysjobs),
        @height int=500;

--- Draw vertical grid lines, but only if @grid is not NULL:
WITH cte AS (
    SELECT CAST(CAST(@from AS date) AS datetime2(0)) AS [date]
    WHERE @grid IS NOT NULL
    UNION ALL
    SELECT DATEADD(second, DATEDIFF(second, 0, @grid), [date])
    FROM cte
    WHERE [date]<@to)

SELECT LEFT(DATENAME(dw, [date]), 3)+' '+CONVERT(varchar(100), [date], 121) AS [Description],
       CAST(NULL AS varchar(100)) AS [Start],
       CAST(NULL AS varchar(100)) AS [End],
       CAST(NULL AS time(0)) AS [Duration],
       CAST(NULL AS nvarchar(4000)) AS [Output],
       geometry::STGeomFromText('LINESTRING ('+
           STR(DATEDIFF(second, @from, [date]), 10, 0)+' '+STR(-@height, 10, 0)+', '+
           STR(DATEDIFF(second, @from, [date]), 10, 0)+' '+STR((@jobcount+2)*@height, 10, 0)+')', 0)
FROM cte
WHERE [date]>=@from AND [date]<=@to


UNION ALL


--- These are the job executions:
SELECT j.[name] AS [Description],
       LEFT(DATENAME(dw, x.execution_start), 3)+' '+CONVERT(varchar(100), x.execution_start, 121) AS [Start],
       CONVERT(varchar(100), DATEADD(second, x.duration_s, x.execution_start), 121) AS [End],
       DATEADD(second, x.duration_s, CAST('00:00:00' AS time(0))) AS [Duration],
       h.[message] AS [Output],
       geometry::STGeomFromText('POLYGON (('+
           STR(coord.x, 10, 0)        +' '+STR(coord.y, 10, 0)+', '+
           STR(coord.x+coord.w, 10, 0)+' '+STR(coord.y, 10, 0)+', '+
           STR(coord.x+coord.w, 10, 0)+' '+STR(coord.y+coord.h, 10, 0)+', '+
           STR(coord.x, 10, 0)        +' '+STR(coord.y+coord.h, 10, 0)+', '+
           STR(coord.x, 10, 0)        +' '+STR(coord.y, 10, 0)+'))', 0)
FROM msdb.dbo.sysjobhistory AS h
INNER JOIN (
    --- All the jobs, with an ordinal number to set their vertical coordition:
    SELECT job_id, [name], DENSE_RANK() OVER (ORDER BY [name], job_id) AS ordinal
    FROM msdb.dbo.sysjobs
    ) AS j ON h.job_id=j.job_id
CROSS APPLY (
    VALUES(
           --- Convert the funky "run_duration" column (int, hhmiss) to the
           --- actual number of seconds that the job ran:
           3600*((h.run_duration-h.run_duration%10000)/10000)+
            60*(((h.run_duration-h.run_duration%100)/100)%100)+
                  h.run_duration%100,
           --- Convert the funky "run_date" (int, yyyymmdd) and "run_time"
           --- (int, hhmiss) to a datetime2(0), so we can work with it:
           DATEADD(second,
               3600*((h.run_time-h.run_time%10000)/10000)+
                60*(((h.run_time-h.run_time%100)/100)%100)+
                      h.run_time%100,
               CONVERT(datetime2(0), CAST(h.run_date AS varchar(100)), 112)))
    ) AS x(duration_s, execution_start)
CROSS APPLY (
    --- Calculating the polygon coordinates:
    VALUES (
            --- x: the offset of the execution start time
            DATEDIFF(second, @from, x.execution_start),
            --- y: the ordinal of the job
            j.ordinal*@height,
            --- w: the duration of the execution
            x.duration_s,
            --- h: 80% of the row height (@height)
            0.8*@height)
    ) AS coord(x, y, w, h)
WHERE h.step_id=0 AND
      (h.run_status=@status OR @status IS NULL) AND
      (h.run_date>CAST(CONVERT(varchar(10), @from, 112) AS int) OR
       h.run_date=CAST(CONVERT(varchar(10), @from, 112) AS int) AND h.run_time>=CAST(REPLACE(CONVERT(varchar(100), @from, 108), ':', '') AS int)) AND
      (h.run_date<CAST(CONVERT(varchar(10), @to,   112) AS int) OR
       h.run_date=CAST(CONVERT(varchar(10), @to,   112) AS int) AND h.run_time<=CAST(REPLACE(CONVERT(varchar(100), @to,   108), ':', '') AS int));
GO