{
  plugins.copilot-chat = {
    enable = true;

    settings = {
      context = "buffers";
      window = {
        layout = "float";
      };
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>cc";
      action = "<cmd>CopilotChatToggle<cr>";
    }
  ];
}
