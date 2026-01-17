{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.core.treesitter;
in
{
  options.frgdNeovim.core.treesitter = with types; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether or not to enable the Treesitter plugin.";
    };
    highlight = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable Treesitter syntax highlighting.";
      };
      additionalVimRegexHighlighting = mkOption {
        type = types.bool;
        default = true;
        description = "Enable additional Vim regex highlighting.";
      };
    };
  };

  config = mkIf cfg.enable {
    plugins.treesitter = {
      enable = true;
      settings = {
        indent.enable = true;
        highlight = {
          enable = cfg.highlight.enable;
          additional_vim_regex_highlighting = cfg.highlight.additionalVimRegexHighlighting;
        };
      };
      folding = {
        enable = true;
      };
      nixvimInjections = true;
    };
    keymaps = [
      {
        mode = "n";
        action = "<cmd>Inspect<cr>";
        key = "gH";
        options = {
          desc = "Treesitter: Show captures";
          silent = true;
          noremap = true;
        };
      }
      {
        mode = [
          "n"
          "v"
        ];
        action = "<cmd>InspectTree<cr>";
        key = "<leader>tP";
        options = {
          desc = "Treesitter: Show tree";
          silent = true;
          noremap = true;
        };
      }
    ];
  };
}
