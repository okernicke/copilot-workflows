<#
.SYNOPSIS
Sync root workflow docs into the .vscode agent/skill mirror directories.

.DESCRIPTION
Keep `agents/` and `skills/` as the canonical source of truth.
The `.vscode/agents/` and `.vscode/skills/` folders are generated mirrors used by VS Code.
#>

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$RepoRoot = Resolve-Path (Join-Path $ScriptDir "..")

function Get-RelativePathCompat {
    param(
        [Parameter(Mandatory = $true)][string]$BasePath,
        [Parameter(Mandatory = $true)][string]$TargetPath
    )

    if ([System.IO.Path].GetMethod('GetRelativePath', [type[]]@([string], [string]))) {
        return [System.IO.Path]::GetRelativePath($BasePath, $TargetPath)
    }

    $baseUri = New-Object System.Uri((Resolve-Path -Path $BasePath).Path.TrimEnd('\\') + '\\')
    $targetUri = New-Object System.Uri((Resolve-Path -Path $TargetPath).Path)
    $relativeUri = $baseUri.MakeRelativeUri($targetUri)
    return [System.Uri]::UnescapeDataString($relativeUri.ToString()).Replace('/', '\\')
}

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
    $relativeSource = Get-RelativePathCompat -BasePath $RepoRoot -TargetPath $source
    $relativeDestination = Get-RelativePathCompat -BasePath $RepoRoot -TargetPath $destination
    Write-Host "Synced $relativeSource -> $relativeDestination"
}

Write-Host "`nSync complete."
