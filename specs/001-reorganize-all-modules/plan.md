
# Implementation Plan: Module Directory Reorganization

**Branch**: `001-reorganize-all-modules` | **Date**: September 26, 2025 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/001-reorganize-all-modules/spec.md`

## Execution Flow (/plan command scope)
```
1. Load feature spec from Input path
   → If not found: ERROR "No feature spec at {path}"
2. Fill Technical Context (scan for NEEDS CLARIFICATION)
   → Detect Project Type from file system structure or context (web=frontend+backend, mobile=app+api)
   → Set Structure Decision based on project type
3. Fill the Constitution Check section based on the content of the constitution document.
4. Evaluate Constitution Check section below
   → If violations exist: Document in Complexity Tracking
   → If no justification possible: ERROR "Simplify approach first"
   → Update Progress Tracking: Initial Constitution Check
5. Execute Phase 0 → research.md
   → If NEEDS CLARIFICATION remain: ERROR "Resolve unknowns"
6. Execute Phase 1 → contracts, data-model.md, quickstart.md, agent-specific template file (e.g., `CLAUDE.md` for Claude Code, `.github/copilot-instructions.md` for GitHub Copilot, `GEMINI.md` for Gemini CLI, `QWEN.md` for Qwen Code or `AGENTS.md` for opencode).
7. Re-evaluate Constitution Check section
   → If new violations: Refactor design, return to Phase 1
   → Update Progress Tracking: Post-Design Constitution Check
8. Plan Phase 2 → Describe task generation approach (DO NOT create tasks.md)
9. STOP - Ready for /tasks command
```

**IMPORTANT**: The /plan command STOPS at step 7. Phases 2-4 are executed by other commands:
- Phase 2: /tasks command creates tasks.md
- Phase 3-4: Implementation execution (manual or via tools)

## Summary
Reorganize 50+ nixvim modules from a flat directory structure into logical functional categories (core, ui, productivity, git, lsp, formatting, search, utilities) following Snowfall Lib conventions. Migration scripts will update import paths immediately, with composite modules remaining intact in their best-fit categories. The reorganization must maintain Snowfall Lib compliance and use evaluation-based validation.

## Technical Context
**Language/Version**: Nix (Nix flakes with nixvim framework)  
**Primary Dependencies**: nixvim (nix-community/nixvim), snowfall-lib, nixpkgs  
**Storage**: File system - Nix module files (.nix), following Snowfall Lib directory structure  
**Testing**: Nix evaluation tests, import validation, functional testing via nix build  
**Target Platform**: Multi-platform (Linux, macOS, any nixpkgs-supported system)
**Project Type**: Nix flake with Snowfall Lib - determines Snowfall directory structure  
**Performance Goals**: Instant module imports, no build time degradation, <500MB evaluation memory  
**Constraints**: Maintain Snowfall Lib compliance, preserve module functionality, immediate migration  
**Scale/Scope**: 50+ nixvim modules, 8 functional categories, multiple import patterns

## Constitution Check
*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- ✅ **Snowfall Lib Architecture**: Reorganization maintains Snowfall Lib directory conventions (`modules/nixvim/`)
- ✅ **Module-First Architecture**: Each module remains discrete with clear boundaries post-reorganization  
- ✅ **Declarative Configuration**: File movement and import updates use declarative Nix expressions
- ✅ **Validation Through Evaluation**: Uses `nix flake check` and build validation instead of traditional testing
- ✅ **Functional Categorization**: Core requirement - organizing modules by functional purpose
- ✅ **Reproducible Builds**: No impact on build determinism, maintains pinned dependencies

**Status**: PASS - All constitutional principles aligned with reorganization approach

## Project Structure

### Documentation (this feature)
```
specs/001-reorganize-all-modules/
├── plan.md              # This file (/plan command output)
├── research.md          # Phase 0 output (/plan command)
├── data-model.md        # Phase 1 output (/plan command)
├── quickstart.md        # Phase 1 output (/plan command)
├── contracts/           # Phase 1 output (/plan command)
└── tasks.md             # Phase 2 output (/tasks command)
```

### Source Code (repository root) - Current Structure
```
lib/
├── lua/
│   └── default.nix
└── [utilities for reorganization scripts]

modules/
└── nixvim/
    ├── default.nix
    ├── auto-session/
    ├── autopairs/
    ├── barbar/
    └── [... 50+ modules in flat structure]

packages/
└── neovim/
    └── default.nix

shells/
└── default/
    └── default.nix
```

### Target Structure (After Reorganization)
```
modules/
└── nixvim/
    ├── default.nix
    ├── core/
    │   ├── clipboard/
    │   ├── treesitter/
    │   ├── which-key/
    │   └── autopairs/
    ├── ui/
    │   ├── lualine/
    │   ├── barbar/
    │   ├── bufferline/
    │   ├── dashboard/
    │   ├── noice/
    │   └── notify/
    ├── productivity/
    │   ├── telescope/
    │   ├── neo-tree/
    │   ├── oil/
    │   ├── hop/
    │   └── auto-session/
    ├── git/
    │   ├── gitsigns/
    │   ├── neogit/
    │   ├── lazygit/
    │   └── diffview/
    ├── lsp/
    │   ├── lsp/
    │   ├── lsp-format/
    │   ├── lspkind/
    │   ├── none-ls/
    │   └── trouble/
    ├── formatting/
    │   ├── conform/
    │   ├── trim/
    │   └── indent-blankline/
    ├── search/
    │   └── neoclip/
    └── utilities/
        ├── mini/
        ├── tmux/
        ├── floaterm/
        ├── toggleterm/
        └── [other misc modules]
