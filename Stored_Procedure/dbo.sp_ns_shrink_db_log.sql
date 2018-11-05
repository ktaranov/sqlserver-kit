/*
Author: Andy Novick
Original link: https://www.mssqltips.com/sqlservertip/2097/how-to-shrink-the-transaction-log-file-in-sql-server
Desctiption: Shrink the transaction log file in SQL Server
*/

 SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.ns_shrink_db_log', 'P') IS NULL
EXECUTE('CREATE PROCEDURE dbo.ns_shrink_db_log as SELECT 1');
GO

ALTER PROCEDURE dbo.ns_shrink_db_log 
(
   @db_name SYSNAME = NULL
  , @target_size_mb INT = 2
  , @backup_location NVARCHAR(200) = NULL
  , @backup_file_name NVARCHAR(200) = NULL
  , @maximum_attempts INT = 10
)
/* Shrinks the log file of @db_name to the @target_size_mb
*
exec [dbo].[ns_shrink_db_log] 'db_name', 2, 'c:\temp\'
             , 'shrink_backup', 4
************************************************************/
AS

SET NOCOUNT ON

SELECT @db_name = COALESCE(@db_name, DB_NAME())
    
DECLARE @logical_log_file_name SYSNAME,
        @backup_log_sql NVARCHAR(MAX),
        @shrink_sql NVARCHAR(MAX),
        @checkpoint_sql NVARCHAR(MAX),
        @db_id INT = DB_ID (@db_name),
        @start_size_mb INT,
        @final_size_mb INT,
        @attempts INT = 0,
        @recovery_model INT,
        @recovery_model_desc SYSNAME,
        @rc INT = 0 -- return code

SELECT @logical_log_file_name = name,
       @start_size_mb = size / 128
   FROM master..sysaltfiles
   WHERE dbid=@db_id AND  fileid=2
  
SELECT @recovery_model = recovery_model  
     , @recovery_model_desc = recovery_model_desc
   FROM sys.databases
   WHERE database_id=@db_id
  
PRINT 'Starting size of [' + @db_name + '].['
            + @logical_log_file_name
            + '] is '
            + CONVERT(VARCHAR(20), @start_size_mb) + ' MB '
            + ' recovery model = ' + @recovery_model_desc

IF @start_size_mb <= @target_size_mb BEGIN
   PRINT '['+@db_name+'] does not need shrinking'
    END
    
ELSE BEGIN    

          
    IF @recovery_model != 3
        AND (@backup_file_name IS NULL OR @backup_location IS NULL) BEGIN
        RAISERROR ('Null backup file location or name. aborting.', 16, 1)
        SET @rc = 50000
        GOTO get_out
    END

   WHILE @attempts < @maximum_attempts
      AND @target_size_mb < (SELECT CONVERT(INT, size/128) FROM master..sysaltfiles
                               WHERE dbid = @db_id AND
                                      name = @logical_log_file_name) -- not target
      BEGIN

        SET @attempts = @attempts + 1
        
        IF @recovery_model= 3 BEGIN
           SET @checkpoint_sql = 'use ['+@db_name+']; '
                               + 'checkpoint'
           PRINT @checkpoint_sql
           EXEC (@checkpoint_sql)
            END
        ELSE BEGIN
           SET @backup_log_sql =  'BACKUP LOG ['+ @db_name + '] '
                              + ' to disk = ''' + @backup_location
                              + CASE WHEN RIGHT(RTRIM(@backup_location), 1)='\'
                                    THEN '' ELSE '\' END
                              + @backup_file_name
                              + CONVERT(VARCHAR(10), @attempts)
                             + '.trn'''
           PRINT @backup_log_sql              

           EXEC (@backup_log_sql) -- See if a trunc of the log shrinks it.
        END
              
       SET @shrink_sql = 'use ['+@db_name+'];'
                       + 'dbcc shrinkfile (['+@logical_log_file_name+'], '
                       + CONVERT(VARCHAR(20), @target_size_mb) + ')'
       EXEC (@shrink_sql)
    END
END

SELECT @final_size_mb = size/128
   FROM master..sysaltfiles
   WHERE dbid = @db_id AND name = @logical_log_file_name
  
PRINT  'Final size of [' + @db_name + '].['
            + @logical_log_file_name
            + '] is ' +
       CONVERT(VARCHAR(20),@final_size_mb)
       + ' MB'
    
get_out:
RETURN @rc
