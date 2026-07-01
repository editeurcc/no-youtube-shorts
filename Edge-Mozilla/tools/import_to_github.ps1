#!/usr/bin/env pwsh
# Script interactif amélioré pour initialiser et pousser le projet local sur GitHub.
# Il détecte une remote existante et propose des options sûres.

function Exit-WithMessage($msg, $color = 'Yellow') {
    Write-Host $msg -ForegroundColor $color
    exit 0
}

$repoPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $repoPath

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Exit-WithMessage "Git n'est pas installé ou pas trouvé dans le PATH. Installe Git avant d'exécuter ce script." 'Red'
}

Write-Host "Chemin du projet : $repoPath" -ForegroundColor Cyan

# Demander l'URL distante
$remoteInput = Read-Host "Entrez l'URL du dépôt distant (ex. https://github.com/USER/REPO.git) ou laisse vide pour annuler"
if ([string]::IsNullOrWhiteSpace($remoteInput)) { Exit-WithMessage "Aucune URL fournie — annulation." }

# Vérifier s'il y a déjà un dépôt git local
$hasGitDir = Test-Path -Path (Join-Path $repoPath '.git')
if (-not $hasGitDir) {
    Write-Host "Aucun dépôt Git local détecté. Initialisation..." -ForegroundColor Green
    git init
}
else {
    Write-Host "Un dépôt Git local existe déjà." -ForegroundColor Yellow
}

# Vérifier si une remote 'origin' existe
$existingRemote = $null
try { $existingRemote = git remote get-url origin 2>$null } catch {}

if ($existingRemote) {
    Write-Host "Remote 'origin' existante : $existingRemote" -ForegroundColor Yellow
    $choice = Read-Host "Que voulez‑vous faire ? (1 = conserver, 2 = remplacer, 3 = pull+merge puis push) [1/2/3]"
    switch ($choice) {
        '1' {
            Write-Host "Conserver la remote existante." -ForegroundColor Cyan
            $remoteToUse = $existingRemote
        }
        '2' {
            Write-Host "Remplacement de la remote 'origin' par : $remoteInput" -ForegroundColor Cyan
            git remote remove origin
            git remote add origin $remoteInput
            $remoteToUse = $remoteInput
        }
        '3' {
            Write-Host "Pull depuis la remote existante, fusion si nécessaire (demande confirmation)." -ForegroundColor Cyan
            git fetch origin
            try {
                git pull origin main --allow-unrelated-histories
            }
            catch {
                Write-Host "Échec du pull automatique — résous les conflits manuellement puis relance." -ForegroundColor Red
                exit 1
            }
            $remoteToUse = $existingRemote
        }
        default {
            Exit-WithMessage "Choix invalide — annulation."
        }
    }
}
else {
    Write-Host "Aucune remote 'origin' détectée. Ajout de : $remoteInput" -ForegroundColor Green
    git remote add origin $remoteInput
    $remoteToUse = $remoteInput
}

# Stage et commit (si aucun commit n'existe encore)
$hasCommits = $false
try {
    $count = git rev-list --count HEAD 2>$null
    if ($count -and [int]$count -gt 0) { $hasCommits = $true }
}
catch {}

if (-not $hasCommits) {
    git add .
    git commit -m "Initial commit"
}

# Forcer la branche main
try { git branch -M main } catch {}

Write-Host "Prêt à pousser vers : $remoteToUse (branche main)." -ForegroundColor Cyan
$confirm = Read-Host "Confirmez l'exécution du push (oui/non)"
if ($confirm -ne 'oui') { Exit-WithMessage "Annulé par l'utilisateur." }

try {
    git push -u origin main
    Write-Host "Push terminé." -ForegroundColor Green
}
catch {
    Write-Host "Push échoué : $_" -ForegroundColor Red
    Write-Host "Si l'erreur est due à une divergence d'historique, envisagez d'exécuter manuellement : git pull origin main --allow-unrelated-histories" -ForegroundColor Yellow
    exit 1
}

