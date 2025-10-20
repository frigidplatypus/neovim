{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.utilities.nix;
in
{
  options.frgdNeovim.utilities.nix.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable nix utility plugin.";
  };

  config = mkIf cfg.enable {
    plugins.nix = {
      enable = true;
    };
    plugins."nix-develop" = {
      enable = true;
    };
  };
}
