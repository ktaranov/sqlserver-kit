# SQL Server Online Filegroup Migration for Powershell
# Author: Bob Pusateri, http://www.bobpusateri.com
# Date: March 2013
# 
# This script is provided "as is" without warranty of any kind,
#  either expressed or implied. It is the user's reponsibility
#  to read and understand this code before executing on any
#  system. Always test in a development environment!!


# REQUIRED FIELDS
$serverName = "ServerName"; # name of the instance
$dbName = "DBName"; # name of the database
$sourceFG = "SourceFG"; # filegroup you're moving objects out of
$destFG = "DestFG"; # filegroup you're moving objects into
$logPath = "C:\path\to\fg_move_logs"; # all queries are logged to this folder so you have record of what was run

# FILTERS - if these are non-null only the objects that match will be migrated
$schemaFilter = $null; # can be $null, a literal "tablename" or a LIKE "%foo%"
$nameFilter = $null; # can be $null, a literal "tablename" or a LIKE "%foo%"
$minSizeFilter = $null; # can be $null or size in MB
$maxSizeFilter = $null; # can be $null or size in MB

# If an individual query exceeds this timeout value it will be cancelled
$queryTimeoutSeconds = 21600; # 6 hours

$runQueries = "n"; 	# "y" will execute the queries. 
					#"n" will print to screen & log but not execute

$ErrorActionPreference = 'Stop';
$dtStart = Get-Date;

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SMO") | Out-Null;

# this just helps for printing errors to console
Function PrintUpdate($str, $printToScreen) {
	$s = (Get-Date -format HH:mm:ss) + " $str";
	if($printToScreen) {
		if($host.Name -eq "ConsoleHost") {
			Write-Host $s;
		} else { # no host is present in SQL Agent
			Write-Output $s;
		}
	}
	$s | out-file -filepath $logFile -append;
}

# gets the columns that make up an index.
Function GetIndexColumns($idx, $includedColumns) {
	$colStr = "";
	foreach($ic in $idx.IndexedColumns) {
		if($ic.IsIncluded -eq $includedColumns) {
			$colStr += "[" + $ic.Name + "]";
			if($ic.Descending -eq $true) {
				$colStr += " DESC"
			}
			$colStr += ", ";
		} #if
	} # foreach
	if ($colStr.length -gt 0) {
		return $colStr.Substring(0, $colStr.length-2);
	} else {
		return $colStr;
	}
} # GetIndexColumns

Function RunSQLQuery($queryStr) {
	try {
		PrintUpdate $queryStr $false;
		if($runQueries -eq "y") {
			$a = Invoke-Sqlcmd -ServerInstance $serverName -database $dbName -query $queryStr -OutputSQLErrors $true -QueryTimeout $queryTimeoutSeconds;
			return $a;
		}
	} catch {
		PrintUpdate $_ $true;
	}
} # RunSQLQuery

$server = New-Object Microsoft.SqlServer.Management.Smo.Server($serverName);

if (!(Test-Path $logPath)) {
	New-Item $logPath -Type Directory
}

$logFile = "$logPath\" + (Get-Date -UFormat %Y%m%d_%H%M%S) + ".log";

if ($server.Edition -eq $null) {
	throw "Cannot connect to server $serverName.";
}

if(!$server.Edition.ToLower().Contains("enterprise") -and !$server.Edition.ToLower().Contains("developer")) {
	throw "You need enterprise or developer edition to do online index operations";
}

$db = $server.Databases[$dbName];

if ($db -eq $null) {
	throw "Database [$dbName] does not exist.";
}

if ($db.FileGroups[$sourceFG] -eq $null) {
	throw "Source filegroup [$sourceFG] does not exist.";
} 

if ($db.FileGroups[$destFG] -eq $null) {
	throw "Source filegroup [$destFG] does not exist.";
}

# get all indexes in source FG satisfying schema & name filters
$qry = "SELECT s.name AS SchemaName,
	o.name AS ObjName,
	o.object_id AS ObjID,
	p.index_id AS IndexID, 
	i.name AS IdxName,
	i.is_unique AS IsUnique,
	ROUND(CAST(au.data_pages AS FLOAT)/128,2) AS Size_MB,
	f.name AS DataFilegroup,
	f2.name AS LOBFilegroup
