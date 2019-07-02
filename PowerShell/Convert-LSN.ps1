function Convert-LSN {
    <#
    .SYNOPSIS
        Converts Lsns between Hex and/or numeric formats

    .DESCRIPTION
        Function takes an LSN in either split Hexadecimal format () or numeric

        It then returns both formats in an object

        https://stuart-moore.com/converting-sql-server-lsns-with-powershell/

    .PARAMETER LSN
        The LSN value to be converted

    .EXAMPLE
        PS C:\ $output = Convert-LSN -LSN 0000047c:00000108:0001

        Will return object $Output with the following value
        $Output.HexLSN = 0000014:000000f3:0001  
        $Output.NumericLSN = 20000000024300001
    #>
    [CmdletBinding()]
    param(
        [string]$LSN
    )

    if ($LSN -match '^[a-fA-F0-9]{8}:[a-fA-F0-9]{8}:[a-fA-F0-9]{4}$') {
        Write-Verbose -Message 'Hexadecimal LSN passed in, converting to numeric'
        $sections = $LSN.Split(':')
        $sect1 = [System.Convert]::ToInt64($sections[0], 16).ToString()
        $sect2 = [System.Convert]::ToInt64($sections[1], 16).ToString().PadLeft(10, '0')
        $sect3 = [System.Convert]::ToInt64($sections[2], 16).ToString().PadLeft(5, '0')
        $Hexadecimal = $LSN
        $Numeric = $sect1 + $sect2 + $sect3

    } elseif ($LSN -match '^[0-9]{15}[0-9]+$') {
        Write-Verbose -Message 'Numeric LSN passed in, converting to Hexadecimal' 
        $sect1 = '{0:x}' -f [System.Convert]::ToString($LSN.Substring(0, $LSN.length-15), 16).PadLeft(8,'0')
        $sect2 = '{0:x}' -f [System.Convert]::ToString($LSN.Substring($lsn.length-14, 9), 16).PadLeft(8, '0')
        $sect3 = '{0:x}' -f [System.Convert]::ToString($LSN.Substring($lsn.length-5, 5), 16).PadLeft(4, '0')
        $Numeric = $LSN
        $Hexadecimal = $sect1 + ':' + $sect2 + ':' + $sect3
    } else {
        Write-Warning -Message 'LSN passed in is neither Numeric nor in the correct hexadecimal format'
        return
    }

    [PSCustomObject]@{
        Hexadecimal = $Hexadecimal
        Numeric     = $Numeric
    }
}

$output = Convert-LSN -LSN 0000014:000000f3:0001