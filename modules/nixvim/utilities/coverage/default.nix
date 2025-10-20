{ lib, ... }:
let
  wrap = lib.moduleEnable;
in
wrap "coverage" {
  plugins.coverage = {
    enable = false;

    settings.auto_reload = true;
  };
}
