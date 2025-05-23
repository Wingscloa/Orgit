$scriptPath = Get-Location
$service = "..\api\serviceAccountKey.json"
$venvPath = "..\api\Scripts"
$envPath = "..\.env"
# --------------- #

# Kontrola, zda .env obsahuje bezpečné heslo
if (Test-Path $envPath) {
    $envLines = Get-Content $envPath
    $passwordLine = $envLines | Where-Object { $_ -match '^pSQLPassword=' }
    if ($passwordLine) {
        $passwordValue = $passwordLine -replace '^pSQLPassword=', ''
        if ($passwordValue -eq 'heslo' -or [string]::IsNullOrWhiteSpace($passwordValue)) {
            Write-Host "❌ V souboru .env není nastaveno heslo pro pSQLPassword! Zadejte správné heslo do .env a spusťte skript znovu."
            exit 1
        }
    }
    else {
        Write-Host "❌ V souboru .env chybí řádek pSQLPassword=...! Nastavte jej a spusťte skript znovu."
        exit 1
    }
}
else {
    # Pokud .env neexistuje, vytvoř základní šablonu
    $defaultEnv = @(
        'FASTAPI_PORT=8080'
        'HOST=tvoje_ip_adresa'
        'pSQLHost=localhost'
        'pSQLPort=5432'
        'pSQLUser=postgres'
        'pSQLPassword=tvoje_heslo'
    )
    Set-Content -Path $envPath -Value $defaultEnv
    Write-Host "⚠️  Soubor .env nebyl nalezen, byl vytvořen nový s výchozími hodnotami. Nastavte správné hodnoty a spusťte skript znovu."
    exit 1
}

if (-not (Test-Path $service)) {
    # Hledej serviceAccountKey.json ve složce Downloads a případně ho přesun do složky projektu
    $downloadsPath = [Environment]::GetFolderPath("UserProfile") + "\Downloads\serviceAccountKey.json"
    if (Test-Path $downloadsPath) {
        Move-Item -Path $downloadsPath -Destination $service -Force
        Write-Host "✅ Soubor serviceAccountKey.json byl nalezen ve složce Downloads a přesunut do složky projektu."
    }
    else {
        Write-Host "❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌"
        Write-Host "🔑 Pokud máte soubor serviceAccountKey.json uložený v cloudovém úložišti (např. Discord, OneDrive apod.), stáhněte si ho odtud do složky 'api'."
        Write-Host "Pokud soubor nemáte, stiskněte Enter a zobrazí se další instrukce, jak ho získat."
        Write-Host "❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌"
        Read-Host
        Clear-Host
        Write-Host "❌ Soubor serviceAccountKey.json nebyl nalezen ve složce Downloads."
        Write-Host "Zkontrolujte, zda je soubor serviceAccountKey.json ve složce projektu."
        Write-Host "Pokud ne, stáhněte ho z Firebase Console a uložte do složky projektu."
        Write-Host "https://console.firebase.google.com/project/scautapp-1683e/settings/serviceaccounts/adminsdk"
        Write-Host "🔗 Otevřete odkaz a postupujte podle instrukcí:"
        Write-Host "1. Klikněte na tlačítko 'Generate new private key'."
        Write-Host "2. Uložte soubor 'serviceAccountKey.json' do složky 'api'."
        Write-Host "3. Informujte ostatní, že se změnily privátní klíče."
        Write-Host "4. Spusťte skript znovu."
        Write-Host 'Následně ho stačí přesunout do složky projektu nebo stažené soubory. 😍'
        exit
    }
}
else {
    Write-Host "✅ serviceAccountKey.json existuje"
}


# slozka Scripts neexistuje
if (-not (Test-Path $venvPath)) {
    Set-Location .\api\
    python -m venv .
    Set-Location .\Scripts\
    .\Activate.ps1
    Set-Location ..
    pip install -r requirements.txt
    Write-Host "✅ Vytvořen virtuální enviroment a nainstalovány závislosti"
}
else {
    # slozka Scripts existuje
    Write-Host "✅ Virtuální enviroment již existuje"
}


Set-Location $scriptPath
$envLines = Get-Content $envPath
$fastApiPort = $envLines[0].Split('=')[1]
# ziskani ip adresy pouze z Wireless LAN adapter Wi-Fi
$ipconfig = ipconfig
$wifiSection = $false
$ip = $null
foreach ($line in $ipconfig) {
    if ($line -match '^Wireless LAN adapter Wi-Fi') {
        $wifiSection = $true
    }
    elseif ($wifiSection -and $line -match '^\S') {
        # Nová sekce začíná, ukonči hledání
        break
    }
    elseif ($wifiSection -and $line -match 'IPv4 Address.*?:\s*(\d+\.\d+\.\d+\.\d+)') {
        $ip = $Matches[1]
        break
    }
}
if (-not $ip) {
    Write-Host "❌ Nepodařilo se najít IPv4 adresu pro Wi-Fi."
    exit 1
}

# zmeneni radku 2.[1] v souboru .env
try {
    $envLines[1] = "HOST=$ip"
    Write-Host "✅ IP adresa byla zapsána do .env: $ip"
    Set-Content -Path $envPath -Value $envLines
}
catch {
    Write-Host "❌ Došlo k chybě při čtení souboru .env: $($_.Exception.Message)"
    exit 1
}
# spusteni serveru
Set-Location $venvPath
.\Activate.ps1
Set-Location ..

try {
    uvicorn main:app --host $ip --port $fastApiPort --reload
    Write-Host "uvicorn main:app --host $ip --port $fastApiPort --reload"
    Write-Host "✅ uvicorn server byl úspěšně spuštěn"
}
catch {
    Write-Host "❌ Došlo k chybě při spuštění uvicorn serveru: $($_.Exception.Message)"
    exit 1
}

Read-Host -Prompt "Ini server - Stiskni Enter pro ukončení"