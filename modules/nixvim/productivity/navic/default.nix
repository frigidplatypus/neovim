{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.productivity.navic;
in
{
  options.frgdNeovim.productivity.navic.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable navic productivity plugin.";
  };

  config = mkIf cfg.enable {
    plugins.navic = {
      enable = true;
      # settings.highlight = true;
      # separator = " \uf105 ";
      # lsp = { autoAttach = true; preference = [ "nixd" ]; };
    };
  };
}
