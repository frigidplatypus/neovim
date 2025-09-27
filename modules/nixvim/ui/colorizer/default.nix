{ lib, ... }:
let wrap = lib.moduleEnable;
in wrap "colorizer" {
	plugins.colorizer.enable = true;
}
