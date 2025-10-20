{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.utilities.snacks;
in
{
  options.frgdNeovim.utilities.snacks.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable snacks utility plugin.";
  };

  config = mkIf cfg.enable {
    plugins.snacks.enable = true;
  };
}
