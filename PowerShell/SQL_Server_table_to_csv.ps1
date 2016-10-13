<#
.SYNOPSIS
    Export SQL Server table to csv file
.DESCRIPTION
    This script export SQL Server table to csv file
.PARAMETER sqlCmd.CommandText
    SQL query for export data
.EXAMPLE
    C:\PS>
    <Description of example>
.NOTES
    Author: Bill Graziano
    Original Link: http://www.sqlteam.com/article/fast-csv-import-in-powershell-to-sql-server
    Created Date: 2014-03-18
#>
$ConnectionString = "localhsot"
$streamWriter = New-Object System.IO.StreamWriter ".\SimpleCsvOut3.txt"
$sqlConn = New-Object System.Data.SqlClient.SqlConnection $ConnectionString
$sqlCmd = New-Object System.Data.SqlClient.SqlCommand
$sqlCmd.Connection = $sqlConn
$sqlCmd.CommandText = "SELECT * FROM sys.tables"
$sqlConn.Open();
$reader = $sqlCmd.ExecuteReader();

# Initialze the arry the hold the values
$array = @()
for ( $i = 0 ; $i -lt $reader.FieldCount; $i++ ) 
    { $array += @($i) }

# Write Header
$streamWriter.Write($reader.GetName(0))
for ( $i = 1; $i -lt $reader.FieldCount; $i ++) 
{ $streamWriter.Write($("," + $reader.GetName($i))) }

$streamWriter.WriteLine("") # Close the header line

while ($reader.Read())
{
    # get the values;
    $fieldCount = $reader.GetValues($array);

    # add quotes if the values have a comma
    for ($i = 0; $i -lt $array.Length; $i++)
    {
        if ($array[$i].ToString().Contains(","))
        {
            $array[$i] = '"' + $array[$i].ToString() + '"';
        }
    }

    $newRow = [string]::Join(",", $array);

    $streamWriter.WriteLine($newRow)
}
$reader.Close();
$sqlConn.Close();
$streamWriter.Close();
