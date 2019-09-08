/*
<documentation>
  <summary>Detail Job History</summary>
  <returns>1 result set with detailed jobs information.</returns>
  <issues>No</issues>
  <author>Max Vernon</author>
  <created>2019-07-21</created>
  <modified></modified>
  <version>1.0</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/How_much_will_it_cost_or_save_to_rebuild_that_index.sql</sourceLink>
  <originalLink>https://www.sqlservercentral.com/articles/rebuild-index</originalLink>
</documentation>
*/

/**************************************************************************************************
 Purpose:
 Display some things about indexes that we’d normally like to know plus it calculates how much 
 extra space would be saved or used after a REBUILD for the current Fill Factor and for the 70, 80,
 90, and 100% Fill Factors.
 Progammers Notes:
 
 1. Keep in mind that these are all based on averages and so should be considered as approximations.
    Also, indexes with very wide rows where there are less than 20 or so rows per page can cause
    less accurate approximations.
 2. It would be quite easy to turn this into a system stored procedure that could be executed from
    any database.
 3. Note that this has only been tested for non-partitioned rowstore indexes.
 Revision History:
 Rev 00 - 21 Jul 2019 - Jeff Moden
        - Borrow parts of a much larger stored procedure that I use.
**************************************************************************************************/
   WITH cteStats AS
(--===== This CTE is used mostly to rename some of the very long names in the DMF.
 SELECT  DBName         = DB_NAME()
        ,ObjectID       = ips.object_id
        ,IndexID        = ips.index_id
        ,FragPct        = CONVERT(INT,ips.avg_fragmentation_in_percent)
        ,AvgFragSize    = avg_fragment_size_in_pages
        ,PageDensity    = ips.avg_page_space_used_in_percent
        ,PageCnt        = ips.page_count
        ,RowCnt         = ips.record_count
        ,CurSizeMB      = ips.page_count/128 --Integer math produces whole numbers here.
   FROM sys.dm_db_index_physical_stats (DB_ID(),NULL,NULL,NULL,'SAMPLED') ips
  WHERE ips.index_id    > 0   --NOT a HEAP
    AND ips.page_count  > 128 --This is 1 MB or 16 Extents and could be parameterized.
)
 SELECT  stats.DBName
        ,SchemaName     = OBJECT_SCHEMA_NAME(stats.ObjectID)
        ,ObjectName     = OBJECT_NAME(stats.ObjectID)
        ,stats.ObjectID
        ,IndexName      = idx.name
        ,stats.IndexID
        ,CurFillFactor  = idx.fill_factor
        ,stats.FragPct
        ,stats.AvgFragSize
        ,stats.PageDensity
        ,stats.PageCnt
        ,stats.RowCnt
        ,stats.CurSizeMB
        ,SavingsMBCur   = CONVERT(INT,(stats.PageCnt-(stats.PageDensity/ISNULL(NULLIF(idx.fill_factor,0),100)*stats.PageCnt))/128.0)
        ,SavingsMB070   = CONVERT(INT,(stats.PageCnt-(stats.PageDensity/ 70*stats.PageCnt))/128.0)
        ,SavingsMB080   = CONVERT(INT,(stats.PageCnt-(stats.PageDensity/ 80*stats.PageCnt))/128.0)
        ,SavingsMB090   = CONVERT(INT,(stats.PageCnt-(stats.PageDensity/ 90*stats.PageCnt))/128.0)
        ,SavingsMB100   = CONVERT(INT,(stats.PageCnt-(stats.PageDensity/100*stats.PageCnt))/128.0)
   FROM cteStats    stats
   JOIN sys.indexes idx
     ON stats.ObjectID  = idx.object_id
    AND stats.IndexID   = idx.index_id
;