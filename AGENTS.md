# Agents Overview – Copilot Workflows

This repository contains my personal AI coding agents and skills.

## Main Agents

### `tdd-coordinator` (Main Agent)
- **Purpose**: Orchestrates full Test-Driven Development workflow
- **Workflow**: Red → Green → Refactor → Coverage → Mutation Testing → Final Review
- **Recommended**: This is the main agent you should talk to for new features

## Skills

| Skill                | Purpose                                      | Used By              |
|----------------------|----------------------------------------------|----------------------|
| `tdd-red`            | Write failing test first                     | tdd-coordinator      |
| `tdd-green`          | Minimal implementation to pass test          | tdd-coordinator      |
| `tdd-refactor`       | Improve code quality while tests stay green  | tdd-coordinator      |
| `coverage-check`     | Check test coverage and quality              | tdd-coordinator      |
| `mutation-testing`   | Run mutation testing for test strength       | tdd-coordinator      |
| `code-review-tdd`    | Final architecture & standards review        | tdd-coordinator      |

## Usage

Start a new task by talking to the **TDD Coordinator**:

> @tdd-coordinator Implement the feature to create a new Skillkategorie with German and English name.

---

**Repository**: `yourusername/copilot-workflows`
**Last Updated**: 2026