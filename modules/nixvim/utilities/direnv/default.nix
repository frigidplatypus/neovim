{ lib, ... }:
let wrap = lib.moduleEnable;
in wrap "direnv" {
	plugins.direnv.enable = true;
}
