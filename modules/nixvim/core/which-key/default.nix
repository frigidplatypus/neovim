{ lib, ... }:
let wrap = lib.moduleEnable; in
wrap "which-key" {
  keymaps = [ { mode = [ "n" "v" ]; action = "<cmd>WhichKey<cr>"; key = "<leader>?"; options = { desc = "Show available keys"; silent = true; noremap = true; }; } ];
  plugins."which-key" = { enable = true; };
}
