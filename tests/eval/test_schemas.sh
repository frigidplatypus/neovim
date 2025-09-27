#!/usr/bin/env bash
# Test that schema files exist and can be evaluated
set -euo pipefail

echo "Testing schema files..."

# Check schema files exist
SCHEMAS=(
  "lib/nix/module-schema.nix"
  "lib/nix/profile-schema.nix" 
  "lib/nix/profile-tools.nix"
)

for schema in "${SCHEMAS[@]}"; do
  if [ ! -f "$schema" ]; then
    echo "Missing schema file: $schema"
    exit 1
  fi
done

echo "All schema files present."

# Try light nix eval if nix is available
if command -v nix >/dev/null 2>&1; then
  echo "Testing nix evaluation of schemas..."
  
  # Test each schema can be imported
  for schema in "${SCHEMAS[@]}"; do
    if ! nix eval --file "$schema" --show-trace >/dev/null 2>&1; then
      echo "Schema $schema failed nix evaluation"
      exit 2
    fi
  done
  
  echo "Schema evaluation tests passed."
else
  echo "Nix not available, skipping evaluation tests."
fi

exit 0