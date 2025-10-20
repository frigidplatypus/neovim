{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ui.rainbowDelimiters;
in
{
  options.frgdNeovim.ui.rainbowDelimiters = with types; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether or not to enable the Rainbow Delimiters UI plugin.";
    };
  };

  config = mkIf cfg.enable {
    plugins.rainbow-delimiters.enable = true;
  };
}
