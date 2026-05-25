# MEMORY - Kotlin Project Knowledge

## Project Overview
- Kotlin backend architecture with clear separation between domain, application, and infrastructure.
- Business language is **German**.
- Prefer Spring Boot adapters with pure domain logic separated.

## Core Architectural Rules
- Dependency direction: `infrastructure → application → domain`.
- Domain layer: no framework-specific imports.
- Use explicit result-handling patterns for business outcomes.
- Application services orchestrate use cases and return well-defined results.

## Naming Conventions
- Domain concepts: German.
- Technical identifiers: English.
- Tests: descriptive names with German descriptions.

## Testing Standards
- `junit-jupiter`, `kotest`, `mockk`
- Property-based tests with Kotest `Arb`
- Write tests before production code.

## Tools & Tech
- `kotlin`
- `spring-boot`
- `junit-jupiter` + `kotest`
- `mockk`
- `gradle`
- `clean architecture` / `hexagonal architecture`
- Domain-driven design with German business language and English technical identifiers
- Use data classes, value objects, and aggregates in the domain layer
- Keep framework and persistence details in infrastructure adapters
- Prefer `@DisplayName`, backticks, and `@Nested` for Kotlin tests
- Use property testing with Kotest `Arb` when valuable

---

Update this file when new Kotlin conventions or recurring patterns are introduced.
