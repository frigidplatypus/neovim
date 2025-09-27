{ lib, ... }:
let wrap = lib.moduleEnable;
in wrap "notify" {
  plugins.notify = {
    enable = false;
    settings = {
      level = 2;
      topDown = false;
      maxWidth = 600;
    };
  };
}
