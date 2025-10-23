{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.utilities;
in
{
  options.frgdNeovim.utilities.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable all utilities plugins.";
  };

  config = mkIf cfg.enable {
    frgdNeovim.utilities.direnv.enable = true;
    frgdNeovim.utilities.floaterm.enable = true;
    frgdNeovim.utilities.image.enable = true;
    frgdNeovim.utilities.markdown-preview.enable = true;
    frgdNeovim.utilities.nix.enable = true;
    frgdNeovim.utilities.quickmath.enable = true;
    frgdNeovim.utilities.render-markdown.enable = true;
    frgdNeovim.utilities.snacks.enable = true;
    frgdNeovim.utilities.toggleterm.enable = true;
  };
}
