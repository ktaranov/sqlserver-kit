# SQL Server First Responder Kit

You're a DBA, sysadmin, or developer who manages Microsoft SQL Servers. It's your fault if they're down or slow. These tools help you understand what's going on in your server.

    When you want an overall health check, run sp_Blitz.
    To learn which queries have been using the most resources, run sp_BlitzCache.
    To analyze which indexes are missing or slowing you down, run sp_BlitzIndex.
    To find out why the server is slow right now, run sp_BlitzFirst.

To install, download the latest release ZIP, then run the SQL files in the master database. (You can use other databases if you prefer.)

Only Microsoft-supported versions of SQL Server are supported here - sorry, 2005 and 2000. Some of these may work some of the time on 2005, but no promises, and don't file a support issue when they fail. (For example, we know the output tables won't work on SQL 2005 because one of the output fields is a DATETIMEOFFSET datatype, which isn't available in 2005.)
