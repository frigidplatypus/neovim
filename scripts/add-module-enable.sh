#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(pwd)"
DRY_RUN=1
APPLY=0
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    --apply) APPLY=1; DRY_RUN=0 ;;
  esac
done

echo "Scanning modules for enable-option scaffolding (dry-run=$DRY_RUN)..."
found=()
for f in modules/nixvim/*/*/default.nix; do
  # extract module name (last path component's parent)
  module=$(basename $(dirname "$f"))
  if rg -q "options\.frgdNeovim\.nixvim\.$module" "$f" >/dev/null 2>&1; then
    echo "SKIP: $f already contains options for $module"
  else
    echo "SUGGEST: add options scaffold for $module in $f"
    found+=("$f")
    # Show a minimal suggested patch snippet
    echo "--- $f"
    echo "+++ $f (suggested)"
    echo "@@"
    echo "+  # options.frgdNeovim.nixvim.$module = with lib.types; { enable = mkBoolOpt false; };"
    echo
  fi
done

if [ ${#found[@]} -eq 0 ]; then
  echo "No files need scaffolding."
  exit 0
fi

if [ $APPLY -eq 1 ]; then
  if [ "$FORCE_APPLY" != "1" ]; then
    echo "--apply requested but FORCE_APPLY!=1; refusing to write files. Set FORCE_APPLY=1 in the environment to actually apply."
    exit 2
  fi
  echo "Applying patches..."
  # Intentionally not implemented here to avoid accidental repo-wide edits
  echo "Apply behavior not implemented in this dry-run-safe script."
  exit 2
fi

echo "Dry-run complete. To apply, run: FORCE_APPLY=1 $0 --apply (not implemented)."
exit 0
