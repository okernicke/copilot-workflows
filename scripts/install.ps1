# ================================================
# scripts/install.ps1 - Agentic Coding Setup Installer
# Canonical installer entry point
# ================================================

[CmdletBinding()]
param(
    [string]$Config = "kotlin"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$RepoRoot = (Resolve-Path (Join-Path $ScriptDir "..")).Path
$CopilotRoot = Join-Path $env:USERPROFILE ".copilot"
$ConfigManifestPath = Join-Path $RepoRoot "configs\configs.json"

if (-not (Test-Path -LiteralPath $ConfigManifestPath -PathType Leaf)) {
    throw "Missing config manifest: $ConfigManifestPath"
}

$configManifest = Get-Content -LiteralPath $ConfigManifestPath -Raw | ConvertFrom-Json
$knownConfigs = @($configManifest | ForEach-Object { $_.name })

if ($Config -notin $knownConfigs) {
    Write-Host "Unknown config: $Config" -ForegroundColor Red
    Write-Host "Available configs:" -ForegroundColor Yellow
    foreach ($name in $knownConfigs) {
        Write-Host "  - $name"
    }
    exit 1
}

$ConfigRoot = Join-Path $RepoRoot ("configs\" + $Config)
if (-not (Test-Path -LiteralPath $ConfigRoot -PathType Container)) {
    throw "Config directory missing: $ConfigRoot"
}

function Ensure-Directory {
    param([string]$Path)
    New-Item -ItemType Directory -Path $Path -Force | Out-Null
}

function Remove-IfExists {
    param([string]$Path)
    if (Test-Path -LiteralPath $Path) {
        Remove-Item -LiteralPath $Path -Force -Recurse -ErrorAction SilentlyContinue
    }
}

function New-LinkOrCopy {
    param(
        [string]$Source,
        [string]$Target,
        [switch]$Directory
    )

    Remove-IfExists -Path $Target

    if (-not (Test-Path -LiteralPath $Source)) {
        Write-Host "Missing source: $Source" -ForegroundColor Yellow
        return
    }

    try {
        New-Item -ItemType SymbolicLink -Path $Target -Target $Source | Out-Null
        return
    } catch {
        Write-Host "Symlink failed for $Target. Falling back to copy." -ForegroundColor Yellow
    }

    if ($Directory) {
        Copy-Item -LiteralPath $Source -Destination $Target -Recurse -Force
    } else {
        Copy-Item -LiteralPath $Source -Destination $Target -Force
    }
}

Write-Host "Installing Agentic Coding Workflow Setup..." -ForegroundColor Cyan
Write-Host "Target: $CopilotRoot" -ForegroundColor Gray
Write-Host "Selected config: $Config" -ForegroundColor Gray

Ensure-Directory -Path (Join-Path $CopilotRoot "skills")
Ensure-Directory -Path (Join-Path $CopilotRoot "agents")
Ensure-Directory -Path (Join-Path $CopilotRoot "context")
Ensure-Directory -Path (Join-Path $CopilotRoot "swarm-configs")

Write-Host "Creating links for skills..." -ForegroundColor Cyan
$skills = Get-ChildItem -Path (Join-Path $RepoRoot "skills") -Directory | Select-Object -ExpandProperty Name
foreach ($skill in $skills) {
    $source = Join-Path $RepoRoot ("skills\" + $skill)
    $target = Join-Path $CopilotRoot ("skills\" + $skill)
    New-LinkOrCopy -Source $source -Target $target -Directory
    Write-Host "Prepared skill: $skill" -ForegroundColor Green
}

Write-Host "Creating links for agents..." -ForegroundColor Cyan
$agentFiles = Get-ChildItem -Path (Join-Path $RepoRoot "agents") -Filter "*.agent.md" | Select-Object -ExpandProperty Name
foreach ($agent in $agentFiles) {
    $source = Join-Path $RepoRoot ("agents\" + $agent)
    $target = Join-Path $CopilotRoot ("agents\" + $agent)
    New-LinkOrCopy -Source $source -Target $target
    Write-Host "Prepared agent: $agent" -ForegroundColor Green
}

Write-Host "Linking shared workflow files..." -ForegroundColor Cyan
$sharedFiles = @(
    @{ Source = "instructions\copilot-instructions.md"; Target = "copilot-instructions.md" },
    @{ Source = "MEMORY.md"; Target = "MEMORY.md" },
    @{ Source = "AGENTS.md"; Target = "AGENTS.md" },
    @{ Source = "README.md"; Target = "README.md" },
    @{ Source = "Agentic-Coding-Workflow-v0.6.md"; Target = "Agentic-Coding-Workflow-v0.6.md" },
    @{ Source = "vscode-swarm-setup.md"; Target = "vscode-swarm-setup.md" }
)

foreach ($file in $sharedFiles) {
    $source = Join-Path $RepoRoot $file.Source
    $target = Join-Path $CopilotRoot $file.Target
    New-LinkOrCopy -Source $source -Target $target
    Write-Host "Prepared shared file: $($file.Target)" -ForegroundColor Green
}

Write-Host "Linking config package assets for all supported configs..." -ForegroundColor Cyan
foreach ($configName in $knownConfigs) {
    $configSourceRoot = Join-Path $RepoRoot ("configs\" + $configName)
    $configTargetRoot = Join-Path $CopilotRoot ("swarm-configs\" + $configName)
    Ensure-Directory -Path $configTargetRoot

    $configAssetMap = @(
        @{ Source = (Join-Path $configSourceRoot "copilot-instructions.md"); Target = (Join-Path $configTargetRoot "copilot-instructions.md"); Directory = $false },
        @{ Source = (Join-Path $configSourceRoot "MEMORY.md"); Target = (Join-Path $configTargetRoot "MEMORY.md"); Directory = $false },
        @{ Source = (Join-Path $configSourceRoot "README.md"); Target = (Join-Path $configTargetRoot "README.md"); Directory = $false }
    )

    foreach ($asset in $configAssetMap) {
        if ($asset.Directory) {
            New-LinkOrCopy -Source $asset.Source -Target $asset.Target -Directory
        } else {
            New-LinkOrCopy -Source $asset.Source -Target $asset.Target
        }
    }

    Write-Host "Prepared config profile: $configName" -ForegroundColor Green
}


$syncScript = Join-Path $RepoRoot "scripts\sync-vscode-docs.ps1"
if (Test-Path -LiteralPath $syncScript -PathType Leaf) {
    Write-Host "Syncing .vscode/agents and .vscode/skills mirrors..." -ForegroundColor Cyan
    & $syncScript
}

Write-Host ""
Write-Host "Installation completed." -ForegroundColor Green
Write-Host "Copilot workflow root: $CopilotRoot" -ForegroundColor Cyan
Write-Host "Use: .\scripts\install.ps1 --config <kotlin|python>" -ForegroundColor Yellow
