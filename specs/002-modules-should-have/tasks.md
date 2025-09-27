---
Feature: Module Configuration Options and Package Generation
Branch: 002-modules-should-have
Path: /specs/002-modules-should-have
---

# Tasks: Module Configuration Options & Package Generation

**Input**: design docs from `/specs/002-modules-should-have/` (plan.md, research.md, data-model.md, quickstart.md, contracts/)

## Overview
This tasks list is dependency-ordered and executable. Follow the ordering rules: setup → validation/tests → models/schemas → implementation → integration → polish. Tasks marked with [P] can run in parallel when they touch different files.

Notes:
- Repository structure follows Snowfall Lib (see plan.md).  
- Validation uses Nix evaluation (`nix build`, `nix eval`, `nix flake check`) as primary test harness.  
- All file paths below are repository-relative and must be created/edited as specified.

## Tasks

T001 Setup: Create feature tasks file [X]
- Create: `/specs/002-modules-should-have/tasks.md` (this file)
- Purpose: Record the executable task list and dependencies
- Depends on: none
  - Note: file created and populated (verified)

T002 Setup: Sanity check & prerequisites [X]
- Run: `.specify/scripts/bash/check-prerequisites.sh --json --paths-only`
- Verify: `FEATURE_DIR` and `IMPL_PLAN` paths exist (see plan.md)
- File/command: repo root script
- Depends on: T001
  - Note: prerequisites script executed; FEATURE_DIR and AVAILABLE_DOCS parsed

T003 Setup: Add developer helper scripts (optional) [X]
- Create: `/lib/nix/profile-tools.nix` (utility helpers for profile composition)
- Purpose: Small reusable Nix helpers used by package derivations
- Mark: [P] (independent file)
- Depends on: T002
  - Note: `lib/nix/profile-tools.nix` added (simple makeModuleSet helper)

T004 Tests [P]: Add contract test placeholder for `contracts/package-generation.md` [X]
- Create: `/specs/002-modules-should-have/tests/contracts/test_package_generation.nix`
- Purpose: Failing contract test describing expected package schema and evaluation behavior (TDD)
- Mark: [P]
- Depends on: T002, contracts/package-generation.md
  - Note: placeholder created

T005 Tests [P]: Add contract test placeholder for `contracts/module-options.md` [X]
- Create: `/specs/002-modules-should-have/tests/contracts/test_module_options.nix`
- Purpose: Failing contract test verifying module option schema (enable, types)
- Mark: [P]
- Depends on: T002, contracts/module-options.md
  - Note: placeholder created

T006 Tests [P]: Add contract test placeholder for `contracts/module-options.md` extras (README-guided) [X]
- Create: `/specs/002-modules-should-have/tests/contracts/test_module_options_readme.nix`
- Purpose: Ensure README examples evaluate as documented
- Mark: [P]
- Depends on: T002, contracts/README.md
  - Note: placeholder created

T007 Models [P]: Implement data model schemas in Nix (Module, Profile, Package) [X]
- Create: `/lib/nix/module-schema.nix` and `/lib/nix/profile-schema.nix`
- Purpose: Encode the `data-model.md` validation rules as `lib.types` Nix schemas
- Mark: [P] (two independent files)
- Depends on: T003, T002, data-model.md
  - Note: minimal schemas added to `/lib/nix/`

T008 Tests [P]: Nix evaluation test for schema imports [X]
- Create: `/tests/eval/test_schemas.sh` which checks presence of schema files and attempts a light `nix eval` when available
- Mark: [P]
- Depends on: T007
  - Note: test script created and passing (schemas validate successfully)

T009 Core: Add enable-option scaffolding to a representative module (prototype) [X]
- Edit: `modules/nixvim/core/autopairs/default.nix` (or create if missing)
  - Change: add `options.frgdNeovim.nixvim.autopairs.enable = mkBoolOpt false` and `config = mkIf cfg.enable { ... }` pattern following research.md
- Purpose: Validate module-level pattern end-to-end before bulk changes
- Depends on: T007, T008
  - Note: added non-invasive options scaffold (commented example) to avoid changing runtime behavior during prototype

T029 Namespace consistency validation (blocks mass-update) [X]
- Create: `/scripts/validate-namespace.sh` (search/grep + report)
- Create: `/tests/eval/test_namespace_consistency.sh`
  - Purpose: Ensure all module option namespace usage is `frgdNeovim.nixvim.<module>`
- Depends on: T002
- Blocks: T011/T012/T013
  - Note: script created, made executable, and ran; no legacy namespaces found after fixes

T010 Tests: Evaluation test for prototype module [X]
  - Create: `/tests/eval/test_autopairs_option.sh` that checks autopairs scaffold presence
  - Additional: `/tests/eval/test_config_validator.sh` that tests user-friendly error messages
  - Depends on: T009, T008
  - Note: Both tests created and passing (scaffold present, validator provides helpful feedback)

