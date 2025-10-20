# AGENTS.md

## Build, Lint, and Test Commands
- Build main package: `nix build .#neovim`
- Build variant: `nix build .#neovim-autopairs-disabled`
- Evaluate config: `nix eval .#packages.x86_64-linux.neovim-dev.config --show-trace`
- Run a single test: execute scripts in `tests/build/` or `tests/eval/` (e.g. `tests/build/test_autopairs_toggle.sh`)
- Lint/validate config: `./scripts/validate-config.sh <profile-file>`
- Namespace validation: `./scripts/validate-namespace.sh`
- Module enable scaffold check: `./scripts/add-module-enable.sh [--dry-run|--apply]`

## Code Style Guidelines
- Use standard Nix conventions for flakes, modules, overlays
- Module options: `options.frgdNeovim.nixvim.<module> = with lib.types; { enable = mkBoolOpt false; };`
- Avoid legacy namespaces (`frgd.apps`, `frgd.nixvim`); use `frgdNeovim.nixvim`
- Prefer Snowfall Lib directory structure for modules/packages
- Bash scripts: use `set -euo pipefail`, clear error messages
- Naming: kebab-case for files, camelCase for Nix attributes, PascalCase for module names
- Imports: relative paths, keep imports at top
- Formatting: 2 spaces indentation, no trailing whitespace
- Types: explicit in Nix options (`mkBoolOpt`, etc)
- Comment non-obvious logic

## Copilot/Technology Stack
- See `.github/copilot-instructions.md` for stack and structure references
- No Cursor rules present
