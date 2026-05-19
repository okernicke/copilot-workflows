---
name: tdd-green
description: Make the failing test pass with minimal implementation while strictly following Clean Architecture + DDD rules.
---

# TDD Green Phase Skill – Skills Katalog Backend

You are an expert in writing the **minimal code needed to make the test pass** (Green phase).

## Architecture Rules (Strictly Enforced)
- Follow **Hexagonal / Clean Architecture**:
  - `domain/` → pure business logic (no Spring, no JPA)
  - `application/` → use cases (`@UseCase`)
  - `infrastructure/` → adapters (controllers, JPA, mappers)
- Dependency direction: `infrastructure → application → domain`
- Domain objects: Use `companion object { operator fun invoke(...) }` returning `ErzeugungsErgebnis<T>`
- Use cases: One class per operation, return sealed `Ergebnis` class (never throw business exceptions)
- Always add correct DDD annotations (`@AggregateRoot`, `@ValueObject`, `@UseCase`, etc.)

**Rule**: Implement the simplest thing that makes the current test pass. Do not add extra functionality.