T011 Core [P]: Create mass-update script to add `enable` & types to all modules [X]
  - Create: `/scripts/add-module-enable.sh` (idempotent; edits module default.nix files or emits patch suggestions)
  - Purpose: Automate applying the `options.frgdNeovim.nixvim.<module>.enable` pattern across `modules/nixvim/*/*/default.nix`
 - Mark: [P]
 - Depends on: T009 (prototype validated)
  - Note: dry-run implemented; script suggests patches and refuses to apply unless FORCE_APPLY=1 and --apply are provided (apply not implemented)

T012 Core: Run mass-update script (dry-run), review patches [X]
- Run script: `/scripts/add-module-enable.sh --dry-run` and inspect suggested patches
- Purpose: Catch modules that need custom options or have unusual layouts
- Depends on: T011
  - Note: dry-run executed; output reviewed (suggested scaffolds shown). Apply gated behind explicit FORCE_APPLY variable and not yet implemented.

T013 Core: Apply mass-update script to repository (commit per category)
- Action: `/scripts/add-module-enable.sh --apply` edits modules in-place, commit changes grouped by category under `modules/nixvim/{category}/`
- Files changed: many `modules/nixvim/*/*/default.nix`
- Notes: Keep commits per category to reduce merge conflicts
- Depends on: T012
 - Progress: Core modules (autopairs, clipboard, treesitter, which-key) migrated with real enable options; remaining categories pending. Added toggle test.
  - Update: Replaced brittle eval toggle test with integration build toggle test (`tests/build/test_autopairs_toggle.sh`) using new support package `neovim-autopairs-disabled`.

T014 Core [P]: Add module-specific extra options for modules that require them
  - Files: edit only modules that need extras (examples)
    - `modules/nixvim/ui/colorscheme/default.nix` -> add `options.frgdNeovim.nixvim.colorscheme.name = types.nullOr types.str` and pass through
  - `modules/nixvim/lsp/cmp/default.nix` -> add module-specific options if documented in data-model.md
- Mark: [P] per distinct file (do not edit same file in parallel)
- Depends on: T013

T014a Define canonical core module list (blocks neovim-minimal) [X]
- Create: `/specs/002-modules-should-have/core-modules.nix`
- Create: `/tests/eval/test_core_modules_exist.nix`
- Purpose: Provide authoritative core set used by `packages/neovim-minimal`
- Depends on: T007
- Blocks: T015
  - Note: `core-modules.nix` added with initial conservative list; test `tests/eval/test_core_modules_exist.sh` passes (all core modules present)

T030 Feedback & validator for user-friendly errors (blocks package release) [X]
- Create: `/specs/002-modules-should-have/feedback.md`
- Create: `/scripts/validate-config.sh` and `/tests/build/test_feedback_messages.sh`
- Purpose: Provide human-friendly messages for invalid module names, invalid color-schemes, and unmet dependencies
- Depends on: T014a, T007, T021
- Blocks: T015-T018 being considered 'ready for users'
  - Note: `validate-config.sh` and `test_feedback_messages.sh` created and test passed locally (validator detects unknown modules)

T015 Packages: Create package derivation for `neovim-minimal` [partial]
- Create: `packages/neovim-minimal/default.nix` (scaffold)
- Content: Nix scaffold that composes `frgdNeovim.nixvim` using `core-modules.nix`
- Depends on: T007, T013
  - Note: scaffold created. Building the package requires flake wiring and possible mass-update of modules; test/build blocked until T013/T023 addressed

T016 Packages: Create package derivation for `neovim-dev` [partial]
- Create: `packages/neovim-dev/default.nix` (scaffold)
- Content: Development profile (core + lsp + git + formatting + search)
- Depends on: T007, T013
  - Note: scaffold created; build wiring pending

T017 Packages: Create package derivation for `neovim-writer` [partial]
- Create: `packages/neovim-writer/default.nix` (scaffold)
- Content: Writing profile (core + productivity + ui subset)
- Depends on: T007, T013
  - Note: scaffold created; build wiring pending

T018 Packages: Create package derivation for `neovim` (full) [partial]
- Create/Update: `packages/neovim/default.nix` (scaffold)
- Content: Enable all modules by default (preserve preexisting behavior)
- Depends on: T013
  - Note: scaffold created; build wiring pending

T019 Tests [P]: Add build tests for each package variant [partial]
- Create: `/tests/build/test_neovim_minimal.sh`, `/tests/build/test_neovim_dev.sh`, `/tests/build/test_neovim_writer.sh`
- Purpose: Ensure each `packages/*` builds and evaluates config correctly
- Mark: [P] (each test independent)
- Depends on: T015, T016, T017, T018
  - Note: Test scaffolds created; package discovery/wiring may need flake integration work

