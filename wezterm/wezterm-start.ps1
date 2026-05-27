

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$RepoRoot = (Resolve-Path (Join-Path $ScriptDir "..")).Path
$linkScript = Join-Path $RepoRoot "scripts\link-project-copilot-instructions.ps1"

if (-not (Test-Path -LiteralPath $linkScript -PathType Leaf)) {
	throw "Missing link helper: $linkScript"
}

& $linkScript -ProjectRoot "C:\projekte\kotlin\skills-katalog-backend"

Test-Path .\.github\copilot-instructions.md

wezterm start --cwd "C:\projekte\kotlin\skills-katalog-backend" 