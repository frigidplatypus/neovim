{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.productivity.surround;
in
{
  options.frgdNeovim.productivity.surround.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable surround productivity plugin.";
  };

  config = mkIf cfg.enable {
    plugins.vim-surround.enable = true;
  };
}
