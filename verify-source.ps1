$ErrorActionPreference = "Stop"

$source = Join-Path $PSScriptRoot `
    "src\main\java\com\avhiral\spark\omemo\PersistentTrustCallback.java"

$content = Get-Content -LiteralPath $source -Raw

$expected = "import org.jivesoftware.smackx.omemo.trust.OmemoFingerprint;"

if ($content -notmatch [regex]::Escape($expected)) {
    throw "Import OmemoFingerprint incorrect dans PersistentTrustCallback.java"
}

Write-Host "Import OmemoFingerprint correct pour Smack 4.4.6." -ForegroundColor Green


$pluginSource = Join-Path $PSScriptRoot `
    "src\main\java\com\avhiral\spark\omemo\AvhOmemoPlugin.java"

$pluginContent = Get-Content -LiteralPath $pluginSource -Raw

$requiredProviders = @(
    "new OmemoVAxolotlProvider()",
    "new OmemoDeviceListVAxolotlProvider()",
    "new OmemoBundleVAxolotlProvider()"
)

foreach ($provider in $requiredProviders) {
    if ($pluginContent -notmatch [regex]::Escape($provider)) {
        throw "Provider OMEMO manquant : $provider"
    }
}

Write-Host "Providers OMEMO explicitement enregistrés." -ForegroundColor Green


$diagnosticSource = Join-Path $PSScriptRoot `
    "src\main\java\com\avhiral\spark\omemo\OmemoDiagnosticService.java"

if (-not (Test-Path -LiteralPath $diagnosticSource)) {
    throw "OmemoDiagnosticService.java absent."
}

$diagnosticContent = Get-Content -LiteralPath $diagnosticSource -Raw

$requiredDiagnosticTokens = @(
    "addAsyncStanzaListener",
    "addStanzaSendingListener",
    "detected.legacyAxolotl",
    "detected.omemo2",
    "ProviderManager.getExtensionProvider"
)

foreach ($token in $requiredDiagnosticTokens) {
    if ($diagnosticContent -notmatch [regex]::Escape($token)) {
        throw "Élément diagnostic manquant : $token"
    }
}

Write-Host "Instrumentation OMEMO 0.13 présente." -ForegroundColor Green


$pluginSource = Join-Path $PSScriptRoot `
    "src\main\java\com\avhiral\spark\omemo\AvhOmemoPlugin.java"

$pluginContent = Get-Content -LiteralPath $pluginSource -Raw

if ($pluginContent -notmatch [regex]::Escape("avhiral-omemo-wire-0.13.log")) {
    throw "Nom du journal filaire 0.13 introuvable dans AvhOmemoPlugin.java"
}

Write-Host "Chemin du journal filaire 0.13 présent." -ForegroundColor Green


$suppressorSource = Join-Path $PSScriptRoot `
    "src\main\java\com\avhiral\spark\omemo\OmemoFallbackSuppressor.java"

if (-not (Test-Path -LiteralPath $suppressorSource)) {
    throw "OmemoFallbackSuppressor.java absent."
}

$suppressorContent = Get-Content -LiteralPath $suppressorSource -Raw
$pluginContent = Get-Content -LiteralPath $pluginSource -Raw

$requiredSuppressorTokens = @(
    "containsLegacyOmemo",
    "message.setBody(null)",
    "addSyncStanzaListener",
    "removeSyncStanzaListener",
    "FALLBACK SUPPRESSED"
)

$combined = $suppressorContent + "`n" + $pluginContent

foreach ($token in $requiredSuppressorTokens) {
    if ($combined -notmatch [regex]::Escape($token)) {
        throw "Correctif fallback manquant : $token"
    }
}

Write-Host "Suppression synchrone du fallback OMEMO présente." `
    -ForegroundColor Green


$controllerSource = Join-Path $PSScriptRoot `
    "src\main\java\com\avhiral\spark\omemo\IntegratedChatController.java"

$controllerContent = Get-Content -LiteralPath $controllerSource -Raw
$pluginContent = Get-Content -LiteralPath $pluginSource -Raw

$required141 = @(
    "addMessageFilter(this)",
    "addTranscriptWindowInterceptor(this)",
    "filterIncoming(",
    "isMessageIntercepted(",
    "TRANSCRIPT FALLBACK BLOCKED",
    "getTranscriptWindow().insertMessage("
)

$combined141 = $pluginContent + "`n" + $controllerContent

foreach ($token in $required141) {
    if ($combined141 -notmatch [regex]::Escape($token)) {
        throw "Correctif 0.14.1 manquant : $token"
    }
}

Write-Host "Rendu visuel OMEMO Spark 0.14.1 présent." `
    -ForegroundColor Green


if ($controllerContent -notmatch [regex]::Escape(
        "import org.jivesoftware.spark.SparkManager;")) {
    throw "Import SparkManager absent dans IntegratedChatController.java"
}

Write-Host "Import SparkManager présent." -ForegroundColor Green
