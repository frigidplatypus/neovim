{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.core."which-key";
in
{
  options.frgdNeovim.core."which-key" = with types; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether or not to enable the which-key plugin.";
    };
  };

  config = mkIf cfg.enable {
    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        action = "<cmd>WhichKey<cr>";
        key = "<leader>?";
        options = {
          desc = "Show available keys";
          silent = true;
          noremap = true;
        };
      }
    ];
    plugins."which-key".enable = true;
  };
}
