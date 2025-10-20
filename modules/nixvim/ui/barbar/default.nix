{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ui.barbar;
in
{
  options.frgdNeovim.ui.barbar = with types; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether or not to enable the Barbar UI plugin.";
    };
  };

  config = mkIf cfg.enable {
    plugins.barbar.enable = true;
  };
}
