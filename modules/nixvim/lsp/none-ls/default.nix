{ lib, ... }:
let wrap = lib.moduleEnable; in
wrap "none-ls" {
  plugins."none-ls" = {
    enable = true;
    sources.diagnostics.deadnix.enable = true;
  };
}
