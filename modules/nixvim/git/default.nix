{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.git;
in
{
  options.frgdNeovim.git.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable all git plugins.";
  };

  config = mkIf cfg.enable {
    frgdNeovim.git.neogit.enable = true;
    frgdNeovim.git.gitsigns.enable = true;
    frgdNeovim.git.lazygit.enable = true;
    frgdNeovim.git.diffview.enable = true;
  };
}
