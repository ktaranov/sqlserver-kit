USE [master]
GO

IF OBJECT_ID (N'dbo.sp_sizing', 'P') IS NULL
    EXECUTE('CREATE PROCEDURE sp_sizing AS SELECT 1');
GO

ALTER PROCEDURE dbo.sp_sizing(
        @granularity VARCHAR(1) = NULL
      , @database_name SYSNAME = NULL
)
AS
/*-------------------------------------------------------------
dbo.sp_sizing Stored Procedure 
Created by Tim Ford, www.sqlcruise.com, www.thesqlagentman.com
Use freely but review code before executing.
Code downloaded from internet so execute at your own risk.
-------------------------------------------------------------*/

DECLARE @sql_command VARCHAR(5000) 

CREATE TABLE #Results ([server] NVARCHAR(128), [database_name] NVARCHAR(128), [file_name] NVARCHAR(128), [physical_name] NVARCHAR(260),  
   [file_type] VARCHAR(4), [total_size_mb] INT, [available_space_mb] INT, [growth_units] VARCHAR(15), [max_file_size_mb] INT) 

SELECT @sql_command =  
'USE [?] INSERT INTO #Results([server], [database_name], [file_name], [physical_name],  
[file_type], [total_size_mb], [available_space_mb],  
[growth_units], [max_file_size_mb])  
SELECT CONVERT(nvarchar(128), SERVERPROPERTY(''Servername'')), DB_NAME(), 
[name] AS [file_name],  
physical_name AS [physical_name],  
[file_type] =  
CASE type 
WHEN 0 THEN ''Data'''  
+ 
           'WHEN 1 THEN ''Log''' 
+ 
       'END, 
