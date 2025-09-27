{ lib, ... }:
let wrap = lib.moduleEnable;
in wrap "image" {
  # TODO: Add passthrough configuration to tmux.
  plugins.image.enable = false;
}
