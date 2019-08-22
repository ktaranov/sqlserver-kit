/*
<documentation>
  <summary>Disable and enable again all triggers in database</summary>
  <returns>nothing.</returns>
  <issues>No</issues>
  <author>Federico Minca</author>
  <created>2019-08-20</created>
  <modified>2019-08-26 by Konstantin Taranov</modified>
  <version>1.0</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Disable_Enable_All_Triggers_In_Database.sql</sourceLink>
  <originalLink>https://jesspomfret.com/disable-all-triggers/</originalLink>
</documentation>
*/

-- Select Active Triggers and prepare Disable and Enable T-SQL Statement and put into Temp Table
SELECT 'ALTER TABLE [' + sc.name + '].[' + ta.name + '] DISABLE TRIGGER [' + tr.name + '];' AS DisableTriggerStatement,
'ALTER TABLE [' + sc.name + '].[' + ta.name + '] ENABLE TRIGGER [' + tr.name + '];' AS EnableTriggerStatement
INTO #Triggers
FROM sys.triggers tr
INNER JOIN sys.tables ta  ON ta.object_id = tr.parent_id
INNER JOIN sys.schemas sc ON sc.schema_id = ta.schema_id
WHERE tr.is_disabled = 0;

-- Perpare Variable Script for Execution
DECLARE @Disable_Statement nvarchar(max) = (
    SELECT tmp.DisableTriggerStatement + CHAR(10) AS "data()"
     FROM #Triggers tmp
    FOR XML PATH('')
    );

-- Execute SQL
EXEC sys.sp_executesql @Disable_Statement;

-- Perpare Variable Script for Execution
DECLARE @Enable_Statement nvarchar(max) = (
   SELECT tmp.DisableTriggerStatement + CHAR(10) AS "data()"
     FROM #Triggers tmp
    FOR XML PATH('')
    );

-- Execute SQL
EXEC sys.sp_executesql @Enable_Statement;

DROP TABLE #Triggers;
