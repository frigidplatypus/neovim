{ lib, ... }:
let wrap = lib.moduleEnable;
in wrap "markdown-preview" {
	plugins.markdown-preview.enable = true;
}
