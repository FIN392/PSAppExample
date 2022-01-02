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
        https://github.com/FIN392/...

    .NOTES
        Author: FIN392 - fin392@gmail.com
#>

$ErrorActionPreference = 'Stop'
Write-Verbose "Begin '$($MyInvocation.MyCommand)'"

# Assemblies
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms


Convert-Path '.'

#Region: Definitions
[string]$AppName = 'Application name'
[version]$AppVersion = "0.0.0.1"
[uri]$AppURL = "https://raw.githubusercontent.com/FIN392/PSAppExample/main/bin/PSAppExample.ps1"
[string]$SplashImageFile = Convert-Path '.\application\resources\SplashImage.jpg'
[string]$IconFile = Convert-Path '.\application\resources\Icon.ico'
#EndRegion

# Show splash window
Import-Module -Name '.\application\SplashWindow.psm1' -Force
$frmSplash = Show-SplashWindow -AppName $AppName -AppVersion $AppVersion -IconFile $IconFile -SplashImageFile $SplashImageFile -Verbose
$frmSplash.Show() | Out-Null

# Ready, steady, go!
Start-Sleep -Seconds 3

#Close splash window
$frmSplash.Close() | Out-Null

# Update the script if there is a newer version on the web
Import-Module -Name '.\application\UpdateApplication.psm1' -Force
Update-ScriptFromWeb -CurrentVersion $AppVersion -ScriptURL $AppURL -Verbose



Write-Host 'Hello, world!'
