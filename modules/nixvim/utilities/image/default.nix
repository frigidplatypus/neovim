{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.utilities.image;
in
{
  options.frgdNeovim.utilities.image.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable image utility plugin.";
  };

  config = mkIf cfg.enable {
    # TODO: Add passthrough configuration to tmux.
    plugins.image.enable = true;
  };
}
