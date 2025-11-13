{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.formatting.trim;
in
{
  options.frgdNeovim.formatting.trim.enable = mkOption {
    type = types.bool;
    default = false; # Disabled - replaced by mini.trailspace
    description = "Enable trim formatting plugin. Replaced by mini.trailspace.";
  };

  config = mkIf cfg.enable {
    plugins.trim.enable = true;
  };
}
