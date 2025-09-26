<!--
Sync Impact Report:
- Version change: 1.0.0 → 1.1.0
- Modified principles: Added Snowfall Lib as new core principle (I), renumbered existing principles
- Added sections: Snowfall Lib compliance under Nix Quality Standards
- Removed sections: None  
- Templates requiring updates: ✅ plan-template.md updated for Snowfall structure, ✅ tasks-template.md updated for Snowfall paths
- Follow-up TODOs: None
-->

# Neovim Configuration Constitution

## Core Principles

### I. Snowfall Lib Architecture (NON-NEGOTIABLE)
All project structure and organization MUST follow Snowfall Lib conventions (https://github.com/snowfallorg/lib). The flake MUST use `snowfall-lib.mkFlake` for outputs generation. Directory structure MUST adhere to Snowfall standards: `lib/` for utilities, `modules/` for nixvim modules, `packages/` for derivations, `shells/` for development environments. Namespace MUST be consistently applied across all components.

### II. Module-First Architecture
Every feature MUST be implemented as a discrete nixvim module with clear boundaries and responsibilities. Modules MUST be self-contained with explicit dependencies declared. Each module MUST have a single, well-defined purpose - no kitchen-sink modules that blur functional boundaries.

### III. Declarative Configuration
All configuration MUST be expressed declaratively through Nix expressions. Imperative scripts or runtime modifications are prohibited except where nixvim framework limitations require them. Configuration changes MUST be reproducible across different environments and systems.

### IV. Validation Through Evaluation
Since TDD is not applicable to Nix configurations, validation MUST occur through `nix flake check`, `nix build`, and evaluation testing. All modules MUST evaluate successfully without errors or warnings. Breaking changes MUST be detected through evaluation failures, not runtime testing.

### V. Functional Categorization
Modules MUST be organized by primary functional purpose, not technical implementation details. Categories MUST reflect user mental models for discovering functionality. New categories require minimum of 4 related modules unless serving as designated catch-all (utilities).

### VI. Reproducible Builds
All dependencies MUST be pinned through flake inputs with explicit version constraints. Builds MUST be deterministic and produce identical results across different machines and time periods. No impure dependencies or network fetches during evaluation.

## Nix Quality Standards

### Snowfall Lib Compliance
All components MUST follow Snowfall Lib naming conventions and directory placement rules. Module exports MUST be compatible with Snowfall's auto-discovery mechanisms. Library functions MUST be placed in `lib/` and properly exported. Packages MUST be defined in `packages/` following Snowfall patterns.

### Evaluation Performance
Module evaluation MUST not introduce significant performance regressions. Complex computations MUST be cached or moved to build time. Memory usage during evaluation MUST remain reasonable for typical development machines (<500MB for full configuration).

### Code Style
All Nix code MUST be formatted with `nixfmt-rfc-style`. Attribute sets MUST use consistent ordering and naming conventions. Comments MUST explain non-obvious configuration choices and trade-offs. Snowfall namespace MUST be used consistently across all components.

### Documentation
Each module MUST include inline documentation explaining its purpose, key options, and usage examples. Breaking changes MUST be documented with migration guides. Category assignments MUST be documented with clear rationale. Snowfall Lib patterns and conventions MUST be documented for contributors.

## Development Workflow

### Change Management
All structural changes (new modules, reorganization, dependency updates) MUST go through the specification workflow (/specify → /clarify → /plan → /tasks). Functional changes to existing modules MAY be implemented directly with appropriate validation.

### Quality Gates
All changes MUST pass `nix flake check` before merging. Pre-commit hooks MUST enforce code formatting and basic validation. Performance impact MUST be measured for significant structural changes.

### Rollback Capability
Major structural changes MUST include rollback procedures and backup strategies. Migration scripts MUST be tested and reversible. Git history MUST be preserved to enable safe rollbacks.

## Governance

This constitution supersedes all other development practices and guidelines. All pull requests and code reviews MUST verify compliance with these principles. Complexity that violates simplicity principles MUST be justified with clear rationale or refactored.

Amendments require documentation of impact, approval from maintainers, and migration plan for existing code. Version bumps follow semantic versioning: MAJOR for breaking principle changes, MINOR for new principles or sections, PATCH for clarifications.

Use this constitution as the primary reference for architectural decisions. When in doubt, choose the simpler, more declarative, and more modular approach.

**Version**: 1.1.0 | **Ratified**: 2025-09-26 | **Last Amended**: 2025-09-26