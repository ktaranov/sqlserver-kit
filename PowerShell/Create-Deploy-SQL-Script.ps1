#requires -version 4
# https://www.red-gate.com/simple-talk/sql/database-delivery/how-to-build-and-deploy-a-database-from-object-level-source-in-a-vcs/
<# this script uses powershell v4. It will need a bit of work if you are stuck on previous versions of PowerShell. #>
$Server = 'SAM_540_TAR' #the name of the server
$Instance = 'MSSQLSERVER'            #The server instance
$Database = 'NIIGAZ'     #the database
#this is the directory where you wish to place your scripts and from which they will be executed
$DatabaseScriptPath = "$($env:HOMEDRIVE)$($env:HOMEPATH)\Documents\$($Database)"
#in case you wish debug information
$WarningPreference='Stop' #because if it can't connect to the database, you only get a warning
$VerbosePreference = "SilentlyContinue"
 
$DoWeLookForParentObjects = $true #don't change this!
$SMO = 'Microsoft.SqlServer.Management.SMO'
#read in the SQLPS module if it isn't in already
import-module 'sqlps' -DisableNameChecking
 
trap {
      Write-Error ('Failed to access "{0}" : {1} in "{2}"' -f "$server/$instance", `
      $_.Exception.Message, $_.InvocationInfo.ScriptName)
      exit
    }
<# SMO likes to do build scripts in ObjectType order in a build script. The script starts with Database properties, followed by Schemas, XML Schema Collections and Types: none of which can have dependent objects. 
Table Types and Procedures come next. Then, in dependency order, Functions, Tables and Views. Then come Clustered indexes, non-clustered indexes, Primary XML Indexes, XML indexes, Default Constraints, Foreign keys Check constraints, triggers and lastly, extended properties.
Here we define their order, but this order may need tweaking
#>
$ObjectTypeOrder = @{
    'users' = 1;
    'Roles' = 2;
    'Schemas' = 3;
    'Assemblies' = 4;
    'AsymmetricKeys' = 5;
    'Certificates' = 6;
    'XmlSchemaCollections' = 7;
    'FileGroups' = 8;
    'FullTextCatalogs' = 9;
    'FullTextStopLists' = 10;
    'LogFiles' = 11;
    'PartitionFunctions' = 12;
    'PartitionSchemes' = 13;
    'PlanGuides' = 14;
    'UserDefinedTypes' = 15;
    'UserDefinedDataTypes' = 16;
    'UserDefinedTableTypes' = 17;
    'UserDefinedAggregates' = 18;
    'ApplicationRoles' = 19;
    'Rules' = 20;
    'Defaults' = 21;
    'Tables' = 22;
    'StoredProcedures' = 23;
    'UserDefinedFunctions' = 24;
    'Views' = 25;
    'DatabaseAuditSpecifications' = 26;
    'SearchPropertyLists' = 27;
    'Sequences' = 28;
    'ServiceBroker' = 29;
    'SymmetricKeys' = 30;
    'Triggers' = 31;
    'Synonyms' = 32;
    'ExtendedStoredProcedures' = 33;
    'ExtendedProperties' = 34;
}
# first we access the server using the PSPath
$Srv = get-item "SQLSERVER:\SQL\$Server\$Instance"
#now we create all our lists of objects, using the SMO URNS to represent the object
$urnCollection = new-object "$SMO.UrnCollection" #the objects that need sorting.
$OrderedURNCollection = new-object "$SMO.UrnCollection" #list in the correct order
$PostTableurnCollection = new-object "$SMO.UrnCollection" #tail of the list
#we now determine the types we don't want to retrieve. This is complicated by a bug in SMO where the SMO doesnt check the version of the target server before asking for a type collection it doesn't know about.
$TypesWeDontWant = '(?im)Roles|Federations'
$pathsWritten=[array] @()
if ([int]$srv.version.Major -gt 10) { $TypesWeDontWant = '(?im)Roles' }
# first we access the database in order to get the object types. we get all except for the ones on our blacklist ' $TypesWeDontWant'
Set-location "SQLSERVER:\SQL\$Server\$Instance\databases\$Database"
Get-ChildItem | where-object{ "$($_.PSChildName))" -notmatch $TypesWeDontWant } |
<#and now we sort them in object-dependency order so that the list of objects to script is in the order in which one would want to script them #>
Select-Object `
@{ E = { $ObjectTypeOrder."$_" }; N = "BuildOrder" },
@{ E = { $_ }; N = "ObjectType" } | sort-object BuildOrder -PipelineVariable CurrentSQLObject |
# then we get all the objects of each type in turn if there are any!
foreach { if (test-Path "$($_.ObjectType.PSPath)") { Get-Childitem "$($_.ObjectType.PSPath)" } } |
#get subtypes if necessary (stuff like service broker objects)
foreach  {
    if ($_.GetType().BaseType -notlike '*smo*') { Get-Childitem "$($_.PSPath)" }
    else { $_ }
} |
#and we check if the object is scriptable,
where { ($_.PSobject.Members.name -match "script") -and ($_.Name -notmatch '(?im)AutoCreatedLocal') } |
Foreach{
    $urn = $_.urn
    if ($CurrentSQLObject.BuildOrder -lt 21) { $OrderedURNCollection.add($urn) }
    elseif ($CurrentSQLObject.BuildOrder -lt 26) { $urnCollection.add($urn) }
    else { $PostTableurnCollection.add($urn) }
}
 <# discovering dependencies only works for a limited subset of objects; Views, Stored Procedures, Tables and User Defined Functions, #>
 
#now  we set up the scripter object just to do the dependency sorting
$scr = New-Object "$SMO.Scripter"
#now choose options for the scripter that we need to get dependency order
$options = New-Object "$SMO.ScriptingOptions"
$options.DriAll = $False
$options.AllowSystemObjects = $false
$options.WithDependencies = $False
$scr.Options = $options
$scr.Server = $srv
 
#we create a dependency walker object
$DependencyWalker = new-object ("$SMO.DependencyWalker")
#    
#now we set up an event listnenr go get progress reports
$ProgressReportEventHandler = [Microsoft.SqlServer.Management.Smo.ProgressReportEventHandler] { Write-Verbose "analysed '$($_.Current.GetAttribute('Name'))'" }
$scr.add_DiscoveryProgress($ProgressReportEventHandler)
#create the dependency tree
$dependencyTree = $scr.DiscoverDependencies($urnCollection, $DoWeLookForParentObjects) #look for the parent objects for each object
#and walk the dependencies to get the dependency tree.
$depCollection = $scr.WalkDependencies($dependencyTree);
#we just extract the root nodes and add them to the ordered list
$Depcollection | where { $_.IsRootNode -ne 0 } | foreach{ $OrderedURNCollection.Add($_.urn) }
#now we add the tail of the ordered list to the end
$PostTableURNCollection | foreach{ $OrderedURNCollection.Add($_) }
 
 
<#now set up the scripting options that you wish. This affects the code that we script out. you need to adjust this to taste. #>
$ScrOptions = new-object ("$SMO.ScriptingOptions") #create the 'options' object
$ScrOptions.ExtendedProperties = $true # yes we want these
$ScrOptions.IncludeIfNotExists = $false # only build if not already there
$ScrOptions.IncludeHeaders = $false # e.g. Object:  Table xxx  Script Date: xxx Date is picked up as a change */
$ScrOptions.ToFileOnly = $true #do not echo as a string
$ScrOptions.DRIAll = $true # and all the constraints with the tables 
$ScrOptions.AllowSystemObjects = $false # not these
$ScrOptions.Indexes = $true # Yup, these would be nice to include with the table
$ScrOptions.Triggers = $true # This should be included when scripting a table
$ScrOptions.ScriptBatchTerminator = $true # this only goes to the file
$ScrOptions.Encoding = [System.Text.Encoding]::UTF8 # otherwise git can't understand it
 
# we now create the script directory if it doesn't already exist
if (!(Test-Path -path $DatabaseScriptPath))
{
    Try { New-Item $DatabaseScriptPath -type directory | out-null }
    Catch [system.exception]{
        Write-Error "error while creating the '$DatabaseScriptPath' dirctory"
        return
    }
}
<# we now create the start of our SQLCMD script (think of it as a type of manifest file) to execute all these scripts in the right order #>
$SQLCMDBuildScript=@"
/**
summary:   >
  This is a SQLCMD file that can be executed in SSMS if you are in SQLCMD mode, or you
  can use the SQLCMD command-line utility
Author: Phil Factor
Revision: 1.5
date: $(get-date)
example: sqlcmd -S $server\$instance -d $($Database)Copy -i $($DatabaseScriptPath)\DatabaseBuildScript.SQL -o $($DatabaseScriptPath)\output.txt
   
**/       
 
SET NOCOUNT ON
GO
PRINT 'Creating the database objects in order'
 
 
"@
#for each object in our ordered list of objects represented by URNs 
$OrderedURNCollection | Foreach{
    # work out the full file path where we want to save each file
    $fullPath = "$DatabaseScriptPath\$($_.Type)"
    $filename = "$(if ($_.GetAttribute('Schema') -ne $null)
    { $($_.GetAttribute('Schema') -replace '[\n\r\\\/\:\.]', '-') + '.' }
    else { '' })$($_.GetAttribute('Name') -replace '[\n\r\\\/\:\.]', '-')_Build.sql"
    # create the file path if it doesn't exist
    if (!(Test-Path -path "$fullPath"))
    {
        Try { New-Item "$fullPath" -type directory | out-null }
        Catch [system.exception]{
            Write-Error "error while creating the "$fullPath" directory"
            return
        }
    }
    $ScrOptions.Filename = "$($fullpath)\$($filename)"; #tell the scripter object where to write the file
    $srv.GetSmoObject($_).script($ScrOptions); #and script the object
$SQLCMDBuildScript+=@"
 
    PRINT 'creating the $($_.Type) $($_.GetAttribute('Name'))' 
    go
    :r $($fullpath)\$($filename)
    :On Error exit
"@ #and write the lines into the contents of the Manifest file
   $PathsWritten+="$($fullpath)\$($filename)"
   
}
$SQLCMDBuildScript+=@"
 
PRINT 'Database creation is now complete'
GO
"@ #now finish off the file. By using the .NET class we write in UTF8
 
[System.IO.File]::WriteAllLines("$DatabaseScriptPath\DatabaseBuildScript.SQL", $SQLCMDBuildScript)
<# now we need to delete the files that don't represent current objects in the database so that all 
dropped objects are dropped in source control #>
$PathsWritten+="$DatabaseScriptPath\DatabaseBuildScript.SQL" #to avoid getting this deleted
<# now delete anything else #>
$DeletedCount=0
Get-ChildItem -path $DatabaseScriptPath -include '*.sql' -recurse |
  where {$Pathswritten -notcontains $_.fullname} | Remove-Item |foreach{$DeletedCount+=1}
if ($DeletedCount -gt 0) {Write-Verbose "deleted $DeletedCount file((if $DeletedCount -gt 1){'s'} else {''})"}
"Did I do well?"
