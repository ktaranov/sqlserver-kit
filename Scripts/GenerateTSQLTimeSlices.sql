/*
Author: Atom
Original link: http://billfellows.blogspot.ru/2017/07/generate-tsql-time-slices.html
Desctiption: Generate TSQL time slices
*/


SELECT
    D.Slice AS SliceStart
,   LEAD
    (
        D.Slice
    ,   1
        -- Default to midnight
    ,   TIMEFROMPARTS(0,0,0,0,0)
    )
    OVER (ORDER BY D.Slice) AS SliceStop
,   ROW_NUMBER() OVER (ORDER BY D.Slice) AS SliceLabel
FROM
(
    -- Generate 15 second time slices
    SELECT 
        TIMEFROMPARTS(A.rn, B.rn, C.rn, 0, 0) AS Slice
    FROM
        (SELECT TOP (24) -1 + ROW_NUMBER() OVER (ORDER BY(SELECT NULL)) FROM sys.all_objects AS AO) AS A(rn)
        CROSS APPLY (SELECT TOP (60) (-1 + ROW_NUMBER() OVER (ORDER BY(SELECT NULL))) FROM sys.all_objects AS AO) AS B(rn)
        -- 4 values since we'll aggregate to 15 seconds
        CROSS APPLY (SELECT TOP (4) (-1 + ROW_NUMBER() OVER (ORDER BY(SELECT NULL))) * 15  FROM sys.all_objects AS AO) AS C(rn)
) D

