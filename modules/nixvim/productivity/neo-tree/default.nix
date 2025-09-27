{ lib, ... }:
let wrap = lib.moduleEnable; in
wrap "neo-tree" {
  plugins."neo-tree" = {
    enable = true;
    autoCleanAfterSessionRestore = true;
    closeIfLastWindow = true;
  };
  keymaps = [
    { mode = "n"; key = "<leader>fn"; action = "<cmd>Neotree toggle<cr>"; }
    { mode = "n"; key = "<leader>fe"; action = "<cmd>Neotree focus<cr>"; }
  ];
}
