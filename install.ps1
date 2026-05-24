# ================================================
# install.ps1 - Agentic Coding Setup Installer
# Run this script as Administrator
# ================================================

$RepoRoot = $PSScriptRoot
$CopilotRoot = "$env:USERPROFILE\.copilot"

Write-Host "🚀 Installing Agentic Coding Workflow Setup..." -ForegroundColor Cyan
Write-Host "Target: $CopilotRoot`n" -ForegroundColor Gray

# Create directories
New-Item -ItemType Directory -Path "$CopilotRoot\skills" -Force | Out-Null
New-Item -ItemType Directory -Path "$CopilotRoot\agents" -Force | Out-Null
New-Item -ItemType Directory -Path "$CopilotRoot\context" -Force | Out-Null
New-Item -ItemType Directory -Path "$CopilotRoot\swarm-configs" -Force | Out-Null

Write-Host "📁 Creating symlinks for Skills..." -ForegroundColor Cyan

# === All Skills ===
$skills = @(
    "concept-generator",
    "acceptance-test-writer",
    "tdd-red",
    "tdd-green",
    "tdd-refactor",
    "property-test-generator",
    "crap-analyzer",
    "git-orchestrator",
    "architectural-reviewer",
    "coverage-check",
    "mutation-testing",
    "code-review-tdd"
)

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

# Agents
$agents = @("tdd-coordinator.agent.md", "swarm-coordinator.agent.md")

foreach ($agent in $agents) {
    $source = Join-Path $RepoRoot "agents\$agent"
    $target = Join-Path $CopilotRoot "agents\$agent"
    
    if (Test-Path $target) { Remove-Item $target -Force }
    
    if (Test-Path $source) {
        New-Item -ItemType SymbolicLink -Path $target -Target $source | Out-Null
        Write-Host "✓ Symlinked agent: $agent" -ForegroundColor Green
    }
}

Write-Host "`n📋 Setting up global files..." -ForegroundColor Cyan

# Global files (mit korrekten Pfaden)
$globalFiles = @(
    @{ Source = "MEMORY.md";                  Target = "MEMORY.md" },
    @{ Source = "AGENTS.md";                  Target = "AGENTS.md" },
    @{ Source = "instructions/global-instructions.md"; Target = "global-instructions.md" },
    @{ Source = "vscode-swarm-setup.md";      Target = "vscode-swarm-setup.md" },
    @{ Source = "Agentic-Coding-Workflow-v0.6.md"; Target = "Agentic-Coding-Workflow-v0.6.md" }
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

Write-Host "`n⚙️  VS Code Swarm configuration is ready (copied via project setup)" -ForegroundColor Cyan

Write-Host "`n✅ Installation completed successfully!" -ForegroundColor Green
Write-Host "Global Copilot Agentic Setup is now active at: $CopilotRoot" -ForegroundColor Cyan
Write-Host "`nTipp: Für zukünftige Technologie-spezifische Konfigurationen (Java/Kotlin, Python, etc.)" -ForegroundColor Yellow
Write-Host "     können wir später eine Ordnerstruktur wie 'configs/kotlin/' einführen."