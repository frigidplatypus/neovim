{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ui.goyo;
in
{
  options.frgdNeovim.ui.goyo = with types; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether or not to enable the Goyo UI plugin.";
    };
  };

  config = mkIf cfg.enable {
    plugins.goyo.enable = true;
    # (add keymaps here if needed)
  };
}
