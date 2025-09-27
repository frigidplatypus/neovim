{ lib, ... }:
let wrap = lib.moduleEnable; in
wrap "lsp-format" {
  plugins."lsp-format" = { enable = true; };
}
