{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ui.dressing;
in
{
  options.frgdNeovim.ui.dressing = with types; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether or not to enable the Dressing UI plugin.";
    };
  };

  config = mkIf cfg.enable {
    plugins.dressing.enable = true;
  };
}
