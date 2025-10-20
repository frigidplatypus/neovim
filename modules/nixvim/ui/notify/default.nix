{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ui.notify;
in
{
  options.frgdNeovim.ui.notify = with types; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether or not to enable the Notify UI plugin.";
    };
  };

  config = mkIf cfg.enable {
    plugins.notify.enable = true;
    # (add settings here if needed)
  };
}
