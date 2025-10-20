{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.productivity.inc-rename;
in
{
  options.frgdNeovim.productivity.inc-rename.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable inc-rename productivity plugin.";
  };

  config = mkIf cfg.enable {
    plugins."inc-rename".enable = true;
  };
}
