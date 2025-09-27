#!/usr/bin/env bash
# Test neovim-dev package build
set -euo pipefail

echo "Testing neovim-dev package..."

# Test package can be evaluated (builds config)
if ! nix eval .#packages.x86_64-linux.neovim-dev.config --show-trace >/dev/null 2>&1; then
  echo "ERROR: neovim-dev package failed nix evaluation"
  exit 1
fi

echo "neovim-dev package evaluation test passed."
exit 0