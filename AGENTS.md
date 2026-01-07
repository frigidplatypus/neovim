# AGENTS.md

## Build / Lint / Test
- `nix build .#neovim` (build main)
- `nix flake check` (evaluation + validation)
- `nix eval .#packages.x86_64-linux.neovim-dev.config --show-trace`
- `./scripts/validate-config.sh <profile-file>` (profile validation)
- `nix fmt` (format code via treefmt.toml / nixfmt-rfc-style)
- Single-target test/build: `nix build .#packages.x86_64-linux.neovim-test-<MODULE>`
- If language tests exist (Python): `pytest tests/path/to/file.py::TestClass::test_name`

## Style Guidelines
- Nix conventions: flakes, modules, overlays follow Snowfall Lib discovery patterns; keep `imports` at the top of `.nix` files
- Naming: files `kebab-case`; Nix attributes `camelCase`; Module names `PascalCase`
- Formatting: 2-space indentation, no trailing whitespace, prefer short, readable expressions
- Module options/types: use explicit `lib.types` and the `mk*` helpers for options
- Bash scripts: `set -euo pipefail`, use descriptive errors, avoid silent failures
- Error handling: prefer explicit failures with helpful messages; use `--show-trace` for Nix evaluation
- Documentation: comment non-obvious logic and reference related files under `specs/`

## Tooling & Policy
- Copilot guidance: see `.github/copilot-instructions.md`
- Cursor rules: no `.cursor/` or `.cursorrules` were found in repo
- Agent Commit Policy: agents MUST obtain an explicit user request before creating any git commits. When a user requests a commit the agent will show the staged diff, the list of files to be committed, and wait for final confirmation before running `git add`/`git commit`. Agents MUST NOT push to remotes without explicit instruction.
