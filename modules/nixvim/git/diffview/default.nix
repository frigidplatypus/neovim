{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.git.diffview;
in
{
  options.frgdNeovim.git.diffview.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable diffview git plugin.";
  };

  config = mkIf cfg.enable {
    plugins.diffview.enable = true;
  };
}
