# Install aeas skill to user skill dirs Cursor actually scans.
param(
    [string]$RepoRoot = (Split-Path $PSScriptRoot -Parent)
)

$ErrorActionPreference = "Stop"
$SkillName = "aeas"
$SkillSrc = Join-Path $RepoRoot "skills\$SkillName"

if (-not (Test-Path $SkillSrc)) {
    Write-Error "Skill source not found: $SkillSrc"
}

function Get-PathKey([string]$Path) {
    return $Path.TrimEnd('\', '/').ToLowerInvariant()
}

function Install-To([string]$Root) {
    New-Item -ItemType Directory -Force -Path $Root | Out-Null
    $dst = Join-Path $Root $SkillName
    $keepKey = Get-PathKey $dst

    foreach ($legacy in @("ass", "ASS", "Ass", "ART", "art", "artstd", "art_std", "dsc-a", "dsc-b", "diagstack-c-comment-style")) {
        $p = Join-Path $Root $legacy
        if (-not (Test-Path $p)) { continue }
        if ((Get-PathKey $p) -eq $keepKey) {
            Write-Host "Skip legacy remove (same path as target): $p"
            continue
        }
        Remove-Item -Recurse -Force $p
        Write-Host "Removed legacy: $p"
    }

    if (Test-Path $dst) {
        Remove-Item -Recurse -Force $dst
    }
    New-Item -ItemType Directory -Force -Path $dst | Out-Null
    Copy-Item -Recurse -Force (Join-Path $SkillSrc "*") $dst

    $skillMd = Join-Path $dst "SKILL.md"
    if (-not (Test-Path $skillMd)) {
        Write-Error "SKILL.md missing after install: $skillMd"
    }
    $author = Join-Path $dst "AUTHOR"
    if (-not (Test-Path $author)) {
        Write-Error "AUTHOR missing after install: $author"
    }
    Write-Host "Installed: $dst"
}

foreach ($root in @(
    (Join-Path $env:USERPROFILE ".cursor\skills"),
    (Join-Path $env:USERPROFILE ".agents\skills")
)) {
    Install-To $root
}

Write-Host ""
Write-Host "Verify with:"
Write-Host "  dir `$env:USERPROFILE\.cursor\skills\aeas\SKILL.md"
Write-Host ""
Write-Host "Then FULLY quit Cursor and reopen. New chat: @aeas or /aeas"
