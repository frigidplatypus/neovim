{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.productivity.neoscroll;
in
{
  options.frgdNeovim.productivity.neoscroll.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable neoscroll productivity plugin.";
  };

  config = mkIf cfg.enable {
    plugins.neoscroll.enable = true;
  };
}
