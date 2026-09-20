param(
  [string]$ApiBaseUrl = "https://virtueforge.goodwin.website",
  [ValidateSet("appbundle", "apk")]
  [string]$Target = "appbundle"
)

$ErrorActionPreference = "Stop"
Set-Location (Split-Path $PSScriptRoot -Parent)

if ([string]::IsNullOrWhiteSpace($ApiBaseUrl)) {
  throw "API_BASE_URL must not be empty."
}
if ($ApiBaseUrl -match "127\.0\.0\.1|localhost|10\.0\.2\.2") {
  throw "Refusing loopback API_BASE_URL for a release build: $ApiBaseUrl"
}

$keyProps = Join-Path "android" "key.properties"
if (-not (Test-Path $keyProps)) {
  Write-Warning "android/key.properties missing — release signing will fall back to debug. See key.properties.example."
}

Write-Host "Building Android $Target with API_BASE_URL=$ApiBaseUrl"
flutter build $Target --release "--dart-define=API_BASE_URL=$ApiBaseUrl"
