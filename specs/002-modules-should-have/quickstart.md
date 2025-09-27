# Quickstart: Module Options and Package Generation

## Quick Validation Test

### 1. Clone and Navigate
```bash
git clone <repository>
cd neovim
git checkout 002-modules-should-have
```

### 2. Test Current State (Before Implementation)
```bash
# Should build current full configuration
nix build .#packages.x86_64-linux.neovim
./result/bin/nvim --version

# Should pass all checks
nix flake check
```

### 3. After Implementation: Test Module Options

#### Test Individual Module Enable/Disable
```bash
# Test with specific module enabled
nix build .#packages.x86_64-linux.neovim-test --override-input config.frgdNeovim.nixvim.lsp.cmp.enable true

# Test with module disabled (should be minimal)
nix build .#packages.x86_64-linux.neovim-minimal
```

#### Test Package Variants
```bash
# Build each package variant
nix build .#packages.x86_64-linux.neovim          # Full configuration
nix build .#packages.x86_64-linux.neovim-minimal  # Core only
nix build .#packages.x86_64-linux.neovim-dev      # Development focused
nix build .#packages.x86_64-linux.neovim-writer   # Writing focused

# Verify they all work
./result/bin/nvim --version
```

### 4. Test User Stories

#### Story 1: Custom Module Selection
```bash
# User wants LSP + Git + minimal UI
nix build .#packages.x86_64-linux.neovim-dev
./result/bin/nvim test.py
# Should have: LSP completion, git signs, basic UI
# Should not have: AI tools, heavy productivity plugins
```

#### Story 2: Minimal Configuration
```bash
# User wants lightweight neovim
nix build .#packages.x86_64-linux.neovim-minimal
./result/bin/nvim test.txt
# Should have: basic editing, treesitter, which-key
# Should not have: LSP, git integration, heavy UI
```

#### Story 3: Writing-Focused Setup
```bash
# User wants distraction-free writing environment
nix build .#packages.x86_64-linux.neovim-writer
./result/bin/nvim document.md
# Should have: markdown preview, distraction-free mode, session management
# Should not have: LSP completion, git integration, development tools
```

#### Story 4: Color Scheme Customization
```bash
# User wants specific color scheme
nix build .#packages.x86_64-linux.neovim-dev --override colorScheme '"tokyonight"'
./result/bin/nvim
# Should open with tokyonight color scheme
```

### 5. Performance Validation

#### Build Time Regression Test
```bash
# Measure current build time
time nix build .#packages.x86_64-linux.neovim --rebuild

# Should maintain ~374ms build time
# Any significant regression indicates implementation issue
```

#### Memory Usage Test
```bash
# Evaluate without excessive memory usage
nix eval --max-memory 500000000 .#packages.x86_64-linux.neovim

# Should not hit memory limit during evaluation
```

### 6. Error Handling Validation

#### Test Nix Error Messages
```bash
# Try to enable non-existent module (should fail clearly)
nix build .#packages.x86_64-linux.neovim --override-input config.frgdNeovim.nixvim.nonexistent.enable true

# Try invalid color scheme (should fail clearly)  
nix build .#packages.x86_64-linux.neovim --override colorScheme '"invalid-theme"'

# Both should produce clear, helpful error messages
```

### 7. Integration Testing

#### Test with Existing Configurations
```bash
# Ensure existing user configurations still work
nix build .#packages.x86_64-linux.neovim
# Should build identical to pre-implementation version

# Test Snowfall Lib integration
nix flake show
# Should show all package variants available
```

### 8. End-to-End User Workflow

#### Complete User Journey Test
```bash
# 1. User discovers available packages
nix flake show | grep neovim

# 2. User tries minimal package  
nix run .#packages.x86_64-linux.neovim-minimal

# 3. User customizes for their needs
nix build .#packages.x86_64-linux.neovim-dev --override-input config.frgdNeovim.nixvim.ai.copilot-lua.enable true

# 4. User integrates into their system
# (Would be done in their own flake.nix)
```

## Success Criteria

### Must Pass
- [ ] All package variants build successfully
- [ ] Performance remains within 10% of current (≤410ms build time)
- [ ] All existing functionality preserved in full package
- [ ] Module options work as documented
- [ ] Clear error messages for invalid configurations

### Should Pass
- [ ] Each package variant serves its intended use case
- [ ] Color scheme integration works correctly
- [ ] Documentation is clear and helpful
- [ ] User workflow is intuitive

### Nice to Have
- [ ] Build time improvement due to smaller packages
- [ ] Easy discoverability of package variants
- [ ] Simple customization for advanced users

This quickstart provides a comprehensive validation path that mirrors real user workflows while ensuring the implementation meets all requirements.