{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ai;
in
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
    frgdNeovim.ai.copilotLua.enable = lib.mkDefault true;
    frgdNeovim.ai.copilotChat.enable = lib.mkDefault true;
    frgdNeovim.ai.codecompanion.enable = lib.mkDefault true;
  };
}
