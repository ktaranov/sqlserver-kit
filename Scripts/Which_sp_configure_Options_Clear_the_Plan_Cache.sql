/*
Author: Brent Ozar
Source link: https://www.brentozar.com/archive/2017/09/sp_configure-options-clear-plan-cache/
*/

DECLARE @string_to_execute NVARCHAR(1000), @current_name NVARCHAR(200), @current_value_in_use SQL_VARIANT, @current_maximum SQL_VARIANT;

CREATE TABLE #configs (name NVARCHAR(200), value_in_use SQL_VARIANT, maximum SQL_VARIANT, clears_plan_cache BIT);
INSERT INTO #configs (name, value_in_use, maximum, clears_plan_cache)
  SELECT name, value_in_use, maximum, 0
  FROM sys.configurations;

DECLARE config_cursor CURSOR FOR 
  SELECT name, value_in_use, maximum
  FROM #configs
  WHERE name NOT IN ('default language', 'default full-text language', 'min server memory (MB)', 'user options');

OPEN config_cursor;
FETCH NEXT FROM config_cursor INTO @current_name, @current_value_in_use, @current_maximum;


WHILE @@FETCH_STATUS = 0
BEGIN
  /* Put something in the plan cache */
  
  /* Run sp_configure to set it to maximum */ 
  SET @string_to_execute = 'sp_configure ''' + @current_name + ''', ''' + CAST(@current_maximum AS NVARCHAR(100)) + '''; RECONFIGURE WITH OVERRIDE;';
  EXEC(@string_to_execute);

  /* Check the plan cache */
  IF NOT EXISTS(SELECT * FROM sys.dm_exec_query_stats)
    UPDATE #configs
    SET clears_plan_cache = 1
    WHERE name = @current_name;

  /* Run sp_configure to set it back */ 
  SET @string_to_execute = 'sp_configure ''' + @current_name + ''', ''' + CAST(@current_value_in_use AS NVARCHAR(100)) + '''; RECONFIGURE WITH OVERRIDE;';
  EXEC(@string_to_execute);

  FETCH NEXT FROM config_cursor INTO @current_name, @current_value_in_use, @current_maximum;
END
CLOSE config_cursor;
DEALLOCATE config_cursor;

SELECT name, clears_plan_cache
  FROM #configs
  WHERE clears_plan_cache = 1
  ORDER BY name;

DROP TABLE #configs;
