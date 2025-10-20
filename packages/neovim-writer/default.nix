{
  lib,
  pkgs,
  inputs,
  ...
}:
## neovim-writer variant
## For now just enables core modules; writing-specific modules will get toggles after migration.
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
  pname = "neovim-writer";
  meta = (old.meta or { }) // {
    description = "Neovim (writer profile; core module toggles active)";
  };
})
