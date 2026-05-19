# ================================================
# install.ps1 - Symlink Copilot Skills, Agents & Memory
# Run this script as Administrator
# ================================================

$RepoRoot = $PSScriptRoot
$CopilotRoot = "$env:USERPROFILE\.copilot"

Write-Host "Setting up GitHub Copilot global configuration..." -ForegroundColor Cyan

# Create directories
New-Item -ItemType Directory -Path "$CopilotRoot\skills" -Force | Out-Null
New-Item -ItemType Directory -Path "$CopilotRoot\agents" -Force | Out-Null
New-Item -ItemType Directory -Path "$CopilotRoot\instructions" -Force | Out-Null

# === Symlink Skills ===
$skills = @("tdd-red", "tdd-green", "tdd-refactor", "coverage-check", "mutation-testing", "code-review-tdd")

foreach ($skill in $skills) {
    $source = Join-Path $RepoRoot "skills\$skill"
    $target = Join-Path $CopilotRoot "skills\$skill"
    
    if (Test-Path $target) { Remove-Item $target -Force -Recurse }
    New-Item -ItemType SymbolicLink -Path $target -Target $source | Out-Null
    Write-Host "✓ Symlinked skill: $skill" -ForegroundColor Green
}

# === Symlink Agents ===
$sourceAgent = Join-Path $RepoRoot "agents\tdd-coordinator.agent.md"
$targetAgent = Join-Path $CopilotRoot "agents\tdd-coordinator.agent.md"

if (Test-Path $targetAgent) { Remove-Item $targetAgent -Force }
New-Item -ItemType SymbolicLink -Path $targetAgent -Target $sourceAgent | Out-Null
Write-Host "✓ Symlinked agent: tdd-coordinator" -ForegroundColor Green

# === Symlink Global Instructions ===
$sourceInstr = Join-Path $RepoRoot "instructions\global-instructions.md"
$targetInstr = Join-Path $CopilotRoot "instructions\global-instructions.md"

if (Test-Path $targetInstr) { Remove-Item $targetInstr -Force }
New-Item -ItemType SymbolicLink -Path $targetInstr -Target $sourceInstr | Out-Null
Write-Host "✓ Symlinked global instructions" -ForegroundColor Green

# === Symlink MEMORY.md ===
$sourceMemory = Join-Path $RepoRoot "MEMORY.md"
$targetMemory = Join-Path $CopilotRoot "MEMORY.md"

if (Test-Path $targetMemory) { Remove-Item $targetMemory -Force }
New-Item -ItemType SymbolicLink -Path $targetMemory -Target $sourceMemory | Out-Null
Write-Host "✓ Symlinked MEMORY.md" -ForegroundColor Green

Write-Host "`n✅ Installation completed successfully!" -ForegroundColor Green
Write-Host "Global Copilot setup is now active." -ForegroundColor Cyan
Write-Host "Location: $CopilotRoot" -ForegroundColor Gray