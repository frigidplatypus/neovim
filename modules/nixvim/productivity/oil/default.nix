{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.productivity.oil;
in
{
  options.frgdNeovim.productivity.oil.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable oil productivity plugin.";
  };

  config = mkIf cfg.enable {
    plugins.oil = {
      enable = true;
      settings = {
        delete_to_trash = true;
        skip_confirm_for_simple_edits = true;
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Oil<cr>";
      }
      {
        mode = "n";
        key = "<leader>fe";
        action = "<cmd>Neotree focus<cr>";
      }
    ];
  };
}
