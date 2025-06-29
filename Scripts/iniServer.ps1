$scriptPath = Get-Location
$service = "..\api\serviceAccountKey.json"
$venvPath = "..\api\Scripts"
$envPath = "..\.env"
# --------------- #

if (-not (Test-Path $service)) {
    # Hledej serviceAccountKey.json ve složce Downloads a případně ho přesun do složky projektu
    $downloadsPath = [Environment]::GetFolderPath("UserProfile") + "\Downloads\serviceAccountKey.json"
    if (Test-Path $downloadsPath) {
        Move-Item -Path $downloadsPath -Destination $service -Force
        Write-Host "✅ Soubor serviceAccountKey.json byl nalezen ve složce Downloads a přesunut do složky projektu."
    }
    else {
        Write-Host "❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌"
        Write-Host "🔑 Pokud mate soubor serviceAccountKey.json ulozeny v cloudovem ulozisti (napr. Discord, OneDrive apod.), stahnete si ho odtud do slozky 'api'."
        Write-Host "Pokud soubor nemate, stisknete Enter a zobrazí se další instrukce, jak ho ziskat."
        Write-Host "❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌"
        Read-Host
        Clear-Host
        Write-Host "❌ Soubor serviceAccountKey.json nebyl nalezen ve složce Downloads."
        Write-Host "Zkontrolujte, zda je soubor serviceAccountKey.json ve složce projektu."
        Write-Host "Pokud ne, stahnete ho z Firebase Console a ulozte do složky projektu."
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
    Set-Location ..\api\
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