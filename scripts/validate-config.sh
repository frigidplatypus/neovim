#!/usr/bin/env bash
# Lightweight config validator (provider-agnostic)
set -euo pipefail
ROOT_DIR="$(pwd)"
CORE_FILE="$ROOT_DIR/specs/002-modules-should-have/core-modules.nix"
if [ ! -f "$CORE_FILE" ]; then
  echo "Core modules file missing: $CORE_FILE" >&2
  exit 2
fi

# Extract core module names from core-modules.nix (naive parse)
CORE_MODULES=$(sed -n '1,200p' "$CORE_FILE" | sed -n '2,$p' | tr -d '[]"' | tr -s '\n' ' ')

PROFILE_FILE=${1:-}
if [ -z "$PROFILE_FILE" ]; then
  echo "Usage: validate-config.sh <profile-file>" >&2
  exit 2
fi
if [ ! -f "$PROFILE_FILE" ]; then
  echo "Profile file not found: $PROFILE_FILE" >&2
  exit 2
fi

echo "Validating profile: $PROFILE_FILE"

# Very small heuristic: extract words that look like module names from the profile file
REQUESTED=$(rg -o "\"[a-zA-Z0-9-_]+\"" "$PROFILE_FILE" || true)
if [ -z "$REQUESTED" ]; then
  echo "No module names detected in profile; ensure it's a Nix list of strings or modules." >&2
  exit 1
fi

missings=()
for name in $REQUESTED; do
  # strip quotes
  m=$(echo $name | sed 's/"//g')
  case " $CORE_MODULES " in
    *" $m "*) ;;
    *) missings+=($m);;
  esac
done

if [ ${#missings[@]} -ne 0 ]; then
  echo "Unknown modules: ${missings[*]}"
  echo "Available core modules: $CORE_MODULES"
  exit 3
fi

echo "Profile validation passed (all referenced modules are known core modules)."
exit 0
