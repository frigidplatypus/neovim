{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ui.web-devicons;
in
{
  options.frgdNeovim.ui.web-devicons = with types; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether or not to enable the Web Devicons UI plugin.";
    };
  };

  config = mkIf cfg.enable {
    plugins.web-devicons.enable = true;
  };
}
