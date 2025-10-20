{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.productivity.comment;
in
{
  options.frgdNeovim.productivity.comment.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable comment productivity plugin.";
  };

  config = mkIf cfg.enable {
    plugins.comment.enable = true;
  };
}
