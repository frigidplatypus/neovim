{ pkgs, ... }:
{
  vimAlias = true;

  luaLoader.enable = true;

  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  opts = {
    smartindent = true;
    breakindent = true;
    cursorline = true;

    tabstop = 2;
    shiftwidth = 2;

    wrap = true;
    linebreak = true;

    number = true;
    relativenumber = true;

    signcolumn = "yes:1";

    # mouse = "";

    foldcolumn = "0";
    foldlevel = 99;
    foldlevelstart = 99;
    foldenable = true;

    updatetime = 50;

    swapfile = false;
    backup = false;
    undofile = true;

    ignorecase = true;
    smartcase = true;

    splitbelow = true;
    splitright = true;

    scrolloff = 4;

    laststatus = 3;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>ch";
      action = "<cmd>noh<cr>";
      options = {
        silent = true;
        desc = "Clear highlight";
      };
    }
    {
      mode = "n";
      key = "<leader>cs";
      action = ''<cmd>let @/=""<cr>'';
      options = {
        silent = true;
        desc = "Clear search";
      };
    }
    {
      mode = "n";
      key = "<leader>bd";
      action = "<cmd>:BD<cr>";
      options = {
        silent = true;
        desc = "Delete buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>bn";
      action = "<cmd>:bnext<cr>";
      options = {
        silent = true;
        desc = "Next buffer";
      };
    }
    {
      mode = "n";
      key = "L";
      action = "<cmd>:bnext<cr>";
      options = {
        silent = true;
        desc = "Next buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>bp";
      action = "<cmd>:bprevious<cr>";
      options = {
        silent = true;
        desc = "Previous buffer";
      };
    }
    {
      mode = "n";
      key = "H";
      action = "<cmd>:bprevious<cr>";
      options = {
        silent = true;
        desc = "Previous buffer";
      };
    }
    {
      mode = "t";
      key = "<esc><esc>";
      action = ''<C-\><C-n>'';
      options = {
        silent = true;
        desc = "Exit terminal mode";
      };
    }
  ];
}
