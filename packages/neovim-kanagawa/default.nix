{
  lib,
  pkgs,
  inputs,
  ...
}:

# Thin wrapper around the main `neovim` package that only changes the colorscheme.
import ../neovim {
  inherit lib pkgs inputs;

  # Only change: disable the default and enable Kanagawa
  neovim-config = lib.mkForce {
    colorschemes = {
      gruvbox = {
        enable = false;
      };
      kanagawa = {
        enable = true;
      };
    };
  };
}
