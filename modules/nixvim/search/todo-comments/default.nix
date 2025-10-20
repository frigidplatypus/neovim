{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.search."todo-comments";
in
{
  options.frgdNeovim.search."todo-comments".enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable todo-comments search plugin.";
  };

  config = mkIf cfg.enable {
    plugins."todo-comments".enable = true;
  };
}
