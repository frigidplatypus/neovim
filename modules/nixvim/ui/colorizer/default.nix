{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ui.colorizer;
in
{
  options.frgdNeovim.ui.colorizer = with types; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether or not to enable the Colorizer UI plugin.";
    };
  };

  config = mkIf cfg.enable {
    plugins.colorizer.enable = true;
  };
}
