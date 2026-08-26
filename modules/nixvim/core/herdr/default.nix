{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.core.herdr;
in
{
  options.frgdNeovim.core.herdr.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable herdr navigation integration (replaces vim-tmux-navigator).";
  };

  config = mkIf cfg.enable {
    extraConfigLuaPre = ''
      -- vim-herdr-navigation
      local function _herdr_nav(wincmd, dir)
        local prev = vim.api.nvim_get_current_win()
        vim.cmd("wincmd " .. wincmd)
        if vim.api.nvim_get_current_win() ~= prev then
          return
        end
        if vim.env.HERDR_PANE_ID and vim.env.HERDR_PANE_ID ~= "" then
          local h = vim.env.HERDR_BIN_PATH
          if h == nil or h == "" then
            h = "herdr"
          end
          vim.fn.system({ h, "pane", "focus", "--direction", dir, "--pane", vim.env.HERDR_PANE_ID })
        elseif vim.env.TMUX and vim.env.TMUX ~= "" then
          local tmux = { left = "Left", down = "Down", up = "Up", right = "Right" }
          pcall(vim.cmd, "TmuxNavigate" .. tmux[dir])
        end
      end

      vim.keymap.set("n", "<C-h>", function() _herdr_nav("h", "left") end, { silent = true, noremap = true, desc = "Navigate left (vim/herdr)" })
      vim.keymap.set("n", "<C-j>", function() _herdr_nav("j", "down") end, { silent = true, noremap = true, desc = "Navigate down (vim/herdr)" })
      vim.keymap.set("n", "<C-k>", function() _herdr_nav("k", "up") end, { silent = true, noremap = true, desc = "Navigate up (vim/herdr)" })
      vim.keymap.set("n", "<C-l>", function() _herdr_nav("l", "right") end, { silent = true, noremap = true, desc = "Navigate right (vim/herdr)" })
    '';
  };
}
