# Microsoft SQL Server Data Types
Complete list of all  Microsoft SQL Server Data Types

## Source link
 - [MSDN Data Types](https://msdn.microsoft.com/en-us/library/ms187752.aspx)
 - [MSDN Data Type Precedence](https://msdn.microsoft.com/en-us/library/ms190309.aspx)
 - [MSDN Data Type Synonyms](https://msdn.microsoft.com/en-us/library/ms177566.aspx)
 - [MSDN Precision, Scale, and Length](https://msdn.microsoft.com/en-us/library/ms190476.aspx)
 - [Integration Services Data Types](https://msdn.microsoft.com/en-us/library/ms141036.aspx)
 - [DbType Enumeration](https://msdn.microsoft.com/en-us/library/System.Data.DbType.aspx)
 - [SQL Server, SSIS and Biml Data Types](http://www.cathrinewilhelmsen.net/2014/05/27/sql-server-ssis-and-biml-data-types/)
 - [SQL Server Integration Services, Data Type Mapping ](http://milambda.blogspot.ru/2014/02/sql-server-integration-services-data.html)

## Data Type Precedence (Transact-SQL)
When an operator combines two expressions of different data types, the rules for data type precedence specify that the data type with the lower precedence is converted to the data type with the higher precedence.
If the conversion is not a supported implicit conversion, an error is returned.
When both operand expressions have the same data type, the result of the operation has that data type.

SQL Server uses the following precedence order for data types:
 1. sql_variant
 2. xml
 3. datetimeoffset
 4. datetime2
 5. datetime
 6. smalldatetime
 7. date
 8. time
 9. float
 10. real
 11. decimal
 12. money
 13. smallmoney
 14. bigint
 15. int
 16. smallint
 17. tinyint
 18. bit
 19. ntext
 20. text
 21. image
 22. timestamp
 23. uniqueidentifier
 24. nvarchar (including nvarchar(max) )
 25. nchar
 26. varchar (including varchar(max) )
 27. char
 28. varbinary (including varbinary(max) )
 29. binary (lowest)


## Data Type Synonyms (Transact-SQL)
Data type synonyms are included in SQL Server for ISO compatibility.
The following table lists the synonyms and the SQL Server system data types that they map to.

| Synonym                       | SQL Server system data type |
|-------------------------------|-----------------------------|
| Binary varying                | varbinary                   |
| char varying                  | varchar                     |
| character                     | char                        |
| character                     | char(1)                     |
| character(n)                  | char(n)                     |
| character varying(n)          | varchar(n)                  |
| Dec                           | decimal                     |
| Double precision              | float                       |
| float[(n)] for n = 1-7        | real                        |
| float[(n)] for n = 8-15       | float                       |
| integer                       | int                         |
| national character(n)         | nchar(n)                    |
| national char(n)              | nchar(n)                    |
| national character varying(n) | nvarchar(n)                 |
| national char varying(n)      | nvarchar(n)                 |
| national text                 | ntext                       |
| timestamp                     | rowversion                  |

Data type synonyms can be used instead of the corresponding base data type name in data definition language (DDL) statements, such as CREATE TABLE, CREATE PROCEDURE, or DECLARE @variable.
However, after the object is created, the synonyms have no visibility.
When the object is created, the object is assigned the base data type that is associated with the synonym.
There is no record that the synonym was specified in the statement that created the object.


## Precision, Scale, and Length (Transact-SQL)
Precision is the number of digits in a number. Scale is the number of digits to the right of the decimal point in a number. For example, the number 123.45 has a precision of 5 and a scale of 2.

In SQL Server, the default maximum precision of numeric and decimal data types is 38. In earlier versions of SQL Server, the default maximum is 28.

Length for a numeric data type is the number of bytes that are used to store the number. Length for a character string or Unicode data type is the number of characters. The length for binary, varbinary, and image data types is the number of bytes. For example, an int data type can hold 10 digits, is stored in 4 bytes, and does not accept decimal points. The int data type has a precision of 10, a length of 4, and a scale of 0.

When two char, varchar, binary, or varbinary expressions are concatenated, the length of the resulting expression is the sum of the lengths of the two source expressions or 8,000 characters, whichever is less.

When two nchar or nvarchar expressions are concatenated, the length of the resulting expression is the sum of the lengths of the two source expressions or 4,000 characters, whichever is less.

When two expressions of the same data type but different lengths are compared by using UNION, EXCEPT, or INTERSECT, the resulting length is the maximum length of the two expressions.

The precision and scale of the numeric data types besides decimal are fixed. If an arithmetic operator has two expressions of the same type, the result has the same data type with the precision and scale defined for that type. If an operator has two expressions with different numeric data types, the rules of data type precedence define the data type of the result. The result has the precision and scale defined for its data type.

The following table defines how the precision and scale of the result are calculated when the result of an operation is of type decimal. The result is decimal when either of the following is true:
 - Both expressions are decimal.
 - One expression is decimal and the other is a data type with a lower precedence than decimal.

The operand expressions are denoted as expression e1, with precision p1 and scale s1, and expression e2, with precision p2 and scale s2. The precision and scale for any expression that is not decimal is the precision and scale defined for the data type of the expression.

| Operation                              | Result precision                    | Result scale *      |
-----------------------------------------|-------------------------------------|---------------------|
| e1 + e2                                | max(s1, s2) + max(p1-s1, p2-s2) + 1 | max(s1, s2)         |
| e1 - e2                                | max(s1, s2) + max(p1-s1, p2-s2) + 1 | max(s1, s2)         |
| e1 * e2                                | p1 + p2 + 1                         | s1 + s2             |
| e1 / e2                                | p1 - s1 + s2 + max(6, s1 + p2 + 1)  | max(6, s1 + p2 + 1) |
| e1 { UNION \| EXCEPT \| INTERSECT } e2 | max(s1, s2) + max(p1-s1, p2-s2)     | max(s1, s2)         |
| e1 % e2                                | min(p1-s1, p2 -s2) + max( s1,s2 )   | max(s1, s2)         |
\* The result precision and scale have an absolute maximum of 38. When a result precision is greater than 38, the corresponding scale is reduced to prevent the integral part of a result from being truncated.


## SQL Server, SSIS and Biml Data Types
The table below shows a simplified mapping between SQL Server, SSIS and Biml data types. The table does not include all possible mappings or all data types, but is meant as a quick reference while developing and learning Biml.

| SQL Server       | SSIS                 | Biml                  |
|------------------|----------------------|-----------------------|
| bigint           | DT_I8                | Int64                 |
| binary           | DT_BYTES             | Binary                |
| bit              | DT_BOOL              | Boolean               |
| char             | DT_STR               | AnsiStringFixedLength |
| date             | DT_DBDATE            | Date                  |
| datetime         | DT_DBTIMESTAMP       | DateTime              |
| datetime2        | DT_DBTIMESTAMP2      | DateTime2             |
| datetimeoffset   | DT_DBTIMESTAMPOFFSET | DateTimeOffset        |
| decimal          | DT_NUMERIC           | Decimal               |
| float            | DT_R8                | Double                |
| geography        | DT_IMAGE             | Object                |
| geometry         | DT_IMAGE             | Object                |
| hierarchyid      | DT_BYTES             | Object                |
| image (*)        | DT_IMAGE             | Binary                |
| int              | DT_I4                | Int32                 |
| money            | DT_CY                | Currency              |
| nchar            | DT_WSTR              | StringFixedLength     |
| ntext (*)        | DT_NTEXT             | String                |
| numeric          | DT_NUMERIC           | Decimal               |
| nvarchar         | DT_WSTR              | String                |
| nvarchar(max)    | DT_NTEXT             | String                |
| real             | DT_R4                | Single                |
| rowversion       | DT_BYTES             | Binary                |
| smalldatetime    | DT_DBTIMESTAMP       | DateTime              |
| smallint         | DT_I2                | Int16                 |
| smallmoney       | DT_CY                | Currency              |
| sql_variant      | DT_WSTR              | Object                |
| text (*)         | DT_TEXT              | AnsiString            |
| time             | DT_DBTIME2           | Time                  |
| timestamp (*)    | DT_BYTES             | Binary                |
| tinyint          | DT_UI1               | Byte                  |
| uniqueidentifier | DT_GUID              | Guid                  |
| varbinary        | DT_BYTES             | Binary                |
| varbinary(max)   | DT_IMAGE             | Binary                |
| varchar          | DT_STR               | AnsiString            |
| varchar(max)     | DT_TEXT              | AnsiString            |
| xml              | DT_NTEXT             | Xml                   |

(\* *These data types will be removed in a future version of SQL Server. Avoid using these data types in new projects, and try to change them in current projects*)

