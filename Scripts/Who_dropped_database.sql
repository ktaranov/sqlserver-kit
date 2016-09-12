/*
Author: Jason Brimhall
Original link: http://jasonbrimhall.info/2016/09/09/database-dropped/
*/

DECLARE @DBName sysname = 'AdventureWorks2014'
        ,@d1 DATETIME
        ,@diff INT;

SELECT ObjectName
          , ObjectID
          , DatabaseName
          , StartTime
          , EventClass
          , EventSubClass
          , ObjectType
          , ServerName
          , LoginName
          , NTUserName
          , ApplicationName
          , CASE EventClass
                WHEN 46
                    THEN 'CREATE'
                WHEN 47
                    THEN 'DROP'
                --WHEN 164
                --  THEN 'ALTER'
            END AS DDLOperation
        INTO #temp_trace  
    FROM sys.fn_trace_gettable(CONVERT(VARCHAR(150), 
            ( SELECT REVERSE(SUBSTRING(REVERSE(path),
                    CHARINDEX('\',REVERSE(path)),256)) + 'log.trc'
                FROM    sys.traces
                WHERE   is_default = 1)), DEFAULT) T  
  WHERE EventClass in (46,47) 
            AND EventSubclass = 0
            AND ObjectType = 16964-- i just want database related events   
            AND DatabaseName = ISNULL(@DBName,DatabaseName);


SELECT @d1 = MIN(StartTime) 
    FROM #temp_trace;

SET @diff= DATEDIFF(hh,@d1,GETDATE());


SELECT @diff AS HrsSinceFirstChange    
        , @d1 AS FirstChangeDate    
        , sv.name AS obj_type_desc
        , tt.ObjectType
        , tt.DDLOperation
        , tt.DatabaseName,tt.ObjectName,tt.StartTime
        , tt.EventClass,tt.EventSubClass
        , tt.ServerName,tt.LoginName, tt.NTUserName
        , tt.ApplicationName
        , (dense_rank() OVER (ORDER BY ObjectName,ObjectType ) )%2 AS l1     
        , (dense_rank() OVER (ORDER BY ObjectName,ObjectType,StartTime ))%2 AS l2    
    FROM #temp_trace tt
        INNER JOIN sys.trace_events AS te 
            ON tt.EventClass = te.trace_event_id
        INNER JOIN sys.trace_subclass_values tsv
            ON tt.EventClass = tsv.trace_event_id
            AND tt.ObjectType = tsv.subclass_value
        INNER JOIN master.dbo.spt_values sv 
            ON tsv.subclass_value = sv.number
            AND sv.type = 'EOD'
    ORDER BY StartTime DESC;

DROP TABLE #temp_trace;
