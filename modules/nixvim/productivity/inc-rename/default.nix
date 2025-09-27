{ lib, ... }:
let wrap = lib.moduleEnable; in
wrap "inc-rename" {
 	plugins."inc-rename" = {
 		enable = true;
 	};
}
