{ lib, ... }:
let wrap = lib.moduleEnable;
in wrap "bufferline" {
	plugins.bufferline.enable = true;
}
