{ lib, ... }:
let wrap = lib.moduleEnable;
in wrap "quickmath" {
	plugins.quickmath.enable = false;
}
