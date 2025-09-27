{ lib, ... }:
let wrap = lib.moduleEnable;
in wrap "indent-blankline" {
	plugins.indent-blankline.enable = true;
}
