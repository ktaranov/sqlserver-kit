/* 
Link: https://dba.stackexchange.com/a/36578/107045
Use coreinfo (utility by sysinternals) as this will give you
a. Logical to Physical Processor Map
b. Logical Processor to Socket Map
c. Logical Processor to NUMA Node Map as below :
Logical to Physical Processor Map:
**----------------------  Physical Processor 0 (Hyperthreaded)
--**--------------------  Physical Processor 1 (Hyperthreaded)
----**------------------  Physical Processor 2 (Hyperthreaded)
------**----------------  Physical Processor 3 (Hyperthreaded)
--------**--------------  Physical Processor 4 (Hyperthreaded)
----------**------------  Physical Processor 5 (Hyperthreaded)
------------**----------  Physical Processor 6 (Hyperthreaded)
--------------**--------  Physical Processor 7 (Hyperthreaded)
----------------**------  Physical Processor 8 (Hyperthreaded)
------------------**----  Physical Processor 9 (Hyperthreaded)
--------------------**--  Physical Processor 10 (Hyperthreaded)
----------------------**  Physical Processor 11 (Hyperthreaded)
Logical Processor to Socket Map:
************------------  Socket 0
------------************  Socket 1
Logical Processor to NUMA Node Map:
************------------  NUMA Node 0
------------************  NUMA Node 1
Now, based on the above info, the Ideal MaxDop setting should be calculated as
a.  It has 12 CPU’s which are hyper threaded giving us 24 CPUs.
b.  It has 2 NUMA node [Node 0 and 1] each having 12 CPU’s with Hyperthreading ON.
c.  Number of sockets are 2 [socket 0 and 1] which are housing 12 CPU’s each.
Considering all above factors, the max degree of Parallelism should be set to 6 which is ideal value for server with above configuration.
So the answer is -- "it depends" on your processor footprint and the NUMA configuration and below table will summarize what I explained above:
8 or less processors    ===> 0 to N (where N= no. of processors)
More than 8 processors  ===> 8
NUMA configured         ===> MAXDOP should not exceed no of CPU’s assigned to each
                                 NUMA node with max value capped to 8
Hyper threading Enabled ===> Should not exceed the number of physical processors.
Below is a quick and dirty TSQL script to generate Recommendation for MAXDOP setting

Author          :   Kin Shah
Purpose         :   Recommend MaxDop settings for the server instance
Tested RDBMS    :   SQL Server 2008R2, 2014, 2016, 2017 */

DECLARE @hyperthreadingRatio BIT;
DECLARE @logicalCPUs INT;
DECLARE @HTEnabled INT;
DECLARE @physicalCPU INT;
DECLARE @SOCKET INT;
DECLARE @logicalCPUPerNuma INT;
DECLARE @NoOfNUMA INT;

SELECT @logicalCPUs = cpu_count -- [Logical CPU Count]
     , @hyperthreadingRatio = hyperthread_ratio --  [Hyperthread Ratio]
     , @physicalCPU = cpu_count / hyperthread_ratio -- [Physical CPU Count]
     , @HTEnabled = CASE
                      WHEN cpu_count > hyperthread_ratio THEN 1
                      ELSE 0
                    END -- HTEnabled
FROM   sys.dm_os_sys_info
OPTION (recompile);

SELECT @logicalCPUPerNuma = Count(parent_node_id)
-- [NumberOfLogicalProcessorsPerNuma]
FROM   sys.dm_os_schedulers
WHERE  [status] = 'VISIBLE ONLINE'
       AND parent_node_id < 64
GROUP  BY parent_node_id
OPTION (recompile);

SELECT @NoOfNUMA = Count(DISTINCT parent_node_id)
FROM   sys.dm_os_schedulers -- find NO OF NUMA Nodes 
WHERE  [status] = 'VISIBLE ONLINE'
       AND parent_node_id < 64

-- Report the recommendations ....
SELECT
--- 8 or less processors and NO HT enabled
CASE
  WHEN @logicalCPUs < 8
       AND @HTEnabled = 0 THEN 'MAXDOP setting should be : '
                               + Cast(@logicalCPUs AS VARCHAR(3))
  --- 8 or more processors and NO HT enabled
  WHEN @logicalCPUs >= 8
       AND @HTEnabled = 0 THEN 'MAXDOP setting should be : 8'
  --- 8 or more processors and HT enabled and NO NUMA
  WHEN @logicalCPUs >= 8
       AND @HTEnabled = 1
       AND @NoOfNUMA = 1 THEN 'MaxDop setting should be : '
                              + Cast(@logicalCPUPerNuma / @physicalCPU AS
                              VARCHAR(3))
  --- 8 or more processors and HT enabled and NUMA
  WHEN @logicalCPUs >= 8
       AND @HTEnabled = 1
       AND @NoOfNUMA > 1 THEN 'MaxDop setting should be : '
                              + Cast(@logicalCPUPerNuma / @physicalCPU AS
                              VARCHAR(3))
  ELSE ''
END AS Recommendations;
