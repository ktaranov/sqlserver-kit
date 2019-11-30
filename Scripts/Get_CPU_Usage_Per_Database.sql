/*
<documentation>
  <summary>Get CPU Usage Per Database</summary>
  <returns>1 data set with 2 columns: database name and CPUTimeAsPercentage.</returns>
  <issues>No</issues>
  <author>Eli Leiba</author>
  <created>2019-11-05</created>
  <modified>2019-11-05</modified>
  <version>1.0</version>
  <originalLink>https://www.mssqltips.com/sqlservertip/6195/sql-server-function-to-measure-cpu-usage-per-database/</originalLink>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Get_CPU_Usage_Per_Database.sql</sourceLink>
</documentation>
*/

SELECT
       T.[Database]
     , T.CPUTimeAsPercentage
   FROM
    (SELECT
        [Database],
        CONVERT (DECIMAL (6, 3), [CPUTimeInMiliSeconds] * 1.0 /
        SUM ([CPUTimeInMiliSeconds]) OVER () * 100.0) AS [CPUTimeAsPercentage]
     FROM 
      (SELECT
          dm_execplanattr.DatabaseID,
          DB_Name(dm_execplanattr.DatabaseID) AS [Database],
          SUM (dm_execquerystats.total_worker_time) AS CPUTimeInMiliSeconds
       FROM sys.dm_exec_query_stats dm_execquerystats
       CROSS APPLY 
        (SELECT
            CONVERT (INT, value) AS [DatabaseID]
         FROM sys.dm_exec_plan_attributes(dm_execquerystats.plan_handle)
         WHERE attribute = N'dbid'
        ) dm_execplanattr
       GROUP BY dm_execplanattr.DatabaseID
      ) AS CPUPerDb
    )  AS T;
