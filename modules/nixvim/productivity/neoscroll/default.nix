{ lib, ... }:
let wrap = lib.moduleEnable; in
wrap "neoscroll" {
	plugins.neoscroll = {
		enable = true;
	};
}
