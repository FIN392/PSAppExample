# Get the version of a script on the web
# Look for the variable 'AppVersion' in the code to determine the version
function Get-ScriptWebVersion {
    [CmdletBinding()]
    [OutputType('version')]
    param (
        [Parameter(Mandatory=$true)][uri]$ScriptURL
    )

    BEGIN {
        $ErrorActionPreference = 'Stop'
        Write-Verbose "Begin function '$($MyInvocation.MyCommand)'"
    }

    PROCESS {
        $ScriptWeb=Invoke-WebRequest -Uri $ScriptURL.AbsoluteUri -UseBasicParsing
        [version]($ScriptWeb.Content -split "[`r`n]" |
            Select-String -Pattern "(?i)^( |\t)*\[version\].*\x24AppVersion *= *(\x22|\x27)(\d)(\.\d){0,3}(\x22|\x27)").toString().Replace(" ","").Replace('"','').Replace("'","").Split("=")[1]
        }

    END {
        Write-Verbose "End function '$($MyInvocation.MyCommand)'"
    }

}

# Upgrade script if a new version is available on the web
function Update-ScriptFromWeb {
    [CmdletBinding()]
    [OutputType('System.IO.FileInfo')]
    param (
        [Parameter(Mandatory=$true)][version]$CurrentVersion,
        [Parameter(Mandatory=$true)][uri]$ScriptURL
    )

    BEGIN {
        $ErrorActionPreference = 'Stop'
        Write-Verbose "Begin function '$($MyInvocation.MyCommand)'"
    }

    PROCESS {
        # Get script version on the web
        [version]$WebVersion = Get-ScriptWebVersion -ScriptURL $ScriptURL

        Write-Verbose "Current version: $CurrentVersion"
        Write-Verbose "Web version    : $WebVersion"

### fuerzo para que se actualice
[version]$WebVersion = "9.9.9.9"

### ¿Qué hago con los literales para que los mensajes salgan en tu idioma?
### (Get-UICulture).TwoLetterISOLanguageName

        # If the version on the web is newer...
        if ( $WebVersion -gt $CurrentVersion ) {

            Add-Type -AssemblyName PresentationCore,PresentationFramework
            $MessageBoxTitle = "NEW VERSION AVAILABLE"

            $MessageBoxBody = "You are currently using version $CurrentVersion`n" +
                "and version $WebVersion is available for download.`n" +
                "`n" +
                "Would you like to upgrade now?"
            $MessageBoxButtons = [System.Windows.MessageBoxButton]::YesNo
            $MessageBoxIcon = [System.Windows.MessageBoxImage]::Information
            # If the user accept the upgrade...
            if ( [System.Windows.MessageBox]::Show($MessageBoxBody,$MessageBoxTitle,$MessageBoxButtons,$MessageBoxIcon) -eq "Yes" ) {

                Write-Verbose "Upgrade process accepted by user"

###
[System.Windows.MessageBox]::Show("Upgrading...",$MessageBoxTitle,[System.Windows.MessageBoxButton]::OK,$MessageBoxIcon)

            } else {
                Write-Verbose "Upgrade denied by user"
            }

        }

    }

    END {
        Write-Verbose "End function '$($MyInvocation.MyCommand)'"
    }

}






<#

    # Get the version of script located in the web
    $ScriptWeb=Invoke-WebRequest -Uri $ScriptURI.AbsoluteUri -UseBasicParsing
    $WebScriptVersion = ($ScriptWeb.Content -split "[`r`n]" |
        Select-String -Pattern "(?i)^( |\t)*\[version\].*\x24ScriptVersion *= *(\x22|\x27)(\d)(\.\d){0,3}(\x22|\x27)").toString().Replace(" ","").Replace('"','').Replace("'","").Split("=")[1]

    # If newer, ask the user if they want to upgrade
    if ( $WebScriptVersion -gt $ScriptVersion ) {

        "Current Script Version : $ScriptVersion"
        "Web Script Version     : $WebScriptVersion"
        "Actualizas?"


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
