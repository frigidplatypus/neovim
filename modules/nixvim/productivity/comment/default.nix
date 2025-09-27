{ lib, ... }:
let wrap = lib.moduleEnable;
in wrap "comment" {
	plugins.comment.enable = true;
}
