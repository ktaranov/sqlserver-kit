# SQL Server Name Convention and T-SQL Programming Style

Official Reference and useful links
 - [Transact-SQL Formatting Standards](https://www.simple-talk.com/sql/t-sql-programming/transact-sql-formatting-standards-%28coding-styles%29/) (by Robert Sheldon)
 - [General Database Conventions](http://kejser.org/database-naming-conventions/general-database-conventions/) (by Thomas Kejser)
 - [Writing Readable SQL](http://www.codeproject.com/Articles/126380/Writing-Readable-SQL)
 - [SQL Style Guide](http://www.sqlstyle.guide/) (Simon Holywell)
 - [SQL Code Layout and Beautification](https://www.simple-talk.com/sql/t-sql-programming/sql-code-layout-and-beautification/) (by William Brewer)
 - [TSQL Coding Style](http://www.databasejournal.com/features/mssql/tsql-coding-style.html) (by Gregory Larsen)
 - [Database object Limitations](http://technet.microsoft.com/en-us/library/ms172451%28v=sql.110%29.aspx)
 - [User-Defined Functions MSDN](http://msdn.microsoft.com/en-us/library/ms191007.aspx)
 - [Synonim TECHNET](http://technet.microsoft.com/en-us/library/ms187552(v=sql.110).aspx)
 - [Primary and Foreign Key Constraints MSDN](http://msdn.microsoft.com/en-us/library/ms179610.aspx)
 - [sys.objects MSDN](http://msdn.microsoft.com/en-us/library/ms190324.aspx)
 - [Constraints TECHNET](http://technet.microsoft.com/en-us/library/ms189862%28v=sql.105%29.aspx)
 - [CHECK Constraint TECHNET](http://technet.microsoft.com/en-us/library/ms188258%28v=sql.105%29.aspx)
 - [SQL Server CLR Integration MSDN](http://msdn.microsoft.com/en-us/library/ms254498%28v=vs.110%29.aspx)
 - [CLR Databse Objects MSDN](http://msdn.microsoft.com/en-us/library/ms345099%28SQL.100%29.aspx)
 - [CLR Stored Procedures](http://msdn.microsoft.com/en-us/library/ms131094%28v=sql.100%29.aspx)
 - [User-defined Functions](http://msdn.microsoft.com/en-us/library/ms191320.aspx)
 - [MSDN SET NOCOUNT ON](https://msdn.microsoft.com/en-us/library/ms189837.aspx)


## SQL Server Object Name Convention

| Object                           | Code | Notation   | Length | Plural | Prefix | Suffix | Abbreviation | Char Mask    | Example                            |
|----------------------------------|------| ---------- |-------:|--------|--------|--------|--------------|--------------|------------------------------------|
| Database                         |      | UPPERCASE  |     30 | No     | No     | No     | Yes          | [A-z]        | MYDATABASE                         |
| Database Trigger                 |      | PascalCase |     50 | No     | DTR_   | No     | Yes          | [A-z]        | DTR_CheckLogin                     |
| Schema                           |      | lowercase  |     30 | No     | No     | No     | Yes          | [A-z][0-9]   | myschema                           |
| File Table                       |      | PascalCase |    128 | No     | FT_    | No     | Yes          | [A-z][0-9]   | FT_MyTable                         |
| Global Temporary Table           |      | PascalCase |    118 | No     | No     | No     | Yes          | ##[A-z][0-9] | ##MyTable                          |
| Local Temporary Table            |      | PascalCase |    118 | No     | No     | No     | Yes          | #[A-z][0-9]  | #MyTable                           |
| Table                            | U    | PascalCase |     30 | No     | No     | No     | Yes          | [A-z][0-9]   | MyTable                            |
| Table Column                     |      | PascalCase |     30 | No     | No     | No     | Yes          | [A-z][0-9]   | MyColumn                           |
| Table Default Values             | D    | PascalCase |    128 | No     | DF_    | No     | Yes          | [A-z][0-9]   | DF_MyTable_MyColumn                |
| Table Check Column Constraint    | C    | PascalCase |    128 | No     | CK_    | No     | Yes          | [A-z][0-9]   | CK_MyTable_MyColumn                |
| Table Check Table Constraint     | C    | PascalCase |    128 | No     | CTK_   | No     | Yes          | [A-z][0-9]   | CTK_MyTable_MyColumn_AnotherColumn |
| Table Primary Key                | PK   | PascalCase |    128 | No     | PK_    | No     | Yes          | [A-z][0-9]   | PK_MyTableID                       |
| Table Alternative Key            | UQ   | PascalCase |    128 | No     | AK_    | No     | Yes          | [A-z][0-9]   | AK_MyTable_MyColumn_AnotherColumn  |
| Table Foreign Key                | F    | PascalCase |    128 | No     | FK_    | No     | Yes          | [A-z][0-9]   | FK_MyTable_ForeignTableID          |
| Table Clustered Index            |      | PascalCase |    128 | No     | IXC_   | No     | Yes          | [A-z][0-9]   | IXC_MyTable_MyColumn_AnotherColumn |
| Table Non Clustered Index        |      | PascalCase |    128 | No     | IX_    | No     | Yes          | [A-z][0-9]   | IX_MyTable_MyColumn_AnotherColumn  |
| Table Trigger                    | TR   | PascalCase |    128 | No     | TR_    | No     | Yes          | [A-z][0-9]   | TR_MyTable_LogicalName             |
| View                             | V    | PascalCase |    128 | No     | VI_    | No     | No           | [A-z][0-9]   | VI_LogicalName                     |
| Stored Procedure                 | P    | PascalCase |    128 | No     | usp_   | No     | No           | [A-z][0-9]   | usp_LogicalName                    |
| Scalar User-Defined Function     | FN   | PascalCase |     50 | No     | udf_   | No     | No           | [A-z][0-9]   | udf_FunctionLogicalName            |
| Table-Valued Function            | FN   | PascalCase |     50 | No     | tvf_   | No     | No           | [A-z][0-9]   | tvf_FunctionLogicalName            |
| Synonym                          | SN   | camelCase  |    128 | No     | sy_    | No     | No           | [A-z][0-9]   | sy_logicalName                     |
| Sequence                         | SO   | PascalCase |    128 | No     | sq_    | No     | No           | [A-z][0-9]   | sq_TableName                       |
| CLR Assembly                     |      | PascalCase |    128 | No     | CA     | No     | Yes          | [A-z][0-9]   | CALogicalName                      |
| CLR Stored Procedures            | PC   | PascalCase |    128 | No     | pc_    | No     | Yes          | [A-z][0-9]   | pc_CAName_LogicalName              |
| CLR Scalar User-Defined Function |      | PascalCase |     50 | No     | cudf_  | No     | No           | [A-z][0-9]   | cudf_CAName_LogicalName            |
| CLR Table-Valued Function        |      | PascalCase |     50 | No     | ctvf_  | No     | No           | [A-z][0-9]   | ctvf_CAName_LogicalName            |
| CLR User-Defined Aggregates      |      | PascalCase |     50 | No     | ca_    | No     | No           | [A-z][0-9]   | ca_CAName_LogicalName              |
| CLR  User-Defined Types          |      | PascalCase |     50 | No     | ct_    | No     | No           | [A-z][0-9]   | ct_CAName_LogicalName              |
| CLR  Triggers                    |      | PascalCase |     50 | No     | ctr_   | No     | No           | [A-z][0-9]   | ctr_CAName_LogicalName             |


## T-SQL Programming Style
SQL Server TSQL Coding Conventions, Best Practices, and Programming Guidelines

### General programming style
 - Delimiters: spaces (not tabs)
 - No square brackets [] are allowed in object names and alias, use only Latin symbols [A-z] and numeric [0-9]
 - All finished expressions should have `;` at the end
 - All scripts should end with `GO` and line break
 - The first argument in SELECT expression should be on the same line with it: `SELECT LastName`
 - Arguments are divided by line breaks, commas should be placed before an argument:
   
   ```sql
   SELECT FirstName
         , LastName
   ```
 - Keywords and data types declaration should be in **UPPERCASE**
 - `FROM, WHERE, INTO, JOIN, GROUP BY, ORDER BY` expressions should be aligned so, that all their arguments are placed under each other
 - All objects must used with schema names: `FROM dbo.Table`

Example:

```sql
SELECT t1.Value1 AS Val1
     , t1.Value2 AS Val2
     , t2.Value3 AS Val3
  INTO #Table3
  FROM dbo.Table1 AS t1
 INNER JOIN dbo.Table3 AS t2
         ON t1.Value1 = t2.Value1
 WHERE t1.Value1 > 1
   AND t2.Value2 >= 101
 ORDER BY t2.Value2;
```

### Stored procedures and functions programming style

 - All stored procedures and functions should use ALTER statement and start with the object presence check
 - ALTER statement should be preceded by 2 line breaks
 - Parameters name should be in **camelCase**
 - Parameters should be placed under procedure name divided by line breaks
 - After the ALTER statement and before AS keyword should be placed a comment with execution example
 - The procedure or function should begin with parameter check
 - Always use `BEGIN TRY` and `BEGIN CATCH`
 - Use `SET NOCOUNT ON` for stops the message that shows the count of the number of rows affected by a Transact-SQL statement

Stored Procedure Example:

```sql
IF OBJECT_ID('dbo.usp_StoredProcedure', 'P') IS NULL
EXECUTE('CREATE PROCEDURE dbo.usp_StoredProcedure as SELECT 1');
GO


ALTER PROCEDURE dbo.usp_StoredProcedure (
                @parameterValue1 SMALLINT
              , @parameterValue2 NVARCHAR(300)
)
/*
EXECUTE dbo.usp_StoredProcedure
        @parameterValue1 = 0
      , @parameterValue2 = N'BULK'
*/
AS
SET NOCOUNT ON;
BEGIN TRY
    IF (@parameterValue1 < 0 OR @parameterValue2 NOT IN ('SIMPLE', 'BULK', 'FULL'))
    RAISERROR('Not valid data parameter!', 16, 1);
    PRINT @parameterValue2;
END TRY

BEGIN CATCH
    -- Print error information. 
    PRINT 'Error: '       + CONVERT(varchar(50), ERROR_NUMBER())   +
          ', Severity: '  + CONVERT(varchar(5),  ERROR_SEVERITY()) +
          ', State: '     + CONVERT(varchar(5),  ERROR_STATE())    +
          ', Procedure: ' + ISNULL(ERROR_PROCEDURE(), '-')         +
          ', Line: '      + CONVERT(varchar(5),  ERROR_LINE())     +
          ', User name: ' + CONVERT(sysname,     CURRENT_USER);
    PRINT ERROR_MESSAGE();
END CATCH;
GO

```
