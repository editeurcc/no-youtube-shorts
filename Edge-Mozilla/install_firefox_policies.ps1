# Script à exécuter en tant qu'administrateur
# Copie `NO-YOUTUBE-SHORTS-GUI-FIREFOX.xpi` dans %ProgramFiles%\Mozilla Firefox\distribution
# et crée `policies.json` pour forcer l'installation persistante de l'extension.

$root = 'C:\Users\wios\Desktop\Projets.2026\Edge-Mozilla'
$xpi = Join-Path $root 'NO-YOUTUBE-SHORTS-GUI-FIREFOX.xpi'
$dist = Join-Path $env:ProgramFiles 'Mozilla Firefox\distribution'

if (-not (Test-Path $xpi)) {
    Write-Error "Fichier .xpi introuvable: $xpi"
    exit 2
}

Write-Output "Destination: $dist"

try {
    New-Item -Path $dist -ItemType Directory -Force | Out-Null
    Copy-Item -Path $xpi -Destination $dist -Force

    $policies = @'
{
  "policies": {
    "Extensions": {
      "Install": [
        "file:///C:/Program Files/Mozilla Firefox/distribution/NO-YOUTUBE-SHORTS-GUI-FIREFOX.xpi"
      ]
    }
  }
}
'@

    $policiesPath = Join-Path $dist 'policies.json'
    $policies | Set-Content -Path $policiesPath -Encoding UTF8 -Force

    Write-Output "OK: Fichier .xpi copié et policies.json créé dans $dist"
}
catch {
    Write-Error "Erreur: $($_.Exception.Message)"
    exit 1
}

Write-Output "Redémarre Firefox pour appliquer la politique."
