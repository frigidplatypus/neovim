{ lib, ... }:
let wrap = lib.moduleEnable; in
wrap "copilot-lua" {
  plugins."copilot-lua" = {
    enable = true;
    settings = {
      panel = {
        enabled = false;
        autoRefresh = true;
        keymap = {
          jumpPrev = "[[";
          jumpNext = "]]";
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
}
