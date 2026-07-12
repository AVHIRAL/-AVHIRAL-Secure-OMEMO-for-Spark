$ErrorActionPreference = "Stop"

$sparkHomes = @(
    @(
        "$env:ProgramFiles\Spark",
        "$env:ProgramFiles\Ignite Realtime\Spark",
        "${env:ProgramFiles(x86)}\Spark",
        "${env:ProgramFiles(x86)}\Ignite Realtime\Spark",
        "$env:LOCALAPPDATA\Programs\Spark"
    ) | Where-Object { $_ -and (Test-Path -LiteralPath $_) }
)

if ($sparkHomes.Count -eq 0) {
    throw "Installation Spark introuvable."
}

$sparkHome = [string]$sparkHomes[0]
$dest = Join-Path $PSScriptRoot "lib\provided"
New-Item -ItemType Directory -Force -Path $dest | Out-Null

$sparkCore = Get-ChildItem -LiteralPath $sparkHome -Recurse -File `
    -Filter "spark-core-*.jar" -ErrorAction SilentlyContinue |
    Select-Object -First 1 -ExpandProperty FullName

$smackCore = Get-ChildItem -LiteralPath $sparkHome -Recurse -File `
    -Filter "smack-core-*.jar" -ErrorAction SilentlyContinue |
    Select-Object -First 1 -ExpandProperty FullName

if (-not $sparkCore) {
    throw "JAR Spark Core introuvable dans : $sparkHome"
}

Copy-Item -LiteralPath $sparkCore `
    -Destination (Join-Path $dest "spark-core.jar") -Force

Write-Host ""
Write-Host "Spark détecté :" -ForegroundColor Cyan
Write-Host "  Dossier    : $sparkHome"
Write-Host "  Spark Core : $sparkCore"
if ($smackCore) { Write-Host "  Smack Core : $smackCore" }
Write-Host ""
Write-Host "Copie terminée :" -ForegroundColor Green
Write-Host "  $(Join-Path $dest 'spark-core.jar')"
Write-Host ""
Write-Host "Cible : Spark 3.0.2 / Smack 4.4.6" -ForegroundColor Green
