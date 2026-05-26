<#
.SYNOPSIS
Launch Copilot swarm agents in Windows Terminal Quake Mode with split panes (Option 3).

.DESCRIPTION
Opens a single Windows Terminal window in Quake Mode with 5 split panes,
each running a different copilot agent. All agents visible at once.
#>

$RepoRoot = "C:\projekte\copilot-workflows"

Write-Host "Launching Windows Terminal Quake Mode with 5 agent panes..." -ForegroundColor Green

# Quake Mode: single window with split panes
# Layout: 1 pane fills top half, 4 panes split the bottom half

$wt = Get-Command wt.exe -ErrorAction SilentlyContinue

if ($null -ne $wt) {
    # Start first pane (Coordinator) - occupies top
    & wt `
        -d "$RepoRoot" powershell -NoExit -Command "Set-Location -LiteralPath '$RepoRoot'; copilot --model auto --agent swarm-coordinator; Write-Host 'Press ENTER to close...'; Read-Host" `
        split-pane -H -d "$RepoRoot" powershell -NoExit -Command "Set-Location -LiteralPath '$RepoRoot'; copilot --model auto --agent tdd-coordinator; Write-Host 'Press ENTER to close...'; Read-Host" `
        split-pane -V -d "$RepoRoot" powershell -NoExit -Command "Set-Location -LiteralPath '$RepoRoot'; copilot --model auto --agent property-test-generator; Write-Host 'Press ENTER to close...'; Read-Host" `
        split-pane -V -d "$RepoRoot" powershell -NoExit -Command "Set-Location -LiteralPath '$RepoRoot'; copilot --model auto --agent crap-analyzer; Write-Host 'Press ENTER to close...'; Read-Host" `
        split-pane -V -d "$RepoRoot" powershell -NoExit -Command "Set-Location -LiteralPath '$RepoRoot'; copilot --model auto --agent git-orchestrator; Write-Host 'Press ENTER to close...'; Read-Host"
    
    Write-Host "Quake Mode window launched with 5 agent panes!" -ForegroundColor Green
} else {
    Write-Host "Windows Terminal (wt.exe) not found. Please install Windows Terminal." -ForegroundColor Red
    exit 1
}
