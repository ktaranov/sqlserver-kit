IF OBJECT_ID('dbo.RunCheckUntrustedForeignKeys', 'P') IS NULL
EXECUTE ('CREATE PROCEDURE dbo.RunCheckUntrustedForeignKeys AS SELECT 1');
GO


ALTER PROCEDURE dbo.RunCheckUntrustedForeignKeys(
    @DbName         VARCHAR(256) = NULL 
)
AS
/*
Author: Jefferson Elias
Original link: http://www.sqlshack.com/managing-untrusted-foreign-keys/
Depends: usp_GetUntrustedForeignKeys
Exapmle: exec dbo.RunCheckUntrustedForeignKeys
*/
BEGIN

    SET NOCOUNT ON;
    
    -- general purpose variables
    DECLARE @tsql                           nvarchar(max);            -- text to execute via dynamic SQL
	DECLARE @LineFeed                       CHAR(2);
    DECLARE @DbLoggerExists                 BIT;
    DECLARE @ErrorLogMsg                    VARCHAR(MAX);
	DECLARE @ProcDbId				        INT;
    DECLARE @CorrectedCount                 INT;
    DECLARE @FailedCount                    INT;
    DECLARE @ErrorNumber	                INT             = ERROR_NUMBER();
    DECLARE @ErrorLine		                INT             = ERROR_LINE();
    DECLARE @ErrorMessage	                NVARCHAR(4000)  = ERROR_MESSAGE();
    DECLARE @ErrorSeverity	                INT             = ERROR_SEVERITY();
    DECLARE @ErrorState		                INT             = ERROR_STATE();    
    
    -- procedure-sepecific variables
    DECLARE @CurrentDb		                VARCHAR(256);
    DECLARE @CurrentSchemaName		        VARCHAR(256);
    DECLARE @CurrentTableName		        VARCHAR(256);
    DECLARE @CurrentForeignKeyName		    VARCHAR(256);
    
    -- initial settings
	SELECT 
        @ProcDbId = DB_ID(), 
        @LineFeed = CHAR(13) + CHAR(10) ,
        @CorrectedCount = 0,
        @FailedCount = 0
    ;

    -- Logging execution
    SELECT 
        @DbLoggerExists = 1 
    FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[Common].[LogMessage]') AND type in (N'P') ;
    
    if(@DbLoggerExists is not null)
    BEGIN
        SET @ErrorLogMsg = 'Procedure started';
        SET @tsql = 'exec [Common].[LogMessage] @ApplicationName = ''$(SolutionName)'',@LogLevel = ''INFO'',@DatabaseID = @DbID,@ObjectID = @ObjID,@LogMessage = @ErrorLogMsg' ;
        exec sp_executesql @tsql, N'@ObjID INT,@ErrorLogMsg VARCHAR(max), @DbID INT',@ObjID=@@PROCID,@ErrorLogMsg =@ErrorLogMsg ,@DbID = @ProcDbId;
    END;
    ELSE
    BEGIN
        PRINT 'Starting procedure ' + OBJECT_NAME(@@PROCID);
    END;
    
    IF(OBJECT_ID('tempdb..##UntrustedForeignKeysData') IS NOT NULL)
    BEGIN
        EXEC sp_executesql N'DROP TABLE ##UntrustedForeignKeysData;';
    END;
    
    BEGIN TRY 
        
        -- building the list of untrusted foreign key based on parameters
        
        exec dbo.GetUntrustedForeignKeys @DbName = @DbName, @_NoTempTableDropAtTheEnd = 1 , @_NoSelectOnTempTable = 1;
        
        -- Now let's loop and try to resolve untrusted foreign keys.
        
        DECLARE GetFKs CURSOR LOCAL FOR 
            SELECT 
                DbName,SchemaName,TableName,ForeignKeyName,DDL2Resolve
            FROM ##UntrustedForeignKeysData
        ;
        
        OPEN GetFKs;
        
        FETCH NEXT FROM GetFKs INTO @CurrentDb,@CurrentSchemaName,@CurrentTableName,@CurrentForeignKeyName,@tsql;
        
        WHILE @@FETCH_STATUS = 0
        BEGIN
            BEGIN TRY
                
                -- run the corrective query
                exec sp_executesql @tsql;
                
                -- log its success 
                SET @ErrorLogMsg =  'Foreign key ' + QUOTENAME(@CurrentForeignKeyName) + ' on table ' + QUOTENAME(@CurrentDb) + '.' + QUOTENAME(@CurrentSchemaName) + '.' + QUOTENAME(@CurrentTableName) + ' checked successfully.';
                
                if(@DbLoggerExists = 1)
                BEGIN
                    SET @tsql = 'exec [Common].[LogMessage] @ApplicationName = ''$(SolutionName)'',@LogLevel = ''INFO'',@DatabaseID = @DbID,@ObjectID = @ObjID,@LogMessage = @ErrorLogMsg' ;
                    exec sp_executesql @tsql, N'@ObjID INT,@ErrorLogMsg VARCHAR(max),@DbID INT',@ObjID=@@PROCID,@ErrorLogMsg =@ErrorLogMsg,@DbID = @ProcDbId ;
                END;
                ELSE 
                BEGIN
                    PRINT @ErrorLogMsg ;
                END;
                
                -- increment for summary
                SET @CorrectedCount = @CorrectedCount + 1 ;
                
            END TRY 
            BEGIN CATCH 
                -- an error occurred during the corrective action
                IF @@TRANCOUNT > 0
                BEGIN 
                    -- just to be sure 
                    ROLLBACK TRANSACTION;        
                END;
                    
                -- getting back error 
                SET @ErrorNumber    = ERROR_NUMBER();
                SET @ErrorLine      = ERROR_LINE();
                SET @ErrorMessage   = ERROR_MESSAGE();
                SET @ErrorSeverity  = ERROR_SEVERITY();
                SET @ErrorState     = ERROR_STATE(); 
                
                SET @ErrorLogMsg =  'Unable to check foreign key ' + QUOTENAME(@CurrentForeignKeyName) + ' on table ' + QUOTENAME(@CurrentDb) + '.' + QUOTENAME(@CurrentSchemaName) + '.' + QUOTENAME(@CurrentTableName) + @LineFeed +
                                    'Query used : ' + @LineFeed+
                                    @tsql + @LineFeed +
                                    'Message ID ' + CONVERT(VARCHAR,@ErrorNumber) + ' caught at Line ' + CONVERT(VARCHAR,@ErrorLine) + @LineFeed +
                                    'With Severity ' + CONVERT(VARCHAR,@ErrorSeverity) + ' and State ' + CONVERT(VARCHAR,@ErrorState) + @LineFeed +
                                    'Full Message = ' + @LineFeed +
                                    @ErrorMessage ;
                
                -- increment for summary
                SET @FailedCount = @FailedCount + 1;
                
                -- Log the error 
                if(@DbLoggerExists = 1)
                BEGIN
                    SET @tsql = 'exec [Common].[LogMessage] @ApplicationName = ''$(SolutionName)'',@LogLevel = ''ERROR'',@DatabaseID = @DbID,@ObjectID = @ObjID,@LogMessage = @ErrorLogMsg' ;
                    exec sp_executesql @tsql, N'@ObjID INT,@ErrorLogMsg VARCHAR(max),@DbID INT',@ObjID=@@PROCID,@ErrorLogMsg =@ErrorLogMsg,@DbID = @ProcDbId ;
                    RAISERROR(@ErrorLogMsg,10,1);
                END;
                ELSE 
                BEGIN
                    PRINT @ErrorLogMsg ;
                END;
            END CATCH;
            
            FETCH NEXT FROM GetFKs INTO @CurrentDb,@CurrentSchemaName,@CurrentTableName,@CurrentForeignKeyName,@tsql;
        END;
        
    END TRY 
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN 
            ROLLBACK TRANSACTION;
        END;
            
        SET @ErrorNumber    = ERROR_NUMBER();
        SET @ErrorLine      = ERROR_LINE();
        SET @ErrorMessage   = ERROR_MESSAGE();
        SET @ErrorSeverity  = ERROR_SEVERITY();
        SET @ErrorState     = ERROR_STATE(); 
            
        SET @ErrorLogMsg =  'Message ID ' + CONVERT(VARCHAR,@ErrorNumber) + ' caught at Line ' + CONVERT(VARCHAR,@ErrorLine) + CHAR(13) + CHAR(10) +
                            'With Severity ' + CONVERT(VARCHAR,@ErrorSeverity) + ' and State ' + CONVERT(VARCHAR,@ErrorState) + CHAR(13) + CHAR(10) +
                            'Full Message = ' + CHAR(13) + CHAR(10) +
                            @ErrorMessage ;

        if(EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[Common].[LogMessage]') AND type in (N'P')))
        BEGIN
            SET @tsql = 'exec [Common].[LogMessage] @ApplicationName = ''$(SolutionName)'',@LogLevel = ''ERROR'',@DatabaseID = @DbID,@ObjectID = @ObjID,@LogMessage = @ErrorLogMsg' ;
            exec sp_executesql @tsql, N'@ObjID INT,@ErrorLogMsg VARCHAR(max),@DbID INT',@ObjID=@@PROCID,@ErrorLogMsg =@ErrorLogMsg,@DbID = @ProcDbId ;
            RAISERROR(@ErrorLogMsg,10,1);
        END;
        ELSE
            THROW ;
    END CATCH;
    
    -- Cleanups 
        
    IF(OBJECT_ID('tempdb..##UntrustedForeignKeysData') IS NOT NULL)
    BEGIN
        EXEC sp_executesql N'DROP TABLE ##UntrustedForeignKeysData;';
    END;
         
    IF (CURSOR_STATUS('local','GetFKs') > -1)
    BEGIN
        CLOSE GetFKs;
    END;         
    IF (CURSOR_STATUS('local','GetFKs') =-1)
    BEGIN
        DEALLOCATE GetFKs;
    END;
    
    -- logging the end of execution
	if(@DbLoggerExists is not null)
    BEGIN
        SET @ErrorLogMsg =  'Procedure completed.' + @LineFeed + 
                            'Summary: ' + @LineFeed + 
                            '    ' + CONVERT(VARCHAR,@CorrectedCount) + ' successful FK check(s).' + @LineFeed + 
                            '    ' + CONVERT(VARCHAR,@FailedCount)    + ' failed FK check(s).'
                          ;
        SET @tsql = 'exec [Common].[LogMessage] @ApplicationName = ''$(SolutionName)'',@LogLevel = ''INFO'',@DatabaseID = @DbID,@ObjectID = @ObjID,@LogMessage = @ErrorLogMsg' ;
        exec sp_executesql @tsql, N'@ObjID INT,@ErrorLogMsg VARCHAR(max),@DbID INT',@ObjID=@@PROCID,@ErrorLogMsg =@ErrorLogMsg,@DbID = @ProcDbId ;
    END;
END
GO
