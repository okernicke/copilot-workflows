<#
.SYNOPSIS
Launch the Copilot swarm agents in external PowerShell terminals using Windows Terminal if available.

.DESCRIPTION
This script opens separate terminals for the swarm coordinator, TDD coordinator,
property test generator, quality guardian, and git orchestrator.
If Windows Terminal is available, it uses tabs. Otherwise it falls back to separate PowerShell windows.
#>

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$RepoRoot = Resolve-Path (Join-Path $ScriptDir "..")

$agents = @(
    @{ Name = 'Coordinator'; Agent = 'swarm-coordinator' },
    @{ Name = 'TDD Coordinator'; Agent = 'tdd-coordinator' },
    @{ Name = 'Property Test Generator'; Agent = 'property-test-generator' },
    @{ Name = 'Quality Guardian'; Agent = 'crap-analyzer' },
    @{ Name = 'Git Orchestrator'; Agent = 'git-orchestrator' }
)

$wt = Get-Command wt.exe -ErrorAction SilentlyContinue

function BuildCommand($agent) {
    return "Set-Location -LiteralPath '$RepoRoot'; copilot --model auto --agent $agent; Write-Host 'Press ENTER to close...'; Read-Host"
}

if ($null -ne $wt) {
    Write-Host "Launching Windows Terminal with swarm agent tabs..."
    
    # Hardcoded tabs for 5 agents
    $cmd1 = "Set-Location -LiteralPath '$RepoRoot'; copilot --model auto --agent swarm-coordinator; Write-Host 'Press ENTER to close...'; Read-Host"
    $cmd2 = "Set-Location -LiteralPath '$RepoRoot'; copilot --model auto --agent tdd-coordinator; Write-Host 'Press ENTER to close...'; Read-Host"
    $cmd3 = "Set-Location -LiteralPath '$RepoRoot'; copilot --model auto --agent property-test-generator; Write-Host 'Press ENTER to close...'; Read-Host"
    $cmd4 = "Set-Location -LiteralPath '$RepoRoot'; copilot --model auto --agent crap-analyzer; Write-Host 'Press ENTER to close...'; Read-Host"
    $cmd5 = "Set-Location -LiteralPath '$RepoRoot'; copilot --model auto --agent git-orchestrator; Write-Host 'Press ENTER to close...'; Read-Host"
    
    Write-Host "Starting Windows Terminal..." -ForegroundColor Green
    
    # Invoke wt with hardcoded tabs
    & cmd.exe /c "wt -d ""$RepoRoot"" powershell -NoExit -Command ""$cmd1"" ; new-tab -d ""$RepoRoot"" powershell -NoExit -Command ""$cmd2"" ; new-tab -d ""$RepoRoot"" powershell -NoExit -Command ""$cmd3"" ; new-tab -d ""$RepoRoot"" powershell -NoExit -Command ""$cmd4"" ; new-tab -d ""$RepoRoot"" powershell -NoExit -Command ""$cmd5"""
    
} else {
    Write-Host "Windows Terminal not found. Falling back to separate PowerShell windows."

    foreach ($entry in $agents) {
        $command = BuildCommand $entry.Agent
        Write-Host "Starting $($entry.Name)..." -ForegroundColor Yellow
        Start-Process powershell -ArgumentList '-NoExit', '-Command', $command
        Start-Sleep -Milliseconds 250
    }
}
