# Research: Module Configuration Options & Package Generation

Date: 2025-09-26

Summary
-------
This research document captures decisions and rationale for implementing module-level enable/disable options and profile-driven package generation for the nixvim configuration.

Decisions
---------
- Profiles: Provide four default profiles: `development`, `writing`, `minimal`, `remote` (agreed in Clarifications session).
- Options pattern: Follow the example module pattern `options.frgdNeovim.nixvim.<module> = { enable = mkBoolOpt false ... }` and use `cfg = config.frgdNeovim.nixvim.<module>` with `mkIf cfg.enable` to conditionally add config.
- Package generation: Declarative package definitions in `packages/` driven by data profiles. Each profile is a Nix attribute set describing module flags and options; packages are simple derivations referencing the modules.
- Validation: Rely on Nix evaluation (`nix build`, `nix eval`, `nix flake check`) for dependency and option validation. No runtime validation layer required.
- Snowfall Lib: Must maintain Snowfall Lib directory layout and auto-discovery; keep module files within `modules/nixvim/*` and place package derivations in `packages/`.

Open questions / low-risk alternatives considered
---------------------------------------------
- Dynamic generation vs pre-built derivations: We prefer declarative pre-defined profiles shipped in `packages/`, with the option for users to define ad-hoc profiles in their own overlays (combination approach).
- UI for selecting profiles: Out of scope for Phase 1; documented in quickstart for manual selection/editing.

Actionable research tasks
-------------------------
1. Create schema for profile definitions (fields, types, default values).
2. Define a canonical list of modules and the minimal core set required for `minimal` profile.
3. Identify modules that require extra options beyond `enable` (e.g., color scheme, font sizes) and surface them in `data-model.md`.
4. Create example package derivations in `packages/` for the four profiles.

References
----------
- Example module pattern provided by user (uses `mkBoolOpt` and `mkIf`)
- Snowfall Lib conventions (project constitution)
# Research: Module Configuration Options and Package Generation

## Research Tasks Completed

### Module Option Pattern Research
**Decision**: Use `config.frgdNeovim.nixvim.{module}.enable` pattern with `mkBoolOpt false` defaults
**Rationale**: 
- Matches existing system flake conventions shown in user example
- Provides consistent interface across all modules
- `mkBoolOpt false` ensures modules are disabled by default (opt-in)
- `mkIf cfg.enable` provides clean conditional configuration

**Alternatives considered**:
- `programs.nixvim.{module}.enable` - Rejected due to inconsistency with user's system
- Category-based options like `frgdNeovim.nixvim.ui.enable` - Rejected as too coarse-grained

### Package Generation Strategy Research
**Decision**: Create specialized packages in `packages/` directory with different module combinations
**Rationale**:
- Snowfall Lib automatically discovers packages in `packages/` directory
- Each package variant can have different module sets enabled
- Users can choose appropriate package for their use case
- Maintains separation between module definitions and package compositions

**Alternatives considered**:
- Dynamic package generation - Rejected as overly complex for Nix evaluation
- Single package with runtime flags - Rejected as violates declarative principles

### Color Scheme Integration Research
**Decision**: Add color scheme option to package definitions, pass through to UI modules
**Rationale**:
- Color schemes are primarily UI concerns
- Package-level option allows per-variant theming
- Can be passed down to relevant modules (colorscheme, lualine, etc.)

**Alternatives considered**:
- Module-level color options - Rejected as creates inconsistency between modules
- Runtime color switching - Rejected as not declarative

### Common Use Cases Research
**Decision**: Support these package variants:
- `neovim` (default) - All modules enabled
- `neovim-minimal` - Core modules only (autopairs, clipboard, treesitter, which-key)
- `neovim-dev` - Development focused (core + lsp + git + formatting + search)
- `neovim-writer` - Writing focused (core + productivity + ui subset)

**Rationale**:
- Covers primary user personas identified in specification
- Each variant serves distinct use cases
- Names are self-explanatory and discoverable

**Alternatives considered**:
- Language-specific variants (python-dev, rust-dev) - Deferred to future enhancement
- Role-specific variants (admin, student) - Too subjective for initial implementation

### Snowfall Lib Integration Research
**Decision**: Leverage existing auto-discovery, no changes to flake structure needed
**Rationale**:
- Snowfall automatically discovers modules regardless of internal structure
- Package variants will be auto-discovered in `packages/` directory
- No manual imports or configuration updates required

**Technical Implementation Pattern**:
```nix
# In each module: modules/nixvim/{category}/{module}/default.nix
{
  config,
  lib,
  ...
}:
with lib;
with lib.frgd;
let
  cfg = config.frgdNeovim.nixvim.{module};
in
{
  options.frgdNeovim.nixvim.{module} = with types; {
    enable = mkBoolOpt false "Whether or not to enable {module}.";
    # Additional module-specific options...
  };

  config = mkIf cfg.enable {
    # Existing module configuration
  };
}
```

### Performance Impact Research
**Decision**: Minimal performance impact expected
**Rationale**:
- Module options add O(1) evaluation time per module
- Conditional configuration through `mkIf` is efficient in Nix
- Package variants share same module base, no duplication
- Current 374ms build time should be maintained

**Monitoring approach**:
- Benchmark before/after implementation
- Test with all modules enabled vs. minimal configuration
- Verify no evaluation performance regression

## Implementation Readiness
All technical unknowns have been resolved. The implementation approach is clear:
1. Add enable options to all 60+ existing modules
2. Create 4 package variants with different module combinations
3. Add color scheme support to packages
4. Validate through Nix evaluation testing

No additional research required to proceed with design phase.