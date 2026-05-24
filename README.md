# mein-copilot-workflows

Mein persönliches **agentenbasiertes Entwicklungs-Setup** für hochqualitative Kotlin/Spring Boot Projekte.

## Ziel

Ein vollständig agenten-orchestrierter Entwicklungsworkflow mit extremem Test-Overkill (TDD + Property-Based + Mutation + CRAP + Architecture Review), inspiriert von Uncle Bob’s Swarm-Ansätzen.

## Features

- **Swarm-First**: Parallele Agenten via VS Code Multi-Terminals
- **Strenge Clean Architecture + DDD**
- **Automatisierte Git-Orchestrierung** (Branching, atomare Commits, Squash, PR-Vorbereitung)
- **Kostenoptimiert** (Default: Claude Haiku-4.5)
- **Projektunabhängig** durch Symlinks nach `~/.copilot/`
- **Menschliche Kontrollpunkte** nur bei Concept, Acceptance Tests und finaler Abnahme

## Installation

```powershell
# Als Administrator ausführen
.\install.ps1
```

## Schnellstart

1. Öffne dein Projekt in VS Code
2. Drücke `Ctrl + Shift + P` → **Tasks: Run Task**
3. Starte z. B. "**Swarm: Start Coordinator**" (günstig) oder "**Swarm: Start Coordinator (Sonnet - teuer)**"

Siehe [`vscode-swarm-setup.md`](vscode-swarm-setup.md) für detailliertes Terminal-Layout und Tipps.

## Workflow (v0.6)

1. **Concept** → `@concept-generator`
2. **Gherkin Acceptance Tests** → `@acceptance-test-writer`
3. Menschliche Review & Abnahme
4. **Swarm Implementation** → `@swarm-coordinator`
5. Quality Gates + Merge

## Wichtige Dateien

| Datei | Zweck |
|-------|------|
| [`Agentic-Coding-Workflow-v0.6.md`](Agentic-Coding-Workflow-v0.6.md) | Gesamtkonzept & detaillierter Workflow |
| [`AGENTS.md`](AGENTS.md) | Übersicht aller Agenten und Skills |
| [`vscode-swarm-setup.md`](vscode-swarm-setup.md) | VS Code Setup & Terminal-Layout |
| [`.vscode/tasks.json`](.vscode/tasks.json) | Schnellstart für alle Agenten |
| `skills/` | Alle spezialisierten Agenten-Skills |
| `install.ps1` | Symlink-Installation |

## Philosophie

Maximale Qualität bei minimaler manueller Routinearbeit durch intelligente, spezialisierte Agenten mit klarer Verantwortungstrennung.

---

**Nächste Schritte**

- Erste echte User Story komplett durch den Workflow führen
- Technologie-spezifische Konfigurationen auslagern (Kotlin, Python, etc.)
- Weitere Skills (z. B. `documentation-updater`)

---
