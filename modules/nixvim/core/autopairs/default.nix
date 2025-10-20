{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.core.autopairs;
in
{
  options.frgdNeovim.core.autopairs = with types; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether or not to enable the nvim-autopairs plugin.";
    };
  };

  config = mkIf cfg.enable {
    plugins."nvim-autopairs".enable = true;
    extraConfigLua = ''
      pcall(function()
        local ok, np = pcall(require, 'nvim-autopairs')
        if ok then
          if not (np.__frgd_configured or false) then
            np.setup({})
            np.__frgd_configured = true
          end
        end
      end)
    '';
  };
}
