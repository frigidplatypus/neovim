{
  lib,
  pkgs,
  inputs,
  ...
}:
## neovim-dev variant
## Reintroduce enable flags for migrated core modules (others pending migration).
let
  base = import ../neovim {
    inherit lib pkgs inputs;
    neovim-config = {
      frgdNeovim.core.autopairs.enable = true;
      frgdNeovim.core.clipboard.enable = true;
      frgdNeovim.core.treesitter.enable = true;
      frgdNeovim.core.treesitter.highlight.enable = true;
      frgdNeovim.ui.web-devicons.enable = true;
      frgdNeovim.core.whichKey.enable = true;
    };
  };
in
base.overrideAttrs (old: {
  pname = "neovim-dev";
  meta = (old.meta or { }) // {
    description = "Neovim (development profile; core module toggles active)";
  };
})
