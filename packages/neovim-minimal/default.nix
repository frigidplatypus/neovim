{ lib, pkgs ? import <nixpkgs> {} }:

# neovim-minimal package scaffold
# This file composes a `frgdNeovim.nixvim` config attrset enabling core modules
let
  core = import ../specs/002-modules-should-have/core-modules.nix {};
in
{
  # Expose composed configuration for downstream flake integration
  config = {
    frgdNeovim = {
      nixvim = lib.listToAttrs (map (m: { name = m; value = { enable = true; }; }) core);
    };
  };

  # Note: This is a scaffold. To produce an actual package derivation that builds
  # Neovim with the composed configuration, connect this file into the repository
  # flake.nix and reference existing neovim build derivations. See T019/T023 for test wiring.
}
