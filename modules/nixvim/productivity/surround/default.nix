{ lib, ... }:
let wrap = lib.moduleEnable;
in wrap "surround" {
  plugins.vim-surround = {
    enable = true;
  };
}
