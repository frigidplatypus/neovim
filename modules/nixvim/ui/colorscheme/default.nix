{ lib, ... }:
let wrap = lib.moduleEnable;
in wrap "colorscheme" {
  colorschemes.gruvbox = {
    enable = true;
  };
}
