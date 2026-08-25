# Agent Notes

## Commands
- `nix flake check` evaluates the flake, package outputs, and the pre-commit check.
- `nix build .#neovim` builds the full profile. Other package outputs are `neovim-kanagawa`, `neovim-minimal`, and `neovim-notes`.
- `nix fmt` formats Nix files with the flake's `nixfmt` formatter.
- `nix develop` enters the dev shell and installs the pre-commit shell hook.
- `./scripts/validate-namespace.sh` requires Fish and rejects deprecated namespace references.
- `./scripts/validate-config.sh <profile-file>` must be run from the repository root against a temporary profile list; it heuristically treats every quoted string as a module name and compares them with `specs/002-modules-should-have/core-modules.nix`.

## Structure
- This is a Snowfall Lib flake; do not manually register package or module files. Packages live at `packages/*/default.nix`, and feature modules are auto-discovered under `modules/nixvim/**/default.nix`.
- Module configuration uses the `frgdNeovim` namespace, including `frgdNeovim.nixvim.<module>.*` enable options.
- The canonical minimal-profile module list is `specs/002-modules-should-have/core-modules.nix`; update it when changing that profile's supported core modules.
- The contract files under `specs/002-modules-should-have/tests/contracts/` are placeholders, not runnable test cases; `nix flake check` is the primary automated verification.

## Formatting
- Format changed Nix files with `nix fmt`; the flake formatter covers `*.nix`.
- Preserve Snowfall discovery paths and use the existing module option/config pattern when adding a module.
