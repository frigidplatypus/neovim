{ lib, pkgs, inputs, ... }:
## neovim-writer variant
## For now just enables core modules; writing-specific modules will get toggles after migration.
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
  pname = "neovim-writer";
  meta = (old.meta or { }) // {
    description = "Neovim (writer profile; core module toggles active)";
  };
})
