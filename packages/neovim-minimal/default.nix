{ lib, pkgs, inputs, ... }:
## neovim-minimal variant
## Enable only a subset of migrated core modules.
let
  base = import ../neovim {
    inherit lib pkgs inputs;
    neovim-config = {
      frgdNeovim.nixvim = {
        treesitter.enable = true;
        "which-key".enable = true;
        autopairs.enable = true;
        clipboard.enable = true;
      };
    };
  };
in base.overrideAttrs (old: {
  pname = "neovim-minimal";
  meta = (old.meta or { }) // {
    description = "Neovim (minimal profile; core subset)";
  };
})
