# Nastavení kódování konzole na UTF8 pro lepší podporu emoji
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
set-executionpolicy remotesigned

$sysPath = [Environment]::GetEnvironmentVariable("Path", "Machine").Split(';') | Where-Object { $_ -match "postgresql" }

Write-Host "✅ Systémová PATH: $sysPath"

$pythonpath = "C:\Users\Acer\AppData\Local\Microsoft\WindowsApps\python.exe"
$pgAdminPath = "C:\Program Files\pgAdmin 4"
$postgresPathBin = "C:\Program Files\PostgreSQL\17\bin"

if (-not (Test-Path $postgresPathBin)) {
    Write-Host "❌ PostgreSQL nebyl nalezen. Stahuji nejnovější verzi PostgreSQL..."

    $pgDownloadPage = "https://get.enterprisedb.com/postgresql/"
    $pgVersionApi = "https://www.postgresql.org/versions.rss"

    # Získání nejnovější verze PostgreSQL (např. 17.1)
    try {
        $rss = Invoke-WebRequest -Uri $pgVersionApi -UseBasicParsing
        $latestVersion = ([xml]$rss.Content).rss.channel.item | Select-Object -First 1 -ExpandProperty title
        $latestVersionNumber = $latestVersion -replace '[^\d\.]', ''
        Write-Host "Nejnovější verze PostgreSQL: $latestVersionNumber"
    }
    catch {
        Write-Host "Nepodařilo se zjistit nejnovější verzi PostgreSQL. Pokračuji s verzí 17."
        $latestVersionNumber = "17"
    }

    # Sestavení názvu instalačního souboru
    $installerName = "postgresql-$latestVersionNumber-1-windows-x64.exe"
    $installerUrl = "$pgDownloadPage$installerName"
    $installerPath = "$env:TEMP\$installerName"

    Write-Host "Stahuji: $installerUrl"
    try {
        Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath
        Write-Host "✅ Staženo: $installerPath"
        Write-Host "Spouštím instalátor PostgreSQL..."
        Start-Process -FilePath $installerPath -Wait
        Write-Host "✅ Instalace dokončena. Spusťte skript znovu pro ověření instalace."
        exit 0
    }
    catch {
        Write-Host "❌ Chyba při stahování nebo instalaci PostgreSQL: $_"
        exit 1
    }
}
else {
    Write-Host "✅ PostgreSQL je již nainstalován."
}

# Přidání postgresPath do systémové PATH, pokud tam ještě není
$currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
Write-Host $currentPath
if (-not $currentPath.Contains(";$postgresPathBin")) {
    $newPath = "$currentPath;$postgresPathBin"
    [Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
    Write-Host "✅ Přidáno do systémové PATH: $postgresPathBin"
}
else { Write-Host "Cesta už v PATH existuje." }

psql --version

# PYTHON
if (-not (Test-Path $pythonpath)) {
    Write-Host "❌ Python není nainstalován. Stahuji a instaluji Python..."
    $pythonInstallerUrl = "https://www.python.org/ftp/python/3.12.3/python-3.12.3-amd64.exe"
    $pythonInstallerPath = "$env:TEMP\python-installer.exe"
    try {
        Invoke-WebRequest -Uri $pythonInstallerUrl -OutFile $pythonInstallerPath
        Write-Host "✅ Staženo: $pythonInstallerPath"
        Write-Host "Spouštím instalátor Pythonu..."
        Start-Process -FilePath $pythonInstallerPath -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
        Write-Host "✅ Instalace Pythonu dokončena."
    }
    catch {
        Write-Host "❌ Chyba při stahování nebo instalaci Pythonu: $_"
        exit 1
    }
}

# Přidání Pythonu do systémové PATH, pokud tam ještě není
$currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
$pythonDir = Split-Path $pythonpath
if (-not $currentPath.ToLower().Contains($pythonDir.ToLower())) {
    $newPath = "$currentPath;$pythonDir"
    [Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
    Write-Host "✅ Přidáno do systémové PATH: $pythonDir"
}
else {
    Write-Host "Cesta k Pythonu už v PATH existuje."
}

# PGADMIN
if (-not (Test-Path $pgAdminPath)) {
    Write-Host "❌ pgAdmin není nainstalován. Stahuji a instaluji pgAdmin..."

    $pgAdminInstallerUrl = "https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v7.8/windows/pgadmin4-7.8-x64.exe"
    $pgAdminInstallerPath = "$env:TEMP\pgadmin4-installer.exe"
    try {
        Invoke-WebRequest -Uri $pgAdminInstallerUrl -OutFile $pgAdminInstallerPath
        Write-Host "✅ Staženo: $pgAdminInstallerPath"
        Write-Host "Spouštím instalátor pgAdmin..."
        Start-Process -FilePath $pgAdminInstallerPath -ArgumentList "/SILENT" -Wait
        Write-Host "✅ Instalace pgAdmin dokončena."
    }
    catch {
        Write-Host "❌ Chyba při stahování nebo instalaci pgAdmin: $_"
        exit 1
    }
}
else {
    Write-Host "✅ pgAdmin je již nainstalován."
}




Read-Host -Prompt "Installer - Stiskni Enter pro ukončení"