{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.frgdNeovim.ui.noice;
in
{
  options.frgdNeovim.ui.noice = with types; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether or not to enable the Noice UI plugin.";
    };
  };

  config = mkIf cfg.enable {
    extraPlugins = with pkgs.vimPlugins; [ nui-nvim ];
    plugins.noice.enable = true;
    plugins.noice.settings = {
      presets = {
        bottom_search = true;
      };

      views = {
        cmdline_popup = {
          position = {
            row = "15%";
          };
          # size = {
          #   width = 60;
          #   height = "auto";
          # };
        };
      };
    };
    # (keep your settings block here, unchanged)
  };
}
