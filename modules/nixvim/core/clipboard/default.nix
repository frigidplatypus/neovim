{ lib, ... }:
let wrap = lib.moduleEnable; in
wrap "clipboard" {
  clipboard = {
    register = "unnamedplus";
    # providers.wl-copy.enable = true; # future: conditional wayland provider
  };
}
