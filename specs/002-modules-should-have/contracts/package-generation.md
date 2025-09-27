# Package Generation Contract

## Package Variant Schema
Each package variant must follow this structure:

```nix
{
  lib,
  ...
}:
with lib;
with lib.frgd;
{
  # Package metadata
  name = "{PACKAGE_NAME}";
  description = "{PACKAGE_DESCRIPTION}";
  
  # Module configuration
  config = {
  frgdNeovim.nixvim = {
      # Enable specific modules for this variant
      {MODULE_1}.enable = true;
      {MODULE_2}.enable = true;
      # ... other modules as needed
      
      # Color scheme configuration (optional)
      colorscheme = mkIf (colorScheme != null) {
        enable = true;
        name = colorScheme;
      };
    };
    
    # Additional nixvim configuration (optional)
    programs.nixvim = {
      # Extra configuration specific to this variant
    };
  };
}
```

## Package Definition Contract

### Required Attributes
- **name**: Unique package identifier matching directory name
- **description**: Human-readable description of package purpose and target use case
- **config**: Nix configuration that enables appropriate modules

### Module Selection Rules
- **Minimal Packages**: Should enable only essential modules (core category minimum)
- **Specialized Packages**: Should enable relevant categories for specific use cases
- **Full Package**: Should enable all modules (current default behavior)
- **Dependency Resolution**: Nix will automatically handle module dependencies

### Color Scheme Integration
- **Optional Feature**: Packages may specify default color schemes
- **Override Support**: Users should be able to override package color schemes
- **Module Integration**: Color scheme should be passed to relevant UI modules

## Predefined Package Variants

### neovim (Default/Full)
```nix
# Enable all modules - current behavior
frgdNeovim.nixvim = {
  # All categories enabled
  ai.*.enable = true;
  core.*.enable = true;
  ui.*.enable = true;
  productivity.*.enable = true;
  git.*.enable = true;
  lsp.*.enable = true;
  formatting.*.enable = true;
  search.*.enable = true;
  utilities.*.enable = true;
};
```

### neovim-minimal
```nix
# Core functionality only
frgdNeovim.nixvim = {
  core.autopairs.enable = true;
  core.clipboard.enable = true;
  core.treesitter.enable = true;
  core.which-key.enable = true;
};
```

### neovim-dev
```nix
# Development-focused configuration
frgdNeovim.nixvim = {
  # Core modules
  core.*.enable = true;
  
  # Development essentials
  lsp.*.enable = true;
  git.*.enable = true;
  formatting.*.enable = true;
  search.telescope.enable = true;
  search.hop.enable = true;
  
  # Minimal UI
  ui.lualine.enable = true;
  ui.web-devicons.enable = true;
  ui.colorscheme.enable = true;
};
```

### neovim-writer
```nix
# Writing and documentation focused
frgdNeovim.nixvim = {
  # Core modules
  core.*.enable = true;
  
  # Writing tools
  productivity.auto-session.enable = true;
  productivity.goyo.enable = true;
  productivity.markdown-preview.enable = true;
  productivity.render-markdown.enable = true;
  productivity.wrapping.enable = true;
  
  # Distraction-free UI
  ui.dashboard.enable = true;
  ui.colorscheme.enable = true;
  ui.notify.enable = true;
};
```

## Package Discovery Contract

### Snowfall Integration
- **Auto-Discovery**: Packages placed in `packages/{PACKAGE_NAME}/default.nix` are automatically discovered
- **Build Targets**: Each package becomes available as `nix build .#packages.{system}.{PACKAGE_NAME}`
- **Cross-Platform**: Packages must work on all platforms supported by nixvim

### Naming Convention
- **Base Name**: `neovim` for default full-featured package
- **Variant Suffix**: `neovim-{variant}` for specialized packages
- **Clear Names**: Variant names should be self-explanatory (minimal, dev, writer)

## Validation Contract

### Build Tests
```bash
# Package builds successfully
nix build .#packages.x86_64-linux.{PACKAGE_NAME}

# Package evaluation succeeds
nix eval .#packages.x86_64-linux.{PACKAGE_NAME} --show-trace

# Package works with flake check
nix flake check
```

### Functionality Tests
```bash
# Package starts without errors
nix run .#packages.x86_64-linux.{PACKAGE_NAME} -- --version

# Package has expected modules enabled
nix run .#packages.x86_64-linux.{PACKAGE_NAME} -- -c ":lua print(vim.inspect(require('lazy').plugins()))"
```

### Performance Tests  
```bash
# Build time regression test
time nix build .#packages.x86_64-linux.{PACKAGE_NAME}

# Memory usage during evaluation
nix eval --max-memory 500000000 .#packages.x86_64-linux.{PACKAGE_NAME}
```

## User Interface Contract

### Configuration Override
Users can override package configurations:
```nix
{
  inputs.neovim.packages.x86_64-linux.neovim-dev.override {
  frgdNeovim.nixvim.ai.copilot-lua.enable = true;  # Add AI support to dev package
    colorScheme = "tokyonight";                # Override color scheme
  };
}
```

### Custom Packages
Users can create custom packages using the same pattern:
```nix
{
  inputs.neovim.lib.makeNeovimPackage {
    name = "my-custom-neovim";
    description = "My personalized neovim configuration";
  config.frgdNeovim.nixvim = {
      # Custom module selection
    };
  };
}
```

This contract ensures consistent package generation while providing flexibility for different use cases and user customization.