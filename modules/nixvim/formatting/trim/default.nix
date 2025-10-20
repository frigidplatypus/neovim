{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.formatting.trim;
in
{
  options.frgdNeovim.formatting.trim.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable trim formatting plugin.";
  };

  config = mkIf cfg.enable {
    plugins.trim.enable = true;
  };
}
