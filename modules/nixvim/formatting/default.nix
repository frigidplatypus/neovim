{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.formatting;
in
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
    frgdNeovim.formatting.conform.enable = lib.mkDefault true;
    frgdNeovim.formatting.trim.enable = lib.mkDefault true;
    frgdNeovim.formatting.ts-context-commentstring.enable = lib.mkDefault true;
  };
}
