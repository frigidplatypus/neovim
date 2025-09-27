{ lib, ... }:
let
  wrap = lib.moduleEnable;
in wrap "diffview" {
  plugins.diffview = {
    enable = true;
  };
}
