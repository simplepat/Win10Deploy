Function Set-Registry
{
    <#
    .SYNOPSIS
    This function gives you the ability to create/change Windows registry keys and values. If you want to create a value but the key doesn't exist, it will create the key for you.
    .PARAMETER RegKey
    Path of the registry key to create/change
    .PARAMETER RegValue
    Name of the registry value to create/change
    .PARAMETER RegData
    The data of the registry value
    .PARAMETER RegType
    The type of the registry value. Allowed types: String,DWord,Binary,ExpandString,MultiString,None,QWord,Unknown. If no type is given, the function will use String as the type.
    .EXAMPLE 
    Set-Registry -RegKey HKLM:\SomeKey -RegValue SomeValue -RegData 1111 -RegType DWord
    This will create the key SomeKey in HKLM:\. There it will create a value SomeValue of the type DWord with the data 1111.
    .NOTES
    Author: Dominik Britz
    Source: https://github.com/DominikBritz
    #>
    [CmdletBinding()]
    PARAM
    (
        $RegKey,
        $RegValue,
        $RegData,
        [ValidateSet('String','DWord','Binary','ExpandString','MultiString','None','QWord','Unknown')]
        $RegType = 'String'    
    )

    If (-not $RegValue)
    {
        If (-not (Test-Path $RegKey))
        {
            Write-Verbose "The key $RegKey does not exist. Trying to create it..."
            Try
            {
                New-Item -Path $RegKey -Force
            }
            Catch
            {
                Write-Error -Message $_
            }
            Write-Verbose "Creation of $RegKey was successful !"
        }        
    }

    If ($RegValue)
    {
        If (-not (Test-Path $RegKey))
        {
            Write-Verbose "The key $RegKey does not exist. Trying to create it..."
            Try
            {
                New-Item -Path $RegKey -Force
                Set-ItemProperty -Path $RegKey -Name $RegValue -Value $RegData -Type $RegType -Force
            }
            Catch
            {
                Write-Error -Message $_
            }
            Write-Verbose "Creation of $RegKey was successful !"
        }
        Else 
        {
            Write-Verbose "The key $RegKey already exists. Trying to set value..."
            Try
            {
                Set-ItemProperty -Path $RegKey -Name $RegValue -Value $RegData -Type $RegType -Force
            }
            Catch
            {
                Write-Error -Message $_
            }
            Write-Verbose "Creation of $RegValue in $RegKey was successful !"           
        }
    }
}