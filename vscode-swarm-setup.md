# VS Code Swarm Setup – Agentic Coding Workflow

## Quick start

1. Press `Ctrl+Shift+P` → **Tasks: Run Task**.
2. Start `Swarm: Start Coordinator` (default model: Haiku 4.5).

**Tip**: Use `Swarm: Start Coordinator (Sonnet - expensive)` for complex refactorings or deep architecture decisions.

## Recommended terminal layout

- Terminal 1: Swarm Coordinator (Haiku)
- Terminal 2: TDD Coordinator (Haiku)
- Terminal 3: Property Test Generator (Haiku)
- Terminal 4: Quality + Git (Haiku)

**Cost strategy**:
- Default = the cheapest model (Haiku)
- Upgrade to stronger models only when needed

---

**Status**: v0.5 – cost optimization integrated

