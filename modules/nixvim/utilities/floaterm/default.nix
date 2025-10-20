{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.utilities.floaterm;
in
{
  options.frgdNeovim.utilities.floaterm.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable floaterm utility plugin.";
  };

  config = mkIf cfg.enable {
    plugins.floaterm = {
      enable = true;
      settings = {
        wintype = "split";
        keymaps = {
          toggle = "<leader>ft";
        };
        height = 0.3;
        # width = 0.9;
      };
    };
  };
}
