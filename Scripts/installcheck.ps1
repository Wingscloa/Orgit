# filepath: c:\Projects\Orgit\Scripts\installcheck.ps1
# ------------------ PARAMETRY ------------------

param(
    [switch]$SkipPython,
    [switch]$SkipPostgres,
    [switch]$SkipPgAdmin,
    [switch]$LogToFile,
    [switch]$Help
)

# ------------------ FUNKCE ------------------

function Write-Log {
    param(
        [string]$Message,
        [string]$Level = "INFO",
        [string]$Color = "White"
    )
    $prefix = "[$Level]"
    Write-Host "$prefix $Message" -ForegroundColor $Color
    if ($LogToFile) {
        Add-Content -Path "install.log" -Value ("$(Get-Date -Format o) $prefix $Message")
    }
}

function Show-DownloadProgress {
    param(
        [string]$Url,
        [string]$OutFile,
        [string]$DisplayName
    )
    try {
        $req = [System.Net.HttpWebRequest]::Create($Url)
        $res = $req.GetResponse()
        $total = $res.ContentLength
        $stream = $res.GetResponseStream()
        $fs = New-Object IO.FileStream $OutFile, [System.IO.FileMode]::Create
        $buffer = New-Object byte[] 8192
        $totalRead = 0
        while (($read = $stream.Read($buffer, 0, $buffer.Length)) -gt 0) {
            $fs.Write($buffer, 0, $read)
            $totalRead += $read
            if ($total -gt 0) {
                $percent = [int](($totalRead / $total) * 100)
                Write-Progress -Activity $DisplayName -Status "$percent%" -PercentComplete $percent
            }
        }
        $fs.Close()
        $stream.Close()
        Write-Progress -Activity $DisplayName -Completed
    }
    catch {
        throw $_
    }
}

# Funkce pro správu .env souboru
function Initialize-EnvFile {
    param(
        [string]$EnvPath = "..\.env"
    )
    
    # Kontrola existence .env, pokud neexistuje, vytvoř ho s příkladovými řádky
    if (-not (Test-Path $EnvPath)) {
        $exampleEnv = @(
            "FASTAPI_PORT=8080",
            "HOST=127.0.0.1",
            "pSQLHost=localhost",
            "pSQLPort=5432",
            "pSQLUser=postgres",
            "pSQLPassword=heslo",
            "Error=false",
            "Installation=false"
        )
        Set-Content -Path $EnvPath -Value $exampleEnv
        Write-Log ".env nebyl nalezen, byl vytvoren s prikladovymi radky. Nastavte hodnoty a spustte skript znovu." "ERROR" "Red"
        return $false
    }

    # Kontrola Installation flag
    $envLines = Get-Content $EnvPath
    if ($envLines.Count -ge 8) {
        $installationLine = $envLines[7]
        if ($installationLine -match "^Installation\s*=\s*true$") {
            Write-Log "Installation=true nalezeno v .env, skript bude ukoncen." "INFO" "Cyan"
            return $false
        }
    }

    # Kontrola bezpečného hesla
    $passwordLine = $envLines | Where-Object { $_ -match "^pSQLPassword=" }
    if ($passwordLine) {
        $passwordValue = $passwordLine -replace "^pSQLPassword=", ""
        if ($passwordValue -eq "heslo" -or [string]::IsNullOrWhiteSpace($passwordValue)) {
            Write-Log "V souboru .env neni nastaveno bezpecne heslo pro pSQLPassword! Zadejte spravne heslo do .env a spustte skript znovu." "ERROR" "Red"
            return $false
        }
    }
    else {
        Write-Log "V souboru .env chybi radek pSQLPassword=...! Nastavte jej a spustte skript znovu." "ERROR" "Red"
        return $false
    }

    return $true
}

function Set-InstallationComplete {
    param(
        [string]$EnvPath = "..\.env"
    )
    
    # Nastav Installation=true na 8. řádek v .env na konci skriptu
    if (Test-Path $EnvPath) {
        $envLines = Get-Content $EnvPath
        while ($envLines.Count -lt 8) { $envLines += "" }
        $envLines[7] = "Installation=true"
        Set-Content -Path $EnvPath -Value $envLines
        Write-Log "Installation=true bylo zapsano do .env na 8. radek." "SUCCESS" "Green"
    }
}

Write-Log "Spouštím kontrolu prostředí pro projekt..." "INFO" "Cyan"
$envPath = "..\.env"
$startTime = Get-Date

# Inicializace .env
if (-not (Initialize-EnvFile -EnvPath $envPath)) {
    exit 1
}

# ------------------ POSTGRESQL ------------------

