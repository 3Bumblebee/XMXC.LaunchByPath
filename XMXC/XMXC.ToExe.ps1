Add-Type -AssemblyName System.Drawing

if (-not (Get-Command -Name "Invoke-PS2EXE" -ErrorAction SilentlyContinue)) {
    Write-Output "Error: Invoke-PS2EXE module is not installed or available."
    Write-Output "Please install the module by running the following command:"
    Write-Output "`nInstall-Module -Name PS2EXE -Scope CurrentUser -Force`n"
    Write-Output "After installation, re-run this script."
    exit 1
}

$XMDirectory = (Get-Location).Path
$XMExe = Join-Path $XMDirectory "XeniaManager.DesktopApp.exe"
$XmXcLBP = Join-Path $XMDirectory "XMXC.LaunchByPath.ps1"

if (-Not (Test-Path -Path $XMExe)) {
    Write-Output "Error: XeniaManager.DesktopApp.exe not found.`nDownload the latest version from https://github.com/xenia-manager/xenia-manager/releases and place this script in the root folder."
    exit 1
}

if (-Not (Test-Path -Path $XmXcLBP)) {
    Write-Output "Error: XMXC.LaunchByPath.ps1 place it in the same folder as this script."
    exit 1
}

$IconPath = Join-Path $XMDirectory "Icon.ico"

$Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($XMExe)
if ($Icon) {
    $Stream = New-Object System.IO.FileStream($IconPath, [System.IO.FileMode]::Create)
    $Icon.Save($Stream)
    $Stream.Close()
    Write-Host "Icon extracted and saved as .ico at $IconPath."
} else {
    Write-Host "No associated icon found for $XMExe."
    exit 1
}

Invoke-PS2EXE -InputFile $XmXcLBP `
    -OutputFile "XMXE.exe" `
    -iconFile $IconPath `
    -title "XMXE" `
    -product "XMXE"

Remove-Item $IconPath -Force
