{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ui;
in
{
  options.frgdNeovim.ui.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable all UI plugins.";
  };

  config = mkIf cfg.enable {
    # Add UI submodule enables here, e.g.:
    # frgdNeovim.ui.lualine.enable = lib.mkDefault true;
    # frgdNeovim.ui.bufferline.enable = lib.mkDefault true;
    # ...
  };
}
