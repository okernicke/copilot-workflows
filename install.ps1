# ================================================
# install.ps1 - Agentic Coding Setup Installer
# Run this script as Administrator
# ================================================

param(
    [string]$Config = "kotlin"
)

$RepoRoot = $PSScriptRoot
$CopilotRoot = "$env:USERPROFILE\.copilot"
$ConfigRoot = Join-Path $RepoRoot "configs\$Config"

if (-not (Test-Path $ConfigRoot)) {
    Write-Host "❌ Unknown config: $Config" -ForegroundColor Red
    Write-Host "Available configs:" -ForegroundColor Yellow
    Get-ChildItem -Path (Join-Path $RepoRoot 'configs') -Directory | ForEach-Object { Write-Host "  - $($_.Name)" }
    exit 1
}

Write-Host "🚀 Installing Agentic Coding Workflow Setup..." -ForegroundColor Cyan
Write-Host "Target: $CopilotRoot`n" -ForegroundColor Gray
Write-Host "Selected config: $Config`n" -ForegroundColor Gray

# Create directories
New-Item -ItemType Directory -Path "$CopilotRoot\skills" -Force | Out-Null
New-Item -ItemType Directory -Path "$CopilotRoot\agents" -Force | Out-Null
New-Item -ItemType Directory -Path "$CopilotRoot\context" -Force | Out-Null
New-Item -ItemType Directory -Path "$CopilotRoot\swarm-configs" -Force | Out-Null

Write-Host "📁 Creating symlinks for Skills..." -ForegroundColor Cyan

$skills = Get-ChildItem -Path (Join-Path $RepoRoot 'skills') -Directory | Select-Object -ExpandProperty Name

foreach ($skill in $skills) {
    $source = Join-Path $RepoRoot "skills\$skill"
    $target = Join-Path $CopilotRoot "skills\$skill"
    
    if (Test-Path $target) { Remove-Item $target -Force -Recurse -ErrorAction SilentlyContinue }
    
    if (Test-Path $source) {
        New-Item -ItemType SymbolicLink -Path $target -Target $source | Out-Null
        Write-Host "✓ Symlinked skill: $skill" -ForegroundColor Green
    } else {
        Write-Host "⚠️  Skill not found: $skill" -ForegroundColor Yellow
    }
}

Write-Host "`n🤖 Creating symlinks for Agents..." -ForegroundColor Cyan

$agentFiles = Get-ChildItem -Path (Join-Path $RepoRoot 'agents') -Filter '*.md' | Select-Object -ExpandProperty Name

foreach ($agent in $agentFiles) {
    $source = Join-Path $RepoRoot "agents\$agent"
    $target = Join-Path $CopilotRoot "agents\$agent"
    
    if (Test-Path $target) { Remove-Item $target -Force }
    
    if (Test-Path $source) {
        New-Item -ItemType SymbolicLink -Path $target -Target $source | Out-Null
        Write-Host "✓ Symlinked agent: $agent" -ForegroundColor Green
    } else {
        Write-Host "⚠️  Agent not found: $agent" -ForegroundColor Yellow
    }
}

Write-Host "`n📋 Setting up global files..." -ForegroundColor Cyan

$globalFiles = @(
    @{ Source = "MEMORY.md";                  Target = "MEMORY.md" },
    @{ Source = "AGENTS.md";                  Target = "AGENTS.md" },
    @{ Source = "README.md";                  Target = "README.md" },
    @{ Source = "Agentic-Coding-Workflow-v0.6.md"; Target = "Agentic-Coding-Workflow-v0.6.md" },
    @{ Source = "vscode-swarm-setup.md";      Target = "vscode-swarm-setup.md" }
)

foreach ($file in $globalFiles) {
    $source = Join-Path $RepoRoot $file.Source
    $target = Join-Path $CopilotRoot $file.Target
    
    if (Test-Path $target) { Remove-Item $target -Force }
    
    if (Test-Path $source) {
        Copy-Item $source $target -Force
        Write-Host "✓ Copied: $($file.Target)" -ForegroundColor Green
    } else {
        Write-Host "⚠️  File not found: $($file.Source)" -ForegroundColor Yellow
    }
}

Write-Host "`n📋 Setting up config-specific files..." -ForegroundColor Cyan

$configFiles = @(
    @{ Source = "configs\$Config\global-instructions.md"; Target = "global-instructions.md" },
    @{ Source = "configs\$Config\MEMORY.md"; Target = "MEMORY.md" },
    @{ Source = "configs\$Config\README.md"; Target = "config-README-$Config.md" }
)

foreach ($file in $configFiles) {
    $source = Join-Path $RepoRoot $file.Source
    $target = Join-Path $CopilotRoot $file.Target
    
    if (Test-Path $target) { Remove-Item $target -Force }
    
    if (Test-Path $source) {
        Copy-Item $source $target -Force
        Write-Host "✓ Copied config-specific file: $($file.Target)" -ForegroundColor Green
    } else {
        Write-Host "⚠️  Config file not found: $($file.Source)" -ForegroundColor Yellow
    }
}

Write-Host "`n⚙️  VS Code Swarm configuration is ready (copied via project setup)" -ForegroundColor Cyan

Write-Host "`n📂 Setting up workspace-level VS Code agents and skills..." -ForegroundColor Cyan

$VsCodeRoot = Join-Path $RepoRoot ".vscode"
New-Item -ItemType Directory -Path "$VsCodeRoot\agents" -Force | Out-Null
New-Item -ItemType Directory -Path "$VsCodeRoot\skills" -Force | Out-Null

# Copy agent files to workspace
Get-ChildItem -Path (Join-Path $RepoRoot 'agents') -Filter '*.agent.md' | ForEach-Object {
    Copy-Item $_.FullName (Join-Path $VsCodeRoot "agents\$($_.Name)") -Force | Out-Null
    Write-Host "✓ Copied agent: $($_.Name)" -ForegroundColor Green
}

# Copy skill files to workspace
Get-ChildItem -Path (Join-Path $RepoRoot 'skills') -Directory | ForEach-Object {
    $skillName = $_.Name
    $source = Join-Path $_.FullName "SKILL.md"
    $target = Join-Path $VsCodeRoot "skills\$skillName.md"
    if (Test-Path $source) {
        Copy-Item $source $target -Force | Out-Null
        Write-Host "✓ Copied skill: $skillName" -ForegroundColor Green
    }
}

Write-Host "`n✅ Installation completed successfully!" -ForegroundColor Green
Write-Host "Global Copilot Agentic Setup is now active at: $CopilotRoot" -ForegroundColor Cyan
Write-Host "`nTipp: Für zukünftige Technologie-spezifische Konfigurationen (Java/Kotlin, Python, etc.)" -ForegroundColor Yellow
Write-Host "     kannst du `install.ps1 --config <kotlin|python>` verwenden."