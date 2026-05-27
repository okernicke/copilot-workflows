# WezTerm Setup for Parallel Copilot Agents

This folder contains a WezTerm config that opens a 5-pane layout and starts the following agents automatically:

- swarm-coordinator
- tdd-coordinator
- property-test-generator
- crap-analyzer
- git-orchestrator

## 1) Install WezTerm (Windows)

Choose one method:

### Option A: winget (recommended)

```powershell
winget install --id WezFurlong.WezTerm -e
```

### Option B: Manual installer

1. Open: https://wezfurlong.org/wezterm/install/windows.html
2. Download the latest Windows installer.
3. Install WezTerm.

Verify installation:

```powershell
wezterm --version
```

## 2) Install and authenticate the Copilot CLI

Your panes run `copilot ...` commands, so the `copilot` command must be available in PATH and authenticated.

Check:

```powershell
copilot --help
```

If needed, install or update Copilot CLI and sign in before continuing.

## 3) Use this repository config as your active WezTerm config

WezTerm reads config from:

- `%USERPROFILE%\.wezterm.lua`

From this repository root, run:

```powershell
Copy-Item .\wezterm\.wezterm.lua "$env:USERPROFILE\.wezterm.lua" -Force
```

Alternative (symlink, good if you update the repo config often):

```powershell
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.wezterm.lua" -Target (Resolve-Path .\wezterm\.wezterm.lua) -Force
```

Note: Creating symbolic links may require Developer Mode or elevated permissions.

## 4) Start WezTerm

Launch WezTerm from Start menu or run:

```powershell
wezterm
```

For project-aware startup (recommended), run the helper script from this repository:

```powershell
.\wezterm\wezterm-start.ps1 -WorkingDirectory "C:\path\to\your\project"
```

This does two things before launching WezTerm:

1. Copies `copilot-instructions.md` into `.github/` of the target project.
2. Starts WezTerm with `--cwd` set to the target project.

On startup, this config will:

1. Create 3 columns.
2. Split middle and right columns into top/bottom panes.
3. Start 5 Copilot agents (one per pane).

## 5) Reload config after changes

Use `Ctrl+Shift+R` in WezTerm to reload config.

If reload fails, check errors with:

```powershell
wezterm start --always-new-process
```

## Troubleshooting

### `copilot` is not recognized

- Ensure Copilot CLI is installed.
- Restart WezTerm after updating PATH.
- Verify in PowerShell: `copilot --help`.

### WezTerm config not picked up

- Confirm `%USERPROFILE%\.wezterm.lua` exists.
- Ensure file content is valid Lua.
- Restart WezTerm completely.

### Pane commands do not start

- Check that the shell in WezTerm can run `copilot`.
- Temporarily replace one `send_text` command in `.wezterm.lua` with `echo test` to verify startup injection works.

## Optional tweaks

In `.wezterm.lua` you can safely change:

- `font_size`
- pane split sizes
- agent command model flags
