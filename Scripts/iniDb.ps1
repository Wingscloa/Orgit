# Vytvoreni databaze Orgit pomoci pgAdmin (psql)
$dbName = "Orgit"
$sqlInitFile = "..\database\init DB.sql"
$sqlMockData = "..\database\mockData.sql"
$pgUser = "postgres"
$pgHost = "localhost"
$pgPort = "5432"
$pgPassword = $null

# Funkce pro barevny vystup s prefixem
function Write-Log {
    param(
        [string]$Message,
        [string]$Level = "INFO",
        [string]$Color = "White"
    )
    $prefix = "[$Level]"
    Write-Host "$prefix $Message" -ForegroundColor $Color
}

# Nacti .env a ziskej pSQLPassword, pokud chybi nebo je prazdne, zeptej se uzivatele a uloz do .env
$envPath = Join-Path $PSScriptRoot '..\.env'
$envLines = Get-Content $envPath
$pSQLPasswordLine = $envLines | Where-Object { $_ -match '^pSQLPassword=' }
$pSQLPassword = $null
if ($pSQLPasswordLine) {
    $pSQLPassword = $pSQLPasswordLine -replace '^pSQLPassword=', ''
}
if (-not $pSQLPassword -or [string]::IsNullOrWhiteSpace($pSQLPassword)) {
    $securePass = Read-Host -Prompt "Zadejte heslo k PostgreSQL uzivateli '$pgUser' (ulozi se do .env)" -AsSecureString
    $ptr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePass)
    $pSQLPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto($ptr)
    [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ptr)
    # Uloz do 6. radku .env
    $envLines[5] = "pSQLPassword=$pSQLPassword"
    Set-Content -Path $envPath -Value $envLines
    Write-Log "Heslo bylo ulozeno do .env na radek 6." "INFO" "Cyan"
}
$pgPasswordPlain = $pSQLPassword

# Funkce pro spusteni psql/createdb s heslem v promenne prostredi
function Invoke-PgCommand {
    param(
        [string]$command,
        [switch]$IgnoreErrors
    )
    try {
        $env:PGPASSWORD = $pgPasswordPlain
        $result = Invoke-Expression $command -ErrorAction SilentlyContinue
        Remove-Item Env:PGPASSWORD
        return $result
    }
    catch {
        Remove-Item Env:PGPASSWORD -ErrorAction SilentlyContinue
        if (-not $IgnoreErrors) {
            Write-Log "Chyba pri provadeni prikazu: $command" "ERROR" "Red"
            Write-Log "Error: $_" "ERROR" "Red"
        }
        return $false
    }
}

# KROK 1: Kontrola existence databaze Orgit
Write-Log "KROK 1: Kontroluji existenci databaze '$dbName'..." "INFO" "Cyan"
$checkDbCmd = "psql -U $pgUser -h $pgHost -p $pgPort -lqt | Select-String -Pattern '\b$($dbName)\b'"
$dbExists = Invoke-PgCommand $checkDbCmd

# Pokud databaze neexistuje, vytvor ji
if (-not $dbExists) {
    Write-Log "Databaze '$dbName' neexistuje, vytvarim novou..." "INFO" "Yellow"
    $createDbCmd = "createdb -U $pgUser -h $pgHost -p $pgPort $dbName"
    Invoke-PgCommand $createDbCmd
    if ($LASTEXITCODE -ne 0) {
        Write-Log "Chyba pri vytvareni databaze '$dbName'." "ERROR" "Red"
        Write-Log "Zkontrolujte, zda je PostgreSQL spusteny a pristupny." "ERROR" "Red"
        exit 1
    }
    else {
        Write-Log "Databaze '$dbName' byla uspesne vytvorena." "SUCCESS" "Green"   
    }
}
else {
    Write-Log "Databaze '$dbName' jiz existuje." "SUCCESS" "Green"
}

# KROK 2: Kontrola existence tabulek
Write-Log "KROK 2: Kontroluji existenci tabulek..." "INFO" "Cyan"
$checkUsersTableCmd = 'psql -U {0} -h {1} -p {2} -d {3} -tAc "SELECT 1 FROM pg_tables WHERE schemaname = ''public'' AND tablename = ''users'';"' -f $pgUser, $pgHost, $pgPort, $dbName
$tableExists = Invoke-PgCommand $checkUsersTableCmd -IgnoreErrors

if (-not $tableExists) {
    Write-Log "Tabulka 'Users' neexistuje, inicializuji tabulky dle souboru '$sqlInitFile'..." "INFO" "Yellow"
    $initCmd = "psql -U $pgUser -h $pgHost -p $pgPort -d $dbName -f '$sqlInitFile'"
    Invoke-PgCommand $initCmd
    if ($LASTEXITCODE -eq 0) {
        Write-Log "Tabulky byly uspesne inicializovany." "SUCCESS" "Green"
    }
    else {
        Write-Log "Chyba pri inicializaci tabulek." "ERROR" "Red"
        Write-Log "Zkontrolujte soubor $sqlInitFile." "INFO" "Yellow"
        exit 1
    }
}
else {
    Write-Log "Tabulka 'Users' jiz existuje." "SUCCESS" "Green"
}

# KROK 3: Kontrola existence dat v tabulkach
Write-Log "KROK 3: Kontroluji existenci dat v tabulkach..." "INFO" "Cyan"
$checkUsersDataCmd = 'psql -U {0} -h {1} -p {2} -d {3} -tAc "SELECT 1 FROM ""Users"" LIMIT 1;"' -f $pgUser, $pgHost, $pgPort, $dbName
$hasUsers = Invoke-PgCommand $checkUsersDataCmd -IgnoreErrors

if (-not $hasUsers) {
    Write-Log "Tabulka 'Users' je prazdna, inicializuji testovaci data dle souboru '$sqlMockData'..." "INFO" "Yellow"
    $mockDataCmd = "psql -U $pgUser -h $pgHost -p $pgPort -d $dbName -f '$sqlMockData'"
    Invoke-PgCommand $mockDataCmd
    if ($LASTEXITCODE -eq 0) {
        Write-Log "Testovaci data byla uspesne inicializovana." "SUCCESS" "Green"
    }
    else {
        Write-Log "Chyba pri inicializaci testovacich dat." "ERROR" "Red"
        Write-Log "Zkontrolujte soubor $sqlMockData." "INFO" "Yellow"
        exit 1
    }
}

else {
    Write-Log "Tabulka 'Users' jiz obsahuje data." "SUCCESS" "Green"
}

Write-Log "Inicializace databaze '$dbName' byla dokoncena." "SUCCESS" "Green"