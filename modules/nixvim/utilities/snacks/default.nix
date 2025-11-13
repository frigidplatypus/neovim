{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.utilities.snacks;
in
{
  options.frgdNeovim.utilities.snacks.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable snacks utility plugin.";
  };

  config = mkIf cfg.enable {
    plugins.snacks = {
      enable = true;
      settings = {
        picker = {
          enabled = true;
        };
        # Disable modules replaced by mini
        notifier = {
          enabled = false; # Replaced by mini.notify
        };
        words = {
          enabled = false; # Replaced by mini.cursorword
        };
        statuscolumn = {
          enabled = false; # Replaced by mini.statusline
        };
      };
    };
    keymaps = [
      {
        key = "<leader><leader>";
        action = "<cmd>lua Snacks.picker.git_files()<cr>";
        options = {
          desc = "Snacks: Git files";
        };
      }
      {
        key = "<leader>ff";
        action = "<cmd>lua Snacks.picker.files()<cr>";
        options = {
          desc = "Snacks: Find files";
        };
      }
      {
        key = "<leader>fg";
        action = "<cmd>lua Snacks.picker.grep()<cr>";
        options = {
          desc = "Snacks: Live grep";
        };
      }
      {
        key = "<leader>fb";
        action = "<cmd>lua Snacks.picker.buffers()<cr>";
        options = {
          desc = "Snacks: Buffers";
        };
      }
      {
        key = "<leader>fh";
        action = "<cmd>lua Snacks.picker.help()<cr>";
        options = {
          desc = "Snacks: Help";
        };
      }
    ] ++ lib.optionals config.frgdNeovim.search.neoclip.enable [
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
