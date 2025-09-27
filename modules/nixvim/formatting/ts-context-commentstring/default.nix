{ lib, ... }:
let
  wrap = lib.moduleEnable;
in wrap "ts-context-commentstring" {
  plugins.ts-context-commentstring.enable = false;
}
