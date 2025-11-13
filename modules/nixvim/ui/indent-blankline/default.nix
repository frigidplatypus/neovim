{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ui."indent-blankline";
in
{
  options.frgdNeovim.ui."indent-blankline" = with types; {
    enable = mkOption {
      type = types.bool;
      default = false; # Disabled - replaced by mini.indentscope
      description = "Whether or not to enable the Indent Blankline UI plugin. Replaced by mini.indentscope.";
    };
  };

  config = mkIf cfg.enable {
    plugins.indent-blankline.enable = true;
  };
}
