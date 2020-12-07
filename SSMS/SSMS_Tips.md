# SQL Server Management Studio Tips
Most tips works for SSMS higher 2008 but some of them only works for SSMS 2016 and above

## Road map
 - [ ] https://blogs.technet.microsoft.com/dataplatforminsider/2018/02/20/whats-new-in-ssms-17-5-data-discovery-and-classification/
 - [ ] https://bertwagner.com/2018/02/27/splitting-it-up-easy-side-by-side-queries-in-ssms/
 - [ ] https://sqlrus.com/2018/03/ssms-output-window/
 - [ ] https://www.sqlshack.com/whats-new-in-ssms-17-5-data-discovery-and-classification-and-more/
 - [ ] Add gifs or images for all tips
 - [ ] Add some tips from excellent ebook http://insiders.sqldownunder.com/ssms-tips-and-tricks/
 - [ ] Add Memory Optimiser Advisor tip https://www.red-gate.com/simple-talk/sql/t-sql-programming/converting-database-memory-oltp/
 - [ ] Add Removing Connections from the SSMS connection dialog https://blog.waynesheffield.com/wayne/archive/2018/05/removing-servers-ssms-connection-dialog/
 - [ ] Add Save the Connection String Parameters http://www.sqlservercentral.com/blogs/sql-geek/2018/07/26/save-the-connection-string-parameters-in-ssms-alwayson/
 - [ ] Analyze Actual Execution Plan https://www.scarydba.com/2018/08/06/analyze-actual-execution-plan/
 - [ ] Compare Actual Execution Plans
 - [ ] [Database Upgrade using the Query Tuning Assistant wizard in SSMS 18](https://www.sqlshack.com/database-upgrade-using-the-query-tuning-assistant-wizard-in-ssms-18/)
 - [ ] [Export Data From SSMS Query to Excel](https://blog.sqlauthority.com/2019/01/16/sql-server-export-data-from-ssms-query-to-excel/)
 - [ ] [Starting SSMS with a specific connection and script file](http://dbamastery.com/tips/ssms-cmdline-utility/)

**Table of Content**:
1. [Import and Export Settings](#1)
2. [SSMS Shortcuts](#2)
3. [Keyboard Shortcuts for Favorite Stored Procedures and Scripts](#3)
4. [SSMS Scripting Option](#4)
5. [Selecting a block of text using the ALT Key](#5)
6. [Script Table and Column Names by Dragging from Object Explorer](#6)
7. [Disable Copy of Empty Text](#7)
8. [Client Statistics](#8)
9. [Configure Object Explorer to Script Compression and Partition Schemes for Indexes](#9)
10. [Using GO X to Execute a Batch or Statement Multiple Times](#10)
11. [SSMS Template Replacement](#11)
12. [Color coding of connections](#12)
13. [SQLCMD mode](#13)
14. [Script multiple objects using the Object Explorer Details Windows](#14)
15. [Registered Servers / Central Management Server](#15)
16. [Splitting the Query Window and Annotations and Map Mode for Vertical Scroll Bar](#16)
17. [Moving columns in the results pane](#17)
18. [Generating Charts and Drawings in SQL Server Management Studio](#18)
19. [Additional Connection Parameters](#19)
20. [Working with tabs headers](#20)
21. [Hiding tables in SSMS Object Explorer](#21)
22. [UnDock Tabs and Windows for Multi Monitor Support](#22)
23. [RegEx-Based Finding and Replacing of Text in SSMS](#23)
24. [Changing what SSMS opens on startup](#24)
25. [Modifying New Query Template](#25)
26. [Query Execution Options](#26)
27. [SQL Server Diagnostics Extension](#27)
28. [Connect to SQL Servers in another domain using Windows Authentication](#28)
29. [SSMS Default Reports](#29)
30. [Live Query Statistics](#30)
31. [Searching in Showplan](#31)
32. [Object Explore Details](#32)
33. [Working with Azure SQL](#33)
34. [Using Extended Events and Profiler in SSMS](#34)
35. [Vulnerability Assessment in SSMS](#35)
36. [Import Flat File to SQL Wizard](#36)
37. [AutoRecover in SSMS](#37)
38. [View and query Power BI .pbix files in SSMS](#38)
39. [Using SSMS to analyze Power BI with XMLA](#39)
40. [Reference](#reference)


**Great thanks to**:
- Kendra Little ([b](http://www.littlekendra.com/) | [t](https://twitter.com/Kendra_Little))
- Slava Murygin ([b](http://slavasql.blogspot.ru/))
- Mike Milligan ([b](http://www.bidn.com/Blogs/userid/43/author/mike-milligan))
- Kenneth Fisher ([b](https://twitter.com/sqlstudent144) | [t](https://twitter.com/sqlstudent144))
- William Durkin ([b](http://www.williamdurkin.com/) | [t](https://twitter.com/sql_williamd))
- John Morehouse ([b](http://sqlrus.com/) | [t](http://twitter.com/sqlrus))
- Phil Factor ([b](https://www.red-gate.com/simple-talk/author/phil-factor/) | [t](https://twitter.com/phil_factor))
- Klaus Aschenbrenner ([b](https://www.sqlpassion.at/) | [t](https://twitter.com/Aschenbrenner))
- Latish Sehgal ([b](http://www.dotnetsurfers.com/))
- Arvind Shyamsundar ([b](https://blogs.msdn.microsoft.com/arvindsh/))
- [SQLMatters](http://www.sqlmatters.com/)
- [MSSQLTips](https://www.mssqltips.com/)
- Anthony Zanevsky, Andrew Zanevsky and Katrin Zanevsky
- Andy Mallon ([b](http://www.am2.co/) | [t](https://twitter.com/AMtwo))
- Aaron Bertrand ([b](http://sqlperformance.com/author/abertrand) | [t](https://twitter.com/AaronBertrand))
- Daniel Calbimonte ([b](https://www.sqlshack.com/author/daniel-calbimonte/) | [t](https://twitter.com/dcalbimonte))
- Ahmad Yaseen ([b](https://www.sqlshack.com/author/ahmad-yaseen/) | [t](https://twitter.com/AhmadZYaseen))
- Solomon Rutzky ([b](https://sqlquantumleap.com/) | [t](https://twitter.com/SqlQuantumLeap))
- Bert Wagner ([b](https://blogs.sentryone.com) | [t](https://twitter.com/bertwagner))
- Thomas LaRock ([b](https://thomaslarock.com/) | [t](https://twitter.com/SQLRockstar))
- Jen Mccown ([b](http://www.midnightdba.com/Jen/author/jen/))
- Louis Davidson ([b](https://www.red-gate.com/simple-talk/author/louis-davidson/) | [t](https://twitter.com/drsql))
- Solomon Rutzky ([b](https://sqlquantumleap.com) | [t](https://twitter.com/srutzky))
- Michelle Haarhues ([b](https://witsociety.wordpress.com/) | [t](https://twitter.com/mhaarhues))
- Christian Wade ([b](https://witsociety.wordpress.com/) | [t](https://twitter.com/_christianWade))
- Kellyn Pot’Vin-Gorman ([b](https://dbakevlar.com/) | [t](https://twitter.com/DBAKevlar))
- Kevin Feasel ([b](https://36chambers.wordpress.com) | [t](https://twitter.com/feaselkl))
- Brent Ozar ([b](https://www.brentozar.com/) | [@BrentO](https://twitter.com/BrentO))


<a id="1"></a>
## 1. Import and Export Settings
`Tools > Options > Environment > Import and Export Settings`

Default settings (if you need to compare with yours) you can find here: [SSMS settings files](https://github.com/ktaranov/sqlserver-kit/tree/master/SSMS/SSMS_vssettings)

You can configure so many settings in SSMS and then export it and use on all your computers.
Below link provide detailed instruction and awesome Dark theme configuration: [Making SSMS Pretty: My Dark Theme](https://blogs.sentryone.com/aaronbertrand/making-ssms-pretty-my-dark-theme/)

Also you can create shared team settings file and use it from network location.
Detailed information you can find in this article [Symbolic Links for Sharing Template Files or "How I Broke Management Studio with Symbolic Links"](http://sqlmag.com/sql-server/symbolic-links-sharing-template-files-or-how-i-broke-management-studio-symbolic-links)

![Import and Export Settings](/SSMS/SSMS_Tips/import_and_export_settings.png)


<a id="2"></a>
## 2. SSMS Shortcuts
All shortcuts you can find [here](https://github.com/ktaranov/sqlserver-kit/blob/master/SSMS/SSMS_Shortcuts.md).
Known problem for SSMS 2012 and 2014: [CTRL+R does not hide the Query Result window in SSMS]

Create custom shortcut as simple as possible:
1. `Tools > Options > Environment > Keyboard`
2. Use the search bar `Show Commands Containing` to find and select the command.
3. In `Press Shortcut Keys`, press the shortcut combination you want to use.
4. Click `Assign`. If you don’t click `Assign`, and just click `OK`, your shortcut won’t be assigned.
5. Click `OK`. (Note that some shortcut changes take effect in query windows you open after the change.)
More details here: [MANAGEMENT STUDIO SHORTCUT – CHANGE CONNECTION](http://www.midnightdba.com/Jen/2018/03/management-studio-shortcut-change-connection/)

Most useful are:

| Shortcut                       | Description                            |
|--------------------------------|----------------------------------------|
| <kbd>Ctrl + U</kbd>            | Change Selected Database               |
| <kbd>Ctrl + R</kbd>            | Toggle Results Pane                    |
| <kbd>Ctrl + Space</kbd>        | Activate Autocomplete                  |
| <kbd>Ctrl + Shift + V</kbd>    | [Cycle through clipboard ring]         |
| <kbd>Ctrl + ]</kbd>            | Navigate to matching parenthesis       |
| <kbd>Ctrl + –</kbd>            | Navigate to last cursor location       |
| <kbd>Ctrl + Shift + –</kbd>    | Navigate forward to cursor location    |
| <kbd>Ctrl + K, Ctrl + C</kbd>  | Comments selected text                 |
| <kbd>Ctrl + K, Ctrl + U</kbd>  | Uncomments selected text               |
| <kbd>Ctrl + K, Ctrl + K</kbd>  | Toggle Bookmark                        |
| <kbd>Ctrl + K, Ctrl + N</kbd>  | Go to Next Bookmark                    |
| <kbd>Ctrl + L</kbd>            | Display Estimated Query Execution plan |
| <kbd>Shift + Alt + Enter</kbd> | View Code Editor in Full Screen        |
| <kbd>Ctrl + I</kbd>            | Quick Search                           |
| <kbd>Ctrl + F4</kbd>           | Close the current MDI child window     |
| <kbd>Ctrl + F5</kbd>           | Parse query  to check for errors       |
| <kbd>Shift + F10</kbd>         | Simulate right mouse button            |
| <kbd>Ctrl + Alt + T</kbd>      | Display Template Explorer              |
| <kbd>Ctrl + Shift + M</kbd>    | Specify values for template parameters |
| <kbd>Ctrl + Shift + R</kbd>    | Refresh local cache                    |
| <kbd>Ctrl + Alt + S</kbd>      | Include Client Statistics              |


<a id="3"></a>
## 3. Keyboard Shortcuts for Favorite Stored Procedures and Scripts
A query shortcut allows you to execute code simply by hitting <kbd>Ctrl</kbd> and a number key. Cool. But first, there are a few things to know about query shortcuts:

1. The window in SSMS where you configure the query shortcuts has the text field for the shortcut labeled as **Stored Procedure**, which is misleading because you can specify a query. You can even specify multiple queries.
2. Whatever you specify needs to be a single line: no newlines / CRLFs. Any text past the first return will be truncated.
3. When using the keyboard query shortcuts, if nothing is highlighted then only the code in the shortcut is executed. But, if any T-SQL is highlighted when you execute the shortcut, then the highlighted code is executed after the code stored in the shortcut finishes. Adding a `RETURN;` at the end of the shortcut simply stops the processing after the code stored in the shortcut finishes. BUT, if anything is highlighted when you execute a query shortcut, it is still parsed, even if not executed. Hence, you can still get parse errors even with the `RETURN;` added at the end.

`Tools > Options > Environment > Keyboard > Query Shortcuts`

![Keyboard Shortcuts for Favorite Stored Procedures](/SSMS/SSMS_Tips/keyboard_shortcuts_for_stored_procedures.png)

3 Shortcuts can not be changed: <kbd>Alt + F1</kbd> - [sp_help], <kbd>Ctrl + 1</kbd> - [sp_who] and <kbd>Ctrl + 2</kbd> - [sp_lock].
For another 9 shortcuts my recommendation awesome open source Brent Ozar teams procedures and with some limitations in License usage Adam Machanic [sp_WhoIsActive]:

| Query Shortcut          | Stored Procedure     |
|-------------------------|----------------------|
| <kbd>Alt + F1</kbd>     | [sp_help]            |
| <kbd>Ctrl + F1</kbd>    | [`sp_WhoIsActive`]   |
| <kbd>Ctrl + 1</kbd>     | [sp_who]             |
| <kbd>Ctrl + 2</kbd>     | [sp_lock]            |
| <kbd>Ctrl + 3</kbd>     | [sp_Blitz]           |
| <kbd>Ctrl + 4</kbd>     | [sp_BlitzCache]      |
| <kbd>Ctrl + 5</kbd>     | [sp_BlitzWho]        |
| <kbd>Ctrl + 6</kbd>     | [sp_BlitzQueryStore] |
| <kbd>Ctrl + 7</kbd>     | [sp_BlitzFirst]      |
| <kbd>Ctrl + 8</kbd>     | [usp_BulkUpload]     |
| <kbd>Ctrl + 9</kbd>     | [sp_BlitzTrace]      |
| <kbd>Ctrl + 0</kbd>     | [sp_foreachdb]       |

Also recommended:
 - [sp_DatabaseRestore]
 - [usp_BulkUpload]

[sp_help]:https://docs.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-help-transact-sql
[sp_who]:https://docs.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-who-transact-sql
[sp_lock]:https://docs.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-lock-transact-sql
[`sp_WhoIsActive`]:http://whoisactive.com
[sp_Blitz]:https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/blob/dev/sp_Blitz.sql
[sp_BlitzBackups]:https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/blob/dev/sp_BlitzBackups.sql
[sp_BlitzCache]:https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/blob/dev/sp_BlitzCache.sql
[sp_BlitzFirst]:https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/blob/dev/sp_BlitzFirst.sql
[sp_BlitzIndex]:https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/blob/dev/sp_BlitzIndex.sql
[sp_BlitzQueryStore]:https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/blob/dev/sp_BlitzQueryStore.sql
[sp_BlitzRS]:https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/blob/dev/sp_BlitzRS.sql
[sp_BlitzTrace]:https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/blob/dev/sp_BlitzTrace.sql
[sp_BlitzWho]:https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/blob/dev/sp_BlitzWho.sql
[sp_DatabaseRestore]:https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/blob/dev/sp_DatabaseRestore.sql
[sp_foreachdb]:https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/blob/dev/sp_foreachdb.sql
[usp_BulkUpload]:https://github.com/ktaranov/sqlserver-kit/blob/master/Stored_Procedure/usp_BulkUpload.sql

### Some useful shortcuts for `sp_WhoIsActive` from Kevin Feasel
More details [here](https://36chambers.wordpress.com/2019/04/02/whoisactive-in-ssms/).

What’s Going On shortcut?
```tsql
EXEC sp_whoisactive
    @get_full_inner_text = 1
  , @get_outer_command = 1
  , @find_block_leaders = 1
  , @get_task_info = 2
  , @get_transaction_info = 1
  , @get_plans = 0
  , @output_column_list = '[session_id][login_name][dd%][CPU][reads][writes][wait_info][blocking_session_id][blocked_session_count][sql_text][sql_command][status][tempdb_%][%]'
  , @sort_order = '[session_id]';
```

And here it is in a little bit nicer of a format so we can cover it:
```tsql
EXEC sp_whoisactive
    @get_full_inner_text = 1
   , @get_outer_command = 1
   , @find_block_leaders = 1
   , @get_task_info = 2
   , @get_transaction_info = 1
   , @get_plans = 0
   , @output_column_list = '[session_id][login_name][dd%][CPU][reads][writes][wait_info][blocking_session_id][blocked_session_count][sql_text][sql_command][status][tempdb_%][%]'
   , @sort_order = '[session_id]';
```

When you need to get execution plans, that’s when I break out Ctrl+4. Here is the one-liner:
```tsql
EXEC sp_whoisactive
    @get_full_inner_text = 1
   , @get_outer_command = 1
   , @find_block_leaders = 1
   , @get_task_info = 2
   , @get_transaction_info = 1
   , @get_plans = 1
   , @output_column_list = '[session_id][login_name][dd%][CPU][reads][writes][wait_info][blocking_session_id][blocked_session_count][sql_text][sql_command][status][tempdb_%][%]'
   , @sort_order = '[session_id]';
```

<a id="4"></a>
## 4. SSMS Scripting Option

### Script any object with data
`Right click on database name > Tasks > Generate Scripts …`

![Script any object with data](/SSMS/SSMS_Tips/ssms_script_objects.gif)


### The Default Scripting Option
In the previous SQL Server Management Studio versions, the generated script will target the latest released SQL Server version.
Starting SSMS 17.2, the `Match Script Settings to Source` has been added, with the default `True` value means that the generated script will target the source SQL Server instance’s version, edition, and engine type, where the `False` value will force the scripting to behave as the previous SSMS versions.

`Tools > Options > SQL Server Object Explore > Scripting > Version Options > Match Script Settings to Source`

More details here: [What’s new in SQL Server Management Studio 17.2; Authentication methods, scripting options and more]

![Script for SQL Server version](/SSMS/SSMS_Tips/ssms_script_objects_server_version.png)


<a id="5"></a>
## 5. Selecting a block of text using the ALT Key
By holding down the ALT key as you select a block of text you can control the width of the selection region as well as the number of rows.
Also you can activate multi line mode with `Shift + Alt` keys and using keyboard arrows to format multi line code.

More info and video about this awesome feature in this article: [My Favorite SSMS Shortcut (After Copy/Paste)](https://bertwagner.com/2017/11/28/multiline-edit-block-selection-alt-highlight-trick/) (by Bert Wagner)

![SSMS Selecting a block of text using the ALT Key](/SSMS/SSMS_Tips/05_ALT+Arrow.gif)

![SSMS Paste values into a template of commands](/SSMS/SSMS_Tips/05_ALT+PASTE.gif)


<a id="6"></a>
## 6. Script Table and Column Names by Dragging from Object Explorer
Save keystrokes by dragging
Drag the `Columns` folder for a table in to auto-type all column names in the table in a single line.
 - Warning: this doesn’t include square [brackets] around the column names for SSMS below 17 version, so if your columns contain spaces or special characters at the beginning, this shortcut isn’t for you
 - Dragging the table name over will auto-type the schema and table name, with brackets.


<a id="7"></a>
## 7. Disable Copy of Empty Text

 - Select a block of text to copy;
 - Move the cursor the place where you want to paste the code;
 - Accidentally press `Ctrl+C` again instead of `Ctrl+V`;
 - Block of copied text is replaced by an empty block;

This behavior can be disabled in SSMS: go to `Tools > Options > Text Editor > All Languages > General > 'Apply Cut or Copy Commands to blank lines when there is no selection'` and uncheck the checkbox.

![Disable Copy of Empty Text](/SSMS/SSMS_Tips/disable_copy_of_empty_text.png)


<a id="8"></a>
## 8. Client Statistics
When you enable that option for your session (`Ctrl + Alt + S`), SQL Server Management Studio will give you more information about the client side processing of your query.

The Network Statistics shows you the following information:
 - Number of Server Roundtrips
 - TDS Packets sent from Client
 - TDS Packets received from Server
 - Bytes sent from Client
 - Bytes received from Server

The Time Statistics additionally shows you the following information:
 - Client Processing Time
 - Total Execution Time
 - Wait Time on Server Replies


<a id="9"></a>
## 9. Configure Object Explorer to Script Compression and Partition Schemes for Indexes
Is this index compressed or partitioned?

By default, you wouldn’t know just by scripting out the index from Object Explorer. If you script out indexes this way to check them into source code, or to tweak the definition slightly, this can lead you to make mistakes.

You can make sure you’re aware when indexes have compression or are partitioned by changing your scripting settings:
- Click `Tools – > Options -> SQL Server Object Explorer -> Scripting`
- Scroll down in the right pane of options and set both of these to `True`
  - *Script Data Compression Options*
  - *Script Partition Schemes*
- Click OK


<a id="10"></a>
## 10. Using GO X to Execute a Batch or Statement Multiple Times
The `GO` command marks the end of a batch of statements that should be sent to SQL Server for processing, and then compiled into a single execution plan. 
By specifying a number after the `GO` the batch can be run specified number of times. This can be useful if, for instance, you want to create test data by running an insert statement a number of times. Note that this is not a Transact SQL statement and will only work in Management Studio (and also SQLCMD or OSQL). For instance the following SQL can be run in SSMS :

```sql
IF OBJECT_ID('TestData','U') IS NOT NULL DROP TABLE TestData;

CREATE TABLE TestData(ID INT IDENTITY (1,1), CreatedDate DATETIME2);
GO

INSERT INTO TestData(CreatedDate) SELECT GETDATE();
GO 10

SELECT ID, CreatedDate FROM TestData;

IF OBJECT_ID('TestData','U') IS NOT NULL DROP TABLE TestData;

```

This will run the insert statement 10 times and therefore insert 10 rows into the `TestData` table.
In this case this is a simpler alternative than creating a cursor or while loop.


<a id="11"></a>
## 11. SSMS Template Replacement
One under-used feature of Management Studio is the template replacement feature. SSMS comes with a library of templates, but you can also make your own templates for reusable scripts.

In your saved .sql script, just use the magic incantation to denote the parameters for replacement. The format is simple: `<label, datatype, default value>`

Then, when you open the `.sql` script, you hit `CTRL + Shift + M`, and SSMS will give you a pop-up to enter your replacement values.


<a id="12"></a>
## 12. Color coding of connections
SQL Server Management Studio has the capability of coloring the bar at the bottom of each query window, with the color dependent on which server is connected.
This can be useful in order to provide a visual check of the server that a query is to be run against, for instance to color code production instances as red, development as green and amber as test.
This can also be used in conjunction with Registered Servers and CMS (Central Management Server).
To add a color bar when connecting to the server click on the Options button in the Connect to Database Engine window and then select the Connection Properties window.
Select the check box towards the bottom of the window and use the ‘Select…’ button to choose a color.


<a id="13"></a>
## 13. SQLCMD mode
Switching on SQLCMD mode enables a number of useful extra scripting style commands in SSMS.
In particular you can use it to change to the connection credentials within the query window, so that you can run a query against multiple servers from the same query window.
There are more details of how to do this here: [Changing the SQL Server connection within an SSMS Query Windows using SQLCMD Mode](http://www.sqlmatters.com/Articles/Changing%20the%20SQL%20Server%20connection%20within%20an%20SSMS%20Query%20Windows%20using%20SQLCMD%20Mode.aspx)

Also some great tips from Louis Davidson article: [Using SQLCMD, End Execution of SQL Commands in a File](https://www.red-gate.com/simple-talk/blogs/using-sqlcmd-end-execution-sql-commands-file/)
1. Making Sure You Don’t Accidentally Execute The Entire File By Mistake using `:EXIT` command in your scripts, details see here [sqlcmd Commands].
2. Quitting the Statements of a File Based on a Condition using `:On Error[ exit | ignore]` command, details see here [sqlcmd Commands].

[sqlcmd Commands]:https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility?view=sql-server-2017#sqlcmd-commands


<a id="14"></a>
## 14. Script multiple objects using the Object Explorer Details Windows
Individual database objects, such as a table or stored procedure, can be scripted within SSMS by right clicking on the object within Object Explorer and selecting the appropriate item in the drop down menu.
However if you have a lot of objects to script that can quickly become time consuming.
Fortunately it’s possible to select multiple objects and script them up all together in a single query window.
To do this just open the Object Explorer Details window from the View menu (or press the F7 key).
If you want to script up multiple (or all) tables, select the Tables item under the relevant database in Object Explorer.
A list of all tables appears in the Object Explorer Details window.
Select the tables you want to script (using the Control key if necessary) and then right click and select which script option you want – e.g. to create a table create script for all tables.


<a id="15"></a>
## 15. Registered Servers / Central Management Server
If you have a lot of servers then re-entering the details in Object Explorer every time you start SSMS can be frustrating and time consuming.
Fortunately there are two facilities within SSMS that enable these details to be entered just once and "remembered" each time you open up SSMS.
These two facilities are **Registered Servers** and **Central Management Servers**.
These were introduced in different versions of SQL Server and work in different ways, each has its own advantages and disadvantages so you may want to use both.

To add a registered server open the Registered Servers window from the View menu (or click `CTRL + ALT + G`), the window should appear in the top left corner of SSMS.
Right click on the Local Server Groups folder and select ‘New Server Registration…’. Enter the server details and close the window.
This new server should then appear under Local Server Groups, you can then right click and open up the server in Object Explorer or open a new query window.
The server details are stored locally in an XML file and so will appear next time you open SSMS.
If you have a lot of servers then you can also create Server Groups to group together similar servers.
One advantage of creating groups (other than being able to logically group similar servers together) is that you can run a query against all servers in the group, by right clicking the group and selecting ‘New Group’.

Central Management Server are similar to Registered Servers but with some differences, the main one being that the server details are stored in a database (the Central Management Server) rather than a local file.
A significant limitation with CMS is that the CMS server itself can’t be included in the list of servers.


<a id="16"></a>
## 16. Splitting the Query Window and Annotations and Map Mode for Vertical Scroll Bar
The query window in SSMS can be split into two so that you can look at two parts of the same query simultaneously.
Both parts of the split window can be scrolled independently. This is especially useful if you have a large query and want to compare different areas of the same query.
To split the window simply drag the bar to the top right hand side of the window as shown below.

The splitter bar allows you to view one session with two panes. You can scroll in each pane independently. You can also edit in both the top and bottom pane.

![Splitting the Query Window](/SSMS/SSMS_Tips/splitting_the_query_window.gif)

Also you can view some very useful features like annotations and Map mode, detailed instruction:
1. [SSMS Tip #1: Annotations and Map Mode for Vertical Scroll Bar]
2. [SQL Server Management Studio Scroll Bar Enhancements](https://witsociety.wordpress.com/2018/12/13/sql-server-management-studio-scroll-bar-enhancements/)

Annotations show the relative position of certain aspects of the script, such as errors, changes, etc.
There are four types of annotations, the first three of which are shown in their own columns on the left side of the scroll bar:

 - **"Changes"** are show in yellow (unsaved) and green (saved). These occupy the left column.
 - **"Marks"** are shown in maroon (Breakpoints) and black (Bookmarks). These occupy the left column.
 - **"Errors"** are shown in red. These occupy the right column.
 - **"Caret Position"** is a thin, blue line going horizontally across the scroll bar. This represents the line of the script that the cursor is on.


<a id="17"></a>
## 17. Moving columns in the results pane
It may not be immediately obvious but you can switch columns around in the results pane when using the grid view, by dragging the column headers and dropping them next to another column header.
This can be useful if you want to rearrange how the results are displayed without amending the query, especially if you have a lot of columns in your result set.
This works only for one column.


<a id="18"></a>
## 18. Generating Charts and Drawings in SQL Server Management Studio
You don't have to settle for T-SQL's monochrome text output. These stored procedures let you quickly and easily turn your SELECT queries' output into colorized charts and even computer-generated art.
To turn your own data into a line, column, area, or bar chart using the Chart stored procedure, you need to design a SELECT query that serves as the first parameter in the stored procedure call.

Detailed article and code here: [Generating Charts and Drawings in SQL Server Management Studio]

Also you can generate amazing chart using awesome R libraries, detailed article: [View R Plots from within SQL Server Management Studio]


<a id="19"></a>
## 19. Additional Connection Parameters
One such change SSMS got for free is the connection resiliency logic within the `SqlConnection.Open()` method.
To improve the default experience for clients which connect to Azure SQL Database, the above method will (in the case of initial connection errors / timeouts) now retry 1 time after sleeping for 10 seconds. These numbers are configurable by properties called ConnectRetryCount (default value 1) and ConnectRetryInterval (default value 10 seconds.)
The previous versions of the SqlConnection class would not automatically retry in cases of connection failure.

There is a simple workaround for this situation. It is to add the following parameter string into the `Additional Connection Parameters` tab within the SSMS connection window. The good news is that you only need to do this once, as the property is saved for future sessions for that SQL Server (until of course it is removed by you later.)
```
ConnectRetryCount=0
```

![Additional Connection Parameters](/SSMS/SSMS_Tips/additional_connection_parameters.png)


<a id="20"></a>
## 20. Working with tabs headers
You can view [SPID](https://docs.microsoft.com/en-us/sql/t-sql/functions/spid-transact-sql) in tabs header, quickly open script containing folder or copy script file path.

![Working with tabs headers](/SSMS/SSMS_Tips/working_with_tabs_headers.png)


<a id="21"></a>
## 21. Hiding tables in SSMS Object Explorer
1. You can actually hide an object from object explorer by assigning a specific extended property:
```
EXEC sp_addextendedproperty
@name = N'microsoft_database_tools_support',
@value = 'Hide',
@level0type = N'Schema', @level0name = 'Person',
@level1type = N'Table', @level1name = 'Address';
GO
```

You can then remove the property (and the object will show back up) like so:
```
EXEC sp_dropextendedproperty
@name = N'microsoft_database_tools_support',
@level0type = N'Schema', @level0name = 'Person',
@level1type = N'Table', @level1name = 'Address';
GO
```

2. DENY VIEW DEFINITION
```
DENY VIEW DEFINITION ON Schema.Table TO UserName;
```

Now UserName won’t be able to see Table in `Object Explorer`.
In Fact, they won’t be able to see the table in `sys.tables` or `INFORMATION_SCHEMA.TABLES`

`VIEW DEFINITION` is the ability to see the definition of the object.
In the case of SPs the code, same with Views and in the case of Tables it’s the columns definitions etc.


<a id="22"></a>
## 22. UnDock Tabs and Windows for Multi Monitor Support
From SSMS 2012 and onwards, you can easily dock/undock the query tabs as well as different object windows inside SSMS to make better use of the screen real estate and multiple monitors you have.

![UnDock Tabs and Windows for Multi Monitor Support](/SSMS/SSMS_Tips/undock_tabs_and_windows_for_multi_monitor_support.gif)


<a id="23"></a>
## 23. RegEx-Based Finding and Replacing of Text in SSMS
So often, one sees developers doing repetitive coding in SSMS or Visual Studio that would be much quicker and easier by using the built-in Regular-Expression-based Find/Replace functionality.
It is understandable, since the syntax is odd and some features are missing, but it is still well-worth knowing about.

More details and examples you can find here [RegEx-Based Finding and Replacing of Text in SSMS].

My favorite regex: replace `\t` on `\n, `. It useful in many cases when you have column names copied from, for example, Excel and need quickly get sql query.


<a id="24"></a>
## 24. Changing what SSMS opens on startup
The more interesting way to look at this shortcut is to check the various options available with SSMS command line parameters.
To check them, use the following command:
```
C:\> ssms /?
```

![SSMS command line parameters](/SSMS/SSMS_Tips/24_SSMS_command-line_parameters.png)

You can customize SSMS startup behavior in `Tools -> Options -> Environment -> Startup` and hide system objects in Object Explore:

![Changing what SSMS opens on startup](/SSMS/SSMS_Tips/24_changing_what_ssms_opens_on_startup.gif)

Also you can disable the splash screen - this cuts the time it takes SSMS to load for versions before SSMS 17.
Right click your shortcut to SSMS and select properties.
Enter the text `-nosplash` right after the ending quote in the path:

![SSMS link nosplash option](/SSMS/SSMS_Tips/24_changing_what_ssms_opens_on_startup_nosplash.png)

It is useful to create a solution of commonly used SQL scripts to always load at start-up.
1. Display the Solution Explorer by pressing `Ctrl+Alt+L` or clicking `View -> Solution Explorer`.
2. Then right click the `Solution "Solution1" (0 projects)` text and select `Add -> New Project`.
3. Use the default `SQL Server Scripts` template and give your solution a clever name.
4. Rename all of your SQL Code Snippets so the extension is .SQL. Drag them into the queries folder within the Solution Explorer.
5. Open Windows explorer and browse to the location of your solution. Copy file location address to your clipboard. 
Go back to your SSMS shortcut properties and add within double quotes the location and file name of your solution before the "-nosplash".

This is the complete text of shortcut properties:

```
"C:\Program Files (x86)\Microsoft SQL Server\140\Tools\Binn\ManagementStudio\Ssms.exe" "C:\Users\taranov\Documents\SQL Server Management Studio\Projects\MySQLServerScripts.ssmssln" -nosplash
```

![Create a solution of commonly used SQL scripts](/SSMS/SSMS_Tips/24_create_solution_commonly_used_sql_scripts.gif)


<a id="25"></a>
## 25. Modifying New Query Template
You can modified New Query template for any instance SQL Server:
```
C:\Program Files (x86)\Microsoft SQL Server\[140|130|120|110]\Tools\Binn\ ManagementStudio\SqlWorkbenchProjectItems\Sql\SQLFile.sql
```

For example, you can add begin transaction statement for preventing ups queries:
```sql
BEGIN TRANSACTION;
 
 
-- COMMIT   TRANSACTION;
-- ROLLBACK TRANSACTION;
```

Thanks for this tip Aaron Bertrand: [T-SQL Tuesday #92: Lessons Learned the Hard Way]


<a id="26"></a>
## 26. Query Execution Options
More detailed article here: [Knowing the Options]

The options represent the SET values of the current session.
`SET options` can affect how the query is execute thus having a different execution plan.
You can find these options in two places within SSMS under `Tools -> Options -> Query Execution -> SQL Server -> Advanced`:

![Query Execution Options Advanced](/SSMS/SSMS_Tips/25_query_execution_options.png)

As well as `Tools -> Options -> Query Execution -> SQL Server -> ANSI`:

![Query Execution Options ANSI](/SSMS/SSMS_Tips/25_query_execution_options_ansi.png)

Using the interface to check what is set can get tiresome. Instead, you can use the system function `@@OPTIONS`.
Each option shown above has a BIT value for all 15 options indicating whether or not it is enabled.

`@@OPTIONS` takes the binary representation and does a BITWISE operation on it to produce an integer value based on the sum of which BITS are enabled.

Default value for `SELECT @@OPTIONS` is **5496**.
Let’s assume for a moment that the only two options that are enabled on my machine are ANSI_PADDING and ANSI_WARNINGS.
The values for these two options are 8 and 16, respectively speaking. The sum of the two is 24.

Microsoft docs: https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-user-options-server-configuration-option

| Value | Configuration             | Description                                                                                                                                                                                             |
|------:|---------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1     | [DISABLE_DEF_CNST_CHK]    | **Deprecated** Controls interim or deferred constraint checking.                                                                                                                                        |
| 2     | [IMPLICIT_TRANSACTIONS]   | For dblib network library connections, controls whether a transaction is started implicitly when a statement is executed. The IMPLICIT_TRANSACTIONS setting has no effect on ODBC or OLEDB connections. |
| 4     | [CURSOR_CLOSE_ON_COMMIT]  | Controls behavior of cursors after a commit operation has been performed.                                                                                                                               |
| 8     | [ANSI_WARNINGS]           | Controls truncation and NULL in aggregate warnings.                                                                                                                                                     |
| 16    | [ANSI_PADDING]            | Controls padding of fixed-length variables.                                                                                                                                                             |
| 32    | [ANSI_NULLS]              | Controls NULL handling when using equality operators.                                                                                                                                                   |
| 64    | [ARITHABORT]              | Terminates a query when an overflow or divide-by-zero error occurs during query execution.                                                                                                              |
| 128   | [ARITHIGNORE]             | Returns NULL when an overflow or divide-by-zero error occurs during a query.                                                                                                                            |
| 256   | [QUOTED_IDENTIFIER]       | Differentiates between single and double quotation marks when evaluating an expression.                                                                                                                 |
| 512   | [NOCOUNT]                 | Turns off the message returned at the end of each statement that states how many rows were affected.                                                                                                    |
| 1024  | [ANSI_NULL_DFLT_ON]       | Alters the session's behavior to use ANSI compatibility for nullability. New columns defined without explicit nullability are defined to allow nulls.                                                   |
| 2048  | [ANSI_NULL_DFLT_OFF]      | Alters the session's behavior not to use ANSI compatibility for nullability. New columns defined without explicit nullability do not allow nulls.                                                       |
| 4096  | [CONCAT_NULL_YIELDS_NULL] | Returns NULL when concatenating a NULL value with a string.                                                                                                                                             |
| 8192  | [NUMERIC_ROUNDABORT]      | Generates an error when a loss of precision occurs in an expression.                                                                                                                                    |
| 16384 | [XACT_ABORT]              | Rolls back a transaction if a Transact-SQL statement raises a run-time error.                                                                                                                           |

[DISABLE_DEF_CNST_CHK]:https://technet.microsoft.com/en-us/library/ms175103
[IMPLICIT_TRANSACTIONS]:https://docs.microsoft.com/en-us/sql/t-sql/statements/set-implicit-transactions-transact-sql
[CURSOR_CLOSE_ON_COMMIT]:https://docs.microsoft.com/en-us/sql/t-sql/statements/set-cursor-close-on-commit-transact-sql
[ANSI_WARNINGS]:https://docs.microsoft.com/en-us/sql/t-sql/statements/set-ansi-warnings-transact-sql
[ANSI_PADDING]:https://docs.microsoft.com/en-us/sql/t-sql/statements/set-ansi-padding-transact-sql
[ANSI_NULLS]:https://docs.microsoft.com/en-us/sql/t-sql/statements/set-ansi-nulls-transact-sql
[ARITHABORT]:https://docs.microsoft.com/en-us/sql/t-sql/statements/set-arithabort-transact-sql
[ARITHIGNORE]:https://docs.microsoft.com/en-us/sql/t-sql/statements/set-arithignore-transact-sql
[QUOTED_IDENTIFIER]:https://docs.microsoft.com/en-us/sql/t-sql/statements/set-quoted-identifier-transact-sql
[NOCOUNT]:https://docs.microsoft.com/en-us/sql/t-sql/statements/set-nocount-transact-sql
[ANSI_NULL_DFLT_ON]:https://docs.microsoft.com/en-us/sql/t-sql/statements/set-ansi-null-dflt-on-transact-sql
[ANSI_NULL_DFLT_OFF]:https://docs.microsoft.com/en-us/sql/t-sql/statements/set-concat-null-yields-null-transact-sql
[CONCAT_NULL_YIELDS_NULL]:https://docs.microsoft.com/en-us/sql/t-sql/statements/set-concat-null-yields-null-transact-sql
[NUMERIC_ROUNDABORT]:https://docs.microsoft.com/en-us/sql/t-sql/statements/set-numeric-roundabort-transact-sql
[XACT_ABORT]:https://docs.microsoft.com/en-us/sql/t-sql/statements/set-xact-abort-transact-sql

```sql
/***************************************************************
  Author: John Morehouse
  Summary: This script display what SET options are enabled for the current session.
 
  You may alter this code for your own purposes. You may republish altered code as long as you give due credit.
 
  THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
***************************************************************/
SELECT 'DISABLE_DEF_CNST_CHK'    AS 'Option', CASE @@options & 1     WHEN 0 THEN 0 ELSE 1 END AS 'Enabled/Disabled' UNION ALL
SELECT 'IMPLICIT_TRANSACTIONS'   AS 'Option', CASE @@options & 2     WHEN 0 THEN 0 ELSE 1 END AS 'Enabled/Disabled' UNION ALL
SELECT 'CURSOR_CLOSE_ON_COMMIT'  AS 'Option', CASE @@options & 4     WHEN 0 THEN 0 ELSE 1 END AS 'Enabled/Disabled' UNION ALL
SELECT 'ANSI_WARNINGS'           AS 'Option', CASE @@options & 8     WHEN 0 THEN 0 ELSE 1 END AS 'Enabled/Disabled' UNION ALL
SELECT 'ANSI_PADDING'            AS 'Option', CASE @@options & 16    WHEN 0 THEN 0 ELSE 1 END AS 'Enabled/Disabled' UNION ALL
SELECT 'ANSI_NULLS'              AS 'Option', CASE @@options & 32    WHEN 0 THEN 0 ELSE 1 END AS 'Enabled/Disabled' UNION ALL
SELECT 'ARITHABORT'              AS 'Option', CASE @@options & 64    WHEN 0 THEN 0 ELSE 1 END AS 'Enabled/Disabled' UNION ALL
SELECT 'ARITHIGNORE'             AS 'Option', CASE @@options & 128   WHEN 0 THEN 0 ELSE 1 END AS 'Enabled/Disabled' UNION ALL
SELECT 'QUOTED_IDENTIFIER'       AS 'Option', CASE @@options & 256   WHEN 0 THEN 0 ELSE 1 END AS 'Enabled/Disabled' UNION ALL
SELECT 'NOCOUNT'                 AS 'Option', CASE @@options & 512   WHEN 0 THEN 0 ELSE 1 END AS 'Enabled/Disabled' UNION ALL
SELECT 'ANSI_NULL_DFLT_ON'       AS 'Option', CASE @@options & 1024  WHEN 0 THEN 0 ELSE 1 END AS 'Enabled/Disabled' UNION ALL
SELECT 'ANSI_NULL_DFLT_OFF'      AS 'Option', CASE @@options & 2048  WHEN 0 THEN 0 ELSE 1 END AS 'Enabled/Disabled' UNION ALL
SELECT 'CONCAT_NULL_YIELDS_NULL' AS 'Option', CASE @@options & 4096  WHEN 0 THEN 0 ELSE 1 END AS 'Enabled/Disabled' UNION ALL
SELECT 'NUMERIC_ROUNDABORT'      AS 'Option', CASE @@options & 8192  WHEN 0 THEN 0 ELSE 1 END AS 'Enabled/Disabled' UNION ALL
SELECT 'XACT_ABORT'              AS 'Option', CASE @@options & 16384 WHEN 0 THEN 0 ELSE 1 END AS 'Enabled/Disabled';
```


<a id="27"></a>
## 27. SQL Server Diagnostics Extension

Analyze Dumps – Customers using this extension will be able to debug and self-resolve memory dump issues from their SQL Server instances and receive recommended Knowledge Base (KB) article(s) from Microsoft, which may be applicable for the fix.
The memory dumps are stored in a secured and compliant manner as governed by the [Microsoft Privacy Policy](https://privacy.microsoft.com/en-us/privacystatement).

For example, Joe, a DBA from Contoso, Ltd., finds that SQL Server has generated a memory dump while running a workload, and he would like to debug the issue.
Using this feature, John can upload the dump and receive recommended KB articles from Microsoft, which can help him fix the issue.

![SQL Server Diagnostics Extension](/SSMS/SSMS_Tips/26_sql_server_diagnostics_extension.png)

More details here: [SQL Server Diagnostics Extension for SSMS] and [SQL Server Diagnostics: New "Analyze Dumps" feature]


<a id="28"></a>
## 28. Connect to SQL Servers in another domain using Windows Authentication
You may find that you need to connect remotely to a SQL Server that is in another domain.
This is a problem when SQL authentication is not an option, because Windows machine is in its own domain; Management Studio cannot directly override the local Windows credentials and pass the credentials for a remote domain user.

### Solution 1: runas

```bat
runas /netonly /user:domain\username "c:\path\ssms.exe"
````

At this point, you are prompted for the password for the remote user and, once provided, you are told that it is attempting to run the program as that user.

Also you can create shortcut: Right-click the desktop and choose `New > Shortcut`. Then enter the same information as above in the command line:
![Connect to SQL Servers in another domain using Windows Authentication with Shortcut](/SSMS/SSMS_Tips/28_connect_to_sql_servers_in_another_domain_using_windows_authentication_with_shortcut.gif)

Now you can double-click the shortcut and, after simply providing the remote password, it will launch an instance of Management Studio that will use those remote credentials every time you use Windows Authentication and try to connect to a remote server.

### Solution 2: Credential Manager
Another method you can use to connect to remote domains using Windows Authentication is to use the Credential Manager built into Windows.
This can be a little tricky to setup, especially if you are connecting over a VPN.

The part that is tricky is ensuring that name resolution matches exactly.
The Windows machine needs to identify the remote server by IP or fully-qualified domain name (FQDN), and may need to explicitly specify the port.
Added the remote server names to `c:\Windows\System32\drivers\etc\hosts` file, and then ran `ipconfig /dnsflush`.

Once you are sure you have the right FQDN (make sure you can ping it by name, or better yet, telnet to the server name on the SQL Server port (usually 1433)),
go to `Control Panel > Credential Manager, choose Windows Credentials, and Add a Windows Credential`.
Then specify the specific server name (potentially you may need `server:port notation`), the domain user (including the domain name), the password, and click OK:
![Connect to SQL Servers in another domain using Windows Authentication with Credential Manager](/SSMS/SSMS_Tips/28_connect_to_sql_servers_in_another_domain_using_windows_authentication_with_credential.gif)

Now, when you connect from Management Studio, make sure you use the exact same server name as the one you entered in the credential, including the port number (only now, use a comma instead of colon if specifying the port number: server,port). Like with the runas /netonly solution, it will *look* like you are connecting using your local Windows credentials, but - as long as the credential store doesn't have any issues in matching the server name - those really are the remote credentials that are being passed under the covers.

More details here: [Connect to SQL Servers in another domain using Windows Authentication]


<a id="29"></a>
## 29. SSMS Default Reports
By right-clicking on the SQL Server instance and navigating to `Reports > Standard Reports`, you can see the predefined SSMS reports:

![SSMS_Server_Default_Reports](/SSMS/SSMS_Tips/29_SSMS_Server_Default_Reports.png)

You can run default reports database:
![SSMS_Database_Default_Reports](/SSMS/SSMS_Tips/29_SSMS_Database_Default_Reports.png)

Useful another reports information:
 - [New in SSMS: Performance Dashboard built-in](https://blogs.msdn.microsoft.com/sql_server_team/new-in-ssms-performance-dashboard-built-in/)
 - [New in SSMS – Always On Availability Group Latency Reports]


<a id="30"></a>
## 30. Live Query Statistics
SQL Server Management Studio provides the ability to view the live execution plan of an active query.
This live query plan provides real-time insights into the query execution process as the controls flow from one query plan operator to another.
The live query plan displays the overall query progress and operator-level run-time execution statistics such as the number of rows produced, elapsed time, operator progress, etc.
Because this data is available in real time without needing to wait for the query to complete, these execution statistics are extremely useful for debugging query performance issues.
This feature is available beginning with SQL Server 2016 Management Studio, however it can work with SQL Server 2014.

More details here: [Live Query Statistics]

Warning: This feature is primarily intended for troubleshooting purposes.
Using this feature can moderately slow the overall query performance.
This feature can be used with the [Transact-SQL Debugger](https://docs.microsoft.com/en-us/sql/relational-databases/scripting/configure-firewall-rules-before-running-the-tsql-debugger).


<a id="31"></a>
## 31. Searching in Showplan
In SSMS 17.2, appear the ability to search table name, index name or column name and more in graphical showplan.
 just use `CTRL+F` to start a search in graphical showplan (or right-click on a blank area of the plan, and in the context menu click on Find Node option), and you can quickly see exactly where node id 30 is.
More details here: [New in SSMS: Searching in Showplan]


<a id="32"></a>
## 32. Object Explore Details
To bring up the Object Explorer Details pane, use the `F7` shortcut or it can be accessed from `Toolbar -> View -> Object -> Explorer Details`.

![SSMS_Database_Default_Reports](/SSMS/SSMS_Tips/32_object_explore_details_01.png)

![SSMS_Database_Default_Reports](/SSMS/SSMS_Tips/32_object_explore_details_02.png)

You can customize display field hide or unhide it:
![SSMS_Database_Default_Reports](/SSMS/SSMS_Tips/32_object_explore_details_03.png)

You can searched for the keyword `%Country%` and using `%` as a wildcard character.
This tells SQL Server Management Studio to display all the objects that have the word `Country` in their name.


<a id="33"></a>
## 33. Working with Azure SQL
For SSMS 17.2 and above you can enable Multi-Factor Authentication in Azure SQL Database, more details here:
[Configure Multi-Factor Authentication in Azure SQL Database]


<a id="34"></a>
## 34. Using Extended Events and Profiler in SSMS

Full instruction here: [EXTENDED EVENTS AND PROFILER: XE PROFILER]


<a id="35"></a>
## 35. Vulnerability Assessment in SSMS
You will need version 17.4 for the Vulnerability Assessment feature. Right-click to any database to start a scan.

![SSMS_Database_Default_Reports](/SSMS/SSMS_Tips/SQL_Vulnerability_Assessment.gif)

1. Run a scan
2. Specify where scan will be saved
3. View the report
4. Analyze the results and resolve issues
5. Set your Baseline
6. Run a new scan to see your customized tracking report
7. Open a previously run scan

More info here: [SQL Vulnerability Assessment Available in SSMS] and [Vulnerability Assessment features](https://docs.microsoft.com/en-us/sql/relational-databases/security/sql-vulnerability-assessment)


<a id="36"></a>
## 36. Import Flat File to SQL Wizard
You will need version 17.3 or later.

Detailed article here: [Import Flat File to SQL Wizard]

Import Flat File Wizard is a simple way to copy data from a flat file (.csv, .txt) to a destination.

This wizard was created to improve the current import experience leveraging an intelligent framework known as Program Synthesis using Examples ([PROSE](https://microsoft.github.io/prose/)).
For a user without specialized domain knowledge, importing data can often be a complex, error prone, and tedious task. This wizard streamlines the import process as simple as selecting an input file and unique table name, and the PROSE framework handles the rest.
PROSE analyzes data patterns in your input file to infer column names, types, delimiters, and more. This framework learns the structure of the file and does all of the hard work so our users don't have to.


<a id="37"></a>
## 37. AutoRecover in SSMS
With the default settings, you can lose up to 5 minutes of work on a sudden reboot.
The recovered information will be kept for 7 days so there is some time to get your files. 
These settings can be modified, changing how often auto recover happens and how long the information is retained.
It depends on the criticality of things that you work on as to how often you would want AutoRecover to save your scripts.
This feature can be turned off but it is not recommended.

To change the settings, go to: `Tools -> Options -> Environment -> AutoRecover`.

More details [here](https://witsociety.wordpress.com/2019/04/11/autorecover-in-ssms/).

![AutoRecover in SSMS](/SSMS/SSMS_Tips/AutoRecover_in_SSMS.png)


<a id="38"></a>
## 38. View and query Power BI .pbix files in SSMS
All Power BI files end with `.pbix`. 
You can make a copy of the file, (because DBA always like to work from copies vs. the originals) then rename the file from `.pbix` to `.zip`.
You can then unzip the file and see the base components that make up a Power BI report and visuals:

![Using SSMS with Power BI](/SSMS/SSMS_Tips/38_using_ssms_with_powerbi_01.jpg)

While the Power BI report is open, you will see what is running using the `netstat -b -n` command from the command prompt as an administrator:

You will notice that `pbidesktop.exe` is port `54125`, with multiple child threads.
You will also notice there is an executable also sourced from the `pbidesktop.exe` process called `msmdsrv.exe`.
That’s the executable for an Analysis Server. Your data model is being run by trimmed down Analysis Server in Power BI.
If you have an Analysis Server port, you can connect to it with SSMS using the ID for Power BI Desktop.
In our example above, the ID is `54125` and as the desktop is running on your PC, it would be your `localhost` for the server name.
Open up SSMS and update the server type to Analysis Server and type in the following, using my Active Directory login to connect.

You will connect to the trimmed down Analysis Server behind the PBI Desktop report you have running on your screen and have limited interactive options.

![Using SSMS with PowerBI](/SSMS/SSMS_Tips/38_using_ssms_with_powerbi_02.jpg)

More details [here](https://dbakevlar.com/2019/03/using-ssms-with-power-bi/).


<a id="39"></a>
## 39. Using SSMS and Profiler to analyze PowerBI with XMLA
SSMS can be used to, for example, view partitions generated by [incremental refresh](https://docs.microsoft.com/power-bi/service-premium-incremental-refresh). Version 18.0 RC1 or above is required.

SQL Server Profiler can be used for tracing and debugging. SSMS 18.0 RC1 or above is required.

More details [here](https://powerbi.microsoft.com/en-us/blog/power-bi-open-platform-connectivity-with-xmla-endpoints-public-preview/).

<a id="reference"></a>
## 40. Reference:
 - [Free Course: SQL Server Management Studio Shortcuts & Secrets](https://sqlworkbooks.com/course/sql-server-management-studio-shortcuts-secrets/) (by Kendra Little)
 - [SSMS Tips: Templates and Control+Shift+M](http://littlekendra.com/2016/08/09/ssms-tips-templates-and-controlshiftm/) (by Kendra Little)
 - [Fixing Hot-Key issue in SSMS in five steps](http://slavasql.blogspot.ru/2017/02/fixing-hot-key-issue-in-ssms-in-five.html) (by Slava Murygin)
 - [SSMS Tips and Tricks](http://www.ssmstipsandtricks.com/) (by Latish Sehgal)
 - [Do you need more than STATISTICS IO for Query Tuning?](https://www.sqlpassion.at/archive/2017/03/27/do-you-need-more-than-statistics-io-for-query-tuning/) (by Klaus Aschenbrenner)
 - [Top 10 SQL Server Management Studio (SSMS) Tips and Tricks](http://www.sqlmatters.com/Articles/Top%2010%20SQL%20Server%20Management%20Studio%20(SSMS)%20Tips%20and%20Tricks.aspx) (by SQLMatters)
 - [Keyboard shortcut to close a query tab in SSMS](https://www.am2.co/2017/01/close-ssms-tab/) (by Andy Mallon)
 - [SQL Server Management Studio Tips](https://www.mssqltips.com/sql-server-tip-category/52/sql-server-management-studio/) (by MSSQLTips)
 - [Generating Charts and Drawings in SQL Server Management Studio] (by Anthony Zanevsky, Andrew Zanevsky and Katrin Zanevsky)
 - [Try and try again: not always a good idea (at least not for SSMS!)](https://blogs.msdn.microsoft.com/sqlcat/2017/04/06/try-and-try-again-not-always-a-good-idea-at-least-not-for-ssms/) (by Arvind Shyamsundar)
 - [SSMS Tips: Copy Full Path](https://sqlstudies.com/2017/04/24/ssms-tips-copy-full-path/) (by Kenneth Fisher)
 - [Hiding tables in SSMS Object Explorer](https://sqlstudies.com/2017/04/03/hiding-tables-in-ssms-object-explorer-using-extended-properties/) (by Kenneth Fisher)
 - [Changing what SSMS opens on startup](https://sqlstudies.com/2017/02/01/changing-what-ssms-opens-on-startup/) (by Kenneth Fisher)
 - [Presenting: Presentation Mode!](http://www.williamdurkin.com/2017/03/presenting-presentation-mode/) (by William Durkin)
 - [RegEx-Based Finding and Replacing of Text in SSMS] (by Phil Factor)
 - [SQL Server Management Studio (SSMS) Tips and Tricks] (by Mike Milligan)
 - [Knowing the Options] (by John Morehouse)
 - [How to Enable/Trace the Query Thread Profile Extended Event in SQL Sever 2014+](https://sqlworkbooks.com/2017/06/how-to-enabletrace-the-query-thread-profile-extended-event-in-sql-sever-2014/) (by Kendra Little)
 - [SQL Server Diagnostics Extension for SSMS] (by Microsoft)
 - [T-SQL Tuesday #92: Lessons Learned the Hard Way] (by Aaron Bertrand)
 - [Connect to SQL Servers in another domain using Windows Authentication] (by Aaron Bertrand)
 - [New in SSMS: Searching in Showplan] (by Pedro Lopes)
 - [Live Query Statistics]
 - [Configure Multi-Factor Authentication in Azure SQL Database] (by Daniel Calbimonte)
 - [What’s new in SQL Server Management Studio 17.2; Authentication methods, scripting options and more] (by Ahmad Yaseen)
 - [CTRL+R does not hide the Query Result window in SSMS]
 - [SSMS Tip #1: Annotations and Map Mode for Vertical Scroll Bar] (by Solomon Rutzky)
 - [SQL Vulnerability Assessment Available in SSMS] (by Thomas LaRock)
 - [SSMS Tips and Tricks free ebook](http://ssmsbook.sqldownunder.com) (by SDU Insiders)

[Cycle through clipboard ring]:http://www.ssmstipsandtricks.com/blog/2014/05/05/cycle-through-clipboard-ring/
[Generating Charts and Drawings in SQL Server Management Studio]:http://sqlmag.com/t-sql/generating-charts-and-drawings-sql-server-management-studio
[View R Plots from within SQL Server Management Studio]:http://www.sqlservercentral.com/articles/R+Services/156107/
[RegEx-Based Finding and Replacing of Text in SSMS]:https://www.simple-talk.com/sql/sql-training/regex-based-finding-and-replacing-of-text-in-ssms/
[SQL Server Management Studio (SSMS) Tips and Tricks]:http://www.bidn.com/blogs/MMilligan/bidn-blog/3326/sql-server-management-studio-ssms-tips-and-tricks
[Knowing the Options]:http://sqlrus.com/2017/05/knowing-the-options/
[SQL Server Diagnostics Extension for SSMS]:https://blogs.msdn.microsoft.com/sql_server_team/sql-server-diagnostics-preview/
[T-SQL Tuesday #92: Lessons Learned the Hard Way]:https://blogs.sentryone.com/aaronbertrand/t-sql-tuesday-92-lessons-learned-hard-way/
[SQL Server Diagnostics: New "Analyze Dumps" feature]:https://sqlworkbooks.com/2017/07/sql-server-diagnostics-new-analyze-dumps-feature/
[Connect to SQL Servers in another domain using Windows Authentication]:https://www.mssqltips.com/sqlservertip/3250/connect-to-sql-servers-in-another-domain-using-windows-authentication/
[New in SSMS: Searching in Showplan]:https://blogs.msdn.microsoft.com/sql_server_team/new-in-ssms-searching-in-showplan/
[Live Query Statistics]:https://docs.microsoft.com/en-us/sql/relational-databases/performance/live-query-statistics
[Configure Multi-Factor Authentication in Azure SQL Database]:https://www.sqlshack.com/configure-multi-factor-authentication-azure-sql-database/
[What’s new in SQL Server Management Studio 17.2; Authentication methods, scripting options and more]:https://www.sqlshack.com/whats-new-sql-server-management-studio-17-2-authentication-methods-scripting-options/
[CTRL+R does not hide the Query Result window in SSMS]:https://stackoverflow.com/questions/17068661/ctrlr-does-not-hide-the-query-result-window-in-ssms
[SSMS Tip #1: Annotations and Map Mode for Vertical Scroll Bar]:https://sqlquantumleap.com/2017/07/17/ssms-tip-1-annotations-and-map-mode-for-vertical-scroll-bar/
[EXTENDED EVENTS AND PROFILER: XE PROFILER]:https://www.scarydba.com/2017/11/07/extended-events-profiler-xe-profiler/
[New in SSMS – Always On Availability Group Latency Reports]:https://blogs.msdn.microsoft.com/sql_server_team/new-in-ssms-always-on-availability-group-latency-reports/
[SQL Vulnerability Assessment Available in SSMS]:https://thomaslarock.com/2017/12/sql-vulnerability-assessment-available-in-ssms/
[Import Flat File to SQL Wizard]:https://docs.microsoft.com/en-us/sql/relational-databases/import-export/import-flat-file-wizard
[SSMS Tips by Wayne Sheffield]:http://blog.waynesheffield.com/wayne/archive/tag/ssms-tips/
[SQL Management Studio, Trusted Connections, and Remote User accounts]:https://weblogs.asp.net/miked/sql-management-studio-trusted-connections-and-remote-user-accounts
