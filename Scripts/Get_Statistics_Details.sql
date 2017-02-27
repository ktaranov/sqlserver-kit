-- Get statistics details on SQL Server 2008 R2 and higher
-- Author: Kendra Little
-- "This works with SQL Server 2008 R2 SP2+ / SQL Server 2012 SP1+ / All higher versions"
    SELECT 
        stat.auto_created,
        stat.name as stats_name,
        STUFF((SELECT ', ' + cols.name
            FROM sys.stats_columns AS statcols
            JOIN sys.columns AS cols ON
                statcols.column_id=cols.column_id
                AND statcols.object_id=cols.object_id
            WHERE statcols.stats_id = stat.stats_id and
                statcols.object_id=stat.object_id
            ORDER BY statcols.stats_column_id
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)'), 1, 2, '')  as stat_cols,
        stat.filter_definition,
        stat.is_temporary,
        stat.no_recompute,
        sp.last_updated,
        sp.modification_counter,
        sp.rows,
        sp.rows_sampled
    FROM sys.stats as stat
    CROSS APPLY sys.dm_db_stats_properties (stat.object_id, stat.stats_id) AS sp
    JOIN sys.objects as so on 
        stat.object_id=so.object_id
    JOIN sys.schemas as sc on
        so.schema_id=sc.schema_id
    WHERE 
        sc.name= 'Warehouse'
        and so.name='StockItemTransactions'
    ORDER BY 1, 2;
    GO
    