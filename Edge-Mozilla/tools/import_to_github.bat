@echo off
REM Lance le script PowerShell interactif pour pousser le projet sur GitHub
pushd "%~dp0"
pwsh -NoProfile -ExecutionPolicy Bypass -File "%~dp0import_to_github.ps1"
popd
pause
