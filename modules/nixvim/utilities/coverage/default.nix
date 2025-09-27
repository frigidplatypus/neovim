{ lib, ... }:
let wrap = lib.moduleEnable;
in wrap "coverage" {
  plugins.coverage = {
    enable = false;

    autoReload = true;
  };
}
