{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.core.mini;
in
{
  options.frgdNeovim.core.mini.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable mini utility plugin.";
  };

  config = mkIf cfg.enable {
    plugins.mini = {
      enable = true;
      modules = {
        # File navigation
        files = { };

        # Auto pairs (replaces nvim-autopairs)
        pairs = { };

        # Indentation guides (replaces indent-blankline)
        indentscope = { };

        # Notifications (replaces nvim-notify and snacks.notifier)
        notify = { };

        # Comments (replaces comment.nvim)
        comment = { };

        # Surround (replaces nvim-surround)
        surround = { };

        # Trailspace (replaces trim)
        trailspace = { };

        # Cursor word highlighting (replaces snacks.words)
        cursorword = { };

        # Statusline (replaces snacks.statuscolumn)
        statusline = { };

        # Additional useful mini plugins
        bracketed = { };
        move = { };
        operators = { };
        splitjoin = { };
      };
    };
    keymaps = [
      {
        key = "<leader>fm";
        action = "<cmd>lua MiniFiles.open()<cr>";
        options = {
          desc = "Mini: File explorer";
        };
      }
      # Comment keybindings (replaces comment.nvim mappings)
      {
        key = "gcc";
        action = "<cmd>lua MiniComment.operator('line')<cr>";
        options = {
          desc = "Mini: Toggle line comment";
        };
      }
      {
        key = "gbc";
        action = "<cmd>lua MiniComment.operator('block')<cr>";
        options = {
          desc = "Mini: Toggle block comment";
        };
      }
      # Surround keybindings (replaces nvim-surround mappings)
      {
        key = "ys";
        action = "<cmd>lua MiniSurround.add('normal')<cr>";
        options = {
          desc = "Mini: Add surround";
        };
      }
      {
        key = "ds";
        action = "<cmd>lua MiniSurround.delete()<cr>";
        options = {
          desc = "Mini: Delete surround";
        };
      }
      {
        key = "cs";
        action = "<cmd>lua MiniSurround.replace()<cr>";
        options = {
          desc = "Mini: Change surround";
        };
      }
      # Trailspace keybinding (replaces trim)
      {
        key = "<leader>cw";
        action = "<cmd>lua MiniTrailspace.trim()<cr>";
        options = {
          desc = "Mini: Trim trailing whitespace";
        };
      }
    ];
  };
}
