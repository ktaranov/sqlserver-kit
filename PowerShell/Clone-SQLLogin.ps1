<#
.Synopsis
  Clone a SQL Server Login based on another exsiting login.

.DESCRIPTION
  Clone a SQL Server Login based on another exsiting login on one or multiple servers and the process can generate a script for auditing purpose.

.EXAMPLE
  The following command scripts out the permissions of login account [John] and generates the script at "c:\temp\clone.sql"
  Notice, parameters [OldLogin] and [NewLogin] uses the same value of "John"
  Clone-SQLLogin -Server Server1, Server2 -OldLogin John -NewLogin John -FilePath "c:\temp\clone.sql"
 
.EXAMPLE
  The following command exports a script that can be used to clone login account [John] for new login account [David], and the script is created at "c:\temp\clone.sql"
  also the -Execute parameter means the new account "David" will be created
  Clone-SQLLogin -Server Server1, Server2 -OldLogin John -NewLogin David -NewPassword 'P@$$W0rd' -FilePath "c:\temp\clone.sql" -Execute;

.Parameter ServerInstance
  ServerInstance is of string array datat ype, and can accept a string of sql instance names, spearated by comma. (mandatory)

.Parameter OldLogin
  The login account is the source where all the permissions will be scripted out and to be used for the NewLogin account (mandatory)

.Parameter NewLogin
  The login account is the target account that we want to clone (mandatory)

.Parameter NewPassword
   The password for the new login account if we want to create the login, default to empty string "" (optional)

.Parameter FilePath
  The full path name for the generated sql script (optional)
 
.Parameter Execute
  This is a swich parameter, if present, it means we need to create the NewLogin account.

.OUTPUTS
  none

.NOTES
  A few service broker related permissions are not covered in this version 1.
  Original link: https://www.mssqltips.com/sqlservertip/4572/cloning-a-sql-server-login-with-all-permissions-using-powershell/
  Author: Jeffrey Yao
#>
#requires -version 3.0
add-type -assembly  "Microsoft.SqlServer.Smo, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91";  #if Version-11.xx means sql server 2012

