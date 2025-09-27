# Feature Specification: Module Configuration Options and Package Generation

**Feature Branch**: `002-modules-should-have`  
**Created**: September 26, 2025  
**Status**: Draft  
**Input**: User description: "Modules should have options to enable them, allow more packages to be generated with special use cases or colorSchemes"

## Execution Flow (main)
```
1. Parse user description from Input
   → Identified: module enablement, package generation, special use cases, color schemes
2. Extract key concepts from description
   → Actors: neovim users, package maintainers
   → Actions: enable/disable modules, generate specialized packages
   → Data: module configurations, package definitions, color schemes
   → Constraints: nixvim framework compatibility, Snowfall Lib integration
3. For each unclear aspect:
   → Resolved: "Special use cases" include language-specific, environment-specific, and role-specific variants (e.g., python-dev, writing, remote-work).
   → Resolved: Packages are generated via declarative package definitions driven by named profiles (profiles are data: lists of module flags and options). These definitions may be used to create both pre-defined packages and dynamic custom variants.
4. Fill User Scenarios & Testing section
   → User flow: configure modules → generate customized package
5. Generate Functional Requirements
   → Module enablement system, package generation framework
6. Identify Key Entities: modules, packages, configurations, color schemes
7. Run Review Checklist
   → WARN "Spec has uncertainties around special use cases definition"
8. Return: SUCCESS (spec ready for planning)
```

---

## Clarifications

### Session 2025-09-26
- Q: Which predefined package profiles should we include by default? → A: C (development, writing, minimal, remote)


## ⚡ Quick Guidelines
- ✅ Focus on WHAT users need and WHY
- ❌ Avoid HOW to implement (no tech stack, APIs, code structure)
- 👥 Written for business stakeholders, not developers

---

## User Scenarios & Testing *(mandatory)*

### Primary User Story
A neovim user wants to create a customized neovim configuration by selectively enabling specific modules (like LSP support, git integration, or UI enhancements) and generate a specialized package that includes only their desired functionality and preferred color scheme.

### Acceptance Scenarios
1. **Given** a user has access to the nixvim configuration, **When** they specify which modules to enable (e.g., LSP, git, productivity tools), **Then** the system generates a neovim package containing only those enabled modules
2. **Given** a user wants a minimal neovim setup, **When** they disable UI and productivity modules but keep core functionality, **Then** the generated package is lightweight and contains only essential features
3. **Given** a user prefers a specific color scheme, **When** they specify their preferred theme during package generation, **Then** the resulting neovim configuration uses that color scheme by default
4. **Given** a user wants multiple specialized packages, **When** they define different module combinations (e.g., "coding", "writing", "minimal"), **Then** the system generates separate packages for each use case

### Edge Cases
All edge cases are handled by Nix's evaluation system:
- **Conflicting dependencies**: Nix throws build errors with clear diagnostic messages
- **Invalid configurations**: Nix validates all options and throws descriptive errors  
- **Missing dependencies**: Nix's dependency resolution catches and reports missing requirements
- **Invalid color schemes**: Nix validates option values and reports invalid selections
- **Empty configurations**: Nix handles minimal configurations gracefully

## Requirements *(mandatory)*

### Functional Requirements
- **FR-001**: System MUST provide options for each module to be enabled or disabled individually
- **FR-002**: System MUST validate module dependencies and prevent configurations that would break functionality
- **FR-003**: Users MUST be able to specify color schemes when generating packages
- **FR-004**: System MUST generate different neovim packages based on enabled module combinations
-- **FR-005**: System MUST support predefined package profiles for common use cases (e.g., `development`, `writing`, `minimal`) and allow maintainers to add others.
- **FR-006**: System MUST maintain compatibility with the existing Snowfall Lib auto-discovery system
- **FR-007**: Users MUST be able to create custom package variants without modifying core module definitions
- **FR-008**: System MUST provide clear feedback when module combinations are invalid or incomplete
- **FR-009**: Generated packages MUST maintain the same performance characteristics as the current monolithic approach
-- **FR-010**: System MUST allow package generation for special use cases such as language-specific (e.g., `python`, `go`), environment-specific (e.g., `remote`, `docker`), and role-specific (e.g., `writer`, `teacher`).

