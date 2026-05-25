# Agentic Coding Workflow – Mein Zukünftiges Entwicklungs-Setup (v0.6)

**Ziel**: Ein vollständig agentenbasiertes, hochautomatisiertes Entwicklungs-Setup mit extremem Test-Overkill, inspiriert von Uncle Bob’s Swarm-Ansätzen.  
**Status**: Reifes, produktionsreifes Konzept mit generischem Workflow und sprachspezifischen Config-Paketen.

## 1. Grundprinzipien

- **Swarm-First**: Mehrere spezialisierte Agenten arbeiten parallel (VS Code Multi-Terminal).
- **TDD + Property-Based Testing** als Non-Negotiable.
- **Test-Overkill**: Unit + Integration + Gherkin Acceptance + Property-Based + Mutation + CRAP + Architecture Review.
- **Kostenoptimierung**: Default = `claude-haiku-4.5` (günstig). Nur bei Bedarf auf stärkere Modelle (z. B. Sonnet) wechseln.
- **Projektunabhängiges Setup**: Eigenes Git-Repo (`mein-copilot-workflows`) mit Symlinks nach `~/.copilot/`.
- **Menschliche Kontrollpunkte**: Nur bei Concept-Review, Acceptance-Test-Review und finaler Abnahme.

## 2. Repository-Struktur

```bash
mein-copilot-workflows/
├── configs/
│   ├── kotlin/
│   │   ├── agents/
│   │   ├── skills/
│   │   ├── instructions/
│   │   ├── MEMORY.md
│   │   ├── README.md
│   │   └── ...
│   └── python/
│       ├── agents/
│       ├── skills/
│       ├── instructions/
│       ├── MEMORY.md
│       ├── README.md
│       └── ...
├── .vscode/
├── instructions/
├── vscode-swarm-setup.md
├── install.ps1
├── MEMORY.md
├── AGENTS.md
└── README.md
```

## 3. Konfigurationsmodell

- `configs/common/` (oder der Root) enthält die generische Workflow-Beschreibung und Shared Assets.
- `configs/kotlin/` enthält die Kotlin- und Spring Boot-spezifischen Agenten- und Skill-Prompts.
- `configs/python/` enthält die Python-spezifischen Agenten- und Skill-Prompts.
- Der Installer wählt beim Setup den gewünschten Config-Paket aus und installiert gemeinsame sowie sprachspezifische Inhalte.

## 4. Der Vollständige Kern-Workflow (pro User Story / Feature)

### Phase 0: Vorbereitung
- User Story als `user-stories/feature-xyz.md` anlegen.

### Phase 1: Concept Creation
- **Agent**: `concept-generator`
- **Output**: Konzeptdatei im Projektkontext
- **Mensch**: Review + Klärung aller offenen Punkte → Abnahme.

### Phase 2: Acceptance Tests (Gherkin)
- **Agent**: `acceptance-test-writer`
- **Output**: Gherkin Feature-Datei
- **Mensch**: Review + Abnahme der Akzeptanztests.

### Phase 3: Technische Umsetzung (Swarm-Modus)

**Swarm Coordinator** startet und koordiniert parallele Agenten:

| Rolle                    | Agent                          | Aufgabe |
|-------------------------|--------------------------------|--------|
| **Main Coder**          | `tdd-coordinator`              | Red → Green → Refactor |
| **Property Tester**     | `property-test-generator`      | Property-Based Tests |
| **Quality Guardian**    | `crap-analyzer`                | CRAP-Analyse + Risikobewertung |
| **Git Master**          | `git-orchestrator`             | Branching, atomare Commits, Squash, PR |
| **Architecture Guard**  | `architectural-reviewer`       | Architektur-Review |
| **Final Reviewer**      | `code-review-tdd`              | Finaler Code-Review |

**Typischer Ablauf in Phase 3**:
1. Parallel: `tdd-red` + `property-test-generator`
2. `tdd-green`
3. `tdd-refactor`
4. Quality Gates (parallel ausführbar)
5. `git-orchestrator` bereitet Merge vor

### Phase 4: Abschluss
- Finale menschliche Review
- Merge in `main`
- Optional: `documentation-updater`

## 5. Git Workflow (automatisiert)

- Branch-Namen: `feature/xyz` oder `story/xyz`
- Commit-Prefixe: `red:`, `green:`, `refactor:`, `test:`, `chore:`, `docs:`
- `git-orchestrator` managt alle Commits
- Finale Merge-Commits im Conventional-Commit-Format

## 6. VS Code Swarm Setup

- Mehrere Terminals parallel (Swarm-Layout)
- `.vscode/tasks.json` für schnelle Agenten-Starts
- Default-Modell: Haiku-4.5
- Kommunikation über `.swarm/communication/`

## 7. Vollständige Liste der Agenten & Skills

**Haupt-Agenten**:
- `swarm-coordinator` (Master-Orchestrator)
- `tdd-coordinator`

**Spezial-Skills**:
- `concept-generator`
- `acceptance-test-writer`
- `property-test-generator`
- `crap-analyzer`
- `git-orchestrator`
- `architectural-reviewer`
- `tdd-red`, `tdd-green`, `tdd-refactor`
- `coverage-check`, `mutation-testing`, `code-review-tdd`

## 8. Konfiguration und Erweiterung

- Die Sprache und Projektkonventionen werden über `configs/<language>/` gesteuert.
- Der Root-Workflow bleibt technologie-agnostisch.
- Neue Sprachen können mittels zusätzlichem Config-Paket ergänzt werden.

---

**Status**: **v0.6 – Aktualisiert für configs/**
**Letztes Update**: 25. Mai 2026

---

**Nächste Schritte**

1. Python-Konfiguration weiter ausbauen.
2. Generic `configs/common/` bei Bedarf einführen.
3. Weitere Skill-Pakete (`documentation-updater`, `schema-checker` etc.) hinzufügen.
