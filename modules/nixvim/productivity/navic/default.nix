{ lib, ... }:
let wrap = lib.moduleEnable; in
wrap "navic" {
  plugins.navic = {
    enable = true;
    # settings.highlight = true;
    # separator = "  ";
    # lsp = { autoAttach = true; preference = [ "nixd" ]; };
  };
}
