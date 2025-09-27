{ lib, ... }:
let wrap = lib.moduleEnable; in
wrap "mini" {
  plugins.mini = { enable = true; };
}
