{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.formatting.ts-context-commentstring;
in
{
  options.frgdNeovim.formatting.ts-context-commentstring.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable ts-context-commentstring formatting plugin.";
  };

  config = mkIf cfg.enable {
    plugins.ts-context-commentstring.enable = true;
  };
}
