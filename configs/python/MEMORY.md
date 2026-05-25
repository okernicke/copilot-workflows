# MEMORY - Python Project Knowledge

## Project Overview
- Python backend architecture with clean separation between domain, application, and infrastructure.
- Business language is **German**.
- Prefer `FastAPI` or `Django` for HTTP adapters, with pure domain logic separated.

## Core Architectural Rules
- Dependency direction: `infrastructure → application → domain`.
- Domain layer: no framework-specific imports.
- Use explicit result-handling patterns for business outcomes.
- Application services orchestrate use cases and return well-defined results.

## Naming Conventions
- Domain concepts: German.
- Technical code: English.
- Tests: descriptive names, either in German or with German docstrings.

## Testing Standards
- `pytest` with fixtures and parameterization.
- `hypothesis` for property-based tests and invariants.
- `pytest-mock` for mocks, or manual test doubles when needed.
- Write tests before production code.

## Tools & Tech
- `python`
- `pytest`, `pytest-mock`, `hypothesis`
- `fastapi` or `django`
- `pydantic`, `dataclasses`, `attrs`, `typing.NamedTuple`
- `clean architecture` / `hexagonal architecture`
- `pytest-cov` for coverage
- Optional mutation testing tools like `mutmut` or `pytest-mutmut`
- Domain-driven design with German business language and English technical identifiers
- Keep framework details out of the domain layer
- Use explicit result models for business outcomes
- Prefer fixtures, factory helpers, and focused unit tests

---

Update this file when new Python conventions or recurring patterns are introduced.
