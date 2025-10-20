{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.utilities."markdown-preview";
in
{
  options.frgdNeovim.utilities."markdown-preview".enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable markdown-preview utility plugin.";
  };

  config = mkIf cfg.enable {
    plugins."markdown-preview".enable = true;
  };
}
