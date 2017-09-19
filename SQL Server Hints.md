# Microsoft Transact-SQL Hints

 - [Microsoft Transact-SQL Hints](https://docs.microsoft.com/en-us/sql/t-sql/queries/hints-transact-sql)
   - [Hints (Transact-SQL) - Join](https://docs.microsoft.com/en-us/sql/t-sql/queries/hints-transact-sql-join)
   - [Hints (Transact-SQL) - Table](https://docs.microsoft.com/en-us/sql/t-sql/queries/hints-transact-sql-table)
   - [Hints (Transact-SQL) - Query](https://docs.microsoft.com/en-us/sql/t-sql/queries/hints-transact-sql-query)

**Hint names are case-insensitive.**

**Some USE HINT hints may conflict with trace flags enabled at the global or session level, or database scoped configuration settings.
In this case, the query level hint (USE HINT) always takes precedence.
If a USE HINT conflicts with another query hint or a trace flag enabled at the query level (such as by QUERYTRACEON), SQL Server will generate an error when trying to execute the query.**

**Separating hints by spaces rather than commas is a deprecated feature: This feature will be removed in a future version of Microsoft SQL Server.
Do not use this feature in new development work, and modify applications that currently use this feature as soon as possible.**