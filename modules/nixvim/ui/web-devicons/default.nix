{ lib, ... }:
let wrap = lib.moduleEnable;
in wrap "web-devicons" {
	plugins.web-devicons.enable = true;
}
