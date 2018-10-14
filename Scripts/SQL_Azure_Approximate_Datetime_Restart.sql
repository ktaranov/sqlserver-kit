/*
Author: Mitch Wheat
Original link: https://mitchwheat.com/2018/10/12/when-did-my-azure-sql-database-server-restart/
Created Date: 2018-10-18
Modified Date: 2018-10-18
*/

;with cte as
(
    SELECT wait_time_ms 
    FROM sys.dm_os_wait_stats w with(nolock)
    WHERE wait_type IN
    (
        'BROKER_TASK_STOP',
        'DIRTY_PAGE_POLL',
        'HADR_FILESTREAM_IOMGR_IOCOMPLETION',
        'LAZYWRITER_SLEEP',
        'LOGMGR_QUEUE',
        'REQUEST_FOR_DEADLOCK_SEARCH',
        'XE_DISPATCHER_WAIT',
        'XE_TIMER_EVENT'
    )
)
select
    approx_ms_since_restart = AVG(wait_time_ms), 
    approximate_restart_date = DATEADD(s, AVG(-wait_time_ms)/1000, GETDATE())
from
cte
cross join
     (select
         q1 = min(wait_time_ms), 
         q3 = max(wait_time_ms), 
         iqr = max(wait_time_ms) - min(wait_time_ms)
      from (select
               wait_time_ms,
               row_number() over (order by wait_time_ms) as seqnum,
               count(*) over (partition by null) as total
            from cte
           ) t
      where seqnum = cast(total * 0.25 as int) or seqnum = cast(total * 0.75 as int)
     ) qts
 where (wait_time_ms >= q1 - 1.5 * iqr) AND (wait_time_ms <= q3 + 1.5 * iqr);