FROM sys.allocation_units au WITH (NOLOCK)
    JOIN sys.partitions p WITH (NOLOCK) ON au.container_id = p.partition_id
    JOIN sys.objects o WITH (NOLOCK) ON p.object_id = o.object_id
    JOIN sys.indexes i WITH (NOLOCK) ON p.index_id = i.index_id AND i.object_id = p.object_id
    JOIN sys.schemas s WITH (NOLOCK) ON o.schema_id = s.schema_id
    LEFT JOIN sys.tables t WITH (NOLOCK) ON o.object_id = t.object_id
    LEFT JOIN sys.filegroups f WITH (NOLOCK) ON au.data_space_id = f.data_space_id
    LEFT JOIN sys.filegroups f2 WITH (NOLOCK) ON t.lob_data_space_id = f2.data_space_id
WHERE au.[type] = 1
	AND i.[type] <= 2 -- heap, clustered, nonclustered
	AND (f.[name] = '$sourceFG' OR f2.[name] = '$sourceFG')";
	
if ($schemaFilter -ne $null) {
	$qry += "`n`tAND s.name LIKE '$schemaFilter'";
}

if ($nameFilter -ne $null) {
	$qry += "`n`tAND o.name LIKE '$nameFilter'";
}

if ($minSizeFilter -ne $null) {
	$qry += "`n`tAND au.data_pages > " + ($minSizeFilter * 128);
}

if ($maxSizeFilter -ne $null) {
	$qry += "`n`tAND au.data_pages <= " + ($maxSizeFilter * 128);
}

$qry += "`nORDER BY SchemaName, ObjName, p.index_id;";

$idxList = Invoke-Sqlcmd -ServerInstance $serverName -database $dbName -query $qry

$totalSize = 0;
$migratedSize = 0;
$foreachIndex = 0;
$foreachSize = $idxList.Length;

