# Module Option Contract

## Module Option Schema
Every nixvim module must implement this option pattern:

```nix
{
  config,
  lib,
  ...
}:
with lib;
with lib.frgd;
let
  cfg = config.frgdNeovim.nixvim.{MODULE_NAME};
in
{
    options.frgdNeovim.nixvim.{MODULE_NAME} = with types; {
    enable = mkBoolOpt false "Whether or not to enable {MODULE_NAME}.";
    # Additional module-specific options as needed
  };

  config = mkIf cfg.enable {
    # Existing module configuration wrapped in conditional
  };
}
```

## Contract Requirements

### Option Declaration
- **Namespace**: Must use `config.frgdNeovim.nixvim.{MODULE_NAME}`
- **Enable Option**: Must provide `enable` boolean option with default `false`
- **Description**: Must include descriptive help text for enable option
- **Type Safety**: Must use proper Nix types for all options

### Configuration Conditional
- **Wrapper**: All existing configuration must be wrapped in `mkIf cfg.enable`
- **Preservation**: Existing module functionality must be unchanged when enabled
- **Dependencies**: Module dependencies must be handled through Nix module system

### Documentation
- **Help Text**: Each option must have clear documentation
- **Examples**: Complex options should include usage examples
- **Dependencies**: Module dependencies should be documented in comments

## Validation Contract
Modules must pass these validation tests:

### Evaluation Tests
```bash
# Module evaluates successfully when disabled (default)
nix eval .#nixosModules.{MODULE_NAME} --show-trace

# Module evaluates successfully when enabled
nix eval .#nixosModules.{MODULE_NAME} --override-input frgdNeovim.nixvim.{MODULE_NAME}.enable true

# Full configuration builds with module enabled
nix build .#packages.x86_64-linux.neovim-test-{MODULE_NAME}
```

### Option Tests
```bash
# Option shows up in documentation
nix eval .#nixosModules.{MODULE_NAME}.options.frgdNeovim.nixvim.{MODULE_NAME}.enable.description

# Option has correct default value
nix eval .#nixosModules.{MODULE_NAME}.options.frgdNeovim.nixvim.{MODULE_NAME}.enable.default
```

### Integration Tests
```bash
# Module works with other modules when enabled
nix build .#packages.x86_64-linux.neovim-dev

# Module doesn't break minimal configuration when disabled
nix build .#packages.x86_64-linux.neovim-minimal
```

## Breaking Changes
This contract introduces non-breaking changes:
- Modules remain enabled by default during migration
- Existing configurations continue to work unchanged
- New enable options are additive, not replacing existing functionality

## Migration Pattern
Existing modules will be updated following this pattern:

### Before (Current)
```nix
{
  config,
  lib,
  ...
}:
{
  # Direct configuration
  programs.nixvim.plugins.{plugin} = {
    enable = true;
    # plugin configuration
  };
}
```

### After (With Options)
```nix
{
  config,
  lib,
  ...
}:
with lib;
with lib.frgd;
let
  cfg = config.frgdNeovim.nixvim.{MODULE_NAME};
in
{
    options.frgdNeovim.nixvim.{MODULE_NAME} = with types; {
    options.frgdNeovim.nixvim.{MODULE_NAME} = with types; {
    enable = mkBoolOpt false "Whether or not to enable {MODULE_NAME}.";
  };

  config = mkIf cfg.enable {
    # Existing configuration moved inside conditional
    programs.nixvim.plugins.{plugin} = {
      enable = true;
      # plugin configuration
    };
  };
}
```

This contract ensures consistency across all modules while maintaining compatibility with existing configurations.