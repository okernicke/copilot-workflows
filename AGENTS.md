# Agents Overview – Copilot Workflows (v0.6)

This repository contains a generic agentic workflow setup for high-quality, test-driven development.

## Core Agents

### `swarm-coordinator` (Master agent)
- **Purpose**: Orchestrates multiple agents in parallel using a Swarm-style workflow.
- **Goal**: Maximize parallel work and coordinate the end-to-end process.
- **Best for**: Complex features and full story implementations.

### `tdd-coordinator` (Classic TDD agent)
- **Purpose**: Executes the traditional TDD cycle: Red → Green → Refactor → Quality Gates.
- **Best for**: Smaller changes or when a full swarm is not required.

## Specialized Skills

| Skill                        | Purpose                                              | Used by                    |
|-----------------------------|------------------------------------------------------|----------------------------|
| `concept-generator`         | Converts user stories into a structured implementation concept | Swarm / human review      |
| `acceptance-test-writer`    | Writes Gherkin acceptance tests based on the concept | Swarm / concept review     |
| `tdd-coordinator`           | Coordinates the TDD loop (Red -> Green -> Refactor -> quality gates) as a reusable workflow skill | `tdd-coordinator` |
| `tdd-red`                   | Writes failing tests first                           | `tdd-coordinator`          |
| `tdd-green`                 | Writes minimal code to pass the tests                | `tdd-coordinator`          |
| `tdd-refactor`              | Refactors code after tests pass                      | `tdd-coordinator`          |
| `property-test-generator`   | Generates property-based tests                       | Swarm / domain-focused     |
| `crap-analyzer`             | Performs CRAP risk analysis and design evaluation    | Quality Gates              |
| `git-orchestrator`          | Manages branching, atomic commits, squash, and PR prep | Swarm                    |
| `grill-with-docs`           | Stress-tests plans against domain and documentation  | Concept / review           |
| `grill-me`                  | Interactive design grilling with one-question-at-a-time decision-tree probing | Concept / review |
| `documentation-updater`     | Updates project docs like MEMORY.md, README, and ADRs | Documentation / review    |
| `review`                    | Two-axis diff review against standards and spec using parallel sub-agents | Quality Gates |
| `handoff`                   | Creates a concise handoff document for the next agent session | Collaboration |
| `caveman`                   | Ultra-compact response style for low-token, high-signal communication | Communication mode |
| `zoom-out`                  | Provides a broad, high-level architectural perspective | Exploration / design      |
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
   - `git-orchestrator` for version control and commit hygiene
   - Quality Gates (`crap-analyzer`, `architectural-reviewer`, `mutation-testing`, `coverage-check`)
5. **Final review & merge**

## VS Code integration

- `.vscode/tasks.json` launches the main agents quickly
- Recommended multi-terminal layout for swarm workflows
- Default model: `auto`

## Configuration

This repository supports multiple config packages under `configs/`, such as `configs/kotlin/` and `configs/python/`.

## Installation

```powershell
.\scripts\install.ps1
```
