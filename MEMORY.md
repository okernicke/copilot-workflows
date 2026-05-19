# MEMORY - Persistent Project Knowledge

## Project Overview
- Kotlin + Spring Boot backend
- Strict **Hexagonal / Clean Architecture** + **DDD**
- Two bounded contexts: `katalog` and `portal`
- Business language is **German**

## Core Architectural Rules (Never Break)
- Dependency direction: `infrastructure → application → domain`
- Domain layer: No Spring, no JPA, no frameworks
- Application layer: One `@UseCase` per business operation
- Use `ErzeugungsErgebnis<T>` (`Erzeugt` / `UngueltigeArgumente`) for object creation
- Use sealed `Ergebnis` classes in use cases instead of exceptions for business errors
- Aggregate Roots created only via `companion object { operator fun invoke(...) }`

## Naming Conventions
- Domain concepts: German (Skillkategorie, ErfassungsZeit, etc.)
- Technical code: English
- Test methods: German backticks (`erfolgreich`, `wenn name bereits existiert`)

## Testing Standards
- JUnit 5 + Kotest assertions
- MockK (never Mockito)
- Controller tests prefer custom DSL builders
- Write tests **before** implementation (TDD)

## Important Classes & Patterns
- DDD Annotations: `@AggregateRoot`, `@ValueObject`, `@UseCase`, `@Repository`, etc.
- Result handling: Sealed classes instead of exceptions
- Test data: Use factory functions (`testSkillkategorie()`, etc.)

## Tools & Tech
- ArchUnit for architecture enforcement
- Flyway migrations
- OpenAPI (manually maintained)
- i18n via `messages*.properties`

---

**Update this file whenever you introduce important new standards, architecture decisions, or recurring patterns.**