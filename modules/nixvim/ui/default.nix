{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ui;
in
{
  options.frgdNeovim.ui.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable all UI plugins.";
  };

  config = mkIf cfg.enable {
    frgdNeovim.ui.barbar.enable = true;
    frgdNeovim.ui.bufferline.enable = true;
    frgdNeovim.ui.colorizer.enable = true;
    frgdNeovim.ui.colorscheme.enable = true;
    frgdNeovim.ui.dashboard.enable = true;
    frgdNeovim.ui.dressing.enable = true;
    frgdNeovim.ui.goyo.enable = true;
    frgdNeovim.ui.indent-blankline.enable = false; # Replaced by mini.indentscope
    frgdNeovim.ui.lualine.enable = true;
    frgdNeovim.ui.noice.enable = true;
    frgdNeovim.ui.notify.enable = false; # Replaced by mini.notify
    frgdNeovim.ui.rainbow-delimiters.enable = true;
    frgdNeovim.ui.web-devicons.enable = true;
  };

}
