{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.utilities;
in
{
  options.frgdNeovim.utilities.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable all utilities plugins.";
  };

  config = mkIf cfg.enable {
    # Add utilities submodule enables here, e.g.:
    # frgdNeovim.utilities.toggleterm.enable = lib.mkDefault true;
    # ...
  };
}
