{ lib, ... }:
let wrap = lib.moduleEnable;
in wrap "dressing" {
	plugins.dressing.enable = true;
}
