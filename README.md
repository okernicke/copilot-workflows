# Copilot Workflows

A generic, multi-language agentic workflow repository for high-quality development.

This repo supports multiple language-specific workflow profiles under `configs/`, currently including `kotlin` and `python`.

## Goal

Provide a fully agent-orchestrated development workflow with strong quality controls and clear conventions.

## Features

- **Swarm-first**: Parallel agent execution via VS Code multi-terminal layouts
- **Clean Architecture + DDD**
- **Automated Git orchestration** (branching, atomic commits, squash, PR preparation)
- **Cost-aware**: default model is Claude Haiku 4.5
- **Project-independent setup** via symlinks into `~/.copilot/`
- **Human checkpoints** only for concept review, acceptance test review, and final approval

## Installation

```powershell
.\install.ps1
```

## Quick start

1. Open your project in VS Code.
2. Press `Ctrl + Shift + P` → **Tasks: Run Task**.
3. Start `Swarm: Start Coordinator` or `Swarm: Start Coordinator (Sonnet - expensive)`.

Use the installer with a config parameter for language-specific setup:

```powershell
.\install.ps1 --config kotlin
.\install.ps1 --config python
```

See [`vscode-swarm-setup.md`](vscode-swarm-setup.md) for terminal layout and setup tips.

## Config package guide

- Supported config packages are defined in `configs/configs.json`.
- Use `install.ps1 --config <name>` to install the shared workflow plus a language-specific profile.
- A valid config package must include:
  - `global-instructions.md`
  - `MEMORY.md`
  - `README.md`
  - optional `agents/` for config-specific agent prompts
- Add new languages by creating `configs/<name>/` and adding an entry to `configs/configs.json`.

## Example workflow

1. Choose a config: `.\install.ps1 --config python` or `.\install.ps1 --config kotlin`.
2. Start the swarm coordinator in VS Code.
3. Run `concept-generator` and `acceptance-test-writer`.
4. Implement the feature with `tdd-coordinator`, `property-test-generator`, and quality gates.
5. Finish with `git-orchestrator` and `documentation-updater`.

## Workflow (v0.6)

1. **Concept** → `@concept-generator`
2. **Gherkin Acceptance Tests** → `@acceptance-test-writer`
3. Human review and approval
4. **Swarm implementation** → `@swarm-coordinator`
5. Quality gates + merge

## Important files

| File | Purpose |
|------|---------|
| [`Agentic-Coding-Workflow-v0.6.md`](Agentic-Coding-Workflow-v0.6.md) | Overall concept and workflow details |
| [`AGENTS.md`](AGENTS.md) | Overview of agents and skills |
| [`CONTRIBUTING.md`](CONTRIBUTING.md) | Guidelines for config packages and contributions |
| [`vscode-swarm-setup.md`](vscode-swarm-setup.md) | VS Code swarm layout and terminal guide |
| [`.vscode/tasks.json`](.vscode/tasks.json) | Quick start tasks for all agents |
| `skills/` | Shared workflow skill prompts |
| `configs/` | Language-specific config packages and metadata |
| `install.ps1` | Symlink-based setup installer |

## Philosophy

Maximize quality while minimizing manual routine work by using intelligent, specialized agents with clear responsibility separation.

---

**Next steps**

- Run a real feature through the workflow.
- Expand language-specific configuration packages.
- Add more shared skills such as `documentation-updater`.

---
