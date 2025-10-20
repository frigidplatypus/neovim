{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.lsp.lspkind;
in
{
  options.frgdNeovim.lsp.lspkind.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable lspkind LSP plugin.";
  };

  config = mkIf cfg.enable {
    plugins.lspkind = {
      enable = true;
      settings.symbol_map = {
        Copilot = "\uf113";
      };
      settings = {
        maxwidth = 50;
        ellipsis_char = "...";
      };
    };
  };
}
