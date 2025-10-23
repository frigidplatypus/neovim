{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.core.mini;
in
{
  options.frgdNeovim.core.mini.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable mini utility plugin.";
  };

  config = mkIf cfg.enable {
    plugins.mini.enable = true;
  };
}
