{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.utilities.toggleterm;
in
{
  options.frgdNeovim.utilities.toggleterm.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable toggleterm utility plugin.";
  };

  config = mkIf cfg.enable {
    plugins.toggleterm = {
      enable = true;
      settings = {
        open_mapping = "[[<a-m>]]";
      };
    };
  };
}
