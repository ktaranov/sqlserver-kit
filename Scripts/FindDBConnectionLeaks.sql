/*
Author: Michael J Swart (@MJSwart)
Original link: https://sqlperformance.com/2017/07/sql-performance/find-database-connection-leaks
Desctiption: Find Database Connection Leaks in Your Application
*/

--Finding Your Connection Leaks

select count(*) as sessions,
         s.host_name,
         s.host_process_id,
         s.program_name,
         db_name(s.database_id) as database_name
   from sys.dm_exec_sessions s
   where is_user_process = 1
   group by host_name, host_process_id, program_name, database_id
   order by count(*) desc;
   
   
--Given a pool, are there sessions that have been sleeping for a while and, if so, 
--how long have they been sleeping and what was the last SQL statement they executed?

declare @host_process_id int = 1508;
  declare @host_name sysname = N'SERV4102';
  declare @database_name sysname = N'My_Database';
 
  select datediff(minute, s.last_request_end_time, getdate()) as minutes_asleep,
         s.session_id,
         db_name(s.database_id) as database_name,
         s.host_name,
         s.host_process_id,
         t.text as last_sql,
         s.program_name
    from sys.dm_exec_connections c
    join sys.dm_exec_sessions s
         on c.session_id = s.session_id
   cross apply sys.dm_exec_sql_text(c.most_recent_sql_handle) t
   where s.is_user_process = 1
         and s.status = 'sleeping'
         and db_name(s.database_id) = @database_name
         and s.host_process_id = @host_process_id
         and s.host_name = @host_name
         and datediff(second, s.last_request_end_time, getdate()) > 60
   order by s.last_request_end_time;
