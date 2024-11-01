{
  plugins.neo-tree = {
    enable = true;
    autoCleanAfterSessionRestore = true;
    closeIfLastWindow = true;

  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>Neotree focus<cr>";
    }
    {
      mode = "n";
      key = "<leader>fe";
      action = "<cmd>Neotree toggle<cr>";
    }
  ];
}
