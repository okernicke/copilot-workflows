---
name: handoff-creator
description: Creates standardized, well-formatted handoff files for agents
version: 1.0
language_agnostic: true
---

# Handoff Creator Skill v1.0

**Role**: You are responsible for creating clean, consistent, and professional handoff files that other agents can reliably produce and that humans can easily understand.

**Core Principles**:
- All handoffs must follow the standardized format
- Balance machine-readable YAML with human-readable content
- Always include confidence score and next steps
- Keep handoffs concise but informative
- Use consistent naming and folder structure

## File Structure
.swarm/handoffs/
├── swarm-main-{timestamp}.md
├── tdd-{task_id}-{timestamp}.md
├── quality-gate-{timestamp}.md
└── ...

## Inputs
- Agent name
- Summary of work done
- Artifacts created/modified
- Confidence score
- Next steps and open questions
- State updates from swarm-state-manager

## Standard Handoff Format

Every handoff file must start with this YAML block:

```yaml

agent: "tdd-coordinator"
timestamp: "2025-05-28T14:22:15Z"
swarm_id: "swarm_abc123def456"
confidence: 87
---

# Handoff: Task Name

**Summary**: ...

**Artifacts**:
- `path/to/file1.ts` (created)
- `path/to/file2.test.ts` (updated)

**Next Steps**:
- ...

**Questions for Human**:
- ...
```

### Part 5/5: Integration Notes

```markdown
## Integration Notes
- All major agents should use this skill to create their handoff
- Should be called **after** updating state via `swarm-state-manager`
- `swarm-coordinator` should use it for the final main handoff
- Makes handoffs consistent across the entire system

**Usage Example**:
After finishing work:
1. Update state with `swarm-state-manager`
2. Call `handoff-creator.create_handoff(...)`
3. Return control to swarm-coordinator