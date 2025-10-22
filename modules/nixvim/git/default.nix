{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.git;
in
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
    frgdNeovim.git.neogit.enable = lib.mkDefault true;
    frgdNeovim.git.gitsigns.enable = lib.mkDefault true;
    frgdNeovim.git.lazygit.enable = lib.mkDefault true;
    frgdNeovim.git.diffview.enable = lib.mkDefault true;
  };
}
