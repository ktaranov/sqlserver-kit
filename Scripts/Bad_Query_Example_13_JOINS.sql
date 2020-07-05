/*
<documentation>
  <summary>Generate complex query plan</summary>
  <returns>Reads and writes per database.</returns>
  <created>2020-06-23 by Brent Ozar</created>
  <modified>2020-07-05 by Konstantin Taranov</modified>
  <version>1.1</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Bad_Query_Example_13_JOINS.sql</sourceLink>
  <originalLink>https://www.brentozar.com/archive/2020/06/bad-idea-jeans-building-big-query-plans/</originalLink>
</documentation>
*/


DECLARE @TheRootOfAllEvil TABLE
  (Id int PRIMARY KEY CLUSTERED);
WITH CTE1 AS (SELECT * FROM @TheRootOfAllEvil r1),
CTE2  AS (SELECT cA.* FROM CTE1 cA INNER JOIN CTE1 cB ON cA.Id = cB.Id),
CTE3  AS (SELECT cA.* FROM CTE2 cA INNER JOIN CTE2 cB ON cA.Id = cB.Id),
CTE4  AS (SELECT cA.* FROM CTE3 cA INNER JOIN CTE3 cB ON cA.Id = cB.Id),
CTE5  AS (SELECT cA.* FROM CTE4 cA INNER JOIN CTE4 cB ON cA.Id = cB.Id),
CTE6  AS (SELECT cA.* FROM CTE5 cA INNER JOIN CTE5 cB ON cA.Id = cB.Id),
CTE7  AS (SELECT cA.* FROM CTE6 cA INNER JOIN CTE6 cB ON cA.Id = cB.Id),
CTE8  AS (SELECT cA.* FROM CTE7 cA INNER JOIN CTE7 cB ON cA.Id = cB.Id),
CTE9  AS (SELECT cA.* FROM CTE8 cA INNER JOIN CTE8 cB ON cA.Id = cB.Id),
CTE10 AS (SELECT cA.* FROM CTE9 cA INNER JOIN CTE9 cB ON cA.Id = cB.Id)
SELECT * FROM CTE10;
