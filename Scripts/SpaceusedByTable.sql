/*
Author: Greg Drake
Original link: http://www.sqlservercentral.com/scripts/99716/
*/
 /*
 * Query that simulates running sp_spaceused on every applicable object in a database and gathering it all into a single result set
 * This set-based approach is more efficient then actually doing that.
 * The logic is derived strait from the source of sp_spaceused, so the numerical values should be a 1-to-1 match.
 * Three changes have been made to the result set:
 *     (1) The object's schema and type are included.
 *     (2) Actual numbers are used in the result instead of strings with ' KB' appended to the end.
 *     (3) The reserved, data, index_size, and unused columns are renamed with a postfix of '_kb'.
 * Compatibility: 2005+
 * Released by Greg Drake on 2013-06-03
 */


SELECT 'schema'         = schema_name(so.schema_id)
     , 'name'          = so.name
     , 'type'          = so.type
     , 'type_desc'     = so.type_desc
     , 'rows'          = partition_stats.row_count
     , 'reserved_kb'   = (calc.reserved_page_count * 8)
     , 'data_kb'       = (partition_stats.page_count * 8)
     , 'index_size_kb' = (CASE WHEN (calc.used_page_count > partition_stats.page_count) THEN (calc.used_page_count - partition_stats.page_count) ELSE 0 END * 8)
     , 'unused_kb'     = (CASE WHEN calc.reserved_page_count > calc.used_page_count THEN (calc.reserved_page_count - calc.used_page_count) ELSE 0 END * 8)
FROM
    sys.objects so
    INNER JOIN
    (
        SELECT
            'object_id'            = sddps.[object_id]
            ,'row_count'           = sum(
                CASE
                    WHEN (sddps.index_id < 2) THEN sddps.row_count
                    ELSE 0
                END
            )
            ,'page_count'          = sum(
                CASE
                    WHEN (sddps.index_id < 2) THEN (sddps.in_row_data_page_count + sddps.lob_used_page_count + sddps.row_overflow_used_page_count)
                    ELSE sddps.lob_used_page_count + sddps.row_overflow_used_page_count
                END
            )
            ,'used_page_count'     = sum(sddps.used_page_count)
            ,'reserved_page_count' = sum(sddps.reserved_page_count)
        FROM
            sys.dm_db_partition_stats sddps
        GROUP BY
            sddps.[object_id]
    ) partition_stats ON (so.[object_id] = partition_stats.[object_id])
    LEFT OUTER JOIN
    (
        SELECT
            sit.parent_object_id
            ,'used_page_count'     = sum(sddps2.used_page_count)
            ,'reserved_page_count' = sum(sddps2.reserved_page_count)
        FROM
            sys.internal_tables sit
            INNER JOIN
            sys.dm_db_partition_stats sddps2 ON (sit.[object_id] = sddps2.[object_id])
        WHERE
            sit.internal_type IN (202,204,211,212,213,214,215,216)
        GROUP BY
            sit.parent_object_id
    ) summary_data ON (so.[object_id] = summary_data.parent_object_id)
    CROSS APPLY
    (
        SELECT
            'reserved_page_count'  = (partition_stats.reserved_page_count + isnull(summary_data.reserved_page_count, 0))
            ,'used_page_count'     = (partition_stats.used_page_count + isnull(summary_data.used_page_count, 0))
    ) calc
WHERE
    so.[type] IN ('U ','V ','S ','SQ','IT')
ORDER BY schema_name(so.schema_id)
       , so.name;
