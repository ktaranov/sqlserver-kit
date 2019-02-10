/*
Author: Arthur Daniels
Created Date: 2019-01-29
Original link: https://blog.sqlauthority.com/2018/09/12/sql-server-simple-method-to-extract-scale-part-from-decimal-number/
Source link: https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Fast_alternative_to_sp_WhoIsActive.sql
Modified: 2018-01-29 by Konstantin Taranov
*/

SELECT s.session_id,
    r.start_time,
    s.host_name,
    s.login_name,
    i.event_info,
    r.status,
    s.program_name,
    r.writes,
    r.reads,
    r.logical_reads,
    r.blocking_session_id,
    r.wait_type,
    r.wait_time,
    r.wait_resource
FROM sys.dm_exec_requests AS r
    INNER JOIN sys.dm_exec_sessions AS s ON s.session_id = r.session_id
CROSS APPLY sys.dm_exec_input_buffer(s.session_id, r.request_id) as i
WHERE s.session_id <> @@SPID AND
      s.is_user_process = 1;
--Remove the line above if you want to see system processes
