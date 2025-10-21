{ config, lib, ... }:
with lib;
let
  allowedColorschemes = [
    "ayu"
    "bamboo"
    "base16"
    "catppuccin"
    "cyberdream"
    "dracula"
    "dracula-nvim"
    "everforest"
    "github-theme"
    "gruvbox"
    "gruvbox-baby"
    "gruvbox-material"
    "gruvbox-material-nvim"
    "kanagawa"
    "kanagawa-paper"
    "melange"
    "modus"
    "monokai-pro"
    "moonfly"
    "nightfox"
    "nord"
    "one"
    "onedark"
    "oxocarbon"
    "palette"
    "poimandres"
    "rose-pine"
    "solarized-osaka"
    "tokyonight"
    "vscode"
  ];
  cfg = config.frgdNeovim.ui.colorschemes;
in
{
  options.frgdNeovim.ui.colorschemes = with types; {
    default = mkOption {
      type = types.enum allowedColorschemes;
      default = "gruvbox";
      description = "The default colorscheme to enable.";
    };
  };

  config = {
    colorschemes.${cfg.default}.enable = true;
  };
}
