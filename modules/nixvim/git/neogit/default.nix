{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.git.neogit;
in
{
  options.frgdNeovim.git.neogit.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable neogit git plugin.";
  };

  config = mkIf cfg.enable {
    plugins.neogit.enable = true;
  };
}
