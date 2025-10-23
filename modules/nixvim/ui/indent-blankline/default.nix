{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ui."indent-blankline";
in
{
  options.frgdNeovim.ui."indent-blankline" = with types; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether or not to enable the Indent Blankline UI plugin.";
    };
  };

  config = mkIf cfg.enable {
    plugins.indent-blankline.enable = true;
  };
}
