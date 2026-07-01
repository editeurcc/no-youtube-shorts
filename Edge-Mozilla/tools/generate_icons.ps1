<#
Génère des icônes redimensionnées à partir de support/icons/icon128.png
Crée: support/icons/icon128.png, icon64.png, icon32.png
Exécution : pwsh -NoProfile -ExecutionPolicy Bypass -File .\tools\generate_icons.ps1
#>

$src = 'support\\icons\\icon128.png'
$outDir = 'support\\icons'

if (-not (Test-Path $src)) {
    Write-Error "Source $src introuvable. Exécute d'abord tools\sync_icons.ps1 pour copier les icônes."
    exit 1
}

Add-Type -AssemblyName System.Drawing

$sizes = @(128, 64, 32)
$img = [System.Drawing.Image]::FromFile($src)
foreach ($s in $sizes) {
    $bmp = New-Object System.Drawing.Bitmap $s, $s
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.DrawImage($img, 0, 0, $s, $s)
    $outPath = Join-Path $outDir ("icon{0}.png" -f $s)
    $bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose()
    $bmp.Dispose()
    Write-Host "Wrote $outPath"
}
$img.Dispose()
Write-Host 'Icons generated.'
