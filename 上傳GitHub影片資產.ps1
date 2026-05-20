$ErrorActionPreference = "Stop"

$repo = "ykf7103-rgb/ai-infinity-ppt"
$tag = "video-assets-2026-05-20"
$title = "AI Infinity video assets 2026-05-20"
$notes = "Large video files for the AI Infinity HTML presentation."

$ai = (Resolve-Path -LiteralPath "MP4\AI IN ALL SUBJECTS.mp4").Path
$nodict = (Get-ChildItem -LiteralPath "MP4" -File | Where-Object { $_.Name -like "*V7.mov" } | Select-Object -First 1).FullName
$enrichment = (Get-ChildItem -LiteralPath "MP4" -File | Where-Object { $_.Extension -eq ".mp4" -and $_.Name -ne "AI IN ALL SUBJECTS.mp4" } | Select-Object -First 1).FullName

$assets = @($ai, $nodict, $enrichment)

gh auth status | Out-Host

foreach ($asset in $assets) {
  if (-not (Test-Path -LiteralPath $asset)) {
    throw "Missing video file: $asset"
  }
}

$releaseExists = $true
gh release view $tag --repo $repo *> $null
if ($LASTEXITCODE -ne 0) {
  $releaseExists = $false
}

if (-not $releaseExists) {
  gh release create $tag --repo $repo --title $title --notes $notes
}

gh release upload $tag --repo $repo --clobber @assets

Write-Host "Done: video assets uploaded to GitHub Release assets."
