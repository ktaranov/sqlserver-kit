# SQL Server Name Convention and T-SQL Script Formatting


## SQL Server Object Name

| Object                           | Code | Notation   | Length | Plural | Prefix | Suffix | Abbreviation | Char Mask    | Example                            |
| -------------------------------- | ---- | ---------- | ------ | ------ | ------ | ------ | ------------ | ------------ | --------------------------------   |
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
| Table Trigger                    |TR    | PascalCase |    128 | No     | TR_    | No     | Yes          | [A-z][0-9]   | TR_MyTable_LogicalName             |
| View                             |V     | PascalCase |    128 | No     | VI_    | No     | No           | [A-z][0-9]   | VI_LogicalName                     |
| Stored Procedure                 |P     | PascalCase |    128 | No     | usp_   | No     | No           | [A-z][0-9]   | usp_LogicalName                    |
| Scalar User-Defined Function     |FN    | PascalCase |     50 | No     | udf_   | No     | No           | [A-z][0-9]   | udf_FunctionLogicalName            |
| Table-Valued Function            |FN    | PascalCase |     50 | No     | tvf_   | No     | No           | [A-z][0-9]   | tvf_FunctionLogicalName            |
| Synonim                          |SN    | camelCase  |    128 | No     | sy_    | No     | No           | [A-z][0-9]   | sy_logicalName                     |
| Sequence                         |SO    | PascalCase |    128 | No     | sq_    | No     | No           | [A-z][0-9]   | sq_TableName                       |
| CLR Assembley                    |      | PascalCase |    128 | No     | CA     | No     | Yes          | [A-z][0-9]   | CALogicalName                      |
| CLR Stored Procedures            |PC    | PascalCase |    128 | No     | pc_    | No     | Yes          | [A-z][0-9]   | pc_CAName_LogicalName              |
| CLR Scalar User-Defined Function |      | PascalCase |     50 | No     | cudf_  | No     | No           | [A-z][0-9]   | cudf_CAName_LogicalName            |
| CLR Table-Valued Function        |      | PascalCase |     50 | No     | ctvf_  | No     | No           | [A-z][0-9]   | ctvf_CAName_LogicalName            |
| CLR User-Defined Aggregates      |      | PascalCase |     50 | No     | ca_    | No     | No           | [A-z][0-9]   | ca_CAName_LogicalName              |
| CLR  User-Defined Types          |      | PascalCase |     50 | No     | ct_    | No     | No           | [A-z][0-9]   | ct_CAName_LogicalName              |
| CLR  Triggers                    |      | PascalCase |     50 | No     | ctr_   | No     | No           | [A-z][0-9]   | ctr_CAName_LogicalName             |

##T-SQL Script Formatting

###General script formatting
 - No tabs are allowed
 - No square brackets [ ] are allowed in object names
 - All finished expressions should have ; at the end
 - All scripts should end with GO and line break
 - The first argument in SELECT expression should be on the same line with it
 - Arguments are divided by line breaks, commas should be placed before an argument
 - FROM, WHERE, INTO expressions should be aligned so, that all their arguments are placed under each other

Example:
<pre><code>SELECT Table1.Value1
     , Table1.Value2
     , Table1.Value3
INTO   #Table2
FROM   Table1
WHERE  Value1 = 1
ORDER BY Value2;
</code></pre>

###Stored procedures and functions formatting
 - All stored procedures and functions should use ALTER statement and start with the object presence check
 - ALTER statement should be preceded by 2 line breaks
 - Parameters should be placed under procedure name divided by line breaks
 - After the ALTER statement  should be placed a comment with execution example
 - The procedure or function should begin with parameter check

Example:
<pre><code>IF OBJECT_ID('usp_StoredProcedure', 'P') IS NULL
EXECUTE('CREATE PROCEDURE usp_StoredProcedure as SELECT 1');
GO


ALTER PROCEDURE usp_StoredProcedure (
                @parameter1 BIT
              , @parameter2 BIT
)
/*
EXECUTE usp_StoredProcedure
        @parameter1 = 0
      , @parameter2 = 1
*/
AS
BEGIN
    IF (@parameter1 < 0 OR @parameter2 > 2) RAISERROR('Not valid data parameter!', 16, 1);
...</code></pre>

## Offical Reference
 - [Database object TECHNET] (Limitations)
 - [User-Defined Functions MSDN]
 - [Synonim TECHNET]
 - [Primary and Foreign Key Constraints MSDN]
 - [sys.objects MSDN]
 - [Constraints TECHNET]
 - [CHECK Constraint TECHNET]
 - [SQL Server CLR Integration MSDN]
 - [CLR Databse Objects MSDN]
 - [User-defined Functions]
 
[Database object TECHNET]:http://technet.microsoft.com/en-us/library/ms172451%28v=sql.110%29.aspx
[User-Defined Functions MSDN]:http://msdn.microsoft.com/en-us/library/ms191007.aspx
[Synonim TECHNET]:http://technet.microsoft.com/en-us/library/ms187552(v=sql.110).aspx
[Primary and Foreign Key Constraints MSDN]:http://msdn.microsoft.com/en-us/library/ms179610.aspx
[sys.objects MSDN]:http://msdn.microsoft.com/en-us/library/ms190324.aspx
[Constraints TECHNET]:http://technet.microsoft.com/en-us/library/ms189862%28v=sql.105%29.aspx
[CHECK Constraint TECHNET]:http://technet.microsoft.com/en-us/library/ms188258%28v=sql.105%29.aspx
[SQL Server CLR Integration MSDN]:http://msdn.microsoft.com/en-us/library/ms254498%28v=vs.110%29.aspx
[CLR Databse Objects MSDN]:http://msdn.microsoft.com/en-us/library/ms345099%28SQL.100%29.aspx
[CLR Stored Procedures]:http://msdn.microsoft.com/en-us/library/ms131094%28v=sql.100%29.aspx
[User-defined Functions]:http://msdn.microsoft.com/en-us/library/ms191320.aspx
