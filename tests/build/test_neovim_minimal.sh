#!/usr/bin/env bash
# Test neovim-minimal package build
set -euo pipefail

echo "Testing neovim-minimal package..."

# Test package can be evaluated (builds config)
if ! nix eval .#packages.x86_64-linux.neovim-minimal.config --show-trace >/dev/null 2>&1; then
  echo "ERROR: neovim-minimal package failed nix evaluation"
  exit 1
fi

echo "neovim-minimal package evaluation test passed."
exit 0