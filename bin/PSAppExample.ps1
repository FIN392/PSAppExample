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

[version]$ScriptVersion = "0.2.3.4"
[uri]$ScriptURI = "https://raw.githubusercontent.com/FIN392/PowerShell/master/FileRename/FileRename.ps1"



PowerShell/xAppName/xAppName.ps1


#Region Functions

function Get-URLScriptVersion {
    [CmdletBinding(DefaultParameterSetName='URL')]
    [OutputType([String])]
    Param
    (
        [Parameter(Mandatory=$true, 
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true, 
            ValueFromRemainingArguments=$false, 
            Position=0,
            ParameterSetName='URL')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        $URL
    )

    try {
        $ScriptWeb=Invoke-WebRequest -Uri $URL -UseBasicParsing
        ($ScriptWeb.Content -split "[`r`n]" |
            Select-String -Pattern "(?i)^( |\t)*\[version\].*\x24ScriptVersion *= *(\x22|\x27)(\d)(\.\d){0,3}(\x22|\x27)").toString().Replace(" ","").Replace('"','').Replace("'","").Split("=")[1]
    }
    catch {
        Write-Error $_
    }

}

function Install-Script {
    [CmdletBinding(DefaultParameterSetName='URL')]
    [OutputType([String])]
    Param
    (
        # Descripción de ayuda de Parám1
        [Parameter(Mandatory=$true, 
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true, 
            ValueFromRemainingArguments=$false, 
            Position=0,
            ParameterSetName='URL')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        $URL
    )

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

}

#EndRegion Functions

#Region VersionCheck

# Get the version of the script in the web
[version]$URLScriptVersion = Get-URLScriptVersion -URL $ScriptURI.AbsoluteUri

Write-Host "Current version   : $ScriptVersion"
Write-Host "Version in the web: $URLScriptVersion"

# If newer then download and install
if ( $URLScriptVersion -gt $ScriptVersion ) {

    Install-Script -URL $ScriptURI.AbsoluteUri

}



#EndRegion VersionCheck

