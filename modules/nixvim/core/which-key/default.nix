{
  config,
  lib,
  helpers,
  ...
}:
with lib;
let
  cfg = config.frgdNeovim.core."which-key";
in
{
  options.frgdNeovim.core."which-key" = with types; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether or not to enable the which-key plugin.";
    };
  };

  config = mkIf cfg.enable {
    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        action = "<cmd>WhichKey<cr>";
        key = "<leader>?";
        options = {
          desc = "Show available keys";
          silent = true;
          noremap = true;
        };
      }
    ];
    plugins."which-key".enable = true;

    # Centralized which-key group registrations to avoid duplicate/overwriting labels
    plugins."which-key".settings = {
      config = helpers.mkRaw ''
        function()
          local ok, wk = pcall(require, "which-key")
          if not ok then return end
          wk.register({
            ["gc"] = { name = "Comment" },
            ["gb"] = { name = "Comment Block" },
            ["gr"] = { name = "LSP / References" },
            ["ys"] = { name = "Surround" },
            ["yS"] = { name = "Surround (line)" },
            ["yow"] = { name = "Wrapping" },
          }, { mode = "n" })
        end
      '';
    };
  };
}
