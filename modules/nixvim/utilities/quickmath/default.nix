{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.utilities.quickmath;
in
{
  options.frgdNeovim.utilities.quickmath.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable quickmath utility plugin.";
  };

  config = mkIf cfg.enable {
    plugins.quickmath.enable = true;
  };
}
