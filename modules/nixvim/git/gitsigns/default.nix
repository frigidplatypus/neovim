{
  lib,
  helpers,
  config,
  ...
}:
with lib;
let
  cfg = config.frgdNeovim.git.gitsigns;
in
{
  options.frgdNeovim.git.gitsigns.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable gitsigns git plugin.";
  };

  config = mkIf cfg.enable {
    plugins.gitsigns = {
      enable = true;
      settings = {
        current_line_blame = true;
        trouble = config.plugins.trouble.enable;
        signs = {
          add.text = "+";
          change.text = "~";
          delete.text = "-";
          topdelete.text = "-";
          changedelete.text = "~";
          untracked.text = "\u2506";
        };
        on_attach = helpers.mkRaw ''
                    function(bufnr)
                      -- Intentionally empty: only use gitsigns' visual indicators (signs/blame).
                      -- No buffer-local keymaps or which-key registrations are created here.
                    end
        '';
      };
    };
  };
}
