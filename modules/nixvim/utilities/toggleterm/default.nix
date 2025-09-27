{ lib, ... }:
let wrap = lib.moduleEnable;
in wrap "toggleterm" {
  plugins.toggleterm = {
    enable = false;
    settings = {
      open_mapping = "[[<a-m>]]";
    };
  };
}
