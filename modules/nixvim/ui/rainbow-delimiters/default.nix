{ lib, ... }:
let wrap = lib.moduleEnable;
in wrap "rainbow-delimiters" {

  plugins = {
    rainbow-delimiters = {
      enable = true;

    };
  };
}
