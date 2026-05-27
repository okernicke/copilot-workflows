# VS Code Swarm Setup – Agentic Coding Workflow

## Quick start

1. Press `Ctrl+Shift+P` → **Tasks: Run Task**.
2. Choose one of the available Swarm tasks below.

## Available tasks from `.vscode/tasks.json`

### Coordinator tasks
- `Swarm: Start Coordinator (Light)`
  - Launches the `swarm-coordinator` agent using `copilot --model auto --agent swarm-coordinator`.
  - Recommended for standard coordination sessions with the cheapest available model.

- `Swarm: Start Coordinator`
  - Also launches the `swarm-coordinator` agent with the same default auto model.
  - Use this when you want the standard coordinator task name.

- `Swarm: Start Coordinator (Sonnet - teuer)`
  - Launches the `swarm-coordinator` agent with `copilot --model claude-sonnet-4 --agent swarm-coordinator`.
  - Use this for deeper architecture decisions or expensive reasoning runs.

### Swarm agent tasks
- `Swarm: Start TDD Coordinator`
  - Starts the `tdd-coordinator` agent via `copilot --model auto --agent tdd-coordinator`.

- `Swarm: Start Property Test Generator`
  - Starts the `property-test-generator` agent via `copilot --model auto --agent property-test-generator`.

- `Swarm: Start Quality Guardian`
  - Starts the `crap-analyzer` agent via `copilot --model auto --agent crap-analyzer`.

- `Swarm: Start Git Orchestrator`
  - Starts the `git-orchestrator` agent via `copilot --model auto --agent git-orchestrator`.

### Composite task
- `Swarm: Start All Agents (Light)`
  - Starts the following tasks in parallel:
    - `Swarm: Start Coordinator (Light)`
    - `Swarm: Start TDD Coordinator`
    - `Swarm: Start Property Test Generator`
    - `Swarm: Start Quality Guardian`
    - `Swarm: Start Git Orchestrator`
  - The task uses `dependsOn` with `dependsOrder: parallel`.

### Project quality task
- `Swarm: Run All Quality Gates`
  - This task is repository-specific. In this project it runs the Gradle wrapper to execute `test`, `jacocoTestReport`, and `pitest`.
  - On Unix-like systems it uses `./gradlew`; on Windows it uses `gradlew.bat`.
  - If this workspace were a Python, Node, or other language project, the quality gate command would need to be replaced with the appropriate toolchain.
  - Use this to execute the project test suite, generate coverage, and run mutation testing.

### Agent/Skill documentation sync
- `agents/` and `skills/` at the repository root are the canonical source of truth.
- `.vscode/agents/` and `.vscode/skills/` are generated mirror copies used by VS Code integration.
- After editing root `agents/` or `skills/` content, run `powershell -ExecutionPolicy Bypass -NoProfile -File scripts/sync-vscode-docs.ps1`.
- You can also run the task `Swarm: Sync VS Code Agent/Skill Docs` from VS Code.
- Do not edit `.vscode/agents/` or `.vscode/skills/` directly.

### External terminal swarm launch
- `scripts/run-swarm.ps1` launches the swarm in external PowerShell terminals using Windows Terminal when available.
- `scripts/run-swarm.sh` launches the swarm in a `tmux` session on Linux.
- Communication is not via terminal pipes; each agent runs in its own shell session and coordination happens through the workspace/user workflow.
- Use `Swarm: Launch External PowerShell Terminals` to start the swarm from VS Code if you want an external terminal layout.

## Recommended terminal layout

- Terminal 1: Swarm Coordinator
- Terminal 2: TDD Coordinator
- Terminal 3: Property Test Generator
- Terminal 4: Quality + Git Orchestrator

**Cost strategy**:
- Default `--model auto` tasks are the least expensive option.
- Use `Swarm: Start Coordinator (Sonnet - teuer)` only when you need a stronger coordinator model.

---

**Status**: v0.6 – cost optimization integrated

