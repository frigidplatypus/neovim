# neovim Development Guidelines

Auto-generated from all feature plans. Last updated: 2025-09-26

## Active Technologies
- Nix (Nix flakes with nixvim framework) + nixvim (nix-community/nixvim), snowfall-lib, nixpkgs (001-reorganize-all-modules)
- File system - Nix module files (.nix), following Snowfall Lib directory structure (001-reorganize-all-modules)
- Nix 2.18+ with nixvim framework (nix-community/nixvim) + Snowfall Lib, nixvim, nixpkgs (following existing flake.nix pattern) (002-modules-should-have)
- File system (Nix expressions, no runtime state) (002-modules-should-have)

## Snowfall Lib & nixvim references

- Snowfall Lib (auto-discovery, module/package layout): https://github.com/snowfallorg/lib
- nixvim (module patterns, makeNixvim helpers, overlays): https://github.com/nix-community/nixvim

The project relies on Snowfall Lib for auto-discovery of `modules/nixvim/*/*/default.nix` and `packages/*/default.nix`. Any structural changes must preserve compatibility with Snowfall's discovery and loading rules.

## Project Structure
```
src/
tests/
```

## Commands
# Add commands for Nix (Nix flakes with nixvim framework)

## Code Style
Nix (Nix flakes with nixvim framework): Follow standard conventions

## Recent Changes
- 002-modules-should-have: Added Nix 2.18+ with nixvim framework (nix-community/nixvim) + Snowfall Lib, nixvim, nixpkgs (following existing flake.nix pattern)
- 002-modules-should-have: Added Nix 2.18+ with nixvim framework (nix-community/nixvim) + Snowfall Lib, nixvim, nixpkgs (following existing flake.nix pattern)
- 001-reorganize-all-modules: Added Nix (Nix flakes with nixvim framework) + nixvim (nix-community/nixvim), snowfall-lib, nixpkgs

<!-- MANUAL ADDITIONS START -->
<!-- MANUAL ADDITIONS END -->
