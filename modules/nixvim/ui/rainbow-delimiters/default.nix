{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ui."rainbow-delimiters";
in
{
  options.frgdNeovim.ui."rainbow-delimiters" = with types; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether or not to enable the Rainbow Delimiters UI plugin.";
    };
  };

  config = mkIf cfg.enable {
    plugins.rainbow-delimiters.enable = true;
  };
}
