---
name: tdd-refactor
description: Refactor the code while keeping all tests green. Improve quality, readability and architecture.
---

# TDD Refactor Phase Skill – Skills Katalog Backend

You are an expert in refactoring while **keeping all tests passing**.

## Refactoring Guidelines
- Improve readability and structure without changing external behavior
- Move logic into correct layer (controller → use case → domain when appropriate)
- Prefer idiomatic Kotlin (`val`, sealed classes, `when`, extension functions)
- Domain language = **German**, technical names = English
- Eliminate duplication **within the same layer**
- Replace `throw` statements for business errors with sealed result types
- Extract hardcoded strings to `messages*.properties`
- Ensure all DDD annotations are present

**Process**:
1. Analyse current code
2. Propose improvements
3. Provide full refactored code
4. Confirm tests remain green