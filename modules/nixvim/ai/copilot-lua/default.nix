{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ai."copilot-lua";
in
{
  options.frgdNeovim.ai."copilot-lua" = with types; {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether or not to enable the copilot-lua plugin.";
    };
  };
  config = mkIf cfg.enable {
    plugins."copilot-lua" = {
      enable = true;
      settings = {
        panel = {
          enabled = false;
          autoRefresh = true;
          keymap = {
            accept = "<cr>";
            refresh = "gr";
            open = "<C-CR>";
          };
          layout = {
            position = "right";
          };
        };
        suggestion = {
          enabled = false;
          autoTrigger = true;
          debounce = 75;
          keymap = {
            accept = "<C-l>";
            acceptWord = false;
            acceptLine = false;
            next = "<C-]>";
            prev = "<C-[>";
            dismiss = "<C-c>";
          };
        };
        filetypes = {
          yaml = false;
          markdown = false;
          help = false;
          gitcommit = false;
          gitrebase = false;
          hgcommit = false;
          svn = false;
          cvs = false;
          "." = false;
          "*" = true;
        };
      };
    };
  };
}
