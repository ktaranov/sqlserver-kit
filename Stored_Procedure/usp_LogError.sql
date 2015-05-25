IF OBJECT_ID('[dbo].[usp_LogError]', 'P') IS NULL
EXECUTE('CREATE PROCEDURE [dbo].[usp_LogError] AS SELECT 1');
go

IF OBJECT_ID('[ErrorLog]','U') IS NULL
CREATE TABLE [dbo].[ErrorLog] (
     [ErrorLogID] INT IDENTITY(1, 1) NOT NULL
    ,[ErrorTime] DATETIME NOT NULL CONSTRAINT [DF_ErrorLog_ErrorTime] DEFAULT(getdate())
    ,[UserName] SYSNAME NOT NULL
    ,[ErrorNumber] INT NOT NULL
    ,[ErrorSeverity] INT NULL
    ,[ErrorState] INT NULL
    ,[ErrorProcedure] NVARCHAR(126) NULL
    ,[ErrorLine] INT NULL
    ,[ErrorMessage] NVARCHAR(4000) NOT NULL
    ,CONSTRAINT [PK_ErrorLog_ErrorLogID] PRIMARY KEY CLUSTERED ([ErrorLogID] ASC) WITH (
     PAD_INDEX = OFF
     ,STATISTICS_NORECOMPUTE = OFF
     ,IGNORE_DUP_KEY = OFF
     ,ALLOW_ROW_LOCKS = ON
     ,ALLOW_PAGE_LOCKS = ON
  ) ON [PRIMARY]
 ) ON [PRIMARY]
go


ALTER PROCEDURE [dbo].[usp_LogError] 
    @ErrorLogID [int] = 0 OUTPUT -- contains the ErrorLogID of the row inserted
AS                               -- by usp_LogError in the ErrorLog table
BEGIN
    SET NOCOUNT ON;

    -- Output parameter value of 0 indicates that error 
    -- information was not logged
    SET @ErrorLogID = 0;

    BEGIN TRY
        -- Return if there is no error information to log
        IF ERROR_NUMBER() IS NULL
            RETURN;

        -- Return if inside an uncommittable transaction.
        -- Data insertion/modification is not allowed when 
        -- a transaction is in an uncommittable state.
        IF XACT_STATE() = -1
        BEGIN
            PRINT 'Cannot log error since the current transaction is in an uncommittable state. ' 
                + 'Rollback the transaction before executing usp_LogError in order to successfully log error information.';
            RETURN;
        END

        INSERT [dbo].[ErrorLog] 
            (
            [UserName], 
            [ErrorNumber], 
            [ErrorSeverity], 
            [ErrorState], 
            [ErrorProcedure], 
            [ErrorLine], 
            [ErrorMessage]
            ) 
        VALUES 
            (
            CONVERT(sysname, CURRENT_USER), 
            ERROR_NUMBER(),
            ERROR_SEVERITY(),
            ERROR_STATE(),
            ERROR_PROCEDURE(),
            ERROR_LINE(),
            ERROR_MESSAGE()
            );

        -- Pass back the ErrorLogID of the row inserted
        SET @ErrorLogID = @@IDENTITY;
    END TRY

    BEGIN CATCH
        PRINT 'An error occurred in stored procedure usp_LogError: ';
        EXECUTE [dbo].[usp_PrintError];
        RETURN -1;
    END CATCH
END;
go
