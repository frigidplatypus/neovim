{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.productivity;
in
{
  options.frgdNeovim.productivity.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable all productivity plugins.";
  };

  config = mkIf cfg.enable {
    frgdNeovim.productivity.auto-session.enable = true;
    frgdNeovim.productivity.comment.enable = false; # Replaced by mini.comment
    frgdNeovim.productivity.hop.enable = true;
    frgdNeovim.productivity.inc-rename.enable = true;
    frgdNeovim.productivity.navic.enable = true;
    frgdNeovim.productivity.neo-tree.enable = true;
    frgdNeovim.productivity.neoscroll.enable = true;
    frgdNeovim.productivity.obsidian.enable = false;
    frgdNeovim.productivity.oil.enable = false;
    frgdNeovim.productivity.surround.enable = false; # Replaced by mini.surround
    frgdNeovim.productivity.wrapping.enable = true;
    frgdNeovim.productivity.yanky.enable = true;
  };
}
