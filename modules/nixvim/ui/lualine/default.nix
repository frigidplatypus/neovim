{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ui.lualine;
in
{
  options.frgdNeovim.ui.lualine = with types; {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether or not to enable the Lualine UI plugin.";
    };
  };

  config = mkIf cfg.enable {
    plugins.lualine.enable = true;
  };
}
