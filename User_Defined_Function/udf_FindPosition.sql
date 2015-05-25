CREATE FUNCTION dbo.udf_FindPosition
(
@strInput varchar ( 8000
                  ) 
,
@delimiter varchar ( 50
                   ) 
) 
RETURNS TABLE
AS
RETURN

    WITH findchar ( posnum,
                    pos
                  ) 
        AS (
        SELECT 1 AS           posnum,
               CHARINDEX ( @delimiter, @strInput
                         ) AS pos
        UNION ALL
        SELECT f.posnum + 1 AS posnum,
               CHARINDEX ( @delimiter, @strInput, f.pos + 1
                         ) AS  pos
          FROM findchar AS f
          WHERE f.posnum + 1 <= LEN ( @strInput
                                    ) 
                AND
                pos <> 0
           ) 
        SELECT posnum
               ,
               pos
          FROM findchar
          WHERE
          pos > 0;

GO
