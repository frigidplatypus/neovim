{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.git.lazygit;
in
{
  options.frgdNeovim.git.lazygit.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable lazygit git plugin.";
  };

  config = mkIf cfg.enable {
    plugins.lazygit.enable = true;
    keymaps = [
      {
        key = "<leader>gg";
        action = "<cmd>LazyGit<cr>";
        options = {
          desc = "Open LazyGit";
        };
      }
    ];
  };
}
