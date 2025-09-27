# Data Model: Module Options & Profiles

This document defines entities, fields, and validation rules used by the package generation system.

Entities
--------

- Module
  - id: string (e.g., "lsp", "gitsigns")
  - enable: bool (default: false)
  - options: attrset (module-specific options, optional)

- Profile
  - id: string (e.g., "development", "minimal")
  - description: string
  - modules: attrset of booleans mapping module id → enabled
  - moduleOptions: attrset mapping module id → options to pass through (optional)

- Package
  - id: string
  - profile: Profile.id
  - derivation: reference to the Nix derivation under `packages/`

Validation rules
----------------
- Every `Profile.modules` set must include a `core` subset that maps all core modules to true for non-minimal profiles.
- Module option values must conform to allowed types (e.g., themeFile must be string or null).
- Profile definitions must not enable modules whose derivations are explicitly marked as unsupported.

Notes
-----
- Concrete types and stricter validation will be expressed in Nix as `types` in module `options` using `lib.types` where applicable.
# Data Model: Module Configuration Options

## Core Entities

### Module Option
**Purpose**: Individual nixvim module with enable/disable capability
**Attributes**:
- `name`: Module identifier (string) - matches directory name
- `category`: Functional category (ai, core, ui, etc.)
- `enable`: Boolean option with default false
- `dependencies`: List of other modules this module requires
- `description`: Human-readable description of module purpose

**Validation Rules**:
- Module name must match existing directory structure
- Category must be one of the 9 defined categories
- Dependencies must reference valid module names
- Description must be non-empty string

**State Transitions**: Static configuration - no runtime state changes

### Package Variant
**Purpose**: Named combination of modules and configuration for specific use cases
**Attributes**:
- `name`: Package identifier (string) - used in packages/ directory
- `description`: Human-readable description of package purpose
- `modules`: Map of module names to boolean (enabled/disabled)
- `colorScheme`: Optional color scheme name (string)
- `extraConfig`: Optional additional nixvim configuration

**Validation Rules**:
- Package name must be valid Nix identifier
- Module references must exist in module registry
- Color scheme must be valid nixvim theme name if specified
- extraConfig must be valid nixvim configuration

**Relationships**:
- Package → Module (many-to-many): Package can enable multiple modules
- Package → ColorScheme (many-to-one): Package can specify one color scheme

### Configuration Profile
**Purpose**: Predefined module combinations for common use cases
**Attributes**:
- `profileName`: Profile identifier (minimal, dev, writer, full)
- `includedCategories`: List of categories to include
- `excludedModules`: List of specific modules to exclude
- `requiredModules`: List of modules that must be enabled

**Validation Rules**:
- Profile name must be unique
- Category references must be valid
- Module exclusions/requirements must reference valid modules
- Required modules cannot be in excluded list

### Module Registry
**Purpose**: Central registry of all available modules with metadata
**Attributes**:
- `allModules`: Map of module name to Module Option
- `categoryModules`: Map of category to list of modules
- `dependencyGraph`: Computed dependency relationships

**Computed Properties**:
- `enabledModules(config)`: List of modules enabled in given configuration
- `validateDependencies(config)`: Check if all dependencies are satisfied
- `getMinimalSet(modules)`: Compute minimal set of modules including dependencies

## Configuration Flow

### Module Configuration
```
User Configuration → Module Options → nixvim Config
     ↓                    ↓               ↓
[enable flags]    [conditional config]  [final config]
```

### Package Generation
```
Package Variant → Profile Resolution → Module Selection → nixvim Package
      ↓                   ↓                  ↓               ↓
[variant spec]    [apply profile]    [enable modules]   [final package]
```

### Dependency Resolution
```
Selected Modules → Dependency Check → Minimal Module Set → Validation
       ↓                 ↓                   ↓              ↓
[user selection]  [add dependencies]  [complete set]   [nix eval]
```

## Data Relationships

### Module Dependencies
- `lsp/cmp` requires `lsp/lsp-config`
- `ui/lualine` requires `ui/web-devicons`
- `productivity/telescope` requires `search/hop` (optional)

### Category Dependencies
- LSP category modules often depend on core modules
- UI modules may depend on other UI modules for consistency
- Productivity modules are generally independent

### Package Compositions
- **Minimal**: `core/*` modules only
- **Dev**: `core/*` + `lsp/*` + `git/*` + `formatting/*` + `search/*`
- **Writer**: `core/*` + `productivity/*` + select `ui/*` modules
- **Full**: All modules enabled (current default behavior)

## Validation Schema

### Module Validation
```nix
moduleSchema = {
  name = types.str;
  category = types.enum [ "ai" "core" "ui" "productivity" "git" "lsp" "formatting" "search" "utilities" ];
  enable = types.bool;
  dependencies = types.listOf types.str;
  description = types.str;
};
```

### Package Validation
```nix
packageSchema = {
  name = types.str;
  description = types.str;
  modules = types.attrsOf types.bool;
  colorScheme = types.nullOr types.str;
  extraConfig = types.nullOr types.attrs;
};
```

This data model provides the foundation for implementing module options and package generation while maintaining compatibility with existing nixvim and Snowfall Lib patterns.