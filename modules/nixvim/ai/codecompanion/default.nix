{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ai.codecompanion;
in
{
  options.frgdNeovim.ai.codecompanion = with types; {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether or not to enable the codecompanion plugin.";
    };
  };
  config = mkIf cfg.enable {
    plugins."codecompanion".enable = true;
    keymaps = [
      {
        mode = "n";
        key = "<leader>cr";
        action = "<cmd>CodeCompanionActions<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Review selected code with CodeCompanion (action palette)";
        };
      }
      {
        mode = "v";
        key = "<leader>ct";
        action = "<cmd>CodeCompanion /tests<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Generate unit tests for selection";
        };
      }
      {
        mode = "v";
        key = "<leader>cf";
        action = "<cmd>CodeCompanion /fix<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Propose fixes for selected code";
        };
      }
      {
        mode = "v";
        key = "<leader>ce";
        action = "<cmd>CodeCompanion /explain<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Explain code in selection";
        };
      }
      {
        mode = "n";
        key = "<leader>cc";
        action = "<cmd>CodeCompanionChat<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Open CodeCompanion chat";
        };
      }
    ];
  };
}
