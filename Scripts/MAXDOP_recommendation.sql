/* Use coreinfo (utility by sysinternals) as this will give you
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
Tested RDBMS    :   SQL Server 2008R2 */

declare @hyperthreadingRatio bit
declare @logicalCPUs int
declare @HTEnabled int
declare @physicalCPU int
declare @SOCKET int
declare @logicalCPUPerNuma int
declare @NoOfNUMA int

select @logicalCPUs = cpu_count -- [Logical CPU Count]
    ,@hyperthreadingRatio = hyperthread_ratio --  [Hyperthread Ratio]
    ,@physicalCPU = cpu_count / hyperthread_ratio -- [Physical CPU Count]
    ,@HTEnabled = case 
        when cpu_count > hyperthread_ratio
            then 1
        else 0
        end -- HTEnabled
from sys.dm_os_sys_info
option (recompile);

select @logicalCPUPerNuma = COUNT(parent_node_id) -- [NumberOfLogicalProcessorsPerNuma]
from sys.dm_os_schedulers
where [status] = 'VISIBLE ONLINE'
    and parent_node_id < 64
group by parent_node_id
option (recompile);

select @NoOfNUMA = count(distinct parent_node_id)
from sys.dm_os_schedulers -- find NO OF NUMA Nodes 
where [status] = 'VISIBLE ONLINE'
    and parent_node_id < 64

-- Report the recommendations ....
select
    --- 8 or less processors and NO HT enabled
    case 
        when @logicalCPUs < 8
            and @HTEnabled = 0
            then 'MAXDOP setting should be : ' + CAST(@logicalCPUs as varchar(3))
                --- 8 or more processors and NO HT enabled
        when @logicalCPUs >= 8
            and @HTEnabled = 0
            then 'MAXDOP setting should be : 8'
                --- 8 or more processors and HT enabled and NO NUMA
        when @logicalCPUs >= 8
            and @HTEnabled = 1
            and @NoofNUMA = 1
            then 'MaxDop setting should be : ' + CAST(@logicalCPUPerNuma / @physicalCPU as varchar(3))
                --- 8 or more processors and HT enabled and NUMA
        when @logicalCPUs >= 8
            and @HTEnabled = 1
            and @NoofNUMA > 1
            then 'MaxDop setting should be : ' + CAST(@logicalCPUPerNuma / @physicalCPU as varchar(3))
        else ''
        end as Recommendations