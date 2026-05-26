<#
.SYNOPSIS
    Super simple test: Opens ONE Windows Terminal window with 5 panes.
    Each pane runs "java --version" + pause.
#>

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$RepoRoot = Resolve-Path (Join-Path $ScriptDir "..")

$wt = Get-Command wt.exe -ErrorAction SilentlyContinue

if ($null -eq $wt) {
    Write-Host "❌ Windows Terminal not found!" -ForegroundColor Red
    exit 1
}

Write-Host "🚀 Opening Windows Terminal with 5 panes..." -ForegroundColor Cyan

# Command that each pane runs
$testCommand = "cd '$RepoRoot'; java --version; Write-Host '=== Test finished - Press ENTER to close ===' -ForegroundColor Green; Read-Host"

# Build the wt command
$wtArgs = @(
    "-d", $RepoRoot,
    "powershell", "-NoExit", "-Command", $testCommand
)

# Add 4 more panes
$wtArgs += ";", "split-pane", "-V", "-d", $RepoRoot, "powershell", "-NoExit", "-Command", $testCommand
$wtArgs += ";", "move-focus", "left"
$wtArgs += ";", "split-pane", "-H", "-d", $RepoRoot, "powershell", "-NoExit", "-Command", $testCommand
$wtArgs += ";", "split-pane", "-H", "-d", $RepoRoot, "powershell", "-NoExit", "-Command", $testCommand
$wtArgs += ";", "split-pane", "-H", "-d", $RepoRoot, "powershell", "-NoExit", "-Command", $testCommand

# Execute
& wt @wtArgs

Write-Host "✅ Done. Check the new Windows Terminal window." -ForegroundColor Green