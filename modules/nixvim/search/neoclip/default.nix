{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.search.neoclip;
in
{
  options.frgdNeovim.search.neoclip.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable neoclip search plugin.";
  };

  config = mkIf cfg.enable {
    plugins.neoclip = {
      enable = true;
      settings = {
        content_spec_column = false;
        default_register = "\"";
        filter = null;
        keys = {
          fzf = {
            custom = { };
            paste = "ctrl-l";
            paste_behind = "ctrl-h";
            select = "default";
          };
          telescope = {
            i = {
              custom = { };
              paste = "<c-l>";
              paste_behind = "<c-h>";
              select = "<cr>";
            };
            n = {
              custom = { };
              paste = "p";
              paste_behind = "P";
              select = "<cr>";
            };
          };
        };
        on_paste = {
          set_reg = false;
        };
        preview = true;
      };
    };
    keymaps = [
      {
        key = "<leader>fy";
        action = "<cmd>Telescope neoclip<cr>";
        options = {
          desc = "Telescope: Clipboard history";
        };
      }
    ];
  };
}
