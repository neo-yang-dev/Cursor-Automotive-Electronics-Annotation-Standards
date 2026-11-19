# Push this repository (requires: gh auth login). The target repo already exists.
param(
    [string]$RepoName = "Cursor-Automotive-Electronics-Annotation-Standards",
    [ValidateSet("public", "private")]
    [string]$Visibility = "public",
    [string]$Description = "Cursor Agent Skills for Automotive Electronics Annotation Standards (AEAS): AUTOSAR Classic names, MISRA C, and comment style."
)

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path $PSScriptRoot -Parent

Push-Location $RepoRoot
try {
    $gh = Get-Command gh -ErrorAction SilentlyContinue
    if (-not $gh) {
        Write-Error "GitHub CLI (gh) not found. Install: winget install GitHub.cli"
    }

    $auth = gh auth status 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Not logged in. Run: gh auth login -h github.com -p https -w"
        exit 1
    }

    $branch = git branch --show-current
    if ($branch -ne "main") {
        git branch -M main
    }

    $hasOrigin = [bool](git remote 2>$null | Where-Object { $_ -eq "origin" })
    if ($hasOrigin) {
        Write-Host "Remote 'origin' already exists. Pushing..."
        git push -u origin main
    } else {
        gh repo create $RepoName `
            --$Visibility `
            --source=. `
            --remote=origin `
            --push `
            --description $Description
        if ($LASTEXITCODE -ne 0) {
            throw "gh repo create failed with exit code $LASTEXITCODE"
        }
    }

    $url = gh repo view --json url -q .url
    Write-Host ""
    Write-Host "Done: $url"
} finally {
    Pop-Location
}
