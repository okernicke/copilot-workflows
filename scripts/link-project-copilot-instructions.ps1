# ================================================
# scripts/link-project-copilot-instructions.ps1
# Ensure project-local .github/copilot-instructions.md is copied from this repo's instructions/copilot-instructions.md
# ================================================

[CmdletBinding()]
param(
    [string]$ProjectRoot = (Get-Location).Path
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$RepoRoot = (Resolve-Path (Join-Path $ScriptDir "..")).Path
$resolvedProjectRoot = (Resolve-Path -LiteralPath $ProjectRoot).Path
$sourceInstructions = Join-Path $RepoRoot "instructions\copilot-instructions.md"

if (-not (Test-Path -LiteralPath $sourceInstructions -PathType Leaf)) {
    throw "Missing source instructions at '$sourceInstructions'."
}

$githubDir = Join-Path $resolvedProjectRoot ".github"
New-Item -ItemType Directory -Path $githubDir -Force | Out-Null

$target = Join-Path $githubDir "copilot-instructions.md"
if (Test-Path -LiteralPath $target) {
    Remove-Item -LiteralPath $target -Force -Recurse -ErrorAction SilentlyContinue
}

Copy-Item -LiteralPath $sourceInstructions -Destination $target -Force
$firstLine = Get-Content -LiteralPath $target -TotalCount 1 -ErrorAction Stop

Write-Host "Copied project Copilot instructions:" -ForegroundColor Green
Write-Host "  $sourceInstructions -> $target"
Write-Host "Resolved first line: $firstLine" -ForegroundColor Gray
