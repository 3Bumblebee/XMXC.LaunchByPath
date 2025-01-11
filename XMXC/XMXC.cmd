@echo off
set "script_dir=%~dp0"
set "ps_script=%script_dir%XMXC.LaunchByPath.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%ps_script%" %*
