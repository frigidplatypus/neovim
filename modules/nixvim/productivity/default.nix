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
    frgdNeovim.productivity.comment.enable = true;
    frgdNeovim.productivity.hop.enable = true;
    frgdNeovim.productivity.inc-rename.enable = true;
    frgdNeovim.productivity.navic.enable = true;
    frgdNeovim.productivity.neo-tree.enable = true;
    frgdNeovim.productivity.neoscroll.enable = true;
    frgdNeovim.productivity.oil.enable = true;
    frgdNeovim.productivity.surround.enable = true;
    frgdNeovim.productivity.wrapping.enable = true;
    frgdNeovim.productivity.yanky.enable = true;
  };
}
