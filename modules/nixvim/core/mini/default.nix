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
        # File navigation (disabled - using neotree for now)
        files = {
          enabled = false;
          settings = {
            mappings = {
              close = "q";
              go_in = "l";
              go_in_plus = "L";
              go_out = "h";
              go_out_plus = "H";
              reset = "<BS>";
              reveal_cwd = "@";
              show_help = "g?";
              synchronize = "=";
              trim_left = "<";
              trim_right = ">";
            };
            options = {
              permanent_delete = false;
              use_as_default_explorer = false;
            };
            windows = {
              max_number = 1000; # Large number instead of math.huge
              preview = true;
              width_focus = 50;
              width_nofocus = 15;
              width_preview = 25;
            };
          };
        };

        # Auto pairs (replaces nvim-autopairs)
        pairs = {
          settings = {
            modes = {
              insert = true;
              command = true;
              terminal = false;
            };
          };
        };

        # Indentation guides (replaces indent-blankline)
        indentscope = {
          settings = {
            symbol = "╎";
            options = {
              indent_at_cursor = true;
              n_lines = 10000;
            };
            mappings = {
              object_scope = "ii";
              object_scope_with_border = "ai";
              goto_top = "[i";
              goto_bottom = "]i";
            };
          };
        };

        # Notifications (replaces nvim-notify and snacks.notifier)
        notify = {
          settings = {
            window = {
              max_width_share = 0.382;
              winblend = 25;
            };
          };
        };

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
        trailspace = {
          settings = {
            only_in_normal_buffers = false;
          };
        };

        # Cursor word highlighting (replaces snacks.words)
        cursorword = {
          settings = {
            delay = 50;
          };
        };

        # Statusline (replaces snacks.statuscolumn)
        statusline = {
          settings = {
            use_icons = false;
          };
        };

        # Additional useful mini plugins
        bracketed = {
          settings = {
            buffer = {
              suffix = "b";
            };
            comment = {
              suffix = "c";
            };
            conflict = {
              suffix = "x";
            };
            diagnostic = {
              suffix = "d";
            };
            file = {
              suffix = "f";
            };
            indent = {
              suffix = "i";
            };
            jump = {
              suffix = "j";
            };
            location = {
              suffix = "l";
            };
            oldfile = {
              suffix = "o";
            };
            quickfix = {
              suffix = "q";
            };
            treesitter = {
              suffix = "t";
            };
            undo = {
              suffix = "u";
            };
            window = {
              suffix = "w";
            };
            yank = {
              suffix = "y";
            };
          };
        };

        move = {
          settings = {
            mappings = {
              left = "<M-h>";
              right = "<M-l>";
              down = "<M-j>";
              up = "<M-k>";
              line_left = "<M-h>";
              line_right = "<M-l>";
              line_down = "<M-j>";
              line_up = "<M-k>";
            };
            options = {
              reindent_linewise = true;
            };
          };
        };

        operators = {
          settings = {
            evaluate = {
              prefix = "g=";
            };
            exchange = {
              prefix = "gx";
              reindent_linewise = true;
            };
            multiply = {
              prefix = "gm";
            };
            replace = {
              prefix = "gr";
              reindent_linewise = true;
            };
            sort = {
              prefix = "gs";
            };
          };
        };

        splitjoin = {
          settings = {
            mappings = {
              toggle = "gS";
            };
            detect = {
              separator = ",";
            };
          };
        };
      };
    };
    keymaps = [
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
