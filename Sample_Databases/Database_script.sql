SELECT name [Database Name]
     , physical_name [File Location]
     , ROUND(size * (8.0 / 1024), 0) [Size in MBs]
     , *
  FROM sys.master_files
 WHERE file_id = 1 AND name NOT IN ('master', 'tempdev', 'modeldev', 'MSDBData')
 ORDER BY CASE WHEN physical_name LIKE '%StackOverflow2010.mdf'                   THEN 1
               WHEN physical_name LIKE '%StackOverflow.mdf'                       THEN 2
               WHEN physical_name LIKE '%WideWorldImporters.mdf'                  THEN 3
               WHEN physical_name LIKE '%WideWorldImportersDW.mdf'                THEN 4
               WHEN physical_name LIKE '%AdventureWorks2017.mdf'                  THEN 5
               WHEN physical_name LIKE '%AdventureWorks2016_Data.mdf'             THEN 6
               WHEN physical_name LIKE '%AdventureWorks2016_EXT_Data.mdf'         THEN 7
               WHEN physical_name LIKE '%AdventureWorks2014_Data.mdf'             THEN 8
               WHEN physical_name LIKE '%AdventureWorks2012.mdf'                  THEN 9
               WHEN physical_name LIKE '%AdventureWorksDW2017.mdf'                THEN 10
               WHEN physical_name LIKE '%AdventureWorksDW2016_Data.mdf'           THEN 11
               WHEN physical_name LIKE '%AdventureWorksDW2016_EXT_Data.mdf'       THEN 12
               WHEN physical_name LIKE '%AdventureWorksDW2014_Data.mdf'           THEN 13
               WHEN physical_name LIKE '%AdventureWorksDW2012.mdf'                THEN 14
               WHEN physical_name LIKE '%AdventureWorksMultidimensionalModel.mdf' THEN 15
               WHEN physical_name LIKE '%AdventureWorksTabularModel.mdf'          THEN 16
               ELSE 100
          END;
