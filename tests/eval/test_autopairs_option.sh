#!/usr/bin/env bash
set -euo pipefail
echo "Checking autopairs module for options scaffold..."
FILE="modules/nixvim/core/autopairs/default.nix"
if grep -q "options.frgdNeovim.nixvim.autopairs" "$FILE"; then
  echo "Options scaffold present (string found)."
  exit 0
fi

echo "Options scaffold not found. This test expects a scaffold comment or options block in $FILE"
exit 2
