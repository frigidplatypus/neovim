{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ui.dashboard;
in
{
  options.frgdNeovim.ui.dashboard = with types; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether or not to enable the Dashboard UI plugin.";
    };
  };

  config = mkIf cfg.enable {
    plugins.dashboard = {
      enable = true;
      # (keep your settings block here, unchanged)
    };
  };
}
