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
        comment = {
          settings = {
            mappings = {
              comment = "gc";
              comment_line = "gcc";
              comment_visual = "gc";
              textobject = "gc";
            };
          };
        };

        # Surround (replaces nvim-surround)
        surround = {
          settings = {
            mappings = {
              add = "ys";
              delete = "ds";
              find = "";
              find_left = "";
              highlight = "";
              replace = "cs";
              update_n_lines = "";
            };
          };
        };

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
      # Comment keybindings are handled by mini.comment settings above
      # Surround keybindings are handled by mini.surround settings above
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