[total_size_mb] = 
CASE ceiling([size]/128)  
WHEN 0 THEN 1 
ELSE ceiling([size]/128) 
END, 
[available_space_mb] =  
CASE ceiling([size]/128) 
WHEN 0 THEN (1 - CAST(FILEPROPERTY([name], ''SpaceUsed''' + ') as int) /128) 
ELSE (([size]/128) - CAST(FILEPROPERTY([name], ''SpaceUsed''' + ') as int) /128) 
END, 
[growth_units]  =  
CASE [is_percent_growth]  
WHEN 1 THEN CAST([growth] AS varchar(20)) + ''%''' 
+ 
           'ELSE CAST([growth]/1024*8 AS varchar(20)) + ''Mb''' 
+ 
       'END, 
[max_file_size_mb] =  
CASE [max_size] 
WHEN -1 THEN NULL 
WHEN 268435456 THEN NULL 
ELSE [max_size]/1024*8 
END 
FROM sys.database_files WITH (NOLOCK)
ORDER BY [file_type], [file_id]' 

--Print the command to be issued against all databases 
--PRINT @sql_command 

--========================================
--RUN COMMAND AGAINST EACH DATABASE
--========================================
EXEC sp_MSforeachdb @sql_command 


--=================================
--RETURN THE RESULTS

--If @database_name is NULL: 
--=================================
IF @database_name IS NULL 
   BEGIN 
       IF @granularity= 'd' /* Database Scope */
           BEGIN 
               SELECT  
                   T.[server], T.[database_name], 
                   T.[total_size_mb] AS [db_size_mb], 
                   T.[available_space_mb] AS [db_free_mb], 
                   T.[used_space_mb] AS [db_used_mb], 
                   D.[total_size_mb] AS [data_size_mb], 
                   D.[available_space_mb] AS [data_free_mb], 
                   D.[used_space_mb] AS [data_used_mb], 
                   CEILING(CAST(D.[available_space_mb] AS decimal(10,1)) / D.[total_size_mb]*100) AS [data_free_pct],
                   L.[total_size_mb] AS [log_size_mb], 
                   L.[available_space_mb] AS [log_free_mb], 
                   L.[used_space_mb] AS [log_used_mb], 
                   CEILING(CAST(L.[available_space_mb] AS decimal(10,1)) / L.[total_size_mb]*100) AS [log_free_pct] 
               FROM  
                   ( 
                                           SELECT [server], [database_name], 
                                                   SUM([total_size_mb]) AS [total_size_mb], 
                                                   SUM([available_space_mb]) AS [available_space_mb], 
                                                   SUM([total_size_mb]-[available_space_mb]) AS [used_space_mb]  
                                           FROM #Results 
                                           GROUP BY [server], [database_name] 
                   ) AS T 
                   INNER JOIN  
                                           ( 
                                                   SELECT [server], 
                                                                [database_name], 
                                                                SUM([total_size_mb]) AS [total_size_mb], 
                                                                SUM([available_space_mb]) AS [available_space_mb], 
                                                                SUM([total_size_mb]-[available_space_mb]) AS [used_space_mb]  
                                                   FROM #Results 
                                                   WHERE #Results.[file_type] = 'Data' 
                                                   GROUP BY [server], [database_name] 
                                           ) AS D ON T.[database_name] = D.[database_name] 
                   INNER JOIN 
                                           ( 
                                                   SELECT [server],
                                                                [database_name], 
                                                                SUM([total_size_mb]) AS [total_size_mb], 
                                                                SUM([available_space_mb]) AS [available_space_mb], 
                                                                SUM([total_size_mb]-[available_space_mb]) AS [used_space_mb]  
                                                   FROM #Results 
                                                   WHERE #Results.[file_type] = 'Log' 
                                                   GROUP BY [server], [database_name] 
                                           ) AS L ON T.[database_name] = L.[database_name] 
               ORDER BY D.[database_name] 
           END 
        ELSE /* File Scope */
                BEGIN 
                        SELECT [server], 
                                [database_name], 
                                [file_name], 
                                [physical_name], 
                                [file_type], 
                                [total_size_mb] AS [db_size_mb], 
                                [available_space_mb] AS [db_free_mb], 
                                CEILING(CAST([available_space_mb] AS DECIMAL(10,1)) / [total_size_mb]*100) AS [free_space_pct], 
                                [growth_units], 
                                [max_file_size_mb] /* AS [Grow Max Size (Mb)]  */
                        FROM #Results  
                        ORDER BY database_name, file_type, [file_name]
                END 
        END 

--=================================
--RETURN THE RESULTS FOR A DATABASE

--If @database_name is provided: 
--=================================
ELSE 
   BEGIN 
       IF @granularity= 'd' /* Database Scope */
           BEGIN 
               SELECT 
                                        T.[server],
                                        T.[database_name], 
                                        T.[total_size_mb] AS [db_size_mb], 
                                        T.[available_space_mb] AS [db_free_mb], 
                                        T.[used_space_mb] AS [db_used_mb], 
                                        D.[total_size_mb] AS [data_size_mb], 
                                        D.[available_space_mb] AS [data_free_mb], 
                                        D.[used_space_mb] AS [data_used_mb], 
                                        CEILING(CAST(D.[available_space_mb] AS DECIMAL(10,1)) / D.[total_size_mb]*100) AS [data_free_pct], 
                                        L.[total_size_mb] AS [log_size_mb], 
                                        L.[available_space_mb] AS [log_free_mb], 
                                        L.[used_space_mb] AS [log_used_mb], 
                                        CEILING(CAST(L.[available_space_mb] AS DECIMAL(10,1)) / L.[total_size_mb]*100) AS [log_free_pct] 
               FROM  
                   ( 
                   SELECT [server], [database_name], 
                       SUM([total_size_mb]) AS [total_size_mb], 
                       SUM([available_space_mb]) AS [available_space_mb], 
                       SUM([total_size_mb]-[available_space_mb]) AS [used_space_mb]  
                   FROM #Results 
                   WHERE [database_name] = @database_name 
                   GROUP BY [server], [database_name] 
                   ) AS T 
                   INNER JOIN  
                                           ( 
                                                   SELECT [server], [database_name], 
                                                           SUM([total_size_mb]) AS [total_size_mb], 
                                                           SUM([available_space_mb]) AS [available_space_mb], 
                                                           SUM([total_size_mb]-[available_space_mb]) AS [used_space_mb]  
                                                   FROM #Results 
                                                   WHERE #Results.[file_type] = 'Data' 
                                                           AND [database_name] = @database_name 
                                                   GROUP BY [server], [database_name] 
                                           ) AS D ON T.[database_name] = D.[database_name] 
                   INNER JOIN 
                                           ( 
                                                   SELECT [server], [database_name], 
                                                           SUM([total_size_mb]) AS [total_size_mb], 
                                                           SUM([available_space_mb]) AS [available_space_mb], 
                                                           SUM([total_size_mb]-[available_space_mb]) AS [used_space_mb]  
                                                   FROM #Results 
                                                   WHERE #Results.[file_type] = 'Log' 
                                                           AND [database_name] = @database_name 
                                                   GROUP BY [server], [database_name] 
                                           ) AS L ON T.[database_name] = L.[database_name] 
               ORDER BY D.[database_name] 
           END 
       ELSE /* File Scope */
           BEGIN 
               SELECT [server],
                                        [database_name], 
                                        [file_name], 
                                        [physical_name], 
                                        [file_type], 
                                        [total_size_mb] AS [db_size_mb], 
                                        [available_space_mb] AS [db_free_mb], 
                                        CEILING(CAST([available_space_mb] AS DECIMAL(10,1)) / [total_size_mb]*100) AS [free_space_pct], 
                                        [growth_units], 
                                        [max_file_size_mb] /* AS [Grow Max Size (Mb)]  */
               FROM #Results  
               WHERE [database_name] = @database_name 
                           ORDER BY file_type, [file_name]
           END 
   END
GO
