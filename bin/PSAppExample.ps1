#Region Documentation

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

#EndRegion Documentation

[version]$ScriptVersion = "0.1.0.0"
[uri]$ScriptURI = "https://raw.githubusercontent.com/FIN392/PSAppExample/main/bin/PSAppExample.ps1"

#Region Functions

function Update-PSApplication {

    # Get version of script on web
    $ScriptWeb=Invoke-WebRequest -Uri $ScriptURI.AbsoluteUri -UseBasicParsing
    $WebScriptVersion = ($ScriptWeb.Content -split "[`r`n]" |
        Select-String -Pattern "(?i)^( |\t)*\[version\].*\x24ScriptVersion *= *(\x22|\x27)(\d)(\.\d){0,3}(\x22|\x27)").toString().Replace(" ","").Replace('"','').Replace("'","").Split("=")[1]

"Current Script Version : $ScriptVersion"
"Web Script Version     : $WebScriptVersion"

    # If newer...

    if ( $WebScriptVersion -gt $ScriptVersion ) {

        # Ask the user if they want to upgrade

<#
        Write-Host "Downloading..."
        $TempFile = "$env:temp\$($URL | Split-Path  -leaf)"
        Remove-Item -Path $TempFile -ErrorAction Ignore
        try {
            Invoke-WebRequest -Uri $URL -OutFile $TempFile
        }
        catch {
            Write-Error $_
        }
    
        Write-Host "Installing..."
        try {
            # Copy-Item -Path $TempFile -Destination $PSCommandPath -Force
            Copy-Item -Path $TempFile -Destination E:\temp.ps1 -Force
        }
        catch {
            Write-Error $_
        }
    
        Write-Host "Installed"
        exit
#>

}


}

#EndRegion Functions

# Update the application
Update-PSApplication

# MAIN
Write-Host 'Hello, world!'
