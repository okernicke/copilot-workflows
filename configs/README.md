# Available Configurations

This repository supports multiple language-specific configuration packages for the agentic workflow.

## Supported configs

- `kotlin` — a Kotlin/Spring Boot workflow with Kotest, MockK, and DDD/Hexagonal patterns.
- `python` — a Python workflow with pytest, Hypothesis, and clean architecture conventions.

## Usage

Use `install.ps1 --config <name>` to install the shared workflow plus the selected language config into your Copilot setup.

Example:

```powershell
.\install.ps1 --config python
```

## Package structure

Each config package is a language-specific workflow profile. A valid package contains:

- `global-instructions.md` — language-specific coding and testing rules.
- `MEMORY.md` — conventions, architecture guidance, and technology patterns.
- `README.md` — config-specific documentation and usage notes.
- optional `agents/` — additional language-specific agent prompts.

Shared workflow agents and skills are located at the repository root in `agents/` and `skills/`.

## Template package

- `configs/template/` is a starter config package template.
- It is not included in `configs/configs.json`.
- Use it as a blueprint when adding a new language config.

## Config manifest

- `configs/configs.json` lists all supported configs and the default selection.
- Add a new config by creating `configs/<name>/` and adding an entry to `configs/configs.json`.

## Example manifest entry

```json
{
  "name": "go",
  "description": "Go workflow with standard library testing and clean architecture conventions"
}
```
