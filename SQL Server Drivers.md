# SQL Server Drivers
SQL Server supports a wide variety of drivers, which are used by client applications or services to connect and query for data.
Please see below for a summary of the different drivers, both current and legacy.

[SQL Server Drivers](https://docs.microsoft.com/en-us/sql/connect/sql-server-drivers)


## Current SQL Drivers
The following SQL Drivers are actively developed. Each driver has a support statement that can be found by following the links.

### ADO.NET
ADO.NET is a library that is a standard part of the .Net framework. It is a C# implementation of the TDS protocol, which is supported by all modern versions of SQL Server.
This driver is developed, tested, and supported by Microsoft.

[Microsoft ADO.NET for SQL Server](https://docs.microsoft.com/en-us/sql/connect/ado-net/microsoft-ado-net-for-sql-server) | [Download .Net Driver](http://www.microsoft.com/net/download/)


### JDBC
The JDBC SQL driver is a Java implementation of the TDS protocol, which is supported by all modern versions of SQL Server. This driver is developed, tested, and supported by Microsoft.

[Microsoft JDBC Driver for SQL Server](https://docs.microsoft.com/en-us/sql/connect/jdbc/microsoft-jdbc-driver-for-sql-server) | [Download JDBC Driver](https://docs.microsoft.com/en-us/sql/connect/jdbc/download-microsoft-jdbc-driver-for-sql-server?view=sql-server-2017)


### ODBC
The ODBC SQL driver is a C++ implementation of the TDS protocol, which is supported by all modern versions of SQL Server. This driver is developed, tested, and supported by Microsoft.

[Microsoft ODBC Driver for SQL Server](https://docs.microsoft.com/en-us/sql/connect/odbc/microsoft-odbc-driver-for-sql-server) | [Download ODBC Driver](https://docs.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server)


### PHP
The PHP SQL driver relies on the Microsoft SQL Server ODBC Driver to handle the low-level communication with SQL Server. This driver is developed, tested, and supported by Microsoft.

[Microsoft PHP Driver for SQL Driver](https://docs.microsoft.com/en-us/sql/connect/php/microsoft-php-driver-for-sql-server) | [Download PHP Driver](https://www.microsoft.com/en-us/download/details.aspx?id=20098) | [Github](https://github.com/Microsoft/msphpsql)


### Node.js
The tedious module is a javascript implementation of the TDS protocol, which is supported by all modern versions of SQL Server. The driver is an open source project, available on Github.

[Node.js Driver for SQL Server](https://docs.microsoft.com/en-us/sql/connect/node-js/node-js-driver-for-sql-server) | [Install Node.js Driver](https://docs.microsoft.com/en-us/sql/connect/node-js/step-1-configure-development-environment-for-node-js-development)


### Python
The pymssql module is a Python implementation of the TDS protocol, which is supported by all modern versions of SQL Server.

[Python Driver for SQL Server](https://docs.microsoft.com/en-us/sql/connect/python/python-driver-for-sql-server)

There are several python SQL Drivers available. Choose which one you want to use, and configure your development environment:
1. [Python SQL Driver - pyodbc](https://docs.microsoft.com/en-us/sql/connect/python/pyodbc/python-sql-driver-pyodbc)
2. [Python SQL Driver - pymssql](https://docs.microsoft.com/en-us/sql/connect/python/pymssql/python-sql-driver-pymssql)


### Ruby
The TinyTDS gem is a Ruby implementation of the TDS protocol, which is supported by all modern versions of SQL Server.

[Ruby Driver for SQL Server](https://docs.microsoft.com/en-us/sql/connect/ruby/ruby-driver-for-sql-server) | [Install Ruby Driver](https://docs.microsoft.com/en-us/sql/connect/ruby/ruby-driver-for-sql-server)


### Rails
The SQL Server adapter for ActiveRecord v5.1 using SQL Server 2012 or higher.

[SQL Server Adapter For Rails](https://github.com/rails-sqlserver/activerecord-sqlserver-adapter)


## Legacy SQL Drivers
The following SQL Drivers were developed and tested by Microsoft, but are not recommended to be used for new development.
Each driver has a support statement that can be found by following the links.


## OLEDB
The OLE DB provider will not be included after SQL Server 2012.

[Microsoft OLE DB](https://docs.microsoft.com/en-us/previous-versions/windows/desktop/ms722784(v=vs.85))


### ADO
The ADO SQL driver has a direct dependency on the OLE DB provider. As such, it will not be supported after SQL Server 2012.

[ActiveX Data Objects (ADO)](https://docs.microsoft.com/en-us/sql/ado/guide/data/activex-data-objects-ado)


## Another alternatives
 - [Devart ODBC Drivers](https://www.devart.com/odbc/)
 - [SNAC - SQL Server Native Client](https://docs.microsoft.com/en-us/sql/relational-databases/native-client/sql-server-native-client)
 - [RODBC: ODBC Database Access CRAN](https://mran.microsoft.com/package/RODBC/)
 - [RODBC: ODBC Database Access MRAN](https://mran.microsoft.com/package/RODBC/)
 - [go-mssqldb - Microsoft SQL server driver written in go language](https://github.com/denisenkom/go-mssqldb)
 - [Node TDS module for connecting to SQL Server databases](https://github.com/tediousjs/tedious/)
 - [SQLProvider - a general .NET/Mono SQL database type provider](https://github.com/fsprojects/SQLProvider) (Other database support: SQL Server, SQLite, PostgreSQL, Oracle, MySQL (& MariaDB), MsAccess, Firebird)
 - [RSQLServer - an R package that provides a SQL Server R Database Interface (DBI), based on the cross-platform jTDS JDBC driver](https://github.com/imanuelcostigan/RSQLServer)
 - [jTDS JDBC driver](http://jtds.sourceforge.net/index.html)
