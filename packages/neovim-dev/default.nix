{ lib, pkgs, inputs, ... }:
## neovim-dev variant
## Reintroduce enable flags for migrated core modules (others pending migration).
let
  base = import ../neovim {
    inherit lib pkgs inputs;
    neovim-config = {
      frgdNeovim.nixvim = {
        autopairs.enable = true;
        clipboard.enable = true;
        treesitter.enable = true;
        "which-key".enable = true;
      };
    };
  };
in base.overrideAttrs (old: {
  pname = "neovim-dev";
  meta = (old.meta or { }) // {
    description = "Neovim (development profile; core module toggles active)";
  };
})
