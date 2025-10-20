{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.productivity.yanky;
in
{
  options.frgdNeovim.productivity.yanky.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable yanky productivity plugin.";
  };

  config = mkIf cfg.enable {
    plugins.yanky = {
      enable = true;
      settings = {
        highlight = {
          on_put = true;
          on_yank = true;
          timer = 500;
        };
        picker = {
          telescope = {
            default = "mapping.put('p')";
            i = {
              "<c-g>" = "mapping.put('p')";
              "<c-k>" = "mapping.put('P')";
              "<c-r>" = "mapping.set_register(utils.get_default_register())";
              "<c-x>" = "mapping.delete()";
            };
            n = {
              P = "mapping.put('P')";
              d = "mapping.delete()";
              p = "mapping.put('p')";
              r = "mapping.set_register(utils.get_default_register())";
            };
          };
        };
        on_paste = {
          set_reg = false;
        };
        preview = true;
      };
    };
  };
}
