{ lib, ... }:
let wrap = lib.moduleEnable; in
wrap "codecompanion" {
  plugins."codecompanion" = {
    enable = true;
  };
}
