{
  lib,
  config,
  helpers,
  ...
}:
with lib;
let
  cfg = config.frgdNeovim.productivity.comment;
in
{
  options.frgdNeovim.productivity.comment.enable = mkOption {
    type = types.bool;
    default = false; # Disabled - replaced by mini.comment
    description = "Enable comment productivity plugin. Replaced by mini.comment.";
  };

  config = mkIf cfg.enable {
    plugins.comment.enable = true;

    # Disable comment.nvim default key mappings to avoid which-key conflicts; centralize mappings instead
    plugins.comment.settings = {
      config = helpers.mkRaw ''
        function()
          local ok, comment = pcall(require, "Comment")
          if not ok then return end
          comment.setup({ mappings = { basic = false, extra = false } })
        end
      '';
    };
  };
}
