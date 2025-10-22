{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ai.codecompanion;
in
{
  options.frgdNeovim.ai.codecompanion = with types; {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether or not to enable the codecompanion plugin.";
    };
  };
  config = mkIf cfg.enable {
    plugins."codecompanion".enable = true;
  };
}
