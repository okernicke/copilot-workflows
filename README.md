# Copilot Workflows

A generic, multi-language agentic workflow repository for high-quality development.

This repo supports multiple language-specific workflow profiles under `configs/`, currently including `kotlin` and `python`.

## Goal

Provide a fully agent-orchestrated development workflow with strong quality controls and clear conventions.

## Features

- **Swarm-first**: Parallel agent execution via VS Code multi-terminal layouts or WezTerm-based startup
- **Clean Architecture + DDD**
- **Automated Git orchestration** (branching, atomic commits, squash, PR preparation)
- **Cost-aware**: default model is Claude Haiku 4.5
- **Project-independent setup** via symlinks into `~/.copilot/`
- **Human checkpoints** only for concept review, acceptance test review, and final approval

## Installation

```powershell
.\scripts\install.ps1
```

## Quick start

1. Choose your terminal mode.
2. VS Code mode: open your project in VS Code, press `Ctrl + Shift + P` → **Tasks: Run Task**, then choose a `Swarm: ...` task.
3. WezTerm mode: run `./.wezterm/wezterm-start.ps1 -WorkingDirectory "<project-path>"`.
4. Use the installer:

```powershell
.\scripts\install.ps1
```

See [`.vscode/README.md`](.vscode/README.md) for terminal layout and setup tips.
See [`.wezterm/README.md`](.wezterm/README.md) for WezTerm setup and startup flow.

## Config package guide

- Supported config packages are defined in `configs/configs.json`.
- Use `scripts/install.ps1` to install the shared workflow and link all supported language profiles.
- A valid config package must include:
  - `global-instructions.md`
  - `MEMORY.md`
  - `README.md`
  - optional `agents/` for config-specific agent prompts
- Add new languages by creating `configs/<name>/` and adding an entry to `configs/configs.json`.

## Example workflow

1. Run installer once: `.\scripts\install.ps1`.
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

## Complete workflow (detailed)

### Phase 0: Preparation

- Create the user story or feature briefing.

### Phase 1: Concept creation

- Agent: `concept-generator`
- Output: project-specific concept document
- Human step: review, clarify open questions, approve

### Phase 2: Acceptance tests (Gherkin)

- Agent: `acceptance-test-writer`
- Output: Gherkin feature file
- Human step: review and approve acceptance tests

### Phase 3: Implementation (Swarm mode)

The `swarm-coordinator` orchestrates parallel roles:

- Main coder: `tdd-coordinator`
- Property tester: `property-test-generator`
- Quality guardian: `crap-analyzer`
- Git orchestrator: `git-orchestrator`
- Architecture guard: `architectural-reviewer`
- Final reviewer: `code-review-tdd`

Typical sequence:

1. Run `tdd-red` + `property-test-generator` in parallel.
2. Continue with `tdd-green`.
3. Refactor with `tdd-refactor`.
4. Execute quality gates.
5. Prepare merge with `git-orchestrator`.

### Phase 4: Completion

- Final human review
- Merge into `main`
- Run `documentation-updater` for docs refresh

## Git workflow

- Branch names: `feature/xyz` or `story/xyz`
- Commit prefixes: `red:`, `green:`, `refactor:`, `test:`, `chore:`, `docs:`
- `git-orchestrator` keeps commit hygiene and PR prep

## Skill inventory

Shared workflow skills are maintained in `skills/`.
For the complete, current list and descriptions (including utility skills like `review`, `handoff`, `grill-me`, and `caveman`), see [`AGENTS.md`](AGENTS.md).

## Important files

| File | Purpose |
|------|---------|
| [`AGENTS.md`](AGENTS.md) | Overview of agents and skills |
| [`CONTRIBUTING.md`](CONTRIBUTING.md) | Guidelines for config packages and contributions |
| [`.vscode/README.md`](.vscode/README.md) | VS Code swarm layout and terminal guide |
| [`.vscode/tasks.json`](.vscode/tasks.json) | Quick start tasks for all agents |
| `skills/` | Shared workflow skill prompts |
| `configs/` | Language-specific config packages and metadata |
| `scripts/install.ps1` | Canonical symlink-based setup installer |

## Philosophy

Maximize quality while minimizing manual routine work by using intelligent, specialized agents with clear responsibility separation.

---

**Next steps**

- Run a real feature through the workflow.
- Expand language-specific configuration packages.
- Keep `AGENTS.md` and workflow docs in sync when adding shared skills.

---
