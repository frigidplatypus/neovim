{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.productivity;
in
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
    frgdNeovim.productivity.auto-session.enable = lib.mkDefault true;
    frgdNeovim.productivity.comment.enable = lib.mkDefault true;
    frgdNeovim.productivity.hop.enable = lib.mkDefault true;
    frgdNeovim.productivity.navic.enable = lib.mkDefault true;
    frgdNeovim.productivity.neo-tree.enable = lib.mkDefault true;
  };
}
