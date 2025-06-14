$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
$scriptPath = Join-Path $projectRoot "Scripts"
# Spustit jako správce, pokud není
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}
# Spuštění všech dostupných skriptů ve složce Scripts postupně
Set-Location $scriptPath
.\installcheck.ps1
.\iniDb.ps1 
.\iniServer.ps1
Write-Host "`n--- Skript dokončen. Okno zůstává otevřené, můžete psát vlastní příkazy. ---`n"
powershell