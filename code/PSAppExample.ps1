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
Set-Location $PSScriptRoot

# Assemblies
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms

#Region: Application definitions
[string]$AppName = 'Application name'
[version]$AppVersion = "0.0.0.1"
[uri]$AppURL = "https://raw.githubusercontent.com/FIN392/PSAppExample/main/bin/PSAppExample.ps1"
#EndRegion

# Show splash window
Import-Module -Name '.\SplashWindow.psm1' -Force
[string]$SplashImageFile = Convert-Path '..\resources\SplashImage.png'
[string]$IconFile = Convert-Path '..\resources\Icon.ico'
$frmSplash = Show-SplashWindow -AppName $AppName -IconFile $IconFile -SplashImageFile $SplashImageFile -Verbose
$frmSplash.Show() | Out-Null

Start-Sleep -Seconds 10

# # Update the script if there is a newer version on the web
# Import-Module -Name '.\application\UpdateApplication.psm1' -Force
# Update-ScriptFromWeb -CurrentVersion $AppVersion -ScriptURL $AppURL -Verbose

#Close splash window
$frmSplash.Close() | Out-Null

<# 

    Installation path:
        $env:USERPROFILE + "\AppData\Roaming\PSAppExample\..."
    Start menu:
        $env:USERPROFILE + "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\PSAppExample\PSAppExample.lnk"
        $env:USERPROFILE + "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\PSAppExample\README.lnk"

    Create shortcut in Start Menu to the application:
        $Shell = New-Object -ComObject ('WScript.Shell')
        $ShortCut = $Shell.CreateShortcut($env:USERPROFILE + '\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\PSAppExample\PSAppExample.lnk')
        $ShortCut.TargetPath='pwsh.exe'
        $ShortCut.Arguments='-ExecutionPolicy Bypass -WindowStyle Hidden -File "' + $env:USERPROFILE + '\AppData\Roaming\PSAppExample\application\PSAppExample.ps1"'
        $ShortCut.WorkingDirectory = ''  # For example: ($env:USERPROFILE + '\AppData\Roaming\PSAppExample\application')
        $ShortCut.WindowStyle = 7 # Minimized
        $ShortCut.Hotkey = '' # For example: 'CTRL+SHIFT+P'
        $ShortCut.IconLocation = ($env:USERPROFILE + '\AppData\Roaming\PSAppExample\application\resources\Icon.ico')
        $ShortCut.Description = 'Short description of PSAppExample'
        $ShortCut.Save()

    Create shortcut in Start Menu to the README:
        ($env:USERPROFILE + '\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\PSAppExample\PSAppExample.url')

        [InternetShortcut]
        URL=file:///C:/Users/josel/AppData/Roaming/PSAppExample/README.html
        IconFile=C:\Users\josel\AppData\Roaming\PSAppExample\application\resources\Icon.ico
        IconIndex=0
        HotKey=0
        IDList=

#>


Write-Host 'Hello, world!'
