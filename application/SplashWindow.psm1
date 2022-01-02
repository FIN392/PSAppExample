function Show-SplashWindow {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][string]$AppName,
        [Parameter(Mandatory=$true)][version]$AppVersion,
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
        $frmSplash.BackgroundImage = $BackgroungImage
        $frmSplash.Icon = $Icon
        $frmSplash.Text = $AppName
        Write-Verbose "Form created"

        # Version label
        $lblVersion = New-Object System.Windows.Forms.Label
        $frmSplash.Controls.Add( $lblVersion )
        $lblVersion.BorderStyle = 0 # None
        $lblVersion.BackColor = 0xFFFFFF # Transparent
        $lblVersion.ForeColor = [System.Drawing.Color]::Black
        $lblVersion.AutoSize = $true
        $lblVersion.Text = "Ver. $AppVersion"
        $lblVersion.Font = New-Object System.Drawing.Font( 'Arial', 10, [System.Drawing.FontStyle]::Bold ) ;
        $lblVersion.Location = New-Object System.Drawing.Point( ( $frmSplash.Width - $lblVersion.Width - 5 ), ( $frmSplash.Height - $lblVersion.Height - 5 ) )
        Write-Verbose "Version label created and added"

        # Message label
        $lblMessage = New-Object System.Windows.Forms.Label
        $frmSplash.Controls.Add( $lblMessage )
        $lblMessage.BorderStyle = 0 # None
        $lblMessage.BackColor = 0xFFFFFF # Transparent
        $lblMessage.ForeColor = [System.Drawing.Color]::Black
        $lblMessage.AutoSize = $false
        $lblMessage.TextAlign = 32 # MiddleCenter
        $lblMessage.Text = ''
        $lblMessage.Font = New-Object System.Drawing.Font( 'Arial', 20, [System.Drawing.FontStyle]::Bold ) ;
        $lblMessage.Location = New-Object System.Drawing.Point( 0, 0 )
        $lblMessage.Width =$frmSplash.Width
        $lblMessage.Height = $frmSplash.Height
        Write-Verbose "Message label created and added"

        # Return Form
        $frmSplash
    }

    END {
        Write-Verbose "End function '$($MyInvocation.MyCommand)'"
    }

}



