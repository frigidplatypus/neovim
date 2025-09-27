{ lib, ... }:
let wrap = lib.moduleEnable; in
wrap "lualine" {
  plugins.lualine = { enable = true; };
}
