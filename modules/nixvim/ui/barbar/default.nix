
{ lib, ... }:
let wrap = lib.moduleEnable;
in wrap "barbar" {
    plugins.barbar.enable = false;
}

