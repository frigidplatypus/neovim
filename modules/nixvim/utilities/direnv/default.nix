{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.utilities.direnv;
in
{
  options.frgdNeovim.utilities.direnv.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable direnv utility plugin.";
  };

  config = mkIf cfg.enable {
    plugins.direnv.enable = true;
  };
}
