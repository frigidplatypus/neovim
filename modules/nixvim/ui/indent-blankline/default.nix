{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ui.indentBlankline;
in
{
  options.frgdNeovim.ui.indentBlankline = with types; {
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
