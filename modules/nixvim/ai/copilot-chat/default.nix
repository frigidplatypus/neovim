{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ai."copilot-chat";
in
{
  options.frgdNeovim.ai."copilot-chat" = with types; {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether or not to enable the copilot-chat plugin.";
    };
  };
  config = mkIf cfg.enable {
    plugins."copilot-chat" = {
      enable = true;
      settings = {
        context = "buffers";
        window.layout = "float";
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>cc";
        action = "<cmd>CopilotChatToggle<cr>";
      }
      {
        mode = "v";
        key = "<leader>cc";
        action = "<cmd>CopilotChatToggle<cr>";
      }
    ];
  };
}
