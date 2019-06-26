/*
<documentation>
  <summary>Count size in bytes veiws, triggers, procedures and function in database.</summary>
  <returns>1 data set: RoutinType, SUM LENGTH of objects, SUM DATALENGTH.</returns>
  <issues>No</issues>
  <author>Cade Roux</author>
  <created>2008-10-20</created>
  <modified>2019-06-26 by Konstantin Taranov</modified>
  <version>1.0</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Objects_Size_In_Database.sql</sourceLink>
  <originalLink>https://stackoverflow.com/a/219740/2298061</originalLink>
</documentation>
*/

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

WITH CTE_Routine AS (
    /* Can not use INFORMATION_SCHEMA.ROUTINES because of 4000 character limit */
    SELECT o.type_desc     AS RoutineType
         , o.[name]        AS RoutineName
         , m.[definition]  AS RoutineDefinition
    FROM   sys.sql_modules AS m 
    INNER JOIN sys.objects AS o ON m.object_id = o.object_id
)
SELECT RoutineType
     , SUM(LEN(RoutineDefinition))            AS RoutineLen
     /* DATALENGTH for counting trailing space in the end of objects definitions */
     , SUM(DATALENGTH(RoutineDefinition)) / 2 AS RoutineDatalength
FROM   CTE_Routine
GROUP BY RoutineType;
