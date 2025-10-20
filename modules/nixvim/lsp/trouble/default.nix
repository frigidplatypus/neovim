{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.lsp.trouble;
in
{
  options.frgdNeovim.lsp.trouble.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable trouble LSP plugin.";
  };

  config = mkIf cfg.enable {
    plugins.trouble = {
      enable = true;
      settings = {
        auto_close = true;
        auto_open = false;
        auto_fold = false;
        auto_preview = false;
        win = {
          position = "right";
        };
        keys = {
          "<leader>gh" = "hover";
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        action = "<cmd>Trouble diagnostics toggle<cr>";
        key = "<leader>tt";
        options.desc = "Toggle trouble";
      }
      {
        mode = "n";
        action = "<cmd>Trouble todo toggle<cr>";
        key = "<leader>tn";
        options.desc = "Toggle notes";
      }
    ];
  };
}
