{ lib, ... }:
let wrap = lib.moduleEnable;
in wrap "tmux" {
  plugins = {
    cmp-tmux.enable = true;
    tmux-navigator = {
      enable = true;
      autoLoad = true;
    };
  };
}

