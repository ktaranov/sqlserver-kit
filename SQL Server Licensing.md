# Microsoft SQL Server Licensing

Source links:
 - [Microway SQL Server 2014 Licensing Datasheet](http://www.microway.com.au/microsoft/SQL-Server-2014-Licensing-Datasheet.pdf)
 - [Microsoft SQL Server 2014 Licensing](https://www.microsoft.com/en-us/licensing/product-licensing/sql-server-2014.aspx)
 - [Microsoft SQL Server_2014 Licensing Guide](http://sql2014.pl/docs/SQL_Server_2014_Licensing_Guide.pdf)
 - [Brent Ozar licensing simplified into 7 rules](https://www.brentozar.com/archive/2015/04/microsoft-sql-server-licensing-simplified-into-7-rules/)
 - [Microsoft Core Factor Table](http://go.microsoft.com/fwlink/?LinkID=229882)
 - [Microsoftstore Standard License](http://www.microsoftstore.com/store/msusa/en_US/pdp/SQL-Server-2014-Standard-Edition/productID.298540100)


## Microsoft SQL Server 2014 Licensing <a id="microsoft-sql-server-2014-licensing"></a>
| SQL Server 2014 Editions | Description                                                                        | Server + CAL | Core-based | Requirements                                         |
|--------------------------|------------------------------------------------------------------------------------|--------------|------------|------------------------------------------------------|
| Enterprise               | for mission critical applications and large scale data warehousing                 | No           | Yes        |                                                      |
| Business Intelligence    | Premium corporate and self-service BI                                              | Yes          | No         | SQL Server CALs required                             |
| Standard                 | Basic database, reporting and analytics capabilities                               | Yes          | Yes        | SQL Server CALs required when licensing Server + CAL |
| Parallel Data Warehouse  | Available as a component of the new Analytics Platform System integrated appliance | No           | Yes        |                                                      |

**Server + CAL**: Provides the option to license users and/or devices, with low cost access to incremental SQL Server deployments.
 - Each server running SQL Server software requires a server license.
 - Each user and/or device accessing a licensed SQL Server requires a SQL Server CAL that is the same version or newer - for example, to access a SQL Server 2012 Standard Edition server, a user would need a SQL Server 2012 or 2014 CAL.
 - Each SQL Server CAL allows access to multiple licensed SQL Servers, including Business Intelligence Edition, Standard Edition and legacy Enterprise Edition Servers

**Per Core**: Gives customers a more precise measure of computing power and a more consistent licensing metric, regardless of whether solutions are deployed on physical servers on-premises, or in virtual or cloud.
 - Core based licensing is appropriate when customers are unable to count users/devices, have Internet/Extranet workloads or systems that integrate with external facing workloads.
 - To license a physical server, customers must license all the cores in the server. Determining the number of licenses needed is done by multiplying the total number of physical cores by the appropriate core factor found in the core factor table. A minimum of 4 core licenses is required for each physical processor on the server.

**Special Note for Enterprise Edition Users**: With the introduction of SQL Server 2012, Enterprise Edition was removed from the Server + CAL mode and new server licenses are no longer available. However, customers with active Software Assurance (SA)coverage can continue to renew SA on Enterprise Edition servers and upgrade to SQL Server 2014 software. Note: for customers who upgrade to SQL Server 2014, a 20 core limit applies to the software.


### Microsoft SQL Server 2014 Core-Based Licensing <a id="microsoft-sql-server-2014-core-based-licensing"></a>
Under the Per Core licensing model, each server running SQL Server 2014 software or any of its components (such as Reporting Services or Integration Services) must be assigned an appropriate number of SQL Server 2014 core licenses. The number of core licenses needed depends on whether customers are licensing the physical server or individual virtual operating system environments (OSEs).
Unlike the Server+CAL licensing model, the Per Core model allows access for an unlimited number of users or devices to connect from either inside or outside an organization’s firewall. With the Per Core model, customers do not need to purchase additional client access licenses (CALs) to access the SQL Server software.

**Physical Server**: A **server** is a physical hardware system capable of running server software. A hardware partition or blade is considered to be a separate physical hardware system. |

**Physical Processor**: A **processor** is generally a physical chip that resides in a physical socket of the hardware partition and contains one or more cores.

**Physical Core**: Each physical processor contains smaller processing units called **physical cores**. Some processors have two cores, some four, some six or eight, and so on. The figure above shows an example of two physical processors with six cores each.

**Hardware Thread**: A **hardware thread** is either a physical core or a hyper-thread in a physical processor.

**Physical Operating System Environment**: A physical operating system environment (OSE) is configured to run directly on a physical hardware system and is all or part of an operating system instance.


### How to License SQL Server 2014 Using the Per Core Licensing Model <a id="how-to-license-sql-server-2014-using-the-per-core-licensing-model"></a>
When running SQL Server in a **physical OSE**, all physical cores on the server must be licensed. Software partitioning does not reduce the number of core licenses required, except when licensing individual virtual machines (VMs). The minimum number of licenses required for each processor on the server still applies.

To determine and acquire the correct number of core licenses needed, customers must:
1. Count the total number of physical cores in the server.
2. Multiply the number of cores by the appropriate core factor to determine the total number of licenses required for the server. Note: The core factor used depends on the processor type deployed, and a minimum of four core licenses is required for each physical processor on a physical server.
3. Purchase the appropriate number of core licenses required for the server. Core licenses are sold in packs of two, so customers must divide the number of licenses required by two to determine the actual number of line items (licensing SKUs) to order.

SQL Server Core Factor Table*

| Processor Type                                                                                             | Core Factor |
|------------------------------------------------------------------------------------------------------------|------------:|
| All processors not mentioned below                                                                         | 1           |
| AMD Processors 31XX, 32XX, 33XX, 41XX, 42XX, 43XX, 61XX, 62XX, 63XX Series Processors with 6 or more cores | 0.75        |
| Single-Core Processors                                                                                     | 4           |
| Dual-Core Processors                                                                                       | 2           |

* This is an example of how to calculate core license requirements and the core factor table. The core factor table is subject to change. You can find the core factor table at any time, updated at the link below.

The Per Core licensing model is appropriate when:
 - Deploying the SQL Server 2014 Enterprise, SQL Server 2012 Parallel Data Warehouse or SQL Server 2014 Web editions.
 - Deploying Internet or extranet workloads, systems that integrate with external-facing workloads (even if external data goes through one or more other systems), or when the number of users/devices cannot be counted easily.
 - Implementing centralized deployments that span a large number of direct and/or indirect users/devices.
 - The total licensing costs are lower than those incurred using the Server+CAL licensing model.
Note: The use of hyper-threading technology does not affect the number of core licenses required when running SQL Server software in a physical OSE.
For details on how to license virtual OSEs using the Per Core model, refer to the Licensing SQL Server 2014 for Virtual Environments section of this guide.

## Microsoft SQL Server Licensing Simplified into 7 Rules (by Brent Ozar) <a id="microsoft-sql-server-licensing-simplified-into-7-rules-by-brent-ozar"></a>
1. If you query it, you have to license it.
2. It's means the Windows environment – all of the processor cores that Windows sees. (Things get a little weirder under virtualization.)
3. Running a backup or a DBCC is considered querying.
4. If you license it, and you pay Software Assurance, you get exactly one free standby server of equivalent size. (Standby means you’re not querying it.)
5. Standard Edition costs about $2k USD per core, but caps out at 16 cores and 128GB RAM (for SQL 2014, or 64GB for 2012).
6. Enterprise Edition costs about $7k USD per core.
7. Software Assurance is an additional annual fee that gives you free upgrades as long as you keep paying for it.
