{
  lib,
  pkgs,
  inputs,
  ...
}:
## Test/support variant: neovim with autopairs explicitly disabled.
## Gives distinct pname so Snowfall auto-discovery surfaces it.
let
  base = import ../neovim {
    inherit lib pkgs inputs;
    neovim-config = {
      frgdNeovim.core.autopairs.enable = false;
    };
  };
in
base.overrideAttrs (old: {
  pname = "neovim-autopairs-disabled";
  meta = (old.meta or { }) // {
    description = "Neovim test variant with autopairs disabled";
  };
})
