# Vytvoření databáze Orgit pomocí pgAdmin (psql)
$dbName = "Orgit"
$sqlInitFile = "..\database\init DB.sql"
$sqlMockData = "..\database\mockData.sql"
$pgUser = "postgres"
$pgHost = "localhost"
$pgPort = "5432"
$pgPassword = $null

# Získání hesla od uživatele pouze jednou
if (-not $pgPassword) {
    $pgPassword = Read-Host -Prompt "Zadejte heslo k PostgreSQL uživateli '$pgUser'" -AsSecureString
    $pgPasswordPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pgPassword))
}

# Funkce pro spuštění psql/createdb s heslem v proměnné prostředí
function Invoke-PgCommand {
    param(
        [string]$command
    )
    $env:PGPASSWORD = $pgPasswordPlain
    Invoke-Expression $command
    Remove-Item Env:PGPASSWORD
}

# Pokud existuje tabulka Users a obsahuje data, přeskoč celý skript
$checkUsersDataCmd = 'psql -U {0} -h {1} -p {2} -d {3} -tAc "SELECT 1 FROM ""Users"" LIMIT 1;"' -f $pgUser, $pgHost, $pgPort, $dbName
$hasUsers = Invoke-PgCommand $checkUsersDataCmd
if ($hasUsers) {
    Write-Host "Databaze Orgit již existuje a obsahuje data. Skript bude ukončen."
    exit 0
}

$checkDbCmd = "psql -U $pgUser -h $pgHost -p $pgPort -lqt | Select-String -Pattern '\b$($dbName)\b'"
$dbExists = Invoke-PgCommand $checkDbCmd
# Databáze
# Vytvoření databáze Orgit
if (-not $dbExists) {
    $createDbCmd = "createdb -U $pgUser -h $pgHost -p $pgPort $dbName"
    Invoke-PgCommand $createDbCmd
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Chyba při vytváření databáze Orgit."
        exit 1
    }
    else {
        Write-Host "✅ Databáze Orgit byla vytvořena."   
    }
}
else {
    Write-Host "✅ Databáze Orgit již existuje."
}

# Tabulky
# Kontrola, zda databáze Orgit obsahuje tabulku Users
$checkUsersTableCmd = 'psql -U {0} -h {1} -p {2} -d {3} -tAc "SELECT 1 FROM pg_tables WHERE schemaname = ''public'' AND tablename = ''users'';"' -f $pgUser, $pgHost, $pgPort, $dbName
$tableExists = Invoke-PgCommand $checkUsersTableCmd

if (-not $tableExists) {
    Write-Host "❌ Tabulka 'Users' neexistuje. Inicializuji dle $sqlInitFile..."
    $initCmd = "psql -U $pgUser -h $pgHost -p $pgPort -d $dbName -f '$sqlInitFile'"
    Invoke-PgCommand $initCmd
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Tabulky byly úspěšně inicializovány."
    }
    else {
        Write-Host "❌ Chyba při inicializaci tabulek."
        exit 1
    }
}
else {
    Write-Host "✅ Tabulka 'Users' již existuje."
}

# Hodnoty
# Kontrola, zda tabulka Users obsahuje nějaká data
$checkUsersDataCmd = 'psql -U {0} -h {1} -p {2} -d {3} -tAc "SELECT 1 FROM ""Users"" LIMIT 1;"' -f $pgUser, $pgHost, $pgPort, $dbName
$hasUsers = Invoke-PgCommand $checkUsersDataCmd

if (-not $hasUsers) {
    Write-Host "❌ Tabulka 'Users' je prázdná. Inicializuji mock data..."
    $mockDataCmd = "psql -U $pgUser -h $pgHost -p $pgPort -d $dbName -f '$sqlMockData'"
    Invoke-PgCommand $mockDataCmd
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Mock data byla úspěšně inicializována."
    }
    else {
        Write-Host "❌ Chyba při inicializaci mock dat."
        exit 1
    }
}
else {
    Write-Host "✅ Tabulka 'Users' obsahuje data."
}