### Key Entities *(include if feature involves data)*
- **Module**: Individual nixvim plugin configuration with enable/disable option and dependency information
- **Package**: Generated neovim configuration containing specific module combinations and color scheme
- **Configuration Profile**: Named combination of enabled modules for common use cases
- **Color Scheme**: Visual theme that can be applied to generated packages
- **Dependency**: Relationship between modules that must be respected during package generation

## Platform & Library References

This feature depends on and must remain compatible with Snowfall Lib conventions and the nixvim framework. See:

- Snowfall Lib (auto-discovery and file layout): https://github.com/snowfallorg/lib
- nixvim (framework and module patterns): https://github.com/nix-community/nixvim

The implementation must follow Snowfall Lib's `modules/` and `packages/` auto-discovery patterns and honor nixvim's module composition model. Details about how these libraries expose modules and package discovery are important for migration and must be referenced in the constitution and implementation plan.

### Snowfall Lib: discovery rules (concrete)

Follow these concrete discovery patterns used by Snowfall Lib and expected by the implementation:

- Modules discovery:
   - Path pattern: `modules/<project>/*/*/default.nix` (for this repo: `modules/nixvim/<category>/<module>/default.nix`).
   - The discovery mechanism treats each `default.nix` as a self-contained Nix module expression that can be imported.
   - Modules must avoid top-level side-effects; they should export a function or attribute set compatible with nixvim module patterns.

- Packages discovery:
   - Path pattern: `packages/<package-name>/default.nix`.
   - Each package `default.nix` should export an attribute set that the flake can expose as a build target (Snowfall Lib will surface these under `packages` automatically).

- Composition notes:
   - Discovery order is not guaranteed; rely only on explicit module dependencies rather than load order.
   - Modules that depend on others should declare dependencies in their metadata and the validation step must ensure dependency graphs are satisfied before building packages.
   - Avoid implicit global state or assumptions about evaluation order in module code.

Refer to Snowfall Lib documentation for exact behavior; these rules are intentionally conservative and intended to be compatibility-preserving.

### Migration notes (concrete steps)

When migrating existing modules to the new options pattern and directory layout, follow these steps to remain Snowfall-compatible and minimize user impact:

1. Add a canonical options scaffold to the module file without changing runtime behavior. Example: add a commented `options.frgdNeovim.nixvim.<module>` block or a non-invasive options definition that does not disable existing configuration.
2. Run the namespace validator (`scripts/validate-namespace.sh`) and the core-existence test (`tests/eval/test_core_modules_exist.sh`) to confirm module names and locations.
3. Use the mass-update script in dry-run mode (`scripts/add-module-enable.sh --dry-run`) to collect suggested patches. Review them manually.
4. Apply changes in small batches per category (commit per category). After each category commit, run `nix flake check` or `nix eval` on a small set of package targets to verify no regressions.
5. For modules that require module-specific extra options, add those options in a follow-up task (T014) and document the option contract in `contracts/module-options.md`.
6. Once all modules contain the options pattern and pass validation, enable package derivations (packages/*) to rely on the canonical `core-modules.nix` and the module option flags.

These steps preserve Snowfall Lib auto-discovery behavior while allowing incremental migration and quick rollbacks.

---

## Review & Acceptance Checklist
*GATE: Automated checks run during main() execution*

### Content Quality
- [x] No implementation details (languages, frameworks, APIs)
- [x] Focused on user value and business needs
- [x] Written for non-technical stakeholders
- [x] All mandatory sections completed

-### Requirement Completeness
- [x] No [NEEDS CLARIFICATION] markers remain
- [x] Requirements are testable and unambiguous  
- [x] Success criteria are measurable
- [x] Scope is clearly bounded
- [x] Dependencies and assumptions identified

---

## Execution Status
*Updated by main() during processing*

- [x] User description parsed
- [x] Key concepts extracted
- [x] Ambiguities marked
- [x] User scenarios defined
- [x] Requirements generated
- [x] Entities identified
- [ ] Review checklist passed (pending clarifications)

---
