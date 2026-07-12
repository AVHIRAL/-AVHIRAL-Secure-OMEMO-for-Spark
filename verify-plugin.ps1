$ErrorActionPreference = "Stop"

$JarExe = "C:\Program Files\Java\jdk-17\bin\jar.exe"
$JavapExe = "C:\Program Files\Java\jdk-17\bin\javap.exe"
$PluginJar = Join-Path $PSScriptRoot "target\avhiral-omemo.jar"
$Temp = Join-Path $env:TEMP "avhiral-omemo-verify"

if (-not (Test-Path -LiteralPath $PluginJar)) {
    throw "Plugin absent : $PluginJar"
}

$item = Get-Item -LiteralPath $PluginJar
Write-Host "Taille : $($item.Length) octets" -ForegroundColor Cyan

if ($item.Length -lt 500000) {
    throw "Plugin incomplet : taille inférieure à 500 Ko."
}

$entries = & $JarExe tf $PluginJar
$required = @(
    "plugin.xml",
    "lib/avhiral-spark-omemo.jar",
    "lib/smack-omemo-4.4.6.jar",
    "lib/smack-omemo-signal-4.4.6.jar"
)

foreach ($entry in $required) {
    if ($entries -notcontains $entry) {
        throw "Entrée manquante : $entry"
    }
    Write-Host "OK : $entry" -ForegroundColor Green
}

Remove-Item $Temp -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path $Temp | Out-Null
Push-Location $Temp
try {
    & $JarExe xf $PluginJar "lib/avhiral-spark-omemo.jar"
    & $JarExe xf ".\lib\avhiral-spark-omemo.jar" `
        "com/avhiral/spark/omemo/AvhOmemoPlugin.class" `
        "com/avhiral/spark/omemo/IntegratedChatController.class"

    $classInfo = & $JavapExe -verbose `
        ".\com\avhiral\spark\omemo\AvhOmemoPlugin.class" |
        Select-String "major version"

    Write-Host $classInfo -ForegroundColor Cyan

    if ($classInfo -notmatch "52") {
        throw "Le plugin n'est pas compilé en Java 8 (major version 52)."
    }
}
finally {
    Pop-Location
}

Write-Host "Sparkplug OMEMO valide et compatible Java 8." -ForegroundColor Green
