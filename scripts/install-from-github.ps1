# One-shot: download aeas skill from GitHub into Cursor skill dirs (no clone needed).
# PowerShell:
#   irm https://raw.githubusercontent.com/neo-yang-dev/Cursor-Automotive-Electronics-Annotation-Standards/main/scripts/install-from-github.ps1 | iex
#
# Windows note: never delete KeepPath while cleaning legacy.

param(
    [string]$Owner = "neo-yang-dev",
    [string]$Repo = "Cursor-Automotive-Electronics-Annotation-Standards",
    [string[]]$Refs = @("main")
)

$ErrorActionPreference = "Stop"
$SkillName = "aeas"
$Files = @("SKILL.md", "examples.md", "AUTHOR")

function Test-Url([string]$Url) {
    try {
        $r = Invoke-WebRequest -Uri $Url -Method Head -UseBasicParsing -TimeoutSec 15
        return ($r.StatusCode -ge 200 -and $r.StatusCode -lt 400)
    } catch {
        return $false
    }
}

function Resolve-Base {
    foreach ($ref in $Refs) {
        $probe = "https://raw.githubusercontent.com/$Owner/$Repo/$ref/skills/aeas/SKILL.md"
        $author = "https://raw.githubusercontent.com/$Owner/$Repo/$ref/skills/aeas/AUTHOR"
        Write-Host "Probe $probe"
        if ((Test-Url $probe) -and (Test-Url $author)) {
            return @{
                Ref = $ref
                Dir = "aeas"
                Base = "https://raw.githubusercontent.com/$Owner/$Repo/$ref/skills/aeas"
            }
        }
    }
    throw "Could not find skills/aeas/SKILL.md on GitHub. Check network / repo, and that main already contains aeas."
}

function Get-PathKey([string]$Path) {
    return $Path.TrimEnd('\', '/').ToLowerInvariant()
}

function Remove-LegacyDirs([string]$Root, [string]$KeepPath) {
    $keepKey = Get-PathKey $KeepPath
    foreach ($legacy in @("ass", "ASS", "Ass", "ART", "art", "artstd", "art_std", "dsc-a", "dsc-b", "diagstack-c-comment-style")) {
        $p = Join-Path $Root $legacy
        if (-not (Test-Path $p)) { continue }
        if ((Get-PathKey $p) -eq $keepKey) {
            Write-Host "Skip legacy remove (same path as target on this OS): $p"
            continue
        }
        Remove-Item -Recurse -Force $p -ErrorAction SilentlyContinue
        Write-Host "Removed legacy: $p"
    }
}

$resolved = Resolve-Base
Write-Host "Using ref=$($resolved.Ref) dir=$($resolved.Dir)"

function Install-FromGitHub([string]$Root) {
    New-Item -ItemType Directory -Force -Path $Root | Out-Null
    $dst = Join-Path $Root $SkillName

    Remove-LegacyDirs -Root $Root -KeepPath $dst

    if (Test-Path $dst) {
        Remove-Item -Recurse -Force $dst
    }
    New-Item -ItemType Directory -Force -Path $dst | Out-Null

    foreach ($f in $Files) {
        $url = "$($resolved.Base)/$f"
        $out = Join-Path $dst $f
        Write-Host "GET $url"
        Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing
    }
    if (-not (Test-Path (Join-Path $dst "SKILL.md"))) {
        throw "Install failed: SKILL.md missing under $dst"
    }
    Write-Host "Installed: $dst"
}

Install-FromGitHub (Join-Path $env:USERPROFILE ".cursor\skills")
Install-FromGitHub (Join-Path $env:USERPROFILE ".agents\skills")

Write-Host ""
Write-Host "OK. Fully quit Cursor, reopen, NEW chat: @aeas or /aeas"
Write-Host "Check: dir $env:USERPROFILE\.cursor\skills\aeas"
