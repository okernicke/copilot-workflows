<#
.SYNOPSIS
Update run-swarm.ps1 with corrected Windows Terminal launcher
#>

$content = @'
<#
.SYNOPSIS
Launch the Copilot swarm agents in external PowerShell terminals using Windows Terminal.

.DESCRIPTION
Opens multiple tabs in Windows Terminal, one for each swarm agent.
If Windows Terminal is not available, falls back to separate PowerShell windows.
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

function BuildCommand {
    param([string]$agent, [string]$repoRoot)
    return "Set-Location -LiteralPath '$repoRoot'; copilot --model auto --agent $agent; Write-Host 'Press ENTER to close...'; Read-Host"
}

if ($null -ne $wt) {
    Write-Host "Launching Windows Terminal with swarm agent tabs..."
    
    # Build WT command as array of tokens, then join into single string
    $wtTokens = @()
    
    foreach ($entry in $agents) {
        $command = BuildCommand $entry.Agent $RepoRoot
        
        if ($wtTokens.Count -eq 0) {
            # First tab
            $wtTokens += 'nt'
            $wtTokens += '-w 0'
        } else {
            # Separator for new tab
            $wtTokens += ';'
            $wtTokens += 'new-tab'
        }
        
        $wtTokens += 'powershell'
        $wtTokens += '-NoExit'
        $wtTokens += '-Command'
        # Wrap command in single quotes to preserve special characters
        $wtTokens += "'$command'"
    }
    
    # Join to single string for direct invocation
    $wtArgs = $wtTokens -join ' '
    
    # Direct invocation: this is much more reliable than Start-Process
    Write-Host "Starting Windows Terminal..."
    & wt $wtArgs
    
} else {
    Write-Host "Windows Terminal not found. Falling back to separate PowerShell windows."
    
    foreach ($entry in $agents) {
        $command = BuildCommand $entry.Agent $RepoRoot
        Write-Host "Starting $($entry.Name)..."
        Start-Process powershell -ArgumentList '-NoExit', '-Command', $command
        Start-Sleep -Milliseconds 250
    }
}
'@

$content | Set-Content -Path (Join-Path $PSScriptRoot 'run-swarm.ps1') -Force -Encoding UTF8
Write-Host "✓ Updated scripts/run-swarm.ps1 with corrected Windows Terminal launcher"
