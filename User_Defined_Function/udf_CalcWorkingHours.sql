/*
Programmer: Luis Cazares
Date: 2014-05-22
Purpose: This function will return working hours between given 2 dates. 
This function assumes that the break is between 9:45 AM and 10 AM and that Lunch is between 12:30 PM and 1 PM. 
This function also assumes that the working hours are between 7:30 AM and 4 PM. 
This function was inspired by Goran Borojevic
*/
CREATE function [dbo].[CalcWorkingHours] (@StartDate datetime, @EndDate datetime)
RETURNS table
AS RETURN
    SELECT ISNULL((((DATEDIFF(dd,@StartDate,@EndDate)-1) --Start with total number of days including weekends
              - (DATEDIFF(wk,@StartDate,@EndDate)*2) --Subtact 2 days for each full weekend
              - (1-SIGN(DATEDIFF(dd,6,@StartDate)%7)) --If StartDate is a Sunday, Subtract 1
              - (1-SIGN(DATEDIFF(dd,5,@EndDate)  %7))) * 465) --This will give us full days minus one that we'll complete with following operations
        + (SELECT CASE  WHEN @StartDate <= DATEADD(MI, 450, DATEADD(DD, DATEDIFF(DD, 0, @StartDate), 0)) 
                    THEN 465 --if Start Date is earlier than 7:30 then it counts as full day
                WHEN @StartDate >= DATEADD(MI, 960, DATEADD(DD, DATEDIFF(DD, 0, @StartDate), 0)) 
                    THEN 0 --if Start Date is later than 16:00 then it won't count
                ELSE DATEDIFF(MI, @StartDate, DATEADD(MI, 960, DATEADD(DD, DATEDIFF(DD, 0, @StartDate), 0))) --Minutes between start date and 16:00
                    -
                    CASE WHEN @StartDate <= DATEADD(MI, 585, DATEADD(DD, DATEDIFF(DD, 0, @StartDate), 0))
                             THEN 15 --If it's earlier than the break, substract whole break
                         WHEN @StartDate <= DATEADD(MI, 600, DATEADD(DD, DATEDIFF(DD, 0, @StartDate), 0))
                                --If it's earlier than the end of the break, substract corresponding minutes
                            THEN DATEDIFF( MI, @StartDate, DATEADD(MI, 600, DATEADD(DD, DATEDIFF(DD, 0, @StartDate), 0)))
                         ELSE 0
                         END 
                    -
                    CASE WHEN @StartDate <= DATEADD(MI, 750, DATEADD(DD, DATEDIFF(DD, 0, @StartDate), 0))
                            THEN 30 --If it's earlier than lunch, substract whole lunch time
                         WHEN @StartDate <= DATEADD(MI, 780, DATEADD(DD, DATEDIFF(DD, 0, @StartDate), 0))
                                --If it's earlier than the end of lunch time, substract corresponding minutes
                            THEN DATEDIFF( MI, @StartDate, DATEADD(MI, 780, DATEADD(DD, DATEDIFF(DD, 0, @StartDate), 0)))
                         ELSE 0
                         END 
                END
                
        + CASE WHEN @EndDate <= DATEADD(MI, 450, DATEADD(DD, DATEDIFF(DD, 0, @EndDate), 0)) 
                THEN 0 --if End Date is earlier than 7:30 then it won't count
                WHEN @EndDate >= DATEADD(MI, 960, DATEADD(DD, DATEDIFF(DD, 0, @EndDate), 0)) 
                THEN 465 --if End Date is later than 16:00 then it counts as full day
                ELSE DATEDIFF(MI, DATEADD(MI, 960, DATEADD(DD, DATEDIFF(DD, 0, @EndDate), 0)), @EndDate) --Minutes between 7:30 and end date
                    -
                    CASE WHEN @EndDate >= DATEADD(MI, 600, DATEADD(DD, DATEDIFF(DD, 0, @EndDate), 0))
                             THEN 15 --If it's later than the break, substract whole break
                         WHEN @EndDate >= DATEADD(MI, 585, DATEADD(DD, DATEDIFF(DD, 0, @EndDate), 0))
                                --If it's later than the start of the break, substract corresponding minutes
                            THEN DATEDIFF( MI, DATEADD(MI, 585, DATEADD(DD, DATEDIFF(DD, 0, @EndDate), 0)), @EndDate)
                         ELSE 0
                         END 
                    -
                    CASE WHEN @EndDate >= DATEADD(MI, 780, DATEADD(DD, DATEDIFF(DD, 0, @EndDate), 0))
                            THEN 30 --If it's later than lunch, substract whole lunch time
                         WHEN @EndDate >= DATEADD(MI, 750, DATEADD(DD, DATEDIFF(DD, 0, @EndDate), 0))
                                --If it's later than the start of lunch time, substract corresponding minutes
                            THEN DATEDIFF( MI, DATEADD(MI, 750, DATEADD(DD, DATEDIFF(DD, 0, @EndDate), 0)), @EndDate)
                         ELSE 0
                         END 
                END
    WHERE @StartDate <= @EndDate)
    /* Uncomment to use holidays table 
    - ((SELECT count(*)
        FROM holidaystable
        WHERE [Date] BETWEEN @StartDate AND @EndDate) * 7.75)
    */
    ,0) / 60.0 AS WorkingHours
