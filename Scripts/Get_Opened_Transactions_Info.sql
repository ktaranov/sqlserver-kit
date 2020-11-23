/*
<documentation>
  <summary>Get opened transactions information</summary>
  <returns>1 data set with information about opened transactions.</returns>
  <created>2017-01-01 by Paul Randal</created>
  <modified>2020-11-19 by Konstantin Taranov</modified>
  <version>1.1</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Get_Opened_Transactions_Info.sql</sourceLink>
  <originalLink>https://sqlstudies.com/2013/09/05/a-t-sql-query-to-get-current-job-activity/</originalLink>
</documentation>
*/

SELECT
    s_tst.session_id
    , s_es.login_name AS "Login Name"
    , DB_NAME (s_tdt.database_id) AS "Database"
    , s_tdt.database_transaction_begin_time AS "Begin Time"
    , s_tdt.database_transaction_log_bytes_used AS "Log Bytes"
    , s_tdt.database_transaction_log_bytes_reserved AS "Log Reserved Bytes"
    , s_est.text AS "Last T-SQL Text"
    , s_eqp.query_plan AS "Last Plan"
FROM
    sys.dm_tran_database_transactions s_tdt
INNER JOIN
    sys.dm_tran_session_transactions s_tst
ON
    s_tst.transaction_id = s_tdt.transaction_id
INNER JOIN
    sys.dm_exec_sessions s_es
ON
    s_es.session_id = s_tst.session_id
INNER JOIN
    sys.dm_exec_connections s_ec
ON
    s_ec.session_id = s_tst.session_id
LEFT OUTER JOIN
    sys.dm_exec_requests s_er
ON
    s_er.session_id = s_tst.session_id
CROSS APPLY
    sys.dm_exec_sql_text (s_ec.most_recent_sql_handle) AS s_est
OUTER APPLY
    sys.dm_exec_query_plan (s_er.plan_handle) AS s_eqp
ORDER BY
   s_tdt.database_transaction_begin_time ASC;
GO
