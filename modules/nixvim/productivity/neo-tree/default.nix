{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.productivity.neo-tree;
in
{
  options.frgdNeovim.productivity.neo-tree.enable = mkOption {
    type = types.bool;
    default = false; # explicitly ensure enabled
    description = "Enable neo-tree productivity plugin.";
  };

  config = mkIf cfg.enable {
    plugins."neo-tree" = {
      enable = true;
      settings.auto_clean_after_session_restore = true;
      settings.close_if_last_window = true;
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>fn";
        action = "<cmd>Neotree toggle<cr>";
      }
      {
        mode = "n";
        key = "<leader>fe";
        action = "<cmd>Neotree focus<cr>";
      }
    ];
    extraConfigLua = ''
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          local arg = vim.fn.argv(0)
          if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
            vim.cmd("Neotree")
          end
        end,
      })
    '';
  };
}
