# Kotlin Config Package

This package contains the Kotlin-specific workflow profile for Copilot Workflows.

## Goal

Provide Kotlin/Spring Boot conventions, architecture guidance, and workflow integration for the shared agentic setup.

## Features

- **Swarm-first**: Parallel agent execution via VS Code multi-terminal layouts
- **Kotlin + Spring Boot** conventions
- **Kotest + MockK** support
- **Clean Architecture + DDD** guidance
- Config-specific instructions and memory for Kotlin projects
- Shared workflow agents and skills remain at the repo root

## Installation

```powershell
.\scripts\install.ps1 --config kotlin
```

## What is included

- `global-instructions.md` — Kotlin-specific coding and testing rules.
- `MEMORY.md` — Kotlin-specific project memory, conventions, and architecture guidance.
- `README.md` — config-specific documentation and usage notes.
- `AGENTS.md` — config-specific agent overview.
- Optional `agents/` if additional Kotlin-specific prompts are needed.

Shared workflow agents and skills are located at the repository root in `agents/` and `skills/`.

For config package requirements and manifest conventions, see `../README.md` and `../configs.json`.

## Quick start

1. Open your project in VS Code.
2. Press `Ctrl + Shift + P` → **Tasks: Run Task**.
3. Start `Swarm: Start Coordinator` or `Swarm: Start Coordinator (Sonnet - expensive)`.

See [`vscode-swarm-setup.md`](../../vscode-swarm-setup.md) for terminal layout and setup tips.

## Workflow (v0.6)

1. **Concept** → `@concept-generator`
2. **Gherkin Acceptance Tests** → `@acceptance-test-writer`
3. Human review and approval
4. **Swarm implementation** → `@swarm-coordinator`
5. Quality gates + merge

## Important files

| File | Purpose |
|------|---------|
| [`Agentic-Coding-Workflow-v0.6.md`](../../Agentic-Coding-Workflow-v0.6.md) | Concept and workflow reference |
| [`AGENTS.md`](AGENTS.md) | Kotlin config agent overview |
| [`vscode-swarm-setup.md`](../../vscode-swarm-setup.md) | VS Code terminal layout guide |
| [`.vscode/tasks.json`](../../.vscode/tasks.json) | Quick start tasks for agents |
| [`scripts/install.ps1`](../../scripts/install.ps1) | Canonical symlink-based setup |

## Philosophy

Maximize quality with minimal manual routine work using intelligent, specialized agents and clear responsibility separation.

---

**Next steps**

- Run a real feature through the workflow.
- Expand language-specific config packages.
- Add more shared skills such as `documentation-updater`.

---
