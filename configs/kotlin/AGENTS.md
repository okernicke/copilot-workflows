# Agents Overview – Copilot Workflows (v0.6)

This package contains the Kotlin-specific agent and skill documentation for the shared workflow.

## Core Agents

### `swarm-coordinator` (Master agent)
- **Purpose**: Orchestrates multiple agents in parallel using a swarm-style workflow.
- **Goal**: Maximize parallel work while preserving quality.
- **Best for**: Complex features and full story delivery.

### `tdd-coordinator` (Classic TDD agent)
- **Purpose**: Runs the traditional TDD cycle: Red → Green → Refactor → Quality Gates.
- **Best for**: Smaller changes or when a full swarm is not required.

## Specialized Skills

| Skill                        | Purpose                                              | Used by                    |
|-----------------------------|------------------------------------------------------|----------------------------|
| `concept-generator`         | Converts user stories into a structured concept      | Swarm / human review       |
| `acceptance-test-writer`    | Writes Gherkin acceptance tests based on the concept | Swarm / concept review     |
| `tdd-red`                   | Writes failing tests first                           | `tdd-coordinator`          |
| `tdd-green`                 | Writes minimal code to pass the tests                | `tdd-coordinator`          |
| `tdd-refactor`              | Refactors code after tests pass                      | `tdd-coordinator`          |
| `property-test-generator`   | Generates property-based tests                       | Swarm / domain-focused     |
| `crap-analyzer`             | Performs CRAP risk analysis and design evaluation    | Quality Gates              |
| `git-orchestrator`          | Manages branching, atomic commits, squash, and PR prep | Swarm                    |
| `architectural-reviewer`    | Reviews architecture for clean boundaries and dependencies | Quality Gates          |
| `coverage-check`            | Checks test coverage and quality                     | Quality Gates              |
| `mutation-testing`          | Executes mutation testing                             | Quality Gates              |
| `code-review-tdd`           | Performs the final TDD-style code review             | Final gate                 |

## Workflow (v0.6)

1. **Concept** → `concept-generator`
2. **Gherkin Acceptance Tests** → `acceptance-test-writer`
3. Human review and approval
4. **Swarm implementation**:
   - `tdd-coordinator` + `property-test-generator` in parallel
   - `git-orchestrator` for commit hygiene
   - Quality gates (`crap-analyzer`, `architectural-reviewer`, `mutation-testing`, `coverage-check`)
5. **Final review & merge**

## VS Code integration

- `.vscode/tasks.json` starts the main agents quickly
- Recommended multi-terminal layout for swarm workflows
- Default model: `claude-haiku-4.5`

## Installation

```powershell
.\install.ps1 --config kotlin
```
