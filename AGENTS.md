# AGENTS.md

## Build, Lint, and Test Commands
- Build main package: `nix build .#neovim`
- Build variant: `nix build .#neovim-autopairs-disabled`
- Evaluate config: `nix eval .#packages.x86_64-linux.neovim-dev.config --show-trace`
- Run a single test: execute scripts in `tests/build/` or `tests/eval/` (example: `tests/build/test_autopairs_toggle.sh`)
- Run all build tests: run the scripts in `tests/build/` or use `./scripts/validate-config.sh <profile-file>` for lint/validation
- Namespace check: `./scripts/validate-namespace.sh`
- Module enable scaffold check: `./scripts/add-module-enable.sh [--dry-run|--apply]`

## Code Style Guidelines
- Use Nix conventions for flakes, modules, overlays and follow Snowfall Lib discovery patterns
- File names: `kebab-case`; Nix attributes: `camelCase`; Module names: `PascalCase`
- Imports: use relative paths and keep `imports` at the top of `.nix` files
- Module options: use explicit types (`options.frgdNeovim.nixvim.<module> = with lib.types; { enable = mkBoolOpt false; };`)
- Formatting: 2-space indentation, no trailing whitespace, keep expressions short and readable
- Bash scripts: `set -euo pipefail`, descriptive errors, avoid silent failures
- Error handling: prefer explicit failures with helpful messages; use `--show-trace` for Nix evaluations
- Tests: prefer small, isolated shell scripts under `tests/` that exit non-zero on failure
- Documentation: comment non-obvious logic and reference related spec files under `specs/`

## Tooling / Copilot
- See `.github/copilot-instructions.md` for project tooling and conventions
- No Cursor rules found in repository (no `.cursor/` or `.cursorrules` present)
