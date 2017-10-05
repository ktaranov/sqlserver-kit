/*
Author: Louis Davidson
Original link: http://sqlblog.com/blogs/louis_davidson/archive/2017/06/15/utility-to-temporarily-drop-foreign-key-constraints-on-a-set-of-tables.aspx
Desctiption: Utility to temporarily drop FOREIGN KEY constraints on a set of tables
*/


--Uses Object Created in Utility-ForeignKey$Scripting.sql, available here: https://www.dropbox.com/s/8hj1vfqpidb3d5i/Utility-ForeignKey%24Scripting.sql?dl=0

 
IF OBJECT_ID('utility.foreign_key$batch_drop', 'P') IS NULL
EXECUTE('CREATE PROCEDURE utility.foreign_key$batch_drop as SELECT 1');
GO

ALTER PROCEDURE utility.foreign_key$batch_drop
( 
    @table_Schema sysname = '%', 
    @table_Name sysname = '%', 
    @add_to_history_flag BIT = 0, 
    @force_replace_status  VARCHAR(20) = 'AS_WAS' --ENABLED, UNTRUSTED, DISABLED 
) AS
-- ---------------------------------------------------------------- 
-- Used to drop foreign keys, saving off what to recreate by batch name 
-- 
-- 2017 Louis Davidson - drsql.org 
-- ----------------------------------------------------------------
 
BEGIN
    IF OBJECT_ID('Utility.foreign_key$batch_drop_toRestore') IS  NULL
            EXEC (' 
            CREATE TABLE Utility.foreign_key$batch_drop_toRestore
            ( 
                table_schema    sysname NOT null, 
                table_name        sysname NOT null, 
                constraint_name    sysname NOT null, 
                recreate_script  NVARCHAR(MAX) NOT null, 
                disabled_flag   BIT NOT null, 
                trusted_flag bit NOT NULL 
            ) 
            ') 
    ELSE
    IF @add_to_history_flag = 0 
          BEGIN
            THROW 50000,'Parameter @add_to_history_flag set to only allow initialize case',1; 
            RETURN -100 
          END
 
    set nocount on
    declare @statements cursor
    SET @statements = CURSOR FOR
           WITH FK AS ( 
                        SELECT OBJECT_SCHEMA_NAME(parent_object_id) AS schemaName, OBJECT_NAME(parent_object_id) AS tableName, 
                               NAME AS constraintName, foreign_keys.is_disabled AS disabledFlag, 
                               IIF(foreign_keys.is_not_trusted = 1e,0,1) AS trustedFlag 
                        FROM   sys.foreign_keys 
                        ) 
                        SELECT schemaName, tableName, constraintName, disabledFlag, FK.trustedFlag 
                        FROM   FK 
                        WHERE  schemaName LIKE @table_Schema 
                          AND  tableName LIKE @table_Name
 
                          ORDER BY schemaName, tableName, constraintName
 
    OPEN @statements
 
    DECLARE  @statement VARCHAR(1000), @schemaName sysname, @tableName sysname, @constraintName sysname, 
             @constraintType sysname,@disabledFlag BIT, @trustedFlag BIT; 
     
    WHILE 1=1 
     BEGIN
           FETCH FROM @statements INTO @schemaName, @tableName, @constraintName, @disabledFlag, @trustedFlag 
               IF @@FETCH_STATUS <> 0 
                    BREAK
 
               BEGIN TRY 
                   BEGIN TRANSACTION
 
                    INSERT INTO Utility.foreign_key$batch_drop_toRestore (table_schema, table_name, constraint_name, 
                                                                                    recreate_script, disabled_flag, trusted_flag) 
                    SELECT  @schemaName 
                             , @tableName 
                             , @constraintName 
                             , utility.foreign_key$script(@schemaName, @constraintName,@force_replace_status) -- must be before the drop 
                             , @disabledFlag 
                             , @trustedFlag
 
 
                    SELECT @statement = 'ALTER TABLE ' + @schemaName + '.' + @tableName + ' DROP ' + @constraintName
 
                    EXEC (@statement) 
                     
                    COMMIT TRANSACTION
 
               END TRY 
              BEGIN CATCH 
              IF XACT_STATE() <> 0 
                ROLLBACK
 
              DECLARE @msg NVARCHAR(2000) = 
                    CONCAT('Error occurred: ' , CAST(ERROR_NUMBER() AS VARCHAR(10)) , ':'
                            , ERROR_MESSAGE() , CHAR(13) , CHAR(10) , 
                            'Statement executed: ' ,  @statement); 
              THROW 50000,@msg,1;
 
           END CATCH
 
 
     END
 
END
GO
 

IF OBJECT_ID('utility.foreign_key$batch_recreate', 'P') IS NULL
EXECUTE('CREATE PROCEDURE utility.foreign_key$batch_recreate as SELECT 1');
GO

ALTER PROCEDURE utility.foreign_key$batch_recreate 
AS 
-- ---------------------------------------------------------------- 
-- Used to enable constraints 
-- 
-- 2017 Louis Davidson - drsql.org 
-- ----------------------------------------------------------------
 
BEGIN
    IF OBJECT_ID('Utility.foreign_key$batch_drop_toRestore') IS  NULL
          BEGIN
            THROW 50000,'Table Utility.foreign_key$batch_drop_toRestore must exist, as this is where the objects to resore are stored',1; 
            RETURN -100 
          END
   
     set nocount on
    declare @statements cursor
    SET @statements = CURSOR FOR
        SELECT table_schema AS schemaName, table_name AS tableName, constraint_name AS constraintName, 
               disabled_flag AS disabledFlag, recreate_script AS statement, trusted_flag 
        FROM   Utility.foreign_key$batch_drop_toRestore        
 
    OPEN @statements
 
    DECLARE   @schemaName sysname, @tableName sysname, @constraintName sysname, 
             @disabledFlag BIT, @trustedFlag BIT, @codelocation VARCHAR(200), @statement NVARCHAR(MAX); 
     
 
    WHILE 1=1 
     BEGIN
           FETCH FROM @statements INTO @schemaName, @tableName, @constraintName, @disabledFlag, @statement, @trustedFlag 
               IF @@FETCH_STATUS <> 0 
                    BREAK
 
               BEGIN TRY 
                   BEGIN TRANSACTION
 
                    EXEC (@statement) 
                    --PRINT @statement
 
                    DELETE FROM  Utility.foreign_key$batch_drop_toRestore 
                    WHERE table_schema = @schemaName 
                      AND table_name = @tableName 
                      AND constraint_name = @constraintName 
                     
                    COMMIT TRANSACTION
 
               END TRY 
              BEGIN CATCH 
              IF XACT_STATE() = 0 
                ROLLBACK; 
              DECLARE @msg NVARCHAR(2000) = 
                    'Error occurred: ' + CAST(ERROR_NUMBER() AS VARCHAR(10))+ ':' + ERROR_MESSAGE() + CHAR(13) + CHAR(10) + 
                                        'Statement executed: ' +  @statement; 
              THROW 50000, @msg, 1; 
                
           END CATCH
 
 
     END
 
     DROP TABLE Utility.foreign_key$batch_drop_toRestore;
 
 
END
GO
