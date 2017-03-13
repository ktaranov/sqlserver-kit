--Finding Blocking Queries
--Author:  Steve Stedman
--One of the common problems with when diagnosing what appears to be a slow scenario where there may be blocking involved is determining what is blocking on SQL Server
--This script works on SQL Server 2008, 2008R2, 2012, 2014, and 2016
--If there is no blocking occurring then this query will return nothing

SELECT * 
INTO #runningQueries
 FROM master..sysprocesses WITH (NOLOCK);
 
 
;WITH BlockingCTE as
(
 SELECT q1.blocked as spid
 FROM #runningQueries q1
 WHERE q1.blocked != 0 
 AND q1.blocked not in (SELECT spid FROM #runningQueries q2 WHERE q2.blocked != 0)
)
, recursiveBlocking AS
(
 SELECT b.spid, cast(0 as SMALLINT) as blocked, 
 cast(b.spid as varchar(1000)) as treePath, 0 as level,
 sp1.sql_handle, b.spid as topBlock
 FROM BlockingCTE b
 INNER JOIN #runningQueries sp1 on sp1.spid = b.spid 
 
 UNION ALL
 
 SELECT sp.spid, rb.spid as blocked, 
 cast(rb.treePath + '-&gt;' + cast(sp.spid as varchar(1000)) as VARCHAR(1000)) as treePath, 
 level + 1 as level, sp.sql_handle, topBlock
 FROM #runningQueries sp 
 INNER JOIN recursiveBlocking as rb ON rb.spid = sp.blocked
)
, topBlockCount AS
(
 SELECT *, count(1) over(partition by topBlock) as NumBlocked 
 FROM recursiveBlocking
)
SELECT DISTINCT
 tb.SPID,
 tb.blocked,
 tb.treePath as blockingChain,
 tb.level,
 tb.topBlock,
 tb.NumBlocked, 
 LTRIM(REPLACE(REPLACE(st.text, char(10), ' '), char(13), ' ')) as theQuery
 FROM topBlockCount tb
 CROSS APPLY sys.dm_exec_sql_text(tb.sql_handle) AS st
 ORDER BY NumBlocked DESC, treePath
 OPTION (RECOMPILE);
 
 
DROP TABLE #runningQueries;