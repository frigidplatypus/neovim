{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.search;
in
{
  options.frgdNeovim.search.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable all search plugins.";
  };

  config = mkIf cfg.enable {
    frgdNeovim.search.neoclip.enable = true;
    frgdNeovim.search.todo-comments.enable = true;
  };
}
