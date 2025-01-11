<#
.SYNOPSIS
Launches a game using Xenia Manager and Xenia Canary emulator based on a provided game path, with optional flags like --Fullscreen.

.DESCRIPTION
This tool verifies the paths of required executables, the configuration file, and the provided game path. It retrieves game details from Config\games.json and constructs a launch command for xenia_canary.exe.

.PARAMETER GamePath
The file path of the game to be launched.

.PARAMETER Fullscreen
(Optional) If specified, the game will launch in fullscreen mode.

.EXAMPLE
.\XMXC.LaunchByPath.ps1 -GamePath "C:\Games\MyGame.iso" -Fullscreen
#>
param (
    [Parameter(Mandatory = $false)]
    [string]$GamePath,

    [Parameter()]
    [switch]$Fullscreen
)

if (-not $GamePath) {
    Write-Output 'Usage: LaunchByPath.exe <GamePath> [--fullscreen]'
    exit 1
}

if ([System.IO.File]::Exists($GamePath)) {
}
else {
    Write-Output "The provided GamePath '$GamePath' does not exist."
    exit 1
}

$XMDirectory = (Get-Location).Path
$XMExe = Join-Path $XMDirectory "XeniaManager.DesktopApp.exe"
$XMGameFile = Join-Path $XMDirectory "Config\games.json"
$XCExe = Join-Path $XMDirectory "Emulators\Xenia Canary\xenia_canary.exe"

if (-Not (Test-Path -Path $XMExe)) {
    Write-Output "Error: '$XMExe' was not found.`nDownload the latest version from https://github.com/xenia-manager/xenia-manager/releases and place this script in the root folder."
    exit 1
}

if (-Not (Test-Path -Path $XMGameFile)) {
    Write-Output "Error: '$XMGameFile' was not found. Run XeniaManager.DesktopApp.exe to set it up."
    & $XMExe
    exit 1
}

if (-Not (Test-Path -Path $XCExe)) {
    Write-Output "Error: '$XCExe' was not found. Install it through Xenia Manager."
    & $XMExe
    exit 1
}

try {
    $Games = Get-Content -Path $XMGameFile -Raw | ConvertFrom-Json
}
catch {
    Write-Output "Error: Failed to parse '$XMGameFile'."
    exit 1
}

$Game = $Games | Where-Object { $_.file_locations.game_location -eq $GamePath }

if ($Game) {
    $LaunchCommand = "`"$XCExe`" `"$($Game.file_locations.game_location)`" --config `"$($Game.file_locations.config_location)`""
    if ($Fullscreen) {
        $LaunchCommand += " --fullscreen"
    }
    Write-Output "Starting '$XCExe' with command: $LaunchCommand"

    $Arguments = @($Game.file_locations.game_location, "--config", $Game.file_locations.config_location)
    if ($Fullscreen) {
        $Arguments += "--fullscreen"
    }

    & $XCExe @Arguments
    exit 0
}
else {
    Write-Output "Error: '$GamePath' needs to be installed in Xenia Manager."
    & $XMExe
    exit 1
}
