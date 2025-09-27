{ lib, ... }:
let wrap = lib.moduleEnable; in
wrap "snacks" {
	plugins.snacks = { enable = true; };
}
