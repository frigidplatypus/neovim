{
  plugins.auto-session = {
    enable = true;

    settings = {
      enabled = true;
      createEnabled = true;
      use_git_branch = true;
      auto_restore = true;
      auto_save = true;
      bypass_save_filetypes = [
        "dashboard"
        "nvim-tree"
      ];
    };
  };

  keymaps = [
    {
      mode = "n";
      action = "<cmd>Telescope session-lens<cr>";
      key = "<leader>fs";
      options = {
        desc = "Find Session";
      };
    }
  ];
}
