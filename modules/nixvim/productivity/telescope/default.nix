{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.frgdNeovim.productivity.telescope;
in
{
  options.frgdNeovim.productivity.telescope.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable telescope productivity plugin.";
  };

  config = mkIf cfg.enable {
    extraPackages = with pkgs; [ ripgrep ];

    plugins.telescope = {
      enable = true;

      keymaps = {
        "<C-p>" = {
          action = "git_files";
          options = {
            desc = "Telescope: Files";
          };
        };
        "<leader><leader>" = {
          action = "git_files";
          options = {
            desc = "Telescope: Files";
          };
        };
        "<leader>ff" = {
          action = "git_files";
          options = {
            desc = "Telescope: Files";
          };
        };
        "<leader>fF" = {
          action = "find_files hidden=true";
          options = {
            desc = "Telescope: Files (hidden)";
          };
        };
        "<leader>fg" = {
          action = "live_grep";
          options = {
            desc = "Telescope: Grep";
          };
        };
        "<leader>fG" = {
          action = "live_grep hidden=true";
          options = {
            desc = "Telescope: Files";
          };
        };
      };

      extensions = {
        fzf-native.enable = true;
        media-files.enable = true;
        ui-select.enable = true;
      };
    };
  };
}
