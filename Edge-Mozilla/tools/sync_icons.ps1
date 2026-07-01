<#
Copies extension icon files from the extension folders into support/icons for hosting.
Run from project root (PowerShell) as: .\tools\sync_icons.ps1
#>

$srcCandidates = @(
    'NO-YOUTUBE-SHORTS-GUI\\FIREFOX',
    'NO-YOUTUBE-SHORTS-GUI\\EDGE',
    'tmp_dist_xpi',
    'tmp_verify'
)

$dest = 'support\\icons'
If (-not (Test-Path $dest)) { New-Item -Path $dest -ItemType Directory | Out-Null }

$sizes = @('16', '32', '48', '128')

foreach ($size in $sizes) {
    $found = $false
    foreach ($src in $srcCandidates) {
        $srcPath = Join-Path $src "icon$size.png"
        if (Test-Path $srcPath) {
            Copy-Item -Path $srcPath -Destination (Join-Path $dest "icon$size.png") -Force
            Write-Host "Copied $srcPath -> $dest/icon$size.png"
            $found = $true
            break
        }
    }
    if (-not $found) { Write-Warning "icon$size.png not found in candidates" }
}

Write-Host "Done. Upload the 'support' folder contents to your webhost (free.fr)."
