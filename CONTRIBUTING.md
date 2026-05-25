# CONTRIBUTING

This repository is designed to provide a generic, multi-language agentic workflow for high-quality development.

## Purpose

Use this guide to:

- add a new language-specific config package
- keep config packages consistent
- understand the required files and manifest format

## Config package requirements

Each language-specific config package under `configs/` must contain:

- `global-instructions.md`
  - language-specific developer and test conventions
- `MEMORY.md`
  - project memory, architecture rules, and tooling guidance
- `README.md`
  - package-specific documentation and usage notes
- optional `agents/`
  - additional agent prompts that are only relevant for the config

Do not add a `skills/` folder to a config package.
Shared workflow skills belong at the repository root in `skills/`.

## Config manifest

The supported configs are declared in `configs/configs.json`.
Each entry should include:

- `name`: the config directory name
- `description`: a short summary of the workflow profile
- optional `default`: `true` for the default config

Example:

```json
{
  "name": "go",
  "description": "Go workflow with standard library testing and clean architecture conventions"
}
```

## Adding a new language config

1. Create `configs/<name>/`.
2. Add the required files: `global-instructions.md`, `MEMORY.md`, and `README.md`.
3. Add optional `agents/` if config-specific agent prompts are needed.
4. Update `configs/configs.json` with a new entry.
5. Update the root `README.md` and `configs/README.md` only if the new config introduces an important new workflow detail.
6. If you add a new shared skill or agent, update `AGENTS.md` and any workflow documentation that references it.

If you want a starting point, copy `configs/template/` and use it as the new config baseline.

## Documentation consistency

- Keep the config package README short and focused on the language-specific conventions.
- Prefer cross-references to `configs/README.md` or `CONTRIBUTING.md` for repository-level standards.
- Keep language-specific conventions in `global-instructions.md` and `MEMORY.md`.

## Workflow extension

If you add a new workflow step or shared skill, update:

- `AGENTS.md`
- `Agentic-Coding-Workflow-v0.6.md`
- `README.md` if the user-facing installation or workflow guidance changes

## Notes

- The installer `install.ps1` currently resolves configs from `configs/configs.json`.
- The shared root-level files are intended to stay generic and technology-agnostic.
