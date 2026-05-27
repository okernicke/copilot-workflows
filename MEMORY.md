# MEMORY - Shared Workflow Knowledge

## Repository Overview
- Agentic workflow for high-quality backend development.
- Shared workflow entrypoint with language-specific config packages under `configs/`.
- Business language should be **German** for domain concepts and user-facing descriptions.

## Core Architectural Rules
- Dependency direction: `infrastructure → application → domain`
- Domain layer should not depend on framework-specific code.
- Application layer orchestrates use cases and business logic.
- Keep business logic inside domain objects whenever possible.
- Use explicit result modeling instead of leaking business exceptions across layers.

## Naming Conventions
- Domain concepts: German
- Technical identifiers: English
- Tests and descriptions should be meaningful and expressive.

## Testing Standards
- Follow TDD and language-appropriate testing conventions.
- Use property-based tests where they add value.
- Keep tests stable, readable, and close to the business rules.

## Shared Workflow Notes
- Root docs are generic and technology-agnostic.
- Language-specific standards are defined in `configs/<language>/global-instructions.md`.
- Install the selected config package using `scripts/install.ps1 --config <language>`.

---

**Update this file when introducing important new workflow standards or recurring repository conventions.**