```

**Structure Decision**: Snowfall Lib compliant categorical organization within `modules/nixvim/`. Maintains Snowfall's auto-discovery while adding functional categorization. Directory structure preserves Snowfall conventions: `lib/` for utilities, `modules/` for nixvim modules, `packages/` for derivations, `shells/` for development environments.

## Phase 0: Outline & Research
1. **Extract unknowns from Technical Context** above:
   - For each NEEDS CLARIFICATION → research task
   - For each dependency → best practices task
   - For each integration → patterns task

2. **Generate and dispatch research agents**:
   ```
   For each unknown in Technical Context:
     Task: "Research {unknown} for {feature context}"
   For each technology choice:
     Task: "Find best practices for {tech} in {domain}"
   ```

3. **Consolidate findings** in `research.md` using format:
   - Decision: [what was chosen]
   - Rationale: [why chosen]
   - Alternatives considered: [what else evaluated]

**Output**: research.md with all NEEDS CLARIFICATION resolved

## Phase 1: Design & Contracts
*Prerequisites: research.md complete*

1. **Extract entities from feature spec** → `data-model.md`:
   - Entity name, fields, relationships
   - Validation rules from requirements
   - State transitions if applicable

2. **Generate API contracts** from functional requirements:
   - For each user action → endpoint
   - Use standard REST/GraphQL patterns
   - Output OpenAPI/GraphQL schema to `/contracts/`

3. **Generate contract tests** from contracts:
   - One test file per endpoint
   - Assert request/response schemas
   - Tests must fail (no implementation yet)

4. **Extract test scenarios** from user stories:
   - Each story → integration test scenario
   - Quickstart test = story validation steps

5. **Update agent file incrementally** (O(1) operation):
   - Run `.specify/scripts/bash/update-agent-context.sh copilot`
     **IMPORTANT**: Execute it exactly as specified above. Do not add or remove any arguments.
   - If exists: Add only NEW tech from current plan
   - Preserve manual additions between markers
   - Update recent changes (keep last 3)
   - Keep under 150 lines for token efficiency
   - Output to repository root

**Output**: data-model.md, /contracts/*, failing tests, quickstart.md, agent-specific file

## Phase 2: Task Planning Approach
*This section describes what the /tasks command will do - DO NOT execute during /plan*

**Task Generation Strategy**:
- Load `.specify/templates/tasks-template.md` as base
- Generate tasks from Phase 1 design docs (contracts, data model, quickstart)
- Each functional requirement → validation task [P]
- Each module category → creation and population task
- Each migration script → development and testing task
- Integration tasks to ensure full system works together

**Ordering Strategy**:
1. **Setup Phase**: Create category structure and analysis tools [P]
2. **Analysis Phase**: Module categorization and assignment rules [P] 
3. **Migration Phase**: File movement and import path updates (sequential)
4. **Validation Phase**: Testing and verification of reorganization [P]
5. **Documentation Phase**: Update docs and create migration guides [P]

**Estimated Output**: 15-20 numbered, ordered tasks in tasks.md

**Key Task Categories**:
- Category definition and creation (4 tasks)
- Module analysis and assignment (3 tasks) 
- Migration script development (2 tasks)
- File migration execution (1 task)
- Import path updates (2 tasks)
- Validation and testing (4 tasks)
- Documentation updates (3 tasks)

**IMPORTANT**: This phase is executed by the /tasks command, NOT by /plan

## Phase 3+: Future Implementation
*These phases are beyond the scope of the /plan command*

**Phase 3**: Task execution (/tasks command creates tasks.md)  
**Phase 4**: Implementation (execute tasks.md following constitutional principles)  
**Phase 5**: Validation (run tests, execute quickstart.md, performance validation)

## Complexity Tracking
*No constitutional violations detected - reorganization aligns with all principles*


## Progress Tracking
*This checklist is updated during execution flow*

**Phase Status**:
- [x] Phase 0: Research complete (/plan command)
- [x] Phase 1: Design complete (/plan command)
- [x] Phase 2: Task planning complete (/plan command - describe approach only)
- [x] Phase 3: Tasks generated (/tasks command)
- [ ] Phase 4: Implementation complete
- [ ] Phase 5: Validation passed

**Gate Status**:
- [x] Initial Constitution Check: PASS
- [x] Post-Design Constitution Check: PASS
- [x] All NEEDS CLARIFICATION resolved
- [x] Complexity deviations documented

---
*Based on Constitution v1.1.0 - See `.specify/memory/constitution.md`*
