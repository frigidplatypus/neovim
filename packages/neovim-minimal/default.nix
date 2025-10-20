{
  lib,
  pkgs,
  inputs,
  ...
}:
## neovim-minimal variant
## Enable only a subset of migrated core modules.
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
  pname = "neovim-minimal";
  meta = (old.meta or { }) // {
    description = "Neovim (minimal profile; core subset)";
  };
})