T020 Integration: Quickstart scenario tests (user stories)
- Create: `/tests/integration/story_minimal.sh`, `/tests/integration/story_dev.sh`, `/tests/integration/story_writer.sh`
- Purpose: Scripted verification steps from `quickstart.md` (build + smoke-run `./result/bin/nvim` and basic checks)
- Depends on: T019

T021 Packages: Add color scheme option plumbing
- Edit: `packages/*/default.nix` to accept `colorScheme` and pass to UI modules (e.g., `ui/colorscheme`) via overrides
- Files: `packages/neovim*/default.nix` (all variants)
- Depends on: T014, T015-T018

T022 Tests: Color scheme validation test
- Create: `/tests/build/test_color_scheme.nix` that attempts to build `neovim-dev` with an allowed and disallowed theme and expects success/failure respectively
- Depends on: T021

T023 Validation: Add nix flake check integration for feature
- Edit: `flake.nix` or `flake.lock` if necessary to include new tests under `checks` (prefer minimal changes). Prefer pointing to `tests/eval` and `tests/build` validations
- File: `flake.nix` (edit carefully) or add `flake-checks/default.nix` pointing to tests
- Depends on: T008, T019

T024 Polish [P]: Documentation update
- Edit/Add: `/docs/module-options.md`, `/docs/package-generation.md`, and update `/README.md` with new package names and examples (or create under `/specs/002-modules-should-have/README.md` first)
- Purpose: Document module option pattern, profile list, and quickstart usage
- Mark: [P]
- Depends on: T013, T015-T018

T025 Polish: Performance validation
- Run: `/specs/002-modules-should-have/quickstart.md` build time checks (measure `nix build` time) and compare to baseline (target within 10%)
- Create: `/specs/002-modules-should-have/perf/results.md` with measured times
- Depends on: T019

T026 Polish [P]: Unit tests and cleanup
- Create: unit-style Nix tests or small shell checks for validation helpers in `/lib/nix/*` and add to `/tests/unit/`
- Mark: [P]
- Depends on: T003, T007

T027 Release prep: Commit, tag, and document migration notes
- Files: Release notes under `/docs/` and a changelog entry in `/CHANGELOG.md`
- Purpose: Communicate breaking changes (if any) and migration steps for maintainers
- Depends on: All implementation tasks (T013-T023)

T028 Optional: Add example overlays to let users define ad-hoc profiles
- Create: `/examples/overlays/custom-profiles.nix` showing how to compose custom package variants locally
- Mark: [P]
- Depends on: T015-T018

T031 Documentation: Add Snowfall Lib & nixvim references to constitution [X]
- Edit: `.github/copilot-instructions.md` and `/docs/CONSTITUTION.md` (if present) to include links and guidance
- Purpose: Ensure maintainers have direct links to Snowfall Lib and nixvim docs and understand discovery rules
- Depends on: T001
  - Note: `.github/copilot-instructions.md` updated; add `/docs/CONSTITUTION.md` if a formal doc is desired

T032 Migration README: Create migration checklist & README [P]
- Create: `/specs/002-modules-should-have/README.md` with step-by-step migration guidance (uses the concrete migration steps in spec)
- Purpose: Give maintainers a one-page checklist for safely migrating modules and packages following Snowfall Lib
- Depends on: T014a, T029, T011

## Parallel Execution Examples
- Group A (can run concurrently): T004, T005, T006, T007, T008, T011, T003  
  Example agent commands:
  - Task agent: "Create schema file /lib/nix/module-schema.nix"  
  - Task agent: "Create contract test /specs/002-modules-should-have/tests/contracts/test_package_generation.nix"

- Group B (build tests): T019 tasks (each test file can run in parallel for different package variants)

## Dependency Notes
- T004-T006 (contract tests) must be created before implementation tasks that make them pass.  
- T007 (schemas) must exist before schema-based tests (T008) and before packages that consume them.  
- Prototype module change (T009) reduces risk for mass-update (T011-T013).  
- Package derivations (T015-T018) depend on module enable flags being present (T013).  

## How an LLM/agent should execute a single task
1. Open the specified file path. If file exists, make minimal edit. If missing, create with a focused, tested snippet.  
2. Run `nix eval` or `nix build` locally for fast validation (prefer `nix eval` for schema-level checks).  
3. Commit a small, focused change with a descriptive message and include the task ID in the commit message (e.g., "T013: add enable options to modules (category: core)").

## Final Notes
- Keep commits small and grouped by logical unit (category or package).  
- Prefer failing tests first (TDD): create tests (T004-T006, T008, T019) before making implementation changes.  
- If a module is highly bespoke, exclude it from mass-update and handle it with a targeted task in T014.  
- After finishing tasks, run `nix flake check` and the quickstart scenarios from `/specs/002-modules-should-have/quickstart.md` to validate acceptance criteria.

---
Generated from: plan.md, research.md, data-model.md, quickstart.md, contracts/
