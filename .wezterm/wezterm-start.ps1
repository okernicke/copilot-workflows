
[CmdletBinding()]
param(
    [string]$WorkingDirectory = (Get-Location).Path
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$RepoRoot = (Resolve-Path (Join-Path $ScriptDir "..")).Path
$linkScript = Join-Path $RepoRoot "scripts\link-project-copilot-instructions.ps1"
$resolvedWorkingDirectory = (Resolve-Path -LiteralPath $WorkingDirectory).Path

if (-not (Test-Path -LiteralPath $linkScript -PathType Leaf)) {
	throw "Missing link helper: $linkScript"
}

& $linkScript -ProjectRoot $resolvedWorkingDirectory

$projectInstructions = Join-Path $resolvedWorkingDirectory ".github\copilot-instructions.md"
if (-not (Test-Path -LiteralPath $projectInstructions -PathType Leaf)) {
	throw "Missing project Copilot instructions after preparation: $projectInstructions"
}

& wezterm start --cwd $resolvedWorkingDirectory