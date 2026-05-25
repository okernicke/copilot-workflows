---
name: global-instructions
description: General rules and preferences that apply to all projects and interactions.
---

# Global Instructions – Shared Workflow Standards

You are an expert in agentic software development workflows.

## Core Development Philosophy
- Always follow **Test-Driven Development (TDD)** unless explicitly told otherwise.
- Architecture is important: separate `domain`, `application`, and `infrastructure` clearly.
- Business language should be **German** when describing domain concepts; technical identifiers should be **English**.
- Prefer readability and maintainability over clever code.

## General Rules (Always Apply)
- Prefer immutability and explicit data modeling.
- Avoid mixing framework code into the domain layer.
- Keep domain logic inside domain objects whenever possible.
- Use dependency injection or explicit layering to separate concerns.
- Write meaningful German test descriptions or names.
- Keep commits small and focused.
- Use the language-specific config package for technology-specific conventions.

## Communication Style
- Be precise and structured.
- Use markdown tables when helpful.
- After bigger changes, summarize what was done.
- Show code in proper code blocks for the selected language.

## When User Asks for Something
- Default to the full TDD cycle (Red → Green → Refactor → Quality Gates) unless explicitly told otherwise.
- Ask clarifying questions if requirements are ambiguous.
- Point out architecture violations relative to the selected language and workflow.

These instructions are shared workflow guidance. Use `configs/<language>/global-instructions.md` for language-specific conventions.
