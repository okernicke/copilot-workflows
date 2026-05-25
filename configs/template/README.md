# Config Package Template

Use this directory as a starting point when creating a new language-specific config package.

## Required files

- `global-instructions.md` — language-specific instructions for coding, testing, and architecture.
- `MEMORY.md` — architecture conventions, technology guidance, and project memory.
- `README.md` — config-specific usage notes and setup instructions.

## Notes

- Do not add this template package to `configs/configs.json`.
- Copy this folder to `configs/<name>/` when creating a new config.
- Keep shared workflow skills and agent prompts at the repository root in `skills/` and `agents/`.
