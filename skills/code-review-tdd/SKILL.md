---
name: code-review-tdd
description: Final TDD code review ensuring architecture, test quality and project standards are met.
---

# TDD Code Review Skill – Final Gate

Perform a final review after Red → Green → Refactor cycle:

### Checklist
- Clean Architecture / Hexagonal rules respected (ArchUnit compliant)
- Correct DDD annotations present
- Use cases return sealed `Ergebnis`, no business exceptions thrown
- Tests follow project conventions (German names, Kotest, MockK, test factories)
- Code is readable and well-structured
- Proper error handling and i18n
- OpenAPI + Flyway + messages updated (if applicable)

Give clear approval or list remaining issues.