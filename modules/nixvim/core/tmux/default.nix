{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.core.tmux;
in
{
  options.frgdNeovim.core.tmux.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable tmux utility plugin.";
  };

  config = mkIf cfg.enable {
    plugins = {
      cmp-tmux.enable = true;
      tmux-navigator = {
        enable = true;
        autoLoad = true;
      };
    };
  };
}
