<#
.SYNOPSIS
Sync root workflow docs into the .vscode agent/skill mirror directories.

.DESCRIPTION
Keep `agents/` and `skills/` as the canonical source of truth.
The `.vscode/agents/` and `.vscode/skills/` folders are generated mirrors used by VS Code.
#>

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$RepoRoot = Resolve-Path (Join-Path $ScriptDir "..")
$SyncMap = @{
    (Join-Path $RepoRoot 'agents') = (Join-Path $RepoRoot '.vscode\agents')
    (Join-Path $RepoRoot 'skills') = (Join-Path $RepoRoot '.vscode\skills')
}

foreach ($source in $SyncMap.Keys) {
    $destination = $SyncMap[$source]

    if (-not (Test-Path -Path $source -PathType Container)) {
        throw "Source directory not found: $source"
    }

    if (Test-Path -Path $destination) {
        Remove-Item -Path $destination -Recurse -Force
    }

    Copy-Item -Path $source -Destination $destination -Recurse -Force
    Write-Host "Synced $([IO.Path]::GetRelativePath($RepoRoot, $source)) -> $([IO.Path]::GetRelativePath($RepoRoot, $destination))"
}

Write-Host "`nSync complete."