function Clone-SQLLogin
{
    [CmdletBinding(SupportsShouldProcess=$true)]
    
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                    Position=0)]
        [string[]] $ServerInstance,
 
        [Parameter(Mandatory=$true)]
        [string] $OldLogin,
 
        [Parameter(Mandatory=$true)]
        [string] $NewLogin,
 
        [string] $NewPassword="",
 
        [string] $FilePath="",
        [switch] $Execute
    )
 
    Begin
    {
        [string]$newUser=$newLogin.Substring($newLogin.IndexOf('\')+1); # if $newLogin is a Windows account, such as domain\username, since "\" is invalid in db user name, we need to remove it
 
        [hashtable[]] $hta = @(); # a hashtable array
        [hashtable] $h = @{};
  
        
        if ( ($FilePath -ne "") -and  (test-path -Path $FilePath))
        { del -Path $filepath; }
    }
    Process
    {
 
        foreach ($sqlinstance in $ServerInstance)
        {
 
           $svr = new-object "Microsoft.SqlServer.Management.Smo.Server" $sqlinstance;
           if ($svr.Edition -eq $null) 
           {
                Write-warning "$sqlinstance cannot be connected";
                continue;
            }
 
            [string]$str = "";
 
            if (-not $WindowsLogin)
            {
                $str += "create login $($newLogin) with password='$($newPassword)'; `r`n"
            }
            else
            {
                $str += "create login $($newLogin) from windows;`r`n "
            }
 
            #find role membership for $login
            if ($svr.logins[$OldLogin] -ne $null)
            { $svr.logins[$oldLogin].ListMembers() | % {$str += "exec sp_addsrvrolemember @loginame = '$($newLogin)', @rolename = '$($_)'; `r`n"};}
            else
            { Write-warning "$oldLogin does not exist on server [$($svr.name)] so this sql instance is skipped"; continue; }
 
            # find permission granted to $login
 
 
            $svr.EnumObjectPermissions($oldLogin)  | % { if ($_.PermissionState -eq 'GrantWithGrant') 
                                                                {$str += "GRANT $($_.PermissionType) on $($_.ObjectClass)::[$($_.ObjectName)] to [$newLogin] WITH GRANT OPTION; `r`n"}
                                                                else
                                                                { $str += "$($_.PermissionState) $($_.PermissionType) on $($_.ObjectClass)::[$($_.ObjectName)] to [$newLogin]; `r`n"} }
                                           
            $svr.EnumServerPermissions($oldLogin)  | % { if ($_.PermissionState -eq 'GrantWithGrant') 
                                                                { $str += "GRANT $($_.PermissionType) to [$newLogin] WITH GRANT OPTION; `r`n"}
                                                                else
                                                                { $str += "$($_.PermissionState) $($_.PermissionType) to [$newLogin]; `r`n" } }
 
            $h = @{Server=$sqlinstance; DBName = 'master'; sqlcmd = $str}; 
            $hta += $h;
            #$str;
 
 
            $ObjPerms = @(); # store login mapped users in each db on $svr
            $Roles = @();
            $DBPerms = @();
            foreach ($itm in $svr.logins[$oldLogin].EnumDatabaseMappings())
            {
                if ($svr.Databases[$itm.DBName].Status -ne 'Normal')
                { continue;}
 
                if ($svr.Databases[$itm.DBName].Users[$newUser] -eq $null)
                { $hta += @{Server=$sqlinstance; DBName = $itm.DBName; sqlcmd = "create user [$newUser] for login [$newLogin];`r`n" }; }
 
                $r = $svr.Databases[$itm.DBName].Users[$itm.UserName].EnumRoles();
                if ($r -ne $null)
                { 
                    $r | % { $hta += @{Server=$sqlinstance; DBName = $itm.DBName; sqlcmd = "exec sp_addrolemember @rolename='$_', @memberName='$($newUser)';`r`n" } }
                }
 
 
                $p = $svr.Databases[$itm.DBName].EnumDatabasePermissions($itm.UserName);
                if ($p -ne $null)
                { $ObjPerms += @{DBName=$itm.DBName; Permission=$p};}
 
                $p = $svr.Databases[$itm.DBName].EnumObjectPermissions($itm.UserName)
                if ($p -ne $null)
                { $ObjPerms += @{DBName=$itm.DBName; Permission=$p}; }
 
                $p = $svr.Databases[$itm.DBName].Certificates | % {$_.EnumObjectPermissions($itm.UserName)} 
                if ($p -ne $null)
                { $ObjPerms += @{DBName=$itm.DBName; Permission=$p};}
 
                #AsymmetricKeys 
                $p = $svr.Databases[$itm.DBName].AsymmetricKeys | % {$_.EnumObjectPermissions($itm.UserName)} 
                if ($p -ne $null)
                { $ObjPerms += @{DBName=$itm.DBName; Permission=$p}; }
 
                #SymmetricKeys 
                $p = $svr.Databases[$itm.DBName].SymmetricKeys | % {$_.EnumObjectPermissions($itm.UserName)} 
                if ($p -ne $null)
                { $ObjPerms += @{DBName=$itm.DBName; Permission=$p};}
 
                #XMLSchemaCollections
                $p = $svr.Databases[$itm.DBName].XMLSchemaCollections | % {$_.EnumObjectPermissions($itm.UserName)} 
                if ($p -ne $null)
                { $ObjPerms += @{DBName=$itm.DBName; Permission=$p};}

                #service broker components
                $p = $svr.Databases[$itm.DBName].ServiceBroker.MessageTypes | % {$_.EnumObjectPermissions($itm.UserName)} 
                if ($p -ne $null)
                { $ObjPerms += @{DBName=$itm.DBName; Permission=$p};}

                $p = $svr.Databases[$itm.DBName].ServiceBroker.Routes | % {$_.EnumObjectPermissions($itm.UserName)} 
                if ($p -ne $null)
                { $ObjPerms += @{DBName=$itm.DBName; Permission=$p};}

                $p = $svr.Databases[$itm.DBName].ServiceBroker.ServiceContracts | % {$_.EnumObjectPermissions($itm.UserName)} 
                if ($p -ne $null)
                { $ObjPerms += @{DBName=$itm.DBName; Permission=$p};}

                $p = $svr.Databases[$itm.DBName].ServiceBroker.Services | % {$_.EnumObjectPermissions($itm.UserName)} 
                if ($p -ne $null)
                { $ObjPerms += @{DBName=$itm.DBName; Permission=$p};}

                #Full text
                $p = $svr.Databases[$itm.DBName].FullTextCatalogs | % {$_.EnumObjectPermissions($itm.UserName)} 
                if ($p -ne $null)
                { $ObjPerms += @{DBName=$itm.DBName; Permission=$p};}

                $p = $svr.Databases[$itm.DBName].FullTextStopLists | % {$_.EnumObjectPermissions($itm.UserName)} 
                if ($p -ne $null)
                { $ObjPerms += @{DBName=$itm.DBName; Permission=$p};}                
            }
 
 
            #generate t-sql to apply permission using SMO only 
            #[string]$str = ([System.String]::Empty)
            foreach ($pr in $ObjPerms)
            {
   
                $h = @{Server=$sqlinstance; DBName=$($pr.DBName); sqlcmd=""};
                $str = "" #"use $($pr.DBName) `r`n"
                foreach ($p in $pr.Permission)
                {
                    [string]$op_state = $p.PermissionState;

                    if ($p.ObjectClass -ne "ObjectOrColumn")
                    {   
                        [string] $schema = "";

                        if ($p.ObjectSchema -ne $null)
                        { $schema = "$($p.ObjectSchema)."}
 
                        [string]$option = "";

                        if ($op_state -eq "GRANTwithGrant")
                        {
                            $op_state = 'GRANT';
                            $option = ' WITH GRANT OPTION';
                        }
        
       
                        Switch ($p.ObjectClass) 
                        {  
                            'Database'         { $str += "$op_state $($p.PermissionType) to [$newUser]$option;`r`n";} 
                            'SqlAssembly'      { $str += "$op_state $($p.PermissionType) ON Assembly::$($schema)$($p.ObjectName) to [$newUser]$option;`r`n";}
                            'Schema'           { $str += "$op_state $($p.PermissionType) ON SCHEMA::$($schema)$($p.ObjectName) to [$newUser]$option;`r`n";}
                            'UserDefinedType'  { $str += "$op_state $($p.PermissionType) ON TYPE::$($schema)$($p.ObjectName) to [$newUser]$option;`r`n";}
                            'AsymmetricKey'    { $str += "$op_state $($p.PermissionType) ON ASYMMETRIC KEY::$($schema)$($p.ObjectName) to [$newUser]$option;`r`n";}
                            'SymmetricKey'     { $str += "$op_state $($p.PermissionType) ON SYMMETRIC KEY::$($schema)$($p.ObjectName) to [$newUser]$option;`r`n";}
                            'Certificate'      { $str += "$op_state $($p.PermissionType) ON Certificate::$($schema)$($p.ObjectName) to [$newUser]$option`r`n";}
                            'XmlNamespace'     { $str += "$op_state $($p.PermissionType) ON XML SCHEMA COLLECTION::$($schema)$($p.ObjectName) to [$newUser]$option`r`n";}
                            'FullTextCatalog'  { $str += "$op_state $($p.PermissionType) ON FullText Catalog::$($schema)[$($p.ObjectName)] to [$newUser]$option`r`n";}
                            'FullTextStopList' { $str += "$op_state $($p.PermissionType) ON FullText Stoplist::$($schema)[$($p.ObjectName)] to [$newUser]$option`r`n";}
                            'MessageType'      { $str += "$op_state $($p.PermissionType) ON Message Type::$($schema)[$($p.ObjectName)] to [$newUser]$option`r`n";}
                            'ServiceContract'  { $str += "$op_state $($p.PermissionType) ON Contract::$($schema)[$($p.ObjectName)] to [$newUser]$option`r`n";}
                            'ServiceRoute'     { $str += "$op_state $($p.PermissionType) ON Route::$($schema)[$($p.ObjectName)] to [$newUser]$option`r`n";}
                            'Service'          { $str += "$op_state $($p.PermissionType) ON Service::$($schema)[$($p.ObjectName)] to [$newUser]$option`r`n";}
                        #you can add other stuff like Available Group etc in this switch block as well
                        }#switch
      
                    }
                    else
                    {  
                        [string]$col = "" #if grant is on column level, we need to capture it
                        if ($p.ColumnName -ne $null)
                        { $col = "($($p.ColumnName))"};
 
                        $str += "$op_state $($p.PermissionType) ON Object::$($p.ObjectSchema).$($p.ObjectName) $col to [$newUser];`r`n";
                    }#else
   
                }
                #$str += "go`r`n";
                $h.sqlcmd = $str;
                $hta += $h;
            }
 
 
        }#loop $ServerInstance
    } #process block
    End
    {
           [string] $sqlcmd = "";
            
           if ($FilePath.Length -gt 3) # $FilePath is provided
           {
                [string]$servername="";
 
                foreach ($h in $hta)
                {
                   if ($h.Server -ne $Servername)
                   { 
                     $ServerName=$h.Server;
                     $sqlcmd += ":connect $servername `r`n" 
                    }
                    
                    $sqlcmd += "use $($h.DBName);`r`n" + $h.sqlcmd +"`r`ngo`r`n"; 
                     
                 }
                 $sqlcmd | out-file -FilePath $FilePath -Append ;   
            }
 
            if ($Execute)
            {
                foreach ($h in $hta)
                {
                    $server = new-object "Microsoft.sqlserver.management.smo.server" $h.Server;
                    $database = $server.databases[$h.DBName];
                    $database.ExecuteNonQuery($h.sqlcmd)
                }
            } #$Execute
 
    }#end block
} #clone-sqllogin 

# test, change parameters to your own. The following creates a script about all permissions assigned to [Bobby] 
# Clone-SQLLogin -Server "$env:ComputerName", "$env:ComputerName\sql2014" -OldLogin Bobby -NewLogin Bobby -FilePath "c:\temp\Bobby_perm.sql";
