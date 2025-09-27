#!/usr/bin/env bash
# Test neovim-writer package build
set -euo pipefail

echo "Testing neovim-writer package..."

# Test package can be evaluated (builds config)
if ! nix eval .#packages.x86_64-linux.neovim-writer.config --show-trace >/dev/null 2>&1; then
  echo "ERROR: neovim-writer package failed nix evaluation"
  exit 1
fi

echo "neovim-writer package evaluation test passed."
exit 0