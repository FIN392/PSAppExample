<# 
    .SYNOPSIS
        Brief explanation of the use of the program.

    .DESCRIPTION
        Detailed description of what the program does.

    .PARAMETER FirstParameterName
        Description of the use of the parameters.
        'Mandatory' or 'Optional'.

    .PARAMETER nParameterName
        Description of the use of the parameters.
        'Mandatory' or 'Optional'.

    .INPUTS
        None.

    .OUTPUTS
        None.

    .EXAMPLE
        COMMAND LINE EXAMPLE

        Explanation of the results.

    .EXAMPLE
        COMMAND LINE EXAMPLE

        Explanation of the results.

    .LINK
        https://github.com/FIN392/PowerShell/tree/master/xLog

    .NOTES
        Author: FIN392 - fin392@gmail.com
#>

[version]$ScriptVersion = "0.0.0.1"
[uri]$ScriptURL = "https://raw.githubusercontent.com/FIN392/PSAppExample/main/bin/PSAppExample.ps1"

# Update the script if there is a newer version on the web
Import-Module -Name '.\UpdateApplication.psm1' -Force
Update-ScriptFromWeb -CurrentVersion $ScriptVersion -ScriptURL $ScriptURL -Verbose


Write-Host 'Hello, world!'
