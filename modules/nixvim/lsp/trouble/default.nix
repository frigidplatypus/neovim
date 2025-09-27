{ lib, ... }:
let wrap = lib.moduleEnable; in
wrap "trouble" {
  plugins.trouble = {
    enable = true;
    settings = {
      auto_close = true;
      auto_open = false;
      auto_fold = false;
      auto_preview = false;
      # v3: window options live under `win`
      win = { position = "right"; };
      # v3: key mappings are set via `keys`
      keys = { "<leader>gh" = "hover"; };
    };
  };
  keymaps = [ { mode = "n"; action = "<cmd>Trouble diagnostics toggle<cr>"; key = "<leader>tt"; options.desc = "Toggle trouble"; } { mode = "n"; action = "<cmd>Trouble todo toggle<cr>"; key = "<leader>tn"; options.desc = "Toggle notes"; } ];
}
