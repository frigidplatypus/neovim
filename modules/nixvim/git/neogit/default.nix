{ lib, ... }:
let wrap = lib.moduleEnable;
in wrap "neogit" {
  plugins.neogit = {
    enable = true;
  };
}
