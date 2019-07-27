# https://www.scarydba.com/2019/01/07/powershell-to-simulate-load/
# GRANT FRITCHEY
# 2019-01-07


# connect to the database
$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = 'Server=WIN-8A2LQANSO51;Database=AdventureWorks2017;trusted_connection=true'

# gather values 
$RefCmd = New-Object System.Data.SqlClient.SqlCommand
$RefCmd.CommandText = "SELECT th.ReferenceOrderID,
COUNT(th.ReferenceOrderID) AS RefCount
FROM Production.TransactionHistory AS th
GROUP BY th.ReferenceOrderID;"
$RefCmd.Connection = $SqlConnection
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $RefCmd
$RefData = New-Object System.Data.DataSet
$SqlAdapter.Fill($RefData)

# Execute a stored procedure
$Sniffcmd = New-Object System.Data.SqlClient.SqlCommand
$Sniffcmd.CommandType = [System.Data.CommandType]'StoredProcedure'
$Sniffcmd.CommandText = "dbo.ProductTransactionHistoryByReference"
$Sniffcmd.Parameters.Add("@ReferenceOrderID",[System.Data.SqlDbType]"Int")
$Sniffcmd.Connection = $SqlConnection

# Optionally, clear the cache
$Freecmd = New-Object System.Data.SqlClient.SqlCommand
$Freecmd.CommandText = "DECLARE @plan_handle VARBINARY(64);
SELECT @plan_handle = deps.plan_handle
FROM sys.dm_exec_procedure_stats AS deps
WHERE deps.object_id = OBJECT_ID('dbo.ProductTransactionHistoryByReference');
DBCC FREEPROCCACHE(@plan_handle);"
$Freecmd.Connection = $SqlConnection

# Count the executions
$x = 0

# Run forever
while(1 -ne 0)
{
    foreach($row in $RefData.Tables[0])
        {
        # Establish an occasional wait
        $check = get-random -Minimum 7 -Maximum 20
        $wait = $x % $check
        if ($wait -eq 0)
        {
        #set a random sleep period in seconds
        $waittime = get-random -minimum 3 -maximum 13
        start-sleep -s $waittime
        $x = 0}
        # Up the count
        $x += 1
        # Execute the procedure
        $RefID = $row[0]
        $SqlConnection.Open()
        $Sniffcmd.Parameters["@ReferenceOrderID"].Value = $RefID
        $Sniffcmd.ExecuteNonQuery() | Out-Null
        $SqlConnection.Close()
        # clear the cache on each execution
        #$SqlConnection.Open()
        #$Freecmd.ExecuteNonQuery() | Out-Null
        #$SqlConnection.Close()
        # clear the cache based on random
        $check = get-random -Minimum 7 -Maximum 20
        $clear = $x % $check
        if($clear -eq 4)
        {
        $SqlConnection.Open()
        $Freecmd.ExecuteNonQuery() | Out-Null
        $SqlConnection.Close()
        }
    }
}