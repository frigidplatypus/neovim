{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ui.bufferline;
in
{
  options.frgdNeovim.ui.bufferline = with types; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether or not to enable the Bufferline UI plugin.";
    };
  };

  config = mkIf cfg.enable {
    plugins.bufferline.enable = true;
  };
}
