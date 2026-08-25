{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.frgdNeovim.productivity.obsidian;
in
{
  options.frgdNeovim.productivity.obsidian = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Obsidian.nvim for note-taking and vault management.";
    };

    workspaces = mkOption {
      type = types.listOf (
        types.submodule {
          options = {
            name = mkOption {
              type = types.str;
              description = "Workspace name";
            };
            path = mkOption {
              type = types.str;
              description = "Path to workspace";
            };
          };
        }
      );
      default = [ ];
      description = "List of Obsidian workspaces";
    };

    templatesFolder = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Path to templates folder";
    };

    autoLoad = mkOption {
      type = types.bool;
      default = false;
      description = "Load Obsidian.nvim when Neovim starts.";
    };

    picker = mkOption {
      type = types.enum [
        "telescope.nvim"
        "fzf-lua"
        "mini.pick"
      ];
      default = "telescope.nvim";
      description = "Picker used by Obsidian.nvim search commands.";
    };

  };

  config = mkIf cfg.enable {
    plugins.obsidian = {
      enable = true;
      autoLoad = cfg.autoLoad;
      settings = mkMerge [
        {
          workspaces = cfg.workspaces;
          picker.name = cfg.picker;
        }
        (mkIf (cfg.templatesFolder != null) {
          templates = {
            folder = cfg.templatesFolder;
          };
        })
      ];
    };
  };
}
