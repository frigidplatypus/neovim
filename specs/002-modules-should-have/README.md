# Migration README: Module Options & Snowfall Lib

This README provides a concise checklist for maintainers migrating modules to the `options.frgdNeovim.nixvim.<module>` pattern while preserving Snowfall Lib compatibility.

Quick checklist

1. Run namespace validator:

```fish
./scripts/validate-namespace.sh
```

2. Ensure `specs/002-modules-should-have/core-modules.nix` contains the canonical core list and run:

```bash
./tests/eval/test_core_modules_exist.sh
```

3. Run the mass-update script in dry-run and review patches:

```bash
./scripts/add-module-enable.sh --dry-run
```

4. Apply changes per-category (manual or via scripted apply) and run `nix flake check` after each category commit.

5. Validate package scaffolds in `packages/` and ensure `packages/*/default.nix` produce the expected `frgdNeovim.nixvim` config.

6. Run feedback validator for any custom profiles:

```bash
./scripts/validate-config.sh specs/002-modules-should-have/tmp-profile.nix
```

Notes

- Snowfall Lib auto-discovers `modules/nixvim/*/*/default.nix` and `packages/*/default.nix`. Keep this in mind when moving files.
- When in doubt, prefer adding non-invasive scaffolds first and iterate.

*** End of README
