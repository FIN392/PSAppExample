function Show-SplashWindow {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][string]$AppName,
        [Parameter(Mandatory=$true)][string]$IconFile,
        [Parameter(Mandatory=$true)][string]$SplashImageFile
    )

    BEGIN {
        $ErrorActionPreference = 'Stop'
        Write-Verbose "Begin function '$($MyInvocation.MyCommand)'"
    }

    PROCESS {

        # Get resources
        $BackgroungImage = New-Object System.Drawing.Bitmap( $SplashImageFile )
        $Icon = New-Object System.Drawing.Icon( $IconFile )
        Write-Verbose "Resources loaded"

        # Create form
        $frmSplash = New-Object System.Windows.Forms.Form
        $frmSplash.FormBorderStyle = 0 # No border
        $frmSplash.StartPosition = 1 # Center screen
        $frmSplash.Size = $BackgroungImage.Size
        $frmSplash.BackColor = [System.Drawing.Color]::Black
        $frmSplash.TransparencyKey = $frmSplash.BackColor
        $frmSplash.BackgroundImage = $BackgroungImage
        $frmSplash.Icon = $Icon
        $frmSplash.Text = $AppName
        Write-Verbose "Form created"

        # Return Form
        $frmSplash
    }

    END {
        Write-Verbose "End function '$($MyInvocation.MyCommand)'"
    }

}
