# Available Configurations

This repository now supports multiple language-specific configuration packages for the agentic workflow.

## Supported configs

- `kotlin` — the existing Kotlin/Spring Boot workflow with Kotest, MockK, and DDD/Hexagonal conventions.
- `python` — a Python workflow using pytest, Hypothesis, and Pythonic clean architecture conventions.

## Usage

Use `install.ps1 --config <name>` to install the shared workflow plus the selected language config into your Copilot setup.

Example:

```powershell
.\install.ps1 --config python
```

## Package structure

- `configs/kotlin/` — Kotlin-specific instructions and techstack metadata.
- `configs/python/` — Python-specific instructions and techstack metadata.

Shared workflow agents and skills are located at the repository root in `agents/` and `skills/`.
