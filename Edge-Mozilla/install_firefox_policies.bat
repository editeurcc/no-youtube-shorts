@echo off
REM Lance le script PowerShell d'installation en demandant l'élévation (UAC)
SET SCRIPT_DIR=%~dp0
SET PS_SCRIPT="%SCRIPT_DIR%install_firefox_policies.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File %PS_SCRIPT%' -Verb RunAs"
EXIT /B %ERRORLEVEL%
