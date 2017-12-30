IF OBJECT_ID('dbo.udf_CheckDynamicSQL', 'FN') IS NULL
EXECUTE ('CREATE FUNCTION dbo.udf_CheckDynamicSQL() RETURNS INT AS BEGIN RETURN 1 END;');
GO

ALTER FUNCTION dbo.udf_CheckDynamicSQL(
    @dynamicSQL NVARCHAR (MAX)
)
RETURNS NVARCHAR (2000)
AS
/*
.SYNOPSIS
    Check Dynamic SQL Statement Syntax

.DESCRIPTION
    Check Dynamic SQL Statement Syntax first output result using sys.dm_exec_describe_first_result_set
    https://docs.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-describe-first-result-set-transact-sql

.PARAMETER @dynamicSQL
    Dynamic SQL statement for checking

.EXAMPLE
    SELECT dbo.udf_CheckDynamicSQL('SELECT * , FROM sys.databases;');
    -- RETURN: Incorrect syntax near the keyword 'FROM'.

.EXAMPLE
    SELECT dbo.udf_CheckDynamicSQL('SELECT TOP(1) * FROM sys.databases;');
    --RETURN: OK

.NOTE
    Author: Eli Leiba
    Source link: https://www.mssqltips.com/sqlservertip/4981/sql-server-function-to-check-dynamic-sql-syntax/
*/
BEGIN
   DECLARE @Result NVARCHAR (2000);

   IF EXISTS (
         SELECT 1
         FROM sys.dm_exec_describe_first_result_set (@dynamicSQL, NULL, 0)
         WHERE [error_message] IS NOT NULL
            AND [error_number] IS NOT NULL
            AND [error_severity] IS NOT NULL
            AND [error_state] IS NOT NULL
            AND [error_type] IS NOT NULL
            AND [error_type_desc] IS NOT NULL
         )
   BEGIN
      SELECT @Result = [error_message]
      FROM sys.dm_exec_describe_first_result_set(@dynamicSQL, NULL, 0)
      WHERE column_ordinal = 0;
   END
   ELSE
   BEGIN
      SET @Result = 'OK'
   END

   RETURN (@Result);
END
GO
