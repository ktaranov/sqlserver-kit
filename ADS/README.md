# Azure Data Studio (ADS)
[Azure Data Studio](https://github.com/microsoft/azuredatastudio) is a open source cross-platform database tool for data professionals using the Microsoft family of on-premises and cloud data platforms on Windows, MacOS, and Linux.


## Useful Links

- [Official ADS List of Extensions](https://github.com/microsoft/azuredatastudio/wiki/List-of-Extensions)
- [Latest Release](https://github.com/microsoft/azuredatastudio/releases/latest)

## Download the latest Azure Data Studio release

| Platform                 | Download Link                                   |
|--------------------------|-------------------------------------------------|
| Windows User Installer   | https://go.microsoft.com/fwlink/?linkid=2132348 |
| Windows System Installer | https://go.microsoft.com/fwlink/?linkid=2132347 |
| Windows ZIP              | https://go.microsoft.com/fwlink/?linkid=2132518|
| macOS ZIP                | https://go.microsoft.com/fwlink/?linkid=2132519 |
| Linux TAR.GZ             | https://go.microsoft.com/fwlink/?linkid=2132349 |
| Linux RPM                | https://go.microsoft.com/fwlink/?linkid=2132351 |
| Linux DEB                | https://go.microsoft.com/fwlink/?linkid=2132350 |


## Azure Data Studio extensions

| Extension                             | Repository Link | Release Date | Version  | .vsix download link                                                 | Description                                                                                                                                             |
|---------------------------------------|-----------------|--------------|----------|---------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------|
| [SQL Server Import]                   | [Github][1]     | 2020-05-15   | 0.15.0   | [GO](https://go.microsoft.com/fwlink/?linkid=2131183)               | Streamlines the data import process by providing a wizard that simplifies copying flat files (`.csv`, `.txt`, `.json`) into a SQL Server table          |
| [PostgreSQL extension (preview)]      | [Github][2]     | 2020-03-26   | 0.2.6    | [GO](https://go.microsoft.com/fwlink/?linkid=2099772)               | Enables users to connect, query, and manage Postgres databases with Azure Data Studio                                                                   |
| [Query Editor Boost][3]               | [Github][3]     | 2020-02-17   | 0.4.1    | [Github][https://github.com/dzsquared/query-editor-boost/releases/] | This extension adds several features helpful with query writing in Azure Data Studio                                                                    |
| [SQL Server Dacpac]                   | [Github][1]     | 2020-06-04   | 1.5.0    | [GO](https://go.microsoft.com/fwlink/?linkid=2099885)               | Provides an easy-to-use wizarding experience to deploy and extract [`.dacpac`] files and import and export `.bacpac` files                              |
| [SQL Server Profiler]                 | [Github][1]     | 2019-12-18   | 0.11.0   | [GO](https://go.microsoft.com/fwlink/?linkid=2099574)               | Provides a simple SQL Server tracing solution similar to SSMS Profiler, allowing users to create and manage traces and analyze and replay trace results |
| [SQL Server Agent]                    | [Github][1]     | 2020-04-16   | 0.47.0   | [GO](https://go.microsoft.com/fwlink/?linkid=2099884)               | Helps manage and troubleshoot SQL Server Agent jobs and configuration (early preview)                                                                   |
| SQL Server Admin Pack                 | [Github][1]     | 2019-03-14   | 0.0.2    | [GO](https://go.microsoft.com/fwlink/?linkid=2099889)               | A collection of popular database administration extensions to help manage SQL Server                                                                    |
| [SQL Server Schema Compare]           | [Github][1]     | 2020-06-17   | 1.5.0    | [GO](https://go.microsoft.com/fwlink/?linkid=2099886)               | Provides an easy-to-use experience to compare the schemas from [`.dacpac`] files and databases and apply the changes from source to target              |
| [PowerShell Extension]                | [Github][6]     | 2020-04-15   | 2020.4.0 | [GO](https://go.microsoft.com/fwlink/?linkid=2099773)               | Provides rich PowerShell language support for Azure Data Studio                                                                                         |
| [SandDance for Azure Data Studio]     | [Github][7]     | 2020-06-24   | 3.0.0    | [Vsix](https://github.com/microsoft/SandDance/releases/latest)      | Provides interactive visualizations that help users explore, understand, and present their data                                                         |
| [SandDance for VSCode][8]             | [Github][7]     | 2020-06-24   | 3.0.0    | [Vsix][8]                                                           | Provides interactive visualizations that help users explore, understand, and present their data for `.csv` or `.tsv` files                              |
| [Server Reports][1]                   | [Github][1]     | 2020-04-27   | 0.2.2    | [GO][https://go.microsoft.com/fwlink/?linkid=2099768]               | Provides useful information about the server's performance, such as: DB Space Usage, DB Buffer Usage, CPU Utilization, Backup Growth Trend              |
| [whoisactive][1]                      | [Github][1]     | 2020-04-27   | 0.1.4    | [GO][https://go.microsoft.com/fwlink/?linkid=2099774]               | Displays insights from sp_whoisactive, a useful tool for activity monitoring and troubleshooting, as graphs and tasks inside an Azure Data Studio       |
| [SQL Database Projects extension]     | [Github][1]     | 2020-04-27   | 0.3.0    | [GO][https://go.microsoft.com/fwlink/?linkid=2143820]               | Extension for developing SQL databases in a project-based development environment                                                                       |


## Azure Data Studio Articles

| Title                                                      | Author                                   | Modified   |
|------------------------------------------------------------|------------------------------------------|------------|
| [Integrating Azure Data Studio with Git and GitHub]        | Rajendra Gupta                           | 2020-07-03 |
| [Working with Git components in Azure Data Studio]         | Rajendra Gupta                           | 2020-07-09 |

[1]:https://github.com/Microsoft/azuredatastudio
[2]:https://github.com/microsoft/azuredatastudio-postgresql
[3]:https://github.com/dzsquared/query-editor-boost/
[4]:https://github.com/dzsquared/query-editor-boost/releases/latest
[5]:https://github.com/microsoft/azuredatastudio-postgresql
[6]:https://github.com/PowerShell/vscode-powershell/
[7]:https://github.com/Microsoft/SandDance
[8]:https://marketplace.visualstudio.com/items?itemName=msrvida.vscode-sanddance
[`.dacpac`]:https://docs.microsoft.com/en-us/sql/relational-databases/data-tier-applications/data-tier-applications

[SQL Server Import]:https://docs.microsoft.com/en-us/sql/azure-data-studio/sql-server-import-extension
[PostgreSQL extension (preview)]:https://docs.microsoft.com/en-us/sql/azure-data-studio/postgres-extension
[SQL Server Dacpac]:https://docs.microsoft.com/en-us/sql/azure-data-studio/sql-server-dacpac-extension
[SQL Server Profiler]:https://docs.microsoft.com/en-us/sql/azure-data-studio/sql-server-profiler-extension
[SQL Server Agent]:https://docs.microsoft.com/en-us/sql/azure-data-studio/sql-server-agent-extension
[SQL Server Compare]:https://docs.microsoft.com/en-us/sql/azure-data-studio/schema-compare-extension
[PowerShell Extension]:https://docs.microsoft.com/en-us/sql/azure-data-studio/powershell-extension
[SandDance for Azure Data Studio]:https://docs.microsoft.com/en-us/sql/azure-data-studio/sanddance-extension
[SQL Database Projects extension]:https://docs.microsoft.com/en-gb/sql/azure-data-studio/extensions/sql-database-project-extension

[Integrating Azure Data Studio with Git and GitHub]:https://www.sqlshack.com/integrating-azure-data-studio-with-git-and-github/
[Working with Git components in Azure Data Studio]:https://www.sqlshack.com/working-with-git-components-in-azure-data-studio/


### TODO Links

- https://github.com/microsoft/azuredatastudio/issues/2752#issuecomment-487315692
