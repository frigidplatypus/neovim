{ lib, ... }:
let wrap = lib.moduleEnable;
in wrap "otter" {
	plugins.otter.enable = true;
}
