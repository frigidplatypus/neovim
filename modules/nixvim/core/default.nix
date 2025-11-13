{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.core;
in
{
  options.frgdNeovim.core.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable all core plugins.";
  };

  config = mkIf cfg.enable {
    frgdNeovim.core.mini.enable = true;
    frgdNeovim.core.tmux.enable = true;
    frgdNeovim.core.telescope.enable = true;
    # Existing core plugins:
    frgdNeovim.core.autopairs.enable = lib.mkForce false; # Replaced by mini.pairs
    frgdNeovim.core.clipboard.enable = true;
    frgdNeovim.core.treesitter.enable = true;
    frgdNeovim.core."which-key".enable = true;
  };
}
