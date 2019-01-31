# Microsoft SQL Server Data Types
Detailed information about Microsoft SQL Server Data Types and its mapping to another databases and program languages analog.

## Table of Contents:
 - [Source link](#source-link)
 - [Data Type Precedence (Transact-SQL)](#data-type-precedence)
 - [Data Type Synonyms (Transact-SQL)](#data-type-synonyms)
 - [Precision, Scale, and Length (Transact-SQL)](#precision-scale-and-length)
 - [SQL Server, SSIS and Biml Data Types](#sql-server-ssis-and-biml-data-types)
 - [SQL Server Data Types Length](#sql-server-data-types-length)
 - [SQL Server to MySQL, Oracle, PostgreSQL and SQLite Data Type Mapping](#sql-server-to-mysql-oracle-postgresql-sqlite)


## Source link
<a id="source-link"></a>
 - [Data Types (Transact-SQL)](https://docs.microsoft.com/en-us/sql/t-sql/data-types/data-types-transact-sql)
 - [Data Type Precedence (Transact-SQL)](https://docs.microsoft.com/en-us/sql/t-sql/data-types/data-type-precedence-transact-sql)
 - [Data Type Synonyms (Transact-SQL)](https://docs.microsoft.com/en-us/sql/t-sql/data-types/data-type-synonyms-transact-sql)
 - [Precision, Scale, and Length](https://docs.microsoft.com/en-us/sql/t-sql/data-types/precision-scale-and-length-transact-sql)
 - [Integration Services Data Types](https://docs.microsoft.com/en-us/sql/integration-services/data-flow/integration-services-data-types)
 - [DbType Enumeration](https://docs.microsoft.com/en-us/dotnet/api/system.data.dbtype)
 - [SQL Server, SSIS and Biml Data Types](http://www.cathrinewilhelmsen.net/2014/05/27/sql-server-ssis-and-biml-data-types/)
 - [SQL Server Integration Services, Data Type Mapping](http://milambda.blogspot.ru/2014/02/sql-server-integration-services-data.html)
 - [SQL Server Data Type Conversion](https://msdn.microsoft.com/en-us/library/ms191530.aspx)
 - [SQL Server to MySQL Data Type Conversion](https://convertdb.com/mysql_mssql_mapping)
 - [SQL Server to Oracle Data Type Conversion](https://docs.oracle.com/cd/B19306_01/gateways.102/b14270/apa.htm)
 - [SQL Server to PostgreSQL Data Type Conversion](http://www.sqlines.com/sql-server-to-postgresql)
 - [SQL Server to SQLite Data Type Conversion](http://ericsink.com/mssql_mobile/data_types.html)

**[⬆ back to top](#table-of-contents)**


## Data Type Precedence (Transact-SQL)
<a id="data-type-precedence"></a>
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

**[⬆ back to top](#table-of-contents)**


## Data Type Synonyms (Transact-SQL)
<a id="data-type-synonyms"></a>
Data type synonyms are included in SQL Server for ISO compatibility.
The following table lists the synonyms and the SQL Server system data types that they map to.

| Synonym                       | System data type |
|-------------------------------|------------------|
| Binary varying                | varbinary        |
| char varying                  | varchar          |
| character                     | char             |
| character                     | char(1)          |
| character(n)                  | char(n)          |
| character varying(n)          | varchar(n)       |
| Dec                           | decimal          |
| Double precision              | float            |
| float[(n)] for n = 1-7        | real             |
| float[(n)] for n = 8-15       | float            |
| integer                       | int              |
| national character(n)         | nchar(n)         |
| national char(n)              | nchar(n)         |
| national character varying(n) | nvarchar(n)      |
| national char varying(n)      | nvarchar(n)      |
| national text                 | ntext            |
| timestamp                     | rowversion       |

Data type synonyms can be used instead of the corresponding base data type name in data definition language (DDL) statements, such as CREATE TABLE, CREATE PROCEDURE, or DECLARE @variable.
However, after the object is created, the synonyms have no visibility.
When the object is created, the object is assigned the base data type that is associated with the synonym.
There is no record that the synonym was specified in the statement that created the object.

**[⬆ back to top](#table-of-contents)**


## Precision, Scale, and Length (Transact-SQL)
<a id="precision-scale-and-length"></a>
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

**[⬆ back to top](#table-of-contents)**


## SQL Server, SSIS and Biml Data Types
<a id="sql-server-ssis-and-biml-data-types"></a>
The table below shows a simplified mapping between SQL Server, SSIS and Biml data types.
The table does not include all possible mappings or all data types, but is meant as a quick reference while developing and learning Biml.

| SQL Server         | SSIS Variables | SSIS Pipeline Buffer | OLE DB            | ADO.NET           | Biml                  |
|--------------------|----------------|----------------------|-------------------|-------------------|-----------------------|
| [bigint][1]        | Int64          | DT_I8                | LARGE_INTEGER     | Int64             | Int64                 |
| [binary][8]        | Object         | DT_BYTES             | -                 | Binary            | Binary                |
| [bit]              | Boolean        | DT_BOOL              | VARIANT_BOOL      | Boolean           | Boolean               |
| [char][5]          | String         | DT_STR               | VARCHAR           | StringFixedLength | AnsiStringFixedLength |
| [date]             | Object         | DT_DBDATE            | DBDATE            | Date              | Date                  |
| [datetime]         | DateTime       | DT_DBTIMESTAMP       | DATE              | DateTime          | DateTime              |
| [datetime2]        | Object         | DT_DBTIMESTAMP2      | DBTIME2           | DateTime2         | DateTime2             |
| [datetimeoffset]   | Object         | DT_DBTIMESTAMPOFFSET | DBTIMESTAMPOFFSET | DateTimeOffset    | DateTimeOffset        |
| [decimal][2]       | Decimal        | DT_NUMERIC           | NUMERIC           | Decimal           | Decimal               |
| [float][4]         | Double         | DT_R8                | FLOAT             | Double            | Double                |
| [geography]        | -              | DT_IMAGE             | -                 | Object            | Object                |
| [geometry]         | -              | DT_IMAGE             | -                 | Object            | Object                |
| [hierarchyid]      | -              | DT_BYTES             | -                 | Object            | Object                |
| [image] (*)        | Object         | DT_IMAGE             | -                 | Binary            | Binary                |
| [int][1]           | Int32          | DT_I4                | LONG              | Int32             | Int32                 |
| [money][3]         | Object         | DT_CY, DT_NUMERIC    | CURRENCY          | Currency          | Currency              |
| [nchar][5]         | String         | DT_WSTR              | NVARCHAR          | StringFixedLength | StringFixedLength     |
| [ntext] (*)        | String         | DT_NTEXT             | -                 | String            | String                |
| [numeric]          | Decimal        | DT_NUMERIC           | NUMERIC           | Decimal           | Decimal               |
| [nvarchar][5]      | String         | DT_WSTR              | NVARCHAR          | String            | String                |
| [nvarchar](max)    | Object         | DT_NTEXT             | -                 | -                 | String                |
| [real]             | Single         | DT_R4                | FLOAT, DOUBLE     | Single            | Single                |
| [rowversion]       | Object         | DT_BYTES             | -                 | Binary            | Binary                |
| [smalldatetime]    | DateTime       | DT_DBTIMESTAMP       | DATE              | DateTime          | DateTime              |
| [smallint][1]      | Int16          | DT_I2                | SHORT             | Int16             | Int16                 |
| [smallmoney][3]    | Object         | DT_CY, DT_NUMERIC    | CURRENCY          | Currency          | Currency              |
| [sql_variant]      | Object         | DT_WSTR, DT_NTEXT    | -                 | Object            | Object                |
| [table]            | Object         | -                    | -                 | -                 | -                     |
| [text] (*)         | Object         | DT_TEXT              | -                 | -                 | AnsiString            |
| [time]             | Object         | DT_DBTIME2           | DBTIME2           | Time              | Time                  |
| [timestamp] (*)    | Object         | DT_BYTES             | -                 | Binary            | Binary                |
| [tinyint][1]       | Byte           | DT_UI1               | BYTE              | Byte              | Byte                  |
| [uniqueidentifier] | String, Object | DT_GUID              | GUID              | Guid              | Guid                  |
| [varbinary][8]     | Object         | DT_BYTES             | -                 | Binary            | Binary                |
| [varbinary(max)][8]| Object         | DT_IMAGE             | -                 | Binary            | Binary                |
| [varchar][5]       | String         | DT_STR               | VARCHAR           | String            | AnsiString            |
| [varchar](max)     | Object         | DT_TEXT              | -                 | -                 | AnsiString            |
| [xml]              | Object         | DT_NTEXT             | -                 | -                 | Xml                   |

(\* *These data types will be removed in a future version of SQL Server. Avoid using these data types in new projects, and try to change them in current projects*)

**[⬆ back to top](#table-of-contents)**


## SQL Server Data Types Length
<a id="sql-server-data-types-length"></a>

| General Type          | Type               | N value        | Precision                         | Storage size, bytes   | Range (in SQL Server)                                                                                                                          |
|-----------------------|--------------------|----------------|-----------------------------------|----------------------:|------------------------------------------------------------------------------------------------------------------------------------------------|
| Exact Numerics        | [bit]              |                |                                   | 1                     | 1, 0                                                                                                                                           |
| Exact Numerics        | [tinyint][1]       |                |                                   | 1                     | 0 to 255                                                                                                                                       |
| Exact Numerics        | [smallint][1]      |                |                                   | 2                     | -2^15(-32768) to 2^15(32767)                                                                                                                   |
| Exact Numerics        | [int][1]           |                |                                   | 4                     | -2^31(-2 147 483 648) to 2^31(2 147 483 647)                                                                                                  |
| Exact Numerics        | [bigint][1]        |                |                                   | 8                     | -2^63(-9 233 372 036 854 775 808) to 2^63(9 233 372 036 854 775 807)                                                                           |
| Exact Numerics        | [decimal][2]       |                | 1-9<br/>10-19<br/>20-28<br/>29-38 | 5<br/>9<br/>13<br/>17 | from -10^38 +1 through 10^38 -1                                                                                                                |
| Exact Numerics        | [smallmoney][3]    |                |                                   | 4                     | -214 748.3648 to 214 748.3647                                                                                                                  |
| Exact Numerics        | [money][3]         |                |                                   | 8                     | -922 337 203 685 477.5808 to 922 337 203 685 477.5807                                                                                          |
| Approximate Numerics  | [float][4]         | 1-24<br/>25-53 | 7<br/>15                          | 4<br/>8               | -3.40E+38 to -1.18E-38, 0 and 1.18E-38 to 3.40E+38<br/>-1.79E+308 to -2.23E-308, 0 and 2.23E-308 to 1.79E+308                                  |
| Date and Time         | [date]             |                |                                   | 3                     | 0001-01-01 through 9999-12-31<br/>January 1, 1 CE through December 31, 9999 CE                                                                 |
| Date and Time         | [smalldatetime]    |                |                                   | 4                     | 1900-01-01 through 2079-06-06<br/>January 1, 1900 through June 6, 2079<br/>00:00:00 through 23:59:59                                           |
| Date and Time         | [time]             |                | 8-11<br/>12-13<br/>14-16          | 3<br/>4<br/>5         | 00:00:00.0000000 through 23:59:59.9999999                                                                                                      |
| Date and Time         | [datetime2]        |                | 1-2<br/>3-4<br/>5-7               | 6<br/>7<br/>8         | 0001-01-01 through 9999-12-31<br/>January 1, 1 CE through December 31, 9999 CE<br/>00:00:00 through 23:59:59.9999999                           |
| Date and Time         | [datetime]         |                |                                   | 8                     | anuary 1, 1753 through December 31, 9999<br/>00:00:00 through 23:59:59.997                                                                     |
| Date and time         | [datetimeoffset]   |                | 26-29<br/>30-34                   | 8<br/>10              | 0001-01-01 through 9999-12-31<br/>January 1, 1 CE through December 31, 9999 CE<br/>00:00:00 through 23:59:59.9999999<br/>-14:00 throuth +14:00 |
| Character Strings     | [char][5]          | 1-8000         |                                   | n                     |                                                                                                                                                |
| Character Strings     | [varchar][5]       | 1-8000         |                                   | n + 2                 |                                                                                                                                                |
| Character Strings     | [varchar](max)     | 1-(2^31 - 1)   |                                   | 2^31 - 1 + 2          |                                                                                                                                                |
| Character Strings     | [nchar][5]         | 1-4000         |                                   |                       |                                                                                                                                                |
| Character Strings     | [nvarchar][5]      | 1-4000         |                                   |                       |                                                                                                                                                |
| Character Strings     | [nvarchar](max)    | 1-(2^31 - 1)   |                                   |                       |                                                                                                                                                |
| Character Strings     | [ntext](*)         | 1-(2^30 - 1)   |                                   | n + n                 |                                                                                                                                                |
| Character Strings     | [text](*)          | 1-(2^31 - 1)   |                                   |                       |                                                                                                                                                |
| Binary Strings        | [image](*)         | 1-(2^31 - 1)   |                                   | n                     |                                                                                                                                                |
| Binary Strings        | [binary][8]        | 1-8000         |                                   | n                     |                                                                                                                                                |
| Binary Strings        | [varbinary][8]     | 1-8000         |                                   | n                     |                                                                                                                                                |
| Binary Strings        | [varbinary(max)][8]| 1-(2^31 - 1)   |                                   | n + 2                 |                                                                                                                                                |
| Other Data Types      | [cursor]           |                |                                   |                       |                                                                                                                                                |
| Other Data Types      | [sql_variant]      |                |                                   | max 8016              |                                                                                                                                                |
| Other Data Types      | [hierarchyid]      |                |                                   | max 892               |                                                                                                                                                |
| Other Data Types      | [rowversion]       |                |                                   | 8                     |                                                                                                                                                |
| Other Data Types      | [timestamp](*)     |                |                                   |                       |                                                                                                                                                |
| Other Data Types      | [uniqueidentifier] |                |                                   | 16                    |                                                                                                                                                |
| Other Data Types      | [xml]              |                |                                   | max 2Gb               |                                                                                                                                                |
| Other Data Types      | [table]            |                |                                   |                       |                                                                                                                                                |
| Spatial Data Types    | [geometry]         |                |                                   |                       |                                                                                                                                                |
| Spatial Data Types    | [geography]        |                |                                   |                       |                                                                                                                                                |

**[⬆ back to top](#table-of-contents)**


## SQL Server to MySQL, Oracle, PostgreSQL, SQLite Data Type Mapping
<a id="sql-server-to-mysql-oracle-postgresql-sqlite"></a>

Common data-type conversions between SQL Server, Oracle, Sybase ASE, and DB2.
More details [here](https://www.sqlserverscience.com/documentation/common-data-type-conversions-between-sql-server-oracle-sybase-ase-and-db2/)

| Source      | Destination |
|-------------|-------------|
| MSSQLSERVER | DB2         |
| MSSQLSERVER | ORACLE      |
| MSSQLSERVER | SYBASE      |
| ORACLE      | MSSQLSERVER |

```tsql
DECLARE @source_dbms         SYSNAME = N'%'
      , @source_version      SYSNAME = N'%'
      , @source_type         SYSNAME = N'%'
      , @destination_dbms    SYSNAME = N'%'
      , @destination_version SYSNAME = N'%'
      , @destination_type    SYSNAME = N'%'
      , @defaults_only       BIT     = 0;

SELECT *
FROM sys.fn_helpdatatypemap (
    @source_dbms
    , @source_version
    , @source_type
    , @destination_dbms
    , @destination_version
    , @destination_type
    , @defaults_only
    );
```

| General Type          | Type               | MySQL                           | Oracle        | PostgreSQL                  | SQLite  |
|-----------------------|--------------------|---------------------------------|---------------|-----------------------------|--------:|
| Exact Numerics        | [bit]              | [TINYINT(1)][20]                | NUMBER(3)     | BOOLEAN                     | INTEGER |
| Exact Numerics        | [tinyint][1]       | [TINYINT(3) UNSIGNED][20]       | NUMBER(3)     | SMALLINT                    | INTEGER |
| Exact Numerics        | [smallint][1]      | [SMALLINT][20]                  | NUMBER(5)     | SMALLINT                    | INTEGER |
| Exact Numerics        | [int][1]           | [INT][20]                       | NUMBER(10)    | INT                         | INTEGER |
| Exact Numerics        | [bigint][1]        | [BIGINT][20]                    | NUMBER(19)    | BIGINT                      | INTEGER |
| Exact Numerics        | [decimal][2]       | [DECIMAL][21]                   | NUMBER(p[,s]) | DECIMAL(p,s)                | REAL    |
| Exact Numerics        | [smallmoney][3]    | [DECIMAL(10,4)][21]             | NUMBER(10,4)  | MONEY                       | REAL    |
| Exact Numerics        | [money][3]         | [DECIMAL(19,4)][21]             | NUMBER(19,4)  | MONEY                       | REAL    |
| Approximate Numerics  | [float][4]         | [FLOAT][22]                     | FLOAT(49)     | DOUBLE PRECISION            | REAL    |
| Date and Time         | [date]             | [DATE][22]                      | DATE          | DATE                        | TEXT    |
| Date and Time         | [smalldatetime]    | [TIMESTAMP][23]                 | DATE          | TIMESTAMP(0)                | TEXT    |
| Date and Time         | [time]             | [TIME][24]                      |               | TIME                        | TEXT    |
| Date and Time         | [datetime2]        | [DATETIME][23]                  |               | TIMESTAMP                   | TEXT    |
| Date and Time         | [datetime]         | [DATETIME][23]                  | DATE          | TIMESTAMP(3)                | TEXT    |
| Date and time         | [datetimeoffset]   |                                 |               | TIMESTAMP<br/>with time zone| TEXT    |
| Character Strings     | [char][5]          | CHAR                            | CHAR          | CHAR                        | TEXT    |
| Character Strings     | [varchar][5]       | VARCHAR                         | VARCHAR2      | VARCHAR                     | TEXT    |
| Character Strings     | [varchar](max)     | LONGTEXT                        | VARCHAR2      | TEXT                        | TEXT    |
| Character Strings     | [nchar][5]         | NCHAR                           |               | NCHAR                       | TEXT    |
| Character Strings     | [nvarchar][5]      | VARCHAR with character set utf8 | NCHAR         | VARCHAR                     | TEXT    |
| Character Strings     | [nvarchar](max)    | LONGTEXT                        | NCHAR         | TEXT                        | TEXT    |
| Character Strings     | [ntext][4] (*)     |                                 | LONG          | TEXT                        | TEXT    |
| Character Strings     | [text][4] (*)      |                                 | LONG          | TEXT                        | TEXT    |
| Binary Strings        | [image][4] (*)     | LONGBLOB                        | LONG RAW      | BYTEA                       | BLOB    |
| Binary Strings        | [binary][8]        | BINARY                          | RAW           | BYTEA                       | BLOB    |
| Binary Strings        | [varbinary][8]     |                                 | RAW           | BYTEA                       | BLOB    |
| Binary Strings        | [varbinary(max)][8]| LONGTEXT                        | RAW           | BYTEA                       | BLOB    |
| Other Data Types      | [cursor]           |                                 |               |                             | TEXT    |
| Other Data Types      | [sql_variant]      | BLOB                            |               |                             | TEXT    |
| Other Data Types      | [hierarchyid]      |                                 |               |                             | TEXT    |
| Other Data Types      | [rowversion]       |                                 |               | BYTEA                       | TEXT    |
| Other Data Types      | [timestamp] (*)    |                                 | RAW           | BYTEA                       | TEXT    |
| Other Data Types      | [uniqueidentifier] | CHAR                            | CHAR(36)      | CHAR(16)                    | TEXT    |
| Other Data Types      | [xml]              |                                 |               | XML                         | TEXT    |
| Other Data Types      | [table]            |                                 |               |                             | -       |
| Spatial Data Types    | [geometry]         |                                 |               | VARCHAR                     | TEXT    |
| Spatial Data Types    | [geography]        |                                 |               | VARCHAR                     | TEXT    |

**[⬆ back to top](#table-of-contents)**

(\* *These data types will be removed in a future version of SQL Server. Avoid using these data types in new projects, and try to change them in current projects*)

[1]:https://docs.microsoft.com/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
[2]:https://docs.microsoft.com/sql/t-sql/data-types/decimal-and-numeric-transact-sql
[3]:https://docs.microsoft.com/sql/t-sql/data-types/money-and-smallmoney-transact-sql
[4]:https://docs.microsoft.com/sql/t-sql/data-types/float-and-real-transact-sql
[5]:https://docs.microsoft.com/sql/t-sql/data-types/char-and-varchar-transact-sql
[6]:https://docs.microsoft.com/sql/t-sql/data-types/nchar-and-nvarchar-transact-sql
[7]:https://docs.microsoft.com/sql/t-sql/data-types/ntext-text-and-image-transact-sql
[8]:https://docs.microsoft.com/sql/t-sql/data-types/binary-and-varbinary-transact-sql

[bit]:https://docs.microsoft.com/sql/t-sql/data-types/bit-transact-sql
[date]:https://docs.microsoft.com/sql/t-sql/data-types/date-transact-sql
[smalldatetime]:https://docs.microsoft.com/sql/t-sql/data-types/smalldatetime-transact-sql
[time]:https://docs.microsoft.com/sql/t-sql/data-types/time-transact-sql
[datetime2]:https://docs.microsoft.com/sql/t-sql/data-types/datetime2-transact-sql
[datetime]:https://docs.microsoft.com/sql/t-sql/data-types/datetime-transact-sql
[datetimeoffset]:https://docs.microsoft.com/sql/t-sql/data-types/datetimeoffset-transact-sql
[cursor]:https://docs.microsoft.com/sql/t-sql/data-types/cursor-transact-sql
[sql_variant]:https://docs.microsoft.com/sql/t-sql/data-types/sql-variant-transact-sql
[hierarchyid]:https://docs.microsoft.com/sql/t-sql/data-types/hierarchyid-data-type-method-reference
[rowversion]:https://docs.microsoft.com/sql/t-sql/data-types/rowversion-transact-sql
[timestamp]:https://docs.microsoft.com/sql/t-sql/data-types/rowversion-transact-sql#remarks
[uniqueidentifier]:https://docs.microsoft.com/sql/t-sql/data-types/uniqueidentifier-transact-sql
[xml]:https://docs.microsoft.com/sql/t-sql/xml/xml-transact-sql
[table]:https://docs.microsoft.com/sql/t-sql/data-types/table-transact-sql
[geometry]:https://docs.microsoft.com/sql/t-sql/spatial-geometry/spatial-types-geometry-transact-sql
[geography]:https://docs.microsoft.com/sql/t-sql/spatial-geography/spatial-types-geography

[20]:https://dev.mysql.com/doc/refman/8.0/en/integer-types.html
[21]:https://dev.mysql.com/doc/refman/8.0/en/fixed-point-types.html
[22]:https://dev.mysql.com/doc/refman/8.0/en/floating-point-types.html
[23]:https://dev.mysql.com/doc/refman/8.0/en/datetime.html
[24]:https://dev.mysql.com/doc/refman/8.0/en/time.html
