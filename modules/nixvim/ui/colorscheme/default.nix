{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ui.colorschemes;
in
{
  options.frgdNeovim.ui.colorschemes = with types; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether or not to enable the Gruvbox colorscheme.";
    };
  };

  config = mkIf cfg.enable {
    colorschemes.gruvbox.enable = true;
  };
}
