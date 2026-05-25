# Agentic Coding Workflow – My Future Development Setup (v0.6)

**Goal**: A fully agentic, highly automated development workflow with strong quality controls, inspired by Uncle Bob’s swarm-style practices.
**Status**: Mature concept updated for generic workflow and language-specific config packages.

## 1. Core Principles

- **Swarm-first**: Multiple specialized agents run in parallel using VS Code multi-terminal layouts.
- **TDD + Property-Based Testing** are non-negotiable.
- **Test overkill**: Unit + Integration + Gherkin Acceptance + Property-Based + Mutation + CRAP + Architecture Review.
- **Cost-aware**: Default model is `claude-haiku-4.5`. Upgrade to a stronger model only when needed.
- **Project-independent setup**: A dedicated workflow repo with symlinks into `~/.copilot/`.
- **Human checkpoints** only at concept review, acceptance-test review, and final approval.

## 2. Repository Structure

```bash
my-copilot-workflows/
├── configs/
│   ├── kotlin/
│   │   ├── global-instructions.md
│   │   ├── MEMORY.md
│   │   ├── README.md
│   │   └── AGENTS.md
│   ├── python/
│   │   ├── global-instructions.md
│   │   ├── MEMORY.md
│   │   ├── README.md
│   │   └── AGENTS.md
│   ├── template/
│   │   ├── global-instructions.md
│   │   ├── MEMORY.md
│   │   └── README.md
│   ├── configs.json
│   └── README.md
├── .vscode/
├── instructions/
├── vscode-swarm-setup.md
├── install.ps1
├── MEMORY.md
├── AGENTS.md
├── README.md
└── Agentic-Coding-Workflow-v0.6.md
```

## 3. Configuration model

- `configs/` contains language-specific workflow packages.
- Root-level `skills/` and `agents/` hold shared workflow assets.
- Each package provides `global-instructions.md`, `MEMORY.md`, and `README.md`.
- The installer picks the chosen config package and installs the shared workflow plus language-specific content.

## 4. Complete core workflow (per user story / feature)

### Phase 0: Preparation
- Create the user story or feature briefing.

### Phase 1: Concept creation
- **Agent**: `concept-generator`
- **Output**: A project-specific concept document.
- **Human**: Review, clarify open questions, approve the concept.

### Phase 2: Acceptance tests (Gherkin)
- **Agent**: `acceptance-test-writer`
- **Output**: A Gherkin feature file.
- **Human**: Review and approve the acceptance tests.

### Phase 3: Implementation (Swarm mode)

The `swarm-coordinator` orchestrates parallel agents:

| Role                    | Agent                          | Responsibility |
|-------------------------|--------------------------------|----------------|
| Main Coder              | `tdd-coordinator`              | Red → Green → Refactor |
| Property Tester         | `property-test-generator`      | Property-based tests |
| Quality Guardian        | `crap-analyzer`                | CRAP risk evaluation |
| Git Master              | `git-orchestrator`             | Branching, atomic commits, squash, PR prep |
| Architecture Guard      | `architectural-reviewer`       | Architecture review |
| Final Reviewer          | `code-review-tdd`              | Final code review |

**Typical Phase 3 flow**:
1. Run `tdd-red` + `property-test-generator` in parallel.
2. Continue with `tdd-green`.
3. Refactor with `tdd-refactor`.
4. Execute the quality gates.
5. Prepare merge with `git-orchestrator`.

### Phase 4: Completion
- Final human review.
- Merge into `main`.
- Run `documentation-updater` to refresh `MEMORY.md`, README, OpenAPI, and related docs.

### Example feature flow

1. Write the user story or brief.
2. Use `concept-generator` to produce a clear implementation concept.
3. Create Gherkin acceptance tests with `acceptance-test-writer`.
4. Implement the feature in swarm mode with `tdd-coordinator`, `property-test-generator`, and quality gates.
5. Close the change with `git-orchestrator` and `documentation-updater`.

## 5. Git workflow (automated)

- Branch names: `feature/xyz` or `story/xyz`
- Commit prefixes: `red:`, `green:`, `refactor:`, `test:`, `chore:`, `docs:`
- `git-orchestrator` manages commit hygiene.
- Final merge commits follow conventional commit style.

## 6. VS Code swarm setup

- Use multiple terminals in a swarm layout.
- `.vscode/tasks.json` launches the main workflow agents.
- Default model: Haiku-4.5.
- Communication is file-based and terminal-centric, avoiding direct prompt chat collisions.

## 7. Agent and skill inventory

**Core agents**:
- `swarm-coordinator`
- `tdd-coordinator`

**Specialized skills**:
- `concept-generator`
- `acceptance-test-writer`
- `property-test-generator`
- `crap-analyzer`
- `git-orchestrator`
- `architectural-reviewer`
- `tdd-red`, `tdd-green`, `tdd-refactor`
- `coverage-check`, `mutation-testing`, `code-review-tdd`

## 8. Configuration and extension

- Language and project conventions live in `configs/<language>/`.
- The root workflow stays technology-agnostic.
- Add new languages via additional config packages.

---

**Status**: **v0.6 — updated for config packages**
**Last updated**: 25 May 2026

---

**Next steps**

1. Expand the Python config package.
2. Consider a shared `configs/common/` package if needed.
3. Add more workflow skills such as `documentation-updater` and `schema-checker`.