if (-not $SkipPostgres) {
    Write-Log "SEKCE: Kontrola a instalace PostgreSQL" "INFO" "Cyan"
    $postgresPathBin = "C:\Program Files\PostgreSQL\17\bin"
    $sysPath = [Environment]::GetEnvironmentVariable("Path", "Machine").Split(";") | Where-Object { $_ -match "postgresql" }
    
    Write-Log "Systémová PATH: $sysPath" "INFO" "White"
    
    if (-not (Test-Path $postgresPathBin)) {
        Write-Log "PostgreSQL nebyl nalezen. Stahuji nejnovejsi verzi PostgreSQL..." "WARNING" "Yellow"
    
        $pgDownloadPage = "https://get.enterprisedb.com/postgresql/"
        $pgVersionApi = "https://www.postgresql.org/versions.rss"
    
        # Ziskani nejnovejsi verze PostgreSQL (napr. 17.1)
        try {
            $rss = Invoke-WebRequest -Uri $pgVersionApi -UseBasicParsing
            $latestVersion = ([xml]$rss.Content).rss.channel.item | Select-Object -First 1 -ExpandProperty title
            $latestVersionNumber = $latestVersion -replace "[^\d\.]", ""
            Write-Log "Nejnovejsi verze PostgreSQL: $latestVersionNumber" "INFO" "White"
        }
        catch {
            Write-Log "Nepodarilo se zjistit nejnovejsi verzi PostgreSQL. Pokracuji s verzi 17." "WARNING" "Yellow"
            $latestVersionNumber = "17"
        }
    
        # Sestaveni nazvu instalacniho souboru
        $installerName = "postgresql-$latestVersionNumber-1-windows-x64.exe"
        $installerUrl = "$pgDownloadPage$installerName"
        $installerPath = "$env:TEMP\$installerName"
    
        Write-Log "Stahuji: $installerUrl" "INFO" "White"
        try {
            Show-DownloadProgress -Url $installerUrl -OutFile $installerPath -DisplayName "Stahuji PostgreSQL $latestVersionNumber"
            Write-Log "Stazeno: $installerPath" "SUCCESS" "Green"
            Write-Log "Spoustim instalator PostgreSQL..." "INFO" "White"
            Start-Process -FilePath $installerPath -Wait
            Write-Log "Instalace dokoncena. Spustte skript znovu pro overeni instalace." "SUCCESS" "Green"
            exit 0
        }
        catch {
            Write-Log "Chyba pri stahovani nebo instalaci PostgreSQL: $_" "ERROR" "Red"
            exit 1
        }
    }
    else {
        Write-Log "PostgreSQL je jiz nainstalovan." "SUCCESS" "Green"
    }
    
    # Pridani postgresPath do systemove PATH, pokud tam jeste neni
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
    if (-not $currentPath.Contains($postgresPathBin)) {
        $newPath = "$currentPath;$postgresPathBin"
        [Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
        Write-Log "Pridano do systemove PATH: $postgresPathBin" "SUCCESS" "Green"
    }
    else { 
        Write-Log "Cesta PostgreSQL uz v systemove PATH existuje." "SUCCESS" "Green" 
    }
    
    # Ověření funkčnosti PostgreSQL
    try {
        $psqlVersion = psql --version
        Write-Log "PostgreSQL verze: $psqlVersion" "SUCCESS" "Green"
    }
    catch {
        Write-Log "PostgreSQL instalace nalezena, ale příkaz psql nefunguje. Zkontrolujte instalaci." "ERROR" "Red"
    }
}
else {
    Write-Log "Preskakuji kontrolu a instalaci PostgreSQL dle parametru." "INFO" "Yellow"
}

# ------------------ PYTHON ------------------

if (-not $SkipPython) {
    Write-Log "SEKCE: Kontrola a instalace Python" "INFO" "Cyan"

    $pythonFound = $false
    $pythonPath = $null
    $pythonPathsToCheck = @(
        "C:\Users\$env:USERNAME\AppData\Local\Microsoft\WindowsApps\python.exe",
        "C:\Users\$env:USERNAME\AppData\Local\Programs\Python\Python312\python.exe",
        "C:\Users\$env:USERNAME\AppData\Local\Programs\Python\Python311\python.exe",
        "C:\Users\$env:USERNAME\AppData\Local\Programs\Python\Python310\python.exe",
        "C:\Python312\python.exe",
        "C:\Python311\python.exe",
        "C:\Python310\python.exe",
        "C:\Python39\python.exe",
        "C:\Program Files\Python312\python.exe",
        "C:\Program Files\Python311\python.exe",
        "C:\Program Files\Python310\python.exe",
        "C:\Program Files\Python39\python.exe",
        "C:\Program Files (x86)\Python312\python.exe",
        "C:\Program Files (x86)\Python311\python.exe",
        "C:\Program Files (x86)\Python310\python.exe",
        "C:\Program Files (x86)\Python39\python.exe",
        "..\api\Scripts\python.exe"
    )
    
    # Hledání Pythonu v definovaných cestách
    foreach ($pyPath in $pythonPathsToCheck) {
        if (Test-Path $pyPath) {
            Write-Log "Python nalezen: $pyPath" "SUCCESS" "Green"
            $pythonFound = $true
            $pythonPath = $pyPath
            break
        }
    }
    
    # Hledání Pythonu v PATH
    if (-not $pythonFound) {
        try {
            $pythonVersion = & python --version 2>$null
            if ($LASTEXITCODE -eq 0) {
                Write-Log "Python nalezen v PATH: $pythonVersion" "SUCCESS" "Green"
                $pythonPath = (Get-Command python).Source
                $pythonFound = $true
            }
        }
        catch {}
    }
    
    # Hledání Pythonu přes py launcher
    if (-not $pythonFound) {
        try {
            $pyVersion = & py --version 2>$null
            if ($LASTEXITCODE -eq 0) {
                Write-Log "Python nalezen pres py launcher: $pyVersion" "SUCCESS" "Green"
                $pythonFound = $true
                try {
                    $pythonPath = (& py -c "import sys; print(sys.executable)") 
                }
                catch {
                    $pythonPath = "py"
                }
            }
        }
        catch {}
    }
    
    # Instalace Pythonu, pokud nebyl nalezen
    if (-not $pythonFound) {
        Write-Log "Python neni nainstalovan. Stahuji a instaluji Python..." "INFO" "Cyan"
        $pythonInstallerUrl = "https://www.python.org/ftp/python/3.12.3/python-3.12.3-amd64.exe"
        $pythonInstallerPath = "$env:TEMP\python-installer.exe"
        try {
            if (Get-Command Start-BitsTransfer -ErrorAction SilentlyContinue) {
                Write-Log "Pouzivam Start-BitsTransfer pro stazeni Pythonu..." "INFO" "Cyan"
                Start-BitsTransfer -Source $pythonInstallerUrl -Destination $pythonInstallerPath -DisplayName "Stahuji Python"
            }
            else {
                Write-Log "Pouzivam vlastni progress bar pro stazeni Pythonu..." "INFO" "Cyan"
                Show-DownloadProgress -Url $pythonInstallerUrl -OutFile $pythonInstallerPath -DisplayName "Stahuji Python"
            }
            Write-Log "Stazeno: $pythonInstallerPath" "SUCCESS" "Green"
            Write-Log "Spoustim instalator Pythonu..." "INFO" "Cyan"
            Start-Process -FilePath $pythonInstallerPath -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
            Write-Log "Instalace Pythonu dokoncena." "SUCCESS" "Green"
            
            # Zjištění nainstalované cesty k Pythonu
            try {
                $pythonPath = (Get-Command python).Source
            }
            catch {
                Write-Log "Python byl nainstalován, ale není v PATH. Restartujte PowerShell a zkuste znovu." "WARNING" "Yellow"
            }
        }
        catch {
            Write-Log "Chyba pri stahovani nebo instalaci Pythonu: $_" "ERROR" "Red"
            exit 1
        }
    }
    else {
        Write-Log "Python je jiz nainstalovan." "SUCCESS" "Green"
    }
    
    # Pridani Pythonu do systemove PATH, pokud tam jeste neni
    if ($pythonPath -ne "py" -and $pythonPath -ne $null) {
        $pythonDir = Split-Path $pythonPath
        $currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
        if (-not $currentPath.ToLower().Contains($pythonDir.ToLower())) {
            $newPath = "$currentPath;$pythonDir"
            try {
                [Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
                Write-Log "Pridano do systemove PATH: $pythonDir" "SUCCESS" "Green"
            }
            catch {
                Write-Log "Nepodařilo se přidat Python do systémové PATH. Zkuste spustit skript jako správce." "WARNING" "Yellow"
            }
        }
        else {
            Write-Log "Cesta k Pythonu uz v PATH existuje." "SUCCESS" "Green"
        }
    }
}
else {
    Write-Log "Preskakuji kontrolu a instalaci Pythonu dle parametru." "INFO" "Yellow"
}

# ------------------ ZÁVĚR ------------------

Set-InstallationComplete -EnvPath $envPath

$endTime = Get-Date
$duration = $endTime - $startTime
Write-Log "Instalace dokoncena za $($duration.TotalSeconds.ToString("0.00")) sekund." "INFO" "Cyan"
Write-Log "Muzete pokracovat dalsim skriptem nebo restartovat pocitac, pokud byl instalovan software." "INFO" "Cyan"
Write-Log "Pokud nastala chyba, zkontrolujte soubor install.log pro podrobnosti." "INFO" "Cyan"
