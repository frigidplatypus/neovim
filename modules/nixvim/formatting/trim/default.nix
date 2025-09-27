
{ lib, ... }:
let wrap = lib.moduleEnable;
in wrap "trim" {
    plugins.trim.enable = true;
}

