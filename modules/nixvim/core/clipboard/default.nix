{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.core.clipboard;
in
{
  options.frgdNeovim.core.clipboard = with types; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether or not to enable clipboard integration.";
    };
  };

  config = mkIf cfg.enable {
    clipboard.register = "unnamedplus";
    # providers.wl-copy.enable = true; # future: conditional wayland provider
  };
}
