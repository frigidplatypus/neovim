{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.productivity.hop;
in
{
  options.frgdNeovim.productivity.hop.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable hop productivity plugin.";
  };

  config = mkIf cfg.enable {
    plugins.hop.enable = true;
    keymaps = [
      {
        key = "<leader>hw";
        action = "<cmd>HopWordAC<cr>";
        options = {
          desc = "Hop To Next Word";
        };
      }
    ];
  };
}
