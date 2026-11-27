<#
.SYNOPSIS
  Start comi locally in one go: Docker (Postgres, Redis, Mailpit) → backend API + worker → Flutter apps in Chrome.

.EXAMPLE
  .\dev.ps1                         # everything: API, worker, restaurant + customer + admin apps
  .\dev.ps1 -Apps restaurant        # API, worker and only the restaurant app
  .\dev.ps1 -Apps none              # backend only
  .\dev.ps1 -Reset                  # wipe the database and reload demo data first
  .\dev.ps1 -Stop                   # stop Docker services (close the app windows yourself)

  Each part opens in its own window. Close a window (or Ctrl+C in it) to stop that part.
  If scripts are blocked: powershell -ExecutionPolicy Bypass -File .\dev.ps1
#>
param(
  [ValidateSet('all', 'restaurant', 'customer', 'admin', 'none')]
  [string[]]$Apps = @('all'),
  [switch]$Reset,
  [switch]$Stop
)

# Not 'Stop': Windows PowerShell treats any stderr output of docker/npm as fatal. Exit codes are checked instead.
$ErrorActionPreference = 'Continue'
$root = $PSScriptRoot
$backend = Join-Path $root 'backend'

function Step($text) { Write-Host "`n==> $text" -ForegroundColor Cyan }
function Fail($text) { Write-Host "`nERROR: $text" -ForegroundColor Red; exit 1 }

# Opens a new PowerShell window running $command in $dir, titled $title.
function Start-Window($title, $dir, $command) {
  $script = "`$Host.UI.RawUI.WindowTitle = '$title'; Set-Location '$dir'; $command"
  Start-Process powershell -ArgumentList '-NoExit', '-NoProfile', '-Command', $script | Out-Null
  Write-Host "    started: $title" -ForegroundColor Green
}

Set-Location $root

if ($Stop) {
  Step 'Stopping Docker services'
  docker compose stop
  Write-Host 'Done. Close the API / worker / app windows yourself.'
  exit 0
}

# ── 1. Tools ────────────────────────────────────────────────────────────────
Step 'Checking tools'
foreach ($tool in 'docker', 'node', 'npm', 'flutter') {
  if (-not (Get-Command $tool -ErrorAction SilentlyContinue)) { Fail "$tool is not installed or not on PATH." }
}
docker info *> $null
if ($LASTEXITCODE -ne 0) { Fail 'Docker is not running. Start Docker Desktop, wait until it says "running", then run this again.' }

# ── 2. Database, Redis, Mailpit ─────────────────────────────────────────────
Step 'Starting Postgres, Redis and Mailpit (docker compose)'
docker compose up -d
if ($LASTEXITCODE -ne 0) { Fail 'docker compose up failed.' }

Write-Host '    waiting for Postgres' -NoNewline
$ready = $false
for ($i = 0; $i -lt 60; $i++) {
  docker compose exec -T postgres pg_isready -U comi *> $null
  if ($LASTEXITCODE -eq 0) { $ready = $true; break }
  Write-Host '.' -NoNewline
  Start-Sleep -Seconds 1
}
Write-Host ''
if (-not $ready) { Fail 'Postgres did not become ready in 60 s. Check: docker compose logs postgres' }

# ── 3. Backend: deps, env, database, build ─────────────────────────────────
Set-Location $backend
if (-not (Test-Path '.env')) {
  Step 'Creating backend\.env from .env.example'
  Copy-Item '.env.example' '.env'
}
if (-not (Test-Path 'node_modules')) {
  Step 'Installing backend packages (first run only)'
  npm install
  if ($LASTEXITCODE -ne 0) { Fail 'npm install failed.' }
}

Step 'Preparing the database'
npx prisma generate *> $null
if ($Reset) {
  npm run db:reset
} else {
  npm run db:deploy
}
if ($LASTEXITCODE -ne 0) { Fail 'Database migration failed.' }
npm run db:seed   # safe to repeat: existing demo data is skipped
if ($LASTEXITCODE -ne 0) { Fail 'Seeding demo data failed.' }

Step 'Building the backend (the worker runs the build)'
npm run build
if ($LASTEXITCODE -ne 0) { Fail 'Backend build failed.' }

# ── 4. API + worker in their own windows ───────────────────────────────────
Step 'Starting API and worker'
Start-Window 'comi API :3100' $backend 'npm run start:dev'
Start-Window 'comi worker' $backend 'npm run start:worker'

Write-Host '    waiting for the API' -NoNewline
$up = $false
for ($i = 0; $i -lt 90; $i++) {
  try {
    $r = Invoke-WebRequest -Uri 'http://localhost:3100/api/v1/health' -UseBasicParsing -TimeoutSec 2
    if ($r.StatusCode -eq 200) { $up = $true; break }
  } catch { }
  Write-Host '.' -NoNewline
  Start-Sleep -Seconds 1
}
Write-Host ''
if (-not $up) { Write-Host '    API not answering yet - look at the "comi API" window for errors.' -ForegroundColor Yellow }

# ── 5. Flutter apps (web, each on its own port) ────────────────────────────
$want = if ($Apps -contains 'all') { @('restaurant', 'customer', 'admin') } elseif ($Apps -contains 'none') { @() } else { $Apps }
if ($want.Count -gt 0) {
  Step 'Getting Flutter packages'
  Set-Location $root
  flutter pub get *> $null
  $apps = @{
    restaurant = @{ dir = 'restaurant_app'; port = 5001 }
    customer   = @{ dir = 'customer_app'; port = 5002 }
    admin      = @{ dir = 'admin_app'; port = 5003 }
  }
  Step 'Starting apps in Chrome'
  foreach ($name in $want) {
    $a = $apps[$name]
    Start-Window "comi $name app :$($a.port)" (Join-Path $root $a.dir) "flutter run -d chrome --web-port $($a.port) --dart-define=API_URL=http://localhost:3100"
  }
}

# ── 6. Summary ──────────────────────────────────────────────────────────────
Set-Location $root
Write-Host @"

comi is starting. Apps take ~1 minute to compile the first time.

  API          http://localhost:3100/api/v1/health
  Mailbox      http://localhost:8025          (emails the system sends)
  Restaurant   http://localhost:5001          owner@comi.vn / comi12345   (kitchen: bep@comi.vn)
  Customer     http://localhost:5002          any VN mobile, e.g. 0901234567 (no SMS in dev)
  Admin        http://localhost:5003          admin@comi.vn / comi12345, leave the code empty
                                              the first time and set up an authenticator app

  Stop: close the windows, then  .\dev.ps1 -Stop
"@ -ForegroundColor Green
