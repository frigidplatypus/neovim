{ lib, ... }:
let wrap = lib.moduleEnable;
in wrap "render-markdown" {
	plugins.render-markdown.enable = true;
}
