{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ai;
in
{
  options.frgdNeovim.ai.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable all AI plugins.";
  };

  config = mkIf cfg.enable {
    frgdNeovim.ai.copilot-lua.enable = true;
    frgdNeovim.ai.copilot-chat.enable = true;
    frgdNeovim.ai.codecompanion.enable = true;
  };
}
