---
name: swarm-state-manager
description: Central state management and observability for swarms - tracks actions, decisions, confidence, and artifacts
version: 1.0
language_agnostic: true
---

# Swarm State Manager Skill v1.0

**Role**: You are the central state and observability manager for all agent swarms. You maintain a single source of truth for what happened during a swarm execution.

**Core Principles**:
- Use append-only event log as source of truth
- Maintain a fast materialized `state.json` for quick access
- Support crash recovery and swarm restartability
- Provide excellent observability for humans and agents
- Ensure thread-safety and atomicity where possible

## File Structure
.swarm/
├── state.json                 # Current materialized state (fast access)
├── logs/
│   └── events-{timestamp}.jsonl   # Append-only event log (immutable history)
└── snapshots/
    └── state-{timestamp}.json     # Periodic snapshots

## Event Log Schema (JSON Lines)

Every event in the `.jsonl` file follows this structure:
```json
{
  "event_id": "evt_20250528134501234",
  "timestamp": "2025-05-28T13:45:01.234Z",
  "swarm_id": "swarm_abc123def456",
  "agent": "tdd-coordinator",
  "event_type": "phase_completed",
  "task_id": "task_auth_service_789",
  "confidence": 88,
  "payload": { ... },
  "artifacts": [ ... ],
  "metadata": { ... }
}
```

## Materialized State Schema (state.json)

```json
{
  "swarm_id": "swarm_abc123def456",
  "started_at": "2025-05-28T13:40:12Z",
  "last_updated": "2025-05-28T13:52:45Z",
  "status": "in_progress",
  "overall_confidence": 82,

  "current_task": {
    "task_id": "task_user_auth",
    "description": "...",
    "assigned_agent": "tdd-coordinator"
  },

  "progress": {
    "phases_completed": ["concept", "tdd_green"],
    "phases_total": 7,
    "completion_percentage": 68
  },

  "agents": { ... },
  "artifacts": [ ... ],
  "quality": { ... },
  "git": { ... },
  "metadata": { ... },

  "open_questions": [ ... ],
  "next_recommended_steps": [ ... ]
}
```

## Main Event Types
- `swarm_started`, `swarm_completed`
- `phase_started`, `phase_completed`
- `handoff_created`
- `quality_gate_passed`, `quality_gate_failed`
- `architecture_violation`
- `git_commit_created`
- `error`, `human_question`

## Core Functions
1. `initialize(swarm_id)` — Create new state + first event
2. `append_event(event)` — Append to event log + update state.json
3. `get_state()` — Return current materialized state
4. `get_history(limit)` — Return recent events
5. `generate_report()` — Create human-readable swarm summary
6. `rebuild_state()` — Rebuild state.json from event log (recovery)

## Output Format (when called)
```yaml
state_update:
  success: true
  events_appended: 1
  current_confidence: 85
  next_recommended_agent: "quality-guardian"
  summary: "Updated swarm state with TDD green phase"
```

## Integration Notes
- swarm-coordinator should initialize and heavily use this skill
- All major agents must call this skill to log their actions
- Enables future features: retry logic, swarm resume, performance analytics
- Strongly recommended to use this skill before creating any handoff

## Usage Pattern:
Every major agent should:
- Do its work
- Call swarm-state-manager to append events
- Then create its handoff