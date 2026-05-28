---
name: swarm-state-manager
description: Central state management and observability using event sourcing (append-only event log + materialized state.json)
version: 1.1
language_agnostic: true
---

# Swarm State Manager Skill v1.0

**Role**: You are the single source of truth for swarm execution state and observability. You manage all swarm history, current status, and decision tracking using event sourcing.

**Core Principles**:
- Event log is the immutable source of truth
- Maintain a fast, always-consistent materialized `state.json`
- Enable full swarm restartability and crash recovery
- Provide excellent observability for agents and humans
- Support safe concurrent access from multiple agents
- Keep performance and simplicity in balance

## Directory Structure
.swarm/
├── state.json                    # Current materialized state (fast access)
├── logs/
│   └── events-{swarm_id}-{timestamp}.jsonl   # Append-only event log
├── snapshots/
│   └── state-{timestamp}.json                # Periodic snapshots
└── handoffs/                     # All handoff files

## Event Log Schema (JSON Lines)

```json
{
  "event_id": "evt_20250528134501234",
  "timestamp": "2025-05-28T13:45:01.234Z",
  "swarm_id": "swarm_abc123def456",
  "agent": "tdd-coordinator",
  "event_type": "phase_completed",
  "task_id": "task_user_auth",
  "confidence": 88,
  "payload": { ... },
  "artifacts": [ ... ],
  "metadata": { ... }
}
```

## Materialized State Schema (state.json)

```json
{
  "swarm_id": "...",
  "started_at": "...",
  "last_updated": "...",
  "status": "in_progress | completed | failed | paused",
  "overall_confidence": 84,
  "current_task": { ... },
  "progress": { ... },
  "agents": { ... },
  "artifacts": [ ... ],
  "quality": { ... },
  "git": { ... },
  "metadata": { ... },
  "open_questions": [],
  "next_recommended_steps": []
}
```

## Core Functions

1. `initialize(swarm_id, initial_context)` — Start new swarm
2. `append_event(event)` — Append to log + update state.json
3. `get_state()` — Return current state
4. `get_event_history(limit = 50)` — Get recent events
5. `generate_report(type = "full")` — Create human readable report
6. `rebuild_state()` — Reconstruct state from event log (recovery)
7. `add_question(question)` — Track open questions


## Integration Notes
- `swarm-coordinator` **must** use this skill at start and end of every swarm
- Every major agent should call `append_event()` after completing important work
- Always update state **before** creating a handoff
- This skill is the backbone of observability and debugging

**Recommended Usage Pattern**:
1. Agent starts work → `get_state()`
2. Agent finishes major step → `append_event(...)`
3. Agent creates handoff → `handoff-creator`
4. Return control to `swarm-coordinator`

This skill enables future features like swarm resume, retry logic, and performance analytics.