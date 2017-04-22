/*Author: Itzik Ben-Gan
Description: Compute Date and Time Difference in Parts
Solution to computing the difference between two date and time values in a combination of parts ranging from the year down to the nanosecond.*/

IF OBJECT_ID(N'dbo.DATEDIFFPARTS', N'IF') IS NOT NULL
                                DROP FUNCTION dbo.DATEDIFFPARTS;
                              GO
                              CREATE FUNCTION dbo.DATEDIFFPARTS(@dt1 AS DATETIME2, @dt2 AS DATETIME2)
                                RETURNS TABLE
                              AS
                              RETURN
                                SELECT
                                  sgn,
                                  yydiff - subyy AS yy,
                                  (mmdiff - submm) % 12 AS mm,
                                  DATEDIFF(day, DATEADD(mm, mmdiff - submm, dt1), dt2) - subdd AS dd,
                                  nsdiff / CAST(3600000000000 AS BIGINT) AS hh,
                                  nsdiff / CAST(60000000000 AS BIGINT) % 60 AS mi,
                                  nsdiff / 1000000000 % 60 AS ss,
                                  nsdiff % 1000000000 AS ns
                                FROM ( VALUES( CASE WHEN @dt1 > @dt2 THEN @dt2 ELSE @dt1 END,
                                               CASE WHEN @dt1 > @dt2 THEN @dt1 ELSE @dt2 END,
                                               CASE WHEN @dt1 < @dt2 THEN 1
                                                    WHEN @dt1 = @dt2 THEN 0
                                                    WHEN @dt1 > @dt2 THEN -1 END ) ) AS D(dt1, dt2, sgn)
                                  CROSS APPLY ( VALUES( CAST(dt1 AS TIME), CAST(dt2 AS TIME),
                                                        DATEDIFF(yy, dt1, dt2),
                                                        DATEDIFF(mm, dt1, dt2),
                                                        DATEDIFF(dd, dt1, dt2) ) )
                                    AS A1(t1, t2, yydiff, mmdiff, dddiff)
                                  CROSS APPLY ( VALUES
                                      ( CASE WHEN DATEADD(yy, yydiff, dt1) > dt2 THEN 1 ELSE 0 END,
                                        CASE WHEN DATEADD(mm, mmdiff, dt1) > dt2 THEN 1 ELSE 0 END,
                                        CASE WHEN DATEADD(dd, dddiff, dt1) > dt2 THEN 1 ELSE 0 END ) )
                                    AS A2(subyy, submm, subdd)
                                  CROSS APPLY ( VALUES( CAST(86400000000000 AS BIGINT) * subdd
                                      + (CAST(1000000000 AS BIGINT) * DATEDIFF(ss, '00:00', t2)
                                           + DATEPART(ns, t2))
                                      - (CAST(1000000000 AS BIGINT) * DATEDIFF(ss, '00:00', t1)
                                           + DATEPART(ns, t1)) ) )
                                    AS A3(nsdiff);
                              GO