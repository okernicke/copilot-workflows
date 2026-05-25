# Agents Overview – Copilot Workflows (v0.6)

Dieses Repository enthält mein persönliches agentenbasiertes Entwicklungs-Setup für hochqualitative, testgetriebene Softwareentwicklung.

## Haupt-Agenten

### `swarm-coordinator` (Master Agent)
- **Purpose**: Orchestriert mehrere Agenten parallel (Swarm-Modus)
- **Ziel**: Maximale Parallelisierung und Koordination des gesamten Workflows
- **Empfohlen für**: Komplexe Features und vollständige User Stories

### `tdd-coordinator` (Klassischer Haupt-Agent)
- **Purpose**: Führt den klassischen TDD-Zyklus (Red → Green → Refactor → Quality Gates) durch
- **Empfohlen für**: Einfachere Änderungen oder wenn kein voller Swarm benötigt wird

## Spezialisierte Skills

| Skill                        | Purpose                                              | Verwendet von              |
|-----------------------------|------------------------------------------------------|----------------------------|
| `concept-generator`         | Übersetzt User Stories in detaillierte Concepts      | Swarm / Mensch             |
| `acceptance-test-writer`    | Erstellt Gherkin Acceptance Tests                    | Swarm / nach Concept       |
| `tdd-red`                   | Schreibt failing Tests zuerst                        | tdd-coordinator            |
| `tdd-green`                 | Minimaler Code zum Bestehen der Tests                | tdd-coordinator            |
| `tdd-refactor`              | Verbessert Code bei grünen Tests                     | tdd-coordinator            |
| `property-test-generator`   | Generiert Property-Based Tests (Kotest + Arb)        | Swarm / Domain-Schwerpunkt |
| `crap-analyzer`             | Führt CRAP-Analyse durch und identifiziert Risiken   | Quality Gates              |
| `git-orchestrator`          | Branching, atomare Commits, Squash, PR-Vorbereitung  | Swarm                      |
| `architectural-reviewer`    | Strenges Architectural Review (Clean Architecture)   | Quality Gates              |
| `coverage-check`            | Überprüft Testabdeckung und Qualität                 | Quality Gates              |
| `mutation-testing`          | Führt Mutation Testing durch                         | Quality Gates              |
| `code-review-tdd`           | Finales Code Review nach Projektstandards            | Final Gate                 |

## Vollständiger Workflow (v0.6)

1. **Concept** → `concept-generator`
2. **Gherkin Acceptance Tests** → `acceptance-test-writer`
3. **Menschliche Abnahme** (Concept + Acceptance Tests)
4. **Swarm Implementation**:
   - `tdd-coordinator` + `property-test-generator` parallel
   - `git-orchestrator` für Versionierung
   - Quality Gates (`crap-analyzer`, `architectural-reviewer`, Mutation, Coverage)
5. **Final Review & Merge**

## VS Code Integration

- `.vscode/tasks.json` für schnellen Start aller Agenten
- Empfohlenes Multi-Terminal Layout (Swarm)
- Default-Modell: `claude-haiku-4.5` (kostengünstig)

## Installation

```powershell
# Als Administrator ausführen
.\install.ps1