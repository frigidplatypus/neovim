{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.formatting;
in
{
  options.frgdNeovim.formatting.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable all formatting plugins.";
  };

  config = mkIf cfg.enable {
    frgdNeovim.formatting.conform.enable = true;
    frgdNeovim.formatting.trim.enable = false; # Replaced by mini.trailspace
    frgdNeovim.formatting.ts-context-commentstring.enable = true;
  };
}