#iterate through each index
foreach ($i in $idxList | sort Size_MB,SchemaName,ObjName) {
	$sn = $i.SchemaName;
	$on = $i.ObjName;
	$iid = $i.IndexID;
	$in = $i.IdxName;
	$sz = $i.Size_MB;
	$oid = $i.ObjID;
	$online = "ON";
	
	$foreachIndex += 1;
	$totalSize += $sz;
	
	PrintUpdate "[$foreachIndex / $foreachSize] Moving $sn.$on ($iid) [$sz MB]" $true;
	# does index contain datatypes that prohibit online operations?
	#if($online = "ON") {
		if($iid -le 1) {
			# if indexID = 0 then look in sys.columns
			$qry = "SELECT COUNT(c.OBJECT_ID) AS n
					FROM sys.columns c
					INNER JOIN sys.objects o ON c.object_id = o.object_id
					INNER JOIN sys.schemas s ON o.schema_id = s.schema_id
					INNER JOIN sys.types t ON c.user_type_id = t.user_type_id
					WHERE s.name = '$sn'
						AND o.name = '$on'
						AND (
							t.name IN ('text','ntext','image','xml')
							OR (
								t.name IN ('varchar','nvarchar','varbinary')
								AND
								t.max_length = -1
								)
							);";
		} else {
			# else look in sys.index_columns
			$qry = "SELECT COUNT(ic.object_id) AS n
					FROM sys.index_columns ic
					INNER JOIN sys.objects o ON ic.object_id = o.object_id
					INNER JOIN sys.schemas s ON o.schema_id = s.schema_id
					INNER JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
					INNER JOIN sys.types t ON c.user_type_id = t.user_type_id
					WHERE s.name = '$sn'
						AND o.name = '$on'
						AND ic.index_id = $iid
						AND (
							t.name IN ('text','ntext','image','xml')
							OR (
								t.name IN ('varchar','nvarchar','varbinary')
								AND
								t.max_length = -1
								)
							);";	
		}
		
		try {
			$rs = Invoke-Sqlcmd -ServerInstance $serverName -database $dbName -query $qry;
			if($rs[0] -gt 0) {
				$online = "OFF";
			}
		} catch {
			$online = "OFF";
		}
	#}
	
	# if lob filegroup needs to change re-create and swap
	if(![System.DBNULL]::Value.Equals($i.LOBFilegroup) -and $i.LOBFilegroup -ne $destFG -and $iid -le 1) {
		# skipping because we're not doing offline operations
		PrintUpdate "  Skipping - LOB filegroup prevents online operations" $true;
		continue;
	} # 
	
	# if index = 0 then create CL, move, delete CL
	if($iid -eq 0) {
		if($online -eq "OFF") {
			# skipping because it can't be done online
			PrintUpdate "  Skipping - column(s) prevents online operations" $true;
			continue;
		}
		
		# disable all NC indexes
		$tbl = $db.Tables.Item($on, $sn);
		PrintUpdate "  Disabling nonclustered indexes" $true;
		foreach($ix in $tbl.Indexes | where {$_.ID -gt 1}) {
			$j = $ix.ID;
			PrintUpdate "    Disabling index $j" $true;
			if($runQueries -eq "y") {
				$ix.Disable();
				$ix.Refresh();
			}
		} # foreach
		
		# create clustered index on first column, rebuild CL on new filegroup, drop CL and return to heap
		$qry = "SELECT QUOTENAME([name]) AS n FROM sys.columns WHERE object_id = $oid AND column_id = 1";
		$firstCol = Invoke-Sqlcmd -ServerInstance $serverName -database $dbName -query $qry;
		
		$qry = "CREATE CLUSTERED INDEX CL_Blah ON [$sn].[$on] (" + $firstCol.n + ") `nWITH(ONLINE=$online) ON [$destFG];";
		$qry += "`nDROP INDEX CL_Blah ON [$sn].[$on];";
		#Write-Host $qry;
		PrintUpdate "  Moving heap" $true;
		RunSQLQuery($qry);
		$migratedSize += $sz;
		
		# rebuild all NC indexes on new filegroup
		PrintUpdate "  Re-enabling nonclustered indexes" $true;
		foreach($ix in $tbl.Indexes | where {$_.ID -gt 1}) {
			$j = $ix.ID;
			PrintUpdate "    Rebuilding index $j" $true;
			$ix.FileGroup = $destFG;
			if($runQueries -eq "y") {
				$ix.Recreate();
				$ix.Refresh();
			}
			$migratedSize += ($ix.SpaceUsed/1MB);
		} # foreach

	} elseif($iid -ge 1) { #clustered index
		if(![System.DBNULL]::Value.Equals($i.LOBFilegroup) -and $i.LOBFilegroup -ne $destFG) {
			# if the LOB filegroup needs to change, it can't be done here
			# the table needs to be dropped and everything recreated
			PrintUpdate "  Skipping - LOB filegroup prevents online operations" $true;
			continue;
		}
		
		if($online -eq "OFF") {
			# skipping because it can't be done online
			PrintUpdate "  Skipping - column(s) prevents online operations" $true;
			continue;
		}
	
		$tbl = $db.Tables.Item($on, $sn);
		
		# if index is on a heap, skip because all NC indexes on heaps will be rebuilt when the heap is moved
		if(!$tbl.HasClusteredIndex) {
			PrintUpdate "  Skipping because index is on a heap" $true;
			continue;
		}
		
		$idx = $tbl.Indexes[$in];
		
		$scr = "CREATE ";
		if($idx.IsUnique -eq $true) {$scr += "UNIQUE ";}
		if($idx.IsClustered -eq $true) {$scr += "CLUSTERED ";}
		$scr += "INDEX [$in] ON [$sn].[$on](";
		$scr += GetIndexColumns $idx $false;
		$scr += ") ";
		if((GetIndexColumns $idx $true) -ne "") {
			$scr += "`nINCLUDE (";
			$scr += GetIndexColumns $idx $true;
			$scr += ") ";
		}
		if($idx.FilterDefinition -ne "") {
			$scr += "`nWHERE ";
			$scr += $idx.FilterDefinition;
			$scr += " ";
		}
		$scr += "`nWITH (DROP_EXISTING=ON, ONLINE=$online, SORT_IN_TEMPDB=";
		if($sz -lt 25000) {
			$scr += "ON, "
		} else {
			$scr += "OFF, "
		}
		#add partition compression support later
		$scr += "DATA_COMPRESSION=";
		$scr += $idx.PhysicalPartitions[0].DataCompression;
		$scr += ") `nON [$destFG];";
		
		RunSQLQuery($scr);
		$migratedSize += $sz;
	
	} 

} #foreach

Write-Host "Made it to end";
Write-Host "Total Size: $totalSize MB";
Write-Host "Migrated Size: $migratedSize MB";

$runDuration = New-TimeSpan $dtStart (Get-Date);
$hrs = $runDuration.Hours;
$mins = $runDuration.Minutes;
$secs = $runDuration.Seconds;
write-host "Completed in $hrs hours $mins minutes $secs seconds";

