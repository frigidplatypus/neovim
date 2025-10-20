{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.productivity.auto-session;
in
{
  options.frgdNeovim.productivity.auto-session.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable auto-session productivity plugin.";
  };

  config = mkIf cfg.enable {
    plugins."auto-session" = {
      enable = true;
      settings = {
        enabled = true;
        createEnabled = true;
        use_git_branch = true;
        auto_restore = false;
        auto_save = true;
        bypass_save_filetypes = [
          "dashboard"
          "nvim-tree"
        ];
      };
    };
    keymaps = [
      {
        mode = "n";
        action = "<cmd>Telescope session-lens<cr>";
        key = "<leader>fs";
        options = {
          desc = "Find Session";
        };
      }
    ];
  };
}
