# Check if Chocolatey is installed
if (-not (Test-Path 'C:\ProgramData\chocolatey\choco.exe' -PathType Leaf)) {
    Write-Host "Chocolatey is not installed. Installing yq..."
    InstallYq
}
else {
    Write-Host "Chocolatey is installed, using Choco to install yq"
    choco install yq
}

function InstallYq {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    $yqDownloadUrl = 'https://github.com/mikefarah/yq/releases/download/v4.4.1/yq_windows_amd64.exe'
    $yqInstallPath = 'C:\tools\yq.exe'

    if (-not (Test-Path $yqInstallPath -PathType Leaf)) {
        Write-Host "Installing yq..."
        $ProgressPreference = 'SilentlyContinue'

        if (-not (Test-Path 'C:\tools' -PathType Container)) {
            New-Item 'C:\tools' -ItemType Directory -Force
        }

        try {
            Invoke-WebRequest $yqDownloadUrl -OutFile $yqInstallPath -UseBasicParsing -ErrorAction Stop
            Write-Host "Download complete."
            
            Unblock-File $yqInstallPath -Confirm:$false
            Write-Host "yq.exe is unblocked."

            Write-Host "yq has been successfully installed to $yqInstallPath"
        }
        catch {
            Write-Host "Failed to download or install yq. Error: $_" -ForegroundColor Red
            exit 1
        }
    }
    else {
        Write-Host "yq is already installed at $yqInstallPath"
    }
}

