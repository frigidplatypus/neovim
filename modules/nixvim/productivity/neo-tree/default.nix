{ lib, ... }:
let wrap = lib.moduleEnable; in
wrap "neo-tree" {
  plugins."neo-tree" = {
    enable = true;
    settings.auto_clean_after_session_restore = true;
    settings.close_if_last_window = true;
  };
  keymaps = [
    { mode = "n"; key = "<leader>fn"; action = "<cmd>Neotree toggle<cr>"; }
    { mode = "n"; key = "<leader>fe"; action = "<cmd>Neotree focus<cr>"; }
  ];
}
