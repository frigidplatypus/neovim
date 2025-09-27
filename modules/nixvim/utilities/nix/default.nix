{ lib, ... }:
let wrap = lib.moduleEnable; in
wrap "nix" {
  plugins.nix = { enable = true; };
  plugins."nix-develop" = { enable = true; };
}
