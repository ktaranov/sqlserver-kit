/*
Author: Kenneth Fisher
Original link: https://sqlstudies.com/2017/01/18/lead-blocker/
*/
WITH Blocked_Sessions AS (
       -- Collect lead blockers
       --     Pull all blocking IDs & check which ones are not being blocked themselves
       SELECT sys.dm_exec_requests.blocking_session_id  AS lead_session_id,
             sys.dm_exec_requests.blocking_session_id  AS blocking_session_id , 0 Cnt
       FROM sys.dm_exec_requests
       WHERE blocking_session_id  <> 0
         AND blocking_session_id  NOT IN (SELECT session_id
                                          FROM sys.dm_exec_requests
                                          WHERE sys.dm_exec_requests.blocking_session_id  <> 0)
       UNION ALL
       -- Recurse through list of blocked sessions
       SELECT Blocked_Sessions.lead_session_id, sys.dm_exec_requests.session_id, 1 Cnt
       FROM sys.dm_exec_requests
       JOIN Blocked_Sessions
             ON Blocked_Sessions.blocking_session_id  = sys.dm_exec_requests.blocking_session_id 
    ),
       Blocked AS (
             -- Add up all sessions blocked for the lead blocker
             SELECT lead_session_id, SUM(Cnt) AS sessions_blocked
             FROM Blocked_Sessions
             GROUP BY lead_session_id)
SELECT Blocked.*, DATEDIFF(s, Sess.last_request_start_time, getdate()) seconds_blocking,
    ISNULL(Req.status,'sleeping') [status], SqlText.text [sql_text],
    STUFF((SELECT DISTINCT ISNULL(', ' + db.name,'')
            FROM sys.databases db
            JOIN sys.dm_tran_locks lcks
                ON db.database_id = lcks.resource_database_id
            WHERE lcks.request_session_id = Sess.session_id
            ORDER BY ISNULL(', ' + db.name,'')
            FOR XML PATH(''),TYPE).value('.','VARCHAR(MAX)')
        ,1,2,'') AS database_list
        , Conn.client_net_address, Sess.login_name
FROM sys.dm_exec_connections Conn
LEFT OUTER JOIN sys.dm_exec_sessions Sess
       ON Conn.session_id = Sess.session_id
JOIN Blocked
       ON Blocked.lead_session_id = Sess.session_id
CROSS APPLY sys.dm_exec_sql_text(Conn.most_recent_sql_handle) SqlText
LEFT JOIN sys.dm_exec_requests Req
       ON Req.session_id = Sess.session_id
WHERE Blocked.sessions_blocked >= 1
-- We only care if the session has been blocked for longer than 30 seconds.
-- This can obviously be modified or commented out.
  AND DATEDIFF(s, Sess.last_request_start_time, getdate()) > 30;
