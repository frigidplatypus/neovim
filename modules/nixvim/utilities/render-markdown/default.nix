{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.utilities."render-markdown";
in
{
  options.frgdNeovim.utilities."render-markdown".enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable render-markdown utility plugin.";
  };

  config = mkIf cfg.enable {
    plugins."render-markdown".enable = true;
  };
}
