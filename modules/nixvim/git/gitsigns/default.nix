{
  lib,
  helpers,
  config,
  ...
}:
with lib;
let
  cfg = config.frgdNeovim.git.gitsigns;
in
{
  options.frgdNeovim.git.gitsigns.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable gitsigns git plugin.";
  };

  config = mkIf cfg.enable {
    plugins.gitsigns = {
      enable = true;
      settings = {
        current_line_blame = true;
        trouble = config.plugins.trouble.enable;
        signs = {
          add.text = "+";
          change.text = "~";
          delete.text = "-";
          topdelete.text = "-";
          changedelete.text = "~";
          untracked.text = "\u2506";
        };
        on_attach = helpers.mkRaw ''
                    function(bufnr)
                      local which_key = require("which-key")
                      local gitsigns = require("gitsigns")

                      -- Register [c and ]c as regular keymaps (not through which-key)
                      vim.keymap.set('n', '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gitsigns.prev_hunk() end)
                        return '<Ignore>'
                      end, { buffer = bufnr, desc = "Previous hunk" })

                      vim.keymap.set('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gitsigns.next_hunk() end)
                        return '<Ignore>'
                      end, { buffer = bufnr, desc = "Next hunk" })

                      which_key.register({
                        { "<leader>h", buffer = bufnr, group = "Git Hunk" },
                        { "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>", buffer = bufnr, desc = "Stage Hunk" },
                        { "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", buffer = bufnr, desc = "Reset Hunk" },
                        { "<leader>hS", "<cmd>Gitsigns stage_buffer<cr>", buffer = bufnr, desc = "Stage Buffer" },
                        { "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<cr>", buffer = bufnr, desc = "Undo Stage Hunk" },
                        { "<leader>hR", "<cmd>Gitsigns reset_buffer<cr>", buffer = bufnr, desc = "Reset Buffer" },
                        { "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>", buffer = bufnr, desc = "Preview Hunk" },
                        { "<leader>hb", "<cmd>Gitsigns blame_line<cr>", buffer = bufnr, desc = "Blame Line" },
                        { "<leader>hd", "<cmd>Gitsigns diffthis<cr>", buffer = bufnr, desc = "Diff" },
                        { "<leader>hD", "<cmd>Gitsigns diffthis ~<cr>", buffer = bufnr, desc = "Diff (~)" },
                        { "<leader>t", buffer = bufnr, group = "Toggle" },
                        { "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<cr>", buffer = bufnr, desc = "Toggle Current Line Blame" },
                        { "<leader>td", "<cmd>Gitsigns toggle_deleted<cr>", buffer = bufnr, desc = "Toggle Deleted" },
                      }, { mode = "n" })
                    end
        '';
      };
    };
  };
}
