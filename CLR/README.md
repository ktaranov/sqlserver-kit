# Microsoft SQL Server CLR

Useful links:
 - [Introduction to SQL Server CLR Integration](https://msdn.microsoft.com/en-us/library/ms254498(v=vs.110).aspx)
 - [CLR User-Defined Functions](https://msdn.microsoft.com/library/ms131077.aspx)
 - [CLR User-Defined Types](https://msdn.microsoft.com/en-us/library/ms131120(SQL.100).aspx)
 - [CLR Stored Procedures](https://msdn.microsoft.com/en-us/library/ms131094(SQL.100).aspx)
 - [CLR Triggers](https://msdn.microsoft.com/en-us/library/ms131093(SQL.100).aspx)
 - [SQL# CLR functions](https://SQLsharp.com/) (by Sql Quantum Lift)

The common language runtime (CLR) is the heart of the Microsoft .NET Framework and provides the execution environment for all .NET Framework code. Code that runs within the CLR is referred to as managed code. The CLR provides various functions and services required for program execution, including just-in-time (JIT) compilation, allocating and managing memory, enforcing type safety, exception handling, thread management, and security.

With the CLR hosted in Microsoft SQL Server (called CLR integration), you can author stored procedures, triggers, user-defined functions, user-defined types, and user-defined aggregates in managed code. Because managed code compiles to native code prior to execution, you can achieve significant performance increases in some scenarios.

Enabling CLR Integration:

```tsql
EXEC sp_configure 'clr enabled', 1;
RECONFIGURE;
GO
```
