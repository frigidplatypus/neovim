{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ui.notify;
in
{
  options.frgdNeovim.ui.notify = with types; {
    enable = mkOption {
      type = types.bool;
      default = false; # Disabled - replaced by mini.notify
      description = "Whether or not to enable the Notify UI plugin. Replaced by mini.notify.";
    };
  };

  config = mkIf cfg.enable {
    plugins.notify.enable = true;
    # (add settings here if needed)
  };